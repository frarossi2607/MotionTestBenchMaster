(*CAPPER*)

TYPE
	CAP_Config_Type : 	STRUCT 
		ChannelA : BOOL;
		ChannelB : BOOL;
		ChannelC : BOOL;
		HeadRotationDir : BOOL;
		BufferSize : UINT;
		PickAndPlace : UINT;
		CamHeightPosition : USINT;
	END_STRUCT;
	CAP_Head_Type : 	STRUCT  (*v1.5*)
		HeadNr : UINT; (*Head Displayed on Row*)
		Data1 : UINT;
		Data2 : UINT;
		Totalizer00 : UINT;
		Totalizer01 : UINT;
		Totalizer02 : UINT;
		Totalizer03 : UINT;
		Totalizer04 : UINT;
		Totalizer05 : UINT;
		Totalizer06 : UINT;
		Totalizer07 : UINT;
		Bool00 : BOOL;
		Bool01 : BOOL;
		Bool02 : BOOL;
		Bool03 : BOOL;
		Bool04 : BOOL;
		Bool05 : BOOL;
		Bool06 : BOOL;
		Bool07 : BOOL;
		LineVisibility : BOOL;
	END_STRUCT;
	CAP_Mode_Type : 
		(
		CAP_Idle,
		CAP_Production,
		CAP_ProductionReady,
		CAP_Emptying,
		CAP_EmptyingRunning,
		CAP_EmptyingDone,
		CAP_BufferLifting,
		CAP_BufferLiftingDone,
		CAP_BufferLowering,
		CAP_BufferLoweringDone,
		CAP_SizeChange,
		CAP_SizeChangeDone
		);
	CAP_SikoMode_Type : 
		(
		SikoMbd_Idle,
		SikoMbd_ManualPositioningHoming,
		SikoMbd_ManualPositioning,
		SikoMbd_WriteParameterM171,
		SikoMbd_WriteParameterM172,
		SikoMbd_WriteParameterM173,
		SikoMbd_PosizioningTimeout,
		SikoMbd_AutoPositioning,
		SikoMbd_MachineEmptying
		);
	CAP_CamMode_Type : 
		(
		CamSizeChange_Init,
		Cam_SizeChange_WaitOperator,
		Cam_SizeChange_WaitMachineStop,
		Cam_SizeChange_Unlock,
		Cam_SizeChange_Move,
		Cam_SizeChange_Lock,
		Cam_SizeChange_WaitOperatorOff,
		Cam_SizeChange_Done
		);
	CAP_BufferMode_Type : 
		(
		Buffer_Idle,
		Buffer_StartUp,
		Buffer_StartUpFilling,
		Buffer_StartUpFillingTimeOut,
		Buffer_Production,
		Buffer_ProductionLowLevel,
		Buffer_EndProductionFilled,
		Buffer_EndProductionEmptying,
		Buffer_EmptyingRotationReverse,
		Buffer_MotorRotationStop,
		Buffer_Emptying,
		Buffer_EmptyingOpenGate,
		Buffer_EmptyingTimeOut,
		Buffer_EmptyingFW1,
		Buffer_EmptyingFW1TimeOut,
		Buffer_EmptyingFW2,
		Buffer_EmptyingFW2TimeOut,
		Buffer_EmptyingFWStopRotation,
		Buffer_EmptyingBW,
		Buffer_EmptyingBWStopRotation,
		Buffer_EmptyingFW3,
		Buffer_EmptyingDone,
		Buffer_MovingUp,
		Buffer_MovingUpRemoveBlock,
		Buffer_MovingUpLifting,
		Buffer_MovingUpInsertBlock,
		Buffer_MovingUpCompleted,
		Buffer_MovingUpLiftingError,
		Buffer_MovingUpBlockError,
		Buffer_MovingDown,
		Buffer_MovingDownWaitOperator,
		Buffer_MovingDownCheckCaps,
		Buffer_MovingDownLifting,
		Buffer_MovingDownRemoveBlock,
		Buffer_MovingDownLowering,
		Buffer_MovingDownInsertBlock,
		Buffer_MovingDownCompleted,
		Buffer_MovingDownLoweringError,
		Buffer_MovingDownLiftingError,
		Buffer_MovingDownBlockError,
		Buffer_SizeChangeInit,
		Buffer_SizeChangeGuideLift,
		Buffer_SizeChangeGuideLow,
		Buffer_SizeChangeGuideHigh,
		Buffer_SizeChangeGuideLower,
		Buffer_SizeChangeGuideUnlock,
		Buffer_SizeChangeGuideLock,
		Buffer_SizeChangeDone,
		Buffer_AdjustmentInit, (*//V4.A.A.1.6.11*)
		Buffer_AdjustmentPositionToZero, (*//V4.A.A.1.6.11*)
		Buffer_AdjustmentZeroToPosition, (*//V4.A.A.1.6.11*)
		Buffer_AdjustmentPositionReached, (*//V4.A.A.1.6.11*)
		Buffer_AdjustmentDone, (*//V4.A.A.1.6.11*)
		Buffer_AdjustmentFault (*//V4.A.A.1.6.12h*)
		);
	CAP_EquCalMode_Type : 
		( (*//V4.A.A.1.6.12 Calibration Sequence*)
		Wait_Start, (*Wait For Calibration Start V4.A.A.1.6.12*)
		Reset_Data, (*Calibration Data Reset V4.A.A.1.6.12*)
		Empty1_SaveCurrent, (*Calibration 1 without Friction -Save Current V4.A.A.1.6.12*)
		Empty1_Done, (*Calibration 1 Done V4.A.A.1.6.12*)
		Empty2_SaveCurrent, (*Calibration 2 without Friction -Save Current V4.A.A.1.6.12*)
		Empty2_Done, (*Calibration 2 Done V4.A.A.1.6.12*)
		Empty3_SaveCurrent, (*Calibration 3 without Friction -Save Current V4.A.A.1.6.12*)
		Empty3_Done, (*Calibration 3 Done V4.A.A.1.6.12*)
		Wait_Friction, (*Wait For Friction Installation V4.A.A.1.6.12*)
		Friction1_SaveCurrent, (*Calibration 1 with Friction -Save Current V4.A.A.1.6.12*)
		Friction1_Done, (*Calibration 1 with Friction Done V4.A.A.1.6.12*)
		Friction2_SaveCurrent, (*Calibration 2 with Friction -Save Current V4.A.A.1.6.12*)
		Friction2_Done, (*Calibration 2 with Friction  Done V4.A.A.1.6.12*)
		Friction3_SaveCurrent, (*Calibration 3 with Friction -Save Current V4.A.A.1.6.12*)
		Friction3_Done, (*Calibration 3 with Friction  Done V4.A.A.1.6.12*)
		Wait_Calculation, (*Wait For Data Average Calculation V4.A.A.1.6.12*)
		Friction_Remove, (*Wait For Friction Remove V4.A.A.1.6.12*)
		Calibration_Done (*Calibration Done V4.A.A.1.6.12*)
		);
	CAP_CapDisMode_Type : 
		( (*V4.A.A.1.7.0*)
		CapDis_Idle,
		CapDis_ProductionInit,
		CapDis_WaitSignal,
		CapDis_WaitCaps,
		CapDis_PrimingReq,
		CapDis_Priming,
		CapDis_Production,
		CapDis_RestartAfterBlock,
		CapDis_RestartAndEmptying,
		CapDis_EmptyingInit,
		CapDis_EmptyingCheck,
		CapDis_Emptying,
		CapDis_EmptyingFault,
		CapDis_EmptyingCycleEnd,
		CapDis_EmptyingDone
		);
	CAP_Type : 	STRUCT 
		DataOut : CAP_DataOut_Type;
	END_STRUCT;
	CAP_DataOut_Type : 	STRUCT 
		CapperEmpty : BOOL;
		ContainerStop : BOOL; (*//1.63*)
		ReleaseInProduction : BOOL;
		ReleaseInEmptying : BOOL;
		BufferLifted : BOOL;
		ReleaseInManual : BOOL;
		BufferLowered : BOOL;
		BufferHighSpeedReached : BOOL;
		SlowSpeedForEmptyReq : BOOL;
		MachineStop : BOOL;
		MachineStart : BOOL;
		ConfigSaveReq : BOOL;
		GreasingPositioningReq : BOOL;
		UVLampAOn : BOOL; (*v1.4*)
		UVLampBOn : BOOL; (*v1.4*)
		UVLampCOn : BOOL; (*v1.4*)
		Idle : BOOL; (*v1.4*)
		Release1Active : BOOL; (*v1.4*)
		Release2Active : BOOL; (*v1.4*)
		Release3Active : BOOL; (*v1.4*)
		Release4Active : BOOL; (*v1.4*)
		BufferSizeChange_MaxPosition : BOOL; (*//V4.A.A.1.6.11*)
		BufferSizeChange_MinPosition : BOOL; (*//V4.A.A.1.6.11*)
		IonisationBoxDoor : BOOL; (*V4.A.A.1.6.12h*)
		CapDis_MachineRestatBlocked : BOOL; (*V4.A.A.1.7.0*)
		CapDis_MachineAutorestart : BOOL; (*V4.A.A.1.7.0*)
		CapDis_CapsRequest : BOOL; (*V4.A.A.1.7.0*)
		CapDis_EmptyingRequest : BOOL; (*V4.A.A.1.7.0*)
		CapDis_VaporizationRequest : BOOL; (*V4.A.A.1.7.0*)
		CapDis_WarmRequest : BOOL; (*V4.A.A.1.7.0*)
		CapDis_PrimingRequest : BOOL; (*V4.A.A.1.7.0*)
		CapDis_EmptySkip : BOOL; (*V4.A.A.1.7.0*)
		CapDis_InletPreformsStopped : BOOL; (*V4.A.A.1.7.0*)
		CapDis_FillerMode : INT; (*V4.A.A.1.7.0*)
	END_STRUCT;
END_TYPE
