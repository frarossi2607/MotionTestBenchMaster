
TYPE
	DOS_Lift_Phase_Type : 	STRUCT 
		Elements : ARRAY[0..19]OF HMI_ComboBoxElements_Type; (*vrma*)
		Data : ARRAY[0..19]OF DOS_LiftPhase_Type;
	END_STRUCT;
	DOS_LiftPhase_Type : 	STRUCT 
		PhaseType : USINT;
	END_STRUCT;
END_TYPE
