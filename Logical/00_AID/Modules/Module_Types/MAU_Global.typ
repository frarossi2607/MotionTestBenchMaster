(*SafetyCheck*)

TYPE
	SafeLogicStatus_Type : 	STRUCT 
		FailSafe : BOOL;
		FirmwareAcknowledge : BOOL;
		NoExecution : BOOL;
		RunDebug : BOOL;
		RunSafe : BOOL;
		SafeKeyExchange : BOOL;
		Scan : BOOL;
		ModuleExchange : UINT;
		ModuleMissing : UINT;
	END_STRUCT;
END_TYPE

(*DUMMY CONTAINERS*)

TYPE
	MAU_DumCon_Type : 	STRUCT 
		DataOut : MAU_DumCon_DataOut_Type;
	END_STRUCT;
	MAU_DumCon_DataOut_Type : 	STRUCT 
		Idle : BOOL;
		InstallDone : BOOL;
		RemoveDone : BOOL;
		FixSpeedRequest : BOOL;
		MachineStart : BOOL;
		MachineStop : BOOL;
		CounterEnable : BOOL;
		FmcCipMode : BOOL;
		InsControl : BOOL;
		DisControl : BOOL;
		InsertionPistonFault : BOOL;
		DmcInsCsrPositioning : BOOL;
		DmcDisCsrPositioning : BOOL;
		LftCenteringCupUp : BOOL;
		LftCenteringCupDownOnCip : BOOL;
		ContainerStop : BOOL; (*//1.63*)
		DmcManualModeActive : BOOL; (*v1.6*)
		DmcManualOperationEn : BOOL; (*V4.A.A.1.7.1*)
	END_STRUCT;
END_TYPE

(*LIFT CONTAINERS*)

TYPE
	MAU_LftCon_Type : 	STRUCT 
		DataOut : MAU_LftCon_DataOut_Type;
	END_STRUCT;
	MAU_LftCon_DataOut_Type : 	STRUCT 
		LiftContainerUp : BOOL := TRUE;
		CenteringCupUp : BOOL;
		CenteringCupDownOnCip : BOOL;
		CenteringCupAirOn : BOOL := TRUE;
		CenteringCupUpTime : UINT;
		WaterReq : BOOL;
	END_STRUCT;
END_TYPE

(*TRAY*)

TYPE
	MAU_Tray_Type : 	STRUCT  (*v1.4*)
		DataOut : MAU_Tray_DataOut_Type;
	END_STRUCT;
	MAU_Tray_DataOut_Type : 	STRUCT  (*v1.4*)
		ContainerStop : BOOL; (*//1.63*)
		TrayInPosition : BOOL;
	END_STRUCT;
END_TYPE

(*UPS*)

TYPE
	MAU_Ups_Type : 	STRUCT 
		DataOut : MAU_Ups_DataOut_Type;
	END_STRUCT;
	MAU_Ups_DataOut_Type : 	STRUCT 
		PowerOffTime : UINT;
	END_STRUCT;
END_TYPE

(*AUX  V1.7.2*)

TYPE
	MAU_Aux_Type : 	STRUCT 
		DataOut : MAU_Aux_DataOut_Type;
	END_STRUCT;
	MAU_Aux_DataOut_Type : 	STRUCT 
		ContainerStop : BOOL;
		EjectionRequest : BOOL;
	END_STRUCT;
END_TYPE
