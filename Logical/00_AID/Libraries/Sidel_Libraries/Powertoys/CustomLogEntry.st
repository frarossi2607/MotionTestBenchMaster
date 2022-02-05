(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: Powertoys
 * File: CustomLogEntry.st
 * Author: gibertinim
 * Created: March 27, 2014
 ********************************************************************
 * Implementation of library Powertoys
 ********************************************************************) 

(* Write a custom entry into the specified logger *)
FUNCTION_BLOCK CustomLogEntry
	
	IF enable THEN
		
		pEntry ACCESS adrCustomEntry;
		
		CASE step OF
			
			0:	(*Check if Log exist*)
				LogInfo.Name	:= 'userlog';
				LogInfo.Execute	:= TRUE;
				errorID 		:= ERR_FUB_BUSY;
				busy			:= TRUE;
				error			:= FALSE;
				
				IF (LogInfo.StatusID = arEVENTLOG_ERR_LOGBOOK_NOT_FOUND) THEN
					step := 5;
					LogInfo.Execute	:= FALSE;
				ELSIF (LogInfo.Done AND LogInfo.StatusID = ERR_OK) THEN
					step 			:= 10;
					LogIdent		:= LogInfo.Ident;
					LogInfo.Execute	:= FALSE;
				END_IF
			
			5:	(*Create Log*)
				LogCreate.Name			:= 'userlog';
				LogCreate.Size			:= 4096;	//4096 BYTES
				LogCreate.Persistence	:= arEVENTLOG_PERSISTENCE_PERSIST;
				LogCreate.Execute		:= TRUE;
				errorID 				:= ERR_FUB_BUSY;
				busy					:= TRUE;
				error					:= FALSE;
				
				IF LogCreate.Error THEN
					step 		:= 200;
					error		:= TRUE;
					errorID		:= LogInfo.StatusID;
					errorStep	:= 1;
				ELSIF (LogCreate.Done AND LogInfo.StatusID = ERR_OK) THEN
					step				:= 10;
					LogIdent			:= LogCreate.Ident;
					LogCreate.Execute	:= FALSE;
				END_IF
				
			10:	(* Writing the logger informations  *)
				eventID := ArEventLogMakeEventID(
					Severity := pEntry.logLevel, 
					Facility := 0, 
					ErrorCode := pEntry.errorNum);
				
				LogWrite.EventID		:= eventID;
				LogWrite.Ident			:= LogIdent;
				LogWrite.AddData		:= pEntry.adr_string;
				LogWrite.AddDataSize	:= 80;
				LogWrite.AddDataFormat	:= 1;
				LogWrite.Execute		:= TRUE;
								
				(* Waiting until the log is written succesfully *)
				IF (LogWrite.Done AND LogWrite.StatusID = ERR_OK) THEN
					(* Log entry written succesfully*)
					step := 101;
					LogWrite.Execute := FALSE;
				ELSIF LogWrite.Error THEN
					(* Error occured while saving the logger *)
					errorStep	:= 10;
					errorID		:= LogWrite.StatusID;
					error		:= TRUE;
					step		:= 200;
				END_IF;
					
			101:
				done := TRUE;
				busy := FALSE;
				errorID := ERR_OK;
							
			200:
				(* Error step *)
				LogCreate.Execute	:= FALSE;
				LogWrite.Execute	:= FALSE;
				LogInfo.Execute		:= FALSE;
				done				:= TRUE;
				busy				:= FALSE;
		END_CASE;
		
	ELSE
		error				:= FALSE;
		errorID				:= ERR_FUB_ENABLE_FALSE;
		errorStep			:= 0;
		step	 			:= 0;
		LogCreate.Execute	:= FALSE;
		LogWrite.Execute	:= FALSE;
		LogInfo.Execute		:= FALSE;
		done				:= FALSE;
		busy				:= FALSE;

	END_IF;
	
	LogCreate();
	LogWrite();
	LogInfo();
	
END_FUNCTION_BLOCK