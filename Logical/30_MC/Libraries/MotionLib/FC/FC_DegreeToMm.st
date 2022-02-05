FUNCTION FC_DegreeToMm
	rTempStep	:= i_rPositionDegree * LREAL_TO_REAL(i_lrMachineStep) / 360.0;

	IF i_xRemindResult THEN
		FC_DegreeToMm	:= FC_RealReminder(i_rDividend := rTempStep, i_rDivisor := LREAL_TO_REAL(i_lrMachineStep), i_rStart := 0);
	ELSE
		FC_DegreeToMm	:= rTempStep;
	END_IF
END_FUNCTION
