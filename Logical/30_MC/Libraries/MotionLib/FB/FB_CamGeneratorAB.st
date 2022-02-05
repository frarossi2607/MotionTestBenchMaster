(* Cam Generator Function Block *)
FUNCTION_BLOCK FB_CamGeneratorAB
	IF i_xEnable THEN
		IF (i_rOnPositionA <> i_rOffPositionA) AND (i_rOnPositionB <> i_rOffPositionB) THEN
			rAdvPosition		:= i_rAdvanceTime * i_prAxisVelocity / 1000.0;
			q_xAdvError			:= (ABS(rAdvPosition) >= 360);
			
			i_pxPointerStepAdvA	:= ((i_rOnPositionA - rAdvPosition) < 0);
			i_pxPointerStepAdvB	:= ((i_rOnPositionB - rAdvPosition) < 0);
			
			rOnPositionA		:= FC_RealReminder(i_rOnPositionA - rAdvPosition,	360.0, 0);
			rOffPositionA		:= FC_RealReminder(i_rOffPositionA - rAdvPosition,	360.0, 0);
			
			rOnPositionB		:= FC_RealReminder(i_rOnPositionB - rAdvPosition,	360.0, 0);
			rOffPositionB		:= FC_RealReminder(i_rOffPositionB - rAdvPosition,	360.0, 0);
			
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
					usiStep := 10;
				
				10:(* WAIT FIRST CAM RAISING EDGE *)
					IF rOnPositionB < rOffPositionA THEN
						IF xCamValueA THEN
							i_pxPointerOutputA := TRUE;
							usiStep := 100;
						END_IF
					ELSE
						IF xCamValueB THEN
							i_pxPointerOutputB := TRUE;
							usiStep := 200;
						END_IF
					END_IF

				100:(* WAIT CAM B RISE EDGE *)
					IF xCamValueB THEN
						i_pxPointerOutputB := TRUE;
						usiStep := 110;
					END_IF
				
				110:(* WAIT CAM A FALLING EDGE *)
					IF NOT xCamValueA THEN
						i_pxPointerOutputA := FALSE;
						usiStep := 120;
					END_IF
				
				120:(* WAIT FOR CAM B FALLING EDGE *)
					IF NOT xCamValueB THEN
						i_pxPointerOutputB := FALSE;
						usiStep := 10;
					END_IF
					
				200:(* WAIT CAM A RISE EDGE *)
					IF xCamValueA THEN
						i_pxPointerOutputA := TRUE;
						usiStep := 210;
					END_IF
				
				
				210:(* WAIT CAM B FALLING EDGE *)
					IF NOT xCamValueB THEN
						i_pxPointerOutputB := FALSE;
						usiStep := 220;
					END_IF
				
				220:(* WAIT FOR CAM A FALLING EDGE *)
					IF NOT xCamValueA THEN
						i_pxPointerOutputA := FALSE;
						usiStep := 10;
					END_IF
		
				ELSE
					usiStep := 255;
			END_CASE
		END_IF
	ELSE
		i_pxPointerOutputA	:= FALSE;
		i_pxPointerOutputB	:= FALSE;
		q_xAdvError			:= FALSE;
	END_IF
END_FUNCTION_BLOCK

(* Cam Generator Function Block *)
FUNCTION_BLOCK FB_CamGeneratorAB_v2
	IF i_xEnable THEN
		IF (i_rOnPositionA <> i_rOffPositionA) AND (i_rOnPositionB <> i_rOffPositionB) THEN
			rPosition			:= DINT_TO_REAL(i_pdiAxisPosition MOD 36000) / 100.0;
			rAdvPosition		:= i_rAdvanceTime * i_prAxisVelocity / 100000.0; //v1.6
			q_xAdvError			:= (ABS(rAdvPosition) >= 360);
			
			i_pxPointerStepAdvA	:= ((i_rOnPositionA - rAdvPosition) < 0);
			i_pxPointerStepAdvB	:= ((i_rOnPositionB - rAdvPosition) < 0);
			
			rOnPositionA		:= FC_RealReminder(i_rOnPositionA - rAdvPosition,	360.0, 0);
			rOffPositionA		:= FC_RealReminder(i_rOffPositionA - rAdvPosition,	360.0, 0);
			
			rOnPositionB		:= FC_RealReminder(i_rOnPositionB - rAdvPosition,	360.0, 0);
			rOffPositionB		:= FC_RealReminder(i_rOffPositionB - rAdvPosition,	360.0, 0);
			
			(* CAM A GENERATION *)
			IF(rOnPositionA < rOffPositionA) THEN
				xCamValueA	:= (rPosition >= rOnPositionA) AND (rPosition < rOffPositionA);
			ELSE
				xCamValueA	:= rPosition >= rOnPositionA OR rPosition < rOffPositionA;
			END_IF
			
			IF xCamValueA <> xOldCamValueA THEN
				rTempReal	:= SEL(xCamValueA, rOffPositionA, rOnPositionA);
				rTempReal	:= rTempReal - rPosition;
				IF ABS(rTempReal) > 0.5 AND ABS(rTempReal) < 359.5 THEN
					xOldCamValueA := xCamValueA;
				END_IF
			END_IF
			
			(* CAM B GENERATION *)
			IF(rOnPositionB < rOffPositionB) THEN
				xCamValueB	:= (rPosition >= rOnPositionB) AND (rPosition < rOffPositionB);
			ELSE
				xCamValueB	:= rPosition >= rOnPositionB OR rPosition < rOffPositionB;
			END_IF
			
			IF xCamValueB <> xOldCamValueB THEN
				rTempReal	:= SEL(xCamValueB, rOffPositionB, rOnPositionB);
				rTempReal	:= rTempReal - rPosition;
				IF ABS(rTempReal) > 0.5 AND ABS(rTempReal) < 359.5 THEN
					xOldCamValueB	:=	xCamValueB;
				END_IF
			END_IF
			
			(* Debounce *)
			CASE usiStep OF
				0:(* INIT *)
					usiStep := 10;
				
				10:(* WAIT FIRST CAM RAISING EDGE *)
					IF rOnPositionB < rOffPositionA THEN
						IF xCamValueA THEN
							i_pxPointerOutputA := TRUE;
							usiStep := 100;
						END_IF
					ELSE
						IF xCamValueB THEN
							i_pxPointerOutputB := TRUE;
							usiStep := 200;
						END_IF
					END_IF

				100:(* WAIT CAM B RISE EDGE *)
					IF xCamValueB THEN
						i_pxPointerOutputB := TRUE;
						usiStep := 110;
					END_IF
				
				110:(* WAIT CAM A FALLING EDGE *)
					IF NOT xCamValueA THEN
						i_pxPointerOutputA := FALSE;
						usiStep := 120;
					END_IF
				
				120:(* WAIT FOR CAM B FALLING EDGE *)
					IF NOT xCamValueB THEN
						i_pxPointerOutputB := FALSE;
						usiStep := 10;
					END_IF
					
				200:(* WAIT CAM A RISE EDGE *)
					IF xCamValueA THEN
						i_pxPointerOutputA := TRUE;
						usiStep := 210;
					END_IF
				
				
				210:(* WAIT CAM B FALLING EDGE *)
					IF NOT xCamValueB THEN
						i_pxPointerOutputB := FALSE;
						usiStep := 220;
					END_IF
				
				220:(* WAIT FOR CAM A FALLING EDGE *)
					IF NOT xCamValueA THEN
						i_pxPointerOutputA := FALSE;
						usiStep := 10;
					END_IF
		
				ELSE
					usiStep := 255;
			END_CASE
		END_IF
	ELSE
		i_pxPointerOutputA	:= FALSE;
		i_pxPointerOutputB	:= FALSE;
		q_xAdvError			:= FALSE;
	END_IF
END_FUNCTION_BLOCK