FUNCTION_BLOCK FB_Position2Velocity
	fbRTInfo(enable := TRUE);
	adiBuffer[uiCount]	:= i_diPosition;
	IF uiCount > 0 THEN
		arBufferVel[uiCount] := DINT_TO_REAL((i_diPosition - adiBuffer[uiCount - 1])) / (DINT_TO_REAL(fbRTInfo.cycle_time) * 1E-6);
	ELSE
		arBufferVel[uiCount] := DINT_TO_REAL((i_diPosition - adiBuffer[c_usiNSample - 1])) / (DINT_TO_REAL(fbRTInfo.cycle_time) * 1E-6);
	END_IF
	
	uiCount 	:= (uiCount + 1) MOD c_usiNSample;
	rInternal	:= 0;
	
	FOR i := 0 TO c_usiNSample - 1 DO
		rInternal	:= rInternal + arBufferVel[i];
	END_FOR
	
	q_rVelocity := rInternal / c_usiNSample;
END_FUNCTION_BLOCK