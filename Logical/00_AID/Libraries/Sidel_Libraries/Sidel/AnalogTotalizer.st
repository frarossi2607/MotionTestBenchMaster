FUNCTION_BLOCK AnalogTotalizer
	RTInfo(enable := TRUE);
	
	CASE IN_ConfigType OF
		0:
			VAR_AuxPulse := IN_PulseWeight * BOOL_TO_REAL(EDGEPOS(IN_Pulse));
		1:
			VAR_AuxPulse := IN_AnalogPV * UDINT_TO_REAL(RTInfo.cycle_time) /1000000;
		2:
			VAR_AuxPulse := IN_AnalogPV * UDINT_TO_REAL(RTInfo.cycle_time) /1000000 / 60;
		3:
			VAR_AuxPulse := IN_AnalogPV * UDINT_TO_REAL(RTInfo.cycle_time) /1000000 / 3600;
	END_CASE
	
	OUT_TotalCounter := VAR_AuxPulse + OUT_TotalCounter;
	
	IF IN_Reset THEN
		OUT_TotalCounter := 0.0;
	END_IF
END_FUNCTION_BLOCK