(* Get the acceleration (deceleration) value from time and jerk *)
FUNCTION FC_GetAccFromTimeAndJerk
	IF i_rTime = 0 THEN
		rTime := 20;
	ELSE
		rTime := i_rTime;
	END_IF

	IF i_rVelocity <= 0 THEN
		FC_GetAccFromTimeAndJerk :=	500;
		RETURN;
	END_IF
	
	IF i_rJerk <= 0 THEN
		FC_GetAccFromTimeAndJerk :=	i_rVelocity	/ rTime;
		RETURN;
	ELSE
		rTemp := rTime * rTime - 4 * i_rVelocity / i_rJerk;
		IF rTemp >= 0 THEN
			rTemp := SQRT(rTemp);
			rFistSolution	:= (i_rTime + rTemp) * i_rJerk / 2;
			rSecondSolution	:= (i_rTime - rTemp) * i_rJerk / 2;
			IF i_rVelocity >= (rFistSolution * rFistSolution) / i_rJerk THEN
				FC_GetAccFromTimeAndJerk := rFistSolution;
			ELSIF i_rVelocity >= (rSecondSolution * rSecondSolution) / i_rJerk THEN
				FC_GetAccFromTimeAndJerk := rSecondSolution;
			ELSE
				FC_GetAccFromTimeAndJerk := i_rVelocity / rTime;
			END_IF
		ELSE
			FC_GetAccFromTimeAndJerk :=	i_rVelocity	/ rTime;
		END_IF
	END_IF
END_FUNCTION
