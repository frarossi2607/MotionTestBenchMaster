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
		FlrToCipHeight : BOOL; (*v999*)
		Sector1DownToCip : BOOL; (*v999*)
		Sector2DownToCip : BOOL; (*v999*)
		Sector1DownToProd : BOOL; (*v999*)
		Sector2DownToProd : BOOL; (*v999*)
		Sector1OnlyRotToCip : BOOL;
		Sector2OnlyRotToCip : BOOL;
		Sector2OnlyRotToProd : BOOL;
		Sector1OnlyRotToProd : BOOL;
		DmcUpInProgress : BOOL;
		FillerReversePosReq : BOOL; (*v999*)
		FillerFirstHalfPosReq : BOOL; (*v999*)
		FirstHalfDisDmcControl : BOOL; (*v999*)
		FillerSecondHalfInserted : BOOL;
		FillerFirstHalfRemoved : BOOL;
		FillerFirstHalfInserted : BOOL;
		FillerSecondHalfRemoved : BOOL;
		SecondHalfDisDmcControl : BOOL; (*v999*)
		FirstHalfInsDmcControl : BOOL; (*V999*)
		ManualAirDischarge : BOOL; (*v999*)
		FmcPhasingReq : BOOL; (*v999*)
		FmcInOperational : BOOL; (*v999*)
		FirstHalfInstControl : BOOL; (*v999*)
		SecondHalfInsDmcControl : BOOL; (*v999*)
		FillerSecondHalfPosReq : BOOL; (*v999*)
		FillerSecondReversePosReq : BOOL; (*v999*)
		SectorDiscargePressure : BOOL; (*v999*)
		ContainerLiftAirDischarge : BOOL;
		ManualModeEnableSec2 : BOOL;
		ManualModeEnableSec1 : BOOL;
		DmcManualOperationEn : BOOL; (*V4.A.A.1.7.1*)
		Dba_Sector2ManDownReq : BOOL;
		Dba_Sector1ManDownReq : BOOL;
		ManModeDisControlSec1 : BOOL;
		CycleFmcInError : BOOL;
		CycleAborted : BOOL;
		ReducePressureToUp : BOOL;
		TankCammaToProdHeight : BOOL;
		ManModeDisControlSec2 : BOOL;
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

(*SCHEDULER //v1.7.4*)

TYPE
	MAU_Scheduler_Type : 	STRUCT 
		DataOut : MAU_Scheduler_DataOut_Type;
	END_STRUCT;
	MAU_Scheduler_DataOut_Type : 	STRUCT 
		AlarmMSInternal : UINT;
		AlarmCSRInternal : UINT;
		AlarmCSAInternal : UINT;
		AlarmMSExternal : UINT;
		AlarmCSRExternal : UINT;
		AlarmCSRExternalDw : UINT;
		AlarmCSAExternal : UINT;
		AlarmCSAExternalDw : UINT;
		AlarmInternalOMAC : UINT; (*V1.7.4*)
		AlarmExternalOMAC : UINT; (*V1.7.4*)
	END_STRUCT;
END_TYPE
