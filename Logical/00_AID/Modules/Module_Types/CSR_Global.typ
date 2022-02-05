(*CSR*)

TYPE
	CSR_Type : 	STRUCT 
		DataOut : CSR_DataOut_Type;
	END_STRUCT;
	CSR_DataOut_Type : 	STRUCT 
		AutoSizeChangeActive : BOOL; (*MASTER NUovo*)
		Active : BOOL;
		CipPosition : BOOL;
		ProductionPosition : BOOL;
		LiftingEnableSafetyRequ : BOOL;
		SkfStop : BOOL;
		SkfStart : BOOL;
		Idle : BOOL; (*v1.4*)
		ContainerStop : BOOL; (*//1.63*)
		PositioningInProgress : BOOL; (*V4.A.A.1.6.12*)
		PositioningDone : BOOL; (*V4.A.A.1.6.12*)
		CrwPositioningReq : BOOL; (*V4.A.A.1.7.0*)
		CapPositioningReq : BOOL; (*V4.A.A.1.7.0*)
		MachineStop : BOOL; (*V4.A.A.1.7.0*)
		SkfTargetPosition : REAL;
		CapperPositionUncoupled : BOOL; (*MASTER NUovo*)
		FlrToMaxMechanicalHeightDone : BOOL; (*MASTER NUovo*)
		FlrPrdPositionHeightDone : BOOL; (*MASTER NUovo*)
	END_STRUCT;
END_TYPE

(*SKF_SCU*)

TYPE
	SKF_SCU_Type : 	STRUCT 
		DataOut : SKF_SCU_DataOut_Type;
	END_STRUCT;
	SKF_SCU_DataOut_Type : 	STRUCT 
		Actuator_1_Position : REAL; (*Actuator 1 position [mm]*)
		Actuator_2_Position : REAL; (*Actuator 2 position [mm]*)
		Actuator_3_Position : REAL; (*Actuator 3 position [mm]*)
		Actuator_Position_Offset : REAL; (*Offset --> Difference from Real Position and Actuator Position [mm]*)
		Running : BOOL;
		InitializationDone : BOOL;
		Idle : BOOL; (*v1.4*)
	END_STRUCT;
	CSR_Lift_SeqMode_Type : 
		(
		CSR_LiftIdle,
		CSR_LiftBottlesStop,
		CSR_LiftMachineStop,
		CSR_LiftRaiseMaximumHeight,
		CSR_LiftNewSize,
		CSR_LiftDescentSizeHeight,
		CSR_LiftWaitSelectorOff,
		CSR_LiftManualMode
		);
	CSR_Sequencer_Type : 
		(
		CSR_Idle := 0,
		CSR_WaitSafetyEnable := 205,
		CSR_SizeChangeHeightRequ := 210,
		CSR_SizeChangeHeightDone := 220,
		CSR_SizeChangeProdHeightRequ := 222,
		CSR_SizeChangeProdHeightDone := 240,
		CSR_ManualWaitSafetyEnable := 605,
		CSR_ManualMode := 606,
		CSR_ManualModeTank := 610,
		CSR_ManualModeCamma := 620,
		CSR_MaxMechanicalHeightRequ := 621,
		CSR_MaxMechanicalHeightDone := 622,
		CSR_Fault := 9999
		);
END_TYPE
