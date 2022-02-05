(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: GenUps
 * File: LogSupplyEvents.st
 * Author: gibertinim
 * Created: March 13, 2014
 ********************************************************************
 * Implementation of library GenUps
 ********************************************************************) 

(* Write the power supply events in the specified logger *)
FUNCTION_BLOCK LogSupplyEvents
	
	
		
	IF (enable = TRUE) THEN
		
		CASE step OF
			
			0:
				pUpsIO ACCESS (ADR_UpsIO);
								
				errorID 			:=	ERR_FUB_BUSY;
				busy				:=	TRUE;
				error				:=	FALSE;
				noSupply			:= TRUE;
				batteryLow			:= FALSE;
				batteryAlarm		:= FALSE;
				shutdownRequested	:= FALSE;
				
				IF (customLogEntry_0.errorID = ERR_FUB_ENABLE_FALSE) THEN
					(* The function block started running *)
					step := 1;
				END_IF;		
			
			1:

				memset(ADR(data),0,SIZEOF(data));
				customLogEntry_0.adrCustomEntry	:=	ADR(data);
				memset(ADR(tempString),0,SIZEOF(tempString));
				memset(ADR(tempString2),0,SIZEOF(tempString2));
				
				IF (pUpsIO.shutdownAlarm = TRUE) THEN
					step := 50;
				ELSE
					step := 51;
				END_IF;
				
				
				
			
				
			2:
				(* Waiting for an event *)
				
				IF 		((pUpsIO.batteryAlarm	= TRUE)		AND	(batteryAlarm		= FALSE))	THEN
					step := 10;
				ELSIF	((pUpsIO.batteryAlarm	= FALSE)	AND	(batteryAlarm		= TRUE))	THEN
					step := 11;
				ELSIF	((pUpsIO.batteryLow		= TRUE)		AND	(batteryLow			= FALSE))	THEN
					step := 20;
				ELSIF	((pUpsIO.batteryLow		= FALSE)	AND	(batteryLow			= TRUE))	THEN
					step := 21;
				ELSIF	((pUpsIO.noPowerSupply	= TRUE)		AND (noSupply			= FALSE))	THEN
					step := 30;
				ELSIF	((pUpsIO.noPowerSupply	= FALSE)	AND (noSupply			= TRUE))	THEN
					step := 31;
				ELSIF (pUpsIO.shutdownReq		= TRUE)		AND	(shutdownRequested	= FALSE)	THEN
					step := 40;
				ELSIF(	(pUpsIO.batteryAlarm	= FALSE)	AND	(batteryAlarm		= FALSE)	AND
						(pUpsIO.batteryLow		= FALSE)	AND	(batteryLow			= FALSE)	AND
						(pUpsIO.noPowerSupply	= FALSE)	AND (noSupply			= FALSE)	AND
						(pUpsIO.shutdownReq 	= FALSE)	AND (shutdownRequested	= FALSE))	THEN
					upsStatus := ERR_OK;
				ELSIF (	(pUpsIO.shutdownReq 	= FALSE)	AND (shutdownRequested	= TRUE)) THEN
					shutdownRequested := FALSE;
				END_IF;
			
			10:
				
				customLogEntry_0.enable 		:= 	TRUE;
				
				data.errorNum		:= ERR_UPS_BATTERY_FAULT;
				data.adr_string		:= ADR('UPS BATTERY FAULT');
				data.logLevel		:= arEVENTLOG_SEVERITY_WARNING;
				batteryAlarm		:= TRUE;
				upsStatus			:= ERR_UPS_BATTERY_FAULT;
				(* Waiting until the log is written succesfully *)
				IF (customLogEntry_0.errorID = ERR_OK) THEN
					(* Log entry written succesfully*)
					step 					:= 101;
					customLogEntry_0.enable := 	FALSE;
				ELSIF ((customLogEntry_0.errorID <> ERR_FUB_BUSY) AND (customLogEntry_0.errorID <> ERR_OK)AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE)) THEN
					(* Error occured while saving the logger *)
					errorStep	:= 10;
					errorID		:= customLogEntry_0.errorID;
					error		:= TRUE;
					step		:= 200;
				END_IF;
			
			11:
				(* Battery alarm recovered *)
		
				customLogEntry_0.enable := 	TRUE;
				data.errorNum			:= ERR_UPS_BATTERY_OK;

				data.adr_string	:= ADR('UPS BATTERY FAULT RECOVERED');
				data.logLevel	:= arEVENTLOG_SEVERITY_INFO;
				batteryAlarm	:= FALSE;
				(* Waiting until the log is written succesfully *)
				
				IF (customLogEntry_0.errorID = ERR_OK) THEN
					(* Log entry written succesfully*)
					step 					:= 101;
					customLogEntry_0.enable := FALSE;
				ELSIF ((customLogEntry_0.errorID <> ERR_FUB_BUSY) AND customLogEntry_0.errorID <> ERR_OK)AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE) THEN
					(* Error occured while saving the logger *)
					errorStep	:= 11;
					errorID		:= customLogEntry_0.errorID;
					error		:= TRUE;
					step		:= 200;
				END_IF;
			
			20:

			
				(* Battery low *)
				
				customLogEntry_0.enable 		:= 	TRUE;
				data.errorNum		:= ERR_UPS_BATTERY_LOW;
				data.adr_string		:= ADR('UPS BATTERY LOW');
				data.logLevel		:= arEVENTLOG_SEVERITY_WARNING;
				batteryLow			:= TRUE;
				upsStatus			:= ERR_UPS_BATTERY_LOW;
				(* Waiting until the log is written succesfully *)
				IF (customLogEntry_0.errorID = ERR_OK) THEN
					(* Log entry written succesfully*)
					step 					:= 101;
					customLogEntry_0.enable := FALSE;
				ELSIF ((customLogEntry_0.errorID <> ERR_FUB_BUSY) AND (customLogEntry_0.errorID <> ERR_OK)AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE)) THEN
					(* Error occured while saving the logger *)
					errorStep	:= 20;
					errorID		:= customLogEntry_0.errorID;
					error		:= TRUE;
					step		:= 200;
				END_IF;
			
			
			21:
				(* Battery recharged *)
				
				customLogEntry_0.enable 		:= 	TRUE;
				
				data.errorNum		:= ERR_UPS_BATTERY_CHARGED;
				data.adr_string		:= ADR('UPS BATTERY CHARGED');
				data.logLevel		:= arEVENTLOG_SEVERITY_INFO;
				batteryLow			:= FALSE;
				(* Waiting until the log is written succesfully *)
				
				IF (customLogEntry_0.errorID = ERR_OK) THEN
					(* Log entry written succesfully*)
					step 					:= 2;
					customLogEntry_0.enable := FALSE;
				ELSIF ((customLogEntry_0.errorID <> ERR_FUB_BUSY) AND (customLogEntry_0.errorID <> ERR_OK)AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE)) THEN
					(* Error occured while saving the logger *)
					errorStep	:= 21;
					errorID		:= customLogEntry_0.errorID;
					error		:= TRUE;
					step		:= 200;
				END_IF;
			
			30:
			
				(* Lost Power supply *)
			
				data.errorNum			:= ERR_UPS_NO_SUPPLY;
				data.adr_string			:= ADR('UPS NO POWER SUPPLY');
				data.logLevel			:= arEVENTLOG_SEVERITY_WARNING;
				noSupply				:= TRUE;
				upsStatus				:= ERR_UPS_NO_SUPPLY;
				customLogEntry_0.enable := 	TRUE;
				(* Waiting until the log is written succesfully *)
				IF (customLogEntry_0.errorID = ERR_OK) THEN
					(* Log entry written succesfully*)
					step 					:= 101;
					customLogEntry_0.enable := FALSE;
				ELSIF ((customLogEntry_0.errorID<> ERR_FUB_BUSY) AND (customLogEntry_0.errorID <> ERR_OK)AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE)) THEN
					(* Error occured while saving the logger *)
					errorStep	:= 30;
					errorID		:= customLogEntry_0.errorID;
					error		:= TRUE;
					step		:= 200;
				END_IF;
				
			
			31:
				(* Power supply ok *)
			
				customLogEntry_0.enable 		:= 	TRUE;
				
				data.errorNum		:= ERR_UPS_SUPPLY_BACK;
				data.adr_string		:= ADR('UPS POWER SUPPLY OK');
				data.logLevel		:= arEVENTLOG_SEVERITY_INFO;
				noSupply			:= FALSE;
				(* Waiting until the log is written succesfully *)
				IF (customLogEntry_0.errorID = ERR_OK) THEN
					(* Log entry written succesfully*)
					step 					:= 101;
					customLogEntry_0.enable := FALSE;
				ELSIF ((customLogEntry_0.errorID <> ERR_FUB_BUSY) AND (customLogEntry_0.errorID <> ERR_OK) AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE)) THEN
					(* Error occured while saving the logger *)
					errorStep	:= 31;
					errorID		:= customLogEntry_0.errorID;
					error		:= TRUE;
					step		:= 200;
				END_IF;
			
			
				
			40:
				(* Shutdown request *)
			
				customLogEntry_0.enable 		:= 	TRUE;
				
				data.errorNum		:= ERR_UPS_SHUTDOWN_REQ;
				data.adr_string		:= ADR('UPS SHUTDOWN REQUEST');
				data.logLevel		:= arEVENTLOG_SEVERITY_INFO;
				shutdownRequested	:= TRUE;
				upsStatus			:= ERR_UPS_SHUTDOWN_REQ;
				(* Waiting until the log is written succesfully *)
				IF (customLogEntry_0.errorID = ERR_OK) THEN
					(* Log entry written succesfully*)
					step 					:= 101;
					customLogEntry_0.enable := FALSE;
				ELSIF ((customLogEntry_0.errorID <> ERR_FUB_BUSY) AND (customLogEntry_0.errorID <> ERR_OK) AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE)) THEN
					(* Error occured while saving the logger *)
					errorStep	:= 40;
					errorID		:= customLogEntry_0.errorID;
					error		:= TRUE;
					step		:= 200;
				END_IF;
			
			
			50:
				(* Writing the total power off time to the logger *)
				(* Shutdown request *)
				itoa(pUpsIO.powerOffTime, ADR(tempString));
				tempString2 := 'UPS SHUTDOWN TIME ';
				strcat(ADR(tempString2), ADR(tempString));
				strcat(ADR(tempString2), ADR('s'));
				
				customLogEntry_0.enable 		:= 	TRUE;
				data.errorNum					:= ERR_UPS_SHUTDOWN_TIME;
				data.adr_string					:= ADR(tempString2);
				data.logLevel					:= arEVENTLOG_SEVERITY_INFO;
				shutdownRequested				:= TRUE;
				upsStatus						:= ERR_UPS_SHUTDOWN_REQ;
				
				(* Waiting until the log is written succesfully *)
				IF (customLogEntry_0.errorID = ERR_OK) THEN
					(* Log entry written succesfully*)
					step 					:= 51;
					customLogEntry_0.enable := FALSE;
				ELSIF ((customLogEntry_0.errorID <> ERR_FUB_BUSY) AND (customLogEntry_0.errorID <> ERR_OK) AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE)) THEN
					(* Error occured while saving the logger *)
					errorStep	:= 50;
					errorID		:= customLogEntry_0.errorID;
					error		:= TRUE;
					step		:= 200;
				END_IF;
				
			51:
				
				(* Identifier obtained succesfully *)
				IF (pUpsIO.noPowerSupply = TRUE) THEN
					step := 30;
				ELSE
					step := 31;
				END_IF;
			
			100:			
				(* Waiting until the log is written succesfully *)
				IF (customLogEntry_0.errorID = ERR_OK) THEN
					(* Log entry written succesfully*)
					step := 101;
					
				ELSIF ((customLogEntry_0.errorID <> ERR_FUB_BUSY) AND (customLogEntry_0.errorID <> ERR_OK) AND (customLogEntry_0.errorID <> ERR_FUB_ENABLE_FALSE)) THEN
					(* Error occured while saving the logger *)
					errorStep	:= 100;
					errorID		:= customLogEntry_0.errorID;
					error		:= TRUE;
					step		:= 200;
				END_IF
			
			101:
			(* Disabling the function block *)
				IF (customLogEntry_0.errorID = ERR_FUB_ENABLE_FALSE) THEN
					memset(ADR(data),0,SIZEOF(data));
					step 			:= 2;
				END_IF;
			
			
			200:
			(* Error step *)
				customLogEntry_0.enable	:=	FALSE;
				
		END_CASE;
		
	ELSE
	
		error					:= TRUE;
		errorID					:= ERR_FUB_ENABLE_FALSE;
		customLogEntry_0.enable	:=	FALSE;
		step					:= 0;
		errorStep				:= 0;
		upsStatus				:= ERR_OK;
		noSupply				:= TRUE;
		batteryLow				:= FALSE;
		batteryAlarm			:= FALSE;
		shutdownRequested		:= FALSE;
		busy					:= FALSE;
		memset(ADR(data),0,SIZEOF(data));
	END_IF;

	customLogEntry_0();
END_FUNCTION_BLOCK