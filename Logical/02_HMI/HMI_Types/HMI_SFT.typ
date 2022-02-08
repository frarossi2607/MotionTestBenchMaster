
TYPE
	StepAcquisition_Type : 	STRUCT 
		Step : USINT;
		_207DSF : StepAcquisition_Sensor_Type;
		_208DSF : StepAcquisition_Sensor_Type;
		_202DSF : StepAcquisition_Sensor_Type;
		_203DSF : StepAcquisition_Sensor_Type;
	END_STRUCT;
	StepAcquisition_Sensor_Type : 	STRUCT 
		Visibility : BOOL;
		Value : UINT;
	END_STRUCT;
	MainCounters_Type : 	STRUCT 
		PbResetMachineCounters : PB_Type;
		MachineCounters : MachineCounters_Type;
		PbResetCycleCounters : PB_Type;
		CycleCounters : TankCounters_Type;
		PbResetContainersCounters : PB_Type;
		ContainersCounters : ContainersCounters_Type;
		PbResetEcoEitCounters : PB_Type;
		EcoEitCounters : EcoEitCounters_Type;
	END_STRUCT;
	MachineCounters_Type : 	STRUCT 
		CapLaps : UDINT; (*Capper torret laps counter*)
		FlrLaps : UDINT; (*Filler laps counter*)
		RnsLaps : UDINT; (*Rinser laps counter*)
		PowerOnCycles : UDINT;
		PowerOnTime : CounterTime_Type;
		RotationTime : CounterTime_Type; (*Machine running hours counter*)
		StartTime : CounterTime_Type;
	END_STRUCT;
	ContainersCounters_Type : 	STRUCT 
		CapFault : UDINT;
		FlrBurst : UDINT;
		RnsFault : UDINT;
		FlrFault : UDINT;
		Ejected : UDINT;
		Entered : UDINT;
		Produced : UDINT;
		StartTime : CounterTime_Type;
	END_STRUCT;
	TankCounters_Type : 	STRUCT 
		ProductionCounter : UDINT;
		ProductionTime : CounterTime_Type;
		CipCounter : UDINT;
		CipTime : CounterTime_Type;
		StartTime : CounterTime_Type;
	END_STRUCT;
	EcoEitCounters_Type : 	STRUCT 
		ElectricalPowerKWH : REAL; (*[KWH]*)
		ElectricalPowerKVAR : REAL; (*[KVAR]*)
		StartTime : CounterTime_Type;
	END_STRUCT;
	HmiCounterData_Type : 	STRUCT 
		Description : STRING[25];
		Unit : STRING[8];
		PbReset : PB_Type;
		ConfigPresent : BOOL;
		ValuePresent : BOOL;
		TimePresent : BOOL;
		StartDatePresent : BOOL;
	END_STRUCT;
	CounterCfg_Type : 	STRUCT 
		MachineCounters : MachineCountersCfg_Type;
		ContainersCounters : ContainersCountersCfg_Type;
		ProcessCounters : ProcessCountersCfg_Type;
		EcoCounters : EcoCountersCfg_Type;
	END_STRUCT;
	CounterData_Type : 	STRUCT 
		MachineCounters : MachineCountersData_Type;
		ContainersCounters : ContainersCountersData_Type;
		ProcessCounters : ProcessCountersData_Type;
		EcoCounters : EcoCountersData_Type;
	END_STRUCT;
	HMI_CounterPage_Type : 	STRUCT 
		Partial : HMI_CounterPage2_Type;
		Total : HMI_CounterPage2_Type;
	END_STRUCT;
	HMI_CounterPage2_Type : 	STRUCT 
		Data : ARRAY[0..15]OF HmiCounterData_Type;
		Cfg : ARRAY[0..15]OF Counters_Type;
	END_STRUCT;
END_TYPE

(*Machine Counter*)

TYPE
	MachineCountersCfg_Type : 	STRUCT 
		HmiData : ARRAY[0..15]OF HmiCounterData_Type;
	END_STRUCT;
	MachineCountersData_Type : 	STRUCT 
		CounterData : ARRAY[0..15]OF Counters_Type;
	END_STRUCT;
END_TYPE

(*Containers Counter*)

TYPE
	ContainersCountersCfg_Type : 	STRUCT 
		HmiData : ARRAY[0..15]OF HmiCounterData_Type;
	END_STRUCT;
	ContainersCountersData_Type : 	STRUCT 
		CounterData : ARRAY[0..15]OF Counters_Type;
	END_STRUCT;
END_TYPE

(*Process Coutner*)

TYPE
	ProcessCountersCfg_Type : 	STRUCT 
		HmiData : ARRAY[0..15]OF HmiCounterData_Type;
	END_STRUCT;
	ProcessCountersData_Type : 	STRUCT 
		CounterData : ARRAY[0..15]OF Counters_Type;
	END_STRUCT;
END_TYPE

(*Eco Counter*)

TYPE
	EcoCountersCfg_Type : 	STRUCT 
		HmiData : ARRAY[0..15]OF HmiCounterData_Type;
	END_STRUCT;
	EcoCountersData_Type : 	STRUCT 
		CounterData : ARRAY[0..15]OF Counters_Type;
	END_STRUCT;
END_TYPE

(*FILLING VALVE*)

TYPE
	DummyContainerDataStructure_Type : 	STRUCT 
		FillingNozzle : USINT;
		DummyInstalled : BOOL; (*SHIFT master nuovo*)
		DummyNotInserted : BOOL;
		DummyRemoved : BOOL;
		DummyNotRemoved : BOOL;
	END_STRUCT;
	FillingValveDataStructure_Type : 	STRUCT 
		FillingDisabled : BOOL; (*SHIFT master nuovo*)
		ContainerBurst : BOOL;
		ContainerPresence : BOOL;
		PreClosingEnd : BOOL;
		WashingLapsEnd : BOOL;
		PreClosingCmdLap1 : BOOL;
		PreClosingCmdLap2 : BOOL;
		PreClosingCmdLap3 : BOOL;
		PreClosingCmdLap4 : BOOL;
		PreClosingCmdLap5 : BOOL;
		PreClosingCmdLap6 : BOOL;
		PreClosingCmdLap7 : BOOL;
		OperatorInspectionReq : BOOL;
		PreClosingActualLap : USINT;
		WashingLaps : USINT;
		ConsecutiveFillNotOk : USINT;
		AbsoluteFillNotOk : USINT;
		ConsecutiveBurst : USINT;
		AbsoluteBurst : USINT;
	END_STRUCT;
	HMI_SFT_BurstData_Type : 	STRUCT 
		ColorStatus : USINT;
		Counter : UINT;
	END_STRUCT;
END_TYPE

(*Sampling*)

TYPE
	HMI_SFT_SamplingMold_Type : 	STRUCT  (*V1.61*)
		Present : BOOL;
		Selected : BOOL;
	END_STRUCT;
END_TYPE
