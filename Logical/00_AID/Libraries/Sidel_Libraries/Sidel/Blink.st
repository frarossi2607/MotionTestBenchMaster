FUNCTION_BLOCK FB_Blinker
	VAR_TimeValue	:= REAL_TO_TIME((1.0 / IN_Freq) * 1000);
	
	TMR_TON_OnDelay(IN:= NOT OUT,	PT:= VAR_TimeValue / 2);
	TMR_TON_OffDelay(IN:= OUT,		PT:= VAR_TimeValue / 2);
	
	IF TMR_TON_OnDelay.Q THEN
		OUT	:= TRUE;
	ELSIF TMR_TON_OffDelay.Q THEN
		OUT	:= FALSE;
	END_IF
END_FUNCTION_BLOCK