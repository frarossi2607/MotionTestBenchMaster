
TYPE
	VAR_DOS_LiftCommands_Type : 	STRUCT 
		Position : VAR_DOS_Position_Type;
		DevicesDetails : VAR_DOS_DevicesDetails_Type;
		WarningsDetails : VAR_DOS_Warnings_Type;
		CmdSizeChangeHeight : VAR_DOS_CmdHeight_Type;
		CmdProductionHeight : VAR_DOS_CmdProductionHeight_Type;
		CmdMaxHeight : VAR_DOS_CmdMaxHeight_Typ;
		CmdCipHeight : VAR_DOS_CmdCipHeight_Typ;
		CmdManualMode : VAR_DOS_CmdManualMode_Type;
		DevicesGeneralAlarm : BOOL;
		CaruselPositioning : BOOL;
		MachineStopReq : BOOL;
		StepActual : USINT;
		ChangeOver : USINT;
	END_STRUCT;
	VAR_DOS_Position_Type : 	STRUCT 
		ActualSp : REAL;
		ActualPv : REAL;
		MinMechanicalHeight : REAL;
		MinMechanicalHeightReached : BOOL;
		MaxMechanicalHeight : REAL;
		MaxMechanicalHeightReached : BOOL;
	END_STRUCT;
	VAR_DOS_DevicesDetails_Type : 	STRUCT 
		IsolatedAlr : BOOL;
		ContactorFbkAlr : BOOL;
		BrakePositionAlr : BOOL;
		ProbeAlr : BOOL;
		DirectionAlr : BOOL;
		RunFbkAlr : BOOL;
		OverloadAlr : BOOL;
		ContactorAlr : BOOL;
		ShaftBrokenAlr : BOOL;
	END_STRUCT;
	VAR_DOS_Warnings_Type : 	STRUCT 
		OutOfPosition : BOOL;
	END_STRUCT;
	VAR_DOS_CmdHeight_Type : 	STRUCT 
		Req : BOOL;
		Done : BOOL;
	END_STRUCT;
	VAR_DOS_CmdProductionHeight_Type : 	STRUCT 
		Req : BOOL;
		Sp : REAL;
		Done : BOOL;
	END_STRUCT;
	VAR_DOS_CmdMaxHeight_Typ : 	STRUCT 
		Req : BOOL;
		Sp : REAL;
		Done : BOOL;
	END_STRUCT;
	VAR_DOS_CmdCipHeight_Typ : 	STRUCT 
		Req : BOOL;
		Sp : REAL;
		Done : BOOL;
	END_STRUCT;
	VAR_DOS_CmdManualMode_Type : 	STRUCT 
		Req : BOOL;
		Up : BOOL;
		Dwn : BOOL;
		UpperLimitReached : BOOL;
		LowerLimitReached : BOOL;
	END_STRUCT;
	VAR_DOS_MMF205_Type : 	STRUCT  (*Motor Lifting *)
		PosValid : BOOL;
		SensorMaxVol : BOOL;
		SensorHighPos : BOOL;
		SensorLowPos : BOOL;
		PosReached : BOOL;
		PosActual : ARRAY[0..1]OF REAL;
		SpActual : ARRAY[0..1]OF REAL;
	END_STRUCT;
	VAR_DOS_MMF206_Type : 	STRUCT 
		PosValid : BOOL;
		PosOffset : BOOL;
		SensorHighPos : BOOL;
		SensorLowPos : BOOL;
		PosReached : BOOL;
		PosActual : ARRAY[0..1]OF REAL;
		SpActual : ARRAY[0..1]OF REAL;
	END_STRUCT;
	VAR_DOS_LimitsExceeded_Type : 	STRUCT  (*Mom uso?*)
		UpperLimitExceededAlr : BOOL;
		LowerLimitExceededAlr : BOOL;
	END_STRUCT;
	VAR_DOS_ChangeOverData_Type : 	STRUCT  (*non uso?*)
		ChangeOverNecessary : BOOL;
		ActualFormatHeight : ARRAY[0..5]OF REAL;
		RecipeFormatHeight : ARRAY[0..5]OF REAL;
	END_STRUCT;
END_TYPE
