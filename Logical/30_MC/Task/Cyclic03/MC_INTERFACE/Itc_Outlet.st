ACTION OutletInput:
	(* Commands *)
	VAR_Machine.stOutletModule.iq_stCmd.i_xVelocityAxisStop			:= MC_InputOutput.Network.Outlet.Commands.VelocityAxisStop;

	FOR uiAxisIndex := CST_FirstOutletModuleAxis TO CST_LastOutletModuleAxis DO
		VAR_Machine.stOutletModule.iq_astSubModuleAxis[uiAxisIndex].iq_stStatus.q_stMainAxisStatus.iq_xNotErrEncoder	:= MC_InputOutput.Safety.Outlet.Commands.AxesDiag[uiAxisIndex].DI_NotErrENC;
		VAR_Machine.stOutletModule.iq_astSubModuleAxis[uiAxisIndex].iq_stStatus.q_stMainAxisStatus.iq_xOperational		:= MC_InputOutput.Safety.Outlet.Commands.AxesDiag[uiAxisIndex].DI_Operational;
	(* Parameters *)
		IF uiAxisIndex > 15 THEN
			VAR_Machine.stOutletModule.iq_astSubModuleAxis[uiAxisIndex].iq_stParam.i_rVelocityOffsetFactor	:= MC_InputOutput.Network.Outlet.Parameters.ConveyorKs / 100.0;
		ELSE
			VAR_Machine.stOutletModule.iq_astSubModuleAxis[uiAxisIndex].iq_stParam.i_rVelocityOffsetFactor	:= MC_InputOutput.Network.Outlet.Parameters.ConveyorKs / 100.0;
		END_IF
	END_FOR
	
END_ACTION

ACTION OutletOutput:
	(* Outlet status *)
	MC_InputOutput.Network.Outlet.Status.Velocity							:= VAR_Machine.stOutletModule.iq_stStatus.q_rVelocity * 10.0;

	MC_InputOutput.Network.Outlet.Status.ModuleHomed						:= VAR_Machine.stOutletModule.iq_stStatus.q_xModuleHomed;
	MC_InputOutput.Network.Outlet.Status.ModuleInPosition;
	MC_InputOutput.Network.Outlet.Status.ModulePowered						:= VAR_Machine.stOutletModule.iq_stStatus.q_xModulePowered;
	MC_InputOutput.Network.Outlet.Status.ModuleReal							:= VAR_Machine.stOutletModule.iq_stStatus.q_xModuleReal;
	MC_InputOutput.Network.Outlet.Status.ModuleRunning						:= SEL(VAR_Machine.iq_stStatus.q_xMultiModalityActive, VAR_Machine.iq_stStatus.q_xMachineStartFbk, VAR_Machine.stOutletModule.iq_stStatus.q_xModuleStartFbk);
	MC_InputOutput.Network.Outlet.Status.ModuleNotInitialized				:= NOT VAR_Machine.stOutletModule.iq_stStatus.q_xInitDone;	
	
	MC_InputOutput.Network.Outlet.Status.AutoActive							:= VAR_Machine.stOutletModule.iq_stStatus.q_xAutoMultiActive;
	MC_InputOutput.Network.Outlet.Status.ModuleJogActive					:= VAR_Machine.stOutletModule.iq_stStatus.q_xJogMultiActive;
	MC_InputOutput.Network.Outlet.Status.SlowMotionActive					:= VAR_Machine.stOutletModule.iq_stStatus.q_xSlowMotionActive;

	MC_InputOutput.Network.Outlet.Status.AutoCmdFeedback					:= VAR_Machine.stOutletModule.iq_stStatus.q_xAutoMultiActive AND VAR_Machine.stOutletModule.iq_stCmd.i_xStart;
	MC_InputOutput.Network.Outlet.Status.JogCmdFeedback						:= VAR_Machine.stOutletModule.iq_stStatus.q_xJogMultiActive AND VAR_Machine.stOutletModule.iq_stCmd.i_xJogPB;

	MC_InputOutput.Network.Outlet.Status.MainAxisReal						:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Outlet.Status.Out01Real							:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Outlet.Status.Out02Real							:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Outlet.Status.Out03Real							:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Outlet.Status.Out04Real							:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	
	(* Button Enable *)
	MC_InputOutput.Network.Outlet.Status.EnableAutoModality					:= NOT VAR_Machine.stOutletModule.iq_stStatus.q_xReactionActive;
	MC_InputOutput.Network.Outlet.Status.EnableJogModality					:= VAR_Machine.stOutletModule.iq_stStatus.q_xModuleStopped AND
																				NOT VAR_Machine.stOutletModule.iq_stStatus.q_xReactionActive;

	(* Exception *)
	(* Main axis exception *)
	IF VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		MC_InputOutput.Network.Outlet.Exceptions.MainAxisNotInOpException		:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
		MC_InputOutput.Network.Outlet.Exceptions.MainAxisSafetyException		:= NOT MC_InputOutput.Safety.Outlet.Commands.AxesDiag[CST_MainAxis].DI_NotErrFUNC;
		MC_InputOutput.Network.Outlet.Exceptions.MainAxisDriveException			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Outlet.Exceptions.MainAxisTorqueException		:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Outlet.Exceptions.MainAxisTrackException			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Outlet.Exceptions.MainAxisHomeException			:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND 
																				VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xInitDone;																		
	END_IF
	
	(* Outlet axis exception *)
	IF VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Outlet.Out[1].VelocityControl THEN
			MC_InputOutput.Network.Outlet.Exceptions.Outlet01NotInOpException		:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Outlet.Exceptions.Outlet01SafetyException		:= NOT MC_InputOutput.Safety.Outlet.Commands.AxesDiag[CST_Outlet01].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Outlet.Exceptions.Outlet01DriveException				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet01TorqueException			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet01TrackException				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet01HomeException				:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Outlet.Out[2].VelocityControl THEN
			MC_InputOutput.Network.Outlet.Exceptions.Outlet02NotInOpException		:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Outlet.Exceptions.Outlet02SafetyException		:= NOT MC_InputOutput.Safety.Outlet.Commands.AxesDiag[CST_Outlet02].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Outlet.Exceptions.Outlet02DriveException 			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet02TorqueException			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet02TrackException 			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet02HomeException				:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xInitDone;	
	END_IF
	
	IF VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Outlet.Out[3].VelocityControl THEN
			MC_InputOutput.Network.Outlet.Exceptions.Outlet03NotInOpException		:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Outlet.Exceptions.Outlet03SafetyException		:= NOT MC_InputOutput.Safety.Outlet.Commands.AxesDiag[CST_Outlet03].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Outlet.Exceptions.Outlet03DriveException				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet03TorqueException			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet03TrackException				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet03HomeException				:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Outlet.Out[4].VelocityControl THEN
			MC_InputOutput.Network.Outlet.Exceptions.Outlet04NotInOpException		:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Outlet.Exceptions.Outlet04SafetyException		:= NOT MC_InputOutput.Safety.Outlet.Commands.AxesDiag[CST_Outlet04].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Outlet.Exceptions.Outlet04DriveException 			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet04TorqueException			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet04TrackException 			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Outlet.Exceptions.Outlet04HomeException				:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stOutletModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xInitDone;	
	END_IF
END_ACTION