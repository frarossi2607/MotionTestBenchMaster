PROGRAM _CYCLIC
(***** FUBs cyclic call *****)
	fbMpAlarmXListUI_Main();

	(* Hmi management *)
	tonUpdateHmiUi.PT	:= t#10s;
	tonUpdateHmiUi.IN	:= NOT xUpdateUi;
	tonUpdateHmiUi();
	
	stMainUIConnect.AcknowledgeAll	:= MC_InputOutput.Network.Machine.Commands.AlarmReset;
	
	IF tonUpdateHmiUi.Q THEN
		xUpdateUi	:= TRUE;
	END_IF
	
	IF xUpdateUi THEN
		IF strlen(ADR(stMainUIConnect.AlarmList.Message[uiStringCounter]))> 0 THEN
			strcpy(ADR(HMI_MC_AlarmList[uiStringCounter]),ADR(stMainUIConnect.AlarmList.Message[uiStringCounter]));	
		ELSIF strlen(ADR(stMainUIConnect.AlarmList.Name[uiStringCounter]))> 0 THEN
			strcpy(ADR(HMI_MC_AlarmList[uiStringCounter]),ADR(stMainUIConnect.AlarmList.Name[uiStringCounter]));
		ELSE
			HMI_MC_AlarmList[uiStringCounter]:= '';
		END_IF
	
		uiStringCounter := (uiStringCounter + 1) MOD 10;
		
		IF uiStringCounter = 0 THEN
			xUpdateUi	:= FALSE;
		END_IF
	ELSE
		uiStringCounter	:= 0;
	END_IF
END_PROGRAM
