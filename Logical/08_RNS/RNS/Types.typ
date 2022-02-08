
TYPE
	SEQ_Type : 	STRUCT 
		Step : ARRAY[0..MAX_STEP_CFG]OF SEQ_Step_Type;
		ModeActual : UINT;
		StepActual : UINT;
		TON_Time_END : BOOL;
		T_Time_END : BOOL;
		TO_Time_END : BOOL;
		Laps_Done : BOOL;
		Cycles_Done : BOOL; (*All Cycles Done*)
	END_STRUCT;
	SEQ_Step_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		Jump : ARRAY[0..MAX_JUMP_CFG]OF SEQ_Jump_Type;
		Config : SEQ_StepConfig_Type;
	END_STRUCT;
	SEQ_Jump_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		Condition : BOOL;
		Number : UINT;
	END_STRUCT;
	VAR_RNS_SeqActualStep_Type : 
		( (*V4.A.A.1.7.0*)
		RNS_SeqWait := 0,
		RNS_SeqPrdPriming := 5,
		RNS_SeqPrdPrimingTimeOut := 6,
		RNS_SeqSystemWaitCon := 7,
		RNS_SeqSystemOnTreatment := 11,
		RNS_SeqSystemTreatmentAlr := 26,
		RNS_SeqDrain := 22,
		RNS_SeqDrainDone := 23,
		RNS_SeqCip := 24, (*v1.4*)
		RNS_SeqCop := 25, (*v1.4*)
		RNS_SeqCipStopped := 30, (*v1.4*)
		RNS_SeqControl := 70, (*V4.A.A.1.7.0*)
		RNS_SeqBypass := 90, (*V4.A.A.1.7.0*)
		RNS_SeqStopped := 40
		);
END_TYPE

(*DEVICES*)

TYPE
	SEQ_Module_Type : 	STRUCT 
		Device : SEQ_Device_Type;
		Mem : SEQ_Mem_Type;
		ITC : SEQ_ITC_Type;
	END_STRUCT;
	SEQ_Mem_Type : 	STRUCT 
		ContainersStop : BOOL; (*Containers Stop Control (1 = Stop)*)
		ByPassRequest : BOOL; (*Rincer ByPass Request*)
		ByPassed : BOOL; (*Rincer ByPassed*)
		WaterTreatmentControl : BOOL; (*Water Spray Continous Mode*)
		AirTreatmentControl : BOOL; (*Air Spray Control Mode*)
		ControlInsercion : BOOL; (*Spray Control Insercion Mode*)
		ControlContinous : BOOL; (*Spray Control Continous Mode*)
		InsercionDevice : BOOL; (*Spray Control Device insercion Request*)
		SpeedReductionControl : BOOL; (*Spray Control Device insercion Request*)
		CopAfterCipRequest : BOOL; (*Cop Request After CIP*)
		PBAbortEnable : BOOL; (*PB Abort Sequence Enable*)
		PBStopEnable : BOOL; (*PB Stop Sequence Enable*)
		PBStartEnable : BOOL; (*PB Start Sequence Enable*)
		NoBoNoSprayInsercion : BOOL; (*No Bottle No Spray Insercion Device for Priming Nozle Rma tes*)
	END_STRUCT;
	SEQ_Device_Type : 	STRUCT 
		AVB224 : Valve_Cmd_Type;
		AVB228 : Valve_Cmd_Type; (*V4.A.A.1.7.0*)
		AVB234 : Valve_Cmd_Type; (*vrma*)
		AVB261 : Valve_Cmd_Type;
		AVB264 : Valve_Cmd_Type; (*V4.A.A.1.7.0*)
		AVB265 : Valve_Cmd_Type; (*V4.A.A.1.7.0*)
		AVB266 : Valve_Cmd_Type; (*V4.A.A.1.7.0*)
		AVB267 : Valve_Cmd_Type; (*v1.4*)
		AVB268 : Valve_Cmd_Type; (*v1.4*)
		AVB273 : Valve_Cmd_Type; (*V4.A.A.1.7.0*)
		AVB294 : Valve_Cmd_Type;
		PPB209 : Seq_Motor_Type; (*v1.4*)
		RVB202_PID : PID_Type; (*V4.A.A.1.7.0*)
		PPB209_PID : PID_Type; (*v1.4*)
		LSB209 : Digital_In_Type; (*v1.4*)
		LSB210 : Digital_In_Type; (*v1.4*)
		LSB299 : Digital_In_Type; (*v1.4*)
		LTB202 : Analog_In_Type; (*vrma*)
		FSB201 : Digital_In_Type;
		FSB220 : Digital_In_Type;
		FTB201 : Analog_In_Type; (*v1.4*)
		FTB202 : Analog_In_Type; (*V4.A.A.1.7.0*)
		PTB220 : Analog_In_Type; (*V4.A.A.1.7.0*)
		PTB270 : Analog_In_Type; (*V4.A.A.1.7.0*)
		PTB290 : Analog_In_Type;
	END_STRUCT;
	SEQ_ITC_Type : 	STRUCT 
		WTT_ProductRequest : BOOL; (*Production Mode Active*)
		WTT_ProductionRunning : BOOL; (*Filler Inlet Open - Start/Stop Overpressure Pump*)
	END_STRUCT;
	Analog_In_Type : 	STRUCT 
		ALR_HighLimitEn : BOOL;
		ALR_HighLimitSP : REAL;
		ALR_LowLimitEn : BOOL;
		ALR_LowLimitSP : REAL;
		SP : REAL;
		CMP : USINT;
		MinDev : REAL;
		MaxDev : REAL;
	END_STRUCT;
	Digital_In_Type : 	STRUCT 
		ALR : BOOL;
		WAIT_ON : BOOL;
		WAIT_OFF : BOOL;
	END_STRUCT;
	PID_Type : 	STRUCT 
		PID_Enable : BOOL; (*PID Enable Condition*)
		PID_Mode : BOOL; (*PID Mode (1 = Auto - 0 = Manual)*)
		Auto_SP_Value : REAL;
		Auto_SP_MinDev : REAL;
		Auto_SP_MaxDev : REAL;
		FIX_Value : REAL;
	END_STRUCT;
	Seq_Motor_Type : 	STRUCT 
		IN_Auto : BOOL; (*PID Enable Condition*)
		IN_AutoSP : REAL;
		IN_FixOut : BOOL;
		IN_FixOutValue : REAL;
	END_STRUCT;
	Valve_Cmd_Type : 	STRUCT 
		AutoCnd : BOOL;
		EnableCnd : BOOL;
	END_STRUCT;
	Motor_Cmd_Type : 	STRUCT 
		AutoCnd : BOOL;
	END_STRUCT;
END_TYPE
