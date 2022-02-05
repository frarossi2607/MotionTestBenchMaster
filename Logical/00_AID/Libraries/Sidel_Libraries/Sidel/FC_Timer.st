FUNCTION FC_IncTimer
	IF IN_Reset THEN
		FC_IncTimer	:= TRUE;
		IN_OUT_CounterStruct.Sec	:= 0;
		IN_OUT_CounterStruct.Min	:= 0;
		IN_OUT_CounterStruct.Hour	:= 0;
		IN_OUT_CounterStruct.Day	:= 0;
	ELSIF(IN_Clock1Hz) AND IN_Condition THEN
		FC_IncTimer	:=	TRUE;
		IN_OUT_CounterStruct.Sec	:= IN_OUT_CounterStruct.Sec + 1;
		IF (IN_OUT_CounterStruct.Sec >= 60) THEN
			IN_OUT_CounterStruct.Sec	:= 0;
			IN_OUT_CounterStruct.Min	:= IN_OUT_CounterStruct.Min + 1;
			IF IN_OUT_CounterStruct.Min >= 60 THEN
				IN_OUT_CounterStruct.Min	:= 0;
				IN_OUT_CounterStruct.Hour	:= IN_OUT_CounterStruct.Hour + 1;
				IF IN_OUT_CounterStruct.Hour >= 24 THEN
					IN_OUT_CounterStruct.Hour	:= 0;
					IN_OUT_CounterStruct.Day	:= IN_OUT_CounterStruct.Day + 1;
				END_IF
			END_IF
		END_IF
	ELSE
		FC_IncTimer	:= FALSE;
	END_IF
END_FUNCTION

FUNCTION FC_MacaoTimer
	IF IN_Reset THEN
		IN_OUT_Counter	:= 0;
	ELSIF IN_Clock1Hz AND IN_Condition THEN
		IN_OUT_Counter	:= IN_OUT_Counter + 1;
	END_IF
	FC_MacaoTimer := TRUE;
END_FUNCTION