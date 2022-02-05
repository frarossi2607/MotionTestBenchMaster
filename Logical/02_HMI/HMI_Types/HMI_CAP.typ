
TYPE
	HMI_CAP_ManualCapsSelection_Type : 	STRUCT 
		Value : USINT;
		Visibility : BOOL;
	END_STRUCT;
	HMI_CAP_ConfigStructure_Type : 	STRUCT 
		Caps : CFG_Cap_Par_Type;
		CfgPresence : HMI_CAP_ConfigStructPres_Type;
		SavePB : PB_Type;
		LoadPB : PB_Type;
	END_STRUCT;
	HMI_CAP_ConfigStructPres_Type : 	STRUCT 
		Channel : BOOL;
		BufferPresent : BOOL;
		BufferSize : BOOL;
		CamHeight : BOOL;
		HeadRotation : BOOL;
		PaP : BOOL;
	END_STRUCT;
	HMI_CAP_State_Type : 	STRUCT 
		Sequencer : Seq_Type; (*Step Actual*)
		Signals : Signals_Type;
	END_STRUCT;
	HMI_CAP_Greasing_Type : 	STRUCT 
		Cycle_Number : UINT;
		Cycle_Request_H : UINT;
		Cycle_TimeOut : UDINT;
		Turret_Cycle_Number : UINT;
		Cycle_RunningTime : UINT;
		Cycle_PauseTime : UDINT;
		Cycle_Running : BOOL;
		Cycle_Alarm : BOOL;
		Pump_Running : BOOL;
	END_STRUCT;
	HMI_CAP_SikoMotor_Type : 	STRUCT  (*V1.61*)
		MotorMax : UINT; (*Head Configuration Number*)
		Data : HMI_CAP_SikoData_Type; (*Data Report Page*)
		Maintenance : ARRAY[0..10]OF Info_Type; (*Maintenance Area*)
		Calibration : HMI_CAP_SikoCal_Type; (*Calibration Area*)
		PageUp : PB_Type := (0); (*Head Scroll in Data Report Page*)
		PageDown : PB_Type := (0); (*Head Scroll in Data Report Page*)
	END_STRUCT;
	HMI_CAP_Brush_Type : 	STRUCT  (*v1.4*)
		HeadMax : UINT; (*Head Configuration Number*)
		Data : HMI_CAP_Data_Type; (*Data Report Page*)
		Maintenance : ARRAY[0..10]OF Info_Type; (*Maintenance Area*)
		Calibration : HMI_CAP_Cal_Type; (*Calibration Area*)
		PageUp : PB_Type := (0); (*Head Scroll in Data Report Page*)
		PageDown : PB_Type := (0); (*Head Scroll in Data Report Page*)
		MaintenanceReadWrite : SS2P_Type; (*//V4.A.A.1.6.11*)
	END_STRUCT;
	HMI_CAP_SikoData_Type : 	STRUCT  (*V1.61*)
		Motor : HMI_CAP_SikoMotorData_Type; (*Data Report*)
		MotorStatus : HMI_CAP_Status_Type; (*Boolean Head Status (Zalkin Only)*)
	END_STRUCT;
	HMI_CAP_Data_Type : 	STRUCT  (*v1.4*)
		HeadNr : UINT; (*Head Request for Diagnostic*)
		Head : ARRAY[0..15]OF HMI_CAP_Head_Type; (*Data Report*)
		HeadStatus : HMI_CAP_Status_Type; (*Boolean Head Status (Zalkin Only)*)
	END_STRUCT;
	HMI_CAP_SikoMotorData_Type : 	STRUCT  (*V1.61*)
		MotorNr : USINT;
		PowerOk : BOOL;
		Enabled : BOOL;
		Ready : BOOL;
		Running : BOOL;
		InPosition : BOOL;
		Error : BOOL;
		BatteryWarning : BOOL;
		xParamRwBusy : BOOL; (*Parameter read/write operation is busy*)
		xParamRwError : BOOL; (*Parameter read/write operation is in error*)
		xParamRwDone : BOOL; (*Parameter read/write operation is done*)
		wPositionVelocity : UINT; (*Jog velocity*)
		wJogVelocity : UINT; (*Current limit*)
		bCurrentLimit : USINT; (*Sense of rotation*)
		bSenseOfRotation : USINT;
	END_STRUCT;
	HMI_CAP_Head_Type : 	STRUCT  (*v1.4*)
		HeadNr : UINT; (*Head Displayed on Row*)
		Data1 : UINT; (*//In arol Equatorque is value of Heads Torque*)
		Data2 : UINT;
		Totalizer00 : UINT;
		Totalizer01 : UINT;
		Totalizer02 : UINT;
		Totalizer03 : UINT;
		Totalizer04 : UINT;
		Totalizer05 : UINT;
		Totalizer06 : UINT;
		Totalizer07 : UINT;
		Bool00 : BOOL; (*//In arol Equatorque RejectionSignal*)
		Bool01 : BOOL; (*//In arol Equatorque NoLoad*)
		Bool02 : BOOL; (*//In arol Equatorque NoClosure*)
		Bool03 : BOOL; (*//In arol Equatorque InTorque*)
		Bool04 : BOOL; (*//In arol Equatorque BadClosure*)
		Bool05 : BOOL; (*//In arol Equatorque FollowingError*)
		Bool06 : BOOL; (*//In arol Equatorque BadClosure*)
		Bool07 : BOOL; (*//In arol Equatorque NoUnwrap*)
		LineVisibility : BOOL;
	END_STRUCT;
	HMI_CAP_Cal_Type : 	STRUCT  (*v1.4*)
		HeadNr : UINT; (*Head Request for Calibration*)
		HeadUp : PB_Type := (0); (*Head Scroll in Calibration Page*)
		HeadDown : PB_Type := (0); (*Head Scroll in Calibration Page*)
		Sequence : SeqTextBar_Type; (*Calibration Sequencer Status*)
		Data : ARRAY[0..14]OF Info_Type; (*//V4.A.A.1.6.12*)
		HeadStatus : HMI_CAP_Status_Type; (*Boolean Head Status (Zalkin Only)*)
		SequencerPerc : INT; (*AROL Equatorque Calibration -Sequencer Step Percentage Display V4.A.A.1.6.12*)
	END_STRUCT;
	HMI_CAP_SikoCal_Type : 	STRUCT  (*V1.61*)
		MotorNr : UINT; (*Motor Siko Request for Calibration*)
		MotorForward : PB_Type := (0); (*Move Motor Forward in Jog Mode*)
		MotorStartPositioning : PB_Type := (0); (*Motor Move to Target Position*)
		MotorBackward : PB_Type := (0); (*Move Motor Backward in Jog Mode*)
		MotorWriteParameter : PB_Type; (*Write Parameter*)
		MotorReadParameter : PB_Type; (*Read Parameter*)
		MotorHoming : PB_Type; (*Homing Motor*)
		Sequence : SeqTextBar_Type; (*Calibration Sequencer Status*)
		Data : Info_Type;
	END_STRUCT;
	HMI_CAP_Status_Type : 	STRUCT  (*v1.4*)
		Visibility : ARRAY[0..7]OF BOOL;
		Status : ARRAY[0..7]OF BOOL;
	END_STRUCT;
	HMI_CAP_DataCfg_Type : 	STRUCT  (*v1.4*)
		Present : BOOL;
		Name : STRING[40];
	END_STRUCT;
	HMI_CAP_ZoneCfg_Type : 	STRUCT  (*v1.5*)
		Present : BOOL;
		Name : STRING[8];
	END_STRUCT;
	HMI_CAP_BufferAdjust_Type : 	STRUCT  (*//V4.A.A.1.6.11*)
		Position_Actual : REAL;
		Position_Request : REAL;
	END_STRUCT;
	HMI_CAP_HRM_Type : 	STRUCT  (*//V4.A.A.1.6.11*)
		ProdSpeedRPM : UINT;
		HeadSpeedRPM : UINT;
		DiagCode : UINT;
		ActualCurrent : UDINT;
		ProdSpeedBPH : REAL;
	END_STRUCT;
END_TYPE
