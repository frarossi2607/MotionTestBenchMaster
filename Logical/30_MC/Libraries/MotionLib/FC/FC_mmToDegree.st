FUNCTION FC_mmToDegree
	rTempStep	:= i_rPositionMm * 360.0 / LREAL_TO_REAL(i_lrMachineStep);
	
	FC_mmToDegree	:= FC_RealReminder(i_rDividend := rTempStep, i_rDivisor := 360.0, i_rStart := 0);
END_FUNCTION
