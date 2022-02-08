
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
	SEQ_Step_Type : 	STRUCT 
		Jump : ARRAY[0..MAX_JUMP_CFG]OF SEQ_Jump_Type;
		Config : SEQ_StepConfig_Type;
	END_STRUCT;
	SEQ_Jump_Type : 	STRUCT 
		Condition : BOOL;
		Number : UINT;
	END_STRUCT;
	ActionReq_Type : 	STRUCT 
		Req : BOOL;
		Done : BOOL;
	END_STRUCT;
END_TYPE

(*DEVICES*)

TYPE
	SEQ_Module_Type : 	STRUCT 
		Device : SEQ_Device_Type;
		Mem : SEQ_Mem_Type;
		ITC : SEQ_Itc_Type;
	END_STRUCT;
	SEQ_Mem_Type : 	STRUCT 
		ContainersStop : BOOL; (*Containers Stop Control (1 = Stop)*)
		MachineStart : BOOL;
		MachineStop : BOOL;
		DummyBottles : BOOL; (*Dummy Bottle Install*)
		PositioningRequest : BOOL; (*Request of Cam Positioning at height SP of Sequncer*)
		COP_Cycle : BOOL; (*Cycle of COP Active*)
		DosingOn : BOOL; (*Dosing*)
		LapsCounter : BOOL; (*Laps Conter Req*)
		ValveOpening : BOOL;
		CopAfterCipRequest : BOOL; (*Request of COP after CIP end*)
		PBAbortEnable : BOOL; (*PB Abort Sequence Enable*)
		PBStopEnable : BOOL; (*PB Stop Sequence Enable*)
		PBStartEnable : BOOL; (*PB Start Sequence Enable*)
	END_STRUCT;
	SEQ_Device_Type : 	STRUCT 
		AVJ201 : Valve_Cmd_Type;
		AVJ210 : Valve_Cmd_Type;
		AVJ211 : Valve_Cmd_Type;
		AVJ212 : Valve_Cmd_Type;
		AVJ215 : Valve_Cmd_Type;
		AVJ216 : Valve_Cmd_Type;
		AVJ217 : Valve_Cmd_Type;
		AVJ218 : Valve_Cmd_Type;
		AVJ221 : Valve_Cmd_Type;
		AVJ230 : Valve_Cmd_Type;
		AVJ231 : Valve_Cmd_Type;
		AVJ232 : Valve_Cmd_Type;
		AVJ233 : Valve_Cmd_Type;
		AVJ234 : Valve_Cmd_Type;
		AVJ235 : Valve_Cmd_Type;
		RVJ201_PID : PID_Type;
		PPJ201_PID : PID_Type;
		PPJ202_PID : PID_Type;
		PPJ203_PID : PID_Type;
		MMJ201_PID : PID_Type;
		LSJ200 : Digital_In_Type;
		LSJ201 : Digital_In_Type;
		LSJ202 : Digital_In_Type;
		FSJ201 : Digital_In_Type;
		FSJ202 : Digital_In_Type;
		LTJ203 : Analog_In_Type;
		TTJ203 : Analog_In_Type;
	END_STRUCT;
	SEQ_Itc_Type : 	STRUCT 
		CIP_CleaningMode : BOOL; (*To CIP -> Filler in Mode Cip*)
		CIP_CleaningRequest : BOOL; (*To CIP -> Request of Solution Sending*)
		CIP_Alarm : BOOL; (*To CIP -> Critical Alarm Present*)
		CIP_RinseEnded : BOOL; (*To CIP -> Rinse Finished*)
		CIP_ChangeEnded : BOOL; (*To CIP -> Change Finished*)
		CIP_DrainRunning : BOOL; (*To CIP -> Drain Cycle Running*)
		CIP_RinseRunning : BOOL; (*To CIP -> Rinse Cycle Running*)
		CIP_CleaningRunning : BOOL; (*To CIP -> Cleaning Cycle Running*)
		CIP_DrainEnded : BOOL; (*To CIP -> Drain Finished*)
		CIP_FloodingEnded : BOOL; (*To CIP -> Drain Finished*)
		CIP_FlipEnable : BOOL; (*To CIP -> Drain Finished*)
		CIP_CycleEnded : BOOL; (*To CIP -> Drain Finished*)
		PROD_ReadyForHeating : BOOL; (*To PASTO-> Filler Ready for Production (Heating)*)
		PROD_DoserInTemperature : BOOL; (*To PASTO-> Filler Temperature OK (After Heating)*)
		PROD_ProductRequest : BOOL; (*To PASTO-> Product Request *)
		PROD_DoserOnFillingMode : BOOL; (*To PASTO-> Product Consumend -Filling Valve Opening*)
		PROD_EndProductionCompleted : BOOL; (*To PASTO-> End Production Done*)
		PROD_ProductRecoveryEnd : BOOL; (*To PASTO-> Product Recovery End*)
		PROD_WaterRequestAfterProd : BOOL; (*To PASTO-> Water Request For Filler Rinse Afetr Production*)
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
	Valve_Cmd_Type : 	STRUCT 
		AutoCnd : BOOL;
		EnableCnd : BOOL;
		FlipGroup : UINT;
	END_STRUCT;
	Motor_Cmd_Type : 	STRUCT 
		AutoCnd : BOOL;
	END_STRUCT;
	DOS_ValveFlip_Type : 	STRUCT 
		Config : BOOL; (*Flip Sequence Configured*)
		Request : BOOL; (*Flip Sequence Request to Valve*)
		Executed : BOOL; (*Flip Sequence Done by Valve*)
		Done : BOOL; (*Flip Sequence Done Memory*)
		SequenceDone : BOOL; (*Flip Sequence Completed*)
		TimeDelay_SP : REAL; (*Next Flip Sequence Delay*)
		TimeDelay_PV : REAL; (*Next Flip Sequence Delay Elapsed*)
	END_STRUCT;
END_TYPE
