ACTION HmiInterfaces:
	xAxisInVelocityControl	:= FALSE;
	
	IF VAR_Machine.iq_stParameter.i_uiAxisSelected >= CST_FillerSubModuleHmiStart AND VAR_Machine.iq_stParameter.i_uiAxisSelected <= CST_FillerSubModuleHmiStart + CST_LastFillerModuleAxis	THEN

		VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected	:= VAR_Machine.iq_stParameter.i_uiAxisSelected - CST_FillerSubModuleHmiStart;
			
		HMI_MC_GenericAxisData.uiDiagCode				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_stInfo.Diag.StatusID.Code;
		HMI_MC_GenericAxisData.iNextAx_Number;
		HMI_MC_GenericAxisData.iPrevAx_Number;
		HMI_MC_GenericAxisData.rEncoderTemperature		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rEncoderTemperature;
		HMI_MC_GenericAxisData.rMaxTorque;
		HMI_MC_GenericAxisData.rMotorTemperature		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rMotorTemperature;
		HMI_MC_GenericAxisData.rNextAx_Position_mm;
		HMI_MC_GenericAxisData.rPosition				:= LREAL_TO_REAL(VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_lrPosition);
		HMI_MC_GenericAxisData.rPosition_mm				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, HMI_MC_GenericAxisData.rPosition, TRUE);
		
		HMI_MC_GenericAxisData.xMotorWithBrake			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xMotorWithBrake;
		HMI_MC_GenericAxisData.xThirdPartMotor			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xThirdPartyMotor;
		HMI_MC_GenericAxisData.xVelocityControl			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
		HMI_MC_GenericAxisData.xInduction				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xInduction;
		HMI_MC_GenericAxisData.rHomingOffset			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rHomingOffset;
		
		HMI_MC_GenericAxisData.rTotalPhasingOffset		:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rTotalOffset, FALSE);
		
		HMI_MC_GenericAxisData.rLagError				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rLagError, FALSE);
		
		HMI_MC_GenericAxisData.rPrevAx_Position_mm;
		HMI_MC_GenericAxisData.rTorque					:= LREAL_TO_REAL(VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_lrTorque);
		HMI_MC_GenericAxisData.rVelocity				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rVelocity * 10.0;
		HMI_MC_GenericAxisData.rSwitchValue;

		HMI_MC_GenericAxisData.xInitialized				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
		
		xPhasingRunning									:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xPhasingRunning;
		
		IF HMI_MC_GenericAxisData.xInitialized THEN
			HMI_MC_GenericAxisData.xActive				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xActive;
			HMI_MC_GenericAxisData.xBrakeReleased		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xBrakeReleased;
			HMI_MC_GenericAxisData.xEnabled;
			HMI_MC_GenericAxisData.xFollowingError		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xLagError;
			HMI_MC_GenericAxisData.xHomed				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xIsHomed;
			HMI_MC_GenericAxisData.xInError				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xError;
			HMI_MC_GenericAxisData.xInPosition			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xInPosition;
			HMI_MC_GenericAxisData.xPowered				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xPoweredOn;
			HMI_MC_GenericAxisData.xReal				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
			HMI_MC_GenericAxisData.xRunning				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xStopped;
			HMI_MC_GenericAxisData.xSynchro				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xSynchronized;
			HMI_MC_GenericAxisData.xTorqueError			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
			HMI_MC_GenericAxisData.xHmiWait				:= FALSE;
		ELSE
			HMI_MC_GenericAxisData.xActive				:= FALSE;
			HMI_MC_GenericAxisData.xBrakeReleased		:= FALSE;
			HMI_MC_GenericAxisData.xEnabled;
			HMI_MC_GenericAxisData.xFollowingError		:= FALSE;
			HMI_MC_GenericAxisData.xHomed				:= FALSE;
			HMI_MC_GenericAxisData.xInError				:= FALSE;
			HMI_MC_GenericAxisData.xInPosition			:= FALSE;
			HMI_MC_GenericAxisData.xPowered				:= FALSE;
			HMI_MC_GenericAxisData.xReal				:= FALSE;
			HMI_MC_GenericAxisData.xRunning				:= FALSE;
			HMI_MC_GenericAxisData.xSynchro				:= FALSE;
			HMI_MC_GenericAxisData.xTorqueError			:= FALSE;
			HMI_MC_GenericAxisData.xHmiWait				:= TRUE;
		END_IF
		
		xAxisInVelocityControl	:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
		
	ELSIF VAR_Machine.iq_stParameter.i_uiAxisSelected >= CST_OutletSubModuleHmiStart AND VAR_Machine.iq_stParameter.i_uiAxisSelected <= CST_OutletSubModuleHmiStart + CST_LastOutletModuleAxis THEN
	
		VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected	:= VAR_Machine.iq_stParameter.i_uiAxisSelected - CST_OutletSubModuleHmiStart;

		HMI_MC_GenericAxisData.uiDiagCode				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_stInfo.Diag.StatusID.Code;
		HMI_MC_GenericAxisData.iNextAx_Number;
		HMI_MC_GenericAxisData.iPrevAx_Number;
		HMI_MC_GenericAxisData.rEncoderTemperature		:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rEncoderTemperature;
		HMI_MC_GenericAxisData.rMaxTorque;
		HMI_MC_GenericAxisData.rLagError				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rLagError, FALSE);
		
		HMI_MC_GenericAxisData.xMotorWithBrake			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xMotorWithBrake;
		HMI_MC_GenericAxisData.xThirdPartMotor			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xThirdPartyMotor;
		HMI_MC_GenericAxisData.xVelocityControl			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
		HMI_MC_GenericAxisData.xInduction				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xInduction;
		HMI_MC_GenericAxisData.rHomingOffset			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rHomingOffset;
		
		HMI_MC_GenericAxisData.rMotorTemperature		:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rMotorTemperature;
		HMI_MC_GenericAxisData.rNextAx_Position_mm;
		HMI_MC_GenericAxisData.rPosition				:= LREAL_TO_REAL(VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_lrPosition);
		HMI_MC_GenericAxisData.rPosition_mm				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, HMI_MC_GenericAxisData.rPosition, TRUE);
			
		HMI_MC_GenericAxisData.rPrevAx_Position_mm;
		HMI_MC_GenericAxisData.rTorque					:= LREAL_TO_REAL(VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_lrTorque);
		HMI_MC_GenericAxisData.rVelocity				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rVelocity * 10.0;
		HMI_MC_GenericAxisData.rSwitchValue;
		
		HMI_MC_GenericAxisData.rTotalPhasingOffset		:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rTotalOffset,FALSE);

		HMI_MC_GenericAxisData.xInitialized				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xInitDone;

		xPhasingRunning									:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xPhasingRunning;
		
		IF HMI_MC_GenericAxisData.xInitialized THEN
			HMI_MC_GenericAxisData.xActive				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xActive;
			HMI_MC_GenericAxisData.xBrakeReleased		:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xBrakeReleased;
			HMI_MC_GenericAxisData.xEnabled;
			HMI_MC_GenericAxisData.xFollowingError		:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xLagError;
			HMI_MC_GenericAxisData.xHomed				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xIsHomed;
			HMI_MC_GenericAxisData.xInError				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xError;
			HMI_MC_GenericAxisData.xInPosition			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xInPosition;
			HMI_MC_GenericAxisData.xPowered				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xPoweredOn;
			HMI_MC_GenericAxisData.xReal				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
			HMI_MC_GenericAxisData.xRunning				:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xStopped;
			HMI_MC_GenericAxisData.xSynchro				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xSynchronized;
			HMI_MC_GenericAxisData.xTorqueError			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
			HMI_MC_GenericAxisData.xHmiWait				:= FALSE;
		ELSE
			HMI_MC_GenericAxisData.xActive				:= FALSE;
			HMI_MC_GenericAxisData.xBrakeReleased		:= FALSE;
			HMI_MC_GenericAxisData.xEnabled;
			HMI_MC_GenericAxisData.xFollowingError		:= FALSE;
			HMI_MC_GenericAxisData.xHomed				:= FALSE;
			HMI_MC_GenericAxisData.xInError				:= FALSE;
			HMI_MC_GenericAxisData.xInPosition			:= FALSE;
			HMI_MC_GenericAxisData.xPowered				:= FALSE;
			HMI_MC_GenericAxisData.xReal				:= FALSE;
			HMI_MC_GenericAxisData.xRunning				:= FALSE;
			HMI_MC_GenericAxisData.xSynchro				:= FALSE;
			HMI_MC_GenericAxisData.xTorqueError			:= FALSE;
			HMI_MC_GenericAxisData.xHmiWait				:= TRUE;
		END_IF
			
		xAxisInVelocityControl	:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
		
	ELSIF VAR_Machine.iq_stParameter.i_uiAxisSelected >= CST_InletSubModuleHmiStart AND VAR_Machine.iq_stParameter.i_uiAxisSelected <= CST_InletSubModuleHmiStart + CST_LastInletModuleAxis THEN
	
		VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected	:= VAR_Machine.iq_stParameter.i_uiAxisSelected - CST_InletSubModuleHmiStart;

		HMI_MC_GenericAxisData.uiDiagCode				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_stInfo.Diag.StatusID.Code;
		HMI_MC_GenericAxisData.iNextAx_Number;
		HMI_MC_GenericAxisData.iPrevAx_Number;
		HMI_MC_GenericAxisData.rEncoderTemperature		:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rEncoderTemperature;
		HMI_MC_GenericAxisData.rMaxTorque;
		HMI_MC_GenericAxisData.rLagError				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rLagError, FALSE);
		
		HMI_MC_GenericAxisData.xMotorWithBrake			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xMotorWithBrake;
		HMI_MC_GenericAxisData.xThirdPartMotor			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xThirdPartyMotor;
		HMI_MC_GenericAxisData.xVelocityControl			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
		HMI_MC_GenericAxisData.xInduction				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xInduction;
		HMI_MC_GenericAxisData.rHomingOffset			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rHomingOffset;
		
		HMI_MC_GenericAxisData.rMotorTemperature		:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rMotorTemperature;
		HMI_MC_GenericAxisData.rNextAx_Position_mm;
		HMI_MC_GenericAxisData.rPosition				:= LREAL_TO_REAL(VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_lrPosition);
		HMI_MC_GenericAxisData.rPosition_mm				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, HMI_MC_GenericAxisData.rPosition, TRUE);
			
		HMI_MC_GenericAxisData.rPrevAx_Position_mm;
		HMI_MC_GenericAxisData.rTorque					:= LREAL_TO_REAL(VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_lrTorque);
		HMI_MC_GenericAxisData.rVelocity				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rVelocity * 10.0;
		HMI_MC_GenericAxisData.rSwitchValue;
		
		HMI_MC_GenericAxisData.rTotalPhasingOffset		:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_rTotalOffset,FALSE);

		HMI_MC_GenericAxisData.xInitialized				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xInitDone;

		xPhasingRunning									:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xPhasingRunning;
		
		IF HMI_MC_GenericAxisData.xInitialized THEN
			HMI_MC_GenericAxisData.xActive				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xActive;
			HMI_MC_GenericAxisData.xBrakeReleased		:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xBrakeReleased;
			HMI_MC_GenericAxisData.xEnabled;
			HMI_MC_GenericAxisData.xFollowingError		:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xLagError;
			HMI_MC_GenericAxisData.xHomed				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xIsHomed;
			HMI_MC_GenericAxisData.xInError				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xError;
			HMI_MC_GenericAxisData.xInPosition			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xInPosition;
			HMI_MC_GenericAxisData.xPowered				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xPoweredOn;
			HMI_MC_GenericAxisData.xReal				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
			HMI_MC_GenericAxisData.xRunning				:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xStopped;
			HMI_MC_GenericAxisData.xSynchro				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xSynchronized;
			HMI_MC_GenericAxisData.xTorqueError			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
			HMI_MC_GenericAxisData.xHmiWait				:= FALSE;
		ELSE
			HMI_MC_GenericAxisData.xActive				:= FALSE;
			HMI_MC_GenericAxisData.xBrakeReleased		:= FALSE;
			HMI_MC_GenericAxisData.xEnabled;
			HMI_MC_GenericAxisData.xFollowingError		:= FALSE;
			HMI_MC_GenericAxisData.xHomed				:= FALSE;
			HMI_MC_GenericAxisData.xInError				:= FALSE;
			HMI_MC_GenericAxisData.xInPosition			:= FALSE;
			HMI_MC_GenericAxisData.xPowered				:= FALSE;
			HMI_MC_GenericAxisData.xReal				:= FALSE;
			HMI_MC_GenericAxisData.xRunning				:= FALSE;
			HMI_MC_GenericAxisData.xSynchro				:= FALSE;
			HMI_MC_GenericAxisData.xTorqueError			:= FALSE;
			HMI_MC_GenericAxisData.xHmiWait				:= TRUE;
		END_IF
			
		xAxisInVelocityControl	:= VAR_Machine.stInletModule.iq_astSubModuleAxis[VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;

	ELSIF VAR_Machine.iq_stParameter.i_uiAxisSelected = CST_MachinePhasingOffset THEN
		
		VAR_Machine.stMasterModule.iq_stParameters.i_uiAxisSelected	:=	VAR_Machine.iq_stParameter.i_uiAxisSelected;
		
		HMI_MC_GenericAxisData.uiDiagCode				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_stInfo.Diag.StatusID.Code;
		HMI_MC_GenericAxisData.rLagError				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_rLagError,FALSE);
		
		HMI_MC_GenericAxisData.xMotorWithBrake			:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xMotorWithBrake;
		HMI_MC_GenericAxisData.xThirdPartMotor			:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xThirdPartyMotor;
		HMI_MC_GenericAxisData.xVelocityControl			:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
		HMI_MC_GenericAxisData.xInduction				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xInduction;
		HMI_MC_GenericAxisData.rHomingOffset			:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_rHomingOffset;
		
		HMI_MC_GenericAxisData.rPosition				:= LREAL_TO_REAL(VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_lrPosition);
		HMI_MC_GenericAxisData.rPosition_mm				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,HMI_MC_GenericAxisData.rPosition,TRUE);
			
		HMI_MC_GenericAxisData.rVelocity				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_rVelocity * 10.0;
		
		HMI_MC_GenericAxisData.rTotalPhasingOffset		:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_rTotalOffset,FALSE);

		HMI_MC_GenericAxisData.xInitialized				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xInitDone;

		xPhasingRunning									:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xPhasingRunning;
				
		IF HMI_MC_GenericAxisData.xInitialized THEN
			HMI_MC_GenericAxisData.xActive				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xActive;
			HMI_MC_GenericAxisData.xBrakeReleased		:= FALSE;
			HMI_MC_GenericAxisData.xEnabled;
			HMI_MC_GenericAxisData.xFollowingError		:= FALSE;
			HMI_MC_GenericAxisData.xHomed				:= FALSE;
			HMI_MC_GenericAxisData.xInError				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xError;
			HMI_MC_GenericAxisData.xInPosition			:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xInPosition;
			HMI_MC_GenericAxisData.xPowered				:= FALSE;
			HMI_MC_GenericAxisData.xReal				:= FALSE;
			HMI_MC_GenericAxisData.xRunning				:= FALSE;
			HMI_MC_GenericAxisData.xSynchro				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xSynchronized;
			HMI_MC_GenericAxisData.xTorqueError			:= FALSE;
			HMI_MC_GenericAxisData.xHmiWait				:= FALSE;
		ELSE
			HMI_MC_GenericAxisData.xActive				:= FALSE;
			HMI_MC_GenericAxisData.xBrakeReleased		:= FALSE;
			HMI_MC_GenericAxisData.xEnabled;
			HMI_MC_GenericAxisData.xFollowingError		:= FALSE;
			HMI_MC_GenericAxisData.xHomed				:= FALSE;
			HMI_MC_GenericAxisData.xInError				:= FALSE;
			HMI_MC_GenericAxisData.xInPosition			:= FALSE;
			HMI_MC_GenericAxisData.xPowered				:= FALSE;
			HMI_MC_GenericAxisData.xReal				:= FALSE;
			HMI_MC_GenericAxisData.xRunning				:= FALSE;
			HMI_MC_GenericAxisData.xSynchro				:= FALSE;
			HMI_MC_GenericAxisData.xTorqueError			:= FALSE;
			HMI_MC_GenericAxisData.xHmiWait				:= TRUE;
		END_IF
			
		xAxisInVelocityControl	:=	 VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
	END_IF
	
	CASE VAR_Machine.iq_stParameter.i_uiAxisSelected OF
		99: 
			HMI_MC_GenericAxisData.usiHmiName	:= 99; //V4.A.A.1.6.13
		
		105:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.In[10].HmiNameId;
		
		106:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.In[9].HmiNameId;
		
		107:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.In[8].HmiNameId;
		
		108:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.In[7].HmiNameId;
		
		109:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.In[6].HmiNameId;
		
		110:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.In[5].HmiNameId;
		
		111:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.In[4].HmiNameId;
		
		112:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.In[3].HmiNameId;
		
		113:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.In[2].HmiNameId;
		
		114:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.In[1].HmiNameId;
		
		115:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.Main.HmiNameId;
			
		116:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.Out[1].HmiNameId;
		
		117:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.Out[2].HmiNameId;
		
		118:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.Out[3].HmiNameId;
		
		119:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.Out[4].HmiNameId;
		
		120:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.Out[5].HmiNameId;
		
		121:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Filler.Out[6].HmiNameId;
					
		211:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Inlet.In[4].HmiNameId;
		
		212:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Inlet.In[3].HmiNameId;
		
		213:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Inlet.In[2].HmiNameId;
		
		214:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Inlet.In[1].HmiNameId;
		
		215:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Inlet.Main.HmiNameId;
			
		216:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Inlet.Out[1].HmiNameId;
		
		217:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Inlet.Out[2].HmiNameId;
		
		218:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Inlet.Out[3].HmiNameId;
		
		219:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Inlet.Out[4].HmiNameId;
		
		311:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Outlet.In[4].HmiNameId;
		
		312:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Outlet.In[3].HmiNameId;
		
		313:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Outlet.In[2].HmiNameId;
		
		314:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Outlet.In[1].HmiNameId;
		
		315:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Outlet.Main.HmiNameId;
			
		316:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Outlet.Out[1].HmiNameId;
		
		317:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Outlet.Out[2].HmiNameId;
		
		318:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Outlet.Out[3].HmiNameId;
		
		319:
			HMI_MC_GenericAxisData.usiHmiName	:= CFG_MC.Axes.Outlet.Out[4].HmiNameId;
		ELSE
			HMI_MC_GenericAxisData.usiHmiName		:= 0;
	END_CASE
	
	HMI_MC_AxisPresent;
	
	//Transfer Wheel - Encoder Diagnostic
	HMI_MC_EncoderDiagnostic.Present 	:= CFG_MC.Generic.SyncroPar.ExternalEncoder;
	HMI_MC_EncoderDiagnostic.ModuleOK 	:= MC_InputOutput.Network.Machine.Commands.MasterEncoderPositionValid;
	HMI_MC_EncoderDiagnostic.Value 		:= ITC_Motion_ExtEnc;
END_ACTION