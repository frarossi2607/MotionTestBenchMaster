(*FLAVOR DOSER*)

TYPE
	DOS_Type : 	STRUCT 
		DataOut : DOS_DataOut_Type;
	END_STRUCT;
	DOS_DataOut_Type : 	STRUCT  (*v999hema*)
		FillingHeatingProd : BOOL;
		FillingProd : BOOL;
		WaitMode : BOOL;
		ProdMode : BOOL;
		ProductRequest : BOOL;
		ProductionEnd : BOOL;
		ReadyForHeating : BOOL;
		DoserFull : BOOL;
		AVJ201Open : BOOL;
		DoserEmpty : BOOL;
		DoserInTemperature : BOOL;
		RecoveryEnd : BOOL;
		EjectionRequest : BOOL;
		HotWaterReq : BOOL;
		NecessaryBottleEndProd : REAL;
		CipMode : BOOL;
		CipConditionOk : BOOL;
		CipSolutionReq : BOOL;
		CipRecovery : BOOL;
		CipRecoveryEnd : BOOL;
		CipAlarm : BOOL;
		RinseEnd : BOOL;
		RinseReq : BOOL;
		CipDrainEnd : BOOL;
		CipLevelReached : BOOL;
		CipSystemFlooded : BOOL;
		RinseAfterProdReq : BOOL;
		RinseMode : BOOL;
		RinseAfterProdEnd : BOOL;
		DrainMode : BOOL;
		CopMode : BOOL;
		CopAfterCipReq : BOOL;
		CopRunning : BOOL;
		AromePodReq : BOOL;
		MachineStart : BOOL;
		MachineStop : BOOL;
		DoserExcluded : BOOL;
		DoserIncluded : BOOL;
		ByPassed : BOOL;
		AxisEnableRequest : BOOL;
		AxisDisableRequest : BOOL;
		FillerAxisDisableRequest : BOOL;
		StepCounterRequest : BOOL;
		FixSpeedRequest : BOOL;
		PositionReached : BOOL;
		CommandToValve : BOOL;
		FixSpeedValue : REAL;
		FillerProdStartEnable : BOOL;
		FillerCipStartEnable : BOOL;
		FillerRinseStartEnable : BOOL;
		PhasingWithDos : BOOL;
		PhasingWithoutDos : BOOL;
	END_STRUCT;
END_TYPE
