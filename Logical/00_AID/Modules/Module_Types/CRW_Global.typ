
TYPE
	CRW_Config_Type : 	STRUCT 
		Channel1 : BOOL;
		Channel2 : BOOL;
		PickAndPlace : UINT;
		Hopper1 : REAL;
		Hopper2 : REAL;
	END_STRUCT;
	CRW_Mode_Type : 
		(
		CRW_Idle,
		CRW_Production,
		CRW_ProductionReady,
		CRW_Emptying
		);
END_TYPE

(*CROWNER*)

TYPE
	CRW_Type : 	STRUCT 
		DataOut : CRW_DataOut_Type;
	END_STRUCT;
	CRW_DataOut_Type : 	STRUCT 
		ReleaseInProduction : BOOL;
		ReleaseInEmptying : BOOL;
		ReleaseInManual : BOOL;
		SlowSpeedForEmptyReq : BOOL;
		ConfigSaveReq : BOOL;
		HeadRinsingReq : BOOL;
		ContainerStop : BOOL;
		Idle : BOOL;
		MachineStart : BOOL; (*vrmaCOP*)
		ChannelEmptyingReq : BOOL; (*vrmaCOP*)
		ChannelEmpty : BOOL; (*vrmaCOP*)
	END_STRUCT;
END_TYPE
