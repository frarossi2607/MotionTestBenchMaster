
FUNCTION FC_Parity : BOOL (*TRUE = Even - FALSE = ODD*)
	VAR_INPUT
		IN_Value : DINT;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK AlarmScheduler (*V4.A.A.1.6.13*)
	VAR_INPUT
		AlarmAreaCfg : ARRAY[0..24] OF AlarmAreaCfg_Type;
		AdrAlarm : UDINT;
		AdrAlarmCFG : UDINT;
		AdrAlarmOldStatus : UDINT;
		AdrHMI : UDINT;
	END_VAR
	VAR_OUTPUT
		AlarmAction : ActionSum_Type;
	END_VAR
	VAR_IN_OUT
		FirstAlarmActive : AlarmCFG_Type;
		FirstExternalAlarmActive : AlarmCFG_Type;
		FirstCriticalAlarmActive : AlarmCFG_Type; (*V4.A.A.1.7.0*)
		FirstAlertAlarmActive : AlarmCFG_Type; (*V4.A.A.1.7.0*)
		FirstExtCriticalAlarmActive : AlarmCFG_Type; (*V4.A.A.1.7.0*)
		FirstExtAlertAlarmActive : AlarmCFG_Type; (*V4.A.A.1.7.0*)
		FirstCsAlarmActive : AlarmCFG_Type; (*V4.A.A.1.7.0*)
		FirstCsExtAlarmActive : AlarmCFG_Type; (*V4.A.A.1.7.5a*)
		CriticalAcknoledgeRequest : BOOL;
		AlarmAcknoledgeRequest : BOOL;
	END_VAR
	VAR
		Alarm : REFERENCE TO AlarmCmd_Type;
		AlarmOldStatus : REFERENCE TO BOOL;
		AlarmCFG : REFERENCE TO AlarmCFG_Type;
		HMI : REFERENCE TO BYTE;
		AlarmActionTemp : ActionSum_Type;
		i : UINT;
		x : UINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FirstAlarmCombiner (*V4.A.A.1.6.13*)
	VAR_INPUT
		SkidAlarmFrom : UINT := 1;
		SkidAlarmTo : UINT;
		SkidFirstAlarm : INT;
		SkidFirstExternalAlarm : INT;
		AdrAlarmCFG : UDINT; (*V1.7.4*)
	END_VAR
	VAR_IN_OUT
		FirstAlarmActive : AlarmCFG_Type;
		FirstExternalAlarmActive : AlarmCFG_Type;
	END_VAR
	VAR
		AlarmCFG : REFERENCE TO AlarmCFG_Type; (*V1.7.4*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK AnalogTotalizer
	VAR_INPUT
		IN_Pulse : BOOL;
		IN_AnalogPV : REAL;
		IN_PulseWeight : REAL;
		IN_ConfigType : USINT; (*Configuaration Time to mapping if analog value is used
(0 = Pulse, 1 = Hours, 2 = Minutes, 3 = Seconds)*)
		IN_Reset : BOOL; (*Reset totalizer*)
	END_VAR
	VAR_IN_OUT
		OUT_TotalCounter : REAL; (*Out Total Counter*)
	END_VAR
	VAR
		RTInfo : RTInfo;
		VAR_AuxPulse : REAL;
		zzEdge00000 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK CyclicActivation
	VAR_INPUT
		IN_CycleTime : TIME;
	END_VAR
	VAR_OUTPUT
		OUT_A : BOOL;
		OUT_B : BOOL;
	END_VAR
	VAR
		TMR_TON_CycleA : TON;
		TMR_TON_CycleB : TON;
		VAR_RtInfo : RTInfo;
		VAR_CycleCounter : REAL;
		VAR_CycleTime : REAL;
		VAR_Cycle : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION ComboBoxString : BOOL
	VAR_INPUT
		IN_ElementsStructure : ARRAY[0..19] OF HMI_ComboBoxElements_Type; (*vrma*)
		OUT_ComboString : REFERENCE TO STRING[500];
	END_VAR
	VAR
		VAR_ElementsIndex : USINT;
		VAR_StrIndex : STRING[2];
		VAR_StrComma : STRING[1];
		VAR_StrSemicolun : STRING[1];
	END_VAR
END_FUNCTION

FUNCTION LftConAirPressSp : REAL
	VAR_INPUT
		RcpPressureSp : REAL;
		RcpCanDiameter : REAL;
	END_VAR
	VAR CONSTANT
		CST_PistonDiameterExt : REAL := 40.0; (*[mm]*)
		CST_PistonDiameterInt : REAL := 16.0; (*[mm]*)
		CST_PistonSpringStrengthRse : REAL := 120.0; (*[N]*)
	END_VAR
	VAR
		VAR_PistonSurface : REAL; (*[mm2]*)
		VAR_DeltaPProduct : REAL; (*[N]*)
		VAR_DeltaPrexPist : REAL; (*[bar]*)
		VAR_PbasePiston : REAL; (*[bar]*)
	END_VAR
END_FUNCTION

FUNCTION_BLOCK FB_Blinker
	VAR_INPUT
		IN_Freq : REAL;
	END_VAR
	VAR_OUTPUT
		OUT : BOOL;
	END_VAR
	VAR
		TMR_TON_OnDelay : TON;
		TMR_TON_OffDelay : TON;
		VAR_TimeValue : TIME;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_Start
	VAR_IN_OUT
		HMI_Data : HMI_ITC_Data_Type;
		AnalogIndexIn : UINT;
		DigitalIndexIn : UINT;
		AnalogIndexOut : UINT;
		DigitalIndexOut : UINT;
	END_VAR
	VAR
		i : UINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_DigitalBool
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_Alarm : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : BOOL;
	END_VAR
	VAR_IN_OUT
		ITC_IO : BOOL;
		ITC : BOOL;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Auto : BOOL := TRUE;
		VAR_Man : BOOL := FALSE;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
		zzEdge00002 : BOOL;
		zzEdge00003 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_DigitalByte
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_Alarm : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_HMIAutoForce : BOOL;
		IN_BitNumber : INT;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : BOOL;
	END_VAR
	VAR_IN_OUT
		ITC_IO : BYTE;
		ITC : BOOL;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Auto : BOOL := TRUE;
		VAR_Man : BOOL := FALSE;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_BitArray : ARRAY[0..7] OF BOOL;
		VAR_BitIndex : USINT;
		VAR_OldPage : USINT;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
		zzEdge00002 : BOOL;
		zzEdge00003 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_DigitalUsint
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_Alarm : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_HMIAutoForce : BOOL;
		IN_BitNumber : INT;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : BOOL;
	END_VAR
	VAR_IN_OUT
		ITC_IO : USINT;
		ITC : BOOL;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Auto : BOOL := TRUE;
		VAR_Man : BOOL := FALSE;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_BitArray : ARRAY[0..7] OF BOOL;
		VAR_BitIndex : USINT;
		VAR_OldPage : USINT;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
		zzEdge00002 : BOOL;
		zzEdge00003 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_DigitalInt
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_Alarm : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_HMIAutoForce : BOOL;
		IN_BitNumber : INT;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : BOOL;
	END_VAR
	VAR_IN_OUT
		ITC_IO : INT;
		ITC : BOOL;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Auto : BOOL := TRUE;
		VAR_Man : BOOL := FALSE;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_BitArray : ARRAY[0..15] OF BOOL;
		VAR_BitIndex : USINT;
		VAR_OldPage : USINT;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
		zzEdge00002 : BOOL;
		zzEdge00003 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogByte
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : BYTE;
	END_VAR
	VAR_IN_OUT
		ITC_IO : BYTE;
		ITC : BYTE;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_ManValue : BYTE := 0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogUsint
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : USINT;
	END_VAR
	VAR_IN_OUT
		ITC_IO : USINT;
		ITC : USINT;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_ManValue : USINT := 0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogInt
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : INT;
	END_VAR
	VAR_IN_OUT
		ITC_IO : INT;
		ITC : INT;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_Value : INT;
		VAR_ManValue : INT := 0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogIntOverUsint
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : INT;
	END_VAR
	VAR_IN_OUT
		ITC_IO : USINT;
		ITC : INT;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_RawValue : INT;
		VAR_Value : INT;
		VAR_ManValue : INT := 0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogUintOverUsint
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : UINT;
	END_VAR
	VAR_IN_OUT
		ITC_IO : USINT;
		ITC : UINT;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_RawValue : UINT;
		VAR_Value : UINT;
		VAR_ManValue : UINT := 0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogDInt
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : DINT;
	END_VAR
	VAR_IN_OUT
		ITC_IO : DINT;
		ITC : DINT;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_Value : DINT;
		VAR_ManValue : DINT := 0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogUdint
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : UDINT;
	END_VAR
	VAR_IN_OUT
		ITC_IO : UDINT;
		ITC : UDINT;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_Value : UDINT;
		VAR_ManValue : UDINT := 0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogDIntOverUsint
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : DINT;
	END_VAR
	VAR_IN_OUT
		ITC_IO : USINT;
		ITC : DINT;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_RawValue : DINT;
		VAR_Value : DINT;
		VAR_ManValue : DINT := 0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogReal
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_Description : STRING[100];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : REAL;
	END_VAR
	VAR_IN_OUT
		ITC_IO : REAL;
		ITC : REAL;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_Value : REAL;
		VAR_ManValue : REAL := 0.0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogRealOverUsint
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_Description : STRING[100];
		IN_HMIAutoForce : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : REAL;
	END_VAR
	VAR_IN_OUT
		ITC_IO : USINT;
		ITC : REAL;
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_RawValue : REAL;
		VAR_Value : REAL;
		VAR_ManValue : REAL := 0.0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
		RealValue : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_End
	VAR_INPUT
		IN_IODigAnalog : BOOL; (*0: DIGITAL 1: ANALOG*)
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
	END_VAR
	VAR_IN_OUT
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_ProgressiveId : UINT;
		i : UINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_FastDigitalByte
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_Alarm : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_HMIAutoForce : BOOL;
		ITC : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : BOOL;
	END_VAR
	VAR_IN_OUT
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Auto : BOOL := TRUE;
		VAR_Man : BOOL := FALSE;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
		zzEdge00002 : BOOL;
		zzEdge00003 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_FastAnalogInt
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_HMIAutoForce : BOOL;
		ITC : INT;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : INT;
	END_VAR
	VAR_IN_OUT
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_ManValue : INT := 0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_FastAnalogDInt
	VAR_INPUT
		IN_Visibility : BOOL;
		IN_ReadOnly : BOOL;
		IN_Wait : BOOL;
		IN_IOType : BOOL; (*0: INPUT 1: OUTPUT*)
		IN_Description : STRING[100];
		IN_MinValue : REAL;
		IN_MaxValue : REAL;
		IN_Unit : STRING[10];
		IN_HMIAutoForce : BOOL;
		ITC : DINT;
	END_VAR
	VAR_OUTPUT
		OUT_Man : BOOL;
		OUT_ManValue : DINT;
	END_VAR
	VAR_IN_OUT
		HMI_Data : HMI_ITC_Data_Type;
		HMI_Page : HMI_ITC_Page_Type;
		Index : UINT;
	END_VAR
	VAR
		VAR_Man : BOOL := FALSE;
		VAR_ManValue : DINT := 0;
		VAR_PageSwitch : BOOL := TRUE;
		VAR_ProgressiveId : UINT;
		VAR_OldPage : USINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_Counter
	VAR_INPUT
		IN_Clock1Hz : BOOL;
		IN_TimeCondition : BOOL;
		IN_IncrementCondition : BOOL;
		IN_PulseWeight : REAL;
		IN_Reset : BOOL;
		IN_Date : DATE_AND_TIME;
	END_VAR
	VAR_IN_OUT
		IN_OUT_CounterPartialStruct : Counters_Type;
		IN_OUT_CounterTotalStruct : Counters_Type;
	END_VAR
	VAR
		tempReal : REAL := 0.0;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION FC_Counter : BOOL (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN_Clock1Hz : BOOL;
		IN_TimeCondition : BOOL;
		IN_IncrementCondition : BOOL;
		IN_Reset : BOOL;
		IN_Date : DATE_AND_TIME;
	END_VAR
	VAR_IN_OUT
		IN_OUT_CounterPartialStruct : Counters_Type;
		IN_OUT_CounterTotalStruct : Counters_Type;
	END_VAR
END_FUNCTION

FUNCTION FC_IncTimer : BOOL (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN_Clock1Hz : BOOL;
		IN_Condition : BOOL;
		IN_Reset : BOOL;
	END_VAR
	VAR_IN_OUT
		IN_OUT_CounterStruct : CounterTime_Type;
	END_VAR
END_FUNCTION

FUNCTION FC_SpeedCheck : BOOL (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN_SpeedReq : REAL;
		IN_SpeedAct : REAL;
		IN_Mode : USINT; (*0 = Equal
1 = Greater
2 = Lower*)
	END_VAR
END_FUNCTION

FUNCTION FC_ReminderShift : INT (*Reminder With Minimum Value*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Dividend : INT;
		Divisor : INT;
		Start : INT;
	END_VAR
	VAR
		ReminderA : INT;
		ReminderB : INT;
		ReminderC : INT;
		LocalDivisor : INT;
	END_VAR
END_FUNCTION

FUNCTION FC_MacaoTimer : BOOL (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IN_Clock1Hz : BOOL;
		IN_Condition : BOOL;
		IN_Reset : BOOL;
	END_VAR
	VAR_IN_OUT
		IN_OUT_Counter : UDINT;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK Integral
	VAR_INPUT
		IN_NewValue : REAL; (*New value*)
		IN_IntCycle : REAL; (*Cycle time*)
	END_VAR
	VAR_IN_OUT
		OUT_Integral : REAL; (*Integrated value*)
	END_VAR
	VAR
		VAR_OldValue : REAL := 0.0; (*Old value*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK LevelVariation
	VAR_INPUT
		IN_Enable : BOOL; (*Function Enable*)
		IN_TankVolumePV : REAL; (*Actual Tank Volume [l]*)
		IN_ControlTime : REAL; (*Level Control Scan Time  [s]*)
	END_VAR
	VAR_OUTPUT
		OUT_Low : BOOL; (*Low Flow Required*)
		OUT_High : BOOL; (*High Flow Required*)
	END_VAR
	VAR
		OldVolume : REAL;
		VAR_RTInfo : RTInfo;
		Timer : REAL;
		VAR_Cycle : REAL;
		DeltaVolume : REAL;
		AbsoluteError : REAL; (*Level Error (no sign)*)
		RestoreTime : REAL; (*Number of Cycles with no Negative Variation*)
	END_VAR
	VAR CONSTANT
		RestoreTimeLimit : REAL := 50.0; (*Number of Cycles Limit with no Negative Variation*)
	END_VAR
	VAR
		RestoreError : REAL; (*Number of Cycles in Idle*)
	END_VAR
	VAR CONSTANT
		RestoreErrorLimit : REAL := 50.0; (*Number of Cycles Limit in Idle*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK PID_Cont
	VAR_INPUT
		IN_ConfigPresent : BOOL; (*Enables PID execution and visualization on HMI*)
		IN_ConfigEngValue : BOOL; (*Configuration: FF and PID OUT Scale - TRUE-> 0-100%, FALSE-> Ing.Unit.*)
		IN_Reverse : BOOL; (*Reverse action (bigger the error smaller the output)*)
		IN_Gain : REAL; (*Proportional gain*)
		IN_TI : REAL; (*Reset time*)
		IN_TD : REAL; (*Derivative time*)
		IN_PV : REAL; (*Process Value for PID Control*)
		IN_Auto : BOOL; (*Execute PID calculations*)
		IN_FixOut : BOOL;
		IN_FixOutValue : REAL;
		IN_IntHold : BOOL; (*Integral action hold*)
		IN_AutoSP : REAL; (*Set Point for PID Control*)
		IN_Disv : REAL; (*Disturbance variable (same unit as manipulated value)*)
		IN_MaxScale : REAL; (*Maximum scale value*)
		IN_Slew : BOOL; (*Slew on SP required*)
		IN_SPSlew : REAL; (*Set Point slew*)
		IN_MinDev : REAL; (*To Set Point Low Deviation (for SP obtained)*)
		IN_MaxDev : REAL; (*To Set Point High Deviation (for SP obtained)*)
		IN_OutMin : REAL; (*Output minimum value*)
		IN_OutMax : REAL; (*Output maximum value*)
		IN_CycleTime : TIME;
		IN_TIInit : BOOL;
		IN_TIInitValue : REAL;
	END_VAR
	VAR_OUTPUT
		OUT : REAL; (*Manipulated value*)
		OUT_ActSP : REAL;
		OUT_Error : REAL; (*Error signal [eng]*)
		OUT_P : REAL; (*Proportionality component*)
		OUT_I : REAL; (*Integral component*)
		OUT_D : REAL; (*Derivative component*)
	END_VAR
	VAR_IN_OUT
		HMI : HMI_PID_Type;
	END_VAR
	VAR
		LCRLimScal_PV : LCRLimScal;
		LCRLimScal_SP : LCRLimScal;
		VAR_Derivative : REAL;
		VAR_FirstCycle : BOOL;
		VAR_GainError : REAL;
		VAR_Integral : Integral;
		VAR_IntegralBlock : BOOL; (*Freeze Integral Calculation*)
		VAR_IntegralOut : REAL;
		VAR_IntegralSaturation : BOOL;
		LCRRamp : LCRRamp;
		VAR_OldError : REAL;
		VAR_Proportional : REAL;
		VAR_RTInfo : RTInfo;
		VAR_SPRamped : REAL;
		VAR_SP : REAL;
		VAR_PV : REAL;
		VAR_CycleCounter : REAL;
		VAR_CycleTime : REAL;
		VAR_SlewInit : BOOL;
		TON_Cycle : TON;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
		zzEdge00002 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK PID_FF_Mod
	VAR_INPUT
		IN_Enable : BOOL; (*Feed Forward Enable (Bit true)*)
		IN_Reset : BOOL; (*Feed Forward Reset (Bit true)*)
		IN_Raise_Step : REAL; (*Raise Ramp Step Start Delay (0 -:- 100)*)
		IN_Raise_Step_Counter : REAL; (*Raise Ramp Step Start Delay Counter*)
		IN_Lower_Step : REAL; (*Lower  Ramp Step Start Delay (0 -:- 100)*)
		IN_Lower_Step_Counter : REAL; (*Lower Ramp Step Start Delay Counter*)
		IN_FF_SP1 : REAL; (*Feed Forward Set Point 1 Value (High Set Point)*)
		IN_FF_SP2 : REAL; (*Feed Forward Set Point 2 Value (High Set Point)*)
		IN_SP1_SP2_Time : REAL; (*Time delay before Lower Ramp to Feed Forward Set Point 2*)
		IN_Ramp_Speed : REAL; (*Feed Forward Ramp Speed (Raise-Lower)*)
		IN_Actual_Speed : REAL; (*Actual Machine Speed (c/h)*)
		IN_Size_Speed : REAL; (*Max Machine Speed for actual Container Size (c/h)*)
	END_VAR
	VAR_OUTPUT
		OUT_FF_Value : REAL;
		OUT_FF_Value_Int : INT;
	END_VAR
	VAR
		Running : BOOL;
		Lower_Ramp : BOOL;
		SP1_ON : BOOL;
		SP2_ON : BOOL;
		FF_SP1_Recipe : REAL;
		Speed : REAL;
		Max_Speed : REAL;
		FF_SP1_Val : REAL;
		Ramp_Time : REAL;
		Ramp_Speed_R : REAL;
		Ramp_Value : REAL;
		FF_value_Out : REAL;
		FF_SP2_Save : REAL;
		FF_SP2_Time : TON;
		FF_SP2_Recipe : REAL;
		FF_SP2_Val : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK PID_FF_Pump
	VAR_INPUT
		IN_Enable : BOOL; (*Feed Forward Enable (Bit true)*)
		IN_Reset : BOOL;
		IN_Control_Type : BOOL; (*0=Control on Ring;1=Control on Product Pipe*)
		IN_FV_Number : REAL; (*Filling Valves Number*)
		IN_RingDiameter_mm : REAL;
		IN_FV_FromFloor : REAL; (*Water From The Floor on The Product Level Tank [mm]*)
		IN_PTF_FromFloor : REAL; (*Water From The Floor on The Product Level Tank [mm]*)
		IN_PTF_FromFV : REAL; (*Water From The Floor on The Product Level Tank [mm]*)
		IN_Pump_Kf : REAL;
		IN_Pump_Kpc : REAL;
		IN_Pump_OutMax : REAL;
		IN_FMCActualFlowrate : REAL;
		IN_TankLevel_mm : REAL; (*Water From The Floor on The Product Level Tank [mm]*)
		IN_Actual_SPmm : REAL; (*Actual Machine Speed (B/h)*)
		IN_Actual_PVmm : REAL; (*Actual Machine Speed (B/h)*)
		IN_Actual_SPbar : REAL; (*Actual Machine Speed (B/h)*)
		IN_Actual_PVbar : REAL; (*Actual Machine Speed (B/h)*)
		IN_Actual_Speed : REAL; (*Actual Machine Speed (B/h)*)
	END_VAR
	VAR_OUTPUT
		OUT_FF : REAL;
		OUT_PID_PV : REAL;
		OUT_PID_SP : REAL;
		OUT_Error : BOOL;
	END_VAR
	VAR
		Radius : REAL;
		Omega : REAL;
		CentrifugalForce : REAL;
		Level_SP_Calculated : REAL;
		Pid_PV_Calculated : REAL;
		PV_Product_Pump : REAL;
		Kpc_FlowRate_Filling : REAL;
		Real_Level : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK PID_FF_PumpH
	VAR_INPUT
		IN_Enable : BOOL; (*Feed Forward Enable (Bit true)*)
		IN_Reset : BOOL;
		IN_Control_Type : BOOL; (*0=Control on Ring;1=Control on Product Pipe*)
		IN_FV_Number : REAL; (*Filling Valves Number*)
		IN_RingDiameter_mm : REAL;
		IN_FV_FromFloor : REAL; (*Water From The Floor on The Product Level Tank [mm]*)
		IN_PTF_FromFloor : REAL; (*Water From The Floor on The Product Level Tank [mm]*)
		IN_PTF_FromFV : REAL; (*Water From The Floor on The Product Level Tank [mm]*)
		IN_Pump_Kf : REAL;
		IN_Pump_Kpc : REAL;
		IN_Pump_OutMax : REAL;
		IN_PumpMaxFillingTime : REAL;
		IN_FMCActualFlowrate : REAL;
		IN_FMCAverFillingTime : REAL;
		IN_FMCStepStartFilling : REAL;
		IN_FMCStepExitCam : REAL;
		IN_TankLevel_mm : REAL; (*Water From The Floor on The Product Level Tank [mm]*)
		IN_Actual_SPmm : REAL; (*Actual Machine Speed (c/h)*)
		IN_Actual_PVmm : REAL; (*Actual Machine Speed (c/h)*)
		IN_Actual_SPbar : REAL; (*Actual Machine Speed (c/h)*)
		IN_Actual_PVbar : REAL; (*Actual Machine Speed (c/h)*)
		IN_Actual_Speed : REAL; (*Actual Machine Speed (c/h)*)
		IN_Recipe_Speed : REAL; (*Max Machine Speed for actual Container Size (c/h)*)
	END_VAR
	VAR_OUTPUT
		OUT_FF : REAL;
		OUT_Centifrugal : REAL;
		OUT_Error : BOOL;
	END_VAR
	VAR
		Radius : REAL;
		Omega : REAL;
		CentrifugalForce : REAL;
		MAX_FillingTime : REAL;
		MAX_ContainersNumber : REAL;
		Level_SP_Calculated : REAL;
		FillingTime : REAL;
		Calculated_FillingTime : REAL;
		PV_Product_Pump : REAL;
		Kpc_FlowRate_Filling : REAL;
		Real_Level : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK RCP_Management
	VAR_INPUT
		IN_AdrPLCRecipe : {REDUND_UNREPLICABLE} UDINT; (*Temporary structure from HMI*)
		IN_AdrHMIRecipe : {REDUND_UNREPLICABLE} UDINT; (*PLC Internal Structure*)
		IN_SizePLCRecipe : UDINT;
		IN_SizeHMIRecipe : UDINT;
		IN_RequestedRCP : STRING[150];
		IN_DownloadRequest : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_ParameterError : BOOL;
		OUT_RecipeLoaded : BOOL;
		OUT_Step : RCP_Management_Step;
	END_VAR
	VAR_IN_OUT
		RCP_Manag : RCP_Management_Type;
	END_VAR
	VAR
		VAR_FirstCycle : BOOL;
		VAR_Step_old : RCP_Management_Step;
		TMR_tonRCP_WaitRestart : TON;
		TMR_tonRCP_WaitStart : TON;
		TMR_tonRCP_DownloadTimeOut : TON;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Sequencer_v1
	VAR_INPUT
		IN_StepConfig : SEQ_StepConfig_Type;
		IN_T_TimeClock : BOOL;
		IN_Step : UINT;
		IN_StepCounter : UINT;
		IN_Pause_Request : BOOL;
		IN_FillingValveNr : UINT;
	END_VAR
	VAR_OUTPUT
		OUT_TON_Time_END : BOOL;
		OUT_TO_Time_END : BOOL;
		OUT_T_Time_END : BOOL;
		OUT_LapsCounterRequest : BOOL;
		OUT_Laps_Done : BOOL;
		OUT_Cycles_Done : BOOL;
		OUT_HMI_ID : UINT; (*ID to match text on HMI*)
		OUT_JMP_StepPrevious : UINT; (*Step wich the sequence is coming from*)
		OUT_JMP_Step : UINT;
		OUT_Laps_Progress : UINT; (*Progress of Laps Executed*)
		OUT_StepTimePr_TON : UINT; (*TON Preset Time*)
		OUT_StepTimePr_T : UINT; (*T Preset Time*)
		OUT_StepTimeCV_TON : UINT; (*TON ActualTime*)
		OUT_StepTimeCV_T : UINT; (*T Actual Time*)
	END_VAR
	VAR_IN_OUT
		CyclesCounter : UDINT;
	END_VAR
	VAR
		TON_Time : TON;
		TO_Time : TON;
		T_Time : CTU;
		VAR_ChangeInProgress : BOOL;
		VAR_CounterInitialized : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Sequencer_v2
	VAR_INPUT
		IN_StepConfig : SEQ_StepConfig_Type;
		IN_T_TimeClock : BOOL;
		IN_Step : UINT;
		IN_StepCounter : UINT;
		IN_Pause_Request : BOOL;
		IN_FillingValveNr : UINT;
	END_VAR
	VAR_OUTPUT
		OUT_TON_Time_END : BOOL;
		OUT_TO_Time_END : BOOL;
		OUT_T_Time_END : BOOL;
		OUT_LapsCounterRequest : BOOL;
		OUT_Laps_Done : BOOL;
		OUT_Cycles_Done : BOOL;
		OUT_HMI_ID : UINT; (*ID to match text on HMI*)
		OUT_StepPrevious : UINT; (*Step wich the sequence is coming from*)
		OUT_StepActual : UINT;
		OUT_Laps_Progress : UINT; (*Progress of Laps Executed*)
		OUT_StepTimePr_TON : UINT; (*TON Preset Time*)
		OUT_StepTimePr_T : UINT; (*T Preset Time*)
		OUT_StepTimeCV_TON : UINT; (*TON ActualTime*)
		OUT_StepTimeCV_T : UINT; (*T Actual Time*)
		OUT_StepProgressiveTime : UINT; (*T Actual Time*)
	END_VAR
	VAR_IN_OUT
		CyclesCounter : UDINT;
	END_VAR
	VAR
		TON_Time : TON;
		TO_Time : TON;
		T_StepProgressiveTime : TON;
		T_Time : CTU;
		VAR_ChangeInProgress : BOOL;
		VAR_CounterInitialized : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK TankMultiScale
	VAR_INPUT
		IN_ConfigPresent : BOOL;
		IN_Wait : BOOL;
		IN_Sp_Type : USINT; (*[1=Wait percentage SP] [2=Wait Volume SP] [3=Wait level Height]*)
		IN_TNK_PV : REAL;
		IN_TNK_LowLimitAbs : REAL;
		IN_TNK_Diameter_mm : REAL;
		IN_TNK_Bottom_liters : REAL;
		IN_ProbeLength_mm : REAL;
		IN_FromFloor_ToZeroProbe_mm : REAL;
		IN_Scale : ARRAY[0..3] OF IN_Analog_Multiscale; (*0..3 = Arrays for Different Scale*)
	END_VAR
	VAR_OUTPUT
		OUT_Scale : ARRAY[0..3] OF OUT_Analog_Multiscale;
	END_VAR
	VAR_IN_OUT
		HMI : HMI_Analog_Multiscale_Type;
	END_VAR
	VAR
		pi : REAL;
		diameter_cm : REAL;
		r_cm : REAL; (*radius [cm]*)
		heightAck_cm : REAL;
		volumeAck_cm3 : REAL;
		volumeAck_liters : REAL;
		heightTot_cm : REAL;
		volumeTot_cm3 : REAL;
		volumeTot_liters : REAL;
		LowLimitAbs_cm : REAL;
		LowLimitAbs_cm3 : REAL;
		LowLimitAbs_liters : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Siko_Management
	VAR_INPUT
		IN_Mode : INT; (*0: Idle ; 1: Production ; 2: Cleaning*)
		IN_HMI_MotEnable : BOOL;
		IN_HMI_ManualEnable : BOOL;
		IN_HMI_StartWrite : BOOL;
		IN_HMI_Calibrate : BOOL;
		IN_HMI_StartRead : BOOL;
		IN_HMI_JogForward : BOOL;
		IN_HMI_JogBackward : BOOL;
		IN_HMI_MoveAt : BOOL;
		IN_PosProduction : REAL;
		IN_PosCleaning : REAL;
		IN_PosManualSP : REAL;
		IN_EnableToRun : BOOL; (*//v049*)
		IN_Reset : BOOL;
	END_VAR
	VAR_OUTPUT
		OUT_Running : BOOL;
		OUT_Done : BOOL;
		OUT_PositionError : BOOL;
	END_VAR
	VAR_IN_OUT
		IN_SikoData : SIKO_MASTER_Type;
	END_VAR
	VAR
		CalculateSP : REAL;
		Status : INT;
		StepTimer : TON;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK Siko_FB
	VAR_INPUT
		IN_EmergencyOK : BOOL;
		IN_Reset : BOOL;
		IN_CommunicationOK : BOOL;
		IN_TimeOutPositioning : TIME;
		IN_PGain : REAL;
		IN_IGain : REAL;
		IN_DGain : REAL;
		IN_VPos : REAL;
		IN_APos : REAL;
		IN_VJog : REAL;
		IN_PosWindows : REAL;
		IN_GearIn : REAL;
		IN_GearOut : REAL;
		IN_SpindlePitch : REAL;
		IN_SenseOfRotation : REAL;
		IN_UpperLimit : REAL;
		IN_LowerLimit : REAL;
		IN_CalibrationValue : REAL;
	END_VAR
	VAR_IN_OUT
		DeviceData : SIKO_MASTER_Type;
		IO : SIKO_COM_Type;
	END_VAR
	VAR
		Com : SIKO_COM_Type;
		ReloadData : BOOL;
		KFactorReal : REAL;
		CounterRead : SINT;
		CounterWrite : SINT;
		CounterCalibration : SINT;
		ReadOrWriteInProgress : BOOL;
		TReadAndWrite : TON;
		zzEdge00000 : BOOL;
		SwitchOn : BOOL;
		TPowerOn : TOF;
		PositionFinished : BOOL;
		zzEdge00001 : BOOL;
		RisingFrontRead : BOOL;
		zzEdge00002 : BOOL;
		RisingFrontWrite : BOOL;
		zzEdge00003 : BOOL;
		zzEdge00004 : BOOL;
		Temp_HIW : UDINT;
		Temp_HSW : UDINT;
		Temp_IN_PWE : UDINT;
		Temp_OUT_PWE : UDINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK TP_Reset
	VAR_INPUT
		IN : BOOL;
		PT : TIME;
		RESET : BOOL;
	END_VAR
	VAR_OUTPUT
		Q : BOOL;
	END_VAR
	VAR
		TimeCounter : UDINT;
		RT_Info : RTInfo;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_VFD_DataRead (*v999Daq*)
	VAR_INPUT
		IN_ReadDataEnable : BOOL;
		IN_DeviceAddress : UDINT;
		IN_DeviceNode : USINT;
		IN_DeviceName : STRING[80];
		IN_DanfossFC280 : BOOL;
		IN_IO_PlkVFD_FC280 : IO_PLK_DanfossFC280_Drive_Type;
		IN_IO_PlkVFD : IO_PLK_Danfoss_Drive_Type;
	END_VAR
	VAR_OUTPUT
		OUT_Error : BOOL;
	END_VAR
	VAR_IN_OUT
		VfdData : Vfd_Data_Type;
	END_VAR
	VAR
		Danfoss_Comm : EplSDORead;
		VAR_DataReadIndex : INT;
		TON_Read : TON;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_Flip
	VAR_INPUT
		IN_CycleOn : BOOL;
		IN_CyclePause : BOOL;
		IN_CycleLoop : BOOL;
		IN_CycleStartOffCount : BOOL;
		IN_CycleNrReset : BOOL;
		IN_CycleNr : UDINT;
		IN_CycleTimeOn : UDINT;
		IN_CycleTimeOff : UDINT;
	END_VAR
	VAR_OUTPUT
		OUT_CycleNr : UDINT;
		OUT_CycleTimeOn : UDINT;
		OUT_CycleTimeOff : UDINT;
		OUT_CycleDone : BOOL;
		Out : BOOL;
	END_VAR
	VAR
		Command_State : USINT;
		VAR_CycleTimeOn : UDINT;
		VAR_CycleTimeOff : UDINT;
		VAR_CycleNr : UDINT;
		VAR_CyleOn : BOOL;
		VAR_CyleCntOn : BOOL;
		VAR_CyleCntOff : BOOL;
		VAR_CyleOnTimeReset : BOOL;
		VAR_CyleOffTimeReset : BOOL;
		VAR_CyleNrReset : BOOL;
		VAR_CycleOffDone : BOOL;
		VAR_CycleOnDone : BOOL;
		VAR_CycleNrDone : BOOL;
		TON_Blink : TON;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
		zzEdge00002 : BOOL;
	END_VAR
END_FUNCTION_BLOCK
