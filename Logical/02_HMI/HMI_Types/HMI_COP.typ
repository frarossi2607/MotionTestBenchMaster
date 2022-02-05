
TYPE
	HMI_COP_StatusWidget_Type : 	STRUCT 
		Running : BOOL;
		RemaningTime : DINT;
		Mode : INT; (*0: Idle
1: Rinse
2: Rinse hot
3: Wait
4: Foam 1
5: Foam 2
6: Foam 3
10: High speed
11: Emptying with air (purge)
20: Manual*)
	END_STRUCT;
	HMI_COP_ZoneCfg_Type : 	STRUCT 
		Present : BOOL;
		Name : STRING[15];
	END_STRUCT;
	HMI_COP_Rcp_Type : 	STRUCT 
		Phase : ARRAY[0..CST_COP_PhaseMaxNr]OF HMI_COP_RcpPhase_Type;
	END_STRUCT;
	HMI_COP_RcpSelection_Type : 	STRUCT 
		ConfigPresent : BOOL;
		Selected : BOOL;
		Enable : BOOL := TRUE;
		Name : STRING[150];
	END_STRUCT;
	HMI_COP_RcpPhase_Type : 	STRUCT 
		PhaseType : USINT;
		Time_SP : UINT;
		PumpPressure_SP : REAL;
		WaterPressure_SP : REAL;
		AirPressure_SP : REAL;
		ValveOpening_SP : REAL;
		Custom01 : REAL;
		Valves_Configuration : UDINT;
	END_STRUCT;
	HMI_COP_RcpInfo_Type : 	STRUCT 
		Rcp : HMI_COP_RcpInfoRcp_Type;
		Phase : HMI_COP_RcpInfoPhase_Type;
	END_STRUCT;
	HMI_COP_RcpInfoRcp_Type : 	STRUCT 
		Name : STRING[150];
		PhaseNr : USINT;
		TimeAct : UDINT;
		TimePreset : UDINT;
		TimeRemaining : UDINT;
	END_STRUCT;
	HMI_COP_RcpInfoPhase_Type : 	STRUCT 
		Nr : USINT;
		Type : USINT;
		TimeAct : UDINT;
		TimePreset : UDINT;
		TimeRemaining : UDINT;
	END_STRUCT;
	HMI_COP_State_Type : 	STRUCT 
		Sequencer : Seq_Type; (*Step Actual*)
		Signals : Signals_Type;
	END_STRUCT;
	HMI_COP_ITC_Type : 	STRUCT 
		In : HMI_COP_ITC_In_Type;
		Out : HMI_COP_ITC_Out_Type;
	END_STRUCT;
	HMI_COP_ITC_In_Type : 	STRUCT 
		CycleActive : BOOL;
		CycleEnded : BOOL;
		Alarm : BOOL;
	END_STRUCT;
	HMI_COP_ITC_Out_Type : 	STRUCT 
		ReadyForFoaming : BOOL;
		Alarm : BOOL;
	END_STRUCT;
END_TYPE
