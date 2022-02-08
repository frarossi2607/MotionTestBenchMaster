(*MACHINE INTERFACE*)

TYPE
	ST_Machine : 	STRUCT 
		iq_stCmd : ST_MachineCmd;
		iq_stStatus : ST_MachineStatus;
		iq_stParameter : ST_MachineParameter;
		stMasterModule : ST_MasterModuleInterface;
		stFillerModule : ST_FillerModuleInterface;
		stInletModule : ST_InletModuleInterface;
		stOutletModule : ST_OutletModuleInterface;
	END_STRUCT;
	ST_MachineCmd : 	STRUCT 
		i_xStart : BOOL;
		i_xCombiSynchroStop : BOOL;
		i_xOkToDisengage : BOOL;
		i_xJogPushButton : BOOL;
		i_xReset : BOOL;
		i_xStepByStepSingleAxisReverse : BOOL; (*v999*)
		i_xStepByStepSingleAxis : BOOL; (*V4.A.A.1.7.0*)
		i_xStepByStep : BOOL;
		i_xAxisPhaseShift : BOOL;
		i_xPositioning : BOOL;
		i_xBrakeRelease : BOOL;
		i_xSelectiveHoming : BOOL;
		i_xThirdPartySetup : BOOL;
		i_xInductionSetup : BOOL;
		i_xMulti : BOOL;
		i_xCombi : BOOL;
		i_xAuto : BOOL;
		i_xJogMode : BOOL;
		i_xOnePitchShift : BOOL;
		i_xVelocity : BOOL;
		i_xQuickStop : BOOL;
	END_STRUCT;
	ST_MachineStatus : 	STRUCT 
		q_xPowered : BOOL;
		q_xEncoderEmulationError : BOOL;
		q_xInPosition : BOOL;
		q_xReactionActive : BOOL;
		q_xHomed : BOOL;
		q_xJogActive : BOOL;
		q_xBrakeReleaseActive : BOOL;
		q_xInMotionTimerDone : BOOL;
		q_xStepByStepSingAxisRevActive : BOOL; (*v999*)
		q_xStepByStepSingleAxisActive : BOOL; (*V4.A.A.1.7.0*)
		q_xStepByStepActive : BOOL;
		q_xAxisNoOp : BOOL;
		q_xCombiActive : BOOL;
		q_xAutoActive : BOOL;
		q_xCombiSynchronized : BOOL;
		q_xCombiSynchroStopDone : BOOL;
		q_xCombiFixedSpeed : BOOL;
		q_xCombiSynchroInProgress : BOOL;
		q_xAutoCmdFeedback : BOOL;
		q_xMultiModalityActive : BOOL;
		q_xMachineStartFbk : BOOL;
		q_xMachineStopped : BOOL;
		q_xOnePitchShiftDone : BOOL;
		q_xNoModalityactive : BOOL;
		q_xVelocityActive : BOOL;
		q_xPositioningActive : BOOL;
		q_xSelHomingActive : BOOL;
		q_xThirdPartyDynSetupActive : BOOL;
		q_xInductionSetupActive : BOOL;
		q_xCheckSumError : BOOL;
	END_STRUCT;
	ST_MachineParameter : 	STRUCT 
		i_uiAxisSelected : UINT;
		i_uiManualVelocity : UINT;
		i_uiNumberOfSteps : UINT;
		i_uiPositioningOffset : UINT;
		i_iAxisPhaseShiftDistance : INT;
	END_STRUCT;
END_TYPE

(*MASTER MODULE INTERFACE*)

TYPE
	ST_MasterModuleInterface : 	STRUCT 
		iq_stCmd : ST_MasterModuleCmds;
		iq_stStatus : ST_MasterModuleStatus;
		iq_stParameters : ST_MasterModuleParameters;
		iq_astSubModuleAxis : ARRAY[0..CST_NumberOfAxesMasterModule]OF ST_GeneralAxis;
	END_STRUCT;
	ST_MasterModuleCmds : 	STRUCT 
		i_xReset : BOOL;
		i_xAlarmInitOk : BOOL := FALSE;
		i_xAutoMode : BOOL;
		i_xCombi : BOOL;
		i_xJogMode : BOOL;
		i_xJogPB : BOOL;
		i_xPositioning : BOOL;
		i_xMachineInitDone : BOOL := FALSE;
		i_xStart : BOOL;
		i_xPhaseShift : BOOL;
		i_xSelectiveHomingMode : BOOL;
		i_xCombiSynchroStop : BOOL;
		i_xOnePitchShift : BOOL;
		i_xMasterRephasingRequest : BOOL;
		i_xPhaseCompensation : BOOL;
		i_xSlowMotionBackward : BOOL;
		i_xSlowMotionForward : BOOL;
		i_xInPhaseStop : BOOL;
		i_xQuickStop : BOOL;
		i_xEnableCurves : BOOL;
		i_xEmergencyStop : BOOL;
		i_xShutdown : BOOL;
	END_STRUCT;
	ST_MasterModuleStatus : 	STRUCT 
		q_xInitDone : BOOL;
		q_xPositioningDone : BOOL;
		q_xMasterRephased : BOOL;
		q_xModuleStopped : BOOL;
		q_xModulePowered : BOOL;
		q_xModuleSynchronized : BOOL;
		q_xRealAxesSynchronized : BOOL;
		q_xRealAxesReadyForACommand : BOOL;
		q_xAlarmXCoreEnabled : BOOL := FALSE;
		q_xModuleReal : BOOL;
		q_xSynchroWithOffset : BOOL;
		q_xNoOpActive : BOOL;
		q_xCombiSynchroStopDone : BOOL;
		q_xOnePitchShifDone : BOOL;
		q_xCombiActive : BOOL;
		q_xAutoActive : BOOL;
		q_xPositioningActive : BOOL;
		q_xSelHomingDone : BOOL;
		q_xSelHomingActive : BOOL;
		q_xPhaseShiftDone : BOOL;
		q_xBrakeReleaseActive : BOOL;
		q_xSlowMotionActive : BOOL;
		q_xJogActive : BOOL;
		q_xJogMultiActive : BOOL;
		q_xAutoMultiActive : BOOL;
		q_xStepByStepActive : BOOL;
	END_STRUCT;
	ST_MasterModuleParameters : 	STRUCT 
		i_lrRephasingPosition : LREAL;
		i_rPositioningOffset : REAL;
		i_rEndlessVelocity : REAL;
		i_rEndlessAcceleration : REAL := 800;
		i_rEndlessDeceleration : REAL := 800;
		i_rJogVelocity : REAL;
		i_rStopPosition : REAL := 180;
		i_rPhaseShiftDistance : REAL;
		i_pstMasterPositionStruct : REFERENCE TO ST_LabellerMotionInterface;
		i_uiAxisSelected : UINT;
	END_STRUCT;
END_TYPE

(*OTHER MODULES INTERFACE*)

TYPE
	ST_FillerModuleInterface : 	STRUCT 
		iq_stCmd : ST_FillerModuleCmds; (*//V4.A.A.1.6.12e*)
		iq_stStatus : ST_FillerModuleStatus; (*//V4.A.A.1.6.12e*)
		iq_stParameters : ST_FillerModuleParameters; (*//V4.A.A.1.6.12e*)
		iq_astSubModuleAxis : ARRAY[0..CST_LastFillerModuleAxis]OF ST_GeneralAxis;
	END_STRUCT;
	ST_InletModuleInterface : 	STRUCT 
		iq_stCmd : ST_InletModuleCmds; (*//V4.A.A.1.6.12e*)
		iq_stStatus : ST_InletModuleStatus; (*//V4.A.A.1.6.12e*)
		iq_stParameters : ST_InletModuleParameters; (*//V4.A.A.1.6.12e*)
		iq_astSubModuleAxis : ARRAY[0..CST_LastInletModuleAxis]OF ST_GeneralAxis;
	END_STRUCT;
	ST_OutletModuleInterface : 	STRUCT 
		iq_stCmd : ST_OutletModuleCmds; (*//V4.A.A.1.6.12e*)
		iq_stStatus : ST_OutletModuleStatus; (*//V4.A.A.1.6.12e*)
		iq_stParameters : ST_OutletModuleParameters; (*//V4.A.A.1.6.12e*)
		iq_astSubModuleAxis : ARRAY[0..CST_LastOutletModuleAxis]OF ST_GeneralAxis;
	END_STRUCT;
	ST_FillerModuleCmds : 	STRUCT  (*V4.A.A.1.6.12e*)
		i_xReset : BOOL;
		i_xAlarmInitOk : BOOL := FALSE;
		i_xAutoMode : BOOL;
		i_xMachineInitDone : BOOL := FALSE;
		i_xFillerAbsolutePositionSensor : BOOL; (*V4.A.A.1.6.12e*)
		i_xRinserFillerAbsolutePosSensor : BOOL; (*V4.A.A.1.6.12e*)
		i_xCapperAbsolutePositionSensor : BOOL; (*V4.A.A.1.6.12e*)
		i_xCrownerAbsolutePositionSensor : BOOL; (*V4.A.A.1.6.12e*)
		i_xDoserAbsolutePositionSensor : BOOL; (*V4.A.A.1.6.12e*)
		i_xDisableRinserAxis : BOOL; (*V4.A.A.1.7.0*)
		i_xVelocityMode : BOOL;
		i_xPositioningMode : BOOL;
		i_xSelectiveHomingMode : BOOL;
		i_xJogMultiMode : BOOL;
		i_xAutoMultiMode : BOOL;
		i_xJogPB : BOOL;
		i_xStart : BOOL;
		i_xPhaseShift : BOOL;
		i_xOnePitchShift : BOOL;
		i_xStepByStep : BOOL;
		i_xStepByStepSingleAxis : BOOL; (*V4.A.A.1.7.0*)
		i_xBrakeRelease : BOOL;
		i_xMasterRephasingRequest : BOOL;
		i_xPhaseCompensation : BOOL;
		i_xSlowMotionBackward : BOOL;
		i_xSlowMotionForward : BOOL;
		i_xThirdPartySetup : BOOL;
		i_xInductionSetup : BOOL;
		i_xInPhaseStop : BOOL;
		i_xQuickStop : BOOL;
		i_xEnable : BOOL;
		i_xExternalQuickStop : BOOL;
		i_xEmergencyStop : BOOL;
		i_xShutdown : BOOL;
		i_xVelocityAxisStop : BOOL;
	END_STRUCT;
	ST_FillerModuleStatus : 	STRUCT  (*V4.A.A.1.6.12e*)
		q_xFillerAbsolutePositionValid : BOOL; (*//V4.A.A.1.6.12e*)
		q_xRinserAbsolutePositionValid : BOOL; (*//V4.A.A.1.6.12e*)
		q_xCapperAbsolutePositionValid : BOOL; (*//V4.A.A.1.6.12e*)
		q_xCrownerAbsolutePositionValid : BOOL; (*//V4.A.A.1.6.12e*)
		q_xDoserAbsolutePositionValid : BOOL; (*//V4.A.A.1.6.12e*)
		q_xInitDone : BOOL;
		q_xReactionActive : BOOL;
		q_xMasterRephased : BOOL;
		q_xModuleStopped : BOOL;
		q_xModuleStartFbk : BOOL;
		q_xModulePowered : BOOL;
		q_xModuleSynchronized : BOOL;
		q_xRealAxesSynchronized : BOOL;
		q_xRealAxesReadyForACommand : BOOL;
		q_xModuleReal : BOOL;
		q_xAlarmXCoreEnabled : BOOL := FALSE;
		q_xSynchroWithOffset : BOOL := FALSE;
		q_xNoOpActive : BOOL;
		q_xAutoActive : BOOL;
		q_xVelocityActive : BOOL;
		q_xPositioningActive : BOOL;
		q_xSelHomingActive : BOOL;
		q_xSelHomingDone : BOOL;
		q_xThirdPartySetupActive : BOOL;
		q_xThirdPartySetupDone : BOOL;
		q_xInductionSetupActive : BOOL;
		q_xInductionSetupDone : BOOL;
		q_xBrakeReleaseActive : BOOL;
		q_xSlowMotionActive : BOOL;
		q_xJogMultiActive : BOOL;
		q_xAutoMultiActive : BOOL;
		q_xStepByStepActive : BOOL;
		q_xPhaseShiftDone : BOOL;
		q_xBrakeReleaseDone : BOOL;
		q_xPositioningDone : BOOL;
		q_xModuleHomed : BOOL;
		q_rVelocity : REAL;
		q_lrFillerAbsolutePosition : LREAL; (*//V4.A.A.1.6.12e*)
		q_lrRinserAbsolutePosition : LREAL; (*//V4.A.A.1.6.12e*)
		q_lrCapperAbsolutePosition : LREAL; (*//V4.A.A.1.6.12e*)
		q_lrCrownerAbsolutePosition : LREAL; (*//V4.A.A.1.6.12e*)
		q_lrDoserAbsolutePosition : LREAL; (*//V4.A.A.1.6.12e*)
	END_STRUCT;
	ST_FillerModuleParameters : 	STRUCT  (*V4.A.A.1.6.12e*)
		i_uiFillerAbsolutePositionOffset : UINT; (*//V4.A.A.1.6.12e*)
		i_uiRinserAbsolutePositionOffset : UINT; (*//V4.A.A.1.6.12e*)
		i_uiCapperAbsolutePositionOffset : UINT; (*//V4.A.A.1.6.12e*)
		i_uiCrownerAbsolutePosOffset : UINT; (*//V4.A.A.1.6.12e*)
		i_uiDoserPositionOffset : UINT; (*//V4.A.A.1.6.12e*)
		i_uiFillerStepsNumber : UINT; (*//V4.A.A.1.6.12e*)
		i_uiRinserStepsNumber : UINT; (*//V4.A.A.1.6.12e*)
		i_uiCapperStepsNumber : UINT; (*//V4.A.A.1.6.12e*)
		i_uiCrownerStepsNumber : UINT; (*//V4.A.A.1.6.12e*)
		i_uiDoserStepsNumber : UINT; (*//V4.A.A.1.6.12e*)
		i_uiAxisSelected : UINT; (*//V4.A.A.1.6.12e*)
		i_uiNumberOfSteps : UINT; (*//V4.A.A.1.6.12e*)
		i_rPhaseShiftDistance : REAL; (*//V4.A.A.1.6.12e*)
		i_rPositioningOffset : REAL; (*//V4.A.A.1.6.12e*)
		i_rManualVelocity : REAL; (*//V4.A.A.1.6.12e*)
		i_rJogVelocity : REAL; (*//V4.A.A.1.6.12e*)
		i_rEndlessVelocity : REAL; (*//V4.A.A.1.6.12e*)
		i_rEndlessAcceleration : REAL := 800; (*//V4.A.A.1.6.12e*)
		i_rEndlessDeceleration : REAL := 800; (*//V4.A.A.1.6.12e*)
		i_rStopPosition : REAL := 180; (*//V4.A.A.1.6.12e*)
		i_lrRephasingPosition : LREAL; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameterMachineCk : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter02 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter03 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter04 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter05 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter06 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter07 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter08 : UDINT := 0; (*//V4.A.A.1.6.12e*)
	END_STRUCT;
	ST_InletModuleCmds : 	STRUCT  (*V4.A.A.1.6.12e*)
		i_xReset : BOOL; (*//V4.A.A.1.6.12e*)
		i_xAlarmInitOk : BOOL := FALSE; (*//V4.A.A.1.6.12e*)
		i_xAutoMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xMachineInitDone : BOOL := FALSE; (*//V4.A.A.1.6.12e*)
		i_xVelocityMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xPositioningMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xSelectiveHomingMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xJogMultiMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xAutoMultiMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xJogPB : BOOL; (*//V4.A.A.1.6.12e*)
		i_xStart : BOOL; (*//V4.A.A.1.6.12e*)
		i_xPhaseShift : BOOL; (*//V4.A.A.1.6.12e*)
		i_xOnePitchShift : BOOL; (*//V4.A.A.1.6.12e*)
		i_xStepByStep : BOOL; (*//V4.A.A.1.6.12e*)
		i_xBrakeRelease : BOOL; (*//V4.A.A.1.6.12e*)
		i_xMasterRephasingRequest : BOOL; (*//V4.A.A.1.6.12e*)
		i_xPhaseCompensation : BOOL; (*//V4.A.A.1.6.12e*)
		i_xSlowMotionBackward : BOOL; (*//V4.A.A.1.6.12e*)
		i_xSlowMotionForward : BOOL; (*//V4.A.A.1.6.12e*)
		i_xThirdPartySetup : BOOL; (*//V4.A.A.1.6.12e*)
		i_xInductionSetup : BOOL; (*//V4.A.A.1.6.12e*)
		i_xInPhaseStop : BOOL; (*//V4.A.A.1.6.12e*)
		i_xQuickStop : BOOL; (*//V4.A.A.1.6.12e*)
		i_xEnable : BOOL; (*//V4.A.A.1.6.12e*)
		i_xExternalQuickStop : BOOL; (*//V4.A.A.1.6.12e*)
		i_xEmergencyStop : BOOL; (*//V4.A.A.1.6.12e*)
		i_xShutdown : BOOL; (*//V4.A.A.1.6.12e*)
		i_xVelocityAxisStop : BOOL; (*//V4.A.A.1.6.12e*)
	END_STRUCT;
	ST_InletModuleStatus : 	STRUCT  (*V4.A.A.1.6.12e*)
		q_xInitDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xReactionActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xMasterRephased : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModuleStopped : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModuleStartFbk : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModulePowered : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModuleSynchronized : BOOL; (*//V4.A.A.1.6.12e*)
		q_xRealAxesSynchronized : BOOL; (*//V4.A.A.1.6.12e*)
		q_xRealAxesReadyForACommand : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModuleReal : BOOL; (*//V4.A.A.1.6.12e*)
		q_xAlarmXCoreEnabled : BOOL := FALSE; (*//V4.A.A.1.6.12e*)
		q_xSynchroWithOffset : BOOL := FALSE; (*//V4.A.A.1.6.12e*)
		q_xNoOpActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xAutoActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xVelocityActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xPositioningActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xSelHomingActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xSelHomingDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xThirdPartySetupActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xThirdPartySetupDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xInductionSetupActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xInductionSetupDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xBrakeReleaseActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xSlowMotionActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xJogMultiActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xAutoMultiActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xStepByStepActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xPhaseShiftDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xBrakeReleaseDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xPositioningDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModuleHomed : BOOL; (*//V4.A.A.1.6.12e*)
		q_rVelocity : REAL; (*//V4.A.A.1.6.12e*)
	END_STRUCT;
	ST_InletModuleParameters : 	STRUCT  (*V4.A.A.1.6.12e*)
		i_uiAxisSelected : UINT; (*//V4.A.A.1.6.12e*)
		i_uiNumberOfSteps : UINT; (*//V4.A.A.1.6.12e*)
		i_rPhaseShiftDistance : REAL; (*//V4.A.A.1.6.12e*)
		i_rPositioningOffset : REAL; (*//V4.A.A.1.6.12e*)
		i_rManualVelocity : REAL; (*//V4.A.A.1.6.12e*)
		i_rJogVelocity : REAL; (*//V4.A.A.1.6.12e*)
		i_rEndlessVelocity : REAL; (*//V4.A.A.1.6.12e*)
		i_rEndlessAcceleration : REAL := 800; (*//V4.A.A.1.6.12e*)
		i_rEndlessDeceleration : REAL := 800; (*//V4.A.A.1.6.12e*)
		i_rStopPosition : REAL := 180; (*//V4.A.A.1.6.12e*)
		i_lrRephasingPosition : LREAL; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameterMachineCk : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter02 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter03 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter04 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter05 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter06 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter07 : UDINT := 0; (*//V4.A.A.1.6.12e*)
		i_udiFbCamParameter08 : UDINT := 0; (*//V4.A.A.1.6.12e*)
	END_STRUCT;
	ST_OutletModuleCmds : 	STRUCT  (*V4.A.A.1.6.12e*)
		i_xReset : BOOL; (*//V4.A.A.1.6.12e*)
		i_xAlarmInitOk : BOOL := FALSE; (*//V4.A.A.1.6.12e*)
		i_xAutoMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xMachineInitDone : BOOL := FALSE; (*//V4.A.A.1.6.12e*)
		i_xVelocityMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xPositioningMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xSelectiveHomingMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xJogMultiMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xAutoMultiMode : BOOL; (*//V4.A.A.1.6.12e*)
		i_xJogPB : BOOL; (*//V4.A.A.1.6.12e*)
		i_xStart : BOOL; (*//V4.A.A.1.6.12e*)
		i_xPhaseShift : BOOL; (*//V4.A.A.1.6.12e*)
		i_xOnePitchShift : BOOL; (*//V4.A.A.1.6.12e*)
		i_xStepByStep : BOOL; (*//V4.A.A.1.6.12e*)
		i_xBrakeRelease : BOOL; (*//V4.A.A.1.6.12e*)
		i_xMasterRephasingRequest : BOOL; (*//V4.A.A.1.6.12e*)
		i_xPhaseCompensation : BOOL; (*//V4.A.A.1.6.12e*)
		i_xSlowMotionBackward : BOOL; (*//V4.A.A.1.6.12e*)
		i_xSlowMotionForward : BOOL; (*//V4.A.A.1.6.12e*)
		i_xThirdPartySetup : BOOL; (*//V4.A.A.1.6.12e*)
		i_xInductionSetup : BOOL; (*//V4.A.A.1.6.12e*)
		i_xInPhaseStop : BOOL; (*//V4.A.A.1.6.12e*)
		i_xQuickStop : BOOL; (*//V4.A.A.1.6.12e*)
		i_xEnable : BOOL; (*//V4.A.A.1.6.12e*)
		i_xExternalQuickStop : BOOL; (*//V4.A.A.1.6.12e*)
		i_xEmergencyStop : BOOL; (*//V4.A.A.1.6.12e*)
		i_xShutdown : BOOL; (*//V4.A.A.1.6.12e*)
		i_xVelocityAxisStop : BOOL; (*//V4.A.A.1.6.12e*)
	END_STRUCT;
END_TYPE

(*//V4.A.A.1.6.12e*)

TYPE
	ST_OutletModuleStatus : 	STRUCT  (*V4.A.A.1.6.12e*)
		q_xInitDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xReactionActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xMasterRephased : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModuleStopped : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModuleStartFbk : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModulePowered : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModuleSynchronized : BOOL; (*//V4.A.A.1.6.12e*)
		q_xRealAxesSynchronized : BOOL; (*//V4.A.A.1.6.12e*)
		q_xRealAxesReadyForACommand : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModuleReal : BOOL; (*//V4.A.A.1.6.12e*)
		q_xAlarmXCoreEnabled : BOOL := FALSE; (*//V4.A.A.1.6.12e*)
		q_xSynchroWithOffset : BOOL := FALSE; (*//V4.A.A.1.6.12e*)
		q_xNoOpActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xAutoActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xVelocityActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xPositioningActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xSelHomingActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xSelHomingDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xThirdPartySetupActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xThirdPartySetupDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xInductionSetupActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xInductionSetupDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xBrakeReleaseActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xSlowMotionActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xJogMultiActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xAutoMultiActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xStepByStepActive : BOOL; (*//V4.A.A.1.6.12e*)
		q_xPhaseShiftDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xBrakeReleaseDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xPositioningDone : BOOL; (*//V4.A.A.1.6.12e*)
		q_xModuleHomed : BOOL; (*//V4.A.A.1.6.12e*)
		q_rVelocity : REAL; (*//V4.A.A.1.6.12e*)
	END_STRUCT;
	ST_OutletModuleParameters : 	STRUCT  (*V4.A.A.1.6.12e*)
		i_uiAxisSelected : UINT;
		i_uiNumberOfSteps : UINT;
		i_rPhaseShiftDistance : REAL;
		i_rPositioningOffset : REAL;
		i_rManualVelocity : REAL;
		i_rJogVelocity : REAL;
		i_rEndlessVelocity : REAL;
		i_rEndlessAcceleration : REAL := 800;
		i_rEndlessDeceleration : REAL := 800;
		i_rStopPosition : REAL := 180;
		i_lrRephasingPosition : LREAL;
		i_udiFbCamParameterMachineCk : UDINT := 0;
		i_udiFbCamParameter02 : UDINT := 0;
		i_udiFbCamParameter03 : UDINT := 0;
		i_udiFbCamParameter04 : UDINT := 0;
		i_udiFbCamParameter05 : UDINT := 0;
		i_udiFbCamParameter06 : UDINT := 0;
		i_udiFbCamParameter07 : UDINT := 0;
		i_udiFbCamParameter08 : UDINT := 0;
	END_STRUCT;
END_TYPE

(*AXIS INTERFACE*)

TYPE
	ST_GeneralAxis : 	STRUCT  (*General axis struct*)
		iq_stParam : ST_AxisParameter; (*Axis parameter struct*)
		iq_stCmd : ST_AxisCmd; (*Axis command struct*)
		iq_stStatus : ST_AxesStatus; (*Axis status struct*)
	END_STRUCT;
	ST_AxisCmd : 	STRUCT  (*Axis command struct*)
		i_xErrorReset : BOOL; (*Error reset*)
		i_xHome : BOOL; (*Homing command*)
		i_xMoveVelocity : BOOL; (*Move velocity*)
		i_xMoveAdditive : BOOL; (*Move additive*)
		i_xSlowMotionFwd : BOOL; (*Slow motion in forward direction*)
		i_xSlowMotionBwd : BOOL; (*Slow motion in backward direction*)
		i_xPhaseCompensation : BOOL; (*Phase compensation command after synchro with offset*)
		i_xJogPositive : BOOL; (*Jog in positive direction*)
		i_xNegCorrection : BOOL; (*In velocity negative shift*)
		i_xPosCorrection : BOOL; (*In velocity positive shift*)
		i_xUpdate : BOOL := FALSE; (*NOT USED*)
		i_xAutoTune : BOOL := FALSE; (*NOT USED*)
		i_xInductionMotorSetup : BOOL := FALSE; (*Induction Motor setup*)
		i_xThirdPartySetup : BOOL := FALSE; (*Third Party Motor setup*)
		i_xSimulate : BOOL := FALSE; (*NOT USED*)
		i_xTroqueLimit : BOOL := FALSE; (*NOT USED*)
		i_xReleaseBrake : BOOL; (*Release the brake manually*)
		i_xGear : BOOL; (*Steady/On fly gear command*)
		i_xPhaseShift : BOOL; (*Phase shift command*)
		i_xCamConnected : BOOL := FALSE;
		i_xOnePitchShift : BOOL; (*One pitch shift command*)
		i_xQuickStop : BOOL := FALSE; (*Quick Stop Command (TRUE: Active)*)
		i_xEmergencyStop : BOOL := FALSE; (*Emergency Stop Command (TRUE: Active)*)
		i_xShutdown : BOOL := FALSE; (*Shutdown Stop Command (TRUE: Active)*)
		i_xMotorPhasing : BOOL; (*Motor phasing command*)
		i_xDisableAxis : BOOL := FALSE; (*Disable axis for debugging*)
	END_STRUCT;
	ST_AxisStatus : 	STRUCT  (*Axis status struct*)
		q_lrPosition : LREAL; (*Actual position*)
		q_lrTorque : LREAL; (*Actual torque*)
		q_lrMasterPosition : LREAL; (*Master actual position*)
		q_rTotalOffset : REAL; (*Total homing offset*)
		q_rDcBus : REAL; (*DC bus voltage (ONLY FOR POWER SUPPLY)*)
		q_rLagError : REAL; (*LagError value (ONLY FOR REAL AXIS)*)
		q_rMotorTemperature : REAL := 30.0; (*Motor actual temperature*)
		q_rEncoderTemperature : REAL := 30.0; (*Encoder actual temperature*)
		q_rMotorPhasingQuality : REAL; (*Motor phasing quality (%)*)
		q_rVelocity : REAL; (*Actual velocity*)
		q_rMotorPhasingOffset : REAL; (*Commutation offset (rad)*)
		q_udiMasterAxisLink : UDINT;
		q_usiMotorPolepairs : USINT; (*Motor polepairs*)
		q_xThirdPartyMotor : BOOL; (*Third party motor*)
		q_xInduction : BOOL; (*Induction motor type*)
		q_xPhasingRunning : BOOL := FALSE; (*Axis doing a phase shift*)
		q_xMotorWithBrake : BOOL; (*The motor has a brake*)
		q_xInitDone : BOOL := FALSE; (*The axis was READY at least once*)
		q_xActive : BOOL; (*Function block active*)
		q_xPowerSupply : BOOL := FALSE; (*The axis is a power supply*)
		q_xAxisReal : BOOL := FALSE; (*The axis is a real axis*)
		q_xError : BOOL; (*The function block is in error state*)
		q_xPowerFault : BOOL; (*Power supply was in power fault*)
		q_xPhaseMonitorFault : BOOL; (*Power supply was in Phase Monitor Fault*)
		q_xDcBusLowVolatage : BOOL; (*Power supply was in DC Bus Low Voltage*)
		q_xPowerSupplyVoltageWarning : BOOL; (*Power supply voltage warning*)
		q_xBleederFault : BOOL; (*Power supply was in bleeder fault*)
		q_xSynchronized : BOOL; (*The axis is sinchronized with the master axis*)
		q_xMasterMovedWhilePhasing : BOOL; (*The master axis was moved during steady gear*)
		q_xReadyForACommand : BOOL; (*The axis is ready for a command*)
		q_xCommandBusy : BOOL; (*Axis Basic or Cam sequencer are in busy state*)
		q_xOnePitchShiftDone : BOOL; (*One pitch shift done feedback*)
		q_xCommandAborted : BOOL; (*Axis basic or cam sequencer were aborted*)
		q_xPoweredOn : BOOL; (*The axis is powered on*)
		q_xIsHomed : BOOL; (*The axis is referenced*)
		q_xInVelocity : BOOL; (*The axis reached the set velocity*)
		q_xInPosition : BOOL; (*The axis reached the set position*)
		q_xMoveActive : BOOL; (*A movement is active*)
		q_xPhaseShiftDone : BOOL; (*Phase shift done*)
		q_xSynchroWithOffset : BOOL; (*Total offset is not zero*)
		q_xStopped : BOOL; (*Axis not moving*)
		q_xVelocityControl : BOOL; (*Axis in velocity control*)
		q_rHomingOffset : REAL; (*Actual homing offset (NOT USED)*)
		q_diStatus : DINT; (*NOT USED*)
		q_xReadTorqueError : BOOL := FALSE; (*NOT USED*)
		q_xUpdateDone : BOOL; (*NOT USED*)
		q_xOperating : BOOL; (*NOT USED*)
		q_xMotorSetupDone : BOOL; (*Third Party Motor or Induction Motor Setup completed*)
		q_xTuningDone : BOOL; (*NOT USED*)
		q_xSimulation : BOOL; (*NOT USED*)
		q_xTorqueLimited : BOOL; (*NOT USED*)
		q_xBrakeReleased : BOOL; (*Brake was released manually*)
		q_xContinuosMotion : BOOL; (*Axis in continuos motion*)
		q_xSynchroMotion : BOOL; (*Axis in synchronized motion*)
		q_xAxisDisabled : BOOL; (*Axis was manually disabled*)
		q_xStandStill : BOOL; (*Axis in standstill*)
		q_xMotorPhasingError : BOOL; (*The phasing offset DataObj of the axis is non present*)
		q_xTorqueError : BOOL; (*The axis torque was over the torque threshold*)
		q_xLagError : BOOL; (*The axis lag error was over the lag error threshold*)
		iq_xNotErrEncoder : BOOL; (*LINKED TO IO MAPPING - NotEncoderError*)
		iq_xOperational : BOOL; (*LINKED IO MAPPING - OPERATIONAL*)
		q_xMotorIdentificationDone : BOOL; (*Phasing procedure done*)
		q_xMotorPhasingDone : BOOL; (*Phasing procedure done*)
		q_ePLCopenStatus : MpAxisPlcOpenStateEnum; (*PLCopen status *)
		q_stInfo : MpAxisBasicInfoType; (*MpAxisBasic Info structure*)
	END_STRUCT;
	ST_AxesStatus : 	STRUCT  (*Double axis status structure*)
		q_stMainAxisStatus : ST_AxisStatus; (*Main axis status*)
		q_stSecondaryAxisStatus : ST_AxisStatus; (*Secondary axis status*)
	END_STRUCT;
	ST_AxisParameter : 	STRUCT  (*Axis parameter struct*)
		i_udiHomingPosition : UDINT; (*Pointer to homing position within the step (to link to previous/next axis position)*)
		i_udiMasterLink : UDINT;
		i_pdiMasterScaledPos : REFERENCE TO DINT; (*Pointer To Master scaled pos (for master ParID only)*)
		i_plrMasterPosition : REFERENCE TO LREAL; (*Pointer To Master Position*)
		i_prMasterVelocity : REFERENCE TO REAL; (*Pointer To Master Velocity*)
		i_uiMasterParId : UINT := 0; (*Master ParID*)
		i_lrAdditiveDistance : LREAL := 20; (*Distance for additive movements*)
		i_rJogDeceleration : REAL := 1200; (*Jog deceleration*)
		i_rEmergencyDeceleration : REAL := 2500; (*Quick Stop/Emergency deceleration*)
		i_rShutdownDeceleration : REAL := 3000; (*Shutdown deceleration*)
		i_rPositioningVelocity : REAL := CST_PositioningVel; (*Axis velocity during positioning*)
		i_rPositioningAccDec : REAL := CST_PositioningAccDec; (*Axis acceleration during positioning*)
		i_rEndlessJerk : REAL := 2000; (*Maximum jerk in move velocity*)
		i_rSlowMotionVelocity : REAL := 50; (*Axis velocity in slow motion mode*)
		i_rSlowMotionAcceleration : REAL := 50; (*Axis acceleration in slow motion*)
		i_rSlowMotionDeceleration : REAL := 50; (*Axis deceleration in slow motion*)
		i_rPhaseShiftDistance : REAL := 0; (*Phase shift distance*)
		i_rJogVelocity : REAL := 200; (*Jog velocity*)
		i_rEndlessDeceleration : REAL := 1200; (*Maximum deceleration in move velocity*)
		i_rEndlessAcceleration : REAL := 800; (*Maximum acceleration in move velocity*)
		i_rEndlessVelocity : REAL := 6000; (*Set velocity*)
		i_rStopPosition : REAL := 180; (*Position for n-phase stop*)
		i_rTorquePreload : REAL; (*Torque difference between Main axis and Secondary axis [Nm]*)
		i_rTorqueRamp : REAL; (*Torque ramp for preload of secondary axis [Nm/s]*)
		i_rTorqueErrorThreshold : REAL := 0; (*Torque error threshold [Nm]*)
		i_rLagErrorThreshold : REAL := 10; (*Lag error threshold [deg]*)
		i_rMaxGearboxTorque : REAL; (*Maximum gearbox torque [Nm]*)
		i_rRunningThreshold : REAL := CST_RunningThreshold; (*Min speed for running*)
		i_rVelocityOffsetFactor : REAL := 1; (*% of master speed*)
		i_rMaxBackwardMovement : REAL := CST_MaxBackwardMovement; (*Max backward movement [deg]*)
		i_xMachineMaster : BOOL := FALSE; (*True for machine master axis*)
		i_stMotorPhasingConfig : MC_SETUP_MOTOR_PHA_PAR_REF; (*Third party motor phasing configuration*)
		i_stInductionMotorConfig : MC_SETUP_IND_MOTOR_PAR_REF; (*Third party induction motor configuration*)
	END_STRUCT;
	ST_AxisHome : 	STRUCT  (*Axis homing structure (permanent)*)
		xHomeValid : BOOL; (*Homing is valid*)
		rPhaseOffsetValue : REAL; (*Total offset value*)
		stEndlessPositions : MC_ENDLESS_POSITION; (*MC Endless position struct retain*)
	END_STRUCT;
	ST_AbsEncPerm : 	STRUCT  (*Absolute encoder permanent struct*)
		diAbsEncOffset : DINT; (*Absolue encoder offset*)
		xCalibrationDone : BOOL; (*Encoder calibration done*)
	END_STRUCT;
	E_MainAxisStepEnum : 
		( (*Main axis step enumerator*)
		DISABLE := 0, (*Axis disabled*)
		INIT := 5,
		INIT_1 := 10,
		INIT_2 := 11,
		INIT_3 := 12,
		INIT_4 := 13,
		INIT_5 := 14,
		INIT_6 := 15,
		INIT_7 := 16,
		INIT_8 := 17,
		INIT_IND_1 := 20,
		INIT_IND_2 := 21,
		INIT_IND_3 := 22,
		INIT_IND_4 := 23,
		INIT_IND_5 := 24,
		INIT_IND_6 := 25,
		INIT_IND_7 := 26,
		INIT_IND_8 := 27,
		INIT_IND_9 := 28,
		INIT_IND_10 := 29,
		INIT_IND_11 := 30,
		INIT_IND_12 := 31,
		INIT_IND_13 := 32,
		INIT_IND_14 := 33,
		INIT_IND_15 := 34,
		INIT_IND_16 := 35,
		INIT_IND_17 := 36,
		INIT_IND_18 := 37,
		INIT_IND_19 := 38,
		INIT_IND_20 := 39,
		INIT_THIRD_1 := 40,
		INIT_THIRD_2 := 41,
		INIT_THIRD_3 := 42,
		INIT_THIRD_4 := 43,
		INIT_THIRD_5 := 44,
		INIT_THIRD_6 := 45,
		INIT_THIRD_7 := 46,
		INIT_THIRD_8 := 47,
		INIT_THIRD_9 := 48,
		INIT_THIRD_10 := 49,
		INIT_THIRD_11 := 50,
		INIT_THIRD_12 := 51,
		INIT_THIRD_13 := 52,
		INIT_THIRD_14 := 53,
		WRITE_I_MAX_ACTION := 60,
		READ_BRAKE_PARID := 70,
		READ_ACP_PARID := 100,
		READ_ACP_PARID_1 := 110,
		READ_ACP_PARID_2 := 120,
		READ_ACP_PARID_3 := 130,
		READ_ACP_PARID_4 := 140,
		MAX_TORQUE_CALCULATION := 150,
		SET_TORQUE_LIMIT := 160,
		SET_TORQUE_LIMIT_1 := 170,
		SET_TORQUE_LIMIT_2 := 175,
		SET_TORQUE_LIMIT_3 := 180, (*1.7.2*)
		SET_TORQUE_LIMIT_4 := 181, (*1.7.2*)
		OPEN_POSITION_LOOP := 190,
		BRAKE_RELEASE := 195,
		BRAKE_RELEASE_1 := 196,
		WAIT_FOR_POWER := 200,
		POWERING := 300,
		HOME_RECOVERY := 350,
		SYSTEM_HOMING := 400,
		WAIT_SECONDARY_AXIS_READY := 500,
		AXIS_READY := 1000, (*//v4.A.A.1.6.12f*)
		ENDLESS_RUN1 := 1100,
		ENDLESS_RUN2 := 1110,
		ENDLESS_GEAR_STOP := 1150,
		SLOW_MOTION := 1200,
		JOG_POSITIVE := 1500,
		MOVE_ADDITIVE := 1600,
		GEAR_VELOCITY := 1900,
		GEAR_VELOCITY_1 := 1910,
		GEAR_VELOCITY_2 := 1920,
		GEAR_VELOCITY_3 := 1930,
		GEAR_VELOCITY_4 := 1940,
		GEAR_VELOCITY_5 := 1950,
		GEAR := 2000, (*Gear step*)
		GEAR_1 := 2010, (*Move the axis to the master position*)
		GEAR_2 := 2020, (*On fly gear*)
		GEAR_3 := 2030, (*Master - slave position difference compensation*)
		GEAR_4 := 2040, (* 1:1 gear*)
		ONE_PITCH_SHIFT := 3000,
		VELOCITY_SHIFT := 3100,
		VELOCITY_SHIFT_1 := 3110,
		PHASE_SHIFT := 3500,
		PHASE_SHIFT_1 := 3510,
		HOMING_1 := 4000,
		HOMING_2 := 4010,
		HOMING_3 := 4020,
		HOMING_4 := 4030,
		WAIT_HOMING_DONE := 4100,
		PHASE_COMPENSATION := 4500,
		PHASE_COMPENSATION_1 := 4600,
		STOP := 5000,
		QUICK_STOP := 5050,
		SLOW_DOWN := 5100,
		STOP_IN_PHASE := 5150,
		WAIT_FOR_STOPPED := 5300,
		NO_MOVE_POWER_OFF := 6000,
		STOPPED := 6500,
		INDUCTION_MOTOR_SETUP := 7000,
		INDUCTION_MOTOR_SETUP_1 := 7010,
		INDUCTION_MOTOR_SETUP_2 := 7020,
		INDUCTION_MOTOR_SETUP_3 := 7030,
		INDUCTION_MOTOR_SETUP_4 := 7040,
		INDUCTION_MOTOR_SETUP_5 := 7050,
		INDUCTION_MOTOR_SETUP_6 := 7060,
		INDUCTION_MOTOR_SETUP_7 := 7070,
		INDUCTION_MOTOR_SETUP_8 := 7080,
		INDUCTION_MOTOR_SETUP_9 := 7090,
		INDUCTION_MOTOR_SETUP_10 := 7100,
		INDUCTION_MOTOR_SETUP_11 := 7110,
		MOTOR_PHASING := 8000,
		MOTOR_PHASING_1 := 8010,
		MOTOR_PHASING_2 := 8020,
		MOTOR_PHASING_3 := 8030,
		MOTOR_PHASING_4 := 8040,
		MOTOR_PHASING_5 := 8050,
		MOTOR_PHASING_6 := 8060,
		MOTOR_PHASING_7 := 8070,
		MOTOR_PHASING_8 := 8080,
		MOTOR_PHASING_9 := 8090,
		MOTOR_PHASING_10 := 8100,
		MOTOR_PHASING_11 := 8110,
		AXIS_ERROR := 9000,
		WAIT_FOR_CONNECTION := 9500
		);
	E_SecondaryAxisStepEnum : 
		( (*Secondary axis step enumerator*)
		S_DISABLE := 0, (*Secondary axis disabled*)
		S_WAIT_SAFETY_READY := 5,
		S_INIT := 10,
		S_INIT_1 := 11,
		S_INIT_2 := 12,
		S_INIT_3 := 13,
		S_INIT_4 := 14,
		S_INIT_5 := 15,
		S_INIT_6 := 16,
		S_INIT_TORQUE_CTRL := 30,
		S_INIT_MP_AXIS_BASIC := 40,
		S_SET_TORQUE_LIMIT := 160,
		S_SET_TORQUE_LIMIT_1 := 170,
		S_SET_TORQUE_LIMIT_2 := 175,
		S_SET_TORQUE_LIMIT_4 := 180,
		S_SET_TORQUE_LIMIT_3 := 185,
		S_WAIT_FOR_POWER := 80,
		S_POWERING := 85,
		S_RAMPING_UP := 90,
		S_POSITIVE_PRELOAD := 95,
		S_POSITIVE_PRELOAD_1 := 98,
		S_POSITIVE_PRELOAD_2 := 99,
		S_READY := 100,
		S_CMD_STOP_HANDLING := 200,
		S_NEGATIVE_PRELOAD := 210,
		S_WAIT_FOR_TORQUE_RAMP := 220,
		S_WAIT_FOR_TORQUE_RAMP_1 := 225,
		S_RAMPING_DOWN := 300,
		S_RAMPING_DOWN_1 := 310,
		S_WAIT_FOR_STOPPING := 320,
		S_POWER_OFF := 330,
		S_MAIN_AXIS_ERROR := 8500,
		S_AXIS_ERROR := 9000,
		S_CONNECTION_LOST := 9500
		);
	E_ReadTempStepEnum : 
		( (*Read encoder/motor temp step enum*)
		MOTOR := 0,
		ENCODER := 10,
		MOTOR_2 := 20,
		ENCODER_2 := 30
		);
	E_MasterStatus : 
		(
		UNKNOWN := 0,
		LOCAL_MASTER := 1,
		GLOBAL_MASTER := 2
		);
	E_DigitalSynchro : 
		( (*Digital sinchronization step enum*)
		SYNCHRO_INIT := 0,
		CURVES_DISABLE := 5,
		CURVES_DISABLE_1 := 10,
		CURVES_DISABLE_2 := 20,
		CURVES_DISABLE_3 := 30,
		ZERO_OFFSET := 35,
		WRITE_MA_PERIOD := 40,
		WRITE_MA_PERIOD_1 := 50,
		WRITE_SL_PERIOD := 60,
		WRITE_SL_PERIOD_1 := 70,
		INIT_FILTERS := 100,
		DISABLE_IPL := 110,
		INIT_CYCLIC_READ_WRITE := 120,
		WRITE_IPL_CYCLIE_TIME := 130,
		ENABLE_IPL := 140,
		CURVES_ENABLE := 200,
		CURVES_ENABLE_1 := 210,
		CURVES_ENABLE_2 := 220,
		CURVES_ENABLE_3 := 230,
		RESTORE_CALIBRATION_OFFSET := 300,
		WAIT_CURVES_STABILIZATION := 350,
		ABS_ENC_READY := 500,
		OFFSET_RESET := 510,
		CALIBRATION := 520,
		WRITE_NEW_CALIBRATION_VALUE := 530,
		ERROR := 900,
		ERROR_1 := 910
		);
END_TYPE

(*Exchange Struct*)

TYPE
	ST_LabellerMotionInterface : 	STRUCT 
		INT0 : UINT;
		INT1 : UINT;
		VLab_UDIntPosition : UDINT; (*0..36000 // Position of Virtual Labeler*)
		DINT02 : UDINT;
		DINT03 : UDINT;
		VLab_LRealPosition : LREAL; (*0..36000 //Position of Virtual Labeler*)
		DINT06 : UDINT;
		DINT07 : UDINT;
		DINT08 : UDINT;
		DINT09 : UDINT;
		DINT10 : UDINT;
		DINT11 : UDINT;
		DINT12 : UDINT;
		DINT13 : UDINT;
		DINT14 : UDINT;
	END_STRUCT;
END_TYPE
