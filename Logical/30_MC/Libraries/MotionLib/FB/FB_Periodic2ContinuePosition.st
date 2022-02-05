FUNCTION_BLOCK FB_Periodic2ContinuePosition
	IF NOT i_xEnable THEN
		xActive 		:= FALSE;
		diOldInPosition := 0;
		q_diPosition	:= 0;
		RETURN;
	ELSIF NOT xActive THEN
		xActive 		:= TRUE;
		q_diPosition	:= i_diInPosition;
		diOldInPosition := i_diInPosition;
	ELSE
		(* Continue DINT position calculation *)
		IF ABS(i_diInPosition - diOldInPosition) < UDINT_TO_DINT(i_udiPeriod / 2) THEN
			q_diPosition		:= q_diPosition + (i_diInPosition - diOldInPosition);
		ELSIF i_diInPosition < diOldInPosition THEN
			q_diPosition		:= q_diPosition + i_udiPeriod + (i_diInPosition - diOldInPosition);
		ELSE
			q_diPosition		:= q_diPosition - i_udiPeriod + (i_diInPosition - diOldInPosition);
		END_IF
		diOldInPosition 	:= i_diInPosition;
	END_IF
END_FUNCTION_BLOCK
