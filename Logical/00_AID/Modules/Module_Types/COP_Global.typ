(*COP*)

TYPE
	COP_Type : 	STRUCT 
		DataOut : COP_DataOut_Type;
	END_STRUCT;
	COP_DataOut_Type : 	STRUCT 
		RcpActive : BOOL;
		RcpRunning : BOOL;
		RcpDone : BOOL;
		CleaningActive : BOOL;
		CircuitFeeding : BOOL;
		CircuitDrain : BOOL;
		ContainerStop : BOOL;
		RcpManual : BOOL;
		FoamingGunActive : BOOL;
		CapBufferHighSpeedReq : BOOL;
		CapBufferEmptyingReq : BOOL;
		CapChannelEmptyingReq : BOOL;
		CapBufferLiftingReq : BOOL;
		CapBufferLoweringReq : BOOL;
		FixSpeedRequest : BOOL;
		FixSpeedValue : REAL;
		TransferGateCloseReq : BOOL;
		WashingPrdEnable : BOOL;
		WashingPrdNekRinse : BOOL;
		WashingPrdAfterCop : BOOL;
		DisableFillingBottle : BOOL; (*vrmaCOP*)
		CvrEmptyingReq : BOOL;
		DmcInsercionReq : BOOL;
		DmcDisinsercionReq : BOOL;
		MachineStart : BOOL;
		MachineStop : BOOL;
		DmcEnabled : BOOL;
		SmfCleaningValveV : ARRAY[3..10]OF BOOL;
		FlrToProductionHeight : BOOL; (*MASTER NUovo*)
		FlrToMaxMechanicalHeight : BOOL; (*MASTER NUovo*)
		Idle : BOOL;
		ValveWashingCfg : BOOL;
		WashingTray : BOOL;
		SamplingCommand : BOOL;
		SamplingInPosition : BOOL;
		RcpAfterCipEndCfg : BOOL;
		DoserPositioningReq : BOOL; (*v999hema*)
		CopDuringChangeFormatActive : BOOL; (*vrmaCOP*)
		CopValvePurge : BOOL; (*vrmaCOP*)
		CopWipInExecution : BOOL; (*vrmaCOP*)
		CopWashingBeforePurge : BOOL; (*vrmaCOP*)
		CopLapsCounter : BOOL; (*vrmaCOP*)
		CopConAirBlowOffCommand : BOOL; (*vrmaCOP*)
		CopBottleBurstRamp1 : BOOL; (*vrmaCOP*)
		CopPhaseType : USINT;
	END_STRUCT;
END_TYPE
