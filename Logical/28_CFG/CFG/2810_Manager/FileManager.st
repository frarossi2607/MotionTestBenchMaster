ACTION FileManager:
	CASE StFmState OF
		0:		//Wait command
			FB_MpRecipeCsv.LoadType		:= mpRECIPE_CSV_LOAD_ALL;
			FB_MpRecipeCsv.Load			:= FALSE;
			FB_MpRecipeCsv.Save			:= FALSE;
			FB_MpRecipeCsv.ErrorReset	:= FALSE;
		
			VAR_FmAck.CommandBusy	:= FALSE;
			VAR_FmAck.CommandDone	:= FALSE;
			VAR_FmAck.CommandError	:= FALSE;
		
			IF FB_MpRecipeCsv.Error THEN
				StFmState	:= 999;
			ELSIF VAR_FmCmd.FolderCreate THEN
				StFmState	:= 100;
			ELSIF VAR_FmCmd.Load THEN
				StFmState	:= 200;
			ELSIF VAR_FmCmd.Save THEN
				StFmState	:= 250;
			END_IF
		
		100:	//Create Folder
			VAR_FmAck.CommandBusy	:= NOT(VAR_FmAck.CommandDone OR VAR_FmAck.CommandError);
	
			IF NOT VAR_FmCmd.FolderCreate THEN
				StFmState	:= 0;
			ELSIF VAR_FmAck.CommandBusy THEN
				FB_DirCreate();
				
				IF FB_DirCreate.status = ERR_OK OR FB_DirCreate.status = fiERR_DIR_ALREADY_EXIST THEN
					VAR_FmAck.CommandDone	:= TRUE;
				ELSIF FB_DirCreate.status <> ERR_FUB_BUSY AND FB_DirCreate.status <> ERR_FUB_ENABLE_FALSE THEN
					VAR_FmAck.CommandError	:= TRUE;
					VAR_FmAck.ErrorCode		:= FB_DirCreate.status;
					VAR_FmAck.ErroreState	:= ERR_FOLDER_CREATE;
				END_IF
			END_IF	
				
		200:	//Load
			VAR_FmAck.CommandBusy	:= NOT(VAR_FmAck.CommandDone OR VAR_FmAck.CommandError);
			FB_MpRecipeCsv.Load		:= TRUE;
				
			IF EDGEPOS(FB_MpRecipeCsv.Error) THEN
				VAR_FmAck.CommandError	:= TRUE;
				VAR_FmAck.ErrorCode		:= FB_MpRecipeCsv.Info.Diag.StatusID.Code;
				VAR_FmAck.ErroreState	:= ERR_LOAD;
			ELSIF EDGEPOS(FB_MpRecipeCsv.CommandDone) AND NOT FB_MpRecipeCsv.Error THEN
				VAR_FmAck.CommandDone	:= TRUE;	
			ELSIF NOT VAR_FmCmd.Load AND (NOT FB_MpRecipeCsv.CommandBusy OR FB_MpRecipeCsv.Error) THEN
				StFmState	:= 0;
			END_IF
		
		250:	//Save configuration
			VAR_FmAck.CommandBusy	:= NOT(VAR_FmAck.CommandDone OR VAR_FmAck.CommandError);
			FB_MpRecipeCsv.Save		:= TRUE;
	
				IF EDGEPOS(FB_MpRecipeCsv.Error) THEN
					VAR_FmAck.CommandError	:= TRUE;
					VAR_FmAck.ErrorCode		:= FB_MpRecipeCsv.Info.Diag.StatusID.Code;
					VAR_FmAck.ErroreState	:= ERR_SAVE;
				ELSIF EDGEPOS(FB_MpRecipeCsv.CommandDone) AND NOT FB_MpRecipeCsv.Error THEN
					VAR_FmAck.CommandDone	:= TRUE;	
				ELSIF NOT VAR_FmCmd.Save AND (NOT FB_MpRecipeCsv.CommandBusy OR FB_MpRecipeCsv.Error) THEN
					StFmState	:= 0;
				END_IF
		
		999:	//Error Reset
			FB_MpRecipeCsv.ErrorReset := TRUE;
		
			IF NOT FB_MpRecipeCsv.Error THEN
				StFmState	:= 0;
			END_IF
	
	END_CASE
END_ACTION
