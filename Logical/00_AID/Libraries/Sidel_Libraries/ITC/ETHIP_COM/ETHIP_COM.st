(************************************************************************************************************************)
(* COPYRIGHT -- Sidel S.p.a.                                                                                            *)
(************************************************************************************************************************)
(* Library:				ETHIP_COM																						*)
(* Author:				Andrea.Cortesi																					*)
(* Site:				Sidel - Parma - Product Care IO																	*)
(* Created:				August 26, 2015																					*)
(* Description:			This Library manage a communication based on ethernet IP Protocol between plc B&R configurated	*)
(*						like a SLAVE and another plc configurated like a MASTER. Connection is openinig only if partner	*)
(*						give positive response at comand ping. In case of timeout connection (5000 ms is default value)	*)
(*						the library close connection, try again to ping partner and if there is no answer generate fault*)
(*						communication. Fault is generate also if there is an error inside Data Object configuration.	*)
(* Restriction:			Call in Fast Task at 30 ms or less.Only one connection can be activated because plc B&R in SLAVE*)
(*						Plc B&R can not be SLAVE of two MASTER at same time!!! Is not possible open two connections like*)
(*						SLAVE concurrently on the same IFx eth port. However is possible open two connections like SLAVE*)
(*						Sconcurrently on two different eth port (ex:IF2 and IF3) with two different IP address class	*)
(* Important Note:		This library open/close connection (with memory release) also in case of program download made	*)
(*						in Copy Mode or Overload Mode.For correct management of Overload Mode is necessaary call istance*)
(*						of ETHIP library with Enable at FALSE inside Exit Transiction of function block in which ETHIP	*)
(*						library istance is called.																		*)
(*----------------------------------------------------------------------------------------------------------------------*)
(* Version History:		v.4.00.0 Date 2015-09-12  Andrea.Cortesi														*)
(* Version History:		v.4.00.1 Date 2017-08-20  Roberto.Bonato														*)
(*																														*)
(*----------------------------------------------------------------------------------------------------------------------*)
(* Development Tool:	B&R Automation Studio V3.0.90.27 SP09															*)
(* Compiler GCC:		V2.95.3; V4.1.1; V4.1.2																			*)
(*----------------------------------------------------------------------------------------------------------------------*)
(* Dependencies:		AsEthIP,AsICMP,AsString,Runtime,Standard														*)
(************************************************************************************************************************)

FUNCTION_BLOCK ETHIP_COM
   (* PING Partner before Communication Initialisation *)
	IF (Enable AND NOT(Ping_Ok) AND NOT(Error)) THEN
		PING_Partner.enable		:= TRUE;
		PING_Partner.pHost		:= ADR(IP_Address_Partner);
		PING_Partner.timeout	:= 500;
		PING_Partner();
		
		Step_Msg_Active      := 'ETHIP PING';
		Status               := PING_Partner.status;
		ETHIP_COM_Error;	(* Call action ETHIP_COM_Error *)
             
		CASE PING_Partner.status OF
			0:		(* No Error *)
				Ping_Ok	:= TRUE;
				
			32750,	(* No response sent by station within the specified timeout *)
			32751,	(* The specified IP address (SG4: name also) could not be resolved *)
			32752,	(* Resource problem in system. Could not create new sockets *)
			65535:	(* No Error - Function block still operating, continue calling *)
				Ping_Ok	:= FALSE;
			ELSE	(* Error not management *)
				Ping_Ok	:= FALSE;
		END_CASE
	END_IF           
       
	(* ETHIP Communication Initialisation *)
	IF ComInit THEN	(* If the communication initialisation is requested then... *)
		ETHIP_Init.enable	:= TRUE;				(* Enabled *)
		ETHIP_Init.pconfig	:= Config_DataObject;	(* Name of the "communication configuration" data object *)
		ETHIP_Init();								(* Call of the "EIPInit" function *)
		
		Handle_Init			:= ETHIP_Init.handle;	(* The handle returned by the EIPInit Function and is reused by the EIPCyclic AND EIPExit functions *)
             
		Step_Msg_Active		:= 'ETHIP INIT';
		Status				:= ETHIP_Init.status;
		ETHIP_COM_Error;							(* Call action ETHIP_COM_Error *)

		(* ETHIP Status Init *)
		CASE ETHIP_Init.status OF
			0:		(* No Error *)
				ComInit		:= FALSE;		(* Reset the communication init request *)
				ComStart	:= TRUE;		(* Set the communication activation request *)
     
			32051,	(* Out of memory. The library cannot be executed *)
			32052,	(* Configuration data object error *)
			32053,	(* Illegal input parameters connected to the FBK. *)
			32054:	(* The Ethernet interface doesn't exist or returns an error. Check the #OWNINTERFACE entry in the configuration data object.*)
				ComInit		:= FALSE;		(* Reset the communication init request *)
				ComStart	:= FALSE;		(* Reset the communication activation request *)
				ComExit		:= TRUE;		(* Set the communication exit request *)
			
			65534:	(* The FBK was called with enable = 0.*)
			
			65535:	(* No Error - Function block still operating, continue calling *)
	
			ELSE	(* Error not management *)
				ComInit		:= FALSE;		(* Reset the communication init request *)
				ComStart	:= FALSE;		(* Reset the communication activation request *)
				ComExit		:= FALSE;		(* Reset the communication exit request *)
		END_CASE
	END_IF 

	(* ETHIP Communication Cyclic *)
	IF ComStart THEN		(* If communication activation is requested then... *)
		ETHIP_Cyclic.enable	:= TRUE;		(* Enabled *)
		ETHIP_Cyclic.handle	:= Handle_Init;	(* Handle received from the EIPInit function *)
		ETHIP_Cyclic();						(* Call of the "EIPcyclic" function *)
       
		Step_Msg_Active		:= 'ETHIP CYCLIC';
		Status				:= ETHIP_Cyclic.status; 
		ETHIP_COM_Error;					(* Call action ETHIP_COM_Error *)
	END_IF
       
	(* ETHIP Status Cyclic *)
	CASE ETHIP_Cyclic.status OF
		0:		(* No Error *)
       
		32051,	(* Out of memory. The library cannot be executed *)
		32052,	(* Configuration data object error *)
		32053,	(* Illegal input parameters connected to the FBK. *)
		32054:	(* The Ethernet interface doesn't exist or returns an error. Check the #OWNINTERFACE entry in the configuration data object.*)
			ComStart	:= FALSE;		(* Reset the communication activation request *)
			ComExit		:= TRUE;		(* Set the communication exit request *)
             
		65534:	(* The FBK was called with enable = 0.*)
                    
		65535:	(* No Error - Function block still operating, continue calling *)
             
		ELSE	(* Error not management *)
			ComInit		:= FALSE;	(* Reset the Communication init request *)
			ComStart	:= FALSE;	(* Reset the communication activation request *)
			ComExit		:= FALSE;	(* Reset the communication exit request *)
	END_CASE
	
	(* Force ETHIP Communication Exit if Enable Not Active *)
	IF (NOT(Enable) AND (ComStart OR ComInit)) THEN
		ComInit		:= FALSE;	(* Reset the communication init request *)
		ComStart	:= FALSE;	(* Reset the communication activation request *)
		ComExit		:= TRUE;	(* Set the communication exit request *)
	END_IF
       
	(* ETHIP Communication Exit *)
	IF ComExit THEN	(* If communication exit is requested then... *)
		ComInit		:= FALSE;		(* Reset the communication init request *)
		ComStart	:= FALSE;		(* Reset the communication activation request *)
		
		ETHIP_Exit.enable	:= TRUE;		(* Enabled *)
		ETHIP_Exit.handle	:= Handle_Init;	(* Handle received from the EIPInit function *)
		ETHIP_Exit();						(* Call of the "EIPExit" function *)

		Step_Msg_Active		:= 'ETHIP EXIT';
		Status				:= ETHIP_Exit.status; 
		ETHIP_COM_Error;					(* Call action ETHIP_COM_Error *)
	END_IF
	
	(* ETHIP Status Exit *)
	CASE ETHIP_Exit.status OF
		0:		(* No Error *)
		
		32051,	(* Out of memory. The library cannot be executed *)
		32052,	(* Configuration data object error *)
		32053,	(* Illegal input parameters connected to the FBK. *)
		32054:	(* The Ethernet interface doesn't exist or returns an error. Check the #OWNINTERFACE entry in the configuration data object.*)
			ComInit		:= FALSE;	(* Reset the communication init request *)
			ComStart	:= FALSE;	(* Reset the communication activation request *) 
			ComExit		:= FALSE;	(* Reset the communication exit request *)
             
		65534:	(* The FBK was called with enable = 0. *)
		
		65535:	(* No Error - Function block still operating, continue calling *)

		ELSE	(* Error not management *)
			ComInit		:= FALSE;	(* Reset the communication init request *)
			ComStart	:= FALSE;	(* Reset the communication activation request *)
			ComExit		:= FALSE;	(* Reset the communication exit request *)
	END_CASE

	// Check if ETHIP Communication Exit is Ended
	IF (ComExit AND (ETHIP_Exit.status = 0)) THEN
		ComInit		:= FALSE;		(* Reset the communication init request *)
		ComStart	:= FALSE;		(* Reset the communication activation request *) 
		ComExit		:= FALSE;		(* Reset the communication exit request *)
	END_IF

	// Check Presence Status Error in ETHIP Init and ETHIP Cyclic
	IF ((ETHIP_Init.status = 0) OR (ETHIP_Init.status = 65335)) AND ((ETHIP_Cyclic.status = 0) OR (ETHIP_Cyclic.status = 65335)) THEN
		Error_Internal	:= FALSE;	(* Reset Error in ETHIP function *)
	ELSE
		IF Ping_Ok THEN
			Error_Internal	:= TRUE;	(* Set Error in ETHIP function *)
		ELSE
			Error_Internal	:= FALSE;	(* Reset Error in ETHIP function *)
		END_IF
	END_IF

	// Set Communication Exit if Ping Not Ok or Fault Communication
	IF (ComStart AND (EDGEPOS(Error) OR EDGENEG(Ping_Ok))) THEN
		IF ConnectionAttempt > 10 THEN
			ComInit		:= FALSE;		(* Reset the communication init request *)
			ComStart	:= FALSE;		(* Reset the communication activation request *)
			ComExit		:= TRUE;		(* Set the communication exit request *)
			ConnectionAttempt := 0;
		ELSE
			ConnectionAttempt	:= ConnectionAttempt + 1;
			Error := FALSE;
		END_IF
	ELSIF (ComStart AND EDGE(Alive_Bit_From_Partner)) THEN
		ConnectionAttempt := 0;
	END_IF

	// Initializatin Communication
	IF (Enable AND NOT(ComInit) AND NOT(ComStart) AND NOT(ComExit) AND Ping_Ok AND NOT(Error)) THEN
		ComInit		:= TRUE;		(* Set the communication init request *)
		ComStart	:= FALSE;		(* Reset the communication activation request *)
		ComExit		:= FALSE;		(* Reset the communication exit request *)
	END_IF

	// Check TimeOut Value
	IF (TimeOut_Value = 0) THEN
		TimeOut_Value	:= 5000;
	ELSIF (TimeOut_Value < 3000) THEN
		TimeOut_Value	:= 3000;
	END_IF
	
	// Check Alive Bit Receive from Partner
	IF Enable THEN
		Timer_CommTimeOut(
		IN	:= NOT EDGE(Alive_Bit_From_Partner) AND Timer_StartComDelay.Q,
		PT	:= UINT_TO_TIME(TimeOut_Value)
		);
		
		Timer_StartComDelay(
		IN	:= TRUE,
		PT	:= UINT_TO_TIME(TimeOut_Value)
		);
	ELSE
		Timer_CommTimeOut(
		IN	:= FALSE,
		PT	:= UINT_TO_TIME(TimeOut_Value)
		);
		
		Timer_StartComDelay(
		IN	:= FALSE,
		PT	:= UINT_TO_TIME(TimeOut_Value)
		);
	END_IF

	// TimeOut Error Communication
	IF ((NOT(Ping_Ok) AND Timer_CommTimeOut.Q) OR Error_Internal) THEN
		Timer_CommTimeOut.IN	:= FALSE;
		Timer_StartComDelay.IN	:= FALSE;
		Error					:= TRUE;
	END_IF 
             
	// Try again to Ping Partner in case of TimeOut Error Communication
	IF (Ping_Ok AND Timer_CommTimeOut.Q AND NOT(Error)) THEN
		Timer_CommTimeOut.IN	:= FALSE;
		Timer_StartComDelay.IN	:= FALSE;
		Ping_Ok					:= FALSE;
	END_IF
	
	// Re-initial Communication in CASE OF ERROR
	IF Error THEN
		IF Reset THEN
			Timer_CommTimeOut.IN	:= FALSE;
			Timer_StartComDelay.IN	:= FALSE;
			Error					:= FALSE;
			Ping_Ok					:= FALSE;
			
			// Reset Buffer and Status
			Buffer_Status_Index		:= 0;
			Status_Old				:= 0;
			Step_Msg_Active_Old		:= '';
			Status_String			:= '';
			memset(ADR(Buffer_Status), 0, SIZEOF(Buffer_Status));
			
			Step_Msg_Active			:= 'ETHIP RESET';
			Status					:= 55150;	(* Reset Allarm Communication Library *)
			ETHIP_COM_Error;					(* Call action ETHIP_COM_Error *)
		END_IF
	END_IF
	
	// Call timer
	Timer_CommTimeOut();
	Timer_StartComDelay();
END_FUNCTION_BLOCK
