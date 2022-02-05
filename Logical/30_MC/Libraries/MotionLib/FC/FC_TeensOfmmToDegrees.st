FUNCTION FC_TeensOfmmToDegrees
	lrTempStep	:= i_iTeensOfmm * 360.0 / (i_lrMachineStep * 10.0);
	
	IF i_xWithoutModulo THEN
		FC_TeensOfmmToDegrees := lrTempStep;
	ELSIF i_xNegativeResult THEN
		IF lrTempStep >= 0 THEN
			FC_TeensOfmmToDegrees := FC_LongRealReminder(i_lrDividend := lrTempStep, i_lrDivisor:= 360.0, i_lrStart := 0);
		ELSE
			FC_TeensOfmmToDegrees := FC_LongRealReminder(i_lrDividend := lrTempStep, i_lrDivisor := 360.0, i_lrStart := 0) - 360.0;
		END_IF
	ELSE
		FC_TeensOfmmToDegrees := FC_LongRealReminder(i_lrDividend := lrTempStep, i_lrDivisor := 360.0, i_lrStart:= 0);
	END_IF		
END_FUNCTION
