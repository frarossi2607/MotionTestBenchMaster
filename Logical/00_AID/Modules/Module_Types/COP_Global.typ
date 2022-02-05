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
		ContainerStop : BOOL; (*//1.63*)
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
		WashingPrdAfterCop : BOOL;
		CvrEmptyingReq : BOOL;
		DmcInsercionReq : BOOL; (*V4.A.A.1.7.0*)
		DmcDisinsercionReq : BOOL; (*V4.A.A.1.7.0*)
		MachineStart : BOOL; (*V4.A.A.1.7.0*)
		MachineStop : BOOL; (*V4.A.A.1.7.0*)
		DmcEnabled : BOOL; (*V4.A.A.1.7.0*)
		SmfCleaningValveV : ARRAY[3..10]OF BOOL;
		FlrToProductionHeight : BOOL;(*MASTER NUovo*)
		FlrToMaxMechanicalHeight : BOOL;(*MASTER NUovo*)
		Idle : BOOL; (*v1.4*)
		ValveWashingCfg : BOOL; (*v1.6*)
		WashingTray : BOOL; (*v1.6*)
		SamplingCommand : BOOL; (*v1.6*)
		SamplingInPosition : BOOL; (*v1.6*)
	END_STRUCT;
END_TYPE
