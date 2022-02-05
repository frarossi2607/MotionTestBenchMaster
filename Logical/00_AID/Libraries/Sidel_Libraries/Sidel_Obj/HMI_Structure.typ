(*VALVES*)

TYPE
	HMI_Valve_Type : 	STRUCT  (*Valves Structure: Digital*)
		Out : BOOL; (*State: Output*)
		Alarm : BOOL; (*State: Position Alarm *)
		Opened : BOOL; (*State: Feed-Back Opened*)
		Closed : BOOL; (*State: Feed-Back Closed*)
		ConfigPosition : BOOL; (*Configuration: Valve Feed-Back Position Present *)
		ConfigPresent : BOOL; (*Configuration: Device Present*)
		ManOff : BOOL; (*Command: Manual Closed*)
		ManOn : BOOL; (*Command: Manual Opened *)
		Mask : BOOL; (*Command: Position Alarm Mask*)
		ManEnable : BOOL; (*Command Enable: Manual Enabled*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
	END_STRUCT;
	HMI_Valve_MixProof_Type : 	STRUCT  (*Valves Structure: Digital Mix Proof*)
		Out : BOOL; (*State: Output*)
		Alarm : BOOL; (*State: Position Alarm *)
		Opened : BOOL; (*State: Feed-Back Opened*)
		Closed : BOOL; (*State: Feed-Back Closed*)
		ConfigPosition : BOOL; (*Configuration: Valve Feed-Back Position Present *)
		ConfigPresent : BOOL; (*Configuration: Device Present*)
		ManOff : BOOL; (*Command: Manual Closed*)
		ManOn : BOOL; (*Command: Manual Opened *)
		Mask : BOOL; (*Command: Position Alarm Mask*)
		ManEnable : BOOL; (*Command Enable: Manual Enabled*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		H_Out : BOOL; (*High State: Output*)
		H_Alarm : BOOL; (*High State: Position Alarm *)
		H_Opened : BOOL; (*High State: Feed-Back Opened*)
		H_Closed : BOOL; (*High State: Feed-Back Closed*)
		H_ConfigPosition : BOOL; (*High Configuration: Valve Closed State Present *)
		H_ManOff : BOOL; (*High Command: Manual Closed*)
		H_ManOn : BOOL; (*High Command: Manual Opened *)
		H_Mask : BOOL; (*High Command: Position Alarm Mask*)
		H_ManEnable : BOOL; (*High Command Enable: Manual Enabled*)
		H_MaskEnable : BOOL; (*High Command Enable: Mask Enabled*)
		L_Out : BOOL; (*Low State: Output*)
		L_Alarm : BOOL; (*Low State: Position Alarm *)
		L_Opened : BOOL; (*Low State: Feed-Back Opened*)
		L_Closed : BOOL; (*Low State: Feed-Back Closed*)
		L_ConfigPosition : BOOL; (*Low Configuration: Valve Closed State Present *)
		L_ManOff : BOOL; (*Low Command: Manual Closed*)
		L_ManOn : BOOL; (*Low Command: Manual Opened *)
		L_Mask : BOOL; (*Low Command: Position Alarm Mask*)
		L_ManEnable : BOOL; (*Low Command Enable: Manual Enabled*)
		L_MaskEnable : BOOL; (*Low Command Enable: Mask Enabled*)
	END_STRUCT;
	HMI_Valve_Mod_Type : 	STRUCT  (*Valves Structure: Analogic*)
		Out : BOOL; (*State: Output*)
		Alarm : BOOL; (*State: Position Alarm *)
		Opened : BOOL; (*State: Feed-Back Opened*)
		Closed : BOOL; (*State: Feed-Back Closed*)
		ConfigSlew : BOOL; (*Configuration: Output Slew Present*)
		ConfigPosition : BOOL; (*Configuration: Valve Feed-Back Position Present *)
		ConfigPresent : BOOL; (*Configuration: Device Present*)
		ManOff : BOOL; (*Command: Manual Closed*)
		ManOn : BOOL; (*Command: Drive Manual OUT = OUT_Man*)
		Mask : BOOL; (*Command: Position Alarm Mask*)
		ManEnable : BOOL; (*Command Enable: Manual Enabled*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		OUT_CV : REAL; (*State: Actual OUTPUT Control Value (0.0-:-100.0)*)
		OUT_Man : REAL; (*Command: Manual OUTPUT Value (0.0-:-100.0)*)
		FBK : REAL; (*State: Feed-Back INPUT Value (0.0-:-100.0)*)
	END_STRUCT;
END_TYPE

(*MOTORS*)

TYPE
	HMI_SCU_Type : 	STRUCT 
		Visibility : BOOL;
		Alarm : BOOL;
		ErrCode : DINT;
		HwCmdUp : BOOL;
		HwCmdDown : BOOL;
		HwCmdStorePosition : BOOL;
	END_STRUCT;
	HMI_Column_Type : 	STRUCT 
		Visibility : BOOL;
		Running : BOOL; (*State: Output*)
		Current : REAL;
		Initialized : BOOL;
		Position : REAL;
		Alarm : BOOL;
	END_STRUCT;
	HMI_Motor_Type : 	STRUCT  (*Motor Structure: Direct On Line*)
		Out : BOOL; (*State: Running*)
		Alarm : BOOL; (*State: Alarm (Isolated, Overload, FBK Fault)*)
		Isolated : BOOL; (*State: Motor Isolated*)
		Overload : BOOL; (*State: Overload*)
		FeedBack : BOOL; (*State: Feed-Back Fault*)
		ConfigPresent : BOOL; (*Configuration: Device Present*)
		ManOff : BOOL; (*Command: Manual Stop*)
		ManOn : BOOL; (*Command: Manual Start*)
		Mask : BOOL; (*Command: Alarm Mask*)
		ManEnable : BOOL; (*Command Enable: Manual Enabled*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
	END_STRUCT;
	HMI_Motor_FC_Type : 	STRUCT  (*Motor Structure: Variable Frequency Drive*)
		Out : BOOL; (*State: Running *)
		Alarm : BOOL; (*State: Alarm (Isolated, Overload, FBK Fault)*)
		Isolated : BOOL; (*State: Motor Isolated*)
		Overload : BOOL; (*State: Overload*)
		FeedBack : BOOL; (*State: In Operation/Safe-OFF Feed-Back Fault*)
		BusFault : BOOL; (*State: Bus Control Fault*)
		Fault : BOOL; (*State: Inverter Internal Fault*)
		ConfigPresent : BOOL; (*Configuration: Device Present*)
		ManOff : BOOL; (*Command: Manual Stop*)
		ManOn : BOOL; (*Command: Manual Start*)
		Mask : BOOL; (*Command: Alarm Mask*)
		ManEnable : BOOL; (*Command Enable: Manual Enabled*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		OUT_CV : REAL; (*State: Actual OUTPUT Value (0.0-:-100.0)*)
		OUT_Man : REAL; (*Command: Manual OUTPUT Value (0.0-:-100.0)*)
	END_STRUCT;
	HMI_Dosing_Pump_Type : 	STRUCT  (*Motor Structure: Dosing Pump*)
		Out : BOOL; (*State: Running *)
		Alarm : BOOL; (*State: Alarm (Isolated, Overload, FBK Fault)*)
		Isolated : BOOL; (*State: Motor Isolated*)
		Overload : BOOL; (*State: Overload*)
		FeedBack : BOOL; (*State: In Operation/Safe-OFF Feed-Back Fault*)
		Pulse_FBK : BOOL; (*State: Pulse Feed-Back Alarm*)
		Internal_Fault : BOOL; (*State: Internal Alarm*)
		ConfigPresent : BOOL; (*Configuration: Device Present*)
		ManOff : BOOL; (*Command: Manual Stop*)
		ManOn : BOOL; (*Command: Manual Start *)
		Mask : BOOL; (*Command: Alarm Mask*)
		ManEnable : BOOL; (*Command Enable: Manual Enabled*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		Stroke_Value : REAL; (*Setting CC/Stroke [cm3/stroke]*)
		Concentration : REAL; (*Tank Concentrated percentage [0..1000000 ppm]*)
		Density : REAL; (*Specific Weight [kg]*)
	END_STRUCT;
	HMI_Danfoss_Diag_Type : 	STRUCT 
		PCV : HMI_Danfoss_PCV_Type;
		PCD_Read : HMI_Danfoss_PCD_Read_Type;
	END_STRUCT;
	HMI_Danfoss_PCV_Type : 	STRUCT 
		Alarm : DINT;
	END_STRUCT;
	HMI_Danfoss_PCD_Read_Type : 	STRUCT 
		Power : REAL;
		Motor_Current : REAL;
		Frequency : REAL;
		Torque : REAL;
		Main_Actual_Value : REAL;
		Speed_RPM : REAL;
		Status_Word : UINT;
	END_STRUCT;
	HMI_Fan_Type : 	STRUCT 
		HMI_Pressurizer : ARRAY[1..6]OF HMI_Pressurizer_Type; (*Single Fans to HMI*)
		HMI_Galvani : HMI_Galvani_Type; (*Galvani Roof Fans*)
	END_STRUCT;
	HMI_Galvani_Type : 	STRUCT 
		Out : BOOL;
		ConfigPresent : BOOL; (*Configuration: Device Present*)
		SS2P_Lamp1 : HMI_SS2P_Type; (*SS2P Lamp*)
		SS2P_Lamp2 : HMI_SS2P_Type; (*SS2P Lamp*)
		ManState : BOOL; (*State: Device in manual mode*)
		ManEnable : BOOL; (*Command Enable: Manual Enabled*)
		ManFlowSet : BOOL; (*Command: Manual Flow set command*)
		ManOff : BOOL; (*Command: Manual Stop*)
		ManOn : BOOL; (*Command: Manual Start*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		Mask : BOOL; (*Command: Alarm Mask*)
		FlowSet : BOOL; (*State: Flow set speed *)
		Alarm : BOOL; (*State: Alarm (Isolated, Overload, FBK Fault)*)
		AlarmAbsoluteFilter : BOOL; (*Fault : Absolute filter clogged*)
		AlarmPrefilterExt : BOOL; (*Fault : External PreFilter Clogged*)
		AlarmPrefilterInt : BOOL; (*Fault : Internal PreFilter Clogged*)
		Overload : BOOL; (*State: Power supply on*)
	END_STRUCT;
	HMI_Pressurizer_Type : 	STRUCT 
		Out : BOOL;
		ConfigPresent : BOOL; (*Configuration: Device Present*)
		SS2P_Lamp : HMI_SS2P_Type; (*SS2P Lamp*)
		ManState : BOOL; (*State: Device in manual mode*)
		ManEnable : BOOL; (*Command Enable: Manual Enabled*)
		ManOff : BOOL; (*Command: Manual Stop*)
		ManOn : BOOL; (*Command: Manual Start*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		Mask : BOOL; (*Command: Alarm Mask*)
		OUT_Man : REAL; (*Command :  Manual Speed OUT value selected (0 - 100)*)
		OUT_CV : REAL; (*State : Actual Speed OUT value %*)
		Alarm : BOOL; (*State: Alarm (Isolated, Overload, FBK Fault)*)
		AlarmFilter : BOOL; (*Fault : Absolute filter or PreFilter Clogged*)
	END_STRUCT;
	HMI_GreasingPump_Type : 	STRUCT 
		LowLevel : HMI_DI_Type;
		CycleEnd : HMI_DI_Type;
		Motor : HMI_Motor_Type;
	END_STRUCT;
END_TYPE

(*INSTRUMENTS*)

TYPE
	HMI_Valve_Ejector_Type : 	STRUCT  (*Valves Structure: Digital*)
		Out : BOOL; (*State: Output*)
		Alarm : BOOL; (*State: Position Alarm *)
		Opened : BOOL; (*State: Feed-Back Opened*)
		Closed : BOOL; (*State: Feed-Back Closed*)
		ConfigPosition : BOOL; (*Configuration: Valve Feed-Back Position Present *)
		ConfigPresent : BOOL; (*Configuration: Device Present*)
		ManOff : BOOL; (*Command: Manual Closed*)
		ManOn : BOOL; (*Command: Manual Opened *)
		Mask : BOOL; (*Command: Position Alarm Mask*)
		ManEnable : BOOL; (*Command Enable: Manual Enabled*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		CounterReset : BOOL; (*Command: Reset Counter*)
		TotalErrors : UDINT; (*State : Total Errors*)
		AbsoluteErrors : USINT; (*State : Absolute Errors*)
		ConsecutiveErrors : USINT; (*State : Consecutive Errors*)
	END_STRUCT;
	HMI_Photocell_Type : 	STRUCT  (*Instrument Structure: Photocell*)
		On : BOOL; (*State: Active*)
		Alarm : BOOL; (*State: Alarm*)
		Wait : BOOL; (*State: Waiting condition*)
		ConfigAlarm : BOOL; (*Configuration: Alarm Present*)
		ConfigPresent : BOOL; (*Configuration: Instrument Present*)
		Mask : BOOL; (*Command: Alarm Mask*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		CounterReset : BOOL; (*Command: Reset Counter*)
		TotalErrors : UDINT; (*State : Total Errors*)
		RepetitiveErrors : USINT; (*State : Repetitive Errors*)
		AbsoluteErrors : USINT; (*State : Absolute Errors*)
		ConsecutiveErrors : USINT; (*State : Consecutive Errors*)
		AlwaysTrueSteps : USINT;
	END_STRUCT;
	HMI_DI_Type : 	STRUCT  (*Instrument Structure: Digital*)
		On : BOOL; (*State: Active*)
		Alarm : BOOL; (*State: Alarm*)
		Wait : BOOL; (*State: Waiting condition*)
		ConfigAlarm : BOOL; (*Configuration: Alarm Present*)
		ConfigPresent : BOOL; (*Configuration: Instrument Present*)
		Mask : BOOL; (*Command: Alarm Mask*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
	END_STRUCT;
	HMI_Analog_IN_Type : 	STRUCT  (*Instrument Structure: Analogic*)
		Alarm : BOOL; (*State: Instrument in fault (Probe Fault)*)
		Wait : BOOL; (*State: Waiting condition*)
		WaitCounter : BOOL; (*State: Waiting Counter condition*)
		ConfigPopUp : BOOL; (*Configuration: Instrument Pop-Up Present (TRUE=Pop-Up NOT Present)*)
		ConfigTot : BOOL; (*Configuration: Totalizator Present (TRUE=Totalizator Present)*)
		ConfigAlarm : BOOL; (*Configuration: Alarm Present (TRUE=Command Mask Present)*)
		ConfigPresent : BOOL; (*Configuration: Instrument Present*)
		ConfigCounter : BOOL; (*Configuration: Counter Present*)
		ResetTot : BOOL; (*Command: Totalizator Reset*)
		Mask : BOOL; (*Command: Alarm Mask (Probe Fault disabled)*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		PV : REAL; (*Input: Scaled Process Value*)
		SP : REAL; (*Input: Actual SetPoint*)
		PV_Counter : REAL; (*Input: Counter Current Value*)
		SP_Counter : REAL; (*Input: Counter Requested Value*)
		Tot : REAL; (*Input: Totalizator*)
	END_STRUCT;
	HMI_Analog_IN_Mode_Type : 	STRUCT  (*Instrument Structure: Analogic Multi Scale*)
		Mode : ARRAY[0..3]OF HMI_Analog_IN_Type;
	END_STRUCT;
	HMI_Analog_Multiscale_Type : 	STRUCT  (*Instrument Structure: Analogic*)
		Alarm : BOOL; (*State: Instrument in fault (Probe Fault)*)
		Unit : USINT; (*0 = Unit1 ; 1 = Unit2 ; 2 = Unit3 ; etc...*)
		ConfigPopup : BOOL; (*Configuration: Instrument Pop-Up Present (TRUE=Pop-Up NOT Present)*)
		ConfigAlarm : BOOL; (*Configuration: Alarm Present (TRUE=Command Mask Present)*)
		ConfigPresent : BOOL; (*Configuration: Instrument Present*)
		ResetTot : BOOL; (*Command: Totalizator Reset*)
		Mask : BOOL; (*Command: Alarm Mask (Probe Fault disabled)*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		Wait : ARRAY[0..3]OF BOOL; (*State: Waiting condition*)
		ConfigTot : ARRAY[0..3]OF BOOL; (*Configuration: Totalizator Present (TRUE=Totalizator Present)*)
		WaitCounter : ARRAY[0..3]OF BOOL; (*State: Waiting Counter condition*)
		ConfigCounter : ARRAY[0..3]OF BOOL; (*Configuration: Counter Present*)
		PV : ARRAY[0..3]OF REAL; (*Input: Scaled Process Value*)
		SP : ARRAY[0..3]OF REAL; (*Input: Actual SetPoint*)
		PV_Counter : ARRAY[0..3]OF REAL; (*Input: Counter Current Value*)
		SP_Counter : ARRAY[0..3]OF REAL; (*Input: Counter Requested Value*)
		Tot : ARRAY[0..3]OF REAL; (*Input: Totalizator*)
	END_STRUCT;
	HMI_TNK_Level_Type : 	STRUCT 
		CFG_Level_Percentage : BOOL;
		Level_Percentage : REAL; (*[%]*)
		CFG_Level_Percentage_SP : BOOL; (*[%]*)
		Level_Height_SP : REAL; (*[mm]*)
		Level_Percentage_SP : REAL; (*[%]*)
		CFG_Volume : BOOL;
		Volume : REAL; (*[l]*)
		CFG_Volume_SP : BOOL; (*[l]*)
		Level_Percentage_Wait : BOOL;
		Level_Height_Wait : BOOL;
		Volume_Wait : BOOL;
		Volume_SP : REAL; (*[l]*)
		CFG_Level_Height : BOOL;
		Level_Height : REAL; (*[mm]*)
	END_STRUCT;
	HMI_TNK_Level_v00_Type : 	STRUCT 
		ConfigPresent : BOOL := TRUE;
		TNK_Height_mm : REAL; (*[mm]*)
		TNK_Height_Sp : REAL; (*[mm]*)
		TNK_Height_Wait : BOOL;
		TNK_Percentage : REAL; (*[%]*)
		TNK_Percentage_Sp : REAL; (*[%]*)
		TNK_Percentage_Wait : BOOL;
		TNK_Volume_liters : REAL; (*[l]*)
		TNK_Volume_Sp : REAL; (*[l]*)
		TNK_Volume_Wait : BOOL;
	END_STRUCT;
	HMI_GateDoor_Type : 	STRUCT 
		Opened : BOOL;
		ShortSafety : BOOL;
		Production : HMI_DI_Type;
		Cleaning : HMI_DI_Type;
	END_STRUCT;
END_TYPE

(*PID*)

TYPE
	HMI_PID_Mode_Type : 	STRUCT 
		Mode : ARRAY[0..3]OF HMI_PID_Type;
	END_STRUCT;
	HMI_PID_Type : 	STRUCT  (*PID Structure: PID Control*)
		Enable : BOOL; (*State: PID Enable*)
		Mode : BOOL; (*State: PID Mode (Automatic = 1  Manual = 0)*)
		Alarm : BOOL; (*State: PID PV in fault*)
		SP_Obtained : BOOL; (*State: PID Set Point Reached*)
		SP_SlewRunning : BOOL; (*State: PID Set Point Slew Running*)
		CnScale : BOOL; (*Configuration: FF and PID OUT Scale - TRUE-> 0-100%, FALSE-> Ing.Unit.*)
		ConfigSlewPresent : BOOL; (*Configuration: Slew Present*)
		ConfigPresent : BOOL; (*Configuration : PID present*)
		SPLocal : BOOL; (*Command: PID Manual Set Point -> "SP_Local"*)
		PV : REAL; (*State: PID Process Value*)
		SP_Actual : REAL; (*State: PID Set Point in Use*)
		SP_Target : REAL; (*State: PID Set Point*)
		FF_OUT : REAL; (*State: PID Feed Forward calculated value*)
		OUT : REAL; (*State: PID Output*)
		SP_Local : REAL; (*Command: PID Manual Set Point Target Value*)
	END_STRUCT;
END_TYPE

(*PWM*)

TYPE
	HMI_PWM_Type : 	STRUCT  (*PWM Structure: Pulse Width Modulation*)
		Out : BOOL; (*State: On*)
		Alarm : BOOL; (*State: Alarm (Isolated, Overload, FBK Fault)*)
		Isolated : BOOL; (*State: Isolated*)
		Overload : BOOL; (*State: Overload*)
		FeedBack : BOOL; (*State: Feed-Back Fault*)
		ConfigPresent : BOOL; (*Configuration: Device Present*)
		ManOff : BOOL; (*Command: Manual Stop*)
		ManOn : BOOL; (*Command: Manual Start*)
		Mask : BOOL; (*Command: Alarm Mask*)
		ManEnable : BOOL; (*Command Enable: Manual Enabled*)
		MaskEnable : BOOL; (*Command Enable: Mask Enabled*)
		OUT_CV : REAL; (*State: Actual OUTPUT Control Value (0.0-:-100.0)*)
		OUT_Man : REAL; (*Command: Manual OUTPUT Value (0.0-:-100.0)*)
	END_STRUCT;
END_TYPE

(* *)

TYPE
	HMI_SS2P_Type : 	STRUCT  (*Selector 2 position (Auto-Man; ON-OFF;) 0=Auto/OFF - 1=Man/ON*)
		Enable : BOOL; (*State: Command Enabled*)
		LampON : BOOL; (*State: Lamp Command ON*)
		Blink : BOOL; (*State: Blink LampOn*)
		Visibility : BOOL; (*Configuration: Present*)
		ON : BOOL; (*Command: Selector Button ON*)
	END_STRUCT;
END_TYPE
