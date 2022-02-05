FUNCTION_BLOCK CyclicActivation
	VAR_RtInfo(enable:=TRUE);	
	VAR_CycleCounter	:= MAX(1, VAR_CycleCounter + 1);
	OUT_A	:= FALSE;
	OUT_B	:= FALSE;
	
	TMR_TON_CycleA(	IN := VAR_Cycle,
	PT := (IN_CycleTime / 2) - UDINT_TO_TIME(VAR_RtInfo.cycle_time / 1000));

	TMR_TON_CycleB(	IN := NOT VAR_Cycle,
	PT := (IN_CycleTime / 2) - UDINT_TO_TIME(VAR_RtInfo.cycle_time / 1000));

	IF TMR_TON_CycleA.Q THEN
		OUT_A		:= TRUE;
		VAR_Cycle	:= FALSE;
	ELSIF TMR_TON_CycleB.Q THEN
		OUT_B		:= TRUE;
		VAR_Cycle	:= TRUE;
	ELSE
		RETURN;
	END_IF
		
	VAR_CycleTime	:= (UDINT_TO_REAL(VAR_RtInfo.cycle_time) * VAR_CycleCounter) / 1000000.0;
	VAR_CycleCounter 	:= 0.0;
	memset(ADR(TMR_TON_CycleA), 0, SIZEOF(TMR_TON_CycleA));
	memset(ADR(TMR_TON_CycleB), 0, SIZEOF(TMR_TON_CycleB));
END_FUNCTION_BLOCK
