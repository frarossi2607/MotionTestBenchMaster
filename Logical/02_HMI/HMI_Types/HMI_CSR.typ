
TYPE
	HMI_CSR_Data_Type : 	STRUCT 
		TnkPositionPv : REAL;
		TnkPositionSp : REAL;
		ColumnPositionPv : REAL;
		ColumnPositionSp : REAL;
		RnsPositionSp : REAL;
		RnsPositionPv : REAL;
		CapPositionSp : REAL;
		CapPositionPv : REAL;
		CrwPositionSp : REAL;
		CrwPositionPv : REAL;
		RcpMaxValue : REAL;
		RcpMinValue : REAL;
		CrwPageVisibility : BOOL;
		CapPageVisibility : BOOL;
		FillerAlarmActive : BOOL;
		CrownerAlarmActive : BOOL;
		CapperAlarmActive : BOOL;
		RinserAlarmActive : BOOL;
	END_STRUCT;
	HMI_CSR_SikoMotorData_Type : 	STRUCT  (* *) (* *) (*13*)
		ActualPosition : REAL; (* *) (* *) (*14*)
		PR_AccelerationSpeed : INT; (* *) (* *) (*15*)
		PR_CalibrationValue : REAL; (* *) (* *) (*16*)
		PR_Delta_Inch : DINT; (* *) (* *) (*17*)
		PR_GearIn : INT; (* *) (* *) (*18*)
		PR_GearOut : INT; (* *) (* *) (*19*)
		PR_JogSpeed : INT; (* *) (* *) (*20*)
		PR_KP : INT; (* *) (* *) (*21*)
		PR_TD : INT; (* *) (* *) (*22*)
		PR_TI : INT; (* *) (* *) (*23*)
		PR_Upper_Limit : REAL; (* *) (* *) (*24*)
		PR_Lower_Limit : REAL; (* *) (* *) (*25*)
		PR_PositionSpeed : INT; (* *) (* *) (*26*)
		PR_PosWindows : INT; (* *) (* *) (*27*)
		PR_RotationSense : INT; (* *) (* *) (*28*)
		PR_Spindle_Pitch : INT; (* *) (* *) (*29*)
		PR_SystemStatus : INT; (* *) (* *) (*30*)
		Status : UINT; (* *) (* *) (*31*)
	END_STRUCT;
	HMI_CSR_SikoActualPosition_Type : 	STRUCT  (* *) (* *) (*33*)
		OutConveyor_Guide : INT; (* *) (* *) (*34*)
		OutConveyor_Height : INT; (* *) (* *) (*35*)
		Position_Actual : REAL; (* *) (* *) (*36*)
		Position_Request : REAL; (* *) (* *) (*37*)
		PositionGuide_Actual : REAL; (*v1.5*) (* *) (*36*)
		PositionGuide_Request : REAL; (*v1.5*) (* *) (*37*)
	END_STRUCT;
END_TYPE
