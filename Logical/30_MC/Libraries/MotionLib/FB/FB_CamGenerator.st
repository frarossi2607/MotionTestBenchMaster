(* Cam Generator Function Block *)
FUNCTION_BLOCK FB_CamGenerator
	IF i_xEnable AND i_usiNumberOfPulse > 0 THEN
		IF i_usiNumberOfPulse = 1 AND i_rOnPosition <> i_rOffPosition THEN
			rAdvPosition		:= i_rAdvanceTime * i_prAxisVelocity / 1000.0;
			q_xAdvError			:= (ABS(rAdvPosition) >= 360);
			
			i_pxPointerStepAdv	:= ((i_rOnPosition - rAdvPosition) < 0);
			
			rOnPositionA		:= FC_RealReminder(i_rOnPosition - rAdvPosition,	360.0, 0);
			rOffPositionA		:= FC_RealReminder(i_rOffPosition - rAdvPosition,	360.0, 0);
			
			(* CAM A GENERATION *)
			IF(rOnPositionA < rOffPositionA) THEN
				xCamValueA	:= (i_plrAxisPosition >= rOnPositionA) AND (i_plrAxisPosition < rOffPositionA);
			ELSE
				xCamValueA	:= i_plrAxisPosition >= rOnPositionA OR i_plrAxisPosition < rOffPositionA;
			END_IF
			
			IF xCamValueA <> xOldCamValueA THEN
				rTempReal	:= SEL(xCamValueA, rOffPositionA, rOnPositionA);
				rTempReal	:= rTempReal - LREAL_TO_REAL(i_plrAxisPosition);
				IF ABS(rTempReal) > 0.5 AND ABS(rTempReal) < 359.5 THEN
					xOldCamValueA := xCamValueA;
				END_IF
			END_IF
			
			(* CAM B GENERATION *)
			IF i_rOnPositionB <> 0 AND i_rOffPositionB <> 0 THEN
				rOnPositionB		:= FC_RealReminder(i_rOnPositionB - rAdvPosition,	360.0, 0);
				rOffPositionB		:= FC_RealReminder(i_rOffPositionB - rAdvPosition,	360.0, 0);
				IF(rOnPositionB < rOffPositionB) THEN
					xCamValueB	:= (i_plrAxisPosition >= rOnPositionB) AND (i_plrAxisPosition < rOffPositionB);
				ELSE
					xCamValueB	:= i_plrAxisPosition >= rOnPositionB OR i_plrAxisPosition < rOffPositionB;
				END_IF
				
				IF xCamValueB <> xOldCamValueB THEN
					rTempReal	:= SEL(xCamValueB, rOffPositionB, rOnPositionB);
					rTempReal	:= rTempReal - LREAL_TO_REAL(i_plrAxisPosition);
					IF ABS(rTempReal) > 0.5 AND ABS(rTempReal) < 359.5 THEN
						xOldCamValueB	:=	xCamValueB;
					END_IF
				END_IF
				
				(* Debounce *)
				CASE usiStep OF
					0:(* INIT *)
						usiStep := 100;
					
					100:(* WAIT FOR CAM A RAISING EDGE *)
						IF xCamValueA THEN
							i_pxPointerOutput := TRUE;
							usiStep := 110;
						END_IF

					110:(* WAIT FOR CAM B FALLING EDGE *)
						IF NOT xCamValueB THEN
							usiStep := 120;
						END_IF
					
					120:(*  WAIT FOR CAM A FALLING EDGE *)
						IF NOT xCamValueA THEN
							i_pxPointerOutput := FALSE;
							usiStep := 130;
						END_IF
					
					130:(* WAIT FOR CAM B RAISING EDGE *)
						IF xCamValueB THEN
							usiStep := 100;
						END_IF
			
					ELSE
						usiStep := 200;
				END_CASE
			ELSE
				(* Simple cam A generator *)
				i_pxPointerOutput	:= xOldCamValueA;
			END_IF
		ELSIF i_usiNumberOfPulse <= 10 THEN
			i_pxPointerStepAdv	:= FALSE;
			i_pxPointerOutput	:= FC_RealReminder(LREAL_TO_REAL(i_plrAxisPosition), 360.0 / i_usiNumberOfPulse, 0) >= 180.0 / i_usiNumberOfPulse;
		END_IF
	ELSE
		i_pxPointerOutput	:= FALSE;
		q_xAdvError			:= FALSE;
	END_IF
END_FUNCTION_BLOCK

(* Cam Generator Function Block *)
FUNCTION_BLOCK FB_CamGenerator_v2
	IF i_xEnable AND i_usiNumberOfPulse > 0 THEN
		IF i_usiNumberOfPulse = 1 AND i_rOnPosition <> i_rOffPosition THEN
			rPosition			:= DINT_TO_REAL(i_pdiAxisPosition MOD 36000) / 100.0;
			rAdvPosition		:= i_rAdvanceTime * i_prAxisVelocity / 100000.0; //v1.4
			q_xAdvError			:= (ABS(rAdvPosition) >= 360);
			
			i_pxPointerStepAdv	:= ((i_rOnPosition - rAdvPosition) < 0);
			
			rOnPosition		:= FC_RealReminder(i_rOnPosition - rAdvPosition,	360.0, 0);
			rOffPosition	:= FC_RealReminder(i_rOffPosition - rAdvPosition,	360.0, 0);
			
			(* CAM GENERATION *)
			IF(rOnPosition < rOffPosition) THEN
				xCamValue	:= (rPosition >= rOnPosition) AND (rPosition < rOffPosition);
			ELSE
				xCamValue	:= rPosition >= rOnPosition OR rPosition < rOffPosition;
			END_IF
			
			IF xCamValue <> xOldCamValue THEN
				rTempReal	:= SEL(xCamValue, rOffPosition, rOnPosition);
				rTempReal	:= rTempReal - rPosition;
				IF ABS(rTempReal) > 0.5 AND ABS(rTempReal) < 359.5 THEN
					xOldCamValue := xCamValue;
				END_IF
			END_IF
			
			i_pxPointerOutput	:= xOldCamValue;
		ELSIF i_usiNumberOfPulse <= 10 THEN
			i_pxPointerStepAdv	:= FALSE;
			rPosition			:= DINT_TO_REAL(i_pdiAxisPosition MOD 36000) / 100.0;
			i_pxPointerOutput	:= FC_RealReminder(rPosition, 360.0 / i_usiNumberOfPulse, 0) >= 180.0 / i_usiNumberOfPulse;
		END_IF
	ELSE
		i_pxPointerOutput	:= FALSE;
		q_xAdvError			:= FALSE;
	END_IF
END_FUNCTION_BLOCK