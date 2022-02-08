
TYPE
	AlarmCmd_Type : 	STRUCT 
		ActionEn : BOOL := TRUE; (*If TRUE the action is performed; If FALSE the alarm is shown as a Message*)
		ByPassEn : BOOL;
		ByPass : BOOL;
		ActionDis : BOOL;
		Active : BOOL; (*If TRUE the alarm is activated.*)
		Visibility : BOOL := TRUE; (*If TRUE the HMI show the Alarm. The action will always performed*)
		DependentActive : BOOL; (*If TRUE the Alarm is deactivated by its master alarm V4.A.A.1.6.13*)
	END_STRUCT;
	AlarmCFG_Type : 	STRUCT 
		Action : USINT;
		Category : USINT;
		OMAC_Code : UINT;
		OMAC_Index : UINT;
	END_STRUCT;
	ActionSum_Type : 	STRUCT 
		Bit : UDINT;
	END_STRUCT;
	ActionSum_Enum : 
		( (*V4.A.A.1.6.13*)
		ALR_NULL := 0, (*No Action, No Code*)
		ALR_MS_QuickStop := 1, (*Machine Stop: Fast deceleration ramp*)
		ALR_MS_NormalStop := 2, (*Machine Stop: Low deceleration ramp*)
		ALR_MS_QuickWithJog := 3, (*Machine Stop: Fast deceleration ramp + JOG Running Possible*)
		ALR_MS_NormalWithJog := 4, (*Machine Stop: Low deceleration ramp + JOG Running Possible*)
		ALR_MS_NormalWithJogMnt := 5, (*Machine Stop Auto Reset: Low deceleration ramp + JOG Running Possible*)
		ALR_CSR := 6, (*Container Stop Operator Reset: Immediate*)
		ALR_CSR_AfterSlowdown := 7, (*Container Stop Operator Reset: After Slowing*)
		ALR_CSR_StopAfterEmptying := 8, (*Container Stop Operator Reset: Emptying + Machine Normal Stop*)
		ALR_CSA := 9, (*Container Stop Auto Reset: Immediate*)
		ALR_CSA_AfterSlowdown := 10, (*Container Stop Auto Reset: After Slowing*)
		ALR_StartModeDisabled := 30, (*Start-Up Function Mode Disabled*)
		ALR_NoProduction := 31 (*No Action, Production Suspended (only Data Acquisition Code)*)
		);
	RCP_Management_Type : 	STRUCT 
		Enable : BOOL; (*To HMI - Enable to download a recipe*)
		Started : BOOL; (*From HMI - Download Started*)
		Ended : BOOL; (*From HMI - Download Ended*)
		Received : BOOL; (*To HMI - Ended Received *)
		EditOnlineEnable : BOOL; (*To HMI - Edit Online Enabled*)
		EditOnlineActive : BOOL; (*From HMI - Edit Online Active*)
		ActiveRecipeName : STRING[70]; (*From HMI - Name of Actived Recipe*)
		RequestedRecipeName : STRING[70]; (*To HMI - Name of the requested recipe*)
		DownloadRequest : BOOL; (*To HMI - Request command to download a recipe*)
	END_STRUCT;
	RCP_Management_Step : 
		(
		Wait_Download := 0,
		Download_Request := 1,
		Copy_To_Internal := 2,
		Download_Done := 3,
		Clear_Cmd := 4,
		Edit_Online := 10,
		Download_Error := 20
		);
	HMI_ITC_Page_Type : 	STRUCT 
		PartnerID : USINT := 11;
		PageNum : USINT := 0;
	END_STRUCT;
	HMI_ITC_Data_Type : 	STRUCT 
		PartnerID : USINT;
		ComType : USINT;
		ComAddress : STRING[35];
		LocalPort : UINT; (*Local port number used to Receive*)
		RemotePort : UINT; (*Remote port number used o Send*)
		ComSwap : BOOL;
		PageUp : HMI_ITC_PB_Type := (Visibility:=TRUE);
		PageDown : HMI_ITC_PB_Type := (Visibility:=TRUE);
		ComStatus : USINT;
		ComMask : HMI_ITC_SS2P_Type := (Visibility:=TRUE);
		DigitalIn : ARRAY[1..16]OF HMI_DigitalITC_Type;
		AnalogIn : ARRAY[1..4]OF HMI_AnalogITC_Type;
		DigitalOut : ARRAY[1..16]OF HMI_DigitalITC_Type;
		AnalogOut : ARRAY[1..4]OF HMI_AnalogITC_Type;
		ManActive : BOOL;
	END_STRUCT;
	HMI_AnalogITC_Type : 	STRUCT 
		Visibility : BOOL;
		PV : REAL;
		Unit : STRING[10];
		Wait : BOOL;
		MinValue : REAL;
		MaxValue : REAL;
		Enable : BOOL;
		Man : BOOL;
		PV_Man : REAL;
		Description : STRING[100];
		Decimal : USINT;
	END_STRUCT;
	HMI_DigitalITC_Type : 	STRUCT 
		Visibility : BOOL;
		Enable : BOOL;
		Auto : BOOL := TRUE;
		LampState : BOOL;
		Alarm : BOOL;
		Wait : BOOL;
		Man : BOOL;
		Description : STRING[100];
	END_STRUCT;
	HMI_ITC_PB_Type : 	STRUCT  (*Push button (ON-OFF;) 0=OFF - 1=ON*)
		Enable : BOOL; (*State: Command Enabled*)
		LampON : BOOL; (*State: Lamp Command ON*)
		Blink : BOOL; (*State: Blink LampOn*)
		Visibility : BOOL; (*Configuration: Present*)
		ON : BOOL; (*Command: Push Button ON*)
	END_STRUCT;
	HMI_ITC_SS2P_Type : 	STRUCT  (*Selector 2 position (Auto-Man; ON-OFF;) 0=Auto/OFF - 1=Man/ON*)
		Enable : BOOL; (*State: Command Enabled*)
		LampON : BOOL; (*State: Lamp Command ON*)
		Blink : BOOL; (*State: Blink LampOn*)
		Visibility : BOOL; (*Configuration: Present*)
		ON : BOOL; (*Command: Push Button ON*)
	END_STRUCT;
	IO_TimeClock_Type : 	STRUCT 
		Seconds : UDINT;
		Nanoseconds : UDINT;
	END_STRUCT;
	Counters_Type : 	STRUCT 
		CounterValue : UDINT;
		CounterTime : CounterTime_Type;
		StartDate : DINT;
	END_STRUCT;
	CounterTime_Type : 	STRUCT 
		Day : UINT;
		Hour : USINT;
		Min : USINT;
		Sec : USINT;
	END_STRUCT;
	HMI_ComboBoxElements_Type : 	STRUCT 
		Present : BOOL;
		Name : STRING[20];
	END_STRUCT;
	SEQ_StepConfig_Type : 	STRUCT 
		T_TimePr : UINT;
		TO_TimePr : UINT;
		HMI_ID : UINT;
		TON_TimePr : UINT;
		Laps_Request : UINT;
		Cycle_Pr : UINT;
		TON_TimeSTART : BOOL;
		T_TimeSTART : BOOL;
		T_TimeSTOP : BOOL;
		T_TimeRESET : BOOL;
		Laps_Counter_Enable : BOOL;
		Cycle_RESET : BOOL;
	END_STRUCT;
	SIKO_MASTER_Type : 	STRUCT  (* *) (* *) (*13*)
		InPosition : BOOL; (*1 - The motor is in position*) (* *) (*14*)
		PositioningInProgress : BOOL; (*1 - The positioning task is in progress*) (* *) (*15*)
		CalibrationDone : BOOL; (*1 - The calibration operation is done*) (* *) (*16*)
		MotorDisabled : BOOL; (*1 - The motor is disabled*) (* *) (*17*)
		AbortPositioning : BOOL; (*1 - The current positioning is aborted*) (* *) (*18*)
		CalibrationInProgress : BOOL; (*1 - The calibration Process is in progress*) (* *) (*19*)
		Spare_06 : BOOL; (* *) (* *) (*20*)
		Spare_07 : BOOL; (* *) (* *) (*21*)
		JogForward : BOOL; (*1 - Jog Forward Command*) (* *) (*22*)
		JogBackward : BOOL; (*1 - Jog Backward Command*) (* *) (*23*)
		StartPositioning : BOOL; (*Positive Edge - Start positioning*) (* *) (*24*)
		StartRead : BOOL; (*Positive Edge - Start read parameter from the drive*) (* *) (*25*)
		StartWrite : BOOL; (*Positive Edge - Start write parameter from the drive*) (* *) (*26*)
		Calibrate : BOOL; (*Positive Edge - Calibrate command. (Calibrate value => Current pos)*) (* *) (*27*)
		Enable : BOOL; (*0 - Disable the motor; 1 - Enable motor*) (* *) (*28*)
		Spare_17 : BOOL; (* *) (* *) (*29*)
		ReadOrWriteError : BOOL; (*1 - A read or wirte error has occured*) (* *) (*30*)
		IllegalOperation : BOOL; (*1 - An illegal operation has occurred*) (* *) (*31*)
		DeviceOutsideSwLimit : BOOL; (*1 - The device is outside the sw limit*) (* *) (*32*)
		OnError : BOOL; (*1 - The motor is on error (current, temperature too high, ...)*) (* *) (*33*)
		TargetOutsideSwLimit : BOOL; (*1 - The target position is outside the sw limit (no movement is possible)*) (* *) (*34*)
		CommunicationFault : BOOL; (*1 - Comunication fault*) (* *) (*35*)
		Spare_26 : BOOL; (* *) (* *) (*36*)
		Warning : BOOL; (*1 - Warning present*) (* *) (*37*)
		EmergencyOkFbk : BOOL; (*Emergency ok feedback*) (* *) (*38*)
		WriteEnabled : BOOL; (*1 - Write process is enabled*) (* *) (*39*)
		ReadOrWriteInProgress : BOOL; (* *) (* *) (*40*)
		Spare_33 : BOOL; (* *) (* *) (*41*)
		Spare_34 : BOOL; (* *) (* *) (*42*)
		Spare_35 : BOOL; (* *) (* *) (*43*)
		Spare_36 : BOOL; (* *) (* *) (*44*)
		Spare_37 : BOOL; (* *) (* *) (*45*)
		TargetPos : REAL; (* *) (* *) (*46*)
		CurrentPos : REAL; (* *) (* *) (*47*)
		Data : SIKO_DATA_Type; (* *) (* *) (*48*)
	END_STRUCT;
	SIKO_DATA_Type : 	STRUCT  (* *) (* *) (*50*)
		OperationMode : INT; (*r/w - address:396hex - value: 2 - Don't change!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*) (* *) (*51*)
		PGain : INT; (*r/w - address:3e8hex*) (* *) (*52*)
		IGain : INT; (*r/w - address:3e9hex*) (* *) (*53*)
		DGain : INT; (*r/w - address:3eahex*) (* *) (*54*)
		VPos : INT; (*r/w - address:3echex*) (* *) (*55*)
		APos : INT; (*r/w - address:3ebhex*) (* *) (*56*)
		VJog : INT; (*r/w - address:3f0hex*) (* *) (*57*)
		SpareInt : INT; (* *) (* *) (*58*)
		GearIn : INT; (*r/w - address:3f2hex*) (* *) (*59*)
		GearOut : INT; (*r/w - address:3f3hex*) (* *) (*60*)
		SpindlePitch : INT; (*r/w - address:3f4hex*) (* *) (*61*)
		SenseOfRotation : INT; (*r/w - address:3f5hex*) (* *) (*62*)
		UpperLimit : REAL; (*r/w - address:3f8hex*) (* *) (*63*)
		LowerLimit : REAL; (*r/w - address:3f9hex*) (* *) (*64*)
		CalibrationValue : REAL; (*r/w - address:3fahex*) (* *) (*65*)
		SystemStatusWord : INT; (*r - address:3fchex*) (* *) (*66*)
		FaultBuffer0 : UINT; (*r - address:3b1 sub: 0*) (* *) (*67*)
		FaultBuffer1 : UINT; (*r - address:3b1 sub: 1*) (* *) (*68*)
		FaultBuffer2 : UINT; (*r - address:3b1 sub: 2*) (* *) (*69*)
		FaultBuffer3 : UINT; (*r - address:3b1 sub: 3*) (* *) (*70*)
		FaultBuffer4 : UINT; (*r - address:3b1 sub: 4*) (* *) (*71*)
		FaultBuffer5 : UINT; (*r - address:3b1 sub: 5*) (* *) (*72*)
		FaultBuffer6 : UINT; (*r - address:3b1 sub: 6*) (* *) (*73*)
		FaultBuffer7 : UINT; (*r - address:3b1 sub: 7*) (* *) (*74*)
		FaultBuffer8 : UINT; (*r - address:3b1 sub: 8*) (* *) (*75*)
		FaultBuffer9 : UINT; (*r - address:3b1 sub: 9*) (* *) (*76*)
		TimeoutPositioning : TIME; (* *) (* *) (*77*)
		PosWindows : REAL; (*r/w - address:3f1hex*) (* *) (*78*)
	END_STRUCT;
	SIKO_COM_Type : 	STRUCT  (* *) (* *) (*80*)
		FLR_SIKO : FLR_SIKO_Type; (* *) (* *) (*81*)
		SIKO_FLR : SIKO_FLR_Type; (* *) (* *) (*82*)
	END_STRUCT;
	FLR_SIKO_Type : 	STRUCT  (* *) (* *) (*84*)
		PKE : UINT; (* *) (* *) (*85*)
		IND : UINT; (* *) (* *) (*86*)
		PWE_H : UINT; (* *) (* *) (*87*)
		PWE_L : UINT; (* *) (* *) (*88*)
		STW : UINT; (* *) (* *) (*89*)
		HSW_H : UINT; (* *) (* *) (*90*)
		HSW_L : UINT; (* *) (* *) (*91*)
	END_STRUCT;
	SIKO_FLR_Type : 	STRUCT  (* *) (* *) (*93*)
		PKE : UINT; (* *) (* *) (*94*)
		IND : UINT; (* *) (* *) (*95*)
		PWE_H : UINT; (* *) (* *) (*96*)
		PWE_L : UINT; (* *) (* *) (*97*)
		ZSW : UINT; (* *) (* *) (*98*)
		HIW_H : UINT; (* *) (* *) (*99*)
		HIW_L : UINT; (* *) (* *) (*100*)
	END_STRUCT;
	AlarmAreaCfg_Type : 	STRUCT  (*V4.A.A.1.6.13*)
		From : UINT;
		To : UINT;
	END_STRUCT;
	Vfd_Data_Type : 	STRUCT  (*v999_Daq*)
		Node : USINT;
		Name : STRING[80];
		ReadData : ARRAY[0..15]OF DINT;
	END_STRUCT;
END_TYPE
