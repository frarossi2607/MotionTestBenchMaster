(* From a step signal a periodic signal is created *)
FUNCTION_BLOCK FB_PeriodicPosition
	IF NOT i_xEnable OR i_rPeriod <=0 THEN	
		usiStep				:= 0;
		q_xPositionValid	:= FALSE;
	ELSE
		CASE usiStep OF
			0:
				q_xPositionValid	:= FALSE;
				q_rPeriodicPosition	:= 0;
				rPosition			:= 0;

				IF i_xEnable THEN
					usiStep	:= 10;
				END_IF
				
			10:
				IF EDGEPOS(i_xResetPostion) THEN
					q_xPositionValid	:= TRUE;
					rPosition			:= i_rAxisPosition;
					q_rPeriodicPosition	:= i_rAxisPosition;
					usiStep				:= 20;
				END_IF
			
			20:
				rDeltaPos	:= i_rAxisPosition - rPosition;
				// If the difference between the old axis and the current axis position
				// If greater than 180° it means that we overlapped the period
				IF ABS(rDeltaPos) > 180 THEN
					IF rDeltaPos > 0 THEN
						rDeltaPos	:= rDeltaPos - 360;
					ELSE
						rDeltaPos	:= rDeltaPos + 360;
					END_IF
				END_IF
				
				q_rPeriodicPosition	:= FC_RealReminder(q_rPeriodicPosition + rDeltaPos, i_rPeriod, 0);
				rPosition			:= i_rAxisPosition;
				
				IF i_xResetPostion	THEN
					usiStep	:= 0;
				END_IF
		END_CASE
	END_IF
END_FUNCTION_BLOCK
