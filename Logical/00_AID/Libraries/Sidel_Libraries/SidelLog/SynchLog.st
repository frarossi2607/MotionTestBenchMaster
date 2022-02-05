(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: SidelLog
 * File: SynchLog.st
 * Author: Administrator
 * Created: July 15, 2014
 ********************************************************************
 * Implementation of library SidelLog
 ********************************************************************) 

(* Machine synchronization logger *)
FUNCTION_BLOCK SynchLog

	IF (enable = TRUE) THEN
		
		CASE step OF
			
			0:
											
				errorID 			:=	ERR_FUB_BUSY;
				busy				:=	TRUE;
				error				:=	FALSE;
				
				
				IF (customLogEntry_0.errorID = ERR_FUB_ENABLE_FALSE) THEN
					(* The function block started running *)
					step := 1;
				END_IF;	
			
			1:
				memset(ADR(data),0,SIZEOF(data));
				
				data.adr_string			:= 	ADR(phasingString);
				
				customLogEntry_0.adrCustomEntry	:=	(ADR(data));
				
				rTrig_0.CLK				:=	offsetAcquire;
				customLogEntry_0.enable	:=	FALSE;
								
				IF rTrig_0.Q	=	TRUE THEN
					step					:=	2;
				END_IF;
			
			
			
			
			2:
				customLogEntry_0.enable	:=	TRUE;
			
				data.errorNum	:= LOG_SYNC_AXIS;
				data.logLevel	:= arEVENTLOG_SEVERITY_INFO;
			
				phasingString	:=	'Homing of Axis ';
				strcat(ADR(phasingString),ADR(axisNameHoming));
				strcat(ADR(phasingString), ADR(' DONE , old position '));
				ftoa(positionMmHoming,ADR(phasingAxisPosition));
				strcat(ADR(phasingString),ADR(phasingAxisPosition)); 
				strcat(ADR(phasingString), ADR('mm'));
			
				IF customLogEntry_0.errorID = ERR_OK THEN
					step					:=	10;
					customLogEntry_0.enable	:=	FALSE;
					indexAxis				:=	RAX1;
						
				ELSIF	((customLogEntry_0.errorID <> ERR_FUB_BUSY) AND (customLogEntry_0.errorID <> ERR_OK)AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE)) THEN	
					errorStep	:= 	2;
					errorID		:=	customLogEntry_0.errorID;
					error		:=	TRUE;
					step		:=	200;
				END_IF;
				
			10:
				IF (customLogEntry_0.errorID=ERR_FUB_ENABLE_FALSE) THEN

					step		:=	20;
					indexAxis	:=	RAX1;
					testIndex	:=  RAX1;
				END_IF;
			
			20:
				IF indexAxis <= AXN THEN
				
					IF testBit = TRUE THEN
							
						customLogEntry_0.enable	:=	TRUE;
						data.errorNum	:= LOG_AXIS_POSITION;
						data.logLevel	:= arEVENTLOG_SEVERITY_INFO;
			
						phasingString	:=	'Position of Axis ';
						strcat(ADR(phasingString),ADR(axisName));
						strcat(ADR(phasingString), ADR(' is '));
						ftoa(positionMm,ADR(phasingAxisPosition));
						strcat(ADR(phasingString),ADR(phasingAxisPosition));
						strcat(ADR(phasingString), ADR('mm'));
							
						IF customLogEntry_0.errorID = ERR_OK THEN
						
							customLogEntry_0.enable	:=	FALSE;
							step					:=21;
						ELSIF	((customLogEntry_0.errorID <> ERR_FUB_BUSY) AND (customLogEntry_0.errorID <> ERR_OK)AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE)) THEN	
							errorStep	:= 20;
							errorID		:= customLogEntry_0.errorID;
							error		:= TRUE;
							step		:=	200;
						
						END_IF;
				
					ELSE
						indexAxis	:=	indexAxis+1;
						testIndex	:=	indexAxis; 
					END_IF;
				ELSE
				
					step	:=	1;
										
				END_IF;
			21:
				IF (customLogEntry_0.errorID=ERR_FUB_ENABLE_FALSE) THEN
					step		:=	20;
					indexAxis	:=	indexAxis+1;
					testIndex	:=	indexAxis;
				END_IF;
				
			200:	
				customLogEntry_0.enable	:=	FALSE;
				
		END_CASE;		
				
	ELSE
				
				error					:=	TRUE;
				errorID					:=	ERR_FUB_ENABLE_FALSE;
				customLogEntry_0.enable	:=	FALSE;
				step					:=	0;
				testIndex				:=	0;
				memset(ADR(data),0,SIZEOF(data));
	END_IF;
				
		
	customLogEntry_0();	
	rTrig_0();
	
END_FUNCTION_BLOCK