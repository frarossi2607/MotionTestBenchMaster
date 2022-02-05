(********************************************************************
 * COPYRIGHT -- Microsoft
 ********************************************************************
 * Library: Powertoys
 * File: SearchIO.st
 * Author: Paolino
 * Created: April 18, 2014
 ********************************************************************
 * Implementation of library Powertoys
 ********************************************************************) 

(* Function Block to show hardware list component *)
FUNCTION_BLOCK SearchIO
	
	IF (enable	=	TRUE) THEN
		
		CASE step OF
			
			0:
				(* Getting the information from configured and/or inserted hardware modules  *)
				
				FB_DiagCreateInfo.enable	:=	TRUE;
				FB_DiagCreateInfo.infoKind	:=	mode;
					
				errorID 		:=	ERR_FUB_BUSY;
				busy			:=	TRUE;
				error			:=	FALSE;
				
				IF (FB_DiagCreateInfo.status	=	ERR_FUB_BUSY) THEN
					(* The function block started running *)
					step :=	1;
				END_IF;
			
			1:
				IF (FB_DiagCreateInfo.status	=	ERR_OK) THEN
       
					(* Collecting data *)
					ident	     			:=	FB_DiagCreateInfo.ident;
					nrEntries	 			:=	FB_DiagCreateInfo.nrEntries;
            
					(* Disabling the used fub *)
					FB_DiagCreateInfo.enable 	:=	FALSE;
					
					IF (wholeList = TRUE) THEN
						(* Create the whole hw list *)
						step        				:=	10;
					ELSE
						(* Output only the specified index *)
						step						:=	60;
					END_IF;
					
					
					
				ELSIF ((FB_DiagCreateInfo.status	<>	ERR_OK)	AND	(FB_DiagCreateInfo.status	<>	ERR_FUB_BUSY)) THEN
					(* Going to the error state *)
					errorID		:=	FB_DiagCreateInfo.status;
					errorStep	:=	1;
					step		:=	200;
					error		:=	TRUE;
				END_IF	
				
				
			10:
				(* Getting path of inserted hardware modules *)
				pData ACCESS (adrSearchIO + (SIZEOF (pData))*counter);
				IF (counter <= (nrEntries - 1)) THEN
					FB_DiagGetStrInfo.infoCode		:=	asdiagPATH;
					FB_DiagGetStrInfo.index			:=	counter;
					FB_DiagGetStrInfo.ident			:=	ident;
					FB_DiagGetStrInfo.pBuffer		:=	ADR(pData.Path);
					FB_DiagGetStrInfo.bufferLen		:=	SIZEOF (pData.Path) - 1;
					FB_DiagGetStrInfo.enable		:=	TRUE;
					
					//IF (FB_DiagGetStrInfo.status	=	ERR_FUB_BUSY) THEN
						step := 11;
					//END_IF
			
				ELSE
            
					counter						:=	0; 
					FB_DiagGetStrInfo.enable 	:=	FALSE;
					step 						:= 	13; 
       
				END_IF
			
			11:			
				IF (FB_DiagGetStrInfo.status	=	ERR_OK) THEN
       
					counter						:=	counter + 1;
					FB_DiagGetStrInfo.enable 	:=	FALSE;
					step 						:=	12;
           
            
				ELSIF (FB_DiagGetStrInfo.status	<>	ERR_FUB_BUSY)	AND	(FB_DiagGetStrInfo.status	<>	ERR_OK) THEN
					(* Going to the error state *)
					errorID		:=	FB_DiagGetStrInfo.status;
					errorStep	:=	10;
					step		:=	200;
					error		:=	TRUE;
         
				END_IF 
			
			12:
				
				IF (FB_DiagGetStrInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	10;
				END_IF
			
			
			13:
				IF (FB_DiagGetStrInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	20;
					
				END_IF
			
				
			20:
				(*Getting Model Number of inserted hardware modules*)
				pData ACCESS (adrSearchIO + SIZEOF (pData)*counter);
				IF (counter <= (nrEntries -1)) THEN
					FB_DiagGetStrInfo.infoCode	:=	asdiagPLUGGED_MODULE;
					FB_DiagGetStrInfo.index		:=	counter;
					FB_DiagGetStrInfo.ident		:=	ident;
					FB_DiagGetStrInfo.pBuffer	:=	ADR(pData.ModelNumber);
					FB_DiagGetStrInfo.bufferLen	:=	SIZEOF(pData.ModelNumber) - 1;
					FB_DiagGetStrInfo.enable	:=	TRUE;
            
					//IF (FB_DiagGetStrInfo.status	=	ERR_FUB_BUSY) THEN
						step := 21;
					//END_IF
			
				ELSE
            
					counter						:=	0; 
					FB_DiagGetStrInfo.enable 	:=	FALSE;
					step 						:= 	23; 
       
				END_IF
			
			21:			
				IF (FB_DiagGetStrInfo.status	=	ERR_OK) THEN
       
					counter						:=	counter + 1;
					FB_DiagGetStrInfo.enable 	:=	FALSE;
					step 						:=	22;
           
            
				ELSIF (FB_DiagGetStrInfo.status	<>	ERR_FUB_BUSY)	AND	(FB_DiagGetStrInfo.status	<>	ERR_OK) THEN
					(* Going to the error state *)
					errorID		:=	FB_DiagGetStrInfo.status;
					errorStep	:=	20;
					step		:=	200;
					error		:=	TRUE;
         
				END_IF 
			
			22:
				
				IF (FB_DiagGetStrInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	20;
				END_IF
			
			
			23:
				IF (FB_DiagGetStrInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	30;
					
				END_IF	
				
			
			30:
				(*Getting Name of inserted hardware modules*)
				pData ACCESS (adrSearchIO + SIZEOF (pData)*counter);
				IF (counter <= (nrEntries -1)) THEN
					FB_DiagGetStrInfo.infoCode	:=	asdiagHARDWARE_MODULE_NAME;
					FB_DiagGetStrInfo.index		:=	counter;
					FB_DiagGetStrInfo.ident		:=	ident;
					FB_DiagGetStrInfo.pBuffer	:=	ADR(pData.Name);
					FB_DiagGetStrInfo.bufferLen	:=	SIZEOF(pData.Name) - 1;
					FB_DiagGetStrInfo.enable	:=	TRUE;
            
					//IF (FB_DiagGetStrInfo.status	=	ERR_FUB_BUSY) THEN
						step := 31;
					//END_IF
			
				ELSE
            
					counter				:=	0; 
					FB_DiagGetStrInfo.enable 	:=	FALSE;
					step 						:= 	33; 
       
				END_IF
			
			31:			
				IF (FB_DiagGetStrInfo.status	=	ERR_OK) THEN
       
					counter						:=	counter + 1;
					FB_DiagGetStrInfo.enable 	:=	FALSE;
					step 						:=	32;
           
            
				ELSIF (FB_DiagGetStrInfo.status	<>	ERR_FUB_BUSY)	AND	(FB_DiagGetStrInfo.status	<>	ERR_OK) THEN
					(* Going to the error state *)
					errorID		:=	FB_DiagGetStrInfo.status;
					errorStep	:=	30;
					step		:=	200;
					error		:=	TRUE;
         
				END_IF 
			
			32:
				
				IF (FB_DiagGetStrInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	30;
				END_IF
			
			
			33:
				IF (FB_DiagGetStrInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	50;
					
				END_IF	

			
			50:
				(*Getting Serial Number of hardware modules*)
				pData ACCESS (adrSearchIO + SIZEOF (pData)*counter);
				IF (counter <= (nrEntries -1)) THEN
					FB_DiagGetNumInfo.ident		:=	ident;
					FB_DiagGetNumInfo.index		:=	counter;
					FB_DiagGetNumInfo.infoCode	:=	asdiagSERIAL_NUMBER;
					FB_DiagGetNumInfo.enable	:=	TRUE;
            
					//IF (FB_DiagGetNumInfo.status = ERR_FUB_BUSY) THEN
						step := 51;
					//END_IF
					
       
          

				ELSE
            
					counter						:=	0; 
					FB_DiagGetNumInfo.enable	:=	FALSE;
					step						:=	53; 
       
				END_IF
			
						
			51:			
				IF (FB_DiagGetNumInfo.status	=	ERR_OK) THEN
       
					pData.Serial 					:=	FB_DiagGetNumInfo.value;
					counter							:=	counter +1;
					FB_DiagGetNumInfo.enable		:=	FALSE;
					step := 52;
           
            
				ELSIF (FB_DiagGetNumInfo.status	<>	ERR_FUB_BUSY)	AND	(FB_DiagGetNumInfo.status	<>	ERR_OK) THEN
					(* Going to the error state *)
					errorID		:=	FB_DiagGetNumInfo.status;
					errorStep	:=	50;
					step		:=	200;
					error		:=	TRUE;
         
				END_IF 
			
			52:
				
				IF (FB_DiagGetNumInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	50;
				END_IF
			
			
			53:
				IF (FB_DiagGetNumInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	100;
					
				END_IF	
			(**************************************************************************************)
			(***************** Output only the specified stationIndex *****************************)
			(**************************************************************************************)
			60:
				(* Getting path of specified hw module *)
				pData ACCESS (adrSearchIO);
				FB_DiagGetStrInfo.infoCode		:=	asdiagPATH;
				FB_DiagGetStrInfo.index			:=	stationIndex;
				FB_DiagGetStrInfo.ident			:=	ident;
				FB_DiagGetStrInfo.pBuffer		:=	ADR(pData.Path);
				FB_DiagGetStrInfo.bufferLen		:=	SIZEOF (pData.Path) - 1;
				FB_DiagGetStrInfo.enable		:=	TRUE;
					
				step := 61;
				 
			61:			
				IF (FB_DiagGetStrInfo.status	=	ERR_OK) THEN
       
					FB_DiagGetStrInfo.enable 	:=	FALSE;
					step 						:=	62;
           
            
				ELSIF (FB_DiagGetStrInfo.status	<>	ERR_FUB_BUSY)	AND	(FB_DiagGetStrInfo.status	<>	ERR_OK) THEN
					(* Going to the error state *)
					errorID		:=	FB_DiagGetStrInfo.status;
					errorStep	:=	60;
					step		:=	200;
					error		:=	TRUE;
         
				END_IF 
			
			62:
				IF (FB_DiagGetStrInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	63;
					
				END_IF
			
			63:
				(*Getting Model Number of inserted hardware modules*)
				FB_DiagGetStrInfo.infoCode	:=	asdiagPLUGGED_MODULE;
				FB_DiagGetStrInfo.index		:=	stationIndex;
				FB_DiagGetStrInfo.ident		:=	ident;
				FB_DiagGetStrInfo.pBuffer	:=	ADR(pData.ModelNumber);
				FB_DiagGetStrInfo.bufferLen	:=	SIZEOF(pData.ModelNumber) - 1;
				FB_DiagGetStrInfo.enable	:=	TRUE;
            
				step := 64;
								
				
			
			64:			
				IF (FB_DiagGetStrInfo.status	=	ERR_OK) THEN
       
					FB_DiagGetStrInfo.enable 	:=	FALSE;
					step 						:=	65;
           
            
				ELSIF (FB_DiagGetStrInfo.status	<>	ERR_FUB_BUSY)	AND	(FB_DiagGetStrInfo.status	<>	ERR_OK) THEN
					(* Going to the error state *)
					errorID		:=	FB_DiagGetStrInfo.status;
					errorStep	:=	63;
					step		:=	200;
					error		:=	TRUE;
         
				END_IF 
			
			65:
				
				IF (FB_DiagGetStrInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	66;
				END_IF
			
			
			66:
				(*Getting Name of inserted hardware modules*)
				
				FB_DiagGetStrInfo.infoCode	:=	asdiagHARDWARE_MODULE_NAME;
				FB_DiagGetStrInfo.index		:=	stationIndex;
				FB_DiagGetStrInfo.ident		:=	ident;
				FB_DiagGetStrInfo.pBuffer	:=	ADR(pData.Name);
				FB_DiagGetStrInfo.bufferLen	:=	SIZEOF(pData.Name) - 1;
				FB_DiagGetStrInfo.enable	:=	TRUE;
            
				step := 67;
							
			67:			
				IF (FB_DiagGetStrInfo.status	=	ERR_OK) THEN
       
					
					FB_DiagGetStrInfo.enable 	:=	FALSE;
					step 						:=	68;
           
            
				ELSIF (FB_DiagGetStrInfo.status	<>	ERR_FUB_BUSY)	AND	(FB_DiagGetStrInfo.status	<>	ERR_OK) THEN
					(* Going to the error state *)
					errorID		:=	FB_DiagGetStrInfo.status;
					errorStep	:=	66;
					step		:=	200;
					error		:=	TRUE;
         
				END_IF 
			
		
			68:
				IF (FB_DiagGetStrInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	69;
					
				END_IF
			
			69:
				(*Getting Serial Number of hardware modules*)
				FB_DiagGetNumInfo.ident		:=	ident;
				FB_DiagGetNumInfo.index		:=	stationIndex;
				FB_DiagGetNumInfo.infoCode	:=	asdiagSERIAL_NUMBER;
				FB_DiagGetNumInfo.enable	:=	TRUE;
            
				step := 70;
										
			70:			
				IF (FB_DiagGetNumInfo.status	=	ERR_OK) THEN
       
					pData.Serial 					:=	FB_DiagGetNumInfo.value;
					FB_DiagGetNumInfo.enable		:=	FALSE;
					step := 71;
           
            
				ELSIF (FB_DiagGetNumInfo.status	<>	ERR_FUB_BUSY)	AND	(FB_DiagGetNumInfo.status	<>	ERR_OK) THEN
					(* Going to the error state *)
					errorID		:=	FB_DiagGetNumInfo.status;
					errorStep	:=	69;
					step		:=	200;
					error		:=	TRUE;
         
				END_IF 
			
			71:
				IF (FB_DiagGetNumInfo.status	=	ERR_FUB_ENABLE_FALSE) THEN
       
					step	:=	100;
					
				END_IF	
			
			
			100:
				done 			:= TRUE;
				busy 			:= FALSE;
				errorID 		:= ERR_OK;
				
				FB_DiagCreateInfo.enable		:= FALSE;
				FB_DiagGetStrInfo.enable		:= FALSE;
				FB_DiagGetNumInfo.enable		:= FALSE;
							
			
			200:
				(* Error step *)
//				FB_DiagCreateInfo.enable		:= FALSE;
//				FB_DiagGetStrInfo.enable		:= FALSE;
//				FB_DiagGetNumInfo.enable		:= FALSE;
								
				done				:= TRUE;
				busy				:= FALSE;
				error 				:= TRUE;

		END_CASE;
		

		
	ELSE
		(* Function block not enabled *)
		error				:= TRUE;
		errorID				:= ERR_FUB_ENABLE_FALSE;
		
		(* Resetting  the internal variables *)
		errorStep			:= 0;
		step	 			:= 0;
		ident 				:= 0;
		counter 			:= 0;
		nrEntries 			:= 0;
		
		
		done				:= FALSE;
		busy				:= FALSE;
		
		(* Disabling the block *)
		FB_DiagCreateInfo.enable		:= FALSE;
		FB_DiagGetStrInfo.enable		:= FALSE;
		FB_DiagGetNumInfo.enable		:= FALSE;
		

	END_IF;

	(*Function Block Call*)
	FB_DiagCreateInfo();
	FB_DiagGetStrInfo();
	FB_DiagGetNumInfo();
	

END_FUNCTION_BLOCK