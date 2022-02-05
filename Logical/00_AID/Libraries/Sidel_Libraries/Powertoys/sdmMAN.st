(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: Powertoys
 * File: sdmMAN.st
 * Author: Administrator
 * Created: December 18, 2014
 ********************************************************************
 * Implementation of library Powertoys
 ********************************************************************) 

(* TODO: Add your comment here *)
FUNCTION_BLOCK sdmMAN
	
	IF enable THEN
		
		CASE step OF
			
			0:
				busy		:= TRUE;
				ready		:= FALSE;
				error		:= FALSE;
				errorID		:= ERR_FUB_BUSY;
				
				(* Getting the required operating mode *)
				old_mode	:= mode;
				
				IF old_mode <= 3 THEN
					CASE old_mode OF
						0:
							(* If SDM is off then switch it on *)
							step 		:= 10;
						1:
							(* If SDM is on the switch it off *)
							step 		:= 20;
						2:
							(* Manual handling of the sdm configuration *)
							step 		:= 30;
							
						3:
							(* SYSTEM DUMP 	*)
							step		:= 40;

					END_CASE;
					
					
				ELSE
					error		:= TRUE;
					errorID		:= ERR_NOTIMPLEMENTED;
					errorStep	:= 0;
					step 		:= 200;
				END_IF;
				
				
				
			10:
				(* If SDM is off then switch it on *)
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 0;
				ELSIF (getSDMstatus.enable = FALSE) AND (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					getSDMstatus.enable := TRUE;
					step				:= 11;
				END_IF;
				
				
				
			11:
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step			:= 100;
				ELSIF (getSDMstatus.status = ERR_OK) AND (getSDMstatus.run = cfgSTATUS_SDM_ENABLED) THEN
					sdmStatus 		:= CST_SDM_ACTIVE;
					step			:= 18;
				ELSIF (getSDMstatus.status = ERR_OK) AND (getSDMstatus.run = cfgSTATUS_SDM_DISABLED) THEN
					sdmStatus 		:= CST_SDM_DISABLE;
					step			:= 12;
					writeLogFlag 	:= TRUE;
				ELSIF (getSDMstatus.status <> ERR_OK) AND (getSDMstatus.status <> ERR_FUB_BUSY) THEN
					(* Error occured *)
					error			:= TRUE;
					errorID			:= getSDMstatus.status;
					errorStep		:= 10;
					step 			:= 200;
				END_IF;
			
			12:
				(* Activating the SDM *)
				getSDMstatus.enable		:= FALSE;
				setSDMstatus.enable		:= FALSE;
				
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 100;
				ELSIF (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) AND (setSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					setSDMstatus.enable	:= TRUE;
					setSDMstatus.start	:= cfgOPTION_ENABLE_SDM;
					step				:= 13;
				END_IF;
			
			13:
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step		:= 100;
				ELSIF (setSDMstatus.status = ERR_OK) THEN
					step		:= 14;
				ELSIF (setSDMstatus.status <> ERR_OK) AND (setSDMstatus.status <> ERR_FUB_BUSY) THEN
					(* Error occured *)
					error		:= TRUE;
					errorID		:= setSDMstatus.status;
					errorStep	:= 12;
					step 		:= 200;
				END_IF;
			
			14:
				(* Reading the sdm status *)
				setSDMstatus.enable		:= FALSE;
				
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 100;
				ELSIF (getSDMstatus.enable = FALSE) AND (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					getSDMstatus.enable := TRUE;
					step				:= 11;
				END_IF;
			
			18:
				(* WRITING ENTRY INTO THE LOGGER *)
				IF (writeLogFlag = TRUE) THEN
					
					memset(ADR(errorEntry)		,0,	SIZEOF(errorEntry));
					memset(ADR(errorString)		,0,	SIZEOF(errorString));
					memset(ADR(errorStepString)	,0,	SIZEOF(errorStepString));
				
					errorEntry.errorNum 		:= CST_SDM_ACTIVE;
					errorEntry.logLevel			:= arEVENTLOG_SEVERITY_INFO;
					errorString					:= 'sdmMAN - SDM Active, previous: DISABLED';
					errorEntry.adr_string 		:= ADR(errorString);
					writeError.adrCustomEntry	:= ADR(errorEntry);
					writeError.enable			:= TRUE;
					step 						:= 19;
				ELSE
					step := 19;
				END_IF;
			19:
				(* SDM ACTIVATED  *)
				busy			:= FALSE;
				ready			:= ((writeError.done) AND (writeError.enable)) OR (NOT writeError.enable);
				error			:= FALSE;
				errorID 		:= ERR_OK;
				writeLogFlag 	:= FALSE;
				IF (old_mode <> mode) AND (writeError.done) AND (writeError.enable) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 100;
					writeError.enable	:= FALSE;
				ELSIF (writeError.error AND writeError.enable) THEN
					step := 201;
				ELSIF (old_mode <> mode) AND (NOT writeError.enable) THEN
						(* Operating mode shanged, returning at the beginning *)
						step				:= 100;
						writeError.enable	:= FALSE;
				END_IF;
			

			20:
				(* If SDM is on the switch it off *)
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step		:= 0;
				ELSIF (getSDMstatus.enable = FALSE) AND (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					getSDMstatus.enable := TRUE;
					step		:= 21;
				END_IF;
			
			21:
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step			:= 100;
				ELSIF (getSDMstatus.status = ERR_OK) AND (getSDMstatus.run = cfgSTATUS_SDM_DISABLED) THEN
					sdmStatus 		:= CST_SDM_DISABLE;
					step			:= 28;
				ELSIF (getSDMstatus.status = ERR_OK) AND (getSDMstatus.run = cfgSTATUS_SDM_ENABLED) THEN
					sdmStatus 		:= CST_SDM_ACTIVE;
					step			:= 22;
					writeLogFlag 	:= TRUE;
				ELSIF (getSDMstatus.status <> ERR_OK) AND (getSDMstatus.status <> ERR_FUB_BUSY) THEN
					(* Error occured *)
					error			:= TRUE;
					errorID			:= getSDMstatus.status;
					errorStep		:= 20;
					step 			:= 200;
				END_IF;
			
			22:
				(* Disabling the SDM *)
				getSDMstatus.enable		:= FALSE;
				setSDMstatus.enable		:= FALSE;
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 100;
				ELSIF (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) AND (setSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					setSDMstatus.enable	:= TRUE;
					setSDMstatus.start	:= cfgOPTION_DISABLE_SDM;
					step				:= 23;
				END_IF;
			
			23:
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step		:= 100;
				ELSIF (setSDMstatus.status = ERR_OK) THEN
					step		:= 24;
				ELSIF (setSDMstatus.status <> ERR_OK) AND (setSDMstatus.status <> ERR_FUB_BUSY) THEN
					(* Error occured *)
					error		:= TRUE;
					errorID		:= setSDMstatus.status;
					errorStep	:= 22;
					step 		:= 200;
				END_IF;
			
			24:
				(* Reading the sdm status *)
				setSDMstatus.enable	:= FALSE;
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step		:= 100;
				ELSIF (getSDMstatus.enable = FALSE) AND (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					getSDMstatus.enable := TRUE;
					step		:= 21;
				END_IF;
			
			28:
				(* WRITING ENTRY INTO THE LOGGER *)
				IF (writeLogFlag = TRUE) THEN
					
					memset(ADR(errorEntry)		,0,	SIZEOF(errorEntry));
					memset(ADR(errorString)		,0,	SIZEOF(errorString));
					memset(ADR(errorStepString)	,0,	SIZEOF(errorStepString));
				
					errorEntry.errorNum 		:= CST_SDM_DISABLE;
					errorEntry.logLevel			:= arEVENTLOG_SEVERITY_INFO;
					errorString					:= 'sdmMAN - SDM DISABLED, previous: ACTIVE';
					errorEntry.adr_string 		:= ADR(errorString);
					writeError.adrCustomEntry	:= ADR(errorEntry);
					writeError.enable			:= TRUE;
					step 						:= 29;
				ELSE
					step := 29;
				END_IF;
			
			29:
				(* SDM DISABLED *)
				busy	:= FALSE;
				ready	:= ((writeError.done) AND (writeError.enable)) OR (NOT writeError.enable);
				error	:= FALSE;
				errorID := ERR_OK;
				writeLogFlag := FALSE;
				IF (old_mode <> mode) AND (writeError.done) AND (writeError.enable) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 100;
					writeError.enable	:= FALSE;
				ELSIF (writeError.error AND writeError.enable) THEN
					step := 201;
				ELSIF (old_mode <> mode) AND (NOT writeError.enable) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 100;
					writeError.enable	:= FALSE;
				END_IF;
			
			30:
				(* Manual handling of the sdm configuration *)
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step		:= 0;
				ELSIF (getSDMstatus.enable = FALSE) AND (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					getSDMstatus.enable := TRUE;
					step		:= 31;
				END_IF;
			
			31:
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step		:= 100;
				ELSIF (getSDMstatus.status = ERR_OK) THEN
					sdmStatus 	:= getSDMstatus.run;
					ready 	:= TRUE;
					busy 	:= FALSE;
					error 	:= FALSE;
					IF ((getSDMstatus.run = cfgSTATUS_SDM_DISABLED) AND (reqSDMstatus = cfgOPTION_ENABLE_SDM) OR
						(getSDMstatus.run = cfgSTATUS_SDM_ENABLED) AND (reqSDMstatus = cfgOPTION_DISABLE_SDM)) THEN
						step	:= 32;
					END_IF;
									
				ELSIF (getSDMstatus.status <> ERR_OK) AND (getSDMstatus.status <> ERR_FUB_BUSY) THEN
					(* Error occured *)
					error		:= TRUE;
					errorID		:= getSDMstatus.status;
					errorStep	:= 30;
					step 		:= 200;
				END_IF;
			
			32:
				ready 	:= FALSE;
				busy 	:= TRUE;
				error 	:= FALSE;
				(* Changing the SDM configuration *)
				getSDMstatus.enable		:= FALSE;
				setSDMstatus.enable		:= FALSE;
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 100;
				ELSIF (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) AND (setSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					setSDMstatus.enable	:= TRUE;
					setSDMstatus.start	:= reqSDMstatus;
					step				:= 33;
				END_IF;
			
			33:
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step		:= 100;
				ELSIF (setSDMstatus.status = ERR_OK) THEN
					step		:= 34;
				ELSIF (setSDMstatus.status <> ERR_OK) AND (setSDMstatus.status <> ERR_FUB_BUSY) THEN
					(* Error occured *)
					error		:= TRUE;
					errorID		:= setSDMstatus.status;
					errorStep	:= 32;
					step 		:= 200;
				END_IF;
			
			34:
				(* Reading the sdm status *)
				setSDMstatus.enable	:= FALSE;
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 100;
				ELSIF (getSDMstatus.enable = FALSE) AND (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					getSDMstatus.enable	:= TRUE;
					step				:= 35;
				END_IF;
			
			35:
				IF (getSDMstatus.status = ERR_OK) THEN
					sdmStatus 	:= getSDMstatus.run;
					step	:= 36;
				ELSIF (getSDMstatus.status <> ERR_OK) AND (getSDMstatus.status <> ERR_FUB_BUSY) THEN
				(* Error occured *)
				error		:= TRUE;
				errorID		:= getSDMstatus.status;
				errorStep	:= 34;
				step 		:= 200;
				END_IF;
			
			36:
				(* WRITING ENTRY INTO THE LOGGER *)
				memset(ADR(errorEntry)		,0,	SIZEOF(errorEntry));
				memset(ADR(errorString)		,0,	SIZEOF(errorString));
				memset(ADR(errorStepString)	,0,	SIZEOF(errorStepString));
				
				IF (sdmStatus = cfgSTATUS_SDM_DISABLED) THEN
					errorEntry.errorNum 		:= CST_SDM_DISABLE;
					errorString					:= 'sdmMAN - SDM DISABLED, previous: ACTIVE';
				ELSIF (sdmStatus = cfgSTATUS_SDM_ENABLED) THEN
					errorEntry.errorNum 		:= CST_SDM_ACTIVE;
					errorString					:= 'sdmMAN - SDM Active, previous: DISABLED';
				END_IF;
				
				errorEntry.logLevel			:= arEVENTLOG_SEVERITY_INFO;
				errorEntry.adr_string 		:= ADR(errorString);
				writeError.adrCustomEntry	:= ADR(errorEntry);
				writeError.enable			:= TRUE;
				step 						:= 37;
			
			37:
				(* SDM DISABLED *)

				IF (writeError.done) AND (writeError.enable) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 31;
					writeError.enable	:= FALSE;
				ELSIF (writeError.error AND writeError.enable) THEN
					step := 201;
					writeError.enable	:= FALSE;
				END_IF;
			
			40:
				busy 	:= TRUE;
				error	:= FALSE;
				ready	:= FALSE;
				error	:= FALSE;
				errorID	:= FALSE;
				(* SYSTEM DUMP, getting the SDM status *)
				IF (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					getSDMstatus.enable := TRUE;
					step := 41;
				END_IF;
			
			41:
				(* SYSTEM DUMP, getting the SDM status *)
				IF (getSDMstatus.status = ERR_OK) THEN
					sdmStatus		:= getSDMstatus.run;
					oldSdmStatus	:= getSDMstatus.run;
					step			:= 42;
				ELSIF (getSDMstatus.status <> ERR_OK) AND (getSDMstatus.status <> ERR_FUB_BUSY) THEN
				(* Error occured *)
				error		:= TRUE;
				errorID		:= getSDMstatus.status;
				errorStep	:= 40;
				step 		:= 200;
				END_IF;
			
			42:	
				(* SYSTEM DUMP, getting the SDM status *)
				getSDMstatus.enable := FALSE;
				IF (sdmStatus = cfgSTATUS_SDM_DISABLED) AND (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					setSDMstatus.start	:= cfgOPTION_ENABLE_SDM;
					setSDMstatus.enable	:= TRUE;
					step			:= 43;
				ELSIF (sdmStatus = cfgSTATUS_SDM_ENABLED) AND (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					step			:= 50;
				END_IF;
			
			43:
				(* SYSTEM DUMP, enabling the SDM *)
				IF (setSDMstatus.status = ERR_OK) THEN
					setSDMstatus.enable := FALSE;
					step				:= 44;
				ELSIF (setSDMstatus.status <> ERR_OK) AND (setSDMstatus.status <> ERR_FUB_BUSY) THEN
					(* Error occured *)
					error		:= TRUE;
					errorID		:= setSDMstatus.status;
					errorStep	:= 42;
					step 		:= 200;
				END_IF;
			
			44:
				(* SYSTEM DUMP, getting the SDM status *)
				IF (setSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					getSDMstatus.enable := TRUE;
					step := 45;
				END_IF;
			
			45:
				(* SYSTEM DUMP, getting the SDM status *)
				IF (getSDMstatus.status = ERR_OK) THEN
					sdmStatus 		:= getSDMstatus.run;
					step			:= 46;
				ELSIF (getSDMstatus.status <> ERR_OK) AND (getSDMstatus.status <> ERR_FUB_BUSY) THEN
					(* Error occured *)
					error		:= TRUE;
					errorID		:= getSDMstatus.status;
					errorStep	:= 46;
					step 		:= 200;
				END_IF;
			
			46:
				(* SYSTEM DUMP, getting the SDM status *)
				getSDMstatus.enable := FALSE;
				IF (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					step := 50;
				END_IF;
			
			50:
				(* SYSTEM DUMP, configuring the DUMP parameters *)
				sDump.configuration := sdm_SYSTEMDUMP_DATA;
				sDump.pFile := 0;
				sDump.pParam := ADR('software,hardware,motion,logger,profiler');
				IF (pDumpDevice <> 0) THEN
					sDump.pDevice := pDumpDevice;
					sDump.enable := TRUE;
					step := 51;
				ELSE
					sDump.enable 	:= FALSE;
					error 			:= TRUE;
					errorStep		:= 50;
					errorID 		:= ERR_BUR_ILLIDENT;
					step := 200;
				END_IF;
				
			51:
				(* SYSTEM DUMP *)
				IF (pDumpDevice <> sDump.pDevice) THEN
					sDump.enable 	:= FALSE;
					error 			:= TRUE;
					errorStep		:= 50;
					errorID 		:= ERR_BUR_ILLIDENT;
					step := 200;
				ELSIF (sDump.status = ERR_OK) AND (pDumpDevice = sDump.pDevice) THEN
					(* Dump complete, restoring the SDM status *)
					sDump.enable 	:= FALSE;
					step := 60;
				ELSIF (sDump.status <> ERR_OK) AND (sDump.status <> ERR_FUB_BUSY) AND (pDumpDevice = sDump.pDevice) THEN
					sDump.enable 	:= FALSE;
					error 			:= TRUE;
					errorStep		:= 50;
					errorID 		:= sDump.status;
					step := 200;
				END_IF;
			
			60:
				(* SYSTEM DUMP, reconfiguring the SDM *)
				sDump.enable 	:= FALSE;
				IF (oldSdmStatus <> sdmStatus) THEN
					setSDMstatus.start := oldSdmStatus;
					setSDMstatus.enable	:= TRUE;
					step := 61;
				ELSE	
					step := 70;
				END_IF;
			
			61:
				(* SYSTEM DUMP, reconfiguring the SDM *)
				IF (setSDMstatus.status = ERR_OK) THEN
					setSDMstatus.enable	:= FALSE;
					step := 62;
				ELSIF (setSDMstatus.status <> ERR_OK) AND (setSDMstatus.status <> ERR_FUB_BUSY) THEN
					error 			:= TRUE;
					errorStep		:= 60;
					errorID 		:= setSDMstatus.status;
					step := 200;
				END_IF;
			
			62:
				(* SYSTEM DUMP, reconfiguring the SDM *)
				IF (setSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					getSDMstatus.enable := TRUE;
					step := 63;
				END_IF;
			
			63:
				(* SYSTEM DUMP, reconfiguring the SDM *)
				IF (getSDMstatus.status = ERR_OK) THEN
					sdmStatus := getSDMstatus.run;
					getSDMstatus.enable := FALSE;
					step := 60;
				ELSIF (getSDMstatus.status <> ERR_OK) AND (getSDMstatus.status <> ERR_FUB_BUSY) THEN
					error 			:= TRUE;
					errorStep		:= 62;
					errorID 		:= getSDMstatus.status;
					step := 200;
				END_IF;
			
			70:
				(* SYSTEM DUMP, writing to the logger *)
				memset(ADR(errorEntry)		,0,	SIZEOF(errorEntry));
				memset(ADR(errorString)		,0,	SIZEOF(errorString));
				memset(ADR(errorStepString)	,0,	SIZEOF(errorStepString));
				
				errorEntry.errorNum 		:= CST_SDM_DUMP_DONE;
				errorEntry.logLevel			:= arEVENTLOG_SEVERITY_INFO;
				errorString					:= 'sdmMAN - System Dump Created';
				errorEntry.adr_string 		:= ADR(errorString);
				writeError.adrCustomEntry	:= ADR(errorEntry);
				writeError.enable			:= TRUE;
				step 						:= 71;
			
			71:
			(* SYSTEM DUMP, writing to the logger *)
				IF writeError.done THEN
					writeError.enable 	:= FALSE;
					step 				:= 79;
				ELSIF	writeError.error THEN
					writeError.enable 	:= FALSE;
					internalError 		:= TRUE;
					step 				:= 202;
				END_IF;
				
			79:
				(* SYSTEM DUMP, completed *)
				busy := FALSE;
				ready := TRUE;
				error := FALSE;
				errorID := ERR_OK;
				IF (old_mode <> mode) THEN
					(* Operating mode shanged, returning at the beginning *)
					step				:= 100;
				END_IF;
				
			
			
			100:
				(* Disabling used function blocks *)
				getSDMstatus.enable := FALSE;
				setSDMstatus.enable	:= FALSE;
				IF (getSDMstatus.status = ERR_FUB_ENABLE_FALSE) AND (setSDMstatus.status = ERR_FUB_ENABLE_FALSE) THEN
					step := 0;
				END_IF;
			
			200:
				(* Error state, disabling all the used function  blocks and writing the error into the logger *)
				getSDMstatus.enable			:= FALSE;
				setSDMstatus.enable			:= FALSE;
				
				memset(ADR(errorEntry)		,0,	SIZEOF(errorEntry));
				memset(ADR(errorString)		,0,	SIZEOF(errorString));
				memset(ADR(errorStepString)	,0,	SIZEOF(errorStepString));
				
				errorEntry.errorNum 		:= errorID;
				errorEntry.logLevel			:= arEVENTLOG_SEVERITY_WARNING;
				errorString					:= 'sdmMAN - Error step: ';
				itoa(USINT_TO_DINT(errorStep),	ADR(errorStepString));
				strcat(ADR(errorString)		, 	ADR(errorStepString));
				errorEntry.adr_string 		:= ADR(errorString);
				writeError.adrCustomEntry	:= ADR(errorEntry);
				writeError.enable			:= TRUE;
				step 						:= 201;
				
			201:
				getSDMstatus.enable			:= FALSE;
				setSDMstatus.enable			:= FALSE;
				
				IF writeError.done THEN
					writeError.enable 	:= FALSE;
					step 				:= 202;
				ELSIF	writeError.error THEN
					writeError.enable 	:= FALSE;
					internalError 		:= TRUE;
					step 				:= 202;
				END_IF;
				
			202:
				(* Waiting to disable the function block *)
				
		END_CASE;
		
	ELSE
		
		(* Function block disabled *)
		busy				:= FALSE;
		ready				:= FALSE;
		error				:= TRUE;
		errorID				:= ERR_FUB_ENABLE_FALSE;
		internalError 		:= FALSE;
		writeLogFlag 		:= FALSE;
		errorStep			:= 0;
		step				:= 0;
		sdmStatus			:= 0;
		oldSdmStatus		:= 0;
		(* Disabling used function blocks *)
		getSDMstatus.enable	:= FALSE;
		setSDMstatus.enable	:= FALSE;
		writeError.enable	:= FALSE;
		sDump.enable		:= FALSE;
		
	END_IF;
	
	getSDMstatus();
	setSDMstatus();
	writeError();
	sDump();
END_FUNCTION_BLOCK