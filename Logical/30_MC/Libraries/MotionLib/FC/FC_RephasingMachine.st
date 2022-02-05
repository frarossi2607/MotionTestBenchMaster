(* Function for finding the machine rephasing position *)
FUNCTION FC_RephasingMachine
	(* Before starting is necessary to load axes on both arrays *)
	udiLastAxisIndex	:= 0;
	
	FOR udiAxisIndex := 0 TO 30 BY 1 DO
		alrPositions[udiAxisIndex]	:= 0.0;
		auiAxisIndex[udiAxisIndex]	:= 0;
	END_FOR
	
	FOR udiAxisIndex := 0 TO CST_LastInletModuleAxis BY 1 DO
		IF iq_astInletSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_xAxisReal 		AND NOT
			iq_astInletSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_xPowerSupply 	AND NOT
			iq_astInletSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl THEN
		
			alrPositions[udiLastAxisIndex]	:= iq_astInletSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_lrPosition;
			auiAxisIndex[udiLastAxisIndex]	:= udiAxisIndex + 2000; (* To the axis module axes index 2000 is added *)
		
			udiLastAxisIndex	:= MIN(udiLastAxisIndex + 1, 30);
		END_IF
	END_FOR
	
	FOR udiAxisIndex := 0 TO CST_LastFillerModuleAxis BY 1 DO
		IF iq_astFillerSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_xAxisReal 		AND NOT
			iq_astFillerSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_xPowerSupply 	AND NOT
			iq_astFillerSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl THEN
		
			alrPositions[udiLastAxisIndex]	:= iq_astFillerSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_lrPosition;
			auiAxisIndex[udiLastAxisIndex]	:= udiAxisIndex;
		
			udiLastAxisIndex	:= MIN(udiLastAxisIndex + 1, 30);
		END_IF
	END_FOR
		
	FOR udiAxisIndex := 0 TO CST_LastOutletModuleAxis BY 1 DO
		IF iq_astOutletSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_xAxisReal 			AND NOT
			iq_astOutletSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_xPowerSupply 		AND NOT
			iq_astOutletSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl THEN
		
			alrPositions[udiLastAxisIndex]	:= iq_astOutletSubModuleAxis[udiAxisIndex].iq_stStatus.q_stMainAxisStatus.q_lrPosition;
			auiAxisIndex[udiLastAxisIndex]	:= udiAxisIndex + 1000; (* To the axis module axes index 1000 is added *)
		
			udiLastAxisIndex	:= MIN(udiLastAxisIndex + 1, 30);
		END_IF
	END_FOR
	
	
	IF udiLastAxisIndex > 1 THEN
		FOR udiRowIndex := 0 TO udiLastAxisIndex - 1 BY 1 DO  (* First Step : make the distance between an axis and the other ones *)
			FOR udiColumnIndex := 0 TO udiLastAxisIndex - 1 BY 1 DO
				aalrDistances[udiRowIndex,udiColumnIndex]	:= 0.0;
				IF udiRowIndex <> udiColumnIndex THEN
					aalrDistances[udiRowIndex,udiColumnIndex] := FC_LongRealReminder(i_lrDividend := (alrPositions[udiRowIndex] - alrPositions[udiColumnIndex]),
					i_lrDivisor:= 360.0,
					i_lrStart:= 0.0);
				END_IF
			END_FOR
		END_FOR
		
		lrMinimumValue	:= 1e100;
		udiAxisIndex	:= 0;
		
		FOR udiRowIndex := 0 TO udiLastAxisIndex - 1 BY 1 DO (* Second Step. Verify the path of all axes and find the minimum combination *)
			lrTemp	:= 0;
			FOR udiColumnIndex := 0 TO udiLastAxisIndex - 1 BY 1 DO
				IF udiRowIndex <> udiColumnIndex THEN
					lrTemp := aalrDistances[udiRowIndex, udiColumnIndex]	+ lrTemp;
				END_IF
			END_FOR
			
			IF lrMinimumValue > lrTemp THEN
				udiAxisIndex		:= udiRowIndex;
				lrMinimumValue		:= lrTemp;
			END_IF
		END_FOR
		
		FC_RephasingMachine := FC_LongRealReminder(i_lrDividend := alrPositions[udiAxisIndex],
													i_lrDivisor:= 360.0,
													i_lrStart:= 0.0);
	ELSE
		FC_RephasingMachine := FC_LongRealReminder(i_lrDividend:= alrPositions[0],
													i_lrDivisor:= 360.0,
													i_lrStart:= 0.0);
	END_IF
END_FUNCTION
