(********************************************************************
 * COPYRIGHT --  Sidel S.p.a.
 ********************************************************************
 * Library: ETHIP_COM
 * File: ETHIP_COM.fun
 * Author: Andrea.Cortesi
 * Created: August 26, 2015
 ********************************************************************
 * Functions and function blocks of library ETHIP_COM
 ********************************************************************)

FUNCTION_BLOCK ETHIP_COM
	VAR_INPUT
		Enable : BOOL := FALSE; (*Enable Function Block*)
		IP_Address_Partner : STRING[16] := ' '; (*IP Address Partner*)
		Alive_Bit_From_Partner : BOOL := FALSE; (*Alive Bit From Partner*)
		Reset : BOOL := FALSE; (*Reset Button*)
		TimeOut_Value : UINT := 5000; (*(OPTIONAL) TimeOut Value [ms]. Default value if no setting is 5000 [ms]. Min value accepted 3000 [ms]*)
		Config_DataObject : UDINT := 0; (*Pointer to Data Object Configuration*)
	END_VAR
	VAR_OUTPUT
		Error : BOOL := FALSE; (*Error: TimeOut Connnection or Internal Error (ex: Data Object Not correct) or other function error*)
	END_VAR
	VAR
		PING_Partner : IcmpPing := (0);
		ConnectionAttempt : UINT;
		ETHIP_Init : EIPInit := (0);
		ETHIP_Cyclic : EIPCyclic := (0);
		ETHIP_Exit : EIPExit := (0);
		Handle_Init : UDINT := 0;
		Status : UINT := 0;
		Status_Old : UINT := 0;
		Step_Msg_Active : STRING[255] := ' ';
		Step_Msg_Active_Old : STRING[255] := ' ';
		Msg_Error : STRING[255] := ' ';
		Status_String : STRING[255] := ' ';
		Buffer_Status : ARRAY[0..Buffer_Status_MaxLimit] OF STRING[255] := [41(' ')]; (*Buffer Diagnostic for Status Message*)
		Buffer_Status_Index : USINT := 0;
		Timer_StartComDelay : TON := (0);
		Timer_CommTimeOut : TON := (0);
		Error_Internal : BOOL := FALSE;
		Ping_Ok : BOOL := FALSE;
		ComInit : BOOL := FALSE;
		ComStart : BOOL := FALSE;
		ComExit : BOOL := FALSE;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
		zzEdge00002 : BOOL;
		zzEdge00003 : BOOL;
	END_VAR
END_FUNCTION_BLOCK
