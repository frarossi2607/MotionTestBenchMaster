(*RINSER*)

TYPE
	RNS_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		DataOut : RNS_DataOut_Type;
	END_STRUCT;
	RNS_DataOut_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		Idle : BOOL;
		StepCountReq : BOOL;
		CipMode : BOOL;
		CipDrainMode : BOOL;
		RinseMode : BOOL;
		DrainMode : BOOL;
		ProdMode : BOOL;
		StartUp : BOOL;
		CopMode : BOOL;
		DeEnergization : BOOL;
		SystemTreatmentAlr : BOOL;
		SystemOnTreatment : BOOL;
		InsercionRequest : BOOL;
		ByPassRequest : BOOL;
		ControlContinousRequestWater : BOOL;
		ControlContinousRequestAir : BOOL;
		ControlInsercionRequestWater : BOOL;
		ControlInsercionRequestAir : BOOL;
		FixSpeedRequest : BOOL;
		ByPassed : BOOL;
		AxisDisableRequest : BOOL;
		ContainerStop : BOOL;
		InsrtcionDeviceRequest : BOOL;
		InsrtcionControlActive : BOOL;
		ContinousControlActive : BOOL;
		ProductRequest : BOOL;
		StepCounterRequest : BOOL;
		MachineStart : BOOL;
		MachineStop : BOOL;
		NoBottleNoSprayInsercion : BOOL; (*vrma test*)
		WaterFlow : REAL;
		Temperature : REAL;
		FixSpeedValue : REAL;
	END_STRUCT;
	RNS_NozzleData_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		Visibility : BOOL;
		InsercionAir : RNS_Control_Type;
		InsercionWater : RNS_Control_Type;
		ContinousAir : RNS_Control_Type;
		ContinousWater : RNS_Control_Type;
		NozzleNumber : USINT;
	END_STRUCT;
	RNS_Control_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		Active : BOOL;
		Alarm : BOOL;
		FailedCount : USINT;
	END_STRUCT;
END_TYPE
