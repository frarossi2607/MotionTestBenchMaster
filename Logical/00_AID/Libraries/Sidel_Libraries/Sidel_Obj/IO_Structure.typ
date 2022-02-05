(*VALVES*)

TYPE
	IO_Valve_Mod_Type : 	STRUCT 
		AO_Raw : INT;
		AI_Raw : INT;
		Valve : IO_Valve_Type;
	END_STRUCT;
	IO_ValveMac_Type : 	STRUCT 
		DI_PowerSupplyPhyChannelOk : BOOL;
		DI_Opened : BOOL; (*DI Valve Open - Feedback*)
		DI_Closed : BOOL; (*DI Valve Close - Feedback*)
		DO_Opened : BOOL; (*DO Valve Open*)
		DO_Closed : BOOL; (*DO Valve Close*)
	END_STRUCT;
	IO_Valve_Type : 	STRUCT 
		DI_Opened : BOOL; (*DI Valve Open - Feedback*)
		DI_Closed : BOOL; (*DI Valve Close - Feedback*)
		DO_Opened : BOOL; (*DO Valve Open*)
		DO_Closed : BOOL; (*DO Valve Close*)
	END_STRUCT;
END_TYPE

(*MOTORS*)

TYPE
	IO_Motor_FwBw_Type : 	STRUCT  (*Motor control Forward Backward*)
		DI_SafetyEnable : BOOL; (*Safety Enable from IOMapping*)
		DI_SafetyFault : BOOL; (*Safety Feed-Back from Safety CPU*)
		DI_Fault : BOOL;
		DI_ContactorFBK : BOOL; (*Contactor Feed-Back *)
		DI_OverloadOK : BOOL := TRUE; (*Not present in case of UL*)
		DI_ManSwitchON : BOOL := TRUE;
		DO_MotorFw : BOOL; (*Start Forward*)
		DO_MotorBw : BOOL; (*Start Backward*)
	END_STRUCT;
	IO_MotorFC280_Type : 	STRUCT  (*Motor control*)
		DI_SafetyEnable : BOOL; (*Safety Enable from IOMapping*)
		DI_SafetyFault : BOOL; (*Safety Feed-Back from Safety CPU*)
		DI_ManSwitchON : BOOL := TRUE;
		DI_ContactorFBK : BOOL; (*Contactor Feed-Back *)
		DI_OverloadOK : BOOL := TRUE; (*Not present in case of UL*)
		DO_MotorON : BOOL; (*Start*)
		DO_ShuntTrip : BOOL; (*Thermal Protection Forced Trip*)
	END_STRUCT;
	IO_Motor_Type : 	STRUCT  (*Motor control*)
		DI_SafetyEnable : BOOL; (*Safety Enable from IOMapping*)
		DI_SafetyFault : BOOL; (*Safety Feed-Back from Safety CPU*)
		DI_ManSwitchON : BOOL := TRUE;
		DI_ContactorFBK : BOOL; (*Contactor Feed-Back *)
		DI_OverloadOK : BOOL := TRUE; (*Not present in case of UL*)
		DO_MotorON : BOOL; (*Start*)
		DO_ShuntTrip : BOOL; (*Thermal Protection Forced Trip*)
	END_STRUCT;
	IO_UVtronic_Type : 	STRUCT  (*Henovia UV control*)
		DI_SafetyEnable : BOOL; (*Safety Enable from IOMapping*)
		DI_Ready : BOOL;
		DI_Alarm : BOOL;
		DI_GeneralFault : BOOL;
		DI_ContactorFBK : BOOL; (*Contactor Feed-Back *)
		DI_OverloadOK : BOOL := TRUE; (*Not present in case of UL*)
		DO_MotorON : BOOL; (*Start*)
	END_STRUCT;
	IO_PLK_DanfossFC280_Drive_Type : 	STRUCT  (*Powerlink Danfoss VLT Interface*)
		Input : IO_PLK_DanfossFC280_IN;
		Output : IO_PLK_DanfossFC280_OUT;
	END_STRUCT;
	IO_PLK_Danfoss_Drive_Type : 	STRUCT  (*Powerlink Danfoss VLT Interface*)
		Input : IO_PLK_Danfoss_IN;
		Output : IO_PLK_Danfoss_OUT;
	END_STRUCT;
	IO_PLK_DanfossFC280_IN : 	STRUCT  (*Powerlink Danfoss VLT Inputs*)
		STW : UINT; (*Status Word*)
		MAV : INT; (*Main Actual Value*)
		ActFreq : UDINT; (*Actual Frequency [Hz]*)
		ActCurrent : UINT; (*Actual Current [A]*)
		Power : UDINT; (*Power [kW]*)
		Torque : DINT; (*Torque [Nm]*)
		SpeedRPM : DINT; (*Speed [RPM]*)
		STW_EX : UDINT; (*Extended Status Word 1*)
		ErrorCode : UDINT; (*Error Code 1*)
		DigitalInput : UINT; (*Digital Input V4.A.A.1.6.13*)
	END_STRUCT;
	IO_PLK_Danfoss_IN : 	STRUCT  (*Powerlink Danfoss VLT Inputs*)
		STW : UINT; (*Status Word*)
		MAV : INT; (*Main Actual Value*)
		ActFreq : UINT; (*Actual Frequency [Hz]*)
		ActCurrent : DINT; (*Actual Current [A]*)
		Power : DINT; (*Power [kW]*)
		Torque : INT; (*Torque [Nm]*)
		SpeedRPM : DINT; (*Speed [RPM]*)
		STW_EX : UDINT; (*Extended Status Word 1*)
		ErrorCode : UDINT; (*Error Code 1*)
		DigitalInput : UINT; (*Digital Input V4.A.A.1.6.13*)
	END_STRUCT;
	IO_PLK_DanfossFC280_OUT : 	STRUCT  (*Powerlink Danfoss VLT Outputs*)
		CTW : UINT; (*Control Word*)
		MRW : INT; (*Main Reference Value*)
	END_STRUCT;
	IO_PLK_Danfoss_OUT : 	STRUCT  (*Powerlink Danfoss VLT Outputs*)
		CTW : UINT; (*Control Word*)
		MRW : INT; (*Main Reference Value*)
	END_STRUCT;
	IO_FanMain_Type : 	STRUCT 
		DI_OverloadOK : BOOL := TRUE;
		DO_ZoneLighting : BOOL; (*V4.A.A.1.7.0*)
		Pressurizer : ARRAY[1..6]OF IO_Pressurizer_Type;
		GalvaniRoof : IO_GalvaniRoof_Type;
	END_STRUCT;
	IO_PressurizerMain_Type : 	STRUCT 
		DI_OverloadOK : BOOL := TRUE;
		Pressurizer : ARRAY[1..6]OF IO_Pressurizer_Type;
	END_STRUCT;
	IO_GalvaniRoof_Type : 	STRUCT 
		DI_Running : BOOL;
		DI_AbsoluteFilterAlarm : BOOL;
		DI_PrefilterExtAlarm : BOOL;
		DI_PrefilterIntAlarm : BOOL;
		DI_CabinetPoweredOn : BOOL;
		DO_Start : BOOL;
		DO_FlowSet : BOOL;
		DO_LightingArea_1 : BOOL;
		DO_LightingArea_2 : BOOL;
	END_STRUCT;
	IO_Pressurizer_Type : 	STRUCT 
		DO_Lighting : BOOL;
		AO_Raw : INT;
		DI_PressurizerON : BOOL; (*Pressurizzer ON*)
		DI_PrefilterAlarm : BOOL; (*Pressurizzer prefilter clogged*)
		DI_AbsoluteFilterAlarm : BOOL; (*Pressurizzer absolute filter clogged*)
	END_STRUCT;
	IO_MotionFan_Type : 	STRUCT 
		DI_ManSwitchON : BOOL := TRUE;
		DI_OverloadOK : BOOL := TRUE;
		DI_ContactorFBK : BOOL := TRUE;
		DO_MotorON : BOOL;
	END_STRUCT;
END_TYPE

(*INSTRUMENTS*)

TYPE
	IO_Analog_IN_OUT_Type : 	STRUCT 
		AO_Raw : INT := 0; (*Analog Input From HW*)
		AI : IO_Analog_IN_Type; (*Analog Input From HW*)
	END_STRUCT;
	IO_Analog_IN_Type : 	STRUCT 
		AI_Raw : INT := 0; (*Analog Input From HW*)
		DI_ChannelOk : BOOL := TRUE;
		DI_Pulse : BOOL; (*Totalizer Pulse*)
		DI_Alarm : BOOL; (*Instrument Alarm*)
		DO_SetScale : BOOL; (*Scale Change Output*)
	END_STRUCT;
	IO_Digital_IN_Type : 	STRUCT 
		DI_Input : BOOL;
	END_STRUCT;
	IO_Digital_OUT_Type : 	STRUCT 
		DO_Output : BOOL;
	END_STRUCT;
	IO_GreasingPump_Type : 	STRUCT 
		LowLevel : IO_Digital_IN_Type;
		CycleEnd : IO_Digital_IN_Type;
		Motor : IO_Motor_Type;
	END_STRUCT;
	IN_Analog_Multiscale : 	STRUCT 
		ScaleLOW : REAL;
		ScaleHIGH : REAL;
		ActualSP : REAL; (*Signal Input Actual Set Point*)
		MinDev : REAL; (*To Set Point Low Deviation (for SP obtained)*)
		MaxDev : REAL; (*To Set Point High Deviation (for SP obtained)*)
		WaitDelay : TIME;
		HighLimitEn : BOOL;
		HighLimitSP : REAL;
		HighLimitHyst : REAL;
		HighLimitDelay : TIME;
		LowLimitEn : BOOL;
		LowLimitSP : REAL;
		LowLimitHyst : REAL;
		LowLimitDelay : TIME;
		TotPulseWeight : REAL;
		TotType : USINT;
		PLCCounterSP : REAL;
		PLCCounterReset : BOOL;
		HMITotEn : BOOL;
		HMITotReset : BOOL;
	END_STRUCT;
	OUT_Analog_Multiscale : 	STRUCT 
		ActValue : REAL; (*Manipulated value*)
		LowLimit : BOOL;
		HighLimit : BOOL;
		PLCCounterReached : BOOL; (*Output Fault*)
		Active : BOOL; (*Request to Instrument Scale Activation*)
	END_STRUCT;
	IO_IncrementalEncoder : 	STRUCT  (*//V4.A.A.1.6.11*)
		CountAtZero : DINT;
		Counter : INT;
		Status : USINT;
		Reference : USINT;
		DI_EnableReference : IO_Digital_IN_Type;
		DI_NotPowered : IO_Digital_IN_Type;
	END_STRUCT;
END_TYPE
