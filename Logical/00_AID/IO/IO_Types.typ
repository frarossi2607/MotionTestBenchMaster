
TYPE
	IO_MotionFanMachine_Type : 	STRUCT 
		Filler : IO_MotionFanFiller_Type;
		Seamer : IO_MotionFanOutlet_Type;
	END_STRUCT;
	IO_MotionFanFiller_Type : 	STRUCT 
		Main : IO_MotionFan_Type;
		In1 : IO_MotionFan_Type;
		In2 : IO_MotionFan_Type;
		In3 : IO_MotionFan_Type;
		In4 : IO_MotionFan_Type;
		In5 : IO_MotionFan_Type;
		In6 : IO_MotionFan_Type;
		In7 : IO_MotionFan_Type;
		In8 : IO_MotionFan_Type;
		In9 : IO_MotionFan_Type;
		In10 : IO_MotionFan_Type;
		Out1 : IO_MotionFan_Type;
		Out2 : IO_MotionFan_Type;
		Out3 : IO_MotionFan_Type;
		Out4 : IO_MotionFan_Type;
		Out5 : IO_MotionFan_Type;
	END_STRUCT;
	IO_MotionFanOutlet_Type : 	STRUCT 
		Main : IO_MotionFan_Type;
	END_STRUCT;
	IO_Dmc_Type : 	STRUCT 
		InsertionSensor : IO_Digital_IN_Type;
		InsertionPiston : IO_Valve_Type; (*Open = Inserction (Back)
Close = Disinserction (Forward)*)
	END_STRUCT;
	IO_OPS_Door_Type : 	STRUCT 
		DI_Diagnostic : BOOL;
	END_STRUCT;
	IO_OPS_Zone_Type : 	STRUCT 
		DO_GreenLight : BOOL;
		DO_RedLight : BOOL;
		DI_ConfinementAck : BOOL;
	END_STRUCT;
	IO_OPS_JOG_Type : 	STRUCT 
		DI_Plugged : BOOL;
	END_STRUCT;
	IO_Cooling_Type : 	STRUCT 
		MaxTemperature : BOOL; (*1.63 tolta inizializzazione variabile*)
		Overload : BOOL := TRUE;
	END_STRUCT;
	PO_Safety_Type : 	STRUCT  (*V4.A.A.1.6.13*)
		PB_Reset : BOOL; (*Push Button Command: Reset Push Button*)
		Production : BOOL; (*Machine on Production Running (the Product Inlet Valves stay Open with Doors Unlocked)*)
		PB_ResetBkInRoom : BOOL; (*Push Button Command: Room Door Inlet Reset Push Button*)
		PB_ResetBkOutRoom : BOOL; (*Push Button Command: Room Door Outlet Reset Push Button*)
		PB_ResetFwRoom : BOOL; (*Push Button Command: Room Door Outlet Reset Push Button*)
		BF_CoupledBF : BOOL; (*Combi Blower: Blower+Filler Coupled*)
		SSC_CoupledBlower : BOOL; (*SuperCombi BLF/BAF: Blower+Labeler / Blower+Actis Coupled//V4.A.A.1.6.10c*)
		SSC_CoupledFiller : BOOL; (*SuperCombi BLF/BAF: Labeler+Filler / Actis+Filler Coupled//V4.A.A.1.6.10c*)
		SSC_BF_BlowerAutoMode : BOOL; (*SuperCombi BLF/BAF ; Combi Blower: Blower on Automatic Mode//V4.A.A.1.6.10c*)
		SSC_LabActAutoMode : BOOL; (*SuperCombi BLF/BAF: Labeler/Actis on Automatic Mode//V4.A.A.1.6.10c*)
		SS_OP_FlrRelease : BOOL; (*Selector Switch Command: All Filler Door Release Command from HMI*)
		ReleaseEnable : BOOL; (*Filler Doors Release Enable Condition*)
		KeyJogReady : BOOL; (*JOG Enable Key: Inserted and Ready*)
		KeyJogWrong : BOOL; (*JOG Enable Key: Inserted but Wrong code*)
		BOOL114 : BOOL;
		BOOL115 : BOOL;
		BOOL116 : BOOL;
		BOOL117 : BOOL;
		HMI_UnlockSelector : BOOL; (*HMI Operator Protection Unlock Command (Selector Switch)V4.A.A.1.6.9*)
		HMI_LockSelector : BOOL; (*V4.A.A.1.6.9*)
		OP_BlwTrUnlockRequest : BOOL; (*Blower Transfer Doors Unlock Request*)
		OP_Lab_ActTrUnlockReq : BOOL; (*Super Combi BLF / BAF: Labeler / Actis Transfer Doors Unlock Requested//V4.A.A.1.6.10c*)
		BOOL122 : BOOL;
		BOOL123 : BOOL;
		BOOL124 : BOOL;
		CapArol_HighCommand : BOOL; (*Capper Arol: Buffer on High Positioning Command*)
		BOOL126 : BOOL;
		BOOL127 : BOOL;
		BOOL128 : BOOL;
		BOOL129 : BOOL;
		GeneralAirIn : BOOL; (*From SKID - 201PSG Inlet General Air Pressure: > 6.0 Bar = TRUE*)
		GeneralAirOut : BOOL; (*From SKID - Outlet General Air Valve 203EVG Opened*)
		BOOL132 : BOOL;
		BOOL133 : BOOL;
		BOOL134 : BOOL;
		HVB297 : BOOL; (*Sampling Valve Open Requested Command V4.A.A.1.6.10c*)
		BOOL136 : BOOL;
		BOOL137 : BOOL;
		BOOL138 : BOOL;
		BOOL139 : BOOL;
		BOOL142 : BOOL;
		BOOL143 : BOOL;
		BOOL144 : BOOL;
		BOOL145 : BOOL;
		BOOL146 : BOOL;
		BOOL147 : BOOL;
		BOOL148 : BOOL;
		FillerLiftRequ : BOOL; (*Filler Lifting enable request*)
		OpFwUnlock : BOOL; (*Operator Forward Door Lock-Unlock push Button*)
		OpBkInUnlock : BOOL; (*Operator Backward In Door Lock-Unlock push Button*)
		OpBkOutUnlock : BOOL; (*Operator Backward Out Door Lock-Unlock push Button*)
		OpTrFwUnlock : BOOL; (*Operator Trasfer In Door Lock-Unlock push Button*)
		OpTrBkUnlock : BOOL; (*Operator Trasfer Out Door Lock-Unlock push Button*)
	END_STRUCT;
	PI_Safety_Type : 	STRUCT  (*V4.A.A.1.6.13*)
		OP_ConfirmPB : BOOL; (*OP Safety Flag: Area Doors Opened Confirm Push Button - Green Lamp V4.A.A.1.6.9*)
		OPFw_ConfirmRequest : BOOL; (*OP Filler Forward Safety Flag: Area Doors Opened Confirm Request - Red Lamp*)
		OPBkIn_ConfirmRequest : BOOL; (*OP Filler Backward Inlet Safety Flag: Area Doors Opened Confirm Request - Red Lamp*)
		OPBkOut_ConfirmRequest : BOOL; (*OP Filler Backward Outlet Safety Flag: Area Doors Opened Confirm Request - Red Lamp*)
		OPTrFw_ConfirmRequest : BOOL; (*OP Filler Transfer Forwrd Safety Flag: Area Doors Opened Confirm Request - Red Lamp*)
		OPTrBk_ConfirmRequest : BOOL; (*OP Filler Transfer Backward Safety Flag: Area Doors Opened Confirm Request - Red Lamp*)
		OPRnBkIn_ConfirmRequest : BOOL; (*OP Rinser Backward Inlet Safety Flag: Area Doors Opened Confirm Request - Red Lamp*)
		OPRnBkOut_ConfirmRequest : BOOL; (*OP Rinser Backward Outlet Safety Flag: Area Doors Opened Confirm Request - Red Lamp*)
		BOOL009 : BOOL;
		OPFw_Jog : BOOL; (*OP Forward Safety Flag: Jog Selected*)
		OPBkIn_Jog : BOOL; (*OP Backward Inlet Safety Flag: Jog Selected*)
		OPBkOut_Jog : BOOL; (*OP Backward Outlet Safety Flag: Jog Selected*)
		OPTrFw_Jog : BOOL; (*OP Transfer Forward Safety Flag: Jog Selected*)
		OPMnOut_Jog : BOOL; (*OP Capper Platform Safety Flag: Jog Selected*)
		OPRnBkIn_Jog : BOOL; (*OP Rinser Backward Inlet Safety Flag: Jog Selected*)
		OPRnBkOut_Jog : BOOL; (*OP Rinser Backward Outlet Safety Flag: Jog Selected //V4.A.A.1.6.10c*)
		OPFwEx_Jog : BOOL; (*OP Forward External Safety Flag: Jog Selected //vrma 106*)
		OPFwEx_JogError : BOOL; (*OP Forward External Safety Flag: Jog Selected Fault vrma106*)
		BOOL019 : BOOL;
		SS_LockOutOff : BOOL; (*V4.A.A.1.7.1*)
		SS_LockOutError : BOOL; (*V4.A.A.1.7.1*)
		SS_JogKeyOff : BOOL; (*Jog with Door Opened Enable Key: Selector on Off Position V4.A.A.1.7.1*)
		SS_JogKeyError : BOOL; (*Jog with Door Opened Enable Key: Selector on Fault V4.A.A.1.7.1*)
		GateConveyorClosed : BOOL; (*OP Filler Safety Flag: Outlet Conveyor Gate Closed*)
		GateConveyorShCirc : BOOL; (*OP Filler Safety Flag: Outlet Conveyor Gate Short Circuit*)
		OPTrGateClosed : BOOL; (*OP Transfer Gate Safety Flag: Gate Closed (Isolation Door Installed)*)
		OPTrGateShCirc : BOOL; (*OP Transfer Gate Safety Flag: Gate Short Circuit (Isolation Door)*)
		BOOL028 : BOOL;
		BOOL029 : BOOL;
		BOOL030 : BOOL;
		BOOL031 : BOOL;
		BOOL032 : BOOL;
		BOOL033 : BOOL;
		BOOL034 : BOOL;
		BOOL035 : BOOL;
		BOOL036 : BOOL;
		OP_ClosedRnsPw : BOOL; (*Operator Protection Safety Flag: Operator Protection Closed Rinser Power ON (Delay)V4.A.A.1.6.10c*)
		OP_ClosedRnsPwFault : BOOL; (*Operator Protection Safety Flag: Operator Protection Closed Rinser Power Fault V4.A.A.1.6.10c*)
		OP_UnlockOpened : BOOL; (*Operator Protection Safety Flag: Operator Protection Unlocked/Opened (HMI Selector=Orange)V4.A.A.1.6.9*)
		OP_CLOSED : BOOL; (*Operator Protection Safety Flag: OPERATOR PROTECTION CLOSED*)
		OP_ExtTrCLOSED : BOOL; (*Operator Protection Safety Flag: External Machine Transfer Doors Closed*)
		OP_ClosedFlrPw : BOOL; (*Operator Protection Safety Flag: Operator Protection Closed Rinser Power ON (Delay) V4.A.A.1.6.10c*)
		OP_ClosedFlrPwFault : BOOL; (*Operator Protection Safety Flag: Operator Protection Closed Filler Power Fault V4.A.A.1.6.10c*)
		BOOL044 : BOOL;
		OP_RELEASE_REQUEST : BOOL; (*Operator Protection Safety Flag: RELEASE REQUEST - MACHINE STOP*)
		OP_RELEASE_Fault : BOOL; (*Operator Protection Safety Flag: RELEASE CIRCUIT FAULT*)
		OP_TransferReleaseRequest : BOOL; (*Operator Protection Safety Flag: Transfer Area Release Request - Sent to Near Machine V4.A.A.1.6.10c*)
		BOOL048 : BOOL;
		BOOL049 : BOOL;
		EMERGENCY_ON : BOOL; (*EMERGENCY CIRCUIT READY*)
		EMERGENCY_CircuitFault : BOOL; (*EMERGENCY CIRCUIT FAULT*)
		EMERGENCY_FILLER : BOOL; (*EMERGENCY FILLER CIRCUIT READY*)
		EMERGENCY_BLOWER : BOOL; (*EMERGENCY BLOWER CIRCUIT READY*)
		EMERGENCY_BLOWER_Fault : BOOL; (*EMERGENCY BLOWER CIRCUIT Feed-Back Fault*)
		EMERGENCY_LABELER : BOOL; (*EMERGENCY LABELER CIRCUIT READY*)
		EMERGENCY_LABELER_Fault : BOOL; (*EMERGENCY LABELER CIRCUIT Feed-back Fault*)
		EmgSkidFault : BOOL; (*Emergency Skid Feed-Back Circuit FAULT*)
		FillerLiftPw : BOOL; (*Master nuovo*)
		FillerLiftPwFault : BOOL; (*Master nuovo*)
		SelMode_Auto : BOOL; (*Mode Selection: Automatic*)
		SelMode_JOG : BOOL; (*Mode Selection: JOG*)
		SelMode_Setting : BOOL; (*Mode Selection: Setting*)
		SelMode_Error : BOOL; (*Mode Selection: Selection Error "JOG Selected from External Machine"*)
		JOG_StopPB : BOOL; (*STOP Push Button on JOG Pressed*)
		JOG_Control_Error : BOOL; (*Jog Safety Flag: JOG Connection Error -Too much Jog Inserted*)
		Selector_Auto : BOOL; (*Selector mode position: Automatic*)
		SelModeAutoError : BOOL; (*Mode Selection: Automatic Error (JOG Enable Key Inserted)*)
		SelModeChange : BOOL; (*Mode Selection: Mode Change, machine Stopped requested*)
		BOOL069 : BOOL;
		DriveEnable : BOOL; (*Emergency + (Operator Protection * JOG) Drive Enabled*)
		JOG_Run : BOOL; (*Jog Safety Flag: JOG Run Command*)
		DriveSafeOFFTimeOut : BOOL; (*Drive Control: Machine Safe OFF Time Out*)
		DriveStopTimeOut : BOOL; (*Drive Control: Machine Stop Time Out*)
		JOG_SpeedError : BOOL; (*Filler JOG Speed Fault*)
		BOOL077 : BOOL;
		BOOL078 : BOOL;
		BOOL079 : BOOL;
		AirReady : BOOL; (*General Air ON: Ready*)
		AirCloseOP : BOOL; (*General Air OFF: Close the Operator Guard to Have Pressure*)
		ProcessValvesFault : BOOL; (*Filler Process Valves Feed-Back Fault*)
		CopValvesFault : BOOL; (*Filler Cop/Washing Valves Feed-Back Fault*)
		VbsValvesFault : BOOL; (*Nitrodoser valves Feed-Back fauòlt*)
		BOOL085 : BOOL;
		BOOL086 : BOOL;
		BOOL087 : BOOL;
		BOOL088 : BOOL;
		BOOL089 : BOOL;
		BOOL090 : BOOL;
		EMERGENCY_VBS : BOOL; (*EMERGENCY VBS READY //CANCELED in Safety document 40v0*)
		EmgVbsPressed : BOOL; (*Emergency Vbs Pressed //CANCELED in Safety document 40v0*)
		EmgVbsShc : BOOL; (*Emergency Vbs Fault //CANCELED in Safety document 40v0*)
		EMERGENCY_CONVEYOR : BOOL; (*EMERGENCY CONVEYOR READY*)
		EmgConveyorPressed : BOOL; (*Emergency Conveyor Pressed*)
		EmgConveyorSch : BOOL; (*Emergency Conveyor Fault*)
		CapBufOP_CLOSED : BOOL; (*Capper Buffer: Buffer Area Closed*)
		CapBuf2OP_CLOSED : BOOL; (*Capper Buffer 2 /Hopper External 2: Buffer Area Closed V4.A.A.1.6.10c*)
		CapBufOP1_Opened : BOOL; (*Capper Buffer: Buffer Door 1 Opened*)
		CapBufOP2_Opened : BOOL; (*Capper Buffer: Buffer Door 2 Opened*)
		CapBufOP1_Sch : BOOL; (*Capper Buffer: Buffer Door 1 Short Circuit  Safety*)
		CapBufOP2_Sch : BOOL; (*Capper Buffer: Buffer Door 2 Shor Circuit Safety*)
		BOOLext0007 : BOOL;
		CapBufEx_DriveEnable : BOOL; (*Capper Buffer/Hopper External: Drive Enable V4.A.A.1.6.10c*)
		CapMotionEnable : BOOL; (*Capper Motion Head Rotation: Motion Enable (Arol Equatorque/Zalkin) V4.A.A.1.6.10c*)
		BOOLext0010 : BOOL;
		BOOLext0011 : BOOL;
		BOOLext0012 : BOOL;
		CapBuf2OP1_Opened : BOOL; (*Capper Buffer/Hopper External: Buffer Door 1 Opened V4.A.A.1.6.10c*)
		CapBuf2OP2_Opened : BOOL; (*Capper Buffer/Hopper External: Buffer Door 2 Opened V4.A.A.1.6.10c*)
		CapBuf2OP1_Sch : BOOL; (*Capper Buffer/Hopper External: Buffer Door 1 Short Circuit  Safety V4.A.A.1.6.10c*)
		CapBuf2OP2_Sch : BOOL; (*Capper Buffer/Hopper External: Buffer Door 2 Shor Circuit Safety V4.A.A.1.6.10c*)
		BOOLext0017 : BOOL;
		BOOLext0018 : BOOL;
		BOOLext0019 : BOOL;
		CapArolPosReady : BOOL; (*Arol Capper Buffer: Position Ready for Doors Unlock*)
		CapArolPosFault : BOOL; (*Arol Capper Buffer: Position Fault*)
		CapArolHighFault : BOOL; (*Arol Capper Buffer: High Position Feed-Back Fault*)
		CapArolBlockedFault : BOOL; (*Arol Capper Buffer: Blocked Position Feed-Back Fault*)
		BOOLext0024 : BOOL;
		CapExtr1Op_Opened : BOOL; (*Cap Extractor 1: Door Opened*)
		CapExtr1Op_Shc : BOOL; (*Cap Extractor 1: Door Short Circuit Safety*)
		CapExtr2Op_Opened : BOOL; (*Cap Extractor 2: Door Opened*)
		CapExtr2Op_Shc : BOOL; (*Cap Extractor 2: Door Short Circuit Safety*)
		BOOLext0029 : BOOL;
		MO_BLO_BaseTest : BOOL; (*Machine Option: BLO Base Machine Test -> "SafeMachineOption00" (on Test = SAFETRUE)V4.A.A.1.6.10c*)
		BOOLext0031 : BOOL;
		MO_BLO_CnfError : BOOL; (*Machine Option: BLO Configuration Error -> Emergency Stop (SefeMachineOption00 = SAFETRUE with Hardware present) V4.A.A.1.6.10c*)
		OPFw_AreaState_AreaError : UINT; (*OP Forward (Zone 1+11): Area State / Area Error*)
		OPBkIn_AreaState_AreaError : UINT; (*OP Backward Inlet (Zone 2+12): Area State / Area Error*)
		OPBkOut_AreaState_AreaError : UINT; (*OP Backward Outlet (Zone 3+13): Area State / Area Error*)
		OPTrFw_AreaState_AreaError : UINT; (*OP Transfer Forward (Zone 4): Area State / Area Error*)
		OPTrBk_AreaState_AreaError : UINT; (*OP Transfer Backward (Zone 5): Area State / Area Error*)
		OPTrFw_TrBk_StateError : UINT; (*OP Transfer Forward/Transfer Backward: Doors State/Doors Error*)
		OPMnIn_AreaState_AreaError : UINT; (*OP Maintenance Inlet (Zone 7): Area State / Area Error*)
		OPMnOut_AreaState_AreaError : UINT; (*OP Maintenance Outlet (Zone 8) Area State / Area Error*)
		OPMnIn_MnOut_StateError : UINT; (*OP Maintenance Inlet/Maintenance Outlet: Doors State/Doors Error*)
		OPRnBkIn_AreaState_AreaErr : UINT; (*OP Rinser Backward Inlet (Zone16): Area State / Area Error*)
		OPRnBkIn_OpenedConfirm : UINT; (*OP Rinser Backward Inlet (Zone 16): Doors 1-:-8 Opened/Confirm*)
		OPRnBkIn_Lock1oo2LockSafety : UINT; (*OP Rinser Backward Inlet (Zone 16): Doors 1-:-8 Lock_1oo2/Lock_Safety*)
		OPRnBkIn_UnlockedShcError : UINT; (*OP Rinser Backward Inlet (Zone 16): Doors 1-:-8 Unlocked/Short Circuit*)
		OPRnBkOut_AreaState_AreaErr : UINT; (*OP Rinser Backward Outlet (Zone 17): Area State / Area Error*)
		OPRnBkOut_OpenedConfirm : UINT; (*OP Rinser Backward Outlet (Zone 17): Doors 1-:-8 Opened/Confirm*)
		OPRnBkOut_Lock1oo2LockSaf : UINT; (*OP Rinser Backward Outlet (Zone 17): Doors 1-:-8 Lock_1oo2/Lock_Safety*)
		OPRnBkOut_UnlockedShcError : UINT; (*OP Rinser Backward Outlet (Zone 17): Doors 1-:-8 Unlocked/Short Circuit*)
		OPRnMnOut_AreaState_AreaErr : UINT; (*OP Rinser Maintenance Outlet (Zone 18): Area State / Area Error*)
		OPRnMnIn_MnOut_StateError : UINT; (*OP Rinser Maintenance Inlet/Maintenance Outlet: Doors State/Doors Error*)
		UINT020 : UINT;
		UINT021 : UINT;
		UINT022 : UINT;
		EmgPB_Press : UINT; (*Filler Emergency Pus Button 1-:-8 Pressed*)
		EmgPB_Shc : UINT; (*Filler Emergency Pus Button 1-:-8 Short Circuit*)
		EmgDriveFault : UINT; (*Emergency Circuit Drive Safe OFF Feed Back Fault*)
		EmgOpDriveFault : UINT; (*Emergency + Operator Protection Circuit Drive Safe OFF Feed Back Fault*)
		EmgOpJogDriveFault : UINT; (*Emergency + (Operator Protection * Jog) Circuit Drive Safe OFF Feed Back Fault*)
		OPValveFault : UINT; (*Operator Protection Circuit Valves Closed Feed Back Fault V4.A.A.1.7.0*)
		SwVer1 : UINT; (*Configuration: Software Version First/Second Digit V4.A.A.1.6.10c*)
		SwVer2 : UINT; (*Configuration: Software Version Third/Fourth Digit V4.A.A.1.6.10c*)
		OPFw_Opened_Confirm : UDINT; (*OP Forward: Zone 1 _ Zone 11: Doors Opened/Confirm*)
		OPFw_Lock1oo2_LockSafety : UDINT; (*OP Forward: Zone 1 _ Zone 11: Doors Lock_1oo2/Lock_Safety*)
		OPFw_Unlocked_ShcError : UDINT; (*OP Forward: Zone 1 _ Zone 11: Doors Unlocked/Short Circuit*)
		OPBkIn_Opened_Confirm : UDINT; (*OP Backward Inlet: Zone 2 _ Zone 12: Doors Opened/Confirm*)
		OPBkIn_Lock1oo2_LockSafety : UDINT; (*OP Backward Inlet: Zone 2 _ Zone 12 Doors Lock_1oo2/Lock_Safety*)
		OPBkIn_Unlocked_ShcError : UDINT; (*OP Backward Inlet: Zone 2 _ Zone 12 Doors Unlocked/Short Circuit*)
		OPBkOut_Opened_Confirm : UDINT; (*OP Backward Outlet: Zone 3 _ Zone 13 Doors Opened/Confirm*)
		OPBkOut_Lock1oo2_LockSafety : UDINT; (*OP Backward Outlet: Zone 3 _ Zone 13 Doors Lock_1oo2/Lock_Safety*)
		OPBkOut_Unlocked_ShcError : UDINT; (*OP Backward Outlet: Zone 3 _ Zone 13 Doors Unlocked/Short Circuit*)
		OPPdBkIn_Opened_Confirm : UDINT; (*OP Pulp Doser Backward Inlet: Zone 21 _ Zone 22: Doors Opened/Confirm*)
		OPPdBkIn_Lock1oo2_LockSafety : UDINT; (*OP Pulp Doser Backward Inlet: Zone 21 _ Zone 22 Doors Lock_1oo2/Lock_Safety*)
		OPPdBkIn_Unlocked_ShcError : UDINT; (*OP Pulp Doser Backward Inlet: Zone 21 _ Zone 22 Doors Unlocked/Short Circuit*)
		UDINT013 : UDINT;
		CnfAreaPresent : UDINT; (*Operator Protection Zone Presence*)
	END_STRUCT;
	IO_SS3PModality_Type : 	STRUCT 
		DI_Adjustement : BOOL; (*Adjustement*)
		DI_Auto : BOOL; (*Auto*)
		DI_Jog : BOOL; (*Jog*)
	END_STRUCT;
	IO_MCRaw_Type : 	STRUCT 
		Input : IO_MCRawInput_Type;
		Output : IO_MCRawOutput_Type;
	END_STRUCT;
	IO_MCRawInput_Type : 	STRUCT 
		MachineCommand : ARRAY[0..31]OF USINT;
		MachineReference : ARRAY[0..31]OF USINT;
		FillerCommandReference : ARRAY[0..31]OF USINT;
		PAR : ARRAY[0..127]OF USINT;
	END_STRUCT;
	IO_MCRawOutput_Type : 	STRUCT 
		MachineAlarm : ARRAY[0..31]OF USINT;
		MachineStatus : ARRAY[0..31]OF USINT;
		FillerStatusAlarm : ARRAY[0..31]OF USINT;
	END_STRUCT;
	IO_SiriusStarter_Type : 	STRUCT  (*//V4.A.A.1.6.11*)
		DI_Fault : IO_Digital_IN_Type;
		DO_CW : BOOL;
		DO_CCW : BOOL;
	END_STRUCT;
	IO_ITC_Type : 	STRUCT 
		CVO : IO_ITC_CVO_Type;
		VBC : IO_ITC_VBC_Type;
		FILTEC : IO_ITC_FCI_Type; (*v1.65*)
		STRATEC : IO_ITC_FCI_Type; (*v1.65*)
		PRESSCO : IO_ITC_FCI_Type; (*v1.65*)
		HEUFT : IO_ITC_FCI_Type; (*v1.65*)
		FTSYSTEM : IO_ITC_FCI_Type; (*v1.65*)
		SIS : IO_ITC_FCI_Type; (*v1.65*)
		COP : IO_ITC_COP_Type;
		UVL : IO_ITC_UVL_Type; (*v1.63*)
		CFD : IO_ITC_CFD_Type; (*V4.A.A.1.6.12*)
		SIKO : IO_ITC_SIKO_Type; (*V4.A.A.1.6.12*)
		DOS : IO_ITC_DOS_Type; (*V4.A.A.1.6.11*)
		CVI : IO_ITC_CVI_DP_Type; (*V4.A.A.1.6.14*)
		CFD2 : IO_ITC_CFD_Type; (*V4.A.A.1.7.1*)
		CDR : IO_ITC_CDR_Type; (*V4.A.A.1.7.1*)
	END_STRUCT;
	IO_ITC_UVL_Type : 	STRUCT 
		In : UvlFlr_Type;
		Out : FlrUvl_Type;
	END_STRUCT;
	IO_ITC_CVO_Type : 	STRUCT 
		In : CvoFlr_Type;
		Out : FlrCvo_Type;
	END_STRUCT;
	IO_ITC_VBC_Type : 	STRUCT 
		In : VbcFlr_Type;
		Out : FlrVbc_Type;
	END_STRUCT;
	IO_ITC_FCI_Type : 	STRUCT 
		In : FciFlr_Type;
		Out : FlrFci_Type;
	END_STRUCT;
	IO_ITC_COP_Type : 	STRUCT 
		In : CopFlr_Type;
		Out : FlrCop_Type;
	END_STRUCT;
	IO_ITC_CFD_Type : 	STRUCT  (*V4.A.A.1.6.12*)
		In : CfdFlr_Type;
		Out : FlrCfd_Type;
	END_STRUCT;
	IO_ITC_DOS_Type : 	STRUCT  (*V4.A.A.1.6.11*)
		In : DosFlr_Type;
		Out : FlrDos_Type;
	END_STRUCT;
	IO_CSR_SCU_Type : 	STRUCT 
		DI_OverloadOK : BOOL;
		DI_ContactorFBK : BOOL; (*Contactor Feed-Back *)
		DI_SafetyEnable : BOOL; (*Safety Enable from IOMapping*)
		DO_StorePosition : BOOL;
		DO_PowerON : BOOL;
		DO_Down : BOOL;
		DO_Up : BOOL;
		DI_Powered : BOOL; (*master nuovo*)
		DO_PowerOn : BOOL; (*Master nuovo*)
	END_STRUCT;
	IO_CPU_Type : 	STRUCT 
		BatteryStatus : USINT; (*Battery status CPU (0 = battery low or missing, 1 = battery ok,)*)
		CoolingPlateTemperature : INT; (*Temperature cooling plate [1/10C] vrma*)
		Temperature : INT; (*Temperature CPU [1/10C] vrma*)
	END_STRUCT;
	IO_UPS_Type : 	STRUCT 
		DI_BatteryReady : BOOL; (*True = UPS in alarm*)
		DI_Alarm : BOOL; (*True = Battery > 85%*)
		DI_MainPowerOn : BOOL := TRUE; (*True = Main power supply on*)
		DI_ModuleOk : BOOL;
		DO_HmiRestart : BOOL;
	END_STRUCT;
	IO_ITC_SIKO_Type : 	STRUCT  (* *) (* *) (*80*)
		In : SikoFlr_Type; (* *) (* *) (*82*)
		Out : FlrSiko_Type; (* *) (* *) (*81*)
	END_STRUCT;
	IO_ITC_CVI_DP_Type : 	STRUCT  (*V4.A.A.1.6.14*)
		In : ARRAY[0..9]OF USINT;
		Out : ARRAY[0..9]OF USINT;
	END_STRUCT;
	IO_ITC_CDR_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		In : CdrFlr_Type;
		Out : FlrCdr_Type;
	END_STRUCT;
END_TYPE
