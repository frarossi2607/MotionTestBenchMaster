(*CFG*)

TYPE
	CFG_Type : 	STRUCT 
		DataOut : CFG_DataOut_Type;
	END_STRUCT;
	CFG_DataOut_Type : 	STRUCT 
		Busy : BOOL;
		CapSaved : BOOL;
		OpsSaved : BOOL;
		ConfigLoaded : BOOL;
		OPSDefault : BOOL;
		MotionDefault : BOOL;
		ItcDefault : BOOL;
		PaoDefault : BOOL;
		CfgDefault : BOOL;
		CfgCapDefault : BOOL;
		ErrorSavingMotion : BOOL;
		ErrorSavingItc : BOOL;
		ErrorSavingPao : BOOL;
		ErrorSavingOPS : BOOL;
		ErrorSavingCfg : BOOL;
		ErrorSavingCfgCap : BOOL;
	END_STRUCT;
END_TYPE

(*CONFIGURATION PARAMETER*)

TYPE
	CFG_Par_Type : 	STRUCT 
		Filler : CFG_Filler_Type; (*V4.A.A.1.6.12*)
		DummyContainers : CFG_DumCon_Type;
		Cop : CFG_Cop_Type;
		Lifting : CFG_Lifting_Type;
		Process : CFG_Process_Type;
		Machine : CFG_Machine_Type;
		ClosingUnit : CFG_Clu_Type;
		Motors : CFG_Motors_Type;
		WhiteRoom : CFG_WhiteRoom_Type;
		FCI : CFG_FCI_Type;
		ProductChangeOver : CFG_ProductChangeOver_Type;
		BottleBottomCooling : CFG_BTC_Type;
		Rinser : CFG_RNS_Type;
		CapFedeer : CFG_CFD_Type;
		CapFedeer2 : CFG_CFD_Type; (*v4.A.A.1.7.0*)
		OperatorSafety : CFG_OperatorSafety_Type;
		Maintenance : CFG_MNT_Type;
	END_STRUCT;
	CFG_Cap_Par_Type : 	STRUCT 
		Elements : ARRAY[0..16]OF HMI_ComboBoxElements_Type;
		Data : ARRAY[0..16]OF CFG_CapFormatData_Type;
	END_STRUCT;
	CFG_Crw_Par_Type : 	STRUCT 
		Elements : ARRAY[0..15]OF HMI_ComboBoxElements_Type;
		Data : ARRAY[0..15]OF CFG_CrwFormatData_Type;
	END_STRUCT;
END_TYPE

(*CLOSING UNIT*)

TYPE
	CFG_Clu_Type : 	STRUCT 
		Capper : CFG_Cap_Type;
		Crowner : CFG_Crw_Type;
	END_STRUCT;
END_TYPE

(*CAPPER*)

TYPE
	CFG_Cap_Type : 	STRUCT 
		GreasingPumpPresent : BOOL;
		Present : BOOL;
		CapDisPresent : BOOL; (*V4.A.A.1.7.0*)
		Buffer : CFG_CapBuffer_Type;
		Channel : CFG_CapChannel_Type;
		Type : CFG_CapManufactor_Type;
		SizeChange : CFG_CapSizeChange_Type;
		HeadRotation : CFG_CapHeadRotation_Type;
		ReleasePresent : USINT; (*1 = Release 1; 2 = Release 2; 3 = Release 3; 4 = Channel 4*)
	END_STRUCT;
	CFG_CapManufactor_Type : 	STRUCT 
		Arol : BOOL;
		Zalkin : BOOL;
	END_STRUCT;
	CFG_CapBuffer_Type : 	STRUCT 
		Spiral : BOOL;
		Vertical : BOOL;
	END_STRUCT;
	CFG_CapHeadRotation_Type : 	STRUCT 
		BrushlessHead : BOOL; (*Arol equatorque or Zalkin Brushless for single head*)
		Hrm : BOOL; (*Brushless for all heads*)
		Drive : BOOL; (*Frequency converter for all heads*)
	END_STRUCT;
	CFG_CapChannel_Type : 	STRUCT 
		EmptyThroughPeP : BOOL;
		EmptyThroughGate : BOOL;
		ChannelOptional : ARRAY[0..3]OF CFG_CapChannelOpt_Type;
	END_STRUCT;
	CFG_CapChannelOpt_Type : 	STRUCT 
		SlidingSensorPresent : BOOL;
		UvLampLowPressure : BOOL;
		UvLampHonle : BOOL;
		UvLampClaranor : BOOL;
		Ionizer : BOOL;
	END_STRUCT;
	CFG_CamHeighSizeChange_Type : 	STRUCT 
		Present : BOOL;
		Manual : BOOL; (*Manual type*)
		Automatic : BOOL; (*Automatic Type*)
	END_STRUCT;
	CFG_CapSizeChange_Type : 	STRUCT  (*Part involved in size change*)
		BottleGuideChange : BOOL; (*Arol Multibody System*)
		BufferSize : BOOL;
		Channel : BOOL;
		CamHeigh : CFG_CamHeighSizeChange_Type;
		PickAndPlace : BOOL;
	END_STRUCT;
	CFG_CapFormatData_Type : 	STRUCT 
		HeadRotationDir : BOOL;
		Channel : UINT; (*1 = Channel A; 2 = Channel B; 3 = Channel C; 4 = Channel D*)
		BufferSize : UINT; (*Spiral: 1 = Low Guide Pos; 2 = High Guide Pos;
Vertical: 1 = Width A; 2 = Width B; 3 = Width C; 1 = Width D;*)
		CamHeightPosition : USINT; (* 1 = Low Cam Pos; 2 = High Cam Pos;*)
		PickAndPlaceN : UINT; (*1 = Release 2; 2 = Release 2; 3 = Release 3; 4 = Channel 4*)
	END_STRUCT;
END_TYPE

(*CROWNER*)

TYPE
	CFG_Crw_Type : 	STRUCT 
		Present : BOOL;
		Channel : CFG_CrwChannel_Type;
		Type : CFG_CrwManufactor_Type;
	END_STRUCT;
	CFG_CrwChannel_Type : 	STRUCT 
		SlidingSensorPresent : BOOL;
		EmptyThroughPeP : BOOL;
		ChannelN : INT;
	END_STRUCT;
	CFG_CrwManufactor_Type : 	STRUCT 
		Sidel : BOOL;
		Others : BOOL;
	END_STRUCT;
	CFG_CrwFormatData_Type : 	STRUCT 
		Channel : UINT; (*1 = Singol Channel
2 = Double Channel*)
		PickAndPlaceN : UINT;
	END_STRUCT;
END_TYPE

(*DUMMY CONTAINERS*)

TYPE
	CFG_DumCon_Type : 	STRUCT 
		Automatic : BOOL;
		Lifting : BOOL;
	END_STRUCT;
END_TYPE

(*COP*)

TYPE
	CFG_Cop_Type : 	STRUCT 
		ValveWashing : CFG_ValveWashing_Type;
		FoamingUnitType : CFG_FoamingUnit_Type;
		ChlorinetedWaterBarrierPresent : BOOL;
		DoubleContainerBlock : BOOL;
		CapBufferLifting : BOOL;
		WithSatellites : BOOL;
		DrainableFoamingUnit : BOOL;
		FoamingGunType : CFG_FoamingGun_Type;
		FullFbk : BOOL;
		ExternalDryingOption : BOOL; (*v4.A.A.1.7.0*)
		VenturiRinsing : BOOL;
		ContainerShower : BOOL;
		NeckRinse : BOOL;
	END_STRUCT;
	CFG_ValveWashing_Type : 	STRUCT 
		Present : BOOL;
		WithContainers : BOOL;
	END_STRUCT;
	CFG_FoamingGun_Type : 	STRUCT 
		WithAVE224 : BOOL;
		WithManualSelector : BOOL;
	END_STRUCT;
	CFG_FoamingUnit_Type : 	STRUCT 
		Diversey : BOOL;
		Ecolab : BOOL;
		External : BOOL;
		Loehrke : BOOL;
		Sidel : BOOL;
	END_STRUCT;
END_TYPE

(*LIFTING*)

TYPE
	CFG_Lifting_Type : 	STRUCT 
		Present : BOOL; (*V4.A.A.1.6.12*)
		Movements : CFG_LiftingMovement_Type;
		Safety : CFG_LiftingSafety_Type;
	END_STRUCT;
	CFG_LiftingMovement_Type : 	STRUCT 
		Filler : CFG_LiftingMovementSku_Type; (*V4.A.A.1.6.12*)
		Crowner : CFG_LiftingMovementClu_Type;(*master nuvo*)
		Capper : CFG_LiftingMovementClu_Type;(*master nuvo*)
		OutletConveyor : CFG_LiftingMovementConveyor_Type; (*V4.A.A.1.6.12*)
		Rinser : CFG_LiftingMovementMotor_Type; (*V4.A.A.1.6.12*)
	END_STRUCT;
	CFG_LiftingMovementConveyor_Type : 	STRUCT 
		SizeChangeHeight : BOOL; (*V4.A.A.1.6.12*)
		SizeChangeBottleGuide : BOOL; (*V4.A.A.1.6.12*)
	END_STRUCT;
	CFG_LiftingMovementSku_Type : 	STRUCT 
		MaxMechanicalTankHeight : REAL;
		MinMechanicalTankHeight : REAL;
		DeltaTank : REAL;
		MaxMechanicalCammaHeight : REAL;
		MinMechanicalCammaHeight : REAL;
		DeltaCamma : REAL;
		SizeChangeHeight : REAL;
		ToleranceUpCamma : REAL;
		ToleranceDownCamma : REAL;
	END_STRUCT;
	CFG_LiftingMovementClu_Type : 	STRUCT 
		SizeChangeHeight : REAL;
		MinMechanicalHeight : REAL;
		MaxMechanicalHeight : REAL;
		Delta : REAL;
		UncouplingRequest : BOOL;
		UncoupledHeight : REAL;
		MaxCoupledHeight : REAL;
	END_STRUCT;
	CFG_LiftingMovementMotor_Type : 	STRUCT 
		SizeChangeHeight : REAL;
		MinMechanicalHeight : REAL;
		MaxMechanicalHeight : REAL;
		Delta : REAL;
	END_STRUCT;
	CFG_LiftingSafety_Type : 	STRUCT 
		EquipmentSensorHeight : REAL;
	END_STRUCT;
END_TYPE

(*PROCESS*)

TYPE
	CFG_Process_Type : 	STRUCT 
		InternalSkid : BOOL;
		BlendFill : BOOL;
	END_STRUCT;
END_TYPE

(*MACHINE*)

TYPE
	CFG_Machine_Type : 	STRUCT 
		Type : CFG_MachineModel_Type;
		Combi : CFG_MachineCombi_Type;
	END_STRUCT;
	CFG_MachineModel_Type : 	STRUCT 
		SRMA : BOOL;
		SRMB : BOOL;
		SRMC : BOOL;
		SRME : BOOL;
		SRMH : BOOL;
		SRMO : BOOL;
	END_STRUCT;
	CFG_MachineCombi_Type : 	STRUCT 
		BAF : BOOL;
		BF : BOOL;
		BLF : BOOL;
		BFL : BOOL;
	END_STRUCT;
END_TYPE

(*MOTORS*)

TYPE
	CFG_Motors_Type : 	STRUCT 
		ConveyorVFD : BOOL;
		DoubleInlet : BOOL;
		FootbarPresent : BOOL;
		CoolingFan : CFG_MachineFan_Type;
	END_STRUCT;
	CFG_MachineFan_Type : 	STRUCT 
		Inlet : CFG_InletFan_Type;
		Filler : CFG_FillerFan_Type;
		Outlet : CFG_OutletFan_Type;
	END_STRUCT;
	CFG_InletFan_Type : 	STRUCT 
		In : ARRAY[1..4]OF CFG_CoolingFan_Type;
		Main : CFG_CoolingFan_Type;
		Out : ARRAY[1..4]OF CFG_CoolingFan_Type;
	END_STRUCT;
	CFG_FillerFan_Type : 	STRUCT 
		In : ARRAY[1..10]OF CFG_CoolingFan_Type;
		Main : CFG_CoolingFan_Type;
		Out : ARRAY[1..6]OF CFG_CoolingFan_Type;
	END_STRUCT;
	CFG_OutletFan_Type : 	STRUCT 
		In : ARRAY[1..4]OF CFG_CoolingFan_Type;
		Main : CFG_CoolingFan_Type;
		Out : ARRAY[1..4]OF CFG_CoolingFan_Type;
	END_STRUCT;
	CFG_CoolingFan_Type : 	STRUCT 
		Present : BOOL;
		CommandPresent : BOOL;
	END_STRUCT;
END_TYPE

(*WHITE ROOM*)

TYPE
	CFG_WhiteRoom_Type : 	STRUCT 
		Basement : CFG_WhiteRoomZone_Type;
		Filler : CFG_WhiteRoomZone_Type;
		Rinser : CFG_WhiteRoomZone_Type;
		Transfer : CFG_WhiteRoomZone_Type;
	END_STRUCT;
	CFG_WhiteRoomZone_Type : 	STRUCT 
		Present : BOOL;
		NumerOfFan : USINT;
		HmiLightPresent : BOOL;
		GalvaniRoof : BOOL;
	END_STRUCT;
END_TYPE

(*CAPFEEDER - Capfeeder Model*)

TYPE
	CFG_CFD_Type : 	STRUCT 
		Aidlin : BOOL;
		Optifeed : BOOL;
		Zalkin : BOOL;
		Customer : BOOL;
	END_STRUCT;
END_TYPE

(*FCI - Full Container Inspector*)

TYPE
	CFG_FCI_Type : 	STRUCT 
		FTSystem : BOOL;
		Heuft : BOOL;
		Pressco : BOOL;
		Stratec : BOOL;
		Filltec : BOOL;
		SIS : BOOL;
	END_STRUCT;
END_TYPE

(*PRODUCT CHANGE OVER*)

TYPE
	CFG_ProductChangeOver_Type : 	STRUCT 
		APCO : BOOL;
		ICO : BOOL;
	END_STRUCT;
END_TYPE

(*INTERCHANGE SIGNALS*)

TYPE
	CFG_ITC_Type : 	STRUCT 
		Blower : ITC_Parameter_Type;
		Labeller : ITC_Parameter_Type;
		Seamer : ITC_Parameter_Type;
		Actis : ITC_Parameter_Type;
		ClosingUnit : ITC_Parameter_Type;
		Skid : ITC_Parameter_Type;
		CoreBlend : ITC_Parameter_Type;
		Cip : ITC_Parameter_Type;
		Cop : ITC_Parameter_Type;
		WhiteRoom : ITC_Parameter_Type;
		InletConveyors : ITC_Parameter_Type;
		OutletConveyors : ITC_Parameter_Type;
		Fci : ITC_Parameter_Type;
		Vbc : ITC_Parameter_Type;
		CapFeeder1 : ITC_Parameter_Type;
		CapFeeder2 : ITC_Parameter_Type;
		Coder : ITC_Parameter_Type;
		LidFeeder : ITC_Parameter_Type;
		SignalConcentrator : ITC_Parameter_Type;
		DataAcquisition : ITC_Parameter_Type;
		ProductChangeover : ITC_Parameter_Type;
		SikoMultibody : ITC_Parameter_Type; (*V4.A.A.1.6.12*)
		RinserRecSkd : ITC_Parameter_Type; (*V4.A.A.1.6.12*)
		FlavorDoser : ITC_Parameter_Type; (*V4.A.A.1.6.12*)
		CapDis : ITC_Parameter_Type; (*V4.A.A.1.7.0*)
	END_STRUCT;
	ITC_Parameter_Type : 	STRUCT 
		ComType : USINT; (*Communication Type:
0 = NOT PRESENT
1 = TCP IP
2 = ETH IP
3 = MODBUS TCP
4 = PROFIBUS
5 = POWERLINK EPL
6 = HW
7 = UDP
8 = SCC
9 = PROFINET
10 = OPC*)
		ComAddress : STRING[35]; (*Communication Partner Adress*)
		ComSwap : BOOL; (*Swap the comunication*)
		EnableServer : BOOL; (*Select Mode: SERVER = TRUE / CLIENT = FALSE*)
		LocalPort : UINT; (*Local port number used to Receive*)
		RemotePort : UINT; (*Remote port number used o Send*)
		RecLength : UDINT; (*Received data Length (BYTE)*)
		SendLength : UDINT; (*Send data Length (BYTE)*)
		RecTimeOut : TIME; (*Receive data TimeOut [ms]*)
		SendTimeAct : TIME; (*Send data Time [ms]*)
	END_STRUCT;
END_TYPE

(*BOTTLE COOLING*)

TYPE
	CFG_BTC_Type : 	STRUCT 
		Present : BOOL;
		UvLamp : BOOL;
		Loose : BOOL;
		Recycling : BOOL;
		DosingPump : BOOL;
		TankSloped : BOOL;
	END_STRUCT;
END_TYPE

(*FILLER V4.A.A.1.6.12*)

TYPE
	CFG_Filler_Type : 	STRUCT 
		ContainerLifting : BOOL;
	END_STRUCT;
END_TYPE

(*RINSER*)

TYPE
	CFG_RNS_Type : 	STRUCT 
		Present : BOOL;
		Recovery : BOOL;
		NoBottleNoSpray : BOOL;(*Master nuovo*)
		ExternalRecoverySkid : BOOL; (*V4.A.A.1.6.12*)
		CipPresent : BOOL; (*V4.A.A.1.7.0*)
		FootbarPresent : BOOL; (*V4.A.A.1.7.0*)
	END_STRUCT;
END_TYPE

(*OPERATOR SAETY*)

TYPE
	CFG_OPS_Type : 	STRUCT 
		Door : ARRAY[0..MAX_CFG_DoorConfiguration]OF CFG_Doors_Type;
		Jog : ARRAY[0..MAX_CFG_JogConfiguration]OF CFG_Jog_Type;
		Emergency : ARRAY[0..MAX_CFG_EmergencyConfiguration]OF CFG_Emergency_Type;
		Layout : CFG_Layout_Type; (*V 1.61*)
	END_STRUCT;
	CFG_Doors_Type : 	STRUCT 
		Number : UINT;
		Zone : UINT;
	END_STRUCT;
	CFG_Jog_Type : 	STRUCT 
		Zone : UINT;
	END_STRUCT;
	CFG_Emergency_Type : 	STRUCT 
		Number : UINT;
	END_STRUCT;
	CFG_Layout_Type : 	STRUCT  (*V 1.61*)
		StarsNumber : UINT;
		SidesNumber : UINT;
		ExitLenght : UINT;
		BufferDoorPosition : UINT; (*V4.A.A.1.6.12d*)
	END_STRUCT;
END_TYPE

(*CONFIGURATION*)

TYPE
	CFG_OperatorSafety_Type : 	STRUCT 
		AcknoledgeButtonZone : BOOL;
		DoorCabinet : BOOL; (*v1.4 DoorCabinet Sensor Presence*)
		EuchnerKey : BOOL; (*v1.4 Euchner key Presence*)
	END_STRUCT;
END_TYPE

(*MAINTENANCE*)

TYPE
	CFG_MNT_Type : 	STRUCT 
		DeEnergization : BOOL; (*LOTO*)
		PreventiveMaintenance : BOOL; (*TPM*)
		SamplingMoldOption : BOOL; (*Mold Sampling at machine exit bottle Ejector present V4.A.A.1.6.12*)
	END_STRUCT;
END_TYPE
