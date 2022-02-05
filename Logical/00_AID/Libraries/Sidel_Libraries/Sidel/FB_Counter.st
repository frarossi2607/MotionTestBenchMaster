FUNCTION_BLOCK FB_Counter
	IF(IN_Clock1Hz) AND IN_TimeCondition THEN
		IN_OUT_CounterPartialStruct.CounterTime.Sec	:= IN_OUT_CounterPartialStruct.CounterTime.Sec + 1;	
		IF (IN_OUT_CounterPartialStruct.CounterTime.Sec >= 60) THEN
			IN_OUT_CounterPartialStruct.CounterTime.Sec	:= 0;
			IN_OUT_CounterPartialStruct.CounterTime.Min	:= IN_OUT_CounterPartialStruct.CounterTime.Min + 1;
			IF IN_OUT_CounterPartialStruct.CounterTime.Min >= 60 THEN
				IN_OUT_CounterPartialStruct.CounterTime.Min	:= 0;
				IN_OUT_CounterPartialStruct.CounterTime.Hour	:= IN_OUT_CounterPartialStruct.CounterTime.Hour + 1;
				IF IN_OUT_CounterPartialStruct.CounterTime.Hour >= 24 THEN
					IN_OUT_CounterPartialStruct.CounterTime.Hour	:= 0;
					IN_OUT_CounterPartialStruct.CounterTime.Day	:= IN_OUT_CounterPartialStruct.CounterTime.Day + 1;
				END_IF
			END_IF
		END_IF
		
		IN_OUT_CounterTotalStruct.CounterTime.Sec	:= IN_OUT_CounterTotalStruct.CounterTime.Sec + 1;
		IF (IN_OUT_CounterTotalStruct.CounterTime.Sec >= 60) THEN
			IN_OUT_CounterTotalStruct.CounterTime.Sec	:= 0;
			IN_OUT_CounterTotalStruct.CounterTime.Min	:= IN_OUT_CounterTotalStruct.CounterTime.Min + 1;
			IF IN_OUT_CounterTotalStruct.CounterTime.Min >= 60 THEN
				IN_OUT_CounterTotalStruct.CounterTime.Min	:= 0;
				IN_OUT_CounterTotalStruct.CounterTime.Hour	:= IN_OUT_CounterTotalStruct.CounterTime.Hour + 1;
				IF IN_OUT_CounterTotalStruct.CounterTime.Hour >= 24 THEN
					IN_OUT_CounterTotalStruct.CounterTime.Hour	:= 0;
					IN_OUT_CounterTotalStruct.CounterTime.Day	:= IN_OUT_CounterTotalStruct.CounterTime.Day + 1;
				END_IF
			END_IF
		END_IF
	END_IF
	
	IF IN_IncrementCondition THEN
		tempReal := tempReal + IN_PulseWeight;
		IF tempReal >= 1.0 THEN
			IN_OUT_CounterPartialStruct.CounterValue	:= IN_OUT_CounterPartialStruct.CounterValue + TRUNC(tempReal);
			IN_OUT_CounterTotalStruct.CounterValue		:= IN_OUT_CounterTotalStruct.CounterValue 	+ TRUNC(tempReal);
			tempReal := tempReal - (TRUNC(tempReal));
		END_IF
	END_IF

	IF IN_Reset THEN
		IN_OUT_CounterPartialStruct.CounterTime.Sec		:= 0;
		IN_OUT_CounterPartialStruct.CounterTime.Min		:= 0;
		IN_OUT_CounterPartialStruct.CounterTime.Hour	:= 0;
		IN_OUT_CounterPartialStruct.CounterTime.Day		:= 0;
		IN_OUT_CounterPartialStruct.CounterValue		:= 0;
		IN_OUT_CounterPartialStruct.StartDate			:= DT_TO_DINT(IN_Date);
	ELSIF IN_OUT_CounterPartialStruct.StartDate = 0 THEN
		IN_OUT_CounterPartialStruct.StartDate		:= DT_TO_DINT(IN_Date);
	ELSIF IN_OUT_CounterTotalStruct.StartDate	= 0 THEN
		IN_OUT_CounterTotalStruct.StartDate		:= DT_TO_DINT(IN_Date);
	END_IF
END_FUNCTION_BLOCK