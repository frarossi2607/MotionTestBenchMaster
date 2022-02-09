ACTION FillerInput:
	(* Commands *)
	VAR_Machine.stFillerModule.iq_stCmd.i_xFillerAbsolutePositionSensor		:= MC_InputOutput.Network.Filler.Commands.FillerAbsolutePositionSensor; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stCmd.i_xRinserFillerAbsolutePosSensor	:= MC_InputOutput.Network.Filler.Commands.RinserAbsolutePositionSensor; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stCmd.i_xCapperAbsolutePositionSensor		:= MC_InputOutput.Network.Filler.Commands.CapperAbsolutePositionSensor; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stCmd.i_xCrownerAbsolutePositionSensor	:= MC_InputOutput.Network.Filler.Commands.CrownerAbsolutePositionSensor; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stCmd.i_xDoserAbsolutePositionSensor		:= MC_InputOutput.Network.Filler.Commands.DoserAbsolutePositionSensor; (*//V4.A.A.1.6.12e*)
	
	VAR_Machine.stFillerModule.iq_stCmd.i_xVelocityAxisStop				:= MC_InputOutput.Network.Filler.Commands.VelocityAxisStop;

	FOR uiAxisIndex := CST_FirstFillerModuleAxis TO CST_LastFillerModuleAxis DO
		VAR_Machine.stFillerModule.iq_astSubModuleAxis[uiAxisIndex].iq_stStatus.q_stMainAxisStatus.iq_xNotErrEncoder	:= MC_InputOutput.Safety.Filler.Commands.AxesDiag[uiAxisIndex].DI_NotErrENC;
		VAR_Machine.stFillerModule.iq_astSubModuleAxis[uiAxisIndex].iq_stStatus.q_stMainAxisStatus.iq_xOperational		:= MC_InputOutput.Safety.Filler.Commands.AxesDiag[uiAxisIndex].DI_Operational;
		(* Parameters *)
		IF uiAxisIndex >= 15 THEN
			VAR_Machine.stFillerModule.iq_astSubModuleAxis[uiAxisIndex].iq_stParam.i_rVelocityOffsetFactor		:= MC_InputOutput.Network.Filler.Parameters.OutletConveyorKs / 100.0;
		ELSE
			VAR_Machine.stFillerModule.iq_astSubModuleAxis[uiAxisIndex].iq_stParam.i_rVelocityOffsetFactor		:= MC_InputOutput.Network.Filler.Parameters.InletConveyorKs / 100.0;
		END_IF
	END_FOR
	
	VAR_Machine.stFillerModule.iq_stParameters.i_uiFillerAbsolutePositionOffset	:= MC_InputOutput.Network.Filler.Parameters.FillerAbsolutePositionOffset; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stParameters.i_uiFillerStepsNumber			:= MC_InputOutput.Network.Filler.Parameters.FillerStepsNumber; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stParameters.i_uiRinserAbsolutePositionOffset	:= MC_InputOutput.Network.Filler.Parameters.RinserAbsolutePositionOffset; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stParameters.i_uiRinserStepsNumber			:= MC_InputOutput.Network.Filler.Parameters.RinserStepsNumber; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stParameters.i_uiCapperAbsolutePositionOffset	:= MC_InputOutput.Network.Filler.Parameters.CapperAbsolutePositionOffset; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stParameters.i_uiCapperStepsNumber			:= MC_InputOutput.Network.Filler.Parameters.CapperStepsNumber; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stParameters.i_uiCrownerAbsolutePosOffset		:= MC_InputOutput.Network.Filler.Parameters.CrownerAbsolutePositionOffset; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stParameters.i_uiCrownerStepsNumber			:= MC_InputOutput.Network.Filler.Parameters.CrownerStepsNumber; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stParameters.i_uiDoserPositionOffset			:= MC_InputOutput.Network.Filler.Parameters.DoserAbsolutePositionOffset; (*//V4.A.A.1.6.12e*)
	VAR_Machine.stFillerModule.iq_stParameters.i_uiDoserStepsNumber				:= MC_InputOutput.Network.Filler.Parameters.DoserStepsNumber; //V4.A.A.1.6.12e
	
	
	
//		Disable axis Rinser command
//	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CFG_MC.Mechanical.ReferenceId.Rinser].iq_stCmd.i_xDisableAxis	:= MC_InputOutput.Network.Filler.Commands.DisableRinserAxis;//V4.A.A.1.7.0
//	(*Disable axis Doser command*)
//	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CFG_MC.Mechanical.ReferenceId.Doser].iq_stCmd.i_xDisableAxis		:= MC_InputOutput.Network.Filler.Commands.DisableDoserAxis;//v999 test
//	(*Disable axis Filler command*)
//	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CFG_MC.Mechanical.ReferenceId.Filler].iq_stCmd.i_xDisableAxis		:= MC_InputOutput.Network.Filler.Commands.DisableFillerAxis;//v999 test

	
	
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Inlet10] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Inlet09] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Inlet08] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Inlet07] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Inlet06] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Inlet05] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Inlet04] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Inlet03] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Inlet02] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Inlet01] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_MainAxis] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Outlet01] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Outlet02] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Outlet03] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Outlet04] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Outlet05] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stCmd.i_xDisableAxis := MC_InputOutput.Network.Filler.Commands.MotorDisableIndex[CST_Outlet06] AND VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	
	
	VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stParam.i_rTorqueErrorThreshold	:= MC_InputOutput.Network.Filler.Parameters.TorqueError.Main;
	FOR uiAxisIndex := 1 TO 10 DO
		VAR_Machine.stFillerModule.iq_astSubModuleAxis[(uiAxisIndex - 1) +  CST_FirstFillerModuleAxis].iq_stParam.i_rTorqueErrorThreshold	:= MC_InputOutput.Network.Filler.Parameters.TorqueError.In[uiAxisIndex];
	END_FOR
	
	FOR uiAxisIndex := 1 TO 6 DO
		VAR_Machine.stFillerModule.iq_astSubModuleAxis[(uiAxisIndex) + CST_MainAxis].iq_stParam.i_rTorqueErrorThreshold	:= MC_InputOutput.Network.Filler.Parameters.TorqueError.Out[uiAxisIndex];
	END_FOR
END_ACTION

ACTION FillerOutput:
	(* Filler status *)
	MC_InputOutput.Network.Filler.Status.Velocity						:= VAR_Machine.stFillerModule.iq_stStatus.q_rVelocity * 10.0;
	MC_InputOutput.Network.Filler.Status.FillerAbsolutePosition			:= VAR_Machine.stFillerModule.iq_stStatus.q_lrFillerAbsolutePosition; (*//V4.A.A.1.6.12e*)
	MC_InputOutput.Network.Filler.Status.RinserAbsolutePosition			:= VAR_Machine.stFillerModule.iq_stStatus.q_lrRinserAbsolutePosition; (*//V4.A.A.1.6.12e*)
	MC_InputOutput.Network.Filler.Status.CapperAbsolutePosition			:= VAR_Machine.stFillerModule.iq_stStatus.q_lrCapperAbsolutePosition; (*//V4.A.A.1.6.12e*)
	MC_InputOutput.Network.Filler.Status.CrownerAbsolutePosition		:= VAR_Machine.stFillerModule.iq_stStatus.q_lrCrownerAbsolutePosition; (*//V4.A.A.1.6.12e*)
	MC_InputOutput.Network.Filler.Status.DoserAbsolutePosition			:= VAR_Machine.stFillerModule.iq_stStatus.q_lrDoserAbsolutePosition; (*//V4.A.A.1.6.12e*)

	MC_InputOutput.Network.Filler.Status.ModuleHomed					:= VAR_Machine.stFillerModule.iq_stStatus.q_xModuleHomed;
	MC_InputOutput.Network.Filler.Status.ModuleInPosition;
	MC_InputOutput.Network.Filler.Status.ModulePowered					:= VAR_Machine.stFillerModule.iq_stStatus.q_xModulePowered;
	MC_InputOutput.Network.Filler.Status.ModuleReal						:= VAR_Machine.stFillerModule.iq_stStatus.q_xModuleReal;
	MC_InputOutput.Network.Filler.Status.ModuleRunning					:= SEL(VAR_Machine.iq_stStatus.q_xMultiModalityActive, VAR_Machine.iq_stStatus.q_xMachineStartFbk, VAR_Machine.stFillerModule.iq_stStatus.q_xModuleStartFbk);
	MC_InputOutput.Network.Filler.Status.ModuleNotInitialized			:= NOT VAR_Machine.stFillerModule.iq_stStatus.q_xInitDone;
	
	MC_InputOutput.Network.Filler.Status.AutoActive						:= VAR_Machine.stFillerModule.iq_stStatus.q_xAutoMultiActive;
	MC_InputOutput.Network.Filler.Status.ModuleJogActive				:= VAR_Machine.stFillerModule.iq_stStatus.q_xJogMultiActive;
	MC_InputOutput.Network.Filler.Status.SlowMotionActive				:= VAR_Machine.stFillerModule.iq_stStatus.q_xSlowMotionActive;

	MC_InputOutput.Network.Filler.Status.AutoCmdFeedback				:= VAR_Machine.stFillerModule.iq_stStatus.q_xAutoMultiActive AND VAR_Machine.stFillerModule.iq_stCmd.i_xStart;
	MC_InputOutput.Network.Filler.Status.JogCmdFeedback					:= VAR_Machine.stFillerModule.iq_stStatus.q_xJogMultiActive AND VAR_Machine.stFillerModule.iq_stCmd.i_xJogPB;

	MC_InputOutput.Network.Filler.Status.CarouselReal				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.In01Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.In02Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.In03Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.In04Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.In05Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.In06Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.In07Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.In08Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.In09Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.In10Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.Out01Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.Out02Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.Out03Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.Out04Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.Out05Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
	MC_InputOutput.Network.Filler.Status.Out06Real					:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;

	MC_InputOutput.Network.Filler.Status.FillerAbsolutePositionValid			:= VAR_Machine.stFillerModule.iq_stStatus.q_xFillerAbsolutePositionValid; (*//V4.A.A.1.6.12e*)
	MC_InputOutput.Network.Filler.Status.RinserAbsolutePositionValid			:= VAR_Machine.stFillerModule.iq_stStatus.q_xRinserAbsolutePositionValid; (*//V4.A.A.1.6.12e*)
	MC_InputOutput.Network.Filler.Status.CapperAbsolutePositionValid			:= VAR_Machine.stFillerModule.iq_stStatus.q_xCapperAbsolutePositionValid; (*//V4.A.A.1.6.12e*)
	MC_InputOutput.Network.Filler.Status.CrownerAbsolutePositionValid			:= VAR_Machine.stFillerModule.iq_stStatus.q_xCrownerAbsolutePositionValid; (*//V4.A.A.1.6.12e*)
	MC_InputOutput.Network.Filler.Status.DoserAbsolutePositionValid				:= VAR_Machine.stFillerModule.iq_stStatus.q_xDoserAbsolutePositionValid; (*//V4.A.A.1.6.12e*)

	(* Disable Motor Filler Module Status ----------------------------*)
	
		(* Disabel Axis FeedBack *) //V4.A.A.1.7.0 Motion
//	MC_InputOutput.Network.Filler.Status.DoserAxisDisabled						:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CFG_MC.Mechanical.ReferenceId.Doser].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
//	MC_InputOutput.Network.Filler.Status.RinserAxisDisabled						:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CFG_MC.Mechanical.ReferenceId.Rinser].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;

	
	
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Inlet10]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Inlet09]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Inlet08]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Inlet07]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Inlet06]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Inlet05]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Inlet04]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Inlet03]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Inlet02]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Inlet01]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_MainAxis]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Outlet01]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Outlet02]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Outlet03]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Outlet04]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Outlet05]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack[CST_Outlet06]		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stStatus.q_stMainAxisStatus.q_xAxisDisabled;
	
	
	(* Button Enable *)
	MC_InputOutput.Network.Filler.Status.EnableAutoModality				:= NOT VAR_Machine.stFillerModule.iq_stStatus.q_xReactionActive;
	MC_InputOutput.Network.Filler.Status.EnableJogModality				:= VAR_Machine.stFillerModule.iq_stStatus.q_xModuleStopped AND
																			NOT VAR_Machine.stFillerModule.iq_stStatus.q_xReactionActive;

	(* Exception *)
	(* Main axis exception *)
	MC_InputOutput.Network.Filler.Exceptions.CarouselNotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
	MC_InputOutput.Network.Filler.Exceptions.CarouselSafetyException			:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_MainAxis].DI_NotErrFUNC;
	MC_InputOutput.Network.Filler.Exceptions.CarouselTorqueException			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
	MC_InputOutput.Network.Filler.Exceptions.CarouselTrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xLagError;
	MC_InputOutput.Network.Filler.Exceptions.CarouselDriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xError;
	MC_InputOutput.Network.Filler.Exceptions.CarouselHomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																					VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_MainAxis].iq_stStatus.q_stMainAxisStatus.q_xInitDone;

	(* Inlet axis exception *)
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.In[1].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Inlet01NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Inlet01SafetyException				:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Inlet01].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Inlet01TorqueException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet01TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet01DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet01HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet01].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.In[2].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Inlet02NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Inlet02SafetyException				:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Inlet02].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Inlet02TorqueException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet02TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet02DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet02HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet02].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
		
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.In[3].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Inlet03NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Inlet03SafetyException				:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Inlet03].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Inlet03TorqueException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet03TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet03DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet03HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet03].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.In[4].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Inlet04NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Inlet04SafetyException				:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Inlet04].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Inlet04DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet04TorqueException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet04TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet04HomeException 				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet04].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.In[5].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Inlet05NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Inlet05SafetyException				:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Inlet05].DI_NotErrFUNC;
		END_IF
	MC_InputOutput.Network.Filler.Exceptions.Inlet05DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stStatus.q_stMainAxisStatus.q_xError;
	MC_InputOutput.Network.Filler.Exceptions.Inlet05TorqueException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
	MC_InputOutput.Network.Filler.Exceptions.Inlet05TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stStatus.q_stMainAxisStatus.q_xLagError;
	MC_InputOutput.Network.Filler.Exceptions.Inlet05HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																					VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet05].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.In[6].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Inlet06NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Inlet06SafetyException				:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Inlet06].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Inlet06DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet06TorqueException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet06TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet06HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet06].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
		
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.In[7].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Inlet07NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Inlet07SafetyException				:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Inlet07].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Inlet07DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet07TorqueException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet07TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet07HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet07].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.In[8].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Inlet08NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Inlet08SafetyException				:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Inlet08].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Inlet08DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet08TorqueException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet08TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet08HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet08].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.In[9].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Inlet09NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Inlet09SafetyException				:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Inlet09].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Inlet09DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet09TorqueException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet09TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet09HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																					VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet09].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.In[10].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Inlet10NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Inlet10SafetyException				:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Inlet10].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Inlet10DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet10TorqueException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet10TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Inlet10HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Inlet10].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	(* Outlet axis exception *)
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.Out[1].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Outlet01NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Outlet01SafetyException			:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Outlet01].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Outlet01DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet01TorqueException			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet01TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet01HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet01].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.Out[2].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Outlet02NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Outlet02SafetyException			:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Outlet02].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Outlet02DriveException 			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet02TorqueException			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet02TrackException 			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet02HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet02].iq_stStatus.q_stMainAxisStatus.q_xInitDone;	
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.Out[3].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Outlet03NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Outlet03SafetyException			:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Outlet03].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Outlet03DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet03TorqueException			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet03TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet03HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet03].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.Out[4].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Outlet04NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Outlet04SafetyException			:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Outlet04].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Outlet04DriveException 			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet04TorqueException			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet04TrackException 			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet04HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet04].iq_stStatus.q_stMainAxisStatus.q_xInitDone;	
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.Out[5].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Outlet05NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Outlet05SafetyException			:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Outlet05].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Outlet05DriveException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet05TorqueException			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet05TrackException				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet05HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet05].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
	
	IF VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stStatus.q_stMainAxisStatus.q_xAxisReal THEN
		IF NOT CFG_MC.Axes.Filler.Out[6].VelocityControl THEN
			MC_InputOutput.Network.Filler.Exceptions.Outlet06NotInOpException			:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stStatus.q_stMainAxisStatus.iq_xOperational;
			MC_InputOutput.Network.Filler.Exceptions.Outlet06SafetyException			:= NOT MC_InputOutput.Safety.Filler.Commands.AxesDiag[CST_Outlet06].DI_NotErrFUNC;
		END_IF
		MC_InputOutput.Network.Filler.Exceptions.Outlet06DriveException 			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stStatus.q_stMainAxisStatus.q_xError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet06TorqueException			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet06TrackException 			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stStatus.q_stMainAxisStatus.q_xLagError;
		MC_InputOutput.Network.Filler.Exceptions.Outlet06HomeException				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stStatus.q_stMainAxisStatus.q_xIsHomed AND
																						VAR_Machine.stFillerModule.iq_astSubModuleAxis[CST_Outlet06].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
	END_IF
END_ACTION