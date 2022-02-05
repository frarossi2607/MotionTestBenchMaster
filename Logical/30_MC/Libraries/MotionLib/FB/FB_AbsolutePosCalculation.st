FUNCTION_BLOCK FB_AbsolutePosCalculation
	IF i_xEnable THEN
		
		IF NOT i_pstAxis.iq_stStatus.q_stMainAxisStatus.q_xInitDone OR i_pstAxis.iq_stStatus.q_stMainAxisStatus.q_xError THEN
			xPositionValid 		:= FALSE;
		ELSIF i_xPositionSensor AND NOT xPositionValid THEN
			lrAbsolutePosition 	:= i_pstAxis.iq_stStatus.q_stMainAxisStatus.q_lrPosition + 360.0 * MAX((i_uiAbsolutePositionOffset - 1), 0);
			xPositionValid 		:= TRUE;
			lrOldPosition 		:= i_pstAxis.iq_stStatus.q_stMainAxisStatus.q_lrPosition;
		ELSE 
			lrIncrement			:= i_pstAxis.iq_stStatus.q_stMainAxisStatus.q_lrPosition - lrOldPosition;
			
			IF lrIncrement < -180.0 THEN
				lrIncrement := lrIncrement + 360.0;
			ELSIF lrIncrement > 180.0 THEN
				lrIncrement := lrIncrement - 360.0;
			END_IF
			
			lrAbsolutePosition	:= lrAbsolutePosition + lrIncrement;
			lrOldPosition		:= i_pstAxis.iq_stStatus.q_stMainAxisStatus.q_lrPosition;
		END_IF
		
		lrAbsolutePosition		:= FC_LongRealReminder(lrAbsolutePosition, 360.0 * i_uiStepsNumber, 0);
		
		q_xPositionValid		:= xPositionValid;
		q_lrAbsolutePosition	:= lrAbsolutePosition;
	END_IF	
END_FUNCTION_BLOCK
