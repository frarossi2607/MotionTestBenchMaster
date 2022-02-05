FUNCTION_BLOCK RCP_Management
	IF NOT VAR_FirstCycle THEN
		IF (memcmp(IN_AdrPLCRecipe, IN_AdrHMIRecipe, IN_SizePLCRecipe) <> 0) OR (memcmp(IN_AdrHMIRecipe, IN_AdrPLCRecipe, IN_SizeHMIRecipe) <> 0) THEN
			OUT_ParameterError := TRUE;
			RETURN;
		ELSE
			VAR_FirstCycle := TRUE;
		END_IF
	END_IF
	
	TMR_tonRCP_WaitStart.IN			:= FALSE;
	TMR_tonRCP_DownloadTimeOut.IN	:= FALSE;
	
	CASE OUT_Step OF
	
		Wait_Download:
			RCP_Manag.RequestedRecipeName	:= IN_RequestedRCP;
			TMR_tonRCP_WaitStart.IN			:= IN_DownloadRequest OR RCP_Manag.Started;
			TMR_tonRCP_WaitStart.PT			:= t#500ms;
			
			IF TMR_tonRCP_WaitStart.Q THEN
				OUT_Step := Download_Request;
			END_IF
		
			IF RCP_Manag.EditOnlineActive THEN
				OUT_Step := Edit_Online;
			END_IF
		
		Download_Request:
			RCP_Manag.RequestedRecipeName 	:= IN_RequestedRCP;
			RCP_Manag.DownloadRequest		:= IN_DownloadRequest;
			
			IF (RCP_Manag.Started AND RCP_Manag.Ended) THEN
				OUT_Step := Copy_To_Internal;
			END_IF
			
			TMR_tonRCP_DownloadTimeOut.IN	:= NOT RCP_Manag.Ended OR (NOT RCP_Manag.Started AND RCP_Manag.Ended);
			TMR_tonRCP_DownloadTimeOut.PT	:= t#10s;
			
			IF TMR_tonRCP_DownloadTimeOut.Q THEN
				OUT_Step := Download_Error;
			END_IF
		
		Copy_To_Internal:
			RCP_Manag.DownloadRequest := FALSE;
			
			IF (memcmp(IN_AdrPLCRecipe,IN_AdrHMIRecipe,IN_SizePLCRecipe) <> 0) THEN 
				memcpy(IN_AdrPLCRecipe,IN_AdrHMIRecipe,IN_SizePLCRecipe);
			END_IF
			
			IF IN_DownloadRequest THEN
				IF (IN_RequestedRCP = RCP_Manag.ActiveRecipeName) THEN	// Check Request Recipe Name
					IF (memcmp(IN_AdrPLCRecipe,IN_AdrHMIRecipe,IN_SizePLCRecipe) = 0) THEN
						OUT_Step := Download_Done;
					END_IF
				END_IF
			ELSE
				OUT_Step := Download_Done;
			END_IF
			
			TMR_tonRCP_DownloadTimeOut.IN := (IN_RequestedRCP <> RCP_Manag.ActiveRecipeName);
			TMR_tonRCP_DownloadTimeOut.PT := t#5s;
			
			IF TMR_tonRCP_DownloadTimeOut.Q THEN
				OUT_Step := Download_Error;
			END_IF	
		
		Download_Done:
			RCP_Manag.Received	:= TRUE;
			OUT_RecipeLoaded	:= TRUE;
			
			IF (NOT RCP_Manag.Ended AND NOT (IN_DownloadRequest OR RCP_Manag.Started)) THEN
				OUT_Step := Clear_Cmd;
			END_IF
			
		Clear_Cmd:
			RCP_Manag.Received := FALSE;
			RCP_Manag.RequestedRecipeName := '';
			OUT_Step := Wait_Download;
		
		Edit_Online:
			IF RCP_Manag.EditOnlineActive THEN
				IF (memcmp(IN_AdrPLCRecipe,IN_AdrHMIRecipe,IN_SizePLCRecipe) <> 0) THEN
					memcpy(IN_AdrPLCRecipe,IN_AdrHMIRecipe,IN_SizePLCRecipe);
				END_IF
			ELSE
				OUT_Step := Clear_Cmd;
			END_IF
		
		Download_Error:
			RCP_Manag.Received := FALSE;
			RCP_Manag.DownloadRequest := FALSE;
			RCP_Manag.Started := FALSE;
			RCP_Manag.Ended := FALSE;
			RCP_Manag.RequestedRecipeName := '';
			
			TMR_tonRCP_WaitRestart.IN := IN_DownloadRequest OR RCP_Manag.Started;
			TMR_tonRCP_WaitRestart.PT := t#3s;
			
			IF TMR_tonRCP_WaitRestart.Q THEN
				OUT_Step := Download_Request;
			END_IF
			
			IF NOT IN_DownloadRequest AND NOT RCP_Manag.Started THEN
				OUT_Step := Wait_Download;
			END_IF
	END_CASE
		
	IF OUT_Step <> VAR_Step_old THEN
		TMR_tonRCP_WaitStart.IN			:= FALSE;
		TMR_tonRCP_DownloadTimeOut.IN	:= FALSE;
		VAR_Step_old := OUT_Step;
	END_IF
	
	TMR_tonRCP_WaitStart();
	TMR_tonRCP_DownloadTimeOut();
END_FUNCTION_BLOCK
