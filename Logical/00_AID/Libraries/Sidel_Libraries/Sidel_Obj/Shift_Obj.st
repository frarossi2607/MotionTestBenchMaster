FUNCTION_BLOCK PhotoCell_SftObj
	IF IN_ConfigPresent THEN
		VAR_GrippersNumber	:= LIMIT(1, IN_GrippersNumber, CST_RepetitiveArrayDim);
		VAR_Mask 			:= IN_MaskEn AND HMI.Mask;
		
		IF VAR_Mask THEN
			VAR_Signal := IN_WaitOn AND NOT IN_WaitOff;
		ELSE
			VAR_Signal := IO.DI_Input;
		END_IF

		HMI.On := VAR_Signal;

		OUT	:= HMI.On;
		
		IF IN_MachinePitch AND IN_Enable THEN
			VAR_ActualValveCounter	:= INT_TO_USINT(FC_ReminderShift(VAR_ActualValveCounter	+ 1, VAR_GrippersNumber, 0));
			
			IF IN_WritePresenceEnable THEN //v1.63
				SHIFT_Position.ContainerPresence	:= IO.DI_Input;
			END_IF//v1.63
			
			IF SHIFT_Position.ContainerPresence THEN//v1.63
				IF NOT SHIFT_Position.ContainerBurst	AND	NOT VAR_Mask THEN//v1.63
					IF NOT IO.DI_Input THEN
						HMI.ConsecutiveErrors	:= SEL((IN_MStopConsecutiveValue > 0), 0,HMI.ConsecutiveErrors + 1);
						HMI.AbsoluteErrors		:= SEL((IN_CBlockAbsoluteValue > 0), 0, HMI.AbsoluteErrors + 1);
						HMI.TotalErrors			:= SEL((IN_MStopAbsoluteValue > 0), HMI.TotalErrors, HMI.TotalErrors + 1);
						
						VAR_RepetitiveCounterArray[VAR_ActualValveCounter]	:= SEL((IN_CBlockRepetitiveValue > 0), 0, VAR_RepetitiveCounterArray[VAR_ActualValveCounter] + 1);
						SHIFT_Position.ContainerPresence	:= FALSE;//v1.63
						
						IF VAR_RepetitiveCounterArray[VAR_ActualValveCounter] > IN_CBlockRepetitiveValue THEN
							OUT_CBlockRepetitive	:= TRUE;
						END_IF
					ELSE
						VAR_RepetitiveCounterArray[VAR_ActualValveCounter]	:= 0;
						HMI.ConsecutiveErrors	:= 0;//v1.63
					END_IF
				ELSE//v1.63
					VAR_RepetitiveCounterArray[VAR_ActualValveCounter]	:= 0;
					HMI.ConsecutiveErrors	:= 0;
				END_IF//v1.63
			END_IF

			HMI.AlwaysTrueSteps	:= SEL(VAR_EdgeChecked, HMI.AlwaysTrueSteps + 1, 0);//v1.63
			
			IF IN_CBlockRepetitiveValue > 0 THEN
				HMI.RepetitiveErrors	:= 0;
				
				FOR VAR_GrippersNumber:= 1	TO	CST_RepetitiveArrayDim	DO
					HMI.RepetitiveErrors := MAX(HMI.RepetitiveErrors, VAR_RepetitiveCounterArray[VAR_GrippersNumber]);
				END_FOR
			END_IF
		ELSIF NOT IO.DI_Input AND IN_Enable THEN
			VAR_EdgeChecked		:= TRUE;
		END_IF
		
		TMR_TON_TotalCounterReset(IN := IN_ResetCounters OR HMI.CounterReset, PT := T#5s);
		
		IF IN_ResetCounters OR HMI.CounterReset OR VAR_Mask OR NOT IN_Enable THEN
			IF NOT VAR_CounterResetMemory THEN
				VAR_CounterResetMemory	:= TRUE;
				
				FOR VAR_GrippersNumber:= 1 TO CST_RepetitiveArrayDim DO
					VAR_RepetitiveCounterArray[VAR_GrippersNumber]	:= 0;
					OUT_CBlockRepetitive	:= FALSE;
				END_FOR

				HMI.AlwaysTrueSteps		:= 0;
				HMI.RepetitiveErrors	:= 0;
				HMI.ConsecutiveErrors	:= 0;
				HMI.AbsoluteErrors		:= 0;
			END_IF
		ELSE
			VAR_CounterResetMemory	:= FALSE;
		END_IF
		
		IF TMR_TON_TotalCounterReset.Q THEN
			IF NOT VAR_TotalCounterResetMemory THEN
				VAR_TotalCounterResetMemory := TRUE;
				HMI.TotalErrors	:= 0;
			END_IF
		ELSE
			VAR_TotalCounterResetMemory := FALSE;
		END_IF
		
		HMI.ConfigPresent 	:= IN_ConfigPresent;
		HMI.ConfigAlarm 	:= IN_Alarm;
		HMI.Alarm 			:= OUT_CBlockAbsolute OR OUT_MStopConsecutive OR OUT_MStopAbsolute OR OUT_AlwaysTrueError;
		HMI.Wait			:= (IN_WaitOn AND NOT HMI.On) OR (IN_WaitOff AND HMI.On);
		HMI.MaskEnable		:= IN_MaskEn;
		
		OUT_CBlockAbsolute		:= (HMI.AbsoluteErrors 		>= IN_CBlockAbsoluteValue)		AND (IN_CBlockAbsoluteValue		> 0);
		OUT_MStopConsecutive	:= (HMI.ConsecutiveErrors 	>= IN_MStopConsecutiveValue)	AND (IN_MStopConsecutiveValue	> 0);
		OUT_MStopAbsolute		:= (HMI.AbsoluteErrors 		>= (IN_MStopAbsoluteValue + IN_CBlockAbsoluteValue))		AND (IN_MStopAbsoluteValue		> 0);	//V4.A.A.1.6.12
		OUT_AlwaysTrueError		:= (HMI.AlwaysTrueSteps		>= CST_AlwaysTrueMaxSteps)		AND (CST_AlwaysTrueMaxSteps		> 0);
	ELSE
		OUT						:= FALSE;
		OUT_CBlockRepetitive	:= FALSE;
		OUT_CBlockAbsolute		:= FALSE;
		OUT_MStopConsecutive	:= FALSE;
		OUT_MStopAbsolute		:= FALSE;
		OUT_AlwaysTrueError		:= FALSE;
		HMI.On 					:= FALSE;
		HMI.MaskEnable			:= FALSE;
		HMI.ConfigPresent 		:= FALSE;
		HMI.ConfigAlarm 		:= FALSE;
		HMI.Alarm 				:= FALSE;
		HMI.Wait				:= FALSE;
		HMI.RepetitiveErrors	:= 0;
		HMI.ConsecutiveErrors	:= 0;
		HMI.AbsoluteErrors		:= 0;
		HMI.AlwaysTrueSteps		:= 0;
	END_IF
END_FUNCTION_BLOCK

FUNCTION_BLOCK CapPhotoCell_SftObj
	IF IN_ConfigPresent THEN
		VAR_GrippersNumber	:= LIMIT(1, IN_GrippersNumber, CST_CounterArrayDim);
		VAR_Mask 			:= IN_MaskEn AND HMI.Mask;
		
		IF VAR_Mask THEN
			VAR_Signal := IN_WaitOn AND NOT IN_WaitOff;
		ELSE
			VAR_Signal := IO.DI_Input;
		END_IF
	
		HMI.On := VAR_Signal;

		OUT	:= HMI.On;
		
		IF IN_MachinePitch AND IN_Enable THEN
			VAR_ActualValveCounter	:= INT_TO_USINT(FC_ReminderShift(VAR_ActualValveCounter + 1, VAR_GrippersNumber, 0));
			
			IF SHIFT_Position.ContainerPresence AND SHIFT_Position.ClosingReleased AND NOT VAR_Mask THEN
				HMI.AlwaysTrueSteps	:= SEL(VAR_EdgeChecked, HMI.AlwaysTrueSteps + 1, 0);
				SHIFT_Position.ContainerClosed	:= IO.DI_Input;
				
				IF VAR_CapsReleased < 16#FFFFFFFF THEN
					VAR_CapsReleased := VAR_CapsReleased + 1;
				ELSE
					FOR VAR_i := VAR_AbsoluteErrorN TO 1 BY -1 DO
						VAR_AbsoluteCounterArray[VAR_i] := VAR_AbsoluteCounterArray[VAR_i] - (VAR_AbsoluteCounterArray[1] - 1);
					END_FOR
					VAR_CapsReleased := VAR_AbsoluteCounterArray[VAR_AbsoluteErrorN] + 1;
				END_IF
				
				IF NOT IO.DI_Input THEN
					HMI.ConsecutiveErrors	:= SEL((IN_MStopConsecutiveValue > 0), 0,HMI.ConsecutiveErrors + 1);
					//HMI.AbsoluteErrors		:= SEL((IN_CBlockAbsoluteValue > 0), 0, VAR_AbsoluteErrorN);	//V4.A.A.1.6.12
					HMI.TotalErrors			:= SEL((IN_CBlockAbsoluteValue > 0) OR (IN_MStopConsecutiveValue > 0), HMI.TotalErrors, HMI.TotalErrors + 1);
					
					VAR_RepetitiveCounterArray[VAR_ActualValveCounter] := SEL((IN_CBlockRepetitiveValue > 0), 0, VAR_RepetitiveCounterArray[VAR_ActualValveCounter] + 1);
					
					IF VAR_RepetitiveCounterArray[VAR_ActualValveCounter] > IN_CBlockRepetitiveValue THEN
						OUT_CBlockRepetitive	:= TRUE;
					END_IF
					
					IF IN_CBlockAbsoluteValue > 0 THEN
						IF IN_CBlockAbsoluteQuantity > 0 THEN
							VAR_AbsoluteCounterArray[VAR_AbsoluteErrorN] := VAR_CapsReleased;
						ELSE
							VAR_AbsoluteCounterArray[VAR_AbsoluteErrorN] := 0;
						END_IF
						
						VAR_AbsoluteErrorN := VAR_AbsoluteErrorN + 1;
					ELSE
						VAR_AbsoluteCounterArray[VAR_AbsoluteErrorN] := 0;
						VAR_AbsoluteErrorN := 1;
					END_IF
				ELSE
					VAR_RepetitiveCounterArray[VAR_ActualValveCounter]	:= 0;
				END_IF
			ELSE
				HMI.ConsecutiveErrors	:= 0;
			END_IF
			
			IF ((VAR_CapsReleased - VAR_AbsoluteCounterArray[1]) > IN_CBlockAbsoluteQuantity) AND (IN_CBlockAbsoluteQuantity > 0) THEN
				memmove(ADR(VAR_AbsoluteCounterArray[1]), ADR(VAR_AbsoluteCounterArray[2]), SIZEOF(VAR_AbsoluteCounterArray[1]) * 49);
				VAR_AbsoluteCounterArray[50] := 0;
				VAR_AbsoluteErrorN := MAX(VAR_AbsoluteErrorN - 1, 1);
			END_IF
			
			IF IN_CBlockRepetitiveValue > 0 THEN
				HMI.RepetitiveErrors := 0;
				FOR VAR_GrippersNumber:= 1 TO CST_CounterArrayDim DO
					HMI.RepetitiveErrors := MAX(HMI.RepetitiveErrors, VAR_RepetitiveCounterArray[VAR_GrippersNumber]);
				END_FOR
			END_IF
			
			HMI.AbsoluteErrors		:= SEL((IN_CBlockAbsoluteValue > 0), 0, VAR_AbsoluteErrorN - 1);	//V4.A.A.1.6.12
		ELSIF NOT IO.DI_Input AND IN_Enable THEN
			VAR_EdgeChecked := TRUE;
		ELSIF NOT IN_Enable THEN
			SHIFT_Position.ContainerClosed	:= SHIFT_Position.ContainerPresence AND SHIFT_Position.ClosingReleased;
		END_IF
		
		TMR_TON_TotalCounterReset(IN := IN_ResetCounters OR HMI.CounterReset, PT := T#5s);
		
		IF IN_ResetCounters OR HMI.CounterReset OR VAR_Mask OR NOT IN_Enable THEN
			IF NOT VAR_CounterResetMemory THEN
				VAR_CounterResetMemory	:= TRUE;
				
				FOR VAR_GrippersNumber:= 1 TO CST_CounterArrayDim DO
					VAR_RepetitiveCounterArray[VAR_GrippersNumber]	:= 0;
					OUT_CBlockRepetitive	:= FALSE;
				END_FOR
				
				memset(ADR(VAR_AbsoluteCounterArray[1]), 0, SIZEOF(VAR_AbsoluteCounterArray));
				VAR_AbsoluteErrorN := 1;
				
				VAR_CapsReleased		:= 0;
				HMI.AlwaysTrueSteps		:= 0;
				HMI.RepetitiveErrors	:= 0;
				//HMI.ConsecutiveErrors	:= 0;//V1.61
				HMI.AbsoluteErrors		:= 0;
			END_IF
		ELSE
			VAR_CounterResetMemory	:= FALSE;
		END_IF
		(*V1.61 Consecutive Errorors counter reset new management*)
		IF IN_ResetCountersConsecutive OR VAR_Mask OR NOT IN_Enable THEN
			IF NOT VAR_CounterConsResetMemory THEN
				VAR_CounterConsResetMemory	:= TRUE;
				HMI.ConsecutiveErrors	:= 0;
			END_IF
		ELSE
			VAR_CounterConsResetMemory	:= FALSE;
		END_IF
		
		IF TMR_TON_TotalCounterReset.Q THEN
			IF NOT VAR_TotalCounterResetMemory THEN
				VAR_TotalCounterResetMemory := TRUE;
				HMI.TotalErrors	:= 0;
			END_IF
		ELSE
			VAR_TotalCounterResetMemory := FALSE;
		END_IF
		
		HMI.ConfigPresent 	:= IN_ConfigPresent;
		HMI.ConfigAlarm 	:= IN_Alarm;
		HMI.Alarm 			:= OUT_CBlockAbsolute OR OUT_MStopConsecutive OR OUT_AlwaysTrueError;
		HMI.Wait			:= (IN_WaitOn AND NOT HMI.On) OR (IN_WaitOff AND HMI.On);
		HMI.MaskEnable		:= IN_MaskEn;
		
		OUT_CBlockAbsolute		:= (HMI.AbsoluteErrors 		>= IN_CBlockAbsoluteValue)		AND (IN_CBlockAbsoluteValue		> 0);
		OUT_MStopConsecutive	:= (HMI.ConsecutiveErrors 	>= IN_MStopConsecutiveValue)	AND (IN_MStopConsecutiveValue	> 0);
		OUT_AlwaysTrueError		:= (HMI.AlwaysTrueSteps		>= CST_AlwaysTrueMaxSteps)		AND (CST_AlwaysTrueMaxSteps		> 0);
	ELSE
		OUT						:= FALSE;
		OUT_CBlockRepetitive	:= FALSE;
		OUT_CBlockAbsolute		:= FALSE;
		OUT_MStopConsecutive	:= FALSE;
		OUT_AlwaysTrueError		:= FALSE;
		HMI.On 					:= FALSE;
		HMI.MaskEnable			:= FALSE;
		HMI.ConfigPresent 		:= FALSE;
		HMI.ConfigAlarm 		:= FALSE;
		HMI.Alarm 				:= FALSE;
		HMI.Wait				:= FALSE;
		HMI.RepetitiveErrors	:= 0;
		HMI.ConsecutiveErrors	:= 0;
		HMI.AbsoluteErrors		:= 0;
		HMI.AlwaysTrueSteps		:= 0;
	END_IF
END_FUNCTION_BLOCK

FUNCTION_BLOCK CapPhotoCell_SftObj_old
	IF IN_ConfigPresent THEN
		VAR_GrippersNumber	:= LIMIT(1, IN_GrippersNumber, CST_RepetitiveArrayDim);
		VAR_Mask 			:= IN_MaskEn AND HMI.Mask;
		
		IF VAR_Mask THEN
			VAR_Signal := IN_WaitOn AND NOT IN_WaitOff;
		ELSE
			VAR_Signal := IO.DI_Input;
		END_IF
	
		HMI.On := VAR_Signal;

		OUT	:= HMI.On;
		
		IF IN_MachinePitch AND IN_Enable THEN
			VAR_ActualValveCounter	:= INT_TO_USINT(FC_ReminderShift(VAR_ActualValveCounter + 1, VAR_GrippersNumber, 0));
			
			IF SHIFT_Position.ContainerPresence AND SHIFT_Position.ClosingReleased AND NOT VAR_Mask THEN
				HMI.AlwaysTrueSteps	:= SEL(VAR_EdgeChecked, HMI.AlwaysTrueSteps + 1, 0);
				SHIFT_Position.ContainerClosed	:= IO.DI_Input;
				
				IF NOT IO.DI_Input THEN
					HMI.ConsecutiveErrors	:= SEL((IN_MStopConsecutiveValue > 0), 0,HMI.ConsecutiveErrors + 1);
					HMI.AbsoluteErrors		:= SEL((IN_CBlockAbsoluteValue > 0), 0, HMI.AbsoluteErrors + 1);
					HMI.TotalErrors			:= SEL((IN_MStopAbsoluteValue > 0), HMI.TotalErrors, HMI.TotalErrors + 1);
					
					VAR_RepetitiveCounterArray[VAR_ActualValveCounter] := SEL((IN_CBlockRepetitiveValue > 0), 0, VAR_RepetitiveCounterArray[VAR_ActualValveCounter] + 1);
					
					IF VAR_RepetitiveCounterArray[VAR_ActualValveCounter] > IN_CBlockRepetitiveValue THEN
						OUT_CBlockRepetitive	:= TRUE;
					END_IF
				ELSE
					VAR_RepetitiveCounterArray[VAR_ActualValveCounter]	:= 0;
				END_IF
			ELSE
				HMI.ConsecutiveErrors	:= 0;
			END_IF
		
			IF IN_CBlockRepetitiveValue > 0 THEN
				HMI.RepetitiveErrors := 0;
				FOR VAR_GrippersNumber:= 1 TO CST_RepetitiveArrayDim DO
					HMI.RepetitiveErrors := MAX(HMI.RepetitiveErrors, VAR_RepetitiveCounterArray[VAR_GrippersNumber]);
				END_FOR
			END_IF
		ELSIF NOT IO.DI_Input AND IN_Enable THEN
			VAR_EdgeChecked := TRUE;
		ELSIF NOT IN_Enable THEN
			SHIFT_Position.ContainerClosed	:= SHIFT_Position.ContainerPresence AND SHIFT_Position.ClosingReleased;
		END_IF
		
		TMR_TON_TotalCounterReset(IN := IN_ResetCounters OR HMI.CounterReset, PT := T#5s);
		
		IF IN_ResetCounters OR HMI.CounterReset OR VAR_Mask THEN
			IF NOT VAR_CounterResetMemory THEN
				VAR_CounterResetMemory	:= TRUE;
				
				FOR VAR_GrippersNumber:= 1 TO CST_RepetitiveArrayDim DO
					VAR_RepetitiveCounterArray[VAR_GrippersNumber]	:= 0;
					OUT_CBlockRepetitive	:= FALSE;
				END_FOR
				
				HMI.AlwaysTrueSteps		:= 0;
				HMI.RepetitiveErrors	:= 0;
				HMI.ConsecutiveErrors	:= 0;
				HMI.AbsoluteErrors		:= 0;
			END_IF
		ELSE
			VAR_CounterResetMemory	:= FALSE;
		END_IF
		
		IF TMR_TON_TotalCounterReset.Q THEN
			IF NOT VAR_TotalCounterResetMemory THEN
				VAR_TotalCounterResetMemory := TRUE;
				HMI.TotalErrors	:= 0;
			END_IF
		ELSE
			VAR_TotalCounterResetMemory := FALSE;
		END_IF
		
		HMI.ConfigPresent 	:= IN_ConfigPresent;
		HMI.ConfigAlarm 	:= IN_Alarm;
		HMI.Alarm 			:= OUT_CBlockAbsolute OR OUT_MStopConsecutive OR OUT_MStopAbsolute OR OUT_AlwaysTrueError;
		HMI.Wait			:= (IN_WaitOn AND NOT HMI.On) OR (IN_WaitOff AND HMI.On);
		HMI.MaskEnable		:= IN_MaskEn;
		
		OUT_CBlockAbsolute		:= (HMI.AbsoluteErrors 		>= IN_CBlockAbsoluteValue)		AND (IN_CBlockAbsoluteValue		> 0);
		OUT_MStopConsecutive	:= (HMI.ConsecutiveErrors 	>= IN_MStopConsecutiveValue)	AND (IN_MStopConsecutiveValue	> 0);
		OUT_MStopAbsolute		:= (HMI.AbsoluteErrors 		>= IN_MStopAbsoluteValue)		AND (IN_MStopAbsoluteValue		> 0);
		OUT_AlwaysTrueError		:= (HMI.AlwaysTrueSteps		>= CST_AlwaysTrueMaxSteps)		AND (CST_AlwaysTrueMaxSteps		> 0);
	ELSE
		OUT						:= FALSE;
		OUT_CBlockRepetitive	:= FALSE;
		OUT_CBlockAbsolute		:= FALSE;
		OUT_MStopConsecutive	:= FALSE;
		OUT_MStopAbsolute		:= FALSE;
		OUT_AlwaysTrueError		:= FALSE;
		HMI.On 					:= FALSE;
		HMI.MaskEnable			:= FALSE;
		HMI.ConfigPresent 		:= FALSE;
		HMI.ConfigAlarm 		:= FALSE;
		HMI.Alarm 				:= FALSE;
		HMI.Wait				:= FALSE;
		HMI.RepetitiveErrors	:= 0;
		HMI.ConsecutiveErrors	:= 0;
		HMI.AbsoluteErrors		:= 0;
		HMI.AlwaysTrueSteps		:= 0;
	END_IF
END_FUNCTION_BLOCK

FUNCTION_BLOCK Ejector_SftObj
	VAR_Mask	:= HMI.Mask AND IN_MaskEn;
	
	(* Local *)
	IF IN_ManEn AND NOT IN_HMIAutoForce THEN
		VAR_ManOn	:= HMI.ManOn;
		VAR_Auto	:= NOT HMI.ManOff AND NOT HMI.ManOn;
	ELSE
		VAR_ManOn	:= FALSE;
		VAR_Auto	:= TRUE;
		HMI.ManOn	:= FALSE;
		HMI.ManOff	:= FALSE;
	END_IF	
	
	IF IN_MachinePitch THEN
		VAR_AutoCnd := IN_ShiftPosition.ContainerPresence		AND (IN_ShiftPosition.ContainerBurst	OR
						(NOT IN_ShiftPosition.ContainerFilled	AND IN_FillingErrorEject) OR IN_ShiftPosition.EjectContainer) AND NOT VAR_Mask; (*V1.61*)
		IF VAR_AutoCnd AND NOT IN_SamplingModeActive THEN (*V1.61*)
			HMI.ConsecutiveErrors	:= HMI.ConsecutiveErrors	+ 1;
			HMI.AbsoluteErrors		:= HMI.AbsoluteErrors		+ 1;
			HMI.TotalErrors			:= HMI.TotalErrors			+ 1;
		ELSE
			HMI.ConsecutiveErrors	:= 0;
		END_IF(*V1.61*)
		
		IF IN_SamplingModeActive AND VAR_AutoCnd THEN (*V1.61*)
			IN_ShiftPosition.ContainerEjected := TRUE;(*V1.61*)
		ELSE 
			IN_ShiftPosition.ContainerEjected := FALSE;(*V1.61*)
		END_IF
	END_IF
	
	TMR_TON_TotalCounterReset(IN := IN_ResetCounters OR HMI.CounterReset, PT := T#5s);
	
	IF IN_ResetCounters OR HMI.CounterReset THEN
		IF NOT VAR_CounterResetMemory THEN
			VAR_CounterResetMemory	:= TRUE;
			HMI.ConsecutiveErrors	:= 0;
			HMI.AbsoluteErrors		:= 0;
		END_IF
	ELSE
		VAR_CounterResetMemory	:= FALSE;
	END_IF
		
	IF TMR_TON_TotalCounterReset.Q THEN
		IF NOT VAR_TotalCounterResetMemory THEN
			VAR_TotalCounterResetMemory := TRUE;
			HMI.TotalErrors	:= 0;
		END_IF
	ELSE
		VAR_TotalCounterResetMemory := FALSE;
	END_IF
	
	IF IN_ConfigPresent THEN
		IF IN_Enable THEN
			IF VAR_Auto THEN
				VAR_ValveOpened := VAR_AutoCnd;
			ELSIF VAR_ManOn THEN
				VAR_ValveOpened := TRUE;
			ELSE
				VAR_ValveOpened := FALSE;
			END_IF
		ELSIF NOT IN_ConfigType THEN
			VAR_ValveOpened := FALSE;
		END_IF
		VAR_ValveClosed := NOT VAR_ValveOpened;
      
		OUT						:= VAR_ValveOpened;
		OUT_CBlockAbsolute		:= (HMI.AbsoluteErrors 		>= IN_CBlockAbsoluteValue)		AND (IN_CBlockAbsoluteValue		> 0);
		OUT_MStopConsecutive	:= (HMI.ConsecutiveErrors 	>= IN_MStopConsecutiveValue)	AND (IN_MStopConsecutiveValue	> 0);
	ELSE
		VAR_ValveOpened			:= FALSE;
		VAR_ValveClosed			:= FALSE;
		OUT						:= FALSE;
		OUT_CBlockAbsolute		:= 0;
		OUT_MStopConsecutive	:= 0;
	END_IF

	(* HMI *)
	HMI.ManEnable		:= IN_ManEn;
	HMI.ConfigPresent	:= IN_ConfigPresent;
	HMI.MaskEnable		:= IN_MaskEn;
	HMI.Alarm 			:= OUT_CBlockAbsolute OR OUT_MStopConsecutive;

	(* IO *)
	IO.DO_Opened	:= VAR_ValveOpened;
	IO.DO_Closed	:= VAR_ValveClosed;
	HMI.Out			:= IO.DO_Opened;
END_FUNCTION_BLOCK