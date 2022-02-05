(* Find The Position Of The First Axis *)
FUNCTION FC_RephasingPositionOutlet
	FOR udiRowIndex := 0 TO CST_LastOutletModuleAxis BY 1 DO (* First Step : make the distance between an axis and the other ones *)
		FOR udiColumnIndex := 0 TO CST_LastOutletModuleAxis BY 1 DO
			aalrDistances[udiRowIndex, udiColumnIndex]	:= 0.0;
			IF 	udiRowIndex <> udiColumnIndex	AND
				iq_astSubModuleAxis[udiRowIndex].iq_stStatus.q_stMainAxisStatus.q_xAxisReal 				AND
				iq_astSubModuleAxis[udiColumnIndex].iq_stStatus.q_stMainAxisStatus.q_xAxisReal 				AND
				NOT iq_astSubModuleAxis[udiRowIndex].iq_stStatus.q_stMainAxisStatus.q_xPowerSupply 			AND
				NOT iq_astSubModuleAxis[udiColumnIndex].iq_stStatus.q_stMainAxisStatus.q_xPowerSupply 		AND
				NOT iq_astSubModuleAxis[udiRowIndex].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl		AND
				NOT iq_astSubModuleAxis[udiColumnIndex].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl THEN

				aalrDistances[udiRowIndex,udiColumnIndex] := FC_LongRealReminder(i_lrDividend := (iq_astSubModuleAxis[udiRowIndex].iq_stStatus.q_stMainAxisStatus.q_lrPosition - iq_astSubModuleAxis[udiColumnIndex].iq_stStatus.q_stMainAxisStatus.q_lrPosition),
																					i_lrDivisor := 360.0,
																					i_lrStart := 0.0);
			END_IF
		END_FOR
	END_FOR

	lrMinimumValue	:= 1e100;
	udiAxisIndex	:= CST_FirstOutletModuleAxis;

	FOR udiRowIndex := 0 TO CST_LastOutletModuleAxis BY 1 DO (* Second Step. Verify the path of all axes and find the minimum combination *)
		lrTemp	:= 0;
		IF iq_astSubModuleAxis[udiRowIndex].iq_stStatus.q_stMainAxisStatus.q_xAxisReal 			AND
			NOT iq_astSubModuleAxis[udiRowIndex].iq_stStatus.q_stMainAxisStatus.q_xPowerSupply 	AND
			NOT iq_astSubModuleAxis[udiRowIndex].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl THEN
	
			FOR udiColumnIndex := 0 TO CST_LastOutletModuleAxis BY 1 DO
				IF udiRowIndex <> udiColumnIndex AND 
					iq_astSubModuleAxis[udiColumnIndex].iq_stStatus.q_stMainAxisStatus.q_xAxisReal  		AND
					NOT iq_astSubModuleAxis[udiColumnIndex].iq_stStatus.q_stMainAxisStatus.q_xPowerSupply 	AND
					NOT iq_astSubModuleAxis[udiColumnIndex].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl THEN
					
					lrTemp := aalrDistances[udiRowIndex, udiColumnIndex] + lrTemp;
				END_IF
			END_FOR
	
			IF lrMinimumValue > lrTemp THEN
				udiAxisIndex		:= udiRowIndex;
				lrMinimumValue		:= lrTemp;
			END_IF
		END_IF
	END_FOR

	FC_RephasingPositionOutlet := FC_LongRealReminder(i_lrDividend := iq_astSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_lrPosition,
														i_lrDivisor := 360.0,
														i_lrStart := 0.0);
END_FUNCTION