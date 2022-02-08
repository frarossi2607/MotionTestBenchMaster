
TYPE
	VAR_DOS_LiftMoveStep_Type : 
		(
		DSR_LiftSystemOff,
		DSR_ProbeZeroReq,
		DSR_ProbeZeroLowPos,
		DSR_ProbeZeroDisengSensLow,
		DSR_ProbeZeroWaitSensLowPos,
		DSR_ProbeZeroDone,
		DSR_CopPosReached,
		DSR_DosingReq,
		DSR_DosingActive,
		DSR_Manual,
		DSR_PosMMF206ToMMF205,
		DSR_UpMMF205andMMF206,
		DSR_DwnMMF205andMMF206,
		DSR_PosReached,
		DSR_Fault
		);
	VAR_DOS_LiftSeqMem_Type : 	STRUCT 
		Unlock : BOOL;
		LiftMotor : VAR_DOS_SeqMemLiftMotor_Type;
		Position : VAR_DOS_SeqMemPosition_Type;
		Sensor : VAR_DOS_SeqMemSensor_Type;
	END_STRUCT;
	VAR_DOS_SeqMemLiftMotor_Type : 	STRUCT 
		Up : BOOL;
		Dwn : BOOL;
		RunFbkAlr : BOOL;
		DirectionAlr : BOOL;
	END_STRUCT;
	VAR_DOS_SeqMemPosition_Type : 	STRUCT 
		ActualSp : REAL;
		SizeChangeHeightReached : BOOL;
		ProductionHeightReached : BOOL;
		MaxMechanicalHeightReached : BOOL;
		ManUpperLimitReached : BOOL;
		ManLowerLimitReached : BOOL;
	END_STRUCT;
	VAR_DOS_SeqMemSensor_Type : 	STRUCT 
		SensorMaxVolWaitOff : BOOL;
		SensorLowPosWaitOn : BOOL;
		SensorHighPosWaitOn : BOOL;
		SensorLowPosWaitOff : BOOL;
		SensorHighPosWaitOff : BOOL;
		SensorMaxVolWaitOn : BOOL;
	END_STRUCT;
END_TYPE
