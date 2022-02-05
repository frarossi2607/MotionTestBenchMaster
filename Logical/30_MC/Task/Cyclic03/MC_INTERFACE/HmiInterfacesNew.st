ACTION HmiInterfacesNew:
	xAxisInVelocityControl	:= FALSE;

	IF VAR_Machine.iq_stParameter.i_uiAxisSelected >= CST_FillerSubModuleHmiStart AND VAR_Machine.iq_stParameter.i_uiAxisSelected <= CST_FillerSubModuleHmiStart + CST_LastFillerModuleAxis	THEN
		VAR_Machine.stFillerModule.iq_stParameters.i_uiAxisSelected	:= VAR_Machine.iq_stParameter.i_uiAxisSelected - CST_FillerSubModuleHmiStart;
	ELSIF VAR_Machine.iq_stParameter.i_uiAxisSelected >= CST_OutletSubModuleHmiStart AND VAR_Machine.iq_stParameter.i_uiAxisSelected <= CST_OutletSubModuleHmiStart + CST_LastOutletModuleAxis THEN
		VAR_Machine.stOutletModule.iq_stParameters.i_uiAxisSelected	:= VAR_Machine.iq_stParameter.i_uiAxisSelected - CST_OutletSubModuleHmiStart;
	ELSIF VAR_Machine.iq_stParameter.i_uiAxisSelected >= CST_InletSubModuleHmiStart AND VAR_Machine.iq_stParameter.i_uiAxisSelected <= CST_InletSubModuleHmiStart + CST_LastInletModuleAxis THEN
		VAR_Machine.stInletModule.iq_stParameters.i_uiAxisSelected	:= VAR_Machine.iq_stParameter.i_uiAxisSelected - CST_InletSubModuleHmiStart;
	ELSIF VAR_Machine.iq_stParameter.i_uiAxisSelected = CST_MachinePhasingOffset THEN
		VAR_Machine.stMasterModule.iq_stParameters.i_uiAxisSelected	:=	VAR_Machine.iq_stParameter.i_uiAxisSelected;	
	END_IF
////////////////////////////////////////////////
	
		HMI_MC_GenericAxisDataNew[1].uiDiagCode				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_stInfo.Diag.StatusID.Code;
		HMI_MC_GenericAxisDataNew[1].rLagError				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_rLagError,FALSE);
		
		HMI_MC_GenericAxisDataNew[1].xMotorWithBrake		:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xMotorWithBrake;
		HMI_MC_GenericAxisDataNew[1].xThirdPartMotor		:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xThirdPartyMotor;
		HMI_MC_GenericAxisDataNew[1].xVelocityControl		:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
		HMI_MC_GenericAxisDataNew[1].xInduction				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xInduction;
		HMI_MC_GenericAxisDataNew[1].rHomingOffset			:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_rHomingOffset;
		
		HMI_MC_GenericAxisDataNew[1].rPosition				:= LREAL_TO_REAL(VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_lrPosition);
		HMI_MC_GenericAxisDataNew[1].rPosition_mm			:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,HMI_MC_GenericAxisDataNew[1].rPosition,TRUE);//V1.7.2
			
		HMI_MC_GenericAxisDataNew[1].rVelocity				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_rVelocity * 10.0;
		
		HMI_MC_GenericAxisDataNew[1].rTotalPhasingOffset	:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_rTotalOffset,FALSE);

		HMI_MC_GenericAxisDataNew[1].xInitialized			:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xInitDone;

		xPhasingRunning									:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xPhasingRunning;
				
		IF HMI_MC_GenericAxisDataNew[1].xInitialized THEN
			HMI_MC_GenericAxisDataNew[1].xActive				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xActive;
			HMI_MC_GenericAxisDataNew[1].xBrakeReleased		:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xEnabled;
			HMI_MC_GenericAxisDataNew[1].xFollowingError		:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xHomed				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xInError				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xError;
			HMI_MC_GenericAxisDataNew[1].xInPosition			:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xInPosition;
			HMI_MC_GenericAxisDataNew[1].xPowered				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xReal				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xRunning				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xSynchro				:= VAR_Machine.stMasterModule.iq_astSubModuleAxis[CST_MachineMasterAxis].iq_stStatus.q_stMainAxisStatus.q_xSynchronized;
			HMI_MC_GenericAxisDataNew[1].xTorqueError			:= FALSE;
//			HMI_MC_GenericAxisDataNew[1].xHmiWait				:= FALSE;//V1.7.2
		ELSE
			HMI_MC_GenericAxisDataNew[1].xActive				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xBrakeReleased		:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xEnabled;
			HMI_MC_GenericAxisDataNew[1].xFollowingError		:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xHomed				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xInError				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xInPosition			:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xPowered				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xReal				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xRunning				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xSynchro				:= FALSE;
			HMI_MC_GenericAxisDataNew[1].xTorqueError			:= FALSE;
//			HMI_MC_GenericAxisDataNew[1].xHmiWait				:= TRUE;//v1.7.2
		END_IF
			
	FOR HMI_AxisIndex := 1 TO 13 DO
		//Inlet Axis Motor
		IF HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID >= CST_InletSubModuleHmiStart AND HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID <= CST_InletSubModuleHmiStart + CST_LastInletModuleAxis THEN
			
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiDiagCode				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_stInfo.Diag.StatusID.Code;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].iNextAx_Number;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].iPrevAx_Number;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rEncoderTemperature		:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rEncoderTemperature;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rMaxTorque;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rLagError				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rLagError, FALSE);
		
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xMotorWithBrake			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xMotorWithBrake;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xThirdPartMotor			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xThirdPartyMotor;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xVelocityControl			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInduction				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xInduction;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rHomingOffset			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rHomingOffset;
		
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rMotorTemperature		:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rMotorTemperature;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rNextAx_Position_mm;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPosition				:= LREAL_TO_REAL(VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_lrPosition);
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPosition_mm			:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPosition,TRUE);//v1.7.2
			
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPrevAx_Position_mm;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rTorque					:= LREAL_TO_REAL(VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_lrTorque);
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rVelocity				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rVelocity * 10.0;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rSwitchValue;
		
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rTotalPhasingOffset		:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rTotalOffset,FALSE);

			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInitialized				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xInitDone;

			xPhasingRunning									:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xPhasingRunning;
		
			IF HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInitialized THEN
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xActive				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xActive;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xBrakeReleased		:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xBrakeReleased;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xEnabled;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xFollowingError		:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xLagError;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHomed				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xIsHomed;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInError				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xError;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInPosition			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xInPosition;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xPowered				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xPoweredOn;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xReal				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xRunning				:= NOT VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xStopped;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xSynchro				:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xSynchronized;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xTorqueError			:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
				//HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHmiWait				:= FALSE;//v1.7.2
			ELSE
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xActive				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xBrakeReleased		:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xEnabled;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xFollowingError		:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHomed					:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInError				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInPosition			:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xPowered				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xReal					:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xRunning				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xSynchro				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xTorqueError			:= FALSE;
//				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHmiWait				:= TRUE;//v1.7.2
			END_IF
			xAxisInVelocityControl	:= VAR_Machine.stInletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_InletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
		//Filler Module
		ELSIF HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID >= CST_FillerSubModuleHmiStart AND HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID <= CST_FillerSubModuleHmiStart + CST_LastFillerModuleAxis THEN
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiDiagCode				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_stInfo.Diag.StatusID.Code;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].iNextAx_Number;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].iPrevAx_Number;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rEncoderTemperature		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rEncoderTemperature;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rMaxTorque;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rMotorTemperature		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rMotorTemperature;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rNextAx_Position_mm;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPosition				:= LREAL_TO_REAL(VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_lrPosition);
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPosition_mm			:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPosition,TRUE);//v1.7.2
		
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xMotorWithBrake			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xMotorWithBrake;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xThirdPartMotor			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xThirdPartyMotor;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xVelocityControl			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInduction				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xInduction;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rHomingOffset			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rHomingOffset;
		
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rTotalPhasingOffset		:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rTotalOffset, FALSE);
		
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rLagError				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rLagError, FALSE);
		
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPrevAx_Position_mm;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rTorque					:= LREAL_TO_REAL(VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_lrTorque);
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rVelocity				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rVelocity * 10.0;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rSwitchValue;

			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInitialized				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xInitDone;
		
			xPhasingRunning									:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xPhasingRunning;
		
			IF HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInitialized THEN
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xActive				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xActive;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xBrakeReleased		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xBrakeReleased;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xEnabled;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xFollowingError		:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xLagError;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHomed				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xIsHomed;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInError				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xError;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInPosition			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xInPosition;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xPowered				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xPoweredOn;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xReal				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xRunning				:= NOT VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xStopped;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xSynchro				:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xSynchronized;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xTorqueError			:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
				//HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHmiWait				:= FALSE;//v1.7.2
			ELSE
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xActive				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xBrakeReleased		:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xEnabled;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xFollowingError		:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHomed				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInError				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInPosition			:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xPowered				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xReal				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xRunning				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xSynchro				:= FALSE;
				HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xTorqueError			:= FALSE;
				//HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHmiWait				:= TRUE;//v1.7.2
			END_IF
		
			xAxisInVelocityControl	:= VAR_Machine.stFillerModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID-CST_FillerSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
		//Outlet Module 
		ELSIF HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID >= CST_OutletSubModuleHmiStart AND HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID <= CST_OutletSubModuleHmiStart + CST_LastOutletModuleAxis THEN
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiDiagCode					:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_stInfo.Diag.StatusID.Code;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].iNextAx_Number;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].iPrevAx_Number;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rEncoderTemperature		:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rEncoderTemperature;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rMaxTorque;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rLagError					:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep, VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rLagError, FALSE);
		
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xMotorWithBrake			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xMotorWithBrake;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xThirdPartMotor			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xThirdPartyMotor;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xVelocityControl			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInduction					:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xInduction;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rHomingOffset				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rHomingOffset;
		
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rMotorTemperature			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rMotorTemperature;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rNextAx_Position_mm;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPosition					:= LREAL_TO_REAL(VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_lrPosition);
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPosition_mm				:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPosition,TRUE);//v1.7.2
			
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rPrevAx_Position_mm;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rTorque					:= LREAL_TO_REAL(VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_lrTorque);
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rVelocity					:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rVelocity * 10.0;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rSwitchValue;
		
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].rTotalPhasingOffset		:= FC_DegreeToMm(CFG_MC.Mechanical.MachineStep,VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_rTotalOffset,FALSE);

			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInitialized				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xInitDone;

			xPhasingRunning														:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xPhasingRunning;
		
		IF HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInitialized THEN
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xActive				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xActive;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xBrakeReleased			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xBrakeReleased;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xEnabled;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xFollowingError		:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xLagError;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHomed					:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xIsHomed;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInError				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xError;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInPosition			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xInPosition;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xPowered				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xPoweredOn;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xReal					:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xAxisReal;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xRunning				:= NOT VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xStopped;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xSynchro				:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xSynchronized;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xTorqueError			:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xTorqueError;
			//HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHmiWait				:= FALSE;
			ELSE
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xActive				:= FALSE;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xBrakeReleased			:= FALSE;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xEnabled;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xFollowingError		:= FALSE;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHomed					:= FALSE;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInError				:= FALSE;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xInPosition			:= FALSE;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xPowered				:= FALSE;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xReal					:= FALSE;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xRunning				:= FALSE;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xSynchro				:= FALSE;
			HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xTorqueError			:= FALSE;
			//HMI_MC_GenericAxisDataNew[HMI_AxisIndex].xHmiWait				:= TRUE;
			END_IF
			
			xAxisInVelocityControl	:= VAR_Machine.stOutletModule.iq_astSubModuleAxis[HMI_MC_GenericAxisDataNew[HMI_AxisIndex].uiAxisID - CST_OutletSubModuleHmiStart].iq_stStatus.q_stMainAxisStatus.q_xVelocityControl;
		
		END_IF
	END_FOR
	
		IF VAR_Machine.stFillerModule.iq_stStatus.q_xInitDone AND  VAR_Machine.stInletModule.iq_stStatus.q_xInitDone AND VAR_Machine.stOutletModule.iq_stStatus.q_xInitDone THEN//v1.7.2
			HMI_MC_GenericAxisData.xHmiWait										:= FALSE ;//v1.7.2
		ELSE //v1.7.2
			HMI_MC_GenericAxisData.xHmiWait										:= TRUE;//v1.7.2
		END_IF//v1.7.2


		/////////////////////////////////////////////////
		HMI_MC_EncoderDiagnostic.Present 									:= CFG_MC.Generic.SyncroPar.ExternalEncoder;
		HMI_MC_EncoderDiagnostic.ModuleOK 									:= MC_InputOutput.Network.Machine.Commands.MasterEncoderPositionValid;
		HMI_MC_EncoderDiagnostic.Value 										:= ITC_Motion_ExtEnc;
	
		HMI_MC_GenericAxisData.rPosition									:= LREAL_TO_REAL(VAR_Machine.stFillerModule.iq_astSubModuleAxis[15].iq_stStatus.q_stMainAxisStatus.q_lrPosition);//V4.A.A.1.7.0
	END_ACTION