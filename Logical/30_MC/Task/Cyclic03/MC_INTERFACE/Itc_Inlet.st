ACTION InletInput:
	(* Commands *)
 
	VAR_Machine.stInletModule.iq_stCmd.i_xVelocityAxisStop			:= MC_InputOutput.Network.Inlet.Commands.VelocityAxisStop;
	
	FOR uiAxisIndex := CST_FirstInletModuleAxis TO CST_LastInletModuleAxis DO
		VAR_Machine.stInletModule.iq_astSubModuleAxis[uiAxisIndex].iq_stStatus.q_stMainAxisStatus.iq_xNotErrEncoder	:= MC_InputOutput.Safety.Inlet.Commands.AxesDiag[uiAxisIndex].DI_NotErrENC;
		VAR_Machine.stInletModule.iq_astSubModuleAxis[uiAxisIndex].iq_stStatus.q_stMainAxisStatus.iq_xOperational	:= MC_InputOutput.Safety.Inlet.Commands.AxesDiag[uiAxisIndex].DI_Operational;
		(* Parameters *)
		IF uiAxisIndex >= 15 THEN
			VAR_Machine.stInletModule.iq_astSubModuleAxis[uiAxisIndex].iq_stParam.i_rVelocityOffsetFactor	:= MC_InputOutput.Network.Inlet.Parameters.ConveyorKs / 100.0;
		ELSE
			VAR_Machine.stInletModule.iq_astSubModuleAxis[uiAxisIndex].iq_stParam.i_rVelocityOffsetFactor	:= MC_InputOutput.Network.Inlet.Parameters.ConveyorKs / 100.0;
		END_IF
	END_FOR
 
	
	VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stParam.i_rTorqueErrorThreshold	:= MC_InputOutput.Network.Inlet.Parameters.TorqueError.Main;
	FOR uiAxisIndex := 1 TO 4 DO
		VAR_Machine.stInletModule.iq_astSubModuleAxis[(uiAxisIndex - 1) +  CST_FirstInletModuleAxis].iq_stParam.i_rTorqueErrorThreshold	:= MC_InputOutput.Network.Inlet.Parameters.TorqueError.In[uiAxisIndex];
	END_FOR
	
	FOR uiAxisIndex := 1 TO 4 DO
		VAR_Machine.stInletModule.iq_astSubModuleAxis[(uiAxisIndex) + CST_MainAxis].iq_stParam.i_rTorqueErrorThreshold	:= MC_InputOutput.Network.Inlet.Parameters.TorqueError.Out[uiAxisIndex];
	END_FOR
END_ACTION

ACTION InletOutput:
	(* Inlet status *)
	MC_InputOutput.Network.Inlet.Status.Velocity							:= VAR_Machine.stInletModule.iq_stStatus.q_rVelocity * 10.0;
 
	MC_InputOutput.Network.Inlet.Status.ModuleHomed							:= VAR_Machine.stInletModule.iq_stStatus.q_xModuleHomed;
	MC_InputOutput.Network.Inlet.Status.ModuleInPosition;
	MC_InputOutput.Network.Inlet.Status.ModulePowered						:= VAR_Machine.stInletModule.iq_stStatus.q_xModulePowered;
	MC_InputOutput.Network.Inlet.Status.ModuleReal							:= VAR_Machine.stInletModule.iq_stStatus.q_xModuleReal;
	MC_InputOutput.Network.Inlet.Status.ModuleRunning						:= SEL(VAR_Machine.iq_stStatus.q_xMultiModalityActive, VAR_Machine.iq_stStatus.q_xMachineStartFbk, VAR_Machine.stInletModule.iq_stStatus.q_xModuleStartFbk);
	MC_InputOutput.Network.Inlet.Status.ModuleNotInitialized				:= NOT VAR_Machine.stInletModule.iq_stStatus.q_xInitDone;	
	
	MC_InputOutput.Network.Inlet.Status.AutoActive							:= VAR_Machine.stInletModule.iq_stStatus.q_xAutoMultiActive;
	MC_InputOutput.Network.Inlet.Status.ModuleJogActive						:= VAR_Machine.stInletModule.iq_stStatus.q_xJogMultiActive;
	MC_InputOutput.Network.Inlet.Status.SlowMotionActive					:= VAR_Machine.stInletModule.iq_stStatus.q_xSlowMotionActive;

	MC_InputOutput.Network.Inlet.Status.AutoCmdFeedback						:= VAR_Machine.stInletModule.iq_stStatus.q_xAutoMultiActive AND VAR_Machine.stInletModule.iq_stCmd.i_xStart;
	MC_InputOutput.Network.Inlet.Status.JogCmdFeedback						:= VAR_Machine.stInletModule.iq_stStatus.q_xJogMultiActive AND VAR_Machine.stInletModule.iq_stCmd.i_xJogPB;

	MC_InputOutput.Network.Inlet.Status.MainAxisReal						:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Inlet.Status.In01Real							:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Inlet.Status.In02Real							:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Inlet.Status.In03Real							:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Inlet.Status.In04Real							:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	
	(* Button Enable *)
	MC_InputOutput.Network.Inlet.Status.EnableAutoModality					:= NOT VAR_Machine.stInletModule.iq_stStatus.q_xReactionActive;
	MC_InputOutput.Network.Inlet.Status.EnableJogModality					:= VAR_Machine.stInletModule.iq_stStatus.q_xModuleStopped AND
	NOT VAR_Machine.stInletModule.iq_stStatus.q_xReactionActive;

	(* Exception *)
	(* Main axis exception *)
	IF VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		MC_InputOutput.Network.Inlet.Exceptions.MainAxisNotInOpException		:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
		MC_InputOutput.Network.Inlet.Exceptions.MainAxisSafetyException			:= NOT MC_InputOutput.Safety.Inlet.Commands.AxesDiag[CST_MainAxis].DI_NotErrFUNC;
		MC_InputOutput.Network.Inlet.Exceptions.MainAxisDriveException			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Inlet.Exceptions.MainAxisTorqueException			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Inlet.Exceptions.MainAxisTrackException			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Inlet.Exceptions.MainAxisHomeException			:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																					VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	(* Inlet axis exception *)
	IF VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Inlet.In[1].VelocityControl THEN
			MC_InputOutput.Network.Inlet.Exceptions.Inlet01NotInOpException			:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Inlet.Exceptions.Inlet01SafetyException			:= NOT MC_InputOutput.Safety.Inlet.Commands.AxesDiag[CST_Inlet01].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Inlet.Exceptions.Inlet01TorqueException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet01TrackException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet01DriveException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet01HomeException				:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Inlet.In[2].VelocityControl THEN
			MC_InputOutput.Network.Inlet.Exceptions.Inlet02NotInOpException			:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Inlet.Exceptions.Inlet02SafetyException			:= NOT MC_InputOutput.Safety.Inlet.Commands.AxesDiag[CST_Inlet02].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Inlet.Exceptions.Inlet02TorqueException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet02TrackException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet02DriveException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet02HomeException				:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
		
	IF VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Inlet.In[3].VelocityControl THEN
			MC_InputOutput.Network.Inlet.Exceptions.Inlet03NotInOpException			:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Inlet.Exceptions.Inlet03SafetyException			:= NOT MC_InputOutput.Safety.Inlet.Commands.AxesDiag[CST_Inlet03].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Inlet.Exceptions.Inlet03TorqueException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet03TrackException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet03DriveException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet03HomeException				:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Inlet.In[4].VelocityControl THEN
			MC_InputOutput.Network.Inlet.Exceptions.Inlet04NotInOpException			:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Inlet.Exceptions.Inlet04SafetyException			:= NOT MC_InputOutput.Safety.Inlet.Commands.AxesDiag[CST_Inlet04].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Inlet.Exceptions.Inlet04DriveException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet04TorqueException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet04TrackException				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Inlet.Exceptions.Inlet04HomeException 				:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stInletModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
END_ACTION