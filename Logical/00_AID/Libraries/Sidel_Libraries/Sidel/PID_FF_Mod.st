FUNCTION_BLOCK PID_FF_Mod
	IF SP1_ON THEN
		FF_SP2_Save := IN_FF_SP2;
		IF FF_SP2_Save >= IN_FF_SP1 THEN
			FF_SP2_Save := IN_FF_SP1;
		END_IF
		FF_SP2_Time.PT := REAL_TO_TIME(IN_SP1_SP2_Time/1000);
	END_IF

	FF_SP2_Time.IN := SP1_ON;
	FF_SP2_Time();

	IF NOT IN_Reset AND IN_Enable THEN
		IF ( IN_Raise_Step_Counter >= IN_Raise_Step ) OR ( IN_Raise_Step_Counter >= 100 ) THEN
			Running := TRUE;
			Lower_Ramp := TRUE;
		END_IF
	END_IF

	IF (NOT IN_Enable AND (( IN_Lower_Step_Counter >= IN_Lower_Step ) OR ( IN_Lower_Step_Counter >= 100 )))
		OR IN_Reset THEN
		Running := FALSE;
		SP1_ON := FALSE;
		SP2_ON := FALSE;
	END_IF

	FF_SP1_Recipe := (IN_FF_SP1);
	FF_SP2_Recipe := (IN_FF_SP2);
	Speed := IN_Actual_Speed;
	Max_Speed := MAX(IN_Size_Speed, 1);

	FF_SP1_Val := FF_SP1_Recipe * Speed;
	FF_SP1_Val := FF_SP1_Val / Max_Speed;

	FF_SP2_Val := FF_SP2_Recipe * Speed;
	FF_SP2_Val := FF_SP2_Val / Max_Speed;

	IF NOT Running AND NOT Lower_Ramp THEN
		FF_value_Out := 0.0;
	ELSIF NOT Running THEN
		Ramp_Time := 200.0;
		Ramp_Speed_R := (IN_Ramp_Speed);
		Ramp_Value := Ramp_Value - ((Ramp_Time /1000.0) * Ramp_Speed_R );
		IF Ramp_Value <= 0 THEN
			Lower_Ramp := FALSE;
			Ramp_Value := 0;
		END_IF
		FF_value_Out := Ramp_Value;	
	ELSIF SP2_ON THEN
		FF_value_Out := FF_SP2_Val;
		Ramp_Value := FF_SP2_Val;	
	ELSIF FF_SP2_Time.Q THEN
		Ramp_Time := 200.0;
		Ramp_Speed_R := (IN_Ramp_Speed);
		Ramp_Value := Ramp_Value - ((Ramp_Time /1000.0) * Ramp_Speed_R );
		IF Ramp_Value <= FF_SP2_Val THEN
			SP2_ON := TRUE;
			Ramp_Value := FF_SP2_Val;
		END_IF
		FF_value_Out := Ramp_Value;
	ELSIF SP1_ON THEN
		FF_value_Out := FF_SP1_Val;
		Ramp_Value := FF_SP1_Val;
	ELSE
		Ramp_Time := 200.0;
		Ramp_Speed_R := (IN_Ramp_Speed);
		Ramp_Value := Ramp_Value + ((Ramp_Time /1000.0) * Ramp_Speed_R );
		FF_value_Out := Ramp_Value;
		IF Ramp_Value >= FF_SP1_Val THEN
			SP1_ON := TRUE;
		END_IF	
	END_IF

	OUT_FF_Value := FF_value_Out;
	OUT_FF_Value_Int := REAL_TO_INT(FF_value_Out);
END_FUNCTION_BLOCK
