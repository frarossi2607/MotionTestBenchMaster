FUNCTION_BLOCK TP_Reset
	RT_Info(enable := TRUE);
	
	IF EDGEPOS(IN) THEN
		TimeCounter	:= TIME_TO_UDINT(PT) * 1000;	//micros
	END_IF
		
	IF TimeCounter >= RT_Info.cycle_time THEN
		TimeCounter := TimeCounter - (RT_Info.cycle_time);
	ELSE
		TimeCounter := 0;
	END_IF
	
	IF EDGEPOS(RESET) THEN
		TimeCounter := 0;
	END_IF
	
	Q := TimeCounter <> 0;
END_FUNCTION_BLOCK
