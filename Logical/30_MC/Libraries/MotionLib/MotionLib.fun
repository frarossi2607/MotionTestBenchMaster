(*FUNCTION INTERFACE*)

FUNCTION FC_diReminder : DINT (*DINT Reminder*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		i_diDividend : DINT;
		i_diDivisor : DINT;
		i_diStart : DINT;
	END_VAR
	VAR
		diReminder_a : DINT;
		diReminder_b : DINT;
	END_VAR
END_FUNCTION

FUNCTION FC_LongRealReminder : LREAL (*LREAL Reminder*)
	VAR_INPUT
		i_lrDividend : LREAL;
		i_lrDivisor : LREAL;
		i_lrStart : LREAL;
	END_VAR
	VAR
		lrReminder_a : LREAL;
		lrReminder_b : LREAL;
	END_VAR
END_FUNCTION

FUNCTION FC_RealReminder : REAL (*REAL Reminder*)
	VAR_INPUT
		i_rDividend : REAL;
		i_rDivisor : REAL;
		i_rStart : REAL;
	END_VAR
	VAR
		rReminder_a : REAL;
		rReminder_b : REAL;
	END_VAR
END_FUNCTION

FUNCTION FC_RephasingMachine : LREAL (*Function for finding the machine rephasing position*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_IN_OUT
		iq_astInletSubModuleAxis : ARRAY[0..CST_LastInletModuleAxis] OF ST_GeneralAxis;
		iq_astFillerSubModuleAxis : ARRAY[0..CST_LastFillerModuleAxis] OF ST_GeneralAxis;
		iq_astOutletSubModuleAxis : ARRAY[0..CST_LastOutletModuleAxis] OF ST_GeneralAxis;
	END_VAR
	VAR
		udiRowIndex : UDINT;
		udiColumnIndex : UDINT;
		udiAxisIndex : UDINT;
		udiLastAxisIndex : UDINT;
		auiAxisIndex : ARRAY[0..30] OF LREAL;
		lrMinimumValue : LREAL;
		lrTemp : LREAL;
		alrPositions : ARRAY[0..30] OF LREAL;
		aalrDistances : ARRAY[0..30,0..30] OF LREAL;
	END_VAR
END_FUNCTION

FUNCTION FC_RephasingPositionFiller : LREAL (*Find The Position Of The First Axis*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_IN_OUT
		iq_astSubModuleAxis : ARRAY[0..CST_LastFillerModuleAxis] OF ST_GeneralAxis;
	END_VAR
	VAR
		udiRowIndex : UDINT;
		udiColumnIndex : UDINT;
		udiAxisIndex : UDINT;
		lrMinimumValue : LREAL;
		lrTemp : LREAL;
		aalrDistances : ARRAY[0..CST_LastFillerModuleAxis,0..CST_LastFillerModuleAxis] OF LREAL;
	END_VAR
END_FUNCTION

FUNCTION FC_RephasingPositionInlet : LREAL
	VAR_IN_OUT
		iq_astSubModuleAxis : ARRAY[0..CST_LastInletModuleAxis] OF ST_GeneralAxis;
	END_VAR
	VAR
		udiRowIndex : UDINT;
		udiColumnIndex : UDINT;
		udiAxisIndex : UDINT;
		lrMinimumValue : LREAL;
		lrTemp : LREAL;
		aalrDistances : ARRAY[0..CST_LastInletModuleAxis,0..CST_LastInletModuleAxis] OF LREAL;
	END_VAR
END_FUNCTION

FUNCTION FC_RephasingPositionOutlet : LREAL
	VAR_IN_OUT
		iq_astSubModuleAxis : ARRAY[0..CST_LastOutletModuleAxis] OF ST_GeneralAxis;
	END_VAR
	VAR
		udiRowIndex : UDINT;
		udiColumnIndex : UDINT;
		udiAxisIndex : UDINT;
		lrMinimumValue : LREAL;
		lrTemp : LREAL;
		aalrDistances : ARRAY[0..CST_LastOutletModuleAxis,0..CST_LastOutletModuleAxis] OF LREAL;
	END_VAR
END_FUNCTION

FUNCTION FC_TeensOfmmToDegrees : LREAL
	VAR_INPUT
		i_iTeensOfmm : INT;
		i_lrMachineStep : LREAL;
		i_xNegativeResult : BOOL := FALSE;
		i_xWithoutModulo : BOOL;
	END_VAR
	VAR
		lrTempStep : LREAL;
	END_VAR
END_FUNCTION

FUNCTION FC_GetAccFromTimeAndJerk : REAL (*Get the acceleration (deceleration) value from time and jerk*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		i_rTime : REAL;
		i_rJerk : REAL;
		i_rVelocity : REAL;
	END_VAR
	VAR
		rFistSolution : REAL;
		rSecondSolution : REAL;
		rTemp : REAL;
		rTime : REAL;
	END_VAR
END_FUNCTION

FUNCTION FC_mmToDegree : REAL (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		i_lrMachineStep : LREAL;
		i_rPositionMm : REAL;
	END_VAR
	VAR
		rTempStep : REAL;
	END_VAR
END_FUNCTION

FUNCTION FC_DegreeToMm : REAL (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		i_lrMachineStep : LREAL;
		i_rPositionDegree : REAL;
		i_xRemindResult : BOOL;
	END_VAR
	VAR
		rTempStep : REAL;
	END_VAR
END_FUNCTION
(*UTILITY FUNCTION BLOCK INTERFACE*)

FUNCTION_BLOCK FB_Position2Velocity (*Position to velocity converter*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		i_diPosition : DINT;
	END_VAR
	VAR_OUTPUT
		q_rVelocity : REAL;
	END_VAR
	VAR CONSTANT
		c_usiNSample : USINT := 10;
	END_VAR
	VAR
		fbRTInfo : RTInfo;
		adiBuffer : ARRAY[0..c_usiNSample] OF DINT;
		arBufferVel : ARRAY[0..c_usiNSample] OF REAL;
		i : UINT;
		uiCount : UINT;
		rInternal : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_CamGenerator (*Double Cam Generator Function Block*)
	VAR_INPUT
		i_xEnable : BOOL; (*Function block enable*)
		i_pxPointerOutput : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_pxPointerStepAdv : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_rOnPosition : REAL; (*Cam A on position*)
		i_rOffPosition : REAL; (*Cam A off position*)
		i_rOnPositionB : REAL := 0; (*Cam B on position*)
		i_rOffPositionB : REAL := 0; (*Cam B off position*)
		i_rAdvanceTime : REAL; (*Advance time*)
		i_usiNumberOfPulse : USINT := 1; (*Number of pulse within the period*)
		i_plrAxisPosition : REFERENCE TO LREAL; (*Pointer to axis position*)
		i_prAxisVelocity : REFERENCE TO REAL; (*Pointer to axis velocity*)
	END_VAR
	VAR_OUTPUT
		q_xAdvError : BOOL; (*Error on advance time*)
	END_VAR
	VAR
		usiStep : USINT;
		xOldCamValueA : BOOL;
		xOldCamValueB : BOOL;
		xCamValueA : BOOL;
		xCamValueB : BOOL;
		rAdvPosition : REAL;
		rTempReal : REAL;
		rOnPositionA : REAL;
		rOffPositionA : REAL;
		rOnPositionB : REAL;
		rOffPositionB : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_CamGeneratorAB (*Double Cam Generator Function Block*)
	VAR_INPUT
		i_xEnable : BOOL; (*Function block enable*)
		i_pxPointerOutputA : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_pxPointerOutputB : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_pxPointerStepAdvA : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_pxPointerStepAdvB : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_rOnPositionA : REAL; (*Cam A on position*)
		i_rOffPositionA : REAL; (*Cam A off position*)
		i_rOnPositionB : REAL := 0; (*Cam B on position*)
		i_rOffPositionB : REAL := 0; (*Cam B off position*)
		i_rAdvanceTime : REAL; (*Advance time*)
		i_plrAxisPosition : REFERENCE TO LREAL; (*Pointer to axis position*)
		i_prAxisVelocity : REFERENCE TO REAL; (*Pointer to axis velocity*)
	END_VAR
	VAR_OUTPUT
		q_xAdvError : BOOL; (*Error on advance time*)
	END_VAR
	VAR
		usiStep : USINT;
		xOldCamValueA : BOOL;
		xOldCamValueB : BOOL;
		xCamValueA : BOOL;
		xCamValueB : BOOL;
		rAdvPosition : REAL;
		rTempReal : REAL;
		rOnPositionA : REAL;
		rOffPositionA : REAL;
		rOnPositionB : REAL;
		rOffPositionB : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_ExceptionAlarmX (*Fb for mananging alarms*)
	VAR_INPUT
		i_xConditions : BOOL;
		i_xAutoAck : BOOL;
		i_pxInitCoreDone : REFERENCE TO BOOL;
		i_pxAcknowledge : REFERENCE TO BOOL;
		i_psAlarmName : REFERENCE TO STRING[20];
		i_pstMpAlarmXLink : REFERENCE TO MpComIdentType;
	END_VAR
	VAR_OUTPUT
		q_xAlarmActive : BOOL; (*The alarm is active*)
	END_VAR
	VAR
		xAlarmActive : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_Periodic2ContinuePosition (*Periodic to continue position*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		i_xEnable : BOOL;
		i_diInPosition : DINT;
		i_udiPeriod : UDINT;
	END_VAR
	VAR_OUTPUT
		q_diPosition : UDINT;
	END_VAR
	VAR
		diOldInPosition : DINT;
		xActive : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_CamGenerator_v2 (*Double Cam Generator Function Block*)
	VAR_INPUT
		i_xEnable : BOOL; (*Function block enable*)
		i_pxPointerOutput : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_pxPointerStepAdv : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_rOnPosition : REAL; (*Cam A on position*)
		i_rOffPosition : REAL; (*Cam A off position*)
		i_rAdvanceTime : REAL; (*Advance time*)
		i_usiNumberOfPulse : USINT := 1; (*Number of pulse within the period*)
		i_pdiAxisPosition : REFERENCE TO DINT; (*Pointer to axis position*)
		i_prAxisVelocity : REFERENCE TO REAL; (*Pointer to axis velocity*)
	END_VAR
	VAR_OUTPUT
		q_xAdvError : BOOL; (*Error on advance time*)
	END_VAR
	VAR
		xOldCamValue : BOOL;
		xCamValue : BOOL;
		rAdvPosition : REAL;
		rTempReal : REAL;
		rOnPosition : REAL;
		rOffPosition : REAL;
		rPosition : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_CamGeneratorAB_v2 (*Double Cam Generator Function Block*)
	VAR_INPUT
		i_xEnable : BOOL; (*Function block enable*)
		i_pxPointerOutputA : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_pxPointerOutputB : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_pxPointerStepAdvA : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_pxPointerStepAdvB : REFERENCE TO BOOL; (*Cam A output pointer*)
		i_rOnPositionA : REAL; (*Cam A on position*)
		i_rOffPositionA : REAL; (*Cam A off position*)
		i_rOnPositionB : REAL := 0; (*Cam B on position*)
		i_rOffPositionB : REAL := 0; (*Cam B off position*)
		i_rAdvanceTime : REAL; (*Advance time*)
		i_pdiAxisPosition : REFERENCE TO DINT; (*Pointer to axis position*)
		i_prAxisVelocity : REFERENCE TO REAL; (*Pointer to axis velocity*)
	END_VAR
	VAR_OUTPUT
		q_xAdvError : BOOL; (*Error on advance time*)
	END_VAR
	VAR
		usiStep : USINT;
		xOldCamValueA : BOOL;
		xOldCamValueB : BOOL;
		xCamValueA : BOOL;
		xCamValueB : BOOL;
		rAdvPosition : REAL;
		rTempReal : REAL;
		rOnPositionA : REAL;
		rOffPositionA : REAL;
		rOnPositionB : REAL;
		rOffPositionB : REAL;
		rPosition : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_DigitalCam
	VAR_INPUT
		i_pstAxis : REFERENCE TO ACP10AXIS_typ;
		i_rOnCam : REAL;
		i_rOffCam : REAL;
		i_rAdvTime : REAL;
		i_usiPulses : USINT;
		i_xRefreshClock : BOOL;
	END_VAR
	VAR_OUTPUT
		q_xOutPulse : BOOL;
	END_VAR
	VAR
		xCamInitialized : BOOL;
		fbCamSwitch : MC_BR_DigitalCamSwitch;
		stMasterSwitch : MC_MASTER_SWITCHES_REF;
		stOutputOption : MC_OUTPUT_OPTIONS_REF;
		stTrackOption : MC_TRACK_OPTIONS_REF;
		uiMngStep : UINT;
		usiTemp : USINT;
		usiMultiPulse : USINT;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
	END_VAR
END_FUNCTION_BLOCK
(*AXIS FUNCTION BLOCK INTERFACE*)

FUNCTION_BLOCK FB_EncEmul (*Encoder Emulation*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		i_xEnable : BOOL;
		i_xErrorReset : BOOL;
		i_uiNumberOfPulses : UINT := 1024;
		i_pstSrcAxis : REFERENCE TO ACP10AXIS_typ;
		i_pstEncEmulAxis : REFERENCE TO ACP10AXIS_typ;
	END_VAR
	VAR_OUTPUT
		q_xActive : BOOL;
		q_xError : BOOL;
		q_uiErrorID : UINT;
	END_VAR
	VAR
		uiStep : UINT;
		fbReadParID : MC_BR_ReadParID;
		fbWriteParID : MC_BR_WriteParID;
		fbAxisError : MC_BR_ReadAxisError;
		uiTemp : UINT;
		udiTemp : UDINT;
		usiErrCode : USINT;
		usiTemp : USINT;
		uiEncodOutParID : UINT;
		fbWriteParID_Text : MC_BR_WriteParIDText;
		strTemp : STRING[33];
		strTemp2 : STRING[33];
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_PeriodicPosition (*From a step signal a periodic signal is created *)
	VAR_INPUT
		i_xEnable : BOOL;
		i_xResetPostion : BOOL;
		i_rAxisPosition : REAL;
		i_rPeriod : REAL;
	END_VAR
	VAR_OUTPUT
		q_xPositionValid : BOOL;
		q_rPeriodicPosition : REAL;
	END_VAR
	VAR
		usiStep : USINT;
		rDeltaPos : REAL;
		rPosition : REAL;
		zzEdge00000 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_GeneralAxis (*General axis*)
	VAR_INPUT
		i_xEnable : BOOL; (*Function block enable*)
		i_xToken : BOOL := TRUE; (*Token input in case of token ring axis management*)
		i_xVelocityControl : BOOL := FALSE; (*Enables the velocity control*)
		i_xInductionMotorType : BOOL := FALSE; (*Motor Type 0= Brushless 1= Induction*)
		i_xThirdPartyMotor : BOOL := FALSE; (*Third party motor, enables the possibility to execute the motor phasing*)
		i_xParityPhasing : BOOL;
		i_pAxisMpLink : UDINT; (*Axis MpLink address*)
		i_pAxisADR : UDINT; (*Axis address*)
		i_pSecondaryAxisMpLink : UDINT := 0; (*Torque controlled axis MpLink address*)
		i_pSecondaryAxisADR : UDINT := 0; (*Torque controlled axis address*)
		i_strParTabName : STRING[8] := ''; (*Parameter table object name*)
		i_pstCmd : REFERENCE TO ST_AxisCmd; (*Pointer to axis command structure*)
		i_pstParameter : REFERENCE TO ST_AxisParameter; (*Pointer to axis parameter structure*)
		i_pstAxisHome : REFERENCE TO ST_AxisHome; (*Pointer to axis homing structure (permanent)*)
		i_pstStatus : REFERENCE TO ST_AxesStatus; (*Pointer to axis status structure*)
	END_VAR
	VAR_OUTPUT
		q_xActive : BOOL; (*The axis function block is active*)
		q_xError : BOOL; (*The axis function block is in error state*)
		q_lrMainAxisTorque : LREAL; (*Actual main axis torque*)
		q_lrSecondaryAxisTorque : LREAL; (*Actual secondary axis torque*)
		q_udiCycleTime : UDINT := 0; (*Axis cycle time (micro sec)*)
		q_strMainStep : STRING[40]; (*Main axis step string*)
		q_strSecondaryStep : STRING[40]; (*Secondary axis step string*)
	END_VAR
	VAR
		fbReadSlowlyCyclicParID : MC_BR_InitCyclicRead;
		fbReadCyclicParID : MC_BR_InitCyclicRead;
		fbReadParID : MC_BR_ReadParID;
		fbMpAxisBasicSecondary : MpAxisBasic;
		fbMpAxisCyclicSet : MpAxisCyclicSet;
		fbMpAxisBasic : MpAxisBasic;
		fbMpAxisBasicConfig : MpAxisBasicConfig;
		fbMpAxisCamSequencer : MpAxisCamSequencer;
		fbWriteParID : MC_BR_WriteParID;
		fbTorqueControl : MC_BR_TorqueControl;
		fbSetOverride : MC_SetOverride;
		fbSetupInductionMotor : MC_BR_SetupInductionMotor;
		fbInitParTabObj : MC_BR_InitParTabObj;
		fbDatObjInfo : DatObjInfo;
		fbDatObjMove : DatObjMove;
		fbDatObjDelete : DatObjDelete;
		fbDatObjCopy : DatObjCopy;
		fbRTInfo : RTInfo;
		fbMotorPhasing : MC_BR_SetupMotorPhasing;
		stBasicParameter : MpAxisBasicParType;
		stBasicParameterOld : MpAxisBasicParType;
		stSecondaryBasicParameter : MpAxisBasicParType;
		stBasicConfiguration : MpAxisBasicConfigType;
		stCyclicSetParameters : MpAxisCyclicSetParType;
		stCamParameters : MpAxisCamSequencerParType;
		stAxis : REFERENCE TO ACP10AXIS_typ;
		stSecondaryAxis : REFERENCE TO ACP10AXIS_typ;
		tonAxisStopped : TON;
		tonInVelocity : TON;
		tonStep : TON;
		tonReadTemperature : TON;
		TimerSynchro : TON;
		tonStepSecondary : TON;
		tonWriteParameter : TON;
		tonReadParameter : TON;
		tonWaitOverride : TON;
		tonPowerOn : TON;
		lrTotalPhaseOffset : LREAL;
		lrLongRealTemp : LREAL;
		lrDiffPosition : LREAL;
		lrOldPosition : LREAL;
		plrHomingPosition : REFERENCE TO LREAL; (*Pointer to homing position (degrees within the step)*)
		plrMasterPosition : REFERENCE TO LREAL; (*Pointer to master position (degrees within the step)*)
		udiDatObjIdentRom : UDINT;
		udiDatObjIdentRam : UDINT;
		udiDatObjPhasingRom : UDINT;
		udiDatObjPhasingRam : UDINT;
		pdiMasterScaledPos : REFERENCE TO DINT; (*Pointe to master absolute position (hundreeds of degrees)*)
		prMasterVelocity : REFERENCE TO REAL; (*Pointer to master speed (degrees per seconds)*)
		rSlaveVelocity : REAL;
		rTempWrite : REAL;
		rTempTorque : REAL;
		rTempLimitAccDec : REAL; (*1.7.2*)
		rTemp : REAL;
		rSetAcceleration : REAL;
		rSetDeceleration : REAL;
		rTime : REAL; (*Elapsed time in milliseconds in acceleration and deceleration*)
		rExtrPositionTime : REAL;
		rAccelerationTime : REAL;
		rAcc : REAL;
		rOldTorqueErrorValue : REAL;
		rOldLagErrorValue : REAL;
		rDeltaV : REAL;
		rSlaveCompDist : REAL;
		rMasterCompDist : REAL;
		rSlaveVelocityRatio : REAL := 1;
		rLagErrorDcBusValue : REAL;
		rM_Max : REAL; (*Maximum motor torque*)
		rM_0 : REAL; (*Stall motor torque*)
		rI_Max : REAL; (*Maximum motor current*)
		rI_0 : REAL; (*Stall motor current*)
		rI_Max_ACP : REAL; (*Maximum ACP current*)
		rM_Max_ACP : REAL; (*Maximum torque available with ACOPOS-Motor combination*)
		rTorqueLimitSecondary : REAL; (*Maximum Torque limit secondary axis*)
		rTorqueLimit : REAL; (*Maximum Torque limit primary axis*)
		rOldTargetSpeed : REAL;
		rAxisPeriod : REAL := 360.0; (*Pointer to master speed (degrees per seconds)*)
		uiOldWriteParId : UINT;
		uiOldReadParId : UINT;
		uiBrakeParID : UINT;
		uiTemp : UINT;
		usiPhaseMonitor : USINT;
		usiDrivesStatusBits : USINT;
		usiDebug : USINT;
		iNumberOfSlaveSteps : UINT;
		xAxisConfigUpdateReq : BOOL;
		xAxisDisabled : BOOL;
		xCmdStopActive : BOOL;
		xSlowMotion : BOOL;
		xRampDown : BOOL;
		xMasterParIdInitDone : BOOL;
		xFirstHomeDone : BOOL;
		xFirstInitDone : BOOL;
		xTimeInitialized : BOOL;
		xJogActive : BOOL;
		xWaitForVelocity : BOOL;
		eMainAxisStep : E_MainAxisStepEnum;
		eMainAxisStepOld : E_MainAxisStepEnum;
		eSecondaryAxisStep : E_SecondaryAxisStepEnum;
		eSecondaryAxisStepOld : E_SecondaryAxisStepEnum;
		eReadTempStep : E_ReadTempStepEnum;
		xJerkControl : BOOL := TRUE;
		diMasterSynchPosition : DINT;
		xWasStopped : BOOL;
		xMasterMovedWhilePhasing : BOOL;
		xAxisPhased : BOOL;
		uiCurveMode : UINT;
	END_VAR
	VAR CONSTANT
		c_uiAxisFactor : UINT := 100; (*Axis factor*)
	END_VAR
	VAR
		strDataObjIdent : STRING[20];
		strDataObjPhasing : STRING[20];
		Vtest : BOOL;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_MasterAxis (*Master axis*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		i_xEnable : BOOL; (*Function block enable*)
		i_xExternalEncoder : BOOL;
		i_xExternalPositionFormat : BOOL; (*V4.A.A.1.7.0*)
		i_pAxisADR : UDINT; (*Axis address*)
		i_pstCmd : REFERENCE TO ST_AxisCmd; (*Pointer to axis command structure*)
		i_pstParameter : REFERENCE TO ST_AxisParameter; (*Pointer to axis parameter structure*)
		i_pstAxisHome : REFERENCE TO ST_AxisHome; (*Pointer to axis homing structure (permanent)*)
		i_pstStatus : REFERENCE TO ST_AxesStatus; (*Pointer to axis status structure*)
		i_pstAbsEncPerm : REFERENCE TO ST_AbsEncPerm; (*Pointer to Absolute encoder permanent struct*)
		i_pstMasterPositionStruct : REFERENCE TO ST_LabellerMotionInterface; (*Pointer to Encoder master position DINT*)
		i_pstExtEncoderPosition : REFERENCE TO DINT;
		i_uiNumberOfSteps : UINT := 1; (*Number of filler steps per master revolution*)
		i_udiExternalSignalPeriod : UDINT := 36000; (*External encoder / master period*)
		i_xCmdEnableCurves : BOOL; (*Curve enable command*)
		i_xCmdHoming : BOOL; (*Master homing command*)
		i_uiFilteringCoefficient : UINT; (*Filtering coefficient*)
		i_uiNumberOfEplCycles : UINT; (*Number of powerlink cycles to advance*)
	END_VAR
	VAR_OUTPUT
		q_diOffsetModuloPos : DINT; (*Offset modulo pos*)
		q_diRefPosError : DINT; (*Reference position error due to filter*)
		q_xPositionValid : BOOL; (*Position valid*)
		q_xCyclicComValid : BOOL; (*Cyclic communication is valid*)
		q_xPositionRestored : BOOL; (*Master position restored succesfully*)
	END_VAR
	VAR
		diMasterScaledPos : DINT;
		lrExternalRefPosition : LREAL;
		rExternalRefVelocity : REAL;
		eDigitalSynchroStep : E_DigitalSynchro;
		diMasterModuloPos : DINT;
		diMasterPosToSpt : DINT;
		diRefExtrEncPos : DINT;
		diRefModuloPos : DINT;
		uiCurveMode : UINT;
		TON_WaitCurveStabilization : TON;
		fbVelocity : FB_Position2Velocity;
		fbPeriodicToContinuePosition : FB_Periodic2ContinuePosition;
		fbCyclicRead_ScaledPos : MC_BR_CyclicRead;
		fbCyclicRead_ModuloPos : MC_BR_CyclicRead;
		fbCyclicRead_RefModuloPos : MC_BR_CyclicRead;
		fbCyclicWrite_ExtrEncPos : MC_BR_CyclicWrite;
		fbCyclicWrite_RefExtrEncPos : MC_BR_CyclicWrite;
		fbWriteParID : MC_BR_WriteParID;
		fbRTInfo : RTInfo; (*V4.A.A.1.6.10*)
		uiMasterPositionSampling : UINT; (*v1.2*)
		diMasterPosition : DINT;
		diOldScaledPos : DINT;
		diOldModuloPos : DINT;
		lrExtrTime : LREAL;
		lrFilterTime : LREAL;
		fbEXTR_RefFilter : EXT_DINT;
		fbPT1_EncFilter : PT1_DINT;
		fbEXTR_EncFilter : EXT_DINT;
		diRefModuloOffset : DINT;
	END_VAR
	VAR CONSTANT
		c_rTf_min : LREAL := 0.0159; (*Time constant for 10 Hz*)
		c_timCompensationIPL : LREAL := 0.0008; (*Interpolator delay*)
	END_VAR
	VAR
		zzEdge00000 : BOOL;
	END_VAR
	VAR CONSTANT
		c_uiAxisFactor : UINT := 100;
	END_VAR
	VAR
		udiCycleTime : UDINT;
		diMasterPeriod : DINT;
		diSlavePeriod : DINT;
		diInitialOffset : DINT;
		uiIPLMode : UINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_AbsolutePosCalculation
	VAR_INPUT
		i_xEnable : BOOL;
		i_pstAxis : ST_GeneralAxis;
		i_xPositionSensor : BOOL;
		i_uiAbsolutePositionOffset : UINT;
		i_uiStepsNumber : UINT;
	END_VAR
	VAR_OUTPUT
		q_xPositionValid : BOOL;
		q_lrAbsolutePosition : LREAL;
	END_VAR
	VAR
		xPositionValid : BOOL;
		lrAbsolutePosition : LREAL;
		lrOldPosition : LREAL;
		lrIncrement : LREAL;
	END_VAR
END_FUNCTION_BLOCK
