ACTION MachineInput:
	(* Reset Command To All Submodules *)
	VAR_Machine.stMasterModule.iq_stCmd.i_xReset	:= MC_InputOutput.Network.Machine.Commands.AlarmReset;
	VAR_Machine.stFillerModule.iq_stCmd.i_xReset	:= MC_InputOutput.Network.Machine.Commands.AlarmReset;
	VAR_Machine.stInletModule.iq_stCmd.i_xReset		:= MC_InputOutput.Network.Machine.Commands.AlarmReset;
	VAR_Machine.stOutletModule.iq_stCmd.i_xReset	:= MC_InputOutput.Network.Machine.Commands.AlarmReset;
	VAR_Machine.iq_stCmd.i_xReset					:= MC_InputOutput.Network.Machine.Commands.AlarmReset;

	(* Mode request from ITC *)
	VAR_Machine.iq_stCmd.i_xOnePitchShift			:= MC_InputOutput.Network.Machine.Commands.OnePitchShiftCommand;
	VAR_Machine.iq_stCmd.i_xAuto					:= MC_InputOutput.Network.Machine.Commands.AutoModalityRequest;
	VAR_Machine.iq_stCmd.i_xCombi					:= MC_InputOutput.Network.Machine.Commands.AutoCombiModalityRequest;
	VAR_Machine.iq_stCmd.i_xCombiSynchroStop		:= MC_InputOutput.Network.Machine.Commands.CombiSynchroStop;
	VAR_Machine.iq_stCmd.i_xOkToDisengage			:= MC_InputOutput.Network.Machine.Commands.OkToDisengage;
	VAR_Machine.iq_stCmd.i_xAxisPhaseShift			:= MC_InputOutput.Network.Machine.Commands.InMotionTimerModReq;
	VAR_Machine.iq_stCmd.i_xJogMode					:= MC_InputOutput.Network.Machine.Commands.JogMachineModalityRequest;
	VAR_Machine.iq_stCmd.i_xMulti					:= MC_InputOutput.Network.Machine.Commands.MultiModalityRequest;
	VAR_Machine.iq_stCmd.i_xPositioning				:= MC_InputOutput.Network.Machine.Commands.PositioningModalityRequest;
	VAR_Machine.iq_stCmd.i_xSelectiveHoming			:= MC_InputOutput.Network.Machine.Commands.SelectiveHomeModalityRequest;
	VAR_Machine.iq_stCmd.i_xBrakeRelease			:= MC_InputOutput.Network.Machine.Commands.BrakeReleaseModalityRequest;
	VAR_Machine.iq_stCmd.i_xVelocity				:= MC_InputOutput.Network.Machine.Commands.VelocityModalityRequest;
	VAR_Machine.iq_stCmd.i_xStepByStep				:= MC_InputOutput.Network.Machine.Commands.StepByStepModalityRequest;
	VAR_Machine.iq_stCmd.i_xStepByStepSingleAxis	:= MC_InputOutput.Network.Machine.Commands.StepByStepSingleAxisModReq;//V4.A.A.1.7.0 Footbar
	VAR_Machine.iq_stCmd.i_xStepByStepSingleAxisReverse	:= MC_InputOutput.Network.Machine.Commands.StepByStepSingleAxisRevModReq;//v999
	VAR_Machine.iq_stCmd.i_xQuickStop				:= MC_InputOutput.Network.Machine.Commands.MachineQuickStop;

	(* Input from ITC *)
	VAR_Machine.iq_stCmd.i_xStart							:= MC_InputOutput.Network.Machine.Commands.MachineStart;
	VAR_Machine.iq_stCmd.i_xJogPushButton					:= MC_InputOutput.Network.Machine.Commands.JogPushButton;
	VAR_Machine.iq_stParameter.i_iAxisPhaseShiftDistance	:= REAL_TO_INT(MC_InputOutput.Network.Machine.Parameters.InMotionTimerValue * 10.0);
	VAR_Machine.iq_stParameter.i_uiAxisSelected				:= MC_InputOutput.Network.Machine.Parameters.AxisSelectedOnHmi;
	VAR_Machine.iq_stParameter.i_uiPositioningOffset		:= REAL_TO_UINT(MC_InputOutput.Network.Machine.Parameters.OffsetPositioning * 10.0);
	VAR_Machine.iq_stParameter.i_uiNumberOfSteps			:= MC_InputOutput.Network.Machine.Parameters.StepNumber;
	VAR_Machine.iq_stParameter.i_uiManualVelocity			:= MC_InputOutput.Network.Machine.Parameters.ManualVelocity;

	VAR_Machine.stInletModule.iq_stCmd.i_xExternalQuickStop		:= MC_InputOutput.Network.Inlet.Commands.QuickStopInletModule	OR NOT VAR_Machine.iq_stCmd.i_xMulti;
	VAR_Machine.stFillerModule.iq_stCmd.i_xExternalQuickStop	:= MC_InputOutput.Network.Filler.Commands.QuickStopFillerModule	OR NOT VAR_Machine.iq_stCmd.i_xMulti;
	VAR_Machine.stOutletModule.iq_stCmd.i_xExternalQuickStop	:= MC_InputOutput.Network.Outlet.Commands.QuickStopOutletModule	OR NOT VAR_Machine.iq_stCmd.i_xMulti;

	VAR_Machine.stMasterModule.iq_stParameters.i_rEndlessVelocity	:= MC_InputOutput.Network.Machine.Parameters.AutoSpeed / 10.0;
	VAR_Machine.stFillerModule.iq_stParameters.i_rEndlessVelocity	:= MC_InputOutput.Network.Filler.Parameters.AutoSpeedFillerModule / 10.0;
	VAR_Machine.stInletModule.iq_stParameters.i_rEndlessVelocity	:= MC_InputOutput.Network.Inlet.Parameters.AutoSpeedInletModule / 10.0;
	VAR_Machine.stOutletModule.iq_stParameters.i_rEndlessVelocity	:= MC_InputOutput.Network.Outlet.Parameters.AutoSpeedOutletModule / 10.0;

	IF VAR_Machine.iq_stStatus.q_xHomed THEN
		VAR_Machine.stMasterModule.iq_stParameters.i_rEndlessVelocity	:= LIMIT(0, VAR_Machine.stMasterModule.iq_stParameters.i_rEndlessVelocity, CFG_MC.Movements.MachineMaxSpeed / 10);
		VAR_Machine.stFillerModule.iq_stParameters.i_rEndlessVelocity	:= LIMIT(0, VAR_Machine.stFillerModule.iq_stParameters.i_rEndlessVelocity, CFG_MC.Movements.MachineMaxSpeed / 10);
		VAR_Machine.stInletModule.iq_stParameters.i_rEndlessVelocity	:= LIMIT(0, VAR_Machine.stInletModule.iq_stParameters.i_rEndlessVelocity, CFG_MC.Movements.MachineMaxSpeed / 10);
		VAR_Machine.stOutletModule.iq_stParameters.i_rEndlessVelocity	:= LIMIT(0, VAR_Machine.stOutletModule.iq_stParameters.i_rEndlessVelocity, CFG_MC.Movements.MachineMaxSpeed / 10);
	ELSE
		VAR_Machine.stMasterModule.iq_stParameters.i_rEndlessVelocity	:= LIMIT(0, VAR_Machine.stMasterModule.iq_stParameters.i_rEndlessVelocity, 0.3 *  CFG_MC.Movements.MachineMaxSpeed / 10);
		VAR_Machine.stFillerModule.iq_stParameters.i_rEndlessVelocity	:= LIMIT(0, VAR_Machine.stFillerModule.iq_stParameters.i_rEndlessVelocity, 0.3 *  CFG_MC.Movements.MachineMaxSpeed / 10);
		VAR_Machine.stInletModule.iq_stParameters.i_rEndlessVelocity	:= LIMIT(0, VAR_Machine.stInletModule.iq_stParameters.i_rEndlessVelocity, 0.3 *  CFG_MC.Movements.MachineMaxSpeed / 10);
		VAR_Machine.stOutletModule.iq_stParameters.i_rEndlessVelocity	:= LIMIT(0, VAR_Machine.stOutletModule.iq_stParameters.i_rEndlessVelocity, 0.3 *  CFG_MC.Movements.MachineMaxSpeed / 10);
	END_IF
	
	VAR_Machine.stMasterModule.iq_stParameters.i_rJogVelocity	:= MC_InputOutput.Network.Machine.Parameters.JogSpeed / 10.0;
	VAR_Machine.stInletModule.iq_stParameters.i_rJogVelocity	:= MC_InputOutput.Network.Machine.Parameters.JogSpeed / 10.0;
	VAR_Machine.stFillerModule.iq_stParameters.i_rJogVelocity	:= MC_InputOutput.Network.Machine.Parameters.JogSpeed / 10.0;
	VAR_Machine.stOutletModule.iq_stParameters.i_rJogVelocity	:= MC_InputOutput.Network.Machine.Parameters.JogSpeed / 10.0;

	VAR_Machine.iq_stParameter.i_uiPositioningOffset			:= REAL_TO_UINT(MC_InputOutput.Network.Machine.Parameters.OffsetPositioning * 10.0);

	VAR_Machine.stMasterModule.iq_stParameters.i_rStopPosition	:= LREAL_TO_REAL(FC_TeensOfmmToDegrees(REAL_TO_INT(MC_InputOutput.Network.Machine.Parameters.StopPosition * 10.0), CFG_MC.Mechanical.MachineStep, FALSE,	FALSE));
	VAR_Machine.stInletModule.iq_stParameters.i_rStopPosition	:= LREAL_TO_REAL(FC_TeensOfmmToDegrees(REAL_TO_INT(MC_InputOutput.Network.Machine.Parameters.StopPosition * 10.0), CFG_MC.Mechanical.MachineStep, FALSE,	FALSE));
	VAR_Machine.stFillerModule.iq_stParameters.i_rStopPosition	:= LREAL_TO_REAL(FC_TeensOfmmToDegrees(REAL_TO_INT(MC_InputOutput.Network.Machine.Parameters.StopPosition * 10.0), CFG_MC.Mechanical.MachineStep, FALSE,	FALSE));
	VAR_Machine.stOutletModule.iq_stParameters.i_rStopPosition	:= LREAL_TO_REAL(FC_TeensOfmmToDegrees(REAL_TO_INT(MC_InputOutput.Network.Machine.Parameters.StopPosition * 10.0), CFG_MC.Mechanical.MachineStep, FALSE,	FALSE));
END_ACTION

ACTION MachineOutput:
	(* Machine status *)
	MC_InputOutput.Network.Machine.Status.HandshakeOut 			:= NOT MC_InputOutput.Network.Machine.Commands.HandShakeIn;
	
	MC_InputOutput.Network.Machine.Status.AxisSelectedForEndless;
	MC_InputOutput.Network.Machine.Status.SpeedForAxisSelectedEndless;
	MC_InputOutput.Network.Machine.Status.EnableEndless;
	
	MC_InputOutput.Network.Machine.Status.MachinePitch					:= LREAL_TO_REAL(CFG_MC.Mechanical.MachineStep);
	MC_InputOutput.Network.Machine.Status.AxisNoOp						:= VAR_Machine.iq_stStatus.q_xAxisNoOp;

	MC_InputOutput.Network.Machine.Status.AutoCmdFeedback				:= VAR_Machine.iq_stStatus.q_xAutoActive 	AND VAR_Machine.stMasterModule.iq_stCmd.i_xStart;
	MC_InputOutput.Network.Machine.Status.JogCmdFeedback				:= VAR_Machine.iq_stStatus.q_xJogActive 	AND VAR_Machine.stMasterModule.iq_stCmd.i_xStart;

	MC_InputOutput.Network.Machine.Status.NoModalityActive				:= VAR_Machine.iq_stStatus.q_xNoModalityactive;
	MC_InputOutput.Network.Machine.Status.AutoCombiModalityActive		:= VAR_Machine.iq_stStatus.q_xCombiActive;
	MC_InputOutput.Network.Machine.Status.AutoModalityActive			:= VAR_Machine.iq_stStatus.q_xAutoActive;
	MC_InputOutput.Network.Machine.Status.BrakeReleaseModalityActive	:= VAR_Machine.iq_stStatus.q_xBrakeReleaseActive;
	MC_InputOutput.Network.Machine.Status.JogModalityActive				:= VAR_Machine.iq_stStatus.q_xJogActive;
	MC_InputOutput.Network.Machine.Status.MultiModalityActive			:= VAR_Machine.iq_stStatus.q_xMultiModalityActive;
	MC_InputOutput.Network.Machine.Status.PositioningModalityActive		:= VAR_Machine.iq_stStatus.q_xPositioningActive;
	MC_InputOutput.Network.Machine.Status.SelectiveHomeModalityActive	:= VAR_Machine.iq_stStatus.q_xSelHomingActive;
	MC_InputOutput.Network.Machine.Status.StepByStepModalityActive		:= VAR_Machine.iq_stStatus.q_xStepByStepActive;
	MC_InputOutput.Network.Machine.Status.StepByStepSingleAxisModeActive:= VAR_Machine.iq_stStatus.q_xStepByStepSingleAxisActive;//V4.A.A.1.7.0
	MC_InputOutput.Network.Machine.Status.StepByStepSingleAxisRevModActive	:= VAR_Machine.iq_stStatus.q_xStepByStepSingAxisRevActive;//V999
	MC_InputOutput.Network.Machine.Status.VelocityModalityActive		:= VAR_Machine.iq_stStatus.q_xVelocityActive;
	MC_InputOutput.Network.Machine.Status.EndlessModalityActive;
	MC_InputOutput.Network.Machine.Status.ThirdPartMotStatSetupModAct;
	MC_InputOutput.Network.Machine.Status.ThirdPartMotDynSetupModAct	:= VAR_Machine.iq_stStatus.q_xThirdPartyDynSetupActive;
	MC_InputOutput.Network.Machine.Status.InductionMotSetupActive		:= VAR_Machine.iq_stStatus.q_xInductionSetupActive;

	MC_InputOutput.Network.Machine.Status.CombiFixedSpeed				:= VAR_Machine.iq_stStatus.q_xCombiFixedSpeed;
	MC_InputOutput.Network.Machine.Status.CombiSynchroInProgress		:= VAR_Machine.iq_stStatus.q_xCombiSynchroInProgress;
	MC_InputOutput.Network.Machine.Status.CombiSynchronized				:= VAR_Machine.iq_stStatus.q_xCombiSynchronized;
	MC_InputOutput.Network.Machine.Status.CombiSynchroStopDone			:= VAR_Machine.iq_stStatus.q_xCombiSynchroStopDone;
	MC_InputOutput.Network.Machine.Status.MachineHomed					:= VAR_Machine.iq_stStatus.q_xHomed;
	MC_InputOutput.Network.Machine.Status.MachineIE						:= VAR_Machine.stFillerModule.iq_stStatus.q_xModulePowered	
																			AND (VAR_Machine.stOutletModule.iq_stStatus.q_xModulePowered	OR NOT VAR_Machine.stOutletModule.iq_stStatus.q_xModulePowered)
																			AND (VAR_Machine.stInletModule.iq_stStatus.q_xModulePowered		OR NOT VAR_Machine.stInletModule.iq_stStatus.q_xModulePowered); 
	MC_InputOutput.Network.Machine.Status.MachineInPosition				:= VAR_Machine.iq_stStatus.q_xInPosition;
	MC_InputOutput.Network.Machine.Status.MachinePowered				:= VAR_Machine.iq_stStatus.q_xPowered;
	MC_InputOutput.Network.Machine.Status.MachineRunning				:=	NOT VAR_Machine.iq_stStatus.q_xMachineStopped;
	MC_InputOutput.Network.Machine.Status.MachineSynchro				:= VAR_Machine.stFillerModule.iq_stStatus.q_xModuleSynchronized 
																			AND (VAR_Machine.stOutletModule.iq_stStatus.q_xModuleSynchronized 	OR NOT VAR_Machine.stOutletModule.iq_stStatus.q_xModuleReal)
																			AND (VAR_Machine.stInletModule.iq_stStatus.q_xModuleSynchronized 	OR NOT VAR_Machine.stInletModule.iq_stStatus.q_xModuleReal);
	
	MC_InputOutput.Network.Machine.Status.InMotionTimerDone		:= VAR_Machine.iq_stStatus.q_xInMotionTimerDone;

	tofShiftDoneOff(IN := MC_InputOutput.Network.Machine.Status.InMotionTimerDone OR VAR_Machine.iq_stCmd.i_xAxisPhaseShift, PT := t#10s);
	
	MC_InputOutput.Network.Machine.Status.ModuleNotInitialized			:= NOT VAR_Machine.stMasterModule.iq_stStatus.q_xInitDone AND NOT VAR_CamInitialized;//1.7.2a

	(* Button Enable *)
	MC_InputOutput.Network.Machine.Status.EnableAxisEnable				:= NOT VAR_Machine.stFillerModule.iq_stStatus.q_xModulePowered	AND
																			NOT VAR_Machine.stInletModule.iq_stStatus.q_xModulePowered	AND
																			NOT VAR_Machine.stOutletModule.iq_stStatus.q_xModulePowered;
	MC_InputOutput.Network.Machine.Status.EnableBrakeRelease 			:= VAR_Machine.stMasterModule.iq_stStatus.q_xModuleStopped		AND
																			VAR_Machine.stFillerModule.iq_stStatus.q_xModuleStopped		AND
																			NOT VAR_Machine.stFillerModule.iq_stStatus.q_xModulePowered	AND
																			(VAR_Machine.stOutletModule.iq_stStatus.q_xModuleStopped	AND
																			NOT VAR_Machine.stOutletModule.iq_stStatus.q_xModulePowered	OR NOT
																			VAR_Machine.stOutletModule.iq_stStatus.q_xModuleReal	)	AND
																			(VAR_Machine.stInletModule.iq_stStatus.q_xModuleStopped		AND
																			NOT VAR_Machine.stInletModule.iq_stStatus.q_xModulePowered	OR NOT
																			VAR_Machine.stInletModule.iq_stStatus.q_xModuleReal	);
	MC_InputOutput.Network.Machine.Status.EnableAuto					:= NOT VAR_Machine.iq_stStatus.q_xReactionActive;
	MC_InputOutput.Network.Machine.Status.EnableCombi					:= MC_InputOutput.Network.Machine.Commands.MasterEncoderPositionValid	AND
																			NOT VAR_Machine.iq_stStatus.q_xReactionActive						AND
																			VAR_Machine.iq_stStatus.q_xHomed;
	MC_InputOutput.Network.Machine.Status.EnableHoming					:= VAR_Machine.iq_stStatus.q_xMachineStopped		AND VAR_Machine.iq_stStatus.q_xNoModalityactive AND
																			NOT VAR_Machine.iq_stStatus.q_xReactionActive;
		
	MC_InputOutput.Network.Machine.Status.EnableInMotionTimer			:= (VAR_Machine.iq_stStatus.q_xAutoActive           OR
																			VAR_Machine.iq_stStatus.q_xCombiActive)			AND
																			NOT xPhasingRunning								AND
																			NOT VAR_Machine.iq_stStatus.q_xMachineStopped	AND
																			NOT VAR_Machine.iq_stStatus.q_xReactionActive	AND
																			NOT xAxisInVelocityControl						AND
																			NOT tofShiftDoneOff.Q;
	MC_InputOutput.Network.Machine.Status.EnableJog						:= VAR_Machine.iq_stStatus.q_xMachineStopped 		AND
																			NOT VAR_Machine.iq_stStatus.q_xReactionActive; 
	MC_InputOutput.Network.Machine.Status.EnableMulti					:= VAR_Machine.iq_stStatus.q_xMachineStopped;
	MC_InputOutput.Network.Machine.Status.EnablePositioning				:= VAR_Machine.iq_stStatus.q_xMachineStopped		AND VAR_Machine.iq_stStatus.q_xNoModalityactive AND
																			NOT VAR_Machine.iq_stStatus.q_xReactionActive;
	MC_InputOutput.Network.Machine.Status.EnableSlowMotion				:= VAR_Machine.iq_stStatus.q_xMachineStopped		AND
																			VAR_Machine.iq_stStatus.q_xHomed;
	MC_InputOutput.Network.Machine.Status.EnableStart					:= (VAR_Machine.iq_stStatus.q_xAutoActive 			OR VAR_Machine.iq_stStatus.q_xMultiModalityActive 	OR VAR_Machine.iq_stStatus.q_xCombiActive) AND
																			NOT VAR_Machine.iq_stStatus.q_xReactionActive;
	MC_InputOutput.Network.Machine.Status.EnableStepByStep				:= VAR_Machine.iq_stStatus.q_xMachineStopped;
	MC_InputOutput.Network.Machine.Status.EnableVelocity				:= VAR_Machine.iq_stStatus.q_xMachineStopped		AND
																			NOT VAR_Machine.iq_stStatus.q_xReactionActive;
	
	MC_InputOutput.Network.Machine.Status.ThirdPartMotStatSetupButton;
	MC_InputOutput.Network.Machine.Status.ThirdPartMotDynSetupButton	:= VAR_Machine.iq_stStatus.q_xMachineStopped		AND
																			NOT VAR_Machine.iq_stStatus.q_xReactionActive;
	MC_InputOutput.Network.Machine.Status.InductionMotSetupButton		:= VAR_Machine.iq_stStatus.q_xMachineStopped		AND
																			NOT VAR_Machine.iq_stStatus.q_xReactionActive;
	
	(* Actual speed management *)
	IF VAR_Machine.iq_stStatus.q_xMultiModalityActive OR VAR_Machine.iq_stStatus.q_xMachineStopped OR
		NOT VAR_Machine.stFillerModule.iq_stStatus.q_xModulePowered
		OR (NOT VAR_Machine.stOutletModule.iq_stStatus.q_xModulePowered	AND VAR_Machine.stOutletModule.iq_stStatus.q_xModuleReal)
		OR (NOT VAR_Machine.stInletModule.iq_stStatus.q_xModulePowered	AND VAR_Machine.stInletModule.iq_stStatus.q_xModuleReal) THEN
		MC_InputOutput.Network.Machine.Status.ActualSpeed	:= 0.0;
	ELSE
		MC_InputOutput.Network.Machine.Status.ActualSpeed	:= 10.0 * MAX(VAR_Machine.stFillerModule.iq_stStatus.q_rVelocity, VAR_Machine.stOutletModule.iq_stStatus.q_rVelocity, VAR_Machine.stInletModule.iq_stStatus.q_rVelocity);
	END_IF
	
	MC_InputOutput.Network.Machine.Status.MachineMaxSpeed	:= CFG_MC.Movements.MachineMaxSpeed;

	(* Exception *)
	MC_InputOutput.Network.Machine.Exceptions.Fault								:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xError;
	MC_InputOutput.Network.Machine.Exceptions.ExcessiveVelocityException		:= FALSE;
	MC_InputOutput.Network.Machine.Exceptions.ExcessiveAccException				:= FALSE;
	MC_InputOutput.Network.Machine.Exceptions.NoAxisEnabledException			:= FALSE;

	MC_InputOutput.Network.Machine.Exceptions.HmiChecksumException				:= VAR_Machine.iq_stStatus.q_xCheckSumError;
	MC_InputOutput.Network.Machine.Exceptions.DcBusLowMachineException			:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MasterPowerSupply01].iq_stStatus.q_stMainAxisStatus.q_xDcBusLowVolatage	OR
																					VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MasterPowerSupply02].iq_stStatus.q_stMainAxisStatus.q_xDcBusLowVolatage;
	MC_InputOutput.Network.Machine.Exceptions.PhaseMonitoringException			:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MasterPowerSupply01].iq_stStatus.q_stMainAxisStatus.q_xPhaseMonitorFault	OR
																					VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MasterPowerSupply02].iq_stStatus.q_stMainAxisStatus.q_xPhaseMonitorFault;
	MC_InputOutput.Network.Machine.Exceptions.PowerSupplyLowMachineException	:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MasterPowerSupply01].iq_stStatus.q_stMainAxisStatus.q_xPowerSupplyVoltageWarning	OR//V1.3
																					VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MasterPowerSupply02].iq_stStatus.q_stMainAxisStatus.q_xPowerSupplyVoltageWarning;//V1.3
	MC_InputOutput.Network.Machine.Exceptions.HomingException					:= (NOT VAR_Machine.stFillerModule.iq_stStatus.q_xModuleHomed	AND VAR_Machine.stFillerModule.iq_stStatus.q_xInitDone)		OR
																					(NOT VAR_Machine.stOutletModule.iq_stStatus.q_xModuleHomed	AND VAR_Machine.stOutletModule.iq_stStatus.q_xModuleReal	AND VAR_Machine.stOutletModule.iq_stStatus.q_xInitDone)	OR
																					(NOT VAR_Machine.stInletModule.iq_stStatus.q_xModuleHomed	AND VAR_Machine.stInletModule.iq_stStatus.q_xModuleReal		AND VAR_Machine.stInletModule.iq_stStatus.q_xInitDone);
	MC_InputOutput.Network.Machine.Exceptions.BleederException					:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MasterPowerSupply01].iq_stStatus.q_stMainAxisStatus.q_xBleederFault	OR
																					VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MasterPowerSupply02].iq_stStatus.q_stMainAxisStatus.q_xBleederFault;
	MC_InputOutput.Network.Machine.Exceptions.InitEncoderException				:= NOT MC_InputOutput.Network.Machine.Commands.MasterEncoderPositionValid;
	MC_InputOutput.Network.Machine.Exceptions.NegativeSpeedBlowerException;
	MC_InputOutput.Network.Machine.Exceptions.CombiException;	
	MC_InputOutput.Network.Machine.Exceptions.StopBlowerException;
END_ACTION