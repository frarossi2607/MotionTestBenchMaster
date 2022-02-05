
FUNCTION_BLOCK Analog_In_Direct_Inverse
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_Simulation : BOOL;
		IN_0_20mA : BOOL;
		IN_FaultOutMode : USINT; (*LowOnFault(1) ; HighOnFault (2) HoldOnFault (0)*)
		IN_EngScale : BOOL;
		IN_CompareMode : USINT; (*0 = Off, 1 = PV_Greater_SP, 2 = PV_Less_SP, 3 = PV_Equal_SP, 4 = On*)
		IN_ScaleLOW : REAL;
		IN_ScaleHIGH : REAL;
		IN_AlarmEn : BOOL;
		IN_MaskEn : BOOL;
		IN_ConfigPopup : BOOL;
		IN_Reset : BOOL; (*Reset Analog Channel Alarm*)
		IN_ActualSP : REAL; (*Signal Input Actual Set Point*)
		IN_MinDev : REAL; (*To Set Point Low Deviation (for SP obtained)*)
		IN_MaxDev : REAL; (*To Set Point High Deviation (for SP obtained)*)
		IN_WaitDelay : TIME;
		IN_HighLimitEn : BOOL;
		IN_HighLimitSP : REAL;
		IN_HighLimitHyst : REAL;
		IN_HighLimitDelay : TIME;
		IN_LowLimitEn : BOOL;
		IN_LowLimitSP : REAL;
		IN_LowLimitHyst : REAL;
		IN_LowLimitDelay : TIME;
		IN_Direct_Inverse : BOOL; (*Read Mode: "0" for Direct "1" for Inverse*)
		IN_Delta : REAL; (*Delta Value for Real Component Height*)
	END_VAR
	VAR_OUTPUT
		OUT_ActValue : REAL; (*Manipulated value*)
		OUT_SpReached : BOOL; (*Output Set Point Reached*)
		OUT_HighLimit : BOOL;
		OUT_LowLimit : BOOL;
		OUT_Alarm : BOOL; (*Output Fault*)
		OUT_RawOverflow : BOOL; (*Output Fault*)
		OUT_RawUnderflow : BOOL; (*Output Fault*)
	END_VAR
	VAR_IN_OUT
		IO : IO_Analog_IN_Type;
		HMI : HMI_Analog_IN_Type;
	END_VAR
	VAR
		VAR_Fault : BOOL; (*Alarm Output for Fault or Warning*)
		VAR_Mask : BOOL;
		VAR_Out : REAL;
		VAR_ChannelActive : BOOL;
		VAR_Wait : BOOL;
		VAR_iFault : BOOL;
		VAR_SpReached : BOOL;
		LCRLimScal_0_20mA : LCRLimScal;
		LCRLimScal_4_20mA : LCRLimScal;
		TMR_TON_HighLimitDelay : TON;
		TMR_TON_LowLimitDelay : TON;
		TMR_TOF_SpReached : TOF;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Analog_In
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_Simulation : BOOL;
		IN_0_20mA : BOOL;
		IN_FaultOutMode : USINT; (*LowOnFault(1) ; HighOnFault (2) HoldOnFault (0)*)
		IN_EngScale : BOOL;
		IN_CompareMode : USINT; (*0 = Off, 1 = PV_Less_SP, 2 = PV_Greater_SP, 3 = PV_Equal_SP, 4 = Reached On*)
		IN_ScaleLOW : REAL;
		IN_ScaleHIGH : REAL;
		IN_AlarmEn : BOOL;
		IN_MaskEn : BOOL;
		IN_ConfigPopup : BOOL;
		IN_Reset : BOOL; (*Reset Analog Channel Alarm*)
		IN_ActualSP : REAL; (*Signal Input Actual Set Point*)
		IN_MinDev : REAL; (*To Set Point Low Deviation (for SP obtained)*)
		IN_MaxDev : REAL; (*To Set Point High Deviation (for SP obtained)*)
		IN_WaitDelay : TIME;
		IN_HighLimitEn : BOOL;
		IN_HighLimitSP : REAL;
		IN_HighLimitHyst : REAL;
		IN_HighLimitDelay : TIME;
		IN_LowLimitEn : BOOL;
		IN_LowLimitSP : REAL;
		IN_LowLimitHyst : REAL;
		IN_LowLimitDelay : TIME;
		IN_TotPulseWeight : REAL;
		IN_TotType : USINT;
		IN_PLCCounterEn : BOOL;
		IN_PLCCounterSP : REAL;
		IN_PLCCounterReset : BOOL;
		IN_HMITotEn : BOOL;
		IN_HMITotReset : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_ActValue : REAL; (*Manipulated value*)
		OUT_SpReached : BOOL; (*Output Set Point Reached*)
		OUT_HighLimit : BOOL;
		OUT_LowLimit : BOOL;
		OUT_Alarm : BOOL; (*Output Fault*)
		OUT_RawOverflow : BOOL; (*Output Fault*)
		OUT_RawUnderflow : BOOL; (*Output Fault*)
		OUT_PLCCounterReached : BOOL; (*Output Fault*)
	END_VAR
	VAR_IN_OUT
		IO : IO_Analog_IN_Type;
		HMI : HMI_Analog_IN_Type;
	END_VAR
	VAR
		VAR_Fault : BOOL; (*Alarm Output for Fault or Warning*)
		VAR_Mask : BOOL;
		VAR_Out : REAL;
		VAR_ChannelActive : BOOL;
		VAR_Wait : BOOL;
		VAR_iFault : BOOL;
		VAR_SpReached : BOOL;
		LCRLimScal_0_20mA : LCRLimScal;
		LCRLimScal_4_20mA : LCRLimScal;
		HMITotalizer : AnalogTotalizer;
		PLCCounter : AnalogTotalizer;
		TMR_TON_HighLimitDelay : TON;
		TMR_TON_LowLimitDelay : TON;
		TMR_TOF_SpReached : TOF;
		TON_ChannelOk : TON;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK GateDoorDigital_Obj
	VAR_INPUT
		IN_ConfigPresent : BOOL; (*Configuration: Device Present*)
		IN_Alarm : BOOL; (*Configuration: Timeout Alarm Control Enable*)
		IN_AlarmOpenReq : BOOL; (*Control: On State Time Out Alarm Request*)
		IN_AlarmCloseReq : BOOL; (*Control: Off State Time Out Alarm Request*)
		IN_SwitchDelay : TIME; (*Time: Row Input Switching State Display Delay*)
		IN_WaitOpen : BOOL; (*Control: On State Wait Request*)
		IN_WaitClose : BOOL; (*Control: Off State Wait Request*)
		IN_OnDelay : TIME; (*Time: State On / Alarm On Time Delay*)
		IN_OffDelay : TIME; (*Time: State Off / Alarm Off Time Delay*)
		IN_Reset : BOOL; (*Control: Alarm Reset Push Button*)
		IN_SafetyClosed : BOOL; (*From Safety: Gate Closed*)
		IN_SafetyShortCircuit : BOOL; (*From Safety: Short circuit or 1oo2*)
	END_VAR
	VAR_OUTPUT
		OUT_Opened : BOOL; (*OUT: Gate Opened*)
		OUT_Closed : BOOL; (*OUT: Gate Closed*)
		OUT_Alarm : BOOL; (*State On / Off Time Out Alarm*)
	END_VAR
	VAR_IN_OUT
		IO_Production : IO_Digital_IN_Type; (*State: Digital Input Structure*)
		HMI : HMI_GateDoor_Type;
	END_VAR
	VAR
		TMR_TON_ProdSwOn : TON;
		TMR_TON_ProdSwOff : TON;
		TMR_TON_CleanSwOn : TON;
		TMR_TON_CleanSwOff : TON;
		TMR_TON_ProdOnAlarm : TON;
		TMR_TON_ProdOffAlarm : TON;
		TMR_TON_CleanOnAlarm : TON;
		TMR_TON_CleanOffAlarm : TON;
		VAR_Signal : BOOL;
		VAR_ProdFault : BOOL;
		VAR_CleanFault : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Analog_In_Multiscale
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_Simulation : BOOL;
		IN_0_20mA : BOOL;
		IN_MaskEn : BOOL;
		IN_Reset : BOOL; (*Reset Analog Channel Alarm*)
		IN_FaultOutMode : USINT; (*LowOnFault(1) ; HighOnFault (2) HoldOnFault (0)*)
		IN_EngScale : BOOL;
		IN_AlarmEn : BOOL;
		IN_ConfigPopup : BOOL;
		IN_PLCCounterEn : BOOL;
		IN_CompareMode : USINT; (*0 = Off, 1 = PV_Greater_SP, 2 = PV_Less_SP, 3 = PV_Equal_SP, 4 = On*)
		IN_ScaleIndex : USINT; (*0..3 = Array Requested*)
		IN_Scale : ARRAY[0..3] OF IN_Analog_Multiscale; (*0..3 = Arrays for Different Scale*)
	END_VAR
	VAR_OUTPUT
		OUT_Alarm : BOOL; (*Output Fault*)
		OUT_SpReached : BOOL; (*Output Set Point Reached*)
		OUT_RawOverflow : BOOL; (*Output Analog Fault*)
		OUT_RawUnderflow : BOOL; (*Output Analog Fault*)
		OUT_Scale : ARRAY[0..3] OF OUT_Analog_Multiscale;
	END_VAR
	VAR_IN_OUT
		IO : IO_Analog_IN_Type;
		HMI : HMI_Analog_Multiscale_Type;
	END_VAR
	VAR
		VAR_Fault : BOOL; (*Alarm Output for Fault or Warning*)
		VAR_Mask : BOOL;
		VAR_ChannelActive : BOOL;
		VAR_Wait : BOOL;
		VAR_iFault : BOOL;
		VAR_SpReached : BOOL;
		VAR_Index : USINT;
		VAR_Out : REAL;
		LCRLimScal_0_20mA : LCRLimScal;
		LCRLimScal_4_20mA : LCRLimScal;
		HMITotalizer : AnalogTotalizer;
		PLCCounter : AnalogTotalizer;
		TMR_TON_HighLimitDelay : TON;
		TMR_TON_LowLimitDelay : TON;
		TMR_TOF_SpReached : TOF;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Analog_In_Multicompare
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_Simulation : BOOL;
		IN_0_20mA : BOOL;
		IN_MaskEn : BOOL;
		IN_Reset : BOOL; (*Reset Analog Channel Alarm*)
		IN_FaultOutMode : USINT; (*LowOnFault(1) ; HighOnFault (2) HoldOnFault (0)*)
		IN_EngScale : BOOL;
		IN_AlarmEn : BOOL;
		IN_ConfigPopup : BOOL;
		IN_PLCCounterEn : BOOL;
		IN_CompareMode : USINT; (*0 = Off, 1 = PV_Greater_SP, 2 = PV_Less_SP, 3 = PV_Equal_SP, 4 = On*)
		IN_ScaleIndex : USINT; (*0..3 = Array Requested*)
		IN_Scale : ARRAY[0..3] OF IN_Analog_Multiscale; (*0..3 = Arrays for Different Scale*)
	END_VAR
	VAR_OUTPUT
		OUT_Alarm : BOOL; (*Output Fault*)
		OUT_SpReached : BOOL; (*Output Set Point Reached*)
		OUT_RawOverflow : BOOL; (*Output Analog Fault*)
		OUT_RawUnderflow : BOOL; (*Output Analog Fault*)
		OUT_Scale : ARRAY[0..3] OF OUT_Analog_Multiscale;
	END_VAR
	VAR_IN_OUT
		IO : IO_Analog_IN_Type;
		HMI : HMI_Analog_Multiscale_Type;
	END_VAR
	VAR
		VAR_Fault : BOOL; (*Alarm Output for Fault or Warning*)
		VAR_Mask : BOOL;
		VAR_ChannelActive : BOOL;
		VAR_Wait : BOOL;
		VAR_iFault : BOOL;
		VAR_SpReached : BOOL;
		VAR_Index : USINT;
		VAR_Out : REAL;
		LCRLimScal_0_20mA : LCRLimScal;
		LCRLimScal_4_20mA : LCRLimScal;
		HMITotalizer : AnalogTotalizer;
		PLCCounter : AnalogTotalizer;
		TMR_TON_HighLimitDelay : TON;
		TMR_TON_LowLimitDelay : TON;
		TMR_TOF_SpReached : TOF;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Digital_Obj
	VAR_INPUT
		IN_ConfigPresent : BOOL; (*Configuration: Device Present*)
		IN_Alarm : BOOL; (*Configuration: Timeout Alarm Control Enable*)
		IN_AlarmOnReq : BOOL; (*Control: On State Time Out Alarm Request*)
		IN_AlarmOffReq : BOOL; (*Control: Off State Time Out Alarm Request*)
		IN_SwitchDelay : TIME; (*Time: Row Input Switching State Display Delay*)
		IN_WaitOn : BOOL; (*Control: On State Wait Request*)
		IN_WaitOff : BOOL; (*Control: Off State Wait Request*)
		IN_OnDelay : TIME; (*Time: State On / Alarm On Time Delay*)
		IN_OffDelay : TIME; (*Time: State Off / Alarm Off Time Delay*)
		IN_Reset : BOOL; (*Control: Alarm Reset Push Button*)
		IN_MaskEn : BOOL; (*Control: Mask Enable*)
	END_VAR
	VAR_OUTPUT
		OUT : BOOL; (*State Switching Delayed*)
		OUT_OnDelayed : BOOL; (*State On Time Delayed*)
		OUT_OffDelayed : BOOL; (*State Off Time Delayed*)
		OUT_Alarm : BOOL; (*State On / Off Time Out Alarm*)
	END_VAR
	VAR_IN_OUT
		IO : IO_Digital_IN_Type; (*State: Digital Input Structure*)
		HMI : HMI_DI_Type;
	END_VAR
	VAR
		TMR_TON_SwOn : TON;
		TMR_TON_SwOff : TON;
		TMR_TON_OnTime : TON;
		TMR_TON_OffTime : TON;
		TMR_TON_OnAlarm : TON;
		TMR_TON_OffAlarm : TON;
		VAR_Signal : BOOL;
		VAR_Mask : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Motor_Std_Fw_Bw
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_Simulation : BOOL;
		IN_Enable : BOOL; (*Safety OK ( True if not used)*)
		IN_AutoCnd : BOOL; (*Automation Logic Input*)
		IN_Backward : BOOL; (*Direction Reverse*)
		IN_Reset : BOOL; (*Fault Reset*)
		IN_HMIAutoForce : BOOL;
		IN_FbkCheck : BOOL;
		IN_ManEn : BOOL;
		IN_MaskEn : BOOL;
		IN_FBKDelay : TIME := T#500ms; (*Time: Running Control Delay*)
		IN_ConfigType : BOOL; (*Configuration: Type TRUE = Phoenix FALSE = Contactor*)
	END_VAR
	VAR_OUTPUT
		OUT_Running : BOOL; (*Motor On*)
		OUT_ContactorFBKFault : BOOL;
		OUT_OverloadFault : BOOL;
		OUT_Alarm : BOOL; (*Output for Alarm*)
		OUT_IsolatedFault : BOOL;
	END_VAR
	VAR_IN_OUT
		IO : IO_Motor_FwBw_Type;
		HMI : HMI_Motor_Type;
	END_VAR
	VAR
		TMR_TOF : TON;
		TMR_TON : TON;
		VAR_ContactorFBK : BOOL;
		VAR_DiFault : BOOL;
		VAR_Overload : BOOL;
		VAR_Mask : BOOL;
		VAR_Auto : BOOL;
		VAR_Fault : BOOL; (*Alarm Output for Fault or Warning*)
		VAR_FirstCycle : BOOL;
		VAR_Isolated : BOOL;
		zzEdge00000 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Motor_Std
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_Simulation : BOOL;
		IN_Enable : BOOL; (*Safety OK ( True if not used)*)
		IN_AutoCnd : BOOL; (*Automation Logic Input*)
		IN_Reset : BOOL; (*Fault Reset*)
		IN_HMIAutoForce : BOOL;
		IN_ManEn : BOOL;
		IN_MaskEn : BOOL;
		IN_FBKDelay : TIME := T#500ms; (*Time: Running Control Delay*)
		IN_ConfigType : BOOL; (*Configuration: Type TRUE = Phoenix FALSE = Contactor*)
	END_VAR
	VAR_OUTPUT
		OUT_Running : BOOL; (*Motor On*)
		OUT_IsolatedFault : BOOL;
		OUT_ContactorFBKFault : BOOL;
		OUT_OverloadFault : BOOL;
		OUT_Alarm : BOOL; (*Output for Alarm*)
	END_VAR
	VAR_IN_OUT
		IO : IO_Motor_Type;
		HMI : HMI_Motor_Type;
	END_VAR
	VAR
		TMR_TOF : TON;
		TMR_TON : TON;
		VAR_ContactorFBK : BOOL;
		VAR_Isolated : BOOL;
		VAR_Overload : BOOL;
		VAR_Mask : BOOL;
		VAR_Auto : BOOL;
		VAR_Fault : BOOL; (*Alarm Output for Fault or Warning*)
		VAR_FirstCycle : BOOL;
		zzEdge00000 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK UVtronic_Std
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_Simulation : BOOL;
		IN_Enable : BOOL; (*Safety OK ( True if not used)*)
		IN_AutoCnd : BOOL; (*Automation Logic Input*)
		IN_Reset : BOOL; (*Fault Reset*)
		IN_HMIAutoForce : BOOL;
		IN_ManEn : BOOL;
		IN_MaskEn : BOOL;
		IN_FBKDelay : TIME := T#500ms; (*Time: Running Control Delay*)
		IN_ConfigType : BOOL; (*Configuration: Type TRUE = Phoenix FALSE = Contactor*)
	END_VAR
	VAR_OUTPUT
		OUT_Running : BOOL; (*Motor On*)
		OUT_NotReady : BOOL;
		OUT_GeneralFault : BOOL;
		OUT_ContactorFBKFault : BOOL;
		OUT_OverloadFault : BOOL;
		OUT_Alarm : BOOL; (*Output for Alarm*)
	END_VAR
	VAR_IN_OUT
		IO : IO_UVtronic_Type;
		HMI : HMI_Motor_Type;
	END_VAR
	VAR
		TMR_TOF : TON;
		TMR_TON : TON;
		VAR_ContactorFBK : BOOL;
		VAR_NotReady : BOOL;
		VAR_GeneralFault : BOOL;
		VAR_Overload : BOOL;
		VAR_Mask : BOOL;
		VAR_Auto : BOOL;
		VAR_Fault : BOOL; (*Alarm Output for Fault or Warning*)
		VAR_FirstCycle : BOOL;
		zzEdge00000 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Motor_FC280_Vfd
	VAR_INPUT
		IN_Simulation : BOOL;
		IN_ConfigPresent : BOOL; (*Configuration: Device Present*)
		IN_Enable : BOOL;
		IN_AutoCnd : BOOL; (*Automation Logic Input*)
		IN_AutoSpeed : REAL;
		IN_Reverse : BOOL;
		IN_FrequencyMin : REAL;
		IN_FrequencyMax : REAL;
		IN_ManEn : BOOL; (*Control: Manual On Enabled*)
		IN_MaskEn : BOOL; (*Control: Alarm Mask Enable*)
		IN_Reset : BOOL; (*Control: Alarm Reset Push Button*)
		IN_HMIAutoForce : BOOL;
		IN_QuickStopCmd : BOOL; (*Control: Quick Stop Command (TRUE = Quick Stop)*)
		IN_JOGMode : BOOL; (*Control: JOG Mode (if TRUE)*)
		IN_JOGCnd : BOOL; (*Control: JOG Running Condition*)
		IN_CoastingCmd : BOOL; (*Control: Coasting (TRUE = Coasting)*)
		IN_FCD : BOOL; (*Configuration: Drive Type FCD V4.A.A.1.6.13*)
		IN_FBKDelay : TIME := T#500ms; (*Time: Running Control Delay*)
		IN_SafetyCtrlEn : BOOL; (*Configuration: Drive SafeOFF Enabled TRUE = Control Enabled*)
		IN_ScaleMax : REAL := 100.0; (*Configuration: Drive speed Scale Maximum Value*)
	END_VAR
	VAR_OUTPUT
		OUT_InOperation : BOOL;
		OUT_DriveSafetyFBKFault : BOOL; (*Safety XOR 37*)
		OUT_DriveFault : BOOL; (*Drive fault (from STW) or high current*)
		OUT_IsolatedFault : BOOL;
		OUT_OverloadFault : BOOL;
		OUT_ActualSpeed : REAL;
		OUT_ActualFrequency : REAL;
		OUT_ActualCurrent : REAL;
		OUT_ActualTorque : REAL;
		OUT_ActualPower : REAL;
		OUT_ActualSpeedRPM : REAL;
		OUT_Warning : BOOL; (*Drive warning (from STW)*)
		OUT_SpeedReferece : BOOL;
	END_VAR
	VAR_IN_OUT
		HMI_Danfoss : HMI_Danfoss_Diag_Type;
		HMI_Motor : HMI_Motor_FC_Type;
		IO_DanfossFC280 : IO_PLK_DanfossFC280_Drive_Type;
		IO_MotorFC280 : IO_MotorFC280_Type;
	END_VAR
	VAR
		VAR_RecSTW : Danfoss_STW_Type;
		VAR_RecDI : Danfoss_DI_Type; (*V4.A.A.1.6.13*)
		VAR_SendCTW : Danfoss_CTW_Type;
		TMR_TON_CurrentHigh : TON;
		TMR_TON_FaultFilter : TON;
		TMR_TON_FBKTimeOut : TON;
		TMR_TON_RFeedBack : TON;
		TMR_TON_WarningFilter : TON;
		VAR_CurrentHigh : BOOL;
		VAR_Event : Danfoss_Event_Type;
		VAR_Fault : BOOL; (*Memory Output Generic*)
		VAR_FirstCycle : BOOL;
		VAR_AutoSpeed : REAL;
		VAR_Isolated : BOOL;
		VAR_Overload : BOOL;
		VAR_Auto : BOOL;
		VAR_Mask : BOOL;
		VAR_Start : BOOL; (*Motor start*)
		zzEdge00000 : BOOL;
		zzEdge1 : BOOL;
		zzEdge2 : BOOL;
		zzEdge3 : BOOL;
		zzEdge4 : BOOL;
		zzEdge5 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Motor_Vfd
	VAR_INPUT
		IN_Simulation : BOOL;
		IN_ConfigPresent : BOOL; (*Configuration: Device Present*)
		IN_Enable : BOOL;
		IN_AutoCnd : BOOL; (*Automation Logic Input*)
		IN_AutoSpeed : REAL;
		IN_Reverse : BOOL;
		IN_FrequencyMin : REAL;
		IN_FrequencyMax : REAL;
		IN_ManEn : BOOL; (*Control: Manual On Enabled*)
		IN_MaskEn : BOOL; (*Control: Alarm Mask Enable*)
		IN_Reset : BOOL; (*Control: Alarm Reset Push Button*)
		IN_HMIAutoForce : BOOL;
		IN_QuickStopCmd : BOOL; (*Control: Quick Stop Command (TRUE = Quick Stop)*)
		IN_JOGMode : BOOL; (*Control: JOG Mode (if TRUE)*)
		IN_JOGCnd : BOOL; (*Control: JOG Running Condition*)
		IN_CoastingCmd : BOOL; (*Control: Coasting (TRUE = Coasting)*)
		IN_FCD : BOOL; (*Configuration: Drive Type FCD V4.A.A.1.6.13*)
		IN_FBKDelay : TIME := T#500ms; (*Time: Running Control Delay*)
		IN_SafetyCtrlEn : BOOL; (*Configuration: Drive SafeOFF Enabled TRUE = Control Enabled*)
		IN_ScaleMax : REAL := 100.0; (*Configuration: Drive speed Scale Maximum Value*)
	END_VAR
	VAR_OUTPUT
		OUT_InOperation : BOOL;
		OUT_DriveSafetyFBKFault : BOOL; (*Safety XOR 37*)
		OUT_DriveFault : BOOL; (*Drive fault (from STW) or high current*)
		OUT_IsolatedFault : BOOL;
		OUT_OverloadFault : BOOL;
		OUT_ActualSpeed : REAL;
		OUT_ActualFrequency : REAL;
		OUT_ActualCurrent : REAL;
		OUT_ActualTorque : REAL;
		OUT_ActualPower : REAL;
		OUT_ActualSpeedRPM : REAL;
		OUT_Warning : BOOL; (*Drive warning (from STW)*)
		OUT_SpeedReferece : BOOL;
		OUT_ActualDigitalState : Danfoss_DI_Type; (*V1.7.2*)
	END_VAR
	VAR_IN_OUT
		HMI_Danfoss : HMI_Danfoss_Diag_Type;
		HMI_Motor : HMI_Motor_FC_Type;
		IO_Danfoss : IO_PLK_Danfoss_Drive_Type;
		IO_Motor : IO_Motor_Type;
	END_VAR
	VAR
		VAR_RecSTW : Danfoss_STW_Type;
		VAR_RecDI : Danfoss_DI_Type; (*V4.A.A.1.6.13*)
		VAR_SendCTW : Danfoss_CTW_Type;
		TMR_TON_CurrentHigh : TON;
		TMR_TON_FaultFilter : TON;
		TMR_TON_FBKTimeOut : TON;
		TMR_TON_RFeedBack : TON;
		TMR_TON_WarningFilter : TON;
		VAR_CurrentHigh : BOOL;
		VAR_Event : Danfoss_Event_Type;
		VAR_Fault : BOOL; (*Memory Output Generic*)
		VAR_FirstCycle : BOOL;
		VAR_AutoSpeed : REAL;
		VAR_Isolated : BOOL;
		VAR_Overload : BOOL;
		VAR_Auto : BOOL;
		VAR_Mask : BOOL;
		VAR_Start : BOOL; (*Motor start*)
		zzEdge00000 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Valve_Dig_Mac (*Valve Control: Digital*)
	VAR_INPUT
		IN_ConfigPresent : BOOL; (*Configuration: Device Present*)
		IN_ConfigType : BOOL; (*Configuration: Device Type (0: Monostable - 1: Bistable)*)
		IN_Simulation : BOOL;
		IN_ConfigPositionSensorOpened : BOOL;
		IN_ConfigPositionSensorClosed : BOOL;
		IN_StrokeTime : TIME;
		IN_Enable : BOOL;
		IN_AutoCnd : BOOL; (*Automation Logic Input*)
		IN_EnableCnd : BOOL;
		IN_Cnd : BOOL;
		IN_FlipEnable : BOOL;
		IN_FlipRequest : BOOL;
		IN_FlipTime : TIME;
		IN_Reset : BOOL; (*Fault Reset*)
		IN_HMIAutoForce : BOOL;
		IN_ManEn : BOOL;
		IN_MaskEn : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT : BOOL; (*Stroke done*)
		OUT_Alarm : BOOL; (*Fault Output for Alarm*)
		OUT_OpenedFiltered : BOOL; (*Stroke done*)
		OUT_ClosedFiltered : BOOL; (*Stroke done*)
		OUT_FlipDone : BOOL;
	END_VAR
	VAR_IN_OUT
		IO : IO_ValveMac_Type;
		HMI : HMI_Valve_Type;
	END_VAR
	VAR
		VAR_Enable : BOOL;
		VAR_iFault : BOOL;
		VAR_Mask : BOOL;
		TMR_TOF_FeedBackOpen : TOF;
		TMR_TOF_FeedBackClose : TOF;
		VAR_ManOn : BOOL;
		VAR_Auto : BOOL;
		MAX_Flip_Time : TIME := T#1S;
		VAR_AutoCnd : BOOL;
		VAR_ConfigPosition : BOOL;
		TMR_TON_ControlEnableDelay : TON;
		TMR_TON_Opened : TON;
		TMR_TON_Closed : TON;
		VAR_FeedBackOpen : BOOL;
		VAR_FeedBackClose : BOOL;
		VAR_ValveOpened : BOOL;
		VAR_Fault : BOOL;
		TMR_TP_Block : TP_Reset;
		TMR_TP_Release : TP_Reset;
		TMR_TON_Flip : TON;
		VAR_ValveClosed : BOOL;
		TMR_TON_ClosedFilter : TON;
		TMR_TON_OpenedFilter : TON;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Valve_Dig (*Valve Control: Digital*)
	VAR_INPUT
		IN_ConfigPresent : BOOL; (*Configuration: Device Present*)
		IN_ConfigType : BOOL; (*Configuration: Device Type (0: Monostable - 1: Bistable)*)
		IN_ConfigNormallyOpen : BOOL; (*Configuration: Device Type (0: Normally Closed - 1: Normally Open) v1.5*)
		IN_Simulation : BOOL;
		IN_ConfigPositionSensorOpened : BOOL;
		IN_ConfigPositionSensorClosed : BOOL;
		IN_StrokeTime : TIME;
		IN_Enable : BOOL;
		IN_AutoCnd : BOOL; (*Automation Logic Input*)
		IN_EnableCnd : BOOL;
		IN_Cnd : BOOL;
		IN_FlipEnable : BOOL;
		IN_FlipRequest : BOOL;
		IN_FlipTime : TIME;
		IN_Reset : BOOL; (*Fault Reset*)
		IN_HMIAutoForce : BOOL;
		IN_ManEn : BOOL;
		IN_MaskEn : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT : BOOL; (*Stroke done*)
		OUT_Alarm : BOOL; (*Fault Output for Alarm*)
		OUT_OpenedFiltered : BOOL; (*Stroke done*)
		OUT_ClosedFiltered : BOOL; (*Stroke done*)
		OUT_FlipDone : BOOL;
	END_VAR
	VAR_IN_OUT
		IO : IO_Valve_Type;
		HMI : HMI_Valve_Type;
	END_VAR
	VAR
		VAR_Enable : BOOL;
		VAR_iFault : BOOL;
		VAR_Mask : BOOL;
		TMR_TOF_FeedBackOpen : TOF;
		TMR_TOF_FeedBackClose : TOF;
		VAR_ManOn : BOOL;
		VAR_Auto : BOOL;
		MAX_Flip_Time : TIME := T#1S;
		VAR_AutoCnd : BOOL;
		VAR_ConfigPosition : BOOL;
		TMR_TON_ControlEnableDelay : TON;
		TMR_TON_Opened : TON;
		TMR_TON_Closed : TON;
		VAR_FeedBackOpen : BOOL;
		VAR_FeedBackClose : BOOL;
		VAR_ValveOpened : BOOL;
		VAR_Fault : BOOL;
		TMR_TON_Flip : TON;
		VAR_ValveClosed : BOOL;
		TMR_TON_ClosedFilter : TON;
		TMR_TON_OpenedFilter : TON;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Valve_Mod
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_Simulation : BOOL;
		IN_ConfigPositionSensorOpened : BOOL;
		IN_ConfigPositionSensorClosed : BOOL;
		IN_ConfigPositionAnalogFBK : BOOL;
		IN_StrokeTime : TIME;
		IN_ConfigNormallyOpen : BOOL;
		IN_Enable : BOOL;
		IN_AutoCnd : BOOL;
		IN_AutoVal : REAL;
		IN_OpeningRampEn : BOOL;
		IN_OpeningRampValue : REAL;
		IN_ClosingRampEn : BOOL;
		IN_ClosingRampValue : REAL;
		IN_OutMin : REAL; (*Min Opening [%]*)
		IN_OutMax : REAL; (*Max Opening [%]*)
		IN_HMIAutoForce : BOOL;
		IN_ManEn : BOOL;
		IN_MaskEn : BOOL;
		IN_Reset : BOOL; (*Fault Reset*)
	END_VAR
	VAR_OUTPUT
		OUT_Cv : REAL; (*Analog output (0.0 - 100.0)*)
		OUT_Alarm : BOOL; (*Falt Output for Alarm*)
		OUT_RampDone : BOOL; (*Ramp Done*)
		OUT_FBKFault : BOOL;
		OUT_FBK : REAL; (*Analog Input FeedBack Value 0.0 - 100.0%*)
	END_VAR
	VAR_IN_OUT
		IO : IO_Valve_Mod_Type;
		HMI : HMI_Valve_Mod_Type;
	END_VAR
	VAR
		VAR_Fault : BOOL; (*Falt Output for Alarm*)
		VAR_iFault : BOOL;
		VAR_ConfigPosition : BOOL;
		VAR_OutMan : REAL;
		VAR_Open : REAL;
		VAR_iOpen : REAL;
		TMR_TOF_DOValveOn : TOF;
		VAR_FirstCycle : BOOL;
		VAR_DOValveOn : BOOL;
		VAR_DOValveOff : BOOL;
		VAR_DIFeedBackOpen : BOOL;
		VAR_DIFeedBackClose : BOOL;
		VAR_Mask : BOOL;
		TMR_TON_PositionFiltered : TON;
		VAR_ManOn : BOOL;
		VAR_Auto : BOOL;
		LCRMovingRamp : LCRRamp;
		VAR_OpeningRamp : REAL;
		VAR_ClosingRamp : REAL;
		LCRLimScal_AO : LCRLimScal;
		LCRLimScal_AI : LCRLimScal;
		VAR_FaultSensorOn : BOOL;
		VAR_FaultSensorOff : BOOL;
		VAR_FaultSensorFBK : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Fan_Obj
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_RoofType : BOOL; (*0: Fan 1: Galvani*)
		IN_GalvaniRoofFlowSet : BOOL;
		IN_CgfHmiLampOn : BOOL;
		IN_FanNumber : USINT := 1;
		IN_AutoSpeed : REAL;
		IN_Enable : BOOL;
		IN_HMIAutoForce : BOOL;
		IN_Reset : BOOL; (*Control: Alarm Reset Push Button*)
	END_VAR
	VAR_OUTPUT
		OUT_Alarm : BOOL;
		Out_Light : BOOL; (*v4.A.A.1.7.0*)
		OUT_OverloadFault : BOOL;
	END_VAR
	VAR_IN_OUT
		IO : IO_FanMain_Type;
		HMI : HMI_Fan_Type;
		ALARM : FanZoneAlarm_Type;
	END_VAR
	VAR
		TMR_TON_OnDelay : ARRAY[1..6] OF TON;
		TMR_TON_OffDelay : ARRAY[1..6] OF TON;
		VAR_Auto : ARRAY[1..6] OF BOOL;
		TMR_TON_OnDelay_Gal : TON;
		TMR_TON_OffDelay_Gal : TON;
		VAR_Auto_Gal : BOOL;
		VAR_OUT : REAL;
		VAR_GalvaniOn : BOOL;
		VAR_GalvaniFlowSet : BOOL;
		VAR_AbsoluteFilter : BOOL;
		VAR_PreFilter : BOOL;
		VAR_PressurizedOnAlarm : BOOL;
		VAR_ResetHMI : BOOL;
		VAR_i : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MotionFan_Obj
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_Enable : BOOL; (*Safety OK ( True if not used)*)
		IN_AutoCnd : BOOL; (*Automation Logic Input*)
		IN_Reset : BOOL; (*Fault Reset*)
		IN_FBKDelay : TIME := T#500ms; (*Time: Running Control Delay*)
	END_VAR
	VAR_OUTPUT
		OUT_Running : BOOL; (*Motor On*)
		OUT_IsolatedFault : BOOL;
		OUT_ContactorFBKFault : BOOL;
		OUT_OverloadFault : BOOL;
		OUT_Alarm : BOOL; (*Output for Alarm*)
	END_VAR
	VAR_IN_OUT
		IO : IO_MotionFan_Type;
	END_VAR
	VAR
		TMR_TOF : TON;
		TMR_TON : TON;
		VAR_ContactorFBK : BOOL;
		VAR_Isolated : BOOL;
		VAR_Overload : BOOL;
		VAR_Fault : BOOL; (*Alarm Output for Fault or Warning*)
	END_VAR
END_FUNCTION_BLOCK
(*Shift Register Object*)

FUNCTION_BLOCK CapPhotoCell_SftObj_old (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN_ConfigPresent : BOOL; (*Configuration: Device Present*)
		IN_Enable : BOOL; (*Configuration: Enable *)
		IN_Alarm : BOOL; (*Configuration: Timeout Alarm Control Enable*)
		IN_WaitOn : BOOL; (*Control: On State Wait Request*)
		IN_WaitOff : BOOL; (*Control: Off State Wait Request*)
		IN_MachinePitch : BOOL; (*Control: Machine Pitch Pulse*)
		IN_ResetCounters : BOOL;
		IN_MaskEn : BOOL; (*Control: Mask Enable*)
		IN_GrippersNumber : USINT; (*Control : Grip Number For Repetitive Control*)
		IN_CBlockAbsoluteValue : USINT; (*Control: Container Stop Threshold For Absolute Container Lack*)
		IN_CBlockRepetitiveValue : USINT; (*Control: Container Stop Threshold For Repetitive Container Lack*)
		IN_MStopAbsoluteValue : USINT; (*Control: Critical Stop Threshold For Absolute Container Lack*)
		IN_MStopConsecutiveValue : USINT; (*Control: Critical Stop Threshold For Consecutive Container Lack*)
	END_VAR
	VAR_OUTPUT
		OUT : BOOL; (*State Switching Delayed*)
		OUT_CBlockRepetitive : BOOL; (*Container Stop For Repetitive Lack Errors*)
		OUT_CBlockAbsolute : BOOL; (*Container Stop For Absolute Lack Errors*)
		OUT_MStopConsecutive : BOOL; (*Critical Stop For Consecutive*)
		OUT_MStopAbsolute : BOOL; (*Critical Stop For Absolute*)
		OUT_AlwaysTrueError : BOOL;
	END_VAR
	VAR_IN_OUT
		IO : IO_Digital_IN_Type; (*State: Digital Input Structure*)
		HMI : HMI_Photocell_Type;
		SHIFT_Position : UINT;
	END_VAR
	VAR CONSTANT
		CST_AlwaysTrueMaxSteps : USINT := 10; (*Max Number Of Steps With The Photocell Always TRUE*)
		CST_RepetitiveArrayDim : USINT := 50; (*Repetitive Array Dimension*)
	END_VAR
	VAR
		TMR_TON_TotalCounterReset : TON;
		VAR_Mask : BOOL;
		VAR_Signal : BOOL;
		VAR_CounterResetMemory : BOOL;
		VAR_TotalCounterResetMemory : BOOL;
		VAR_EdgeChecked : BOOL;
		VAR_GrippersNumber : USINT;
		VAR_ActualValveCounter : USINT := 1;
		VAR_RepetitiveCounterArray : ARRAY[1..CST_RepetitiveArrayDim] OF USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK CapPhotoCell_SftObj (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN_ConfigPresent : BOOL; (*Configuration: Device Present*)
		IN_Enable : BOOL; (*Configuration: Enable *)
		IN_Alarm : BOOL; (*Configuration: Timeout Alarm Control Enable*)
		IN_WaitOn : BOOL; (*Control: On State Wait Request*)
		IN_WaitOff : BOOL; (*Control: Off State Wait Request*)
		IN_MachinePitch : BOOL; (*Control: Machine Pitch Pulse*)
		IN_ResetCounters : BOOL; (*V1.61 Reset Absolute Errors*)
		IN_ResetCountersConsecutive : BOOL; (*V1.61 Reset Consecutive errors*)
		IN_MaskEn : BOOL; (*Control: Mask Enable*)
		IN_GrippersNumber : USINT; (*Control : Grip Number For Repetitive Control*)
		IN_CBlockAbsoluteValue : USINT; (*Control: Container Stop Threshold For Absolute Container Lack*)
		IN_CBlockAbsoluteQuantity : UINT; (*Control: Critical Stop Threshold For Consecutive Container Lack*)
		IN_CBlockRepetitiveValue : USINT; (*Control: Container Stop Threshold For Repetitive Container Lack*)
		IN_MStopConsecutiveValue : USINT; (*Control: Critical Stop Threshold For Consecutive Container Lack*)
	END_VAR
	VAR_OUTPUT
		OUT : BOOL; (*State Switching Delayed*)
		OUT_CBlockRepetitive : BOOL; (*Container Stop For Repetitive Lack Errors*)
		OUT_CBlockAbsolute : BOOL; (*Container Stop For Absolute Lack Errors*)
		OUT_MStopConsecutive : BOOL; (*Critical Stop For Consecutive*)
		OUT_AlwaysTrueError : BOOL;
	END_VAR
	VAR_IN_OUT
		IO : IO_Digital_IN_Type; (*State: Digital Input Structure*)
		HMI : HMI_Photocell_Type;
		SHIFT_Position : UINT;
	END_VAR
	VAR CONSTANT
		CST_AlwaysTrueMaxSteps : USINT := 10; (*Max Number Of Steps With The Photocell Always TRUE*)
		CST_CounterArrayDim : USINT := 50; (*Repetitive Array Dimension*)
	END_VAR
	VAR
		TMR_TON_TotalCounterReset : TON;
		VAR_AbsoluteErrorN : USINT := 1;
		VAR_Mask : BOOL;
		VAR_Signal : BOOL;
		VAR_CounterResetMemory : BOOL;
		VAR_CounterConsResetMemory : BOOL; (*V1.61*)
		VAR_TotalCounterResetMemory : BOOL;
		VAR_EdgeChecked : BOOL;
		VAR_GrippersNumber : USINT;
		VAR_ActualValveCounter : USINT := 1;
		VAR_i : USINT;
		VAR_CapsReleased : UDINT;
		VAR_AbsoluteCounterArray : ARRAY[1..CST_CounterArrayDim] OF UDINT;
		VAR_RepetitiveCounterArray : ARRAY[1..CST_CounterArrayDim] OF USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Ejector_SftObj (* Container Ejector Valve *)
	VAR_INPUT
		IN_ConfigPresent : BOOL; (*Configuration: Device Present*)
		IN_ConfigType : BOOL; (*Configuration: Device Type (0: Monostable - 1: Bistable)*)
		IN_Enable : BOOL;
		IN_MachinePitch : BOOL;
		IN_FillingErrorEject : BOOL;
		IN_SamplingModeActive : BOOL; (*V1.61*)
		IN_ResetCounters : BOOL;
		IN_HMIAutoForce : BOOL;
		IN_ManEn : BOOL;
		IN_MaskEn : BOOL;
		IN_ShiftPosition : UINT;
		IN_CBlockAbsoluteValue : USINT; (*Control: Container Stop Threshold For Absolute Container Lack*)
		IN_MStopConsecutiveValue : USINT; (*Control: Machine Stop Threshold For Consecutive Container Lack*)
	END_VAR
	VAR_OUTPUT
		OUT : BOOL; (*Stroke done*)
		OUT_CBlockAbsolute : BOOL; (*Container Stop For Absolute Lack Errors*)
		OUT_MStopConsecutive : BOOL; (*Critical Stop For Consecutive*)
	END_VAR
	VAR_IN_OUT
		IO : IO_Valve_Type;
		HMI : HMI_Valve_Ejector_Type;
	END_VAR
	VAR
		TMR_TON_TotalCounterReset : TON;
		VAR_Mask : BOOL;
		VAR_ManOn : BOOL;
		VAR_Auto : BOOL;
		VAR_AutoCnd : BOOL;
		VAR_CounterResetMemory : BOOL;
		VAR_TotalCounterResetMemory : BOOL;
		VAR_ValveOpened : BOOL;
		VAR_ValveClosed : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK PhotoCell_SftObj (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN_ConfigPresent : BOOL; (*Configuration: Device Present*)
		IN_Enable : BOOL; (*Configuration: Enable *)
		IN_Alarm : BOOL; (*Configuration: Alarm Control Enable*)
		IN_WaitOn : BOOL; (*Control: On State Wait Request*)
		IN_WaitOff : BOOL; (*Control: Off State Wait Request*)
		IN_MachinePitch : BOOL; (*Control: Machine Pitch Pulse*)
		IN_ResetCounters : BOOL;
		IN_WritePresenceEnable : BOOL; (*Configuration Type of Photocell (0: Disabel Write Presence, 1: Enable Write Presence)*)
		IN_MaskEn : BOOL; (*Control: Mask Enable*)
		IN_GrippersNumber : USINT; (*Control : Grip Number For Repetitive Control*)
		IN_CBlockAbsoluteValue : USINT; (*Control: Container Stop Threshold For Absolute Container Lack*)
		IN_CBlockRepetitiveValue : USINT; (*Control: Container Stop Threshold For Repetitive Container Lack*)
		IN_MStopAbsoluteValue : USINT; (*Control: Machine Stop Threshold For Absolute Container Lack*)
		IN_MStopConsecutiveValue : USINT; (*Control: Machine Stop Threshold For Consecutive Container Lack*)
	END_VAR
	VAR_OUTPUT
		OUT : BOOL; (*State Switching Delayed*)
		OUT_CBlockRepetitive : BOOL; (*Container Stop For Repetitive Lack Errors*)
		OUT_CBlockAbsolute : BOOL; (*Container Stop For Absolute Lack Errors*)
		OUT_MStopConsecutive : BOOL; (*Critical Stop For Consecutive*)
		OUT_MStopAbsolute : BOOL; (*Critical Stop For Absolute*)
		OUT_AlwaysTrueError : BOOL;
	END_VAR
	VAR_IN_OUT
		IO : IO_Digital_IN_Type; (*State: Digital Input Structure*)
		HMI : HMI_Photocell_Type;
		SHIFT_Position : UINT;
	END_VAR
	VAR CONSTANT
		CST_AlwaysTrueMaxSteps : USINT := 10; (*Max Number Of Steps With The Photocell Always TRUE*)
		CST_RepetitiveArrayDim : USINT := 50; (*Repetitive Array Dimension*)
	END_VAR
	VAR
		TMR_TON_TotalCounterReset : TON;
		VAR_Mask : BOOL;
		VAR_Signal : BOOL;
		VAR_CounterResetMemory : BOOL;
		VAR_TotalCounterResetMemory : BOOL;
		VAR_EdgeChecked : BOOL;
		VAR_GrippersNumber : USINT;
		VAR_ActualValveCounter : USINT := 1;
		VAR_RepetitiveCounterArray : ARRAY[1..CST_RepetitiveArrayDim] OF USINT;
	END_VAR
END_FUNCTION_BLOCK
