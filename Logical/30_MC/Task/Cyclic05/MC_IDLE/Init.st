PROGRAM _INIT
	(* AlarmX UI Setup *)
	stMainAlarmSetup.AlarmListScrollWindow	:= 0;
	stMainAlarmSetup.AlarmListSize			:= 100;
	
	(* AlarmX UI Connect *)
	stMainUIConnect;
	
	(* Ui Init *)
	fbMpAlarmXListUI_Main.MpLink		:= ADR(gMainAlarmXCoreLink);
	fbMpAlarmXListUI_Main.UISetup		:= stMainAlarmSetup;
	fbMpAlarmXListUI_Main.UIConnect		:= ADR(stMainUIConnect);
	fbMpAlarmXListUI_Main.Enable		:= TRUE;
END_PROGRAM