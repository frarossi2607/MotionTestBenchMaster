(* General axis function block *)
FUNCTION_BLOCK FB_GeneralAxis
(***************************************************************************************************************************************
Master AND Secondary FBs error handling. 

	Case 1) Master on error : the secondary axis will be powered off AND the axis will be in free wheeling mode.
	Case 2) Secondary on error : since the master is the only axis in position control in case of secondary error the external reaction
			of the unexpected behaviour will be a quick stop. The master, alone, will try to stop the axis and garantee the synchro.
****************************************************************************************************************************************)
	IF NOT i_xEnable THEN
		eMainAxisStep 		:= DISABLE;
		eSecondaryAxisStep	:= S_DISABLE;
		RETURN;
	END_IF
	
	(* Power fault Lag error and Torque error detection *)
	i_pstStatus.q_stMainAxisStatus.q_xPowerFault		:= (i_pstStatus.q_stMainAxisStatus.q_xPowerFault	AND NOT i_pstCmd.i_xErrorReset) OR
															(i_pstStatus.q_stMainAxisStatus.q_xPowerSupply	AND
															((usiPhaseMonitor AND (CST_DcBusUndervoltageError + CST_PhaseMonitorError )) <> 0
															OR fbMpAxisBasic.Info.Diag.Internal.Code = 7211 OR fbMpAxisBasic.Info.Diag.Internal.Code = 7215));
	
	IF (usiPhaseMonitor <> 0) THEN//V4.A.A.1.6.14
		
		IF NOT i_pstStatus.q_stMainAxisStatus.q_xDcBusLowVolatage THEN//V4.A.A.1.6.14
			i_pstStatus.q_stMainAxisStatus.q_xDcBusLowVolatage	:= ((usiPhaseMonitor AND CST_DcBusUndervoltageError) <> 0);//V4.A.A.1.6.14
		ELSIF NOT  i_pstStatus.q_stMainAxisStatus.q_xDcBusLowVolatage AND i_pstCmd.i_xErrorReset THEN//V4.A.A.1.6.14
			i_pstStatus.q_stMainAxisStatus.q_xDcBusLowVolatage	:= FALSE;//V4.A.A.1.6.14
			END_IF//V4.A.A.1.6.14
		 
		IF NOT i_pstStatus.q_stMainAxisStatus.q_xPhaseMonitorFault THEN//V4.A.A.1.6.14
			i_pstStatus.q_stMainAxisStatus.q_xPhaseMonitorFault	:= ((usiPhaseMonitor AND CST_PhaseMonitorError) <> 0);//V4.A.A.1.6.14
		ELSIF NOT i_pstStatus.q_stMainAxisStatus.q_xPhaseMonitorFault AND i_pstCmd.i_xErrorReset THEN//V4.A.A.1.6.14
			i_pstStatus.q_stMainAxisStatus.q_xDcBusLowVolatage	:= FALSE;//V4.A.A.1.6.14
		END_IF
		
		IF NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupplyVoltageWarning THEN//V4.A.A.1.6.14
			i_pstStatus.q_stMainAxisStatus.q_xPowerSupplyVoltageWarning	:= ((usiPhaseMonitor AND CST_PowerSupplyVoltageMonitor) <> 0);//V4.A.A.1.6.14
		ELSIF NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupplyVoltageWarning AND i_pstCmd.i_xErrorReset THEN//V4.A.A.1.6.14
			i_pstStatus.q_stMainAxisStatus.q_xPowerSupplyVoltageWarning	:= FALSE;//V4.A.A.1.6.14
		END_IF//V4.A.A.1.6.14
		
	ELSIF (usiPhaseMonitor = 0) AND i_pstCmd.i_xErrorReset THEN//V4.A.A.1.6.14
		i_pstStatus.q_stMainAxisStatus.q_xDcBusLowVolatage			:= FALSE;//V4.A.A.1.6.14
		i_pstStatus.q_stMainAxisStatus.q_xPhaseMonitorFault			:= FALSE;//V4.A.A.1.6.14
		i_pstStatus.q_stMainAxisStatus.q_xPowerSupplyVoltageWarning	:= FALSE;//V4.A.A.1.6.14
	END_IF//V4.A.A.1.6.14
	
	i_pstStatus.q_stMainAxisStatus.q_xLagError			:= (i_pstStatus.q_stMainAxisStatus.q_xLagError		AND NOT i_pstCmd.i_xErrorReset) OR (usiDrivesStatusBits.1 AND rOldLagErrorValue > 0 AND NOT i_xVelocityControl);
	i_pstStatus.q_stMainAxisStatus.q_xTorqueError		:= (i_pstStatus.q_stMainAxisStatus.q_xTorqueError	AND NOT i_pstCmd.i_xErrorReset) OR (usiDrivesStatusBits.0 AND rOldTorqueErrorValue > 0);
	i_pstStatus.q_stMainAxisStatus.q_xPoweredOn			:= fbMpAxisBasic.PowerOn AND (usiDrivesStatusBits.3	OR i_pstStatus.q_stMainAxisStatus.q_xPowerSupply OR i_xInductionMotorType);
	
	fbReadCyclicParID();
	
	IF i_xInductionMotorType OR i_xThirdPartyMotor THEN
		fbInitParTabObj;
		fbDatObjMove;
		fbDatObjInfo;
		fbDatObjCopy;
		fbDatObjDelete;
	END_IF
		
	IF i_xInductionMotorType THEN
		fbSetupInductionMotor;
		IF strDataObjIdent = '' THEN
			strDataObjIdent	:= i_strParTabName;
			strDataObjIdent	:= CONCAT(strDataObjIdent, 'Id');
		END_IF
	END_IF
	
	IF i_xThirdPartyMotor THEN
		fbMotorPhasing();
		IF strDataObjPhasing = '' THEN
			strDataObjPhasing	:= i_strParTabName;
			strDataObjPhasing	:= CONCAT(strDataObjPhasing, 'Ph');
		END_IF
	END_IF
	
	IF NOT i_xToken THEN
		rExtrPositionTime								:= rExtrPositionTime + UDINT_TO_REAL(fbRTInfo.cycle_time) / 1E6;
		xJerkControl									:= FALSE;
		i_pstStatus.q_stMainAxisStatus.q_lrPosition		:= FC_LongRealReminder(fbMpAxisBasic.Position + fbMpAxisBasic.Velocity * rExtrPositionTime, rAxisPeriod, 0);
		RETURN;
	ELSE
		rExtrPositionTime								:= 0;
	END_IF
	
	IF eMainAxisStep > DISABLE THEN (* WAIT FOR FB ENABLE *)
		(* No comunication catch *)
		IF eMainAxisStep > WAIT_FOR_POWER AND fbMpAxisBasic.Info.BootState = mpAXIS_BLP_NETWORK_INACTIVE THEN
			IF eMainAxisStep < WAIT_FOR_CONNECTION THEN
				eMainAxisStep := WAIT_FOR_CONNECTION;
			END_IF
		(* Error catch *)
		ELSIF (fbMpAxisBasic.Error OR fbMpAxisCamSequencer.Error OR fbWriteParID.Error OR fbReadCyclicParID.Error OR fbReadParID.Error OR fbSetOverride.Error OR
				fbMpAxisCyclicSet.Error OR fbMotorPhasing.Error ) THEN
			
			IF eMainAxisStep < AXIS_ERROR THEN
				eMainAxisStep 					:= AXIS_ERROR;	(* ERROR STEP *)
			END_IF
		ELSIF eMainAxisStep >= AXIS_READY AND eMainAxisStep < AXIS_ERROR THEN//v4.A.A.1.6.12f
			IF NOT fbMpAxisBasic.Info.ReadyToPowerOn AND eMainAxisStep < STOPPED (* AXIS_STEP_WAIT_FOR_POWER *) AND
				NOT i_pstStatus.q_stMainAxisStatus.q_xInitDone THEN
	
				eMainAxisStep	:= INIT; (* INIT *)
			ELSIF NOT  fbMpAxisBasic.Info.ReadyToPowerOn AND eMainAxisStep 	< STOPPED (* AXIS_STEP_WAIT_FOR_POWER *)
				AND i_pstStatus.q_stMainAxisStatus.q_xInitDone THEN
	
				eMainAxisStep	:= WAIT_FOR_POWER;
			ELSIF NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
				(* Quick/Emergency/Shutdown STOP handling *)
				xCmdStopActive	:= i_pstCmd.i_xShutdown OR i_pstCmd.i_xEmergencyStop OR i_pstCmd.i_xQuickStop OR (xJogActive AND NOT i_pstCmd.i_xJogPositive) OR (xCmdStopActive AND NOT i_pstStatus.q_stMainAxisStatus.q_xStopped);
				IF i_pstParameter.i_xMachineMaster OR (i_pstStatus.q_stMainAxisStatus.q_ePLCopenStatus <> mpAXIS_SYNCHRONIZED_MOTION AND NOT fbMpAxisCyclicSet.CyclicVelocity) THEN
					IF (xCmdStopActive AND (eMainAxisStep >= AXIS_READY AND eMainAxisStep < STOPPED)) THEN//v4.A.A.1.6.12f
						(* Quickstop is the only command that takes effect in AXIS_STEP_READY *)
						IF xJogActive THEN
							rSetDeceleration := i_pstParameter.i_rJogDeceleration;
						ELSIF i_pstCmd.i_xShutdown THEN
							rSetDeceleration := i_pstParameter.i_rShutdownDeceleration;
						ELSIF i_pstCmd.i_xEmergencyStop THEN
							rSetDeceleration := i_pstParameter.i_rEmergencyDeceleration;
						ELSIF i_pstCmd.i_xQuickStop THEN
							rSetDeceleration := i_pstParameter.i_rEmergencyDeceleration;
						END_IF

						IF eMainAxisStep < STOP THEN
							eMainAxisStep 					:= STOP; (*AXIS_STEP_WAIT_FOR_STOP*)
						END_IF
					END_IF
				ELSIF NOT i_pstParameter.i_xMachineMaster AND (i_pstCmd.i_xEmergencyStop OR i_pstCmd.i_xShutdown) AND i_pstStatus.q_stMainAxisStatus.q_xStopped THEN
					IF eMainAxisStep < WAIT_FOR_STOPPED THEN
						eMainAxisStep := WAIT_FOR_STOPPED; (* SHUT DOWN PROCEDURE *)
					END_IF
				END_IF
			END_IF
		END_IF
	END_IF
	
	IF eMainAxisStep > WAIT_FOR_POWER AND eMainAxisStep < AXIS_ERROR AND i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
		(* Torque error limit value refresh *)		
		IF 	rOldTorqueErrorValue <> i_pstParameter.i_rTorqueErrorThreshold THEN
			IF fbWriteParID.ParID = (ACP10PAR_CMP_WINDOW + 0) AND fbWriteParID.Axis = i_pAxisADR AND fbWriteParID.Done THEN
				fbWriteParID.Execute	:= FALSE;
				rOldTorqueErrorValue	:= i_pstParameter.i_rTorqueErrorThreshold;
			ELSIF NOT fbWriteParID.Execute AND NOT fbWriteParID.Busy THEN
				rTempWrite					:= i_pstParameter.i_rTorqueErrorThreshold;
				fbWriteParID.ParID			:= ACP10PAR_CMP_WINDOW + 0;
				fbWriteParID.DataType		:= ncPAR_TYP_REAL;
				fbWriteParID.DataAddress	:= ADR(rTempWrite);
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.Execute		:= TRUE;
			END_IF
		ELSIF rOldLagErrorValue <> i_pstParameter.i_rLagErrorThreshold THEN
			IF fbWriteParID.ParID = (ACP10PAR_CMP_WINDOW + 1) AND fbWriteParID.Axis = i_pAxisADR AND fbWriteParID.Done THEN
				fbWriteParID.Execute	:= FALSE;
				rOldLagErrorValue		:= i_pstParameter.i_rLagErrorThreshold;
			ELSIF NOT fbWriteParID.Execute AND NOT fbWriteParID.Busy THEN
				rTemp						:= i_pstParameter.i_rLagErrorThreshold * c_uiAxisFactor;
				fbWriteParID.ParID			:= ACP10PAR_CMP_WINDOW + 1;
				fbWriteParID.DataType		:= ncPAR_TYP_REAL;
				fbWriteParID.DataAddress	:= ADR(rTemp);
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.Execute		:= TRUE;
			END_IF
		END_IF
	ELSE
		rOldLagErrorValue		:= -9999;
		rOldTorqueErrorValue	:= -9999;
	END_IF
	
	(***** ACCESS TO PARAMETERS *****)
	IF i_xEnable THEN
		IF i_pstParameter.i_prMasterVelocity <> 0 THEN
			prMasterVelocity ACCESS i_pstParameter.i_prMasterVelocity;
		END_IF
		
		IF i_pstParameter.i_plrMasterPosition <> 0 THEN
			plrMasterPosition ACCESS i_pstParameter.i_plrMasterPosition;
		END_IF
		
		IF i_pstParameter.i_pdiMasterScaledPos <> 0 THEN
			pdiMasterScaledPos ACCESS i_pstParameter.i_pdiMasterScaledPos;
		END_IF
	END_IF
	
	(***** MAIN AXIS STATE MACHINE *****)
	CASE eMainAxisStep OF
		DISABLE: (* DISABLE *)
			xFirstHomeDone		:= FALSE;
			xFirstInitDone		:= FALSE;
			xJogActive 			:= FALSE;
			
			i_pstStatus.q_stMainAxisStatus.q_xInitDone		:= FALSE;
			
			lrTotalPhaseOffset			:= 0;
			fbMpAxisBasic.Enable		:= FALSE;
			fbMpAxisBasicConfig.Enable	:= FALSE;
			IF i_xEnable THEN
				eMainAxisStep := INIT;
			END_IF
		
		(***********   INITIALISATION   **************)
		INIT: (* INIT *)
			xFirstInitDone						:= FALSE;
			fbMpAxisBasic.MpLink				:= i_pAxisMpLink;
			fbMpAxisBasic.Axis					:= i_pAxisADR;
			fbMpAxisBasic.Parameters			:= ADR(stBasicParameter);
			fbMpAxisBasicConfig.MpLink			:= i_pAxisMpLink;
			fbMpAxisBasicConfig.Configuration	:= ADR(stBasicConfiguration);
			
			xMasterParIdInitDone	:= FALSE;
			
			stAxis		ACCESS i_pAxisADR;
			IF stAxis.nc_obj_inf.hardware.acp_typ <> ncACP_TYP_PS 	AND
				stAxis.nc_obj_inf.hardware.acp_typ <> ncACP_TYP_PPS	AND 
				NOT i_xInductionMotorType THEN
				
				stBasicParameter.Home.EndlessPositionDataRef := ADR(i_pstAxisHome.stEndlessPositions);
			END_IF
			
			stBasicParameter.CyclicRead.TorqueMode		:= mpAXIS_READ_OFF;
			stBasicParameter.CyclicRead.MotorTempMode	:= mpAXIS_READ_OFF;
			stBasicParameter.CyclicRead.TorqueMode		:= mpAXIS_READ_MULTIPLEXED;
			stBasicParameter.Acceleration				:= i_pstParameter.i_rEndlessAcceleration;
			stBasicParameter.Deceleration				:= MAX(i_pstParameter.i_rShutdownDeceleration, i_pstParameter.i_rEmergencyDeceleration);
						
			fbMpAxisCyclicSet.MpLink					:= i_pAxisMpLink;
			fbMpAxisCyclicSet.Parameters				:= ADR(stCyclicSetParameters);
			fbMpAxisCamSequencer.MpLinkMaster			:= i_pstParameter.i_udiMasterLink;
			fbMpAxisCamSequencer.MpLink					:= i_pAxisMpLink;
			fbMpAxisCamSequencer.Parameters				:= ADR(stCamParameters);
			fbReadCyclicParID.Execute					:= FALSE;
		
			i_pstStatus.q_stMainAxisStatus.q_udiMasterAxisLink	:= i_pstParameter.i_udiMasterLink;
			
			(* Gearing configuration *)
			stCamParameters.PhaseShift.ApplicationMode	:= mpAXIS_SHIFT_TIME_BASE;
			stCamParameters.PhaseShift.Mode				:= mpAXIS_SHIFT_MODE_REL;
			fbMpAxisBasic.Power 						:= FALSE;
			fbMpAxisBasic.Home 							:= FALSE;
			fbMpAxisBasic.MoveVelocity					:= FALSE;
			fbMpAxisBasic.MoveAbsolute 					:= FALSE;
			fbMpAxisBasic.MoveAdditive 					:= FALSE;
			fbMpAxisCamSequencer.StartSequence 			:= FALSE;
			fbMpAxisBasic.Update 						:= FALSE;
			
			fbRTInfo.enable	:= TRUE;
			fbRTInfo();
			
			IF fbRTInfo.status = ERR_OK THEN
				IF i_xInductionMotorType THEN	(* IF INDUCTION GO TO INIT_IND_1 *)
					eMainAxisStep := INIT_IND_1;
				ELSIF i_xThirdPartyMotor THEN	(* IF THIRD PART BRUSHLESS GO TO INIT_THIRD_1 *)
					fbMpAxisBasic.Enable	:= TRUE;
					IF fbMpAxisBasic.Active AND NOT i_xVelocityControl THEN
						eMainAxisStep := INIT_THIRD_1;
					ELSE
						eMainAxisStep		:= INIT_1;
					END_IF
				ELSE
					fbMpAxisBasic.Enable	:= TRUE;
					IF fbMpAxisBasic.Active THEN	
						eMainAxisStep		:= INIT_1;
					END_IF
				END_IF
			END_IF
			
		INIT_1:(* Wait safety Ready *)
			i_pstStatus.q_stMainAxisStatus.q_xAxisReal		:= NOT (fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_VIRTUAL);
			i_pstStatus.q_stMainAxisStatus.q_xPowerSupply	:= (fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_ACOPOSmulti_PPS) OR
																(fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_ACOPOSmulti_PS);
	
			IF i_pstStatus.q_stMainAxisStatus.q_xPowerSupply	OR
				 NOT i_pstStatus.q_stMainAxisStatus.q_xAxisReal OR
				(i_pstStatus.q_stMainAxisStatus.iq_xNotErrEncoder AND i_pstStatus.q_stMainAxisStatus.iq_xOperational) OR
				(i_xVelocityControl) OR
				fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_ACOPOS_SIM THEN
				
				IF i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
					stBasicParameter.CyclicRead.TorqueMode		:= mpAXIS_READ_MULTIPLEXED;
					
					(* Lag error / torque limit status cyclic transmission *)
					fbReadCyclicParID.Axis						:= i_pAxisADR;
					fbReadCyclicParID.DataAddress				:= ADR(usiDrivesStatusBits);
					fbReadCyclicParID.DataType					:= ncPAR_TYP_USINT;
					fbReadCyclicParID.ParID						:= ACP10PAR_BIT_VALUE1_UI1 + 0;
					fbReadCyclicParID.Execute					:= TRUE;
				ELSIF i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
					(* Power fault information cyclic transmission *)
					fbReadCyclicParID.Axis						:= i_pAxisADR;
					fbReadCyclicParID.DataAddress				:= ADR(usiPhaseMonitor);
					fbReadCyclicParID.DataType					:= ncPAR_TYP_USINT;
					fbReadCyclicParID.ParID						:= ACP10PAR_BIT_VALUE1_UI1 + 0;
					fbReadCyclicParID.Execute					:= TRUE;
				END_IF
				
				fbSetOverride.Axis					:= i_pAxisADR;
				fbSetOverride.VelFactor				:= 1.0;
				fbSetOverride.Enable 				:= TRUE;
		
				eMainAxisStep := INIT_2;
			END_IF
		
		INIT_2:
			IF fbReadCyclicParID.Execute THEN
				IF fbReadCyclicParID.Done OR fbReadCyclicParID.Error THEN
					eMainAxisStep := INIT_3;
				END_IF
			ELSE
				eMainAxisStep := INIT_3;
			END_IF
	
		INIT_3:
			fbMpAxisBasicConfig.Enable	:= TRUE;

			IF fbMpAxisBasicConfig.Active THEN
				eMainAxisStep	:= INIT_4;
			END_IF
		
		INIT_4:
			fbMpAxisBasicConfig.Load := TRUE;
		
			IF fbMpAxisBasicConfig.CommandDone THEN
				fbMpAxisBasicConfig.Load := FALSE;
				eMainAxisStep	:= INIT_5;
			END_IF
		
		INIT_5:
			rAxisPeriod := LREAL_TO_REAL(stBasicConfiguration.Axis.PeriodSettings.Period);
			IF stBasicConfiguration.Drive.Controller.Mode <> mpAXIS_CTRL_MODE_POSITION AND stBasicConfiguration.Drive.Controller.Mode <> mpAXIS_CTRL_MODE_POSITION_FF THEN
				stBasicConfiguration.Drive.Controller.Mode := mpAXIS_CTRL_MODE_POSITION;
				xAxisConfigUpdateReq := TRUE;
			END_IF
					
			IF xAxisConfigUpdateReq THEN
				eMainAxisStep			:= INIT_6;
				xAxisConfigUpdateReq	:= FALSE;
			ELSE
				eMainAxisStep	:= INIT_7;
			END_IF

		INIT_6:
			fbMpAxisBasicConfig.Save := TRUE;

			IF fbMpAxisBasicConfig.CommandDone THEN
				fbMpAxisBasicConfig.Save := FALSE;
				eMainAxisStep	:= INIT_7;
			END_IF
	
		INIT_7:
		//	IF fbMpAxisBasic.Info.ReadyToPowerOn THEN  // V 1.1
				fbMpAxisBasicConfig.Enable	:= FALSE;
				fbMpAxisBasic.Update 		:= TRUE;
				eMainAxisStep		 		:= INIT_8;
		//	END_IF // V 1.1
		
		INIT_8:
			IF fbMpAxisBasic.Info.AxisInitialized AND fbMpAxisBasic.UpdateDone THEN
				fbMpAxisBasic.Update :=	FALSE;
				IF NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply AND i_pstStatus.q_stMainAxisStatus.q_xAxisReal THEN
					eMainAxisStep	:= WRITE_I_MAX_ACTION;
				ELSE
					eMainAxisStep	:= WAIT_FOR_POWER; (* WAIT FOR POWER *)
				END_IF
			END_IF
		
		INIT_IND_1:(* Wait safety Ready *)
			i_pstStatus.q_stMainAxisStatus.q_xAxisReal		:= NOT (fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_VIRTUAL);
			i_pstStatus.q_stMainAxisStatus.q_xPowerSupply	:= (fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_ACOPOSmulti_PPS) OR
																(fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_ACOPOSmulti_PS);
	
			IF i_pstStatus.q_stMainAxisStatus.q_xPowerSupply	OR
				NOT i_pstStatus.q_stMainAxisStatus.q_xAxisReal	OR (stAxis.dig_in.status.enable = 1)	OR
				fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_ACOPOS_SIM THEN
				
				IF i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
					stBasicParameter.CyclicRead.TorqueMode		:= mpAXIS_READ_MULTIPLEXED;
					
					(* Induction motor setup *)
					fbDatObjInfo.pName	:= ADR(strDataObjIdent);
					fbDatObjInfo.enable	:= TRUE;					
				ELSIF i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
					(* Power fault information cyclic transmission *)
					fbReadCyclicParID.Axis						:= i_pAxisADR;
					fbReadCyclicParID.DataAddress				:= ADR(usiPhaseMonitor);
					fbReadCyclicParID.DataType					:= ncPAR_TYP_USINT;
					fbReadCyclicParID.ParID						:= ACP10PAR_BIT_VALUE1_UI1 + 0;
					fbReadCyclicParID.Execute					:= TRUE;
				END_IF
				
				fbSetOverride.Axis					:= i_pAxisADR;
				fbSetOverride.VelFactor				:= 1.0;
				fbSetOverride.Enable 				:= TRUE;
		
				eMainAxisStep := INIT_IND_2;
			END_IF
		
		INIT_IND_2:
			IF fbDatObjInfo.enable THEN	
				IF fbDatObjInfo.status = ERR_OK THEN
					eMainAxisStep := INIT_IND_7;
				ELSIF fbDatObjInfo.status = doERR_MODULNOTFOUND THEN
					fbSetupInductionMotor.Axis										:= i_pAxisADR;
					fbSetupInductionMotor.Command									:= mcSTART;
					fbSetupInductionMotor.Configuration.DatObj.Name					:= strDataObjIdent;
					fbSetupInductionMotor.Configuration.DatObj.Type					:= mcDATOBJ;
					fbSetupInductionMotor.Configuration.SetupInductionMotorPar		:= i_pstParameter.i_stInductionMotorConfig;
					fbSetupInductionMotor.Configuration.SetupInductionMotorPar.Mode	:= mcIDENTIFICATION;
					fbSetupInductionMotor.Execute									:= TRUE;
					
					eMainAxisStep := INIT_IND_3;
				END_IF
			ELSE
				eMainAxisStep := INIT_IND_9;
			END_IF
		
		INIT_IND_3:
			fbDatObjInfo.enable := FALSE;
			
			IF fbSetupInductionMotor.Done THEN
				fbSetupInductionMotor.Execute		:= FALSE;
				
				eMainAxisStep := INIT_IND_4;
			END_IF
	
		INIT_IND_4:
			IF NOT fbSetupInductionMotor.Done THEN
				fbSetupInductionMotor.Command		:= mcSAVE;
				fbSetupInductionMotor.Execute		:= TRUE;
				
				eMainAxisStep := INIT_IND_5;
			END_IF
		 
		INIT_IND_5:
			IF fbSetupInductionMotor.Done THEN
				fbSetupInductionMotor.Execute		:= FALSE;
				
				fbDatObjMove.ident		:= fbSetupInductionMotor.SetupOutput.DataObjectIdent;
				fbDatObjMove.MemType	:= doUSRROM;
				fbDatObjMove.enable		:= TRUE;
				
				eMainAxisStep := INIT_IND_6;
			END_IF
		
		INIT_IND_6:
			IF fbDatObjMove.status = ERR_OK THEN
				fbDatObjMove.enable	:= FALSE;
				
				eMainAxisStep := INIT_IND_9;
			END_IF
		
		INIT_IND_7:
			fbDatObjInfo.enable	:= FALSE;
			
			fbInitParTabObj.Axis			:= i_pAxisADR;
			fbInitParTabObj.DataObjectName	:= strDataObjIdent;
			fbInitParTabObj.Execute			:= TRUE;
			eMainAxisStep := INIT_IND_8;
		
		INIT_IND_8:
			IF fbInitParTabObj.Done THEN
				fbInitParTabObj.Execute	:= FALSE;

				eMainAxisStep := INIT_IND_9;
			END_IF
		
		INIT_IND_9:
			fbMpAxisBasic.Enable	:= TRUE;
					
			IF fbMpAxisBasic.Active THEN
				eMainAxisStep := INIT_IND_10;
			END_IF
		
		INIT_IND_10:	 //Lag error / torque limit status cyclic transmission 
			fbReadCyclicParID.Axis			:= i_pAxisADR;
			fbReadCyclicParID.DataAddress	:= ADR(usiDrivesStatusBits);
			fbReadCyclicParID.DataType		:= ncPAR_TYP_USINT;
			fbReadCyclicParID.ParID			:= ACP10PAR_BIT_VALUE1_UI1 + 0;
			fbReadCyclicParID.Execute		:= TRUE;
			
			IF fbReadCyclicParID.Execute THEN
				IF fbReadCyclicParID.Done OR fbReadCyclicParID.Error THEN
					eMainAxisStep := INIT_IND_11;
				END_IF
			ELSE
				eMainAxisStep := INIT_IND_11;
			END_IF
	
		INIT_IND_11:
			fbMpAxisBasic.Update :=	TRUE;
			
			IF fbMpAxisBasic.Info.AxisInitialized AND fbMpAxisBasic.UpdateDone THEN
				eMainAxisStep		 := INIT_IND_12;
			END_IF
	
		INIT_IND_12:
			fbMpAxisBasic.Update 		:= FALSE;
			fbMpAxisBasicConfig.Enable	:= TRUE;

			IF fbMpAxisBasicConfig.Active THEN
				eMainAxisStep	:= INIT_IND_13;
			END_IF
		
		INIT_IND_13:
			fbMpAxisBasicConfig.Load := TRUE;
		
			IF fbMpAxisBasicConfig.CommandDone THEN
				fbMpAxisBasicConfig.Load := FALSE;
				eMainAxisStep	:= INIT_IND_14;
			END_IF
		
		INIT_IND_14:			
			IF stBasicConfiguration.Drive.Controller.Mode <> mpAXIS_CTRL_MODE_UF THEN
				stBasicConfiguration.Drive.Controller.Mode := mpAXIS_CTRL_MODE_UF;
				xAxisConfigUpdateReq := TRUE;
			END_IF
			
			IF stBasicConfiguration.Drive.Controller.VoltageFrequency.Type <> mpAXIS_CTRL_UF_LINEAR2 THEN
				stBasicConfiguration.Drive.Controller.VoltageFrequency.Type := mpAXIS_CTRL_UF_LINEAR2 ;
				xAxisConfigUpdateReq := TRUE;
			END_IF
		
			IF xAxisConfigUpdateReq THEN
				eMainAxisStep			:= INIT_IND_15;
				xAxisConfigUpdateReq	:= FALSE;
			ELSE
				eMainAxisStep	:= INIT_IND_17;
			END_IF

		INIT_IND_15:
			fbMpAxisBasicConfig.Save := TRUE;

			IF fbMpAxisBasicConfig.CommandDone THEN
				fbMpAxisBasicConfig.Save := FALSE;
				eMainAxisStep	:= INIT_IND_16;
			END_IF
		
		INIT_IND_16:
			fbMpAxisBasicConfig.Enable	:= FALSE;
			fbMpAxisBasic.Update :=	TRUE;
			
			IF fbMpAxisBasic.Info.AxisInitialized AND fbMpAxisBasic.UpdateDone THEN
				eMainAxisStep		 := INIT_IND_17;
			END_IF
		
		INIT_IND_17:
			IF fbMpAxisBasic.Info.ReadyToPowerOn THEN
				IF NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply AND i_pstStatus.q_stMainAxisStatus.q_xAxisReal THEN
					eMainAxisStep	:= WRITE_I_MAX_ACTION;
				ELSE
					eMainAxisStep	:= WAIT_FOR_POWER;
				END_IF
			END_IF
		
		INIT_THIRD_1:(* Wait safety Ready *)
			i_pstStatus.q_stMainAxisStatus.q_xAxisReal		:= NOT (fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_VIRTUAL);
			i_pstStatus.q_stMainAxisStatus.q_xPowerSupply	:= (fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_ACOPOSmulti_PPS) OR
			(fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_ACOPOSmulti_PS);
	
			IF i_pstStatus.q_stMainAxisStatus.q_xPowerSupply	OR
				NOT i_pstStatus.q_stMainAxisStatus.q_xAxisReal OR
				(i_pstStatus.q_stMainAxisStatus.iq_xNotErrEncoder AND i_pstStatus.q_stMainAxisStatus.iq_xOperational) OR
				(i_xVelocityControl) OR
				fbMpAxisBasic.Info.HardwareInfo.DeviceType	= mpAXIS_ACOPOS_SIM THEN
				
				IF i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
					stBasicParameter.CyclicRead.TorqueMode		:= mpAXIS_READ_MULTIPLEXED;
					
					(* Third Party motor setup *)
					fbDatObjInfo.pName	:= ADR(strDataObjPhasing);
					fbDatObjInfo.enable	:= TRUE;					
				ELSIF i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
					(* Power fault information cyclic transmission *)
					fbReadCyclicParID.Axis						:= i_pAxisADR;
					fbReadCyclicParID.DataAddress				:= ADR(usiPhaseMonitor);
					fbReadCyclicParID.DataType					:= ncPAR_TYP_USINT;
					fbReadCyclicParID.ParID						:= ACP10PAR_BIT_VALUE1_UI1 + 0;
					fbReadCyclicParID.Execute					:= TRUE;
				END_IF
				
				fbSetOverride.Axis					:= i_pAxisADR;
				fbSetOverride.VelFactor				:= 1.0;
				fbSetOverride.Enable 				:= TRUE;
		
				eMainAxisStep := INIT_THIRD_2;
			END_IF
		
		INIT_THIRD_2:
			IF fbDatObjInfo.enable THEN	
				IF fbDatObjInfo.status = ERR_OK THEN
					eMainAxisStep := INIT_THIRD_3;
				ELSIF fbDatObjInfo.status = doERR_MODULNOTFOUND THEN
					//i_pstStatus.q_stMainAxisStatus.q_xMotorPhasingError:= TRUE;
					eMainAxisStep := INIT_THIRD_5;
				END_IF
			ELSE
				eMainAxisStep := INIT_THIRD_5;
			END_IF
		
		INIT_THIRD_3:
			fbDatObjInfo.enable	:= FALSE;
			
			fbInitParTabObj.Axis			:= i_pAxisADR;
			fbInitParTabObj.DataObjectName	:= strDataObjPhasing;
			fbInitParTabObj.Execute			:= TRUE;
			eMainAxisStep := INIT_THIRD_4;

		INIT_THIRD_4:
			IF fbInitParTabObj.Done THEN
				fbInitParTabObj.Execute	:= FALSE;

				eMainAxisStep := INIT_THIRD_5;
			END_IF
		
		INIT_THIRD_5:
			fbMpAxisBasic.Enable	:= TRUE;
			
			(* Lag error / torque limit status cyclic transmission *)
			fbReadCyclicParID.Axis						:= i_pAxisADR;
			fbReadCyclicParID.DataAddress				:= ADR(usiDrivesStatusBits);
			fbReadCyclicParID.DataType					:= ncPAR_TYP_USINT;
			fbReadCyclicParID.ParID						:= ACP10PAR_BIT_VALUE1_UI1 + 0;
			fbReadCyclicParID.Execute					:= TRUE;
			
			IF fbMpAxisBasic.Active THEN
				eMainAxisStep := INIT_THIRD_6;
			END_IF
		
		INIT_THIRD_6:
			IF fbReadCyclicParID.Execute THEN
				IF fbReadCyclicParID.Done OR fbReadCyclicParID.Error THEN
					eMainAxisStep := INIT_THIRD_7;
				END_IF
			ELSE
				eMainAxisStep := INIT_THIRD_7;
			END_IF
		
		INIT_THIRD_7:
			fbMpAxisBasicConfig.Enable	:= TRUE;

			IF fbMpAxisBasicConfig.Active THEN
				eMainAxisStep	:= INIT_THIRD_8;
			END_IF
		
		INIT_THIRD_8:
			fbMpAxisBasicConfig.Load := TRUE;
		
			IF fbMpAxisBasicConfig.CommandDone THEN
				fbMpAxisBasicConfig.Load := FALSE;
				eMainAxisStep	:= INIT_THIRD_9;
			END_IF
		
		INIT_THIRD_9:
			rAxisPeriod := LREAL_TO_REAL(stBasicConfiguration.Axis.PeriodSettings.Period);
			IF stBasicConfiguration.Drive.Controller.Mode <> mpAXIS_CTRL_MODE_POSITION OR stBasicConfiguration.Drive.Controller.Mode <> mpAXIS_CTRL_MODE_POSITION_FF THEN
				stBasicConfiguration.Drive.Controller.Mode := mpAXIS_CTRL_MODE_POSITION;
				xAxisConfigUpdateReq := TRUE;
			END_IF
					
			IF xAxisConfigUpdateReq THEN
				eMainAxisStep			:= INIT_THIRD_10;
				xAxisConfigUpdateReq	:= FALSE;
			ELSE
				eMainAxisStep	:= INIT_THIRD_11;
			END_IF

		INIT_THIRD_10:
			fbMpAxisBasicConfig.Save := TRUE;

			IF fbMpAxisBasicConfig.CommandDone THEN
				fbMpAxisBasicConfig.Save := FALSE;
				eMainAxisStep	:= INIT_THIRD_11;
			END_IF		
		
		INIT_THIRD_11:
			fbMpAxisBasic.Update		:= TRUE;
			fbMpAxisBasicConfig.Enable	:= FALSE;
			IF fbMpAxisBasic.Info.AxisInitialized AND fbMpAxisBasic.UpdateDone THEN
				fbMpAxisBasic.Update :=	FALSE;
				eMainAxisStep		 := INIT_THIRD_13;
			END_IF
		
		INIT_THIRD_13:
			IF fbMpAxisBasic.Info.ReadyToPowerOn THEN
				fbWriteParID.Execute	:= FALSE;
				IF NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply AND i_pstStatus.q_stMainAxisStatus.q_xAxisReal THEN
					eMainAxisStep	:= WRITE_I_MAX_ACTION;
				ELSE
					eMainAxisStep	:= WAIT_FOR_POWER; (* WAIT FOR POWER *)
				END_IF
			END_IF
		
		WRITE_I_MAX_ACTION:
			rTempTorque							:= 50000;
			stAxis.controller.position.i_max	:= 50000;
			
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done THEN
				fbWriteParID.Axis				:= i_pAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_POS_CTRL_I_MAX;
				fbWriteParID.DataAddress		:= ADR(rTempTorque);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
			
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_POS_CTRL_I_MAX AND (fbWriteParID.Axis = i_pAxisADR) THEN
				fbWriteParID.Execute	:= FALSE;
				eMainAxisStep 			:= READ_BRAKE_PARID;
			END_IF
		
		READ_BRAKE_PARID:
			IF NOT fbReadParID.Execute AND NOT fbReadParID.Done	THEN
				fbReadParID.Axis				:= i_pAxisADR;
				fbReadParID.ParID				:= ACP10PAR_BRAKE_MODE;
				fbReadParID.DataAddress			:= ADR(uiBrakeParID);
				fbReadParID.DataType			:= ncPAR_TYP_UINT;
			
				fbReadParID.Execute				:= TRUE;
			ELSIF fbReadParID.Done AND fbReadParID.ParID = ACP10PAR_BRAKE_MODE AND (fbReadParID.Axis = i_pAxisADR) THEN
				i_pstStatus.q_stMainAxisStatus.q_xMotorWithBrake	:= (uiBrakeParID <> 0);
				
				fbReadParID.Execute				:= FALSE;
				eMainAxisStep 					:= READ_ACP_PARID;
			END_IF
		
		READ_ACP_PARID:(* READ ACOPOS PARAMETER TO ESTIMATE THE MAXIMUM TORQUE *)
			IF NOT fbReadParID.Execute AND NOT fbReadParID.Done	THEN
				fbReadParID.Axis				:= i_pAxisADR;
				fbReadParID.ParID				:= ACP10PAR_MOTOR_TORQ_MAX;
				fbReadParID.DataAddress			:= ADR(rM_Max);
				fbReadParID.DataType			:= ncPAR_TYP_REAL;
			
				fbReadParID.Execute				:= TRUE;
			ELSIF fbReadParID.Done AND fbReadParID.ParID = ACP10PAR_MOTOR_TORQ_MAX AND (fbReadParID.Axis = i_pAxisADR) THEN
				fbReadParID.Execute				:= FALSE;
				eMainAxisStep					:= READ_ACP_PARID_1;
			END_IF
		
		READ_ACP_PARID_1:
			IF NOT fbReadParID.Execute AND NOT fbReadParID.Done	THEN
				fbReadParID.Axis				:= i_pAxisADR;
				fbReadParID.ParID				:= ACP10PAR_MOTOR_TORQ_STALL;
				fbReadParID.DataAddress			:= ADR(rM_0);
				fbReadParID.DataType			:= ncPAR_TYP_REAL;
			
				fbReadParID.Execute				:= TRUE;
			ELSIF fbReadParID.Done AND fbReadParID.ParID = ACP10PAR_MOTOR_TORQ_STALL AND (fbReadParID.Axis = i_pAxisADR) THEN
				fbReadParID.Execute				:= FALSE;
				eMainAxisStep					:= READ_ACP_PARID_2;
			END_IF
		
		READ_ACP_PARID_2:
			IF NOT fbReadParID.Execute AND NOT fbReadParID.Done	THEN
				fbReadParID.Axis				:= i_pAxisADR;
				fbReadParID.ParID				:= ACP10PAR_MOTOR_CURR_MAX;
				fbReadParID.DataAddress			:= ADR(rI_Max);
				fbReadParID.DataType			:= ncPAR_TYP_REAL;
			
				fbReadParID.Execute				:= TRUE;
			ELSIF fbReadParID.Done AND fbReadParID.ParID = ACP10PAR_MOTOR_CURR_MAX AND (fbReadParID.Axis = i_pAxisADR) THEN
				fbReadParID.Execute				:= FALSE;
				eMainAxisStep					:= READ_ACP_PARID_3;
			END_IF
		
		READ_ACP_PARID_3:
			IF NOT fbReadParID.Execute AND NOT fbReadParID.Done	THEN
				fbReadParID.Axis				:= i_pAxisADR;
				fbReadParID.ParID				:= ACP10PAR_MOTOR_CURR_STALL;
				fbReadParID.DataAddress			:= ADR(rI_0);
				fbReadParID.DataType			:= ncPAR_TYP_REAL;
			
				fbReadParID.Execute				:= TRUE;
			ELSIF fbReadParID.Done AND fbReadParID.ParID = ACP10PAR_MOTOR_CURR_STALL AND (fbReadParID.Axis = i_pAxisADR) THEN
				fbReadParID.Execute				:= FALSE;
				eMainAxisStep 					:= READ_ACP_PARID_4;
			END_IF
		
		READ_ACP_PARID_4:
			IF NOT fbReadParID.Execute AND NOT fbReadParID.Done	THEN
				fbReadParID.Axis				:= i_pAxisADR;
				fbReadParID.ParID				:= ACP10PAR_ACOPOS_CURR_MAX;
				fbReadParID.DataAddress			:= ADR(rI_Max_ACP);
				fbReadParID.DataType			:= ncPAR_TYP_REAL;
			
				fbReadParID.Execute				:= TRUE;
			ELSIF fbReadParID.Done AND fbReadParID.ParID = ACP10PAR_ACOPOS_CURR_MAX AND (fbReadParID.Axis = i_pAxisADR) THEN
				fbReadParID.Execute				:= FALSE;
				eMainAxisStep					:= MAX_TORQUE_CALCULATION;
			END_IF
		
		MAX_TORQUE_CALCULATION:(* MAXIMUM TORQUE CALCULATION *)
			rM_Max_ACP				:= rM_0 + (rM_Max - rM_0) * (rI_Max_ACP - rI_0) / (rI_Max - rI_0);
			rTorqueLimit			:= MIN(rM_Max_ACP, rM_Max);
			rTorqueLimitSecondary	:= rTorqueLimit;

			IF i_pstParameter.i_rMaxGearboxTorque < rTorqueLimit THEN
				rTorqueLimit	:= MAX(i_pstParameter.i_rMaxGearboxTorque, 0.5);
				eMainAxisStep 	:= SET_TORQUE_LIMIT;
			ELSE
				eMainAxisStep	:= OPEN_POSITION_LOOP; (* WAIT FOR POWER *)
			END_IF
		
		SET_TORQUE_LIMIT: (* SET THE TORQUE LIMIT *)
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done THEN
				fbWriteParID.Axis				:= i_pAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_LIM_T1_POS;
				fbWriteParID.DataAddress		:= ADR(rTorqueLimit);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
			
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_LIM_T1_POS AND (fbWriteParID.Axis = i_pAxisADR) THEN
				fbWriteParID.Execute			:= FALSE;
				eMainAxisStep 					:= SET_TORQUE_LIMIT_1;
			END_IF
		
		SET_TORQUE_LIMIT_1:
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done THEN
				fbWriteParID.Axis				:= i_pAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_LIM_T1_NEG;
				fbWriteParID.DataAddress		:= ADR(rTorqueLimit);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
			
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_LIM_T1_NEG AND (fbWriteParID.Axis = i_pAxisADR) THEN
				fbWriteParID.Execute			:= FALSE;
				eMainAxisStep 					:= SET_TORQUE_LIMIT_2;
			END_IF
		
		SET_TORQUE_LIMIT_2:
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done THEN
				fbWriteParID.Axis				:= i_pAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_LIM_T2_POS;
				fbWriteParID.DataAddress		:= ADR(rTorqueLimit);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
			
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_LIM_T2_POS AND (fbWriteParID.Axis = i_pAxisADR) THEN
				fbWriteParID.Execute			:= FALSE;
				eMainAxisStep 					:= SET_TORQUE_LIMIT_3;
			END_IF
		
		SET_TORQUE_LIMIT_3:
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done  THEN
				fbWriteParID.Axis				:= i_pAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_LIM_T2_NEG;
				fbWriteParID.DataAddress		:= ADR(rTorqueLimit);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
			
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_LIM_T2_NEG AND (fbWriteParID.Axis = i_pAxisADR) THEN
				fbWriteParID.Execute			:= FALSE;
				eMainAxisStep					:= SET_TORQUE_LIMIT_4;
			END_IF
		
		SET_TORQUE_LIMIT_4:
			rTempTorque :=	rTorqueLimit / 4;
			
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done THEN
				fbWriteParID.Axis				:= i_pAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_KSCTRL_TORQUE_LIM;
				fbWriteParID.DataAddress		:= ADR(rTempTorque);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
			
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_KSCTRL_TORQUE_LIM AND (fbWriteParID.Axis = i_pAxisADR) THEN
				fbWriteParID.Execute			:= FALSE;
				eMainAxisStep					:= OPEN_POSITION_LOOP;
			END_IF
				
		OPEN_POSITION_LOOP:
			IF i_pSecondaryAxisADR = 0 OR (eSecondaryAxisStep >= S_WAIT_FOR_POWER AND eSecondaryAxisStep < S_AXIS_ERROR) THEN
				IF i_xVelocityControl AND NOT i_xThirdPartyMotor THEN
					uiTemp	:= ACP10PAR_PCTRL_S_SET;
					IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done THEN
						fbWriteParID.Axis				:= i_pAxisADR;
						fbWriteParID.ParID				:= ACP10PAR_PCTRL_S_ACT_PARID;
						fbWriteParID.DataAddress		:= ADR(uiTemp);
						fbWriteParID.DataType			:= ncPAR_TYP_UINT;
					
						fbWriteParID.Execute			:= TRUE;
					ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_PCTRL_S_ACT_PARID AND (fbWriteParID.Axis = i_pAxisADR) THEN
						fbWriteParID.Execute			:= FALSE;
						eMainAxisStep					:= WAIT_FOR_POWER;
					END_IF
				ELSIF i_xVelocityControl AND i_xThirdPartyMotor THEN
					uiTemp	:= ACP10PAR_ENCOD0_S_ACT;
					IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done THEN
						fbWriteParID.Axis				:= i_pAxisADR;
						fbWriteParID.ParID				:= ACP10PAR_PCTRL_S_ACT_PARID;
						fbWriteParID.DataAddress		:= ADR(uiTemp);
						fbWriteParID.DataType			:= ncPAR_TYP_UINT;
					
						fbWriteParID.Execute			:= TRUE;
					ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_PCTRL_S_ACT_PARID AND (fbWriteParID.Axis = i_pAxisADR) THEN
						fbWriteParID.Execute			:= FALSE;
						eMainAxisStep					:= WAIT_FOR_POWER;
					END_IF
				ELSE
					eMainAxisStep := WAIT_FOR_POWER;
				END_IF
			END_IF
		(*************************************************)
		
		BRAKE_RELEASE:
			IF fbMpAxisBasic.BrakeReleased AND (fbMpAxisBasicSecondary.BrakeReleased OR i_pSecondaryAxisADR = 0) THEN
				i_pstStatus.q_stMainAxisStatus.q_xBrakeReleased		:= TRUE;
				IF NOT i_pstCmd.i_xReleaseBrake THEN
					fbMpAxisBasic.ReleaseBrake 			:= FALSE;
					fbMpAxisBasicSecondary.ReleaseBrake	:= FALSE;
					
					eMainAxisStep						:= BRAKE_RELEASE_1;
				END_IF
			END_IF
		
		BRAKE_RELEASE_1:
			IF NOT fbMpAxisBasic.BrakeReleased AND NOT fbMpAxisBasicSecondary.BrakeReleased THEN
				i_pstStatus.q_stMainAxisStatus.q_xBrakeReleased		:= FALSE;
				eMainAxisStep := WAIT_FOR_POWER;
			END_IF
		
		WAIT_FOR_POWER:
			fbSetOverride.Enable 	:= TRUE;
			tonStep(IN := FALSE);
			tonStep(PT := t#1s);
		
			fbMpAxisBasic.Power 			:= FALSE;
			fbMpAxisBasic.MoveAdditive		:= FALSE;
			i_pstStatus.q_stMainAxisStatus.q_xInitDone			:= TRUE;  //V 1.1
			i_pstStatus.q_stMainAxisStatus.q_xPhasingRunning	:= FALSE;
			
			(* The init is done in case of axis error isn't necessary to perform again the init cycle *)
			xMasterParIdInitDone	:= TRUE;
			
			(* Handle an alarm in case of not ReadyToPowerOn *)
			IF fbMpAxisBasic.Info.ReadyToPowerOn THEN
				IF (NOT i_pstCmd.i_xShutdown 					AND
					NOT i_pstCmd.i_xEmergencyStop				OR
					i_pstStatus.q_stMainAxisStatus.q_xPowerSupply) THEN
			
					(* Init of the velocity control *)
					IF i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply AND i_xVelocityControl THEN
						stCyclicSetParameters.Acceleration			:= MAX(i_pstParameter.i_rEmergencyDeceleration, i_pstParameter.i_rShutdownDeceleration) * (2 * LIMIT(0, i_pstParameter.i_rVelocityOffsetFactor, 1) + 1 );
						stCyclicSetParameters.Deceleration			:= stCyclicSetParameters.Acceleration;
						stCyclicSetParameters.VelocityModeDirection	:= mpAXIS_DIR_POSITIVE;
					END_IF
					
					tonStep(IN := FALSE);
					fbMpAxisBasic.Power := TRUE;
					eMainAxisStep 		:= POWERING;
				END_IF
			ELSIF i_pstCmd.i_xReleaseBrake AND i_pstStatus.q_stMainAxisStatus.q_xMotorWithBrake THEN (* Brake management *)
				fbMpAxisBasic.ReleaseBrake 				:= TRUE;
				fbMpAxisBasicSecondary.ReleaseBrake		:= (i_pSecondaryAxisADR <> 0);
				
				eMainAxisStep	:= BRAKE_RELEASE;
			END_IF
				
		POWERING:(* POWERING *)
			tonStep(IN := fbMpAxisBasic.PowerOn, PT := t#20s);

			IF fbMpAxisBasic.PowerOn THEN
				IF fbMpAxisBasic.IsHomed OR i_pstStatus.q_stMainAxisStatus.q_xPowerSupply OR i_xVelocityControl THEN
					xFirstHomeDone		:= TRUE;
					(* The endless position was succesfully restored *)
					eMainAxisStep := WAIT_SECONDARY_AXIS_READY; (* AXIS READY *)
				ELSIF tonStep.Q THEN
					IF xFirstHomeDone THEN
						eMainAxisStep	:= HOME_RECOVERY;
					ELSE
						(* Home the axis manually *)
						fbMpAxisBasic.Home 			:= TRUE;
						i_pstAxisHome.xHomeValid	:= FALSE;
						stBasicParameter.Home.Mode	:= mpAXIS_HOME_MODE_DIRECT;
						eMainAxisStep 				:= SYSTEM_HOMING;(* WAITING HOMING COMMAND *)
					END_IF
				END_IF
			END_IF
	
		HOME_RECOVERY:
			stBasicParameter.Home.Mode	:= mpAXIS_HOME_MODE_RESTORE_POS;
			fbMpAxisBasic.Home 			:= TRUE;
			eMainAxisStep 				:= SYSTEM_HOMING;
		
		SYSTEM_HOMING:(* HOMING *)
			IF fbMpAxisBasic.IsHomed THEN
				xFirstHomeDone				:= TRUE;
				fbMpAxisBasic.Home 			:= FALSE;
				stBasicParameter.Home.Mode	:= mpAXIS_HOME_MODE_DIRECT;
				eMainAxisStep 				:= WAIT_SECONDARY_AXIS_READY;
			END_IF
		
		WAIT_SECONDARY_AXIS_READY:(* WAIT UNTIL THE SECONDARY AXIS IS READY *)
			IF i_pSecondaryAxisADR = 0 OR eSecondaryAxisStep = S_READY OR eSecondaryAxisStep = S_WAIT_FOR_TORQUE_RAMP THEN
				IF fbMpAxisCamSequencer.Update THEN
					fbMpAxisCamSequencer.Update							:= FALSE;
					i_pstStatus.q_stMainAxisStatus.q_udiMasterAxisLink	:= 0;
				END_IF
				
				IF NOT fbMpAxisCamSequencer.UpdateDone THEN
					eMainAxisStep := AXIS_READY;//v4.A.A.1.6.12f
				END_IF
			END_IF
		
		AXIS_READY: (* READY *)//v4.A.A.1.6.12f
			xJogActive 					:= FALSE;
			
			i_pstStatus.q_stMainAxisStatus.q_xOnePitchShiftDone	:= FALSE;
			i_pstStatus.q_stMainAxisStatus.q_xPhasingRunning	:= FALSE;
			i_pstStatus.q_stMainAxisStatus.q_xInitDone			:= TRUE;
			
			stBasicParameter.Direction	:= mpAXIS_DIR_POSITIVE;
			
			tonPowerOn(IN := fbMpAxisBasic.PowerOn, PT:= t#3s);
			
			IF i_xVelocityControl AND tonPowerOn.Q THEN
				fbMpAxisBasic.Power := FALSE;
			END_IF
			
			IF NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
				IF i_pstCmd.i_xDisableAxis THEN
					xAxisDisabled	:= i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply;
				ELSE
					IF ABS(prMasterVelocity) <= i_pstParameter.i_rRunningThreshold THEN
						xAxisDisabled	:= FALSE;
					END_IF
				END_IF
			END_IF
			
			IF NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply AND NOT xAxisDisabled THEN
				(* Axis master management *)
				IF i_pstParameter.i_udiMasterLink <> i_pstStatus.q_stMainAxisStatus.q_udiMasterAxisLink THEN
					fbMpAxisCamSequencer.MpLinkMaster	:= i_pstParameter.i_udiMasterLink;
					fbMpAxisCamSequencer.Update			:= FALSE;
					IF fbMpAxisCamSequencer.Enable AND NOT fbMpAxisCamSequencer.Update AND NOT fbMpAxisCamSequencer.UpdateDone THEN
						fbMpAxisCamSequencer.Update		:= TRUE;
						IF fbMpAxisCamSequencer.UpdateDone THEN
							fbMpAxisCamSequencer.Update	:= FALSE;
							i_pstStatus.q_stMainAxisStatus.q_udiMasterAxisLink	:= i_pstParameter.i_udiMasterLink;
						END_IF
					ELSE
						i_pstStatus.q_stMainAxisStatus.q_udiMasterAxisLink	:= i_pstParameter.i_udiMasterLink;
					END_IF
				ELSE
					IF fbMpAxisCamSequencer.Standby THEN
						fbMpAxisCamSequencer.EndSequence	:= TRUE;
					ELSE
						fbMpAxisCamSequencer.EndSequence	:= FALSE;
					END_IF
					
					stBasicParameter.Acceleration		:= i_pstParameter.i_rEndlessAcceleration;
					stBasicParameter.Deceleration		:= MAX(i_pstParameter.i_rShutdownDeceleration, i_pstParameter.i_rEmergencyDeceleration);
					
					IF i_pstCmd.i_xPhaseCompensation AND lrTotalPhaseOffset <> 0 THEN
						eMainAxisStep	 				:= PHASE_COMPENSATION; (* PHASE COMPENSATION *)
					ELSIF i_pstCmd.i_xMoveVelocity THEN
						rSetAcceleration 				:= i_pstParameter.i_rEndlessAcceleration;
						rSetDeceleration			 	:= i_pstParameter.i_rEndlessDeceleration;
						stBasicParameter.Velocity		:= i_pstParameter.i_rEndlessVelocity;
						
						eMainAxisStep	 				:= ENDLESS_RUN1;	(* ENDLESS RUN *)
					ELSIF i_pstCmd.i_xMoveAdditive AND i_xToken THEN
						fbMpAxisBasic.MoveAdditive		:= FALSE;
						stBasicParameter.Acceleration	:= i_pstParameter.i_rPositioningAccDec;//V4.A.A.1.7.0
						stBasicParameter.Velocity		:= i_pstParameter.i_rPositioningVelocity;
						stBasicParameter.Distance		:= i_pstParameter.i_lrAdditiveDistance;
						stBasicParameter.Deceleration	:= stBasicParameter.Acceleration;
						stBasicParameter.Direction		:= mpAXIS_DIR_POSITIVE;
						
						eMainAxisStep					:= MOVE_ADDITIVE; (* MOVE ADDITIVE *)
					ELSIF i_pstCmd.i_xJogPositive THEN
						rSetAcceleration 				:= i_pstParameter.i_rEndlessAcceleration;
						rSetDeceleration			 	:= i_pstParameter.i_rEmergencyDeceleration;
						stBasicParameter.Velocity		:= i_pstParameter.i_rJogVelocity;
						
						eMainAxisStep	 				:= JOG_POSITIVE; (* Jog *)
					ELSIF i_pstCmd.i_xSlowMotionFwd OR i_pstCmd.i_xSlowMotionBwd THEN
						IF NOT fbMpAxisBasic.Update AND NOT fbMpAxisBasic.UpdateDone THEN
							eMainAxisStep	 				:= SLOW_MOTION;	(* Slow motion *)
							fbMpAxisBasic.MoveVelocity		:= TRUE;
						END_IF
					ELSIF i_pstCmd.i_xGear AND
							ADR(i_pstParameter.i_prMasterVelocity)	<> 0	AND
							ADR(i_pstParameter.i_plrMasterPosition)	<> 0	AND
							i_pstParameter.i_udiMasterLink			<> 0	THEN
	
						rSetAcceleration			 	:= i_pstParameter.i_rPositioningAccDec;
						stBasicParameter.Velocity		:= i_pstParameter.i_rPositioningVelocity;
		
						IF i_xVelocityControl THEN
							eMainAxisStep	:= GEAR_VELOCITY;
						ELSE
							eMainAxisStep	:= GEAR;
						END_IF
					ELSIF i_pstCmd.i_xHome THEN
						fbMpAxisBasic.Home				:= FALSE;
						i_pstAxisHome.xHomeValid		:= FALSE;
						eMainAxisStep	 				:= HOMING_1;
					ELSIF i_pstCmd.i_xInductionMotorSetup AND i_xInductionMotorType THEN
						eMainAxisStep	:= INDUCTION_MOTOR_SETUP;
					ELSIF i_pstCmd.i_xThirdPartySetup AND i_xThirdPartyMotor THEN
						eMainAxisStep	:= MOTOR_PHASING;
					END_IF
				END_IF
			END_IF
					
		ENDLESS_RUN1: (* ENDLESS RUN *)
			IF i_xInductionMotorType THEN
				fbMpAxisBasic.Power	:= TRUE;
				eMainAxisStep 		:= ENDLESS_RUN2;
			ELSE		
				eMainAxisStep 		:= ENDLESS_RUN2;
			END_IF
		
		ENDLESS_RUN2: (* ENDLESS RUN *)
			IF NOT fbMpAxisBasic.Update AND NOT fbMpAxisBasic.UpdateDone AND fbMpAxisBasic.PowerOn THEN
				fbMpAxisBasic.MoveVelocity		:= TRUE;
			END_IF
			
			IF i_pstCmd.i_xMoveVelocity  AND fbMpAxisBasic.Info.PLCopenState = mpAXIS_CONTINUOUS_MOTION THEN
				fbMpAxisCamSequencer.StartSequence 	:= FALSE;
			
				stBasicParameter.Acceleration	:= i_pstParameter.i_rEndlessAcceleration;
				stBasicParameter.Deceleration	:= MAX(i_pstParameter.i_rShutdownDeceleration, i_pstParameter.i_rEmergencyDeceleration);
				rSetAcceleration			 	:= i_pstParameter.i_rEndlessAcceleration;
				
				IF i_xVelocityControl THEN
					rSetDeceleration := i_pstParameter.i_rEmergencyDeceleration;
				ELSE
					rSetDeceleration := i_pstParameter.i_rEndlessDeceleration;
				END_IF
				
				stBasicParameter.Velocity := i_pstParameter.i_rEndlessVelocity;
			END_IF
			
			IF i_pstCmd.i_xGear AND NOT i_pstCmd.i_xMoveVelocity THEN
				eMainAxisStep	 := GEAR;
			ELSIF NOT i_pstCmd.i_xGear AND NOT i_pstCmd.i_xMoveVelocity THEN
				IF NOT i_xVelocityControl THEN
					eMainAxisStep	:= STOP;
				ELSE
					eMainAxisStep	:= ENDLESS_GEAR_STOP;
				END_IF
			END_IF
		
		ENDLESS_GEAR_STOP:
			rSetDeceleration			 	:= i_pstParameter.i_rEmergencyDeceleration;
			stBasicParameter.Velocity		:= 0.0;
		
			IF i_pstStatus.q_stMainAxisStatus.q_xStopped THEN
				eMainAxisStep	:= STOP;
			END_IF
		
		SLOW_MOTION: (* SLOW MOTION *)
			stBasicParameter.Acceleration		:= i_pstParameter.i_rSlowMotionAcceleration;
			stBasicParameter.Deceleration		:= MAX(i_pstParameter.i_rShutdownDeceleration, i_pstParameter.i_rEmergencyDeceleration);
					
			rSetAcceleration 				:= i_pstParameter.i_rSlowMotionAcceleration;
			rSetDeceleration			 	:= i_pstParameter.i_rEmergencyDeceleration;
			stBasicParameter.Velocity		:= i_pstParameter.i_rSlowMotionVelocity;
			
			IF i_pstCmd.i_xSlowMotionFwd AND NOT i_pstCmd.i_xSlowMotionBwd THEN
				stBasicParameter.Direction := mpAXIS_DIR_POSITIVE;
				IF NOT fbMpAxisBasic.Update AND NOT fbMpAxisBasic.UpdateDone THEN
					fbMpAxisBasic.MoveVelocity	:= TRUE;
				END_IF
			ELSIF NOT i_pstCmd.i_xSlowMotionFwd AND i_pstCmd.i_xSlowMotionBwd THEN
				stBasicParameter.Direction := mpAXIS_DIR_NEGATIVE;
				IF NOT fbMpAxisBasic.Update AND NOT fbMpAxisBasic.UpdateDone THEN
					fbMpAxisBasic.MoveVelocity	:= TRUE;
				END_IF
			ELSIF NOT i_pstCmd.i_xSlowMotionBwd AND NOT i_pstCmd.i_xSlowMotionFwd THEN
				eMainAxisStep	:= STOP;
				xSlowMotion 	:= TRUE;
			END_IF
			
		JOG_POSITIVE: (* JOG POSITIVE *)
			xJogActive	:= TRUE;
			
			IF NOT fbMpAxisBasic.Update AND NOT fbMpAxisBasic.UpdateDone THEN
				fbMpAxisBasic.MoveVelocity		:= TRUE;
			END_IF
			
			IF NOT i_pstCmd.i_xJogPositive THEN
				fbMpAxisBasic.MoveVelocity		:= FALSE;
				eMainAxisStep	 				:= STOP;
			END_IF
		
		MOVE_ADDITIVE: (* MOVE ADDITIVE *)
			IF NOT fbMpAxisBasic.Update AND NOT fbMpAxisBasic.UpdateDone THEN
				fbMpAxisBasic.MoveAdditive		:= TRUE;
			END_IF
			
			IF fbMpAxisBasic.InPosition	AND NOT i_pstCmd.i_xMoveAdditive THEN
				fbMpAxisBasic.MoveAdditive		:= FALSE;
				eMainAxisStep					:= AXIS_READY;//v4.A.A.1.6.12f
			END_IF
				
		GEAR_VELOCITY:
			fbMpAxisCyclicSet.Enable	:= TRUE;
			fbMpAxisCyclicSet.Velocity	:= prMasterVelocity * (1 + i_pstParameter.i_rVelocityOffsetFactor);
			
			IF fbMpAxisCyclicSet.Velocity > 1 THEN
				fbMpAxisBasic.Power	:= TRUE;
				eMainAxisStep 		:= GEAR_VELOCITY_1;
			ELSIF NOT i_pstCmd.i_xGear THEN
				fbMpAxisCyclicSet.Velocity	:= 0;
				eMainAxisStep 				:= GEAR_VELOCITY_5;
			END_IF
		
		GEAR_VELOCITY_1:
			IF fbMpAxisBasic.IsHomed THEN
				eMainAxisStep 	:= GEAR_VELOCITY_3;
			ELSE
				stBasicParameter.Home.Mode	:= mpAXIS_HOME_MODE_DIRECT;
				stBasicParameter.Home.Position		:= 0.0;
				fbMpAxisBasic.Home	:= TRUE;
				eMainAxisStep 		:= GEAR_VELOCITY_2;
			END_IF
			
		GEAR_VELOCITY_2:			
			IF fbMpAxisBasic.IsHomed THEN
				fbMpAxisBasic.Home	:= FALSE;
				eMainAxisStep 		:= GEAR_VELOCITY_3;
			END_IF
		
		GEAR_VELOCITY_3:
			tonPowerOn(IN := (fbMpAxisCyclicSet.Velocity < 1), PT := t#3s);
			fbMpAxisCyclicSet.Velocity	:= prMasterVelocity * (1 + i_pstParameter.i_rVelocityOffsetFactor);

			IF fbMpAxisBasic.PowerOn AND fbMpAxisCyclicSet.Active THEN
				fbMpAxisCyclicSet.CyclicVelocity	:= TRUE;
				
				IF tonPowerOn.Q (*AND i_xInductionMotorType*) THEN
					fbMpAxisCyclicSet.Velocity	:= 0;
					eMainAxisStep 				:= GEAR_VELOCITY_4;
				ELSIF NOT i_pstCmd.i_xGear THEN
					fbMpAxisCyclicSet.Velocity	:= 0;
					eMainAxisStep 				:= GEAR_VELOCITY_5;
				END_IF
			END_IF
		
		GEAR_VELOCITY_4:
			IF i_pstStatus.q_stMainAxisStatus.q_xStopped THEN
				fbMpAxisCyclicSet.CyclicVelocity 	:= FALSE;
			END_IF
			
			IF NOT fbMpAxisCyclicSet.CyclicSetActive THEN
				fbMpAxisBasic.Power	:= FALSE;
				eMainAxisStep 		:= GEAR_VELOCITY;
			END_IF
	
		GEAR_VELOCITY_5:
			IF i_pstStatus.q_stMainAxisStatus.q_xStopped THEN
				fbMpAxisCyclicSet.CyclicVelocity 	:= FALSE;
			END_IF

			IF NOT fbMpAxisCyclicSet.CommandBusy THEN
				fbMpAxisCyclicSet.Enable	:= FALSE;
			END_IF
			
			IF NOT fbMpAxisCyclicSet.Active THEN
				eMainAxisStep				:= AXIS_READY;//v4.A.A.1.6.12f
			END_IF
		
		GEAR:
			(* If the gear command is not on anymore, MoveAbsolute = FALSE; *)
			xWasStopped	:=	i_pstStatus.q_stMainAxisStatus.q_xStopped;
			xAxisPhased := FALSE;
						
			(* If the gear command is not on anymore, MoveAbsolute = FALSE; *)
			IF NOT i_pstCmd.i_xGear THEN
				fbMpAxisBasic.MoveAbsolute 	:= FALSE;
				eMainAxisStep 				:= AXIS_READY;//v4.A.A.1.6.12f
			ELSIF ABS(prMasterVelocity) <= i_pstParameter.i_rRunningThreshold THEN (* The master isn't moving *)		
				IF i_xParityPhasing THEN (* Check the parity signal *)
					IF ABS(fbMpAxisBasic.Position - plrMasterPosition) <= CST_RephasingThreshold 	OR 
						ABS(fbMpAxisBasic.Position - plrMasterPosition) >= (rAxisPeriod - CST_RephasingThreshold) THEN (* If we are close to the target position *)
						xAxisPhased := TRUE;
					END_IF
				ELSE
					IF ABS(fbMpAxisBasic.Position - (rAxisPeriod - 360.0) - plrMasterPosition) <= CST_RephasingThreshold 	OR 
						ABS(fbMpAxisBasic.Position - (rAxisPeriod - 360.0) - plrMasterPosition) >= (rAxisPeriod - CST_RephasingThreshold) THEN (* If we are close to the target position *)
						xAxisPhased := TRUE;
					END_IF
				END_IF
				
				
				IF xAxisPhased	THEN 				
					StaticCamInit;
					IF fbMpAxisCamSequencer.Active AND i_pstStatus.q_stMainAxisStatus.q_xStopped THEN (* We wait that the master axis is stopped *)
						fbMpAxisCamSequencer.StartSequence 	:= TRUE;
						eMainAxisStep := GEAR_4;
					END_IF
				ELSE (* Otherwise a movement is needed *)
					lrLongRealTemp				:= FC_LongRealReminder(plrMasterPosition, 360.0, 0.0);
						
					rSetAcceleration			:= i_pstParameter.i_rPositioningAccDec;
					stBasicParameter.Velocity	:= i_pstParameter.i_rPositioningVelocity;
					
					IF rAxisPeriod <= 360.0 THEN
						stBasicParameter.Position 	:= lrLongRealTemp;
					ELSE
						IF i_xParityPhasing THEN
							stBasicParameter.Position 	:= lrLongRealTemp;
						ELSE
							stBasicParameter.Position 	:= lrLongRealTemp + 360.0;
						END_IF
					END_IF
					
					lrDiffPosition		:= i_pstStatus.q_stMainAxisStatus.q_lrPosition - stBasicParameter.Position;
										
					IF (lrDiffPosition > 0	AND lrDiffPosition < i_pstParameter.i_rMaxBackwardMovement)			OR
						(lrDiffPosition < 0	AND lrDiffPosition + rAxisPeriod < i_pstParameter.i_rMaxBackwardMovement) THEN
					
						stBasicParameter.Direction := mpAXIS_DIR_SHORTEST_WAY;
					ELSE
						stBasicParameter.Direction := mpAXIS_DIR_POSITIVE;
					END_IF
					
					IF NOT fbMpAxisBasic.Update AND NOT fbMpAxisBasic.UpdateDone THEN
						fbMpAxisBasic.MoveAbsolute	:= TRUE;
						eMainAxisStep := GEAR_1; (* Positioning to master position *)
					END_IF
				END_IF
			ELSE (* The master is moving *)
				OnFlyCamInit;
				IF fbMpAxisCamSequencer.Active THEN
					fbMpAxisCamSequencer.StartSequence 	:= TRUE;
					eMainAxisStep	:= GEAR_2; (* On fly gear *)
				END_IF
			END_IF
		
		GEAR_1: (* Move the axis to the master position *)
			fbMpAxisBasic.MoveAbsolute := i_pstCmd.i_xGear AND NOT fbMpAxisBasic.InPosition;
			IF fbMpAxisBasic.InPosition THEN
				stBasicParameter.Direction := mpAXIS_DIR_POSITIVE;
				IF ABS(FC_LongRealReminder(fbMpAxisBasic.Position, 360.0, 0.0) - FC_LongRealReminder(plrMasterPosition, 360.0, 0.0)) < 0.5 THEN
					StaticCamInit;
					IF fbMpAxisCamSequencer.Active AND i_pstStatus.q_stMainAxisStatus.q_xStopped THEN
						fbMpAxisCamSequencer.StartSequence 	:= TRUE;
						eMainAxisStep 	:= GEAR_4; (* Static 1:1 gear *)
					END_IF
				ELSE
					xMasterMovedWhilePhasing	:= TRUE;
					eMainAxisStep				:= AXIS_ERROR;
				END_IF
			ELSIF NOT i_pstCmd.i_xGear AND i_pstStatus.q_stMainAxisStatus.q_xStopped THEN
				fbMpAxisCamSequencer.Enable	:= FALSE;
				eMainAxisStep	 			:= AXIS_READY;//v4.A.A.1.6.12f
			END_IF
		
		GEAR_2: (* On fly gear *)
			TimerSynchro.IN := (fbMpAxisCamSequencer.ActualStateIndex = 4);
			TimerSynchro.PT	:= T#0.2s;
		
			IF TimerSynchro.Q THEN
				TimerSynchro.IN 							:= FALSE;
				lrDiffPosition								:= plrMasterPosition - (prMasterVelocity * UDINT_TO_REAL(fbRTInfo.cycle_time) * 1e-6) - i_pstStatus.q_stMainAxisStatus.q_lrPosition;
				stCamParameters.PhaseShift.Acceleration		:= i_pstParameter.i_rPositioningAccDec;
				IF lrDiffPosition > 0 THEN (* Make always the position difference negative *)
					lrDiffPosition		:= lrDiffPosition - 360.0;	//Completare Doppio Ingresso
				END_IF
				
				IF i_pstParameter.i_uiMasterParId <> 0 THEN
					lrDiffPosition								:= lrDiffPosition * c_uiAxisFactor;
					stCamParameters.PhaseShift.Acceleration		:= 30.00 * c_uiAxisFactor;
					stCamParameters.PhaseShift.Velocity			:= 90.00 * c_uiAxisFactor;
				ELSE
					stCamParameters.PhaseShift.Acceleration		:= 30.00;
					stCamParameters.PhaseShift.Velocity			:= 90.00;
				END_IF
				
				IF ABS(lrDiffPosition) < 0.5 OR xWasStopped THEN
					eMainAxisStep 							:= GEAR_4;
				ELSE
					stCamParameters.PhaseShift.Distance		:= lrDiffPosition;
					fbMpAxisCamSequencer.PhaseShift			:= FALSE;
					eMainAxisStep 							:= GEAR_3;
				END_IF
			END_IF
	
		GEAR_3:	(* Master - slave position difference compensation *)
			fbMpAxisCamSequencer.PhaseShift			:= TRUE;
				
			IF fbMpAxisCamSequencer.PhasingDone THEN
				fbMpAxisCamSequencer.PhaseShift		:= FALSE;
				eMainAxisStep 						:= GEAR_4;
			END_IF
	
		GEAR_4:	(* 1:1 gear *)
			fbMpAxisCamSequencer.PhaseShift		:= FALSE;
			IF NOT i_pstCmd.i_xGear AND i_pstCmd.i_xMoveVelocity THEN
				stBasicParameter.Velocity 		:= i_pstStatus.q_stMainAxisStatus.q_rVelocity;
				fbMpAxisBasic.MoveVelocity 		:= TRUE;
				eMainAxisStep 					:= ENDLESS_RUN1;
			ELSIF NOT i_pstCmd.i_xGear AND NOT i_pstCmd.i_xMoveVelocity THEN
				stBasicParameter.Velocity 		:= i_pstStatus.q_stMainAxisStatus.q_rVelocity;
				eMainAxisStep 					:= STOP;
			ELSIF i_pstCmd.i_xOnePitchShift THEN
				eMainAxisStep 				:= ONE_PITCH_SHIFT;
			ELSIF i_pstCmd.i_xPhaseShift AND i_pstParameter.i_rPhaseShiftDistance <> 0 THEN
				i_pstStatus.q_stMainAxisStatus.q_xPhasingRunning	:= TRUE;
				eMainAxisStep 				:= PHASE_SHIFT;
			ELSIF i_pstCmd.i_xPosCorrection AND NOT i_pstCmd.i_xNegCorrection THEN
				IF NOT fbMpAxisCamSequencer.Update AND NOT fbMpAxisCamSequencer.UpdateDone THEN
					rSlaveVelocityRatio			:= (prMasterVelocity + 100) / prMasterVelocity;
					CompCamInit;
					fbMpAxisCamSequencer.Update	:= TRUE;
					eMainAxisStep 				:= VELOCITY_SHIFT;
				END_IF
			ELSIF i_pstCmd.i_xNegCorrection AND NOT i_pstCmd.i_xPosCorrection THEN
				IF NOT fbMpAxisCamSequencer.Update AND NOT fbMpAxisCamSequencer.UpdateDone THEN
					rSlaveVelocityRatio			:= (prMasterVelocity - 100)/prMasterVelocity;
					CompCamInit;
					fbMpAxisCamSequencer.Update	:= TRUE;
					eMainAxisStep 				:= VELOCITY_SHIFT;
				END_IF
			ELSIF i_pstCmd.i_xDisableAxis AND ABS(prMasterVelocity) <= i_pstParameter.i_rRunningThreshold THEN
				xAxisDisabled					:= i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply;
				eMainAxisStep 					:= STOP;
			ELSE
				fbMpAxisBasic.MoveVelocity	:= FALSE;
			END_IF
		
		ONE_PITCH_SHIFT: (* AXIS_STEP_ONE_PITCH_SHIFT *)
			stCamParameters.PhaseShift.Acceleration	:= i_pstParameter.i_rPositioningAccDec;
			stCamParameters.PhaseShift.Distance		:= -360.0;
			fbMpAxisCamSequencer.PhaseShift			:= TRUE;
			
			(* In case of MasterParId <> 0 the Factor is lost. So it's necessary to multiply for the axis factor *)
			IF i_pstParameter.i_uiMasterParId <> 0 THEN
				stCamParameters.PhaseShift.Distance		:= stCamParameters.PhaseShift.Distance * c_uiAxisFactor;
				stCamParameters.PhaseShift.Acceleration	:= stCamParameters.PhaseShift.Acceleration * c_uiAxisFactor;
			END_IF
			
			i_pstStatus.q_stMainAxisStatus.q_xOnePitchShiftDone	:= fbMpAxisCamSequencer.PhasingDone;
			
			IF NOT i_pstCmd.i_xGear THEN
				fbMpAxisCamSequencer.PhaseShift						:= FALSE;
				i_pstStatus.q_stMainAxisStatus.q_xOnePitchShiftDone	:= FALSE;
				eMainAxisStep										:= GEAR_4;
			ELSIF fbMpAxisCamSequencer.PhasingDone AND NOT i_pstCmd.i_xOnePitchShift THEN
				fbMpAxisCamSequencer.PhaseShift	:= FALSE;
				IF NOT fbMpAxisCamSequencer.PhasingDone THEN
					i_pstStatus.q_stMainAxisStatus.q_xOnePitchShiftDone	:= FALSE;
					eMainAxisStep										:= GEAR_4;
				END_IF
			END_IF
		
		VELOCITY_SHIFT: (* PHASE CORRECTION *)
			IF fbMpAxisCamSequencer.UpdateDone THEN
				fbMpAxisCamSequencer.Update		:= FALSE;
				fbMpAxisCamSequencer.Signal1	:= TRUE;
				fbMpAxisCamSequencer.Signal3	:= FALSE;
				
				eMainAxisStep 			:= VELOCITY_SHIFT_1;
			END_IF
			
		VELOCITY_SHIFT_1: (* PHASE CORRECTION *)
			IF NOT i_pstCmd.i_xNegCorrection AND NOT i_pstCmd.i_xPosCorrection THEN
				fbMpAxisCamSequencer.Signal1	:= FALSE;
				fbMpAxisCamSequencer.Signal3	:= TRUE;
				eMainAxisStep					:= GEAR_4;
			END_IF
		
		PHASE_SHIFT: (* Generic Shift compensation *)
			stCamParameters.PhaseShift.Acceleration	:= i_pstParameter.i_rPositioningAccDec;
			fbMpAxisCamSequencer.PhaseShift			:= TRUE;

			stCamParameters.PhaseShift.Acceleration	:= i_pstParameter.i_rPositioningAccDec;
			stCamParameters.PhaseShift.Velocity		:= MIN(i_pstParameter.i_rPositioningVelocity, i_pstStatus.q_stMainAxisStatus.q_rVelocity / 4);
			
			IF i_pstParameter.i_rPhaseShiftDistance >= 0 THEN
				stCamParameters.PhaseShift.Distance	:= FC_RealReminder(i_rDividend	:= i_pstParameter.i_rPhaseShiftDistance,
																		i_rDivisor	:= 360.0,
																		i_rStart	:= 0);
			ELSE
				stCamParameters.PhaseShift.Distance	:= - FC_RealReminder(i_rDividend := - i_pstParameter.i_rPhaseShiftDistance,
																		i_rDivisor	:= 360.0,
																		i_rStart	:= 0);
			END_IF
			
			(* In case of MasterParId <> 0 the Factor is lost. So it's necessary to multiply for the axis factor *)
			IF i_pstParameter.i_uiMasterParId <> 0 THEN
				stCamParameters.PhaseShift.Distance		:= stCamParameters.PhaseShift.Distance 		* c_uiAxisFactor;
				stCamParameters.PhaseShift.Acceleration	:= stCamParameters.PhaseShift.Acceleration	* c_uiAxisFactor;
				stCamParameters.PhaseShift.Velocity		:= stCamParameters.PhaseShift.Velocity		* c_uiAxisFactor;
			END_IF
			
			eMainAxisStep := PHASE_SHIFT_1;
			
		PHASE_SHIFT_1:
			fbMpAxisCamSequencer.PhaseShift	:= TRUE;
			
			IF NOT i_pstCmd.i_xGear THEN
				fbMpAxisCamSequencer.PhaseShift						:= FALSE;
				i_pstStatus.q_stMainAxisStatus.q_xOnePitchShiftDone	:= FALSE;
				i_pstStatus.q_stMainAxisStatus.q_xPhasingRunning	:= FALSE;
				eMainAxisStep										:= GEAR_4;
			ELSIF fbMpAxisCamSequencer.PhasingDone AND NOT i_pstCmd.i_xPhaseShift THEN
				IF i_pstParameter.i_uiMasterParId <> 0 THEN
					i_pstAxisHome.rPhaseOffsetValue	:= i_pstAxisHome.rPhaseOffsetValue + LREAL_TO_REAL(stCamParameters.PhaseShift.Distance) / c_uiAxisFactor;
					lrTotalPhaseOffset				:= fbMpAxisCamSequencer.Info.ActualPhasingValue / c_uiAxisFactor;
				ELSE
					i_pstAxisHome.rPhaseOffsetValue	:= i_pstAxisHome.rPhaseOffsetValue + LREAL_TO_REAL(stCamParameters.PhaseShift.Distance);
					lrTotalPhaseOffset				:= fbMpAxisCamSequencer.Info.ActualPhasingValue;
				END_IF
				
				stCamParameters.PhaseShift.Distance					:= 0.0;
				fbMpAxisCamSequencer.PhaseShift						:= FALSE;
				i_pstStatus.q_stMainAxisStatus.q_xPhasingRunning	:= FALSE;
				eMainAxisStep										:= GEAR_4;
			END_IF
		
		HOMING_1:	(* DISABLE CURVE *)
			IF NOT i_pstStatus.q_stMainAxisStatus.q_xAxisReal THEN //Only for virtual axis
				IF NOT fbWriteParID.Busy THEN
					uiCurveMode					:= 0; //DISABLE
					fbWriteParID.Axis			:= i_pAxisADR;
					fbWriteParID.DataAddress	:= ADR(uiCurveMode);
					fbWriteParID.DataType		:= ncPAR_TYP_UINT;
					fbWriteParID.ParID			:= ACP10PAR_CURVE_MODE + 5;
					fbWriteParID.Execute		:= TRUE;
				END_IF
				
				IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_MODE + 5 THEN
					fbWriteParID.Execute	:= FALSE;
					eMainAxisStep		:= HOMING_2;
				END_IF
			ELSE
				eMainAxisStep	:= HOMING_2;
			END_IF
			
		HOMING_2:	(* HOMING *)
			stBasicParameter.Home.Mode		:= mpAXIS_HOME_MODE_DIRECT;
			i_pstAxisHome.rPhaseOffsetValue	:= 0;
			
			IF i_pstParameter.i_udiHomingPosition <> 0 THEN
				plrHomingPosition	ACCESS i_pstParameter.i_udiHomingPosition;
				stBasicParameter.Home.Position	:= plrHomingPosition;
			ELSE
				stBasicParameter.Home.Position	:= 0;
			END_IF
			
			i_pstAxisHome.xHomeValid		:= FALSE;
			
			fbMpAxisBasic.Home				:= TRUE;
			eMainAxisStep					:= HOMING_3;
		
		HOMING_3:	(* WAIT HOMING DONE *)
			IF NOT fbMpAxisBasic.CommandBusy AND fbMpAxisBasic.IsHomed THEN
				lrTotalPhaseOffset				:= 0.0;
				fbMpAxisBasic.Home				:= FALSE;
				stBasicParameter.Home.Mode		:= mpAXIS_HOME_MODE_RESTORE_POS;
				i_pstAxisHome.xHomeValid		:= TRUE;
				i_pstAxisHome.rPhaseOffsetValue	:= 0.0;
			END_IF
		
			IF i_pstAxisHome.xHomeValid AND NOT i_pstCmd.i_xHome AND NOT i_pstCmd.i_xPhaseCompensation THEN
				eMainAxisStep				:= HOMING_4;
			END_IF
			
		HOMING_4:	(* ENABLE CURVE *)
			IF NOT i_pstStatus.q_stMainAxisStatus.q_xAxisReal THEN //Only for virtual axis
				IF NOT fbWriteParID.Busy THEN
					uiCurveMode					:= 2; //ENABLE
					fbWriteParID.Axis			:= i_pAxisADR;
					fbWriteParID.DataAddress	:= ADR(uiCurveMode);
					fbWriteParID.DataType		:= ncPAR_TYP_UINT;
					fbWriteParID.ParID			:= ACP10PAR_CURVE_MODE + 5;
					fbWriteParID.Execute		:= TRUE;
				END_IF
				
				IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_MODE + 5 THEN
					fbWriteParID.Execute	:= FALSE;
					eMainAxisStep		:= AXIS_READY;//v4.A.A.1.6.12f
				END_IF
			ELSE
				eMainAxisStep	:= AXIS_READY;//v4.A.A.1.6.12f
			END_IF
			
		PHASE_COMPENSATION:
			IF NOT i_pstParameter.i_xMachineMaster THEN
				stBasicParameter.Home.Mode		:= mpAXIS_HOME_MODE_DIRECT;
				stBasicParameter.Home.Position	:= FC_LongRealReminder(i_pstStatus.q_stMainAxisStatus.q_lrPosition	- lrTotalPhaseOffset, 360.0, 0);
				i_pstAxisHome.xHomeValid		:= FALSE;
				fbMpAxisBasic.Home				:= TRUE;
				eMainAxisStep					:= PHASE_COMPENSATION_1;
			ELSE
				IF i_pstAxisHome.rPhaseOffsetValue = 0.0 THEN //V4.A.A.1.6.10
					lrTotalPhaseOffset				:= 0.0;
					eMainAxisStep					:= AXIS_READY;//v4.A.A.1.6.12f
				END_IF //V4.A.A.1.6.10
			END_IF
				
		PHASE_COMPENSATION_1:
			eMainAxisStep := WAIT_HOMING_DONE;
		
		WAIT_HOMING_DONE:
			IF NOT fbMpAxisBasic.CommandBusy AND fbMpAxisBasic.IsHomed THEN
				lrTotalPhaseOffset				:= 0.0;
				fbMpAxisBasic.Home				:= FALSE;
				stBasicParameter.Home.Mode		:= mpAXIS_HOME_MODE_RESTORE_POS;
				i_pstAxisHome.xHomeValid		:= TRUE;
				i_pstAxisHome.rPhaseOffsetValue	:= 0.0;
			END_IF
		
			IF i_pstAxisHome.xHomeValid AND NOT i_pstCmd.i_xHome AND NOT i_pstCmd.i_xPhaseCompensation THEN
				eMainAxisStep					:= AXIS_READY;//v4.A.A.1.6.12f
			END_IF	
		
		STOP: (* PREPARE FOR STOP *)
			IF i_pstStatus.q_stMainAxisStatus.q_xStopped THEN
				stBasicParameter.Direction 		:= mpAXIS_DIR_POSITIVE;
				eMainAxisStep					:= WAIT_FOR_STOPPED;
			ELSIF NOT fbMpAxisBasic.Update AND NOT fbMpAxisBasic.UpdateDone THEN
				IF (stBasicParameter.Velocity > fbMpAxisBasic.Velocity) THEN (* ACCELERATING *)
					rDeltaV	:= MAX((rSetAcceleration * rSetAcceleration / (2 * i_pstParameter.i_rEndlessJerk)), 2.0); // Never less than 20 cph //V4.A.A.1.6.10a//v4.A.A.1.6.12f
				ELSIF  (stBasicParameter.Velocity < fbMpAxisBasic.Velocity) THEN (* DECELERATING *)
					rDeltaV	:= MAX((rSetDeceleration * rSetDeceleration / (2 * i_pstParameter.i_rEndlessJerk)), 2.0); // Never less than 20 cph //V4.A.A.1.6.10a//v4.A.A.1.6.12f
				ELSE
					rDeltaV	:= 2.0;//v4.A.A.1.6.12g
				END_IF
				
				IF (stBasicParameter.Velocity - ABS(fbMpAxisBasic.Velocity)) > rDeltaV THEN
					stBasicParameter.Velocity	:= ABS(fbMpAxisBasic.Velocity) + rDeltaV * 1.2;
				ELSIF (stBasicParameter.Velocity - ABS(fbMpAxisBasic.Velocity)) < - rDeltaV THEN
					stBasicParameter.Velocity	:= ABS(fbMpAxisBasic.Velocity) - rDeltaV * 1.2;
				ELSE//v4.A.A.1.6.12f
					stBasicParameter.Velocity	:= MAX((ABS(fbMpAxisBasic.Velocity) - rDeltaV * 1.2), 0.0);//v4.A.A.1.6.12g
				END_IF
				
				fbMpAxisBasic.MoveVelocity 		:= TRUE;
				tonStep(IN := FALSE);

				IF i_pstCmd.i_xShutdown THEN
					stBasicParameter.Velocity	:= 0.0;
					eMainAxisStep				:= WAIT_FOR_STOPPED;
				ELSE
					Vtest := TRUE;//da cancellare
					eMainAxisStep				:= QUICK_STOP;
				END_IF
			END_IF
		
		QUICK_STOP: (* Wait until the axis is in velocity before starting the ramp *)
			tonStep(IN := fbMpAxisBasic.InVelocity OR i_pstStatus.q_stMainAxisStatus.q_xStopped, PT := t#50ms);
			IF tonStep.Q OR (i_pstCmd.i_xShutdown AND NOT fbMpAxisBasic.UpdateDone) OR tonInVelocity.Q THEN
				rSetAcceleration			:= i_pstParameter.i_rEndlessAcceleration;
				rSetDeceleration			:= i_pstParameter.i_rEndlessDeceleration;
				
				fbMpAxisBasic.MoveVelocity 	:= NOT i_pstStatus.q_stMainAxisStatus.q_xStopped;
				fbMpAxisBasic.MoveAbsolute 	:= FALSE;
				fbMpAxisBasic.MoveAdditive 	:= FALSE;
				
				IF xCmdStopActive OR xSlowMotion THEN
					stBasicParameter.Velocity	:= 0.0;//v999
					fbMpAxisBasic.MoveVelocity 	:= FALSE;//v999
					fbMpAxisBasic.MoveAbsolute 	:= FALSE;//v999
					fbMpAxisBasic.MoveAdditive 	:= FALSE;//v999
					eMainAxisStep				:= WAIT_FOR_STOPPED;
				ELSE (* In phase stop *)
					stBasicParameter.Velocity	:= 200.0;
					eMainAxisStep				:= SLOW_DOWN;
				END_IF
			END_IF
			
		SLOW_DOWN: (* SLOW DOWN TO STOP IN PHASE *)
			IF xCmdStopActive OR i_pstStatus.q_stMainAxisStatus.q_xStopped THEN
				stBasicParameter.Velocity	:= 0.0;
				fbMpAxisBasic.MoveVelocity 	:= NOT i_pstStatus.q_stMainAxisStatus.q_xStopped;
				fbMpAxisBasic.MoveAbsolute 	:= FALSE;
				fbMpAxisBasic.MoveAdditive 	:= FALSE;
				eMainAxisStep				:= WAIT_FOR_STOPPED;
			ELSIF fbMpAxisBasic.InVelocity AND ABS(fbMpAxisBasic.Velocity - 200) < 1.0 THEN
				tonStep(IN:= FALSE, PT:= t#50ms);
				eMainAxisStep := STOP_IN_PHASE;
			END_IF
		
		STOP_IN_PHASE: (* LAUNCH STOP IN PHASE COMMAND *)
			tonStep(IN:= (fbSetOverride.AccFactor = 1), PT:= t#50ms); (* Wait the system accept the Override *)
			IF tonStep.Q THEN
				stBasicParameter.Stop.StopInPhase	:= TRUE;
				stBasicParameter.Stop.Deceleration	:= 100;
				stBasicParameter.Stop.Phase			:= i_pstParameter.i_rStopPosition;
				fbMpAxisBasic.Stop					:= TRUE;
				eMainAxisStep						:= WAIT_FOR_STOPPED;
			END_IF
		
		WAIT_FOR_STOPPED: (* STOP_4 *)
			IF i_pstStatus.q_stMainAxisStatus.q_xStopped THEN
				xSlowMotion							:= FALSE;
				fbMpAxisCamSequencer.StartSequence 	:= FALSE;
				fbMpAxisBasic.Stop					:= FALSE;
				fbMpAxisBasic.MoveVelocity			:= FALSE;
				fbMpAxisBasic.MoveAbsolute			:= FALSE;
				fbMpAxisCyclicSet.CyclicVelocity	:= FALSE;
				IF NOT fbMpAxisCyclicSet.CommandBusy THEN
					fbMpAxisCyclicSet.Enable	:= FALSE;
				END_IF

				IF NOT fbMpAxisCyclicSet.Active THEN
					IF i_pstCmd.i_xShutdown  OR i_pstCmd.i_xEmergencyStop THEN
						eMainAxisStep 	:= NO_MOVE_POWER_OFF;
					ELSIF NOT fbMpAxisBasic.MoveActive THEN
						eMainAxisStep 	:= STOPPED;
					END_IF
				END_IF			
			ELSIF fbMpAxisCyclicSet.Active THEN
				fbMpAxisCyclicSet.Velocity	:= prMasterVelocity * (1 + i_pstParameter.i_rVelocityOffsetFactor);
			ELSIF xCmdStopActive THEN
				stBasicParameter.Velocity	:= 0.0;
				fbMpAxisBasic.MoveVelocity 	:= NOT i_pstStatus.q_stMainAxisStatus.q_xStopped;
				fbMpAxisBasic.MoveAbsolute 	:= FALSE;
				fbMpAxisBasic.MoveAdditive 	:= FALSE;
			END_IF
						
		NO_MOVE_POWER_OFF:
			fbMpAxisBasic.Home		:= FALSE;
			fbMpAxisBasic.Stop		:= FALSE;
			fbMpAxisCamSequencer.Enable	:= fbMpAxisCamSequencer.CommandBusy;
			
			IF i_pstStatus.q_stMainAxisStatus.q_xStopped 	AND
				NOT fbMpAxisCamSequencer.Active				AND
				(i_pSecondaryAxisADR = 0 OR NOT fbMpAxisBasicSecondary.PowerOn) THEN (* WAIT UNTIL THE SECONDARY AXIS IS POWERED OFF *)
				
				fbMpAxisBasic.Power := FALSE;
			END_IF
			
			IF NOT fbMpAxisBasic.PowerOn THEN
				eMainAxisStep 	:= STOPPED;
			END_IF
		
		STOPPED:
			xJogActive 		:= FALSE;
			i_pstStatus.q_stMainAxisStatus.q_xOnePitchShiftDone	:= FALSE;
			
			IF NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
				IF i_pstCmd.i_xDisableAxis THEN
					xAxisDisabled	:= i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply;
				ELSE
					IF ABS(prMasterVelocity) <= i_pstParameter.i_rRunningThreshold THEN
						xAxisDisabled	:= FALSE;
					END_IF
				END_IF
			END_IF
			
			fbMpAxisBasic.Home	:= FALSE;
			fbMpAxisBasic.Stop	:= FALSE;
			i_pstStatus.q_stMainAxisStatus.q_xPhasingRunning := FALSE;
			
			IF (i_pstCmd.i_xEmergencyStop OR i_pstCmd.i_xShutdown) AND fbMpAxisBasic.PowerOn THEN
				eMainAxisStep 	:= NO_MOVE_POWER_OFF;
			ELSIF NOT xCmdStopActive THEN
				IF NOT i_pstStatus.q_stMainAxisStatus.q_xPoweredOn THEN
					eMainAxisStep	:= WAIT_FOR_POWER;
				ELSE 
					eMainAxisStep 	:= AXIS_READY;//v4.A.A.1.6.12f
				END_IF
			ELSIF i_pstCmd.i_xReleaseBrake AND i_pstStatus.q_stMainAxisStatus.q_xMotorWithBrake AND NOT i_pstStatus.q_stMainAxisStatus.q_xPoweredOn THEN (* Brake management *)
				fbMpAxisBasic.ReleaseBrake 			:= TRUE;
				fbMpAxisBasicSecondary.ReleaseBrake	:= (i_pSecondaryAxisADR <> 0);
				eMainAxisStep	:= BRAKE_RELEASE;
			END_IF
		
		INDUCTION_MOTOR_SETUP:	(* Motor Identification *)
			fbMpAxisBasic.Power := FALSE;
			i_pstStatus.q_stMainAxisStatus.q_xMotorSetupDone	:= FALSE;
		
			IF NOT fbMpAxisBasic.PowerOn THEN
				fbSetupInductionMotor.Axis										:= i_pAxisADR;
				fbSetupInductionMotor.Command									:= mcSTART;
				fbSetupInductionMotor.Configuration.DatObj.Name					:= 'TempIde';
				fbSetupInductionMotor.Configuration.DatObj.Type					:= mcDATOBJ;
				fbSetupInductionMotor.Configuration.SetupInductionMotorPar		:= i_pstParameter.i_stInductionMotorConfig;
				fbSetupInductionMotor.Configuration.SetupInductionMotorPar.Mode	:= mcIDENTIFICATION;
				fbSetupInductionMotor.Execute									:= TRUE;
				
				//eMainAxisStep	:= INDUCTION_MOTOR_SETUP_1;
			END_IF
		
		INDUCTION_MOTOR_SETUP_1:	(* Wait Identification Done *)
			IF fbSetupInductionMotor.Done THEN
				fbSetupInductionMotor.Execute		:= FALSE;
				
				//eMainAxisStep := INDUCTION_MOTOR_SETUP_2;
			END_IF
		
		INDUCTION_MOTOR_SETUP_2:	(* Save Motor Identification in RAM *)
			IF NOT fbSetupInductionMotor.Done THEN
				fbSetupInductionMotor.Command		:= mcSAVE;
				fbSetupInductionMotor.Execute		:= TRUE;
				
				//eMainAxisStep := INDUCTION_MOTOR_SETUP_3;
			END_IF
		
		INDUCTION_MOTOR_SETUP_3:	(* Find old DataObj in ROM *)
			IF fbSetupInductionMotor.Done THEN
				fbSetupInductionMotor.Execute := FALSE;
				udiDatObjIdentRam := fbSetupInductionMotor.SetupOutput.DataObjectIdent;
				
				fbDatObjInfo.pName	:= ADR(strDataObjIdent);
				fbDatObjInfo.enable	:= TRUE;
			
				//eMainAxisStep := INDUCTION_MOTOR_SETUP_4;
			END_IF
		
		INDUCTION_MOTOR_SETUP_4:
			IF fbDatObjInfo.enable THEN
				IF fbDatObjInfo.status = ERR_OK THEN
					udiDatObjIdentRom	:= fbDatObjInfo.ident;
					//eMainAxisStep		:= INDUCTION_MOTOR_SETUP_5;
				ELSIF fbDatObjInfo.status = doERR_MODULNOTFOUND THEN
					//eMainAxisStep	:= INDUCTION_MOTOR_SETUP_7;
				END_IF
			END_IF
			
		INDUCTION_MOTOR_SETUP_5:	(* Delete old DataObj in RAM *)
			fbDatObjInfo.enable := FALSE;
			
			fbDatObjDelete.ident	:= udiDatObjIdentRom;
			fbDatObjDelete.enable	:= TRUE;
		
			//eMainAxisStep	:= INDUCTION_MOTOR_SETUP_6;
			
		INDUCTION_MOTOR_SETUP_6:
			IF fbDatObjDelete.enable = TRUE THEN
				IF fbDatObjDelete.status = ERR_OK THEN
					fbDatObjDelete.enable := FALSE;
					//eMainAxisStep	:= INDUCTION_MOTOR_SETUP_7;
				END_IF
			END_IF
			
		INDUCTION_MOTOR_SETUP_7:	(* Copy new DataObj in ROM with new name *)			
			fbDatObjCopy.ident			:= udiDatObjIdentRam;
			fbDatObjCopy.pNameTarget	:= ADR(strDataObjIdent);
			fbDatObjCopy.MemTypeTarget	:= doUSRROM;
			fbDatObjCopy.enable			:= TRUE;
						
			//eMainAxisStep	:= INDUCTION_MOTOR_SETUP_8;
		
		INDUCTION_MOTOR_SETUP_8:
			IF fbDatObjCopy.status = ERR_OK	THEN
				fbDatObjCopy.enable	:= FALSE;				
				//eMainAxisStep := INDUCTION_MOTOR_SETUP_9;
			END_IF
		
		INDUCTION_MOTOR_SETUP_9:	(* Delete temporaty DataObj in RAM *)
			fbDatObjDelete.ident	:= udiDatObjIdentRam;
			fbDatObjDelete.enable	:= TRUE;
		
			//eMainAxisStep	:= INDUCTION_MOTOR_SETUP_10;
		
		INDUCTION_MOTOR_SETUP_10:
			IF fbDatObjDelete.status = ERR_OK THEN
				//eMainAxisStep	:= INDUCTION_MOTOR_SETUP_11;
			END_IF
		
		INDUCTION_MOTOR_SETUP_11:
			fbDatObjDelete.enable	:= FALSE;
			i_pstStatus.q_stMainAxisStatus.q_xMotorSetupDone	:= TRUE;
			
			IF NOT i_pstCmd.i_xInductionMotorSetup THEN
				//eMainAxisStep 	:= WAIT_FOR_POWER;
			END_IF
		
		MOTOR_PHASING:	(* Motor Phasing *)
			fbMpAxisBasic.Power := FALSE;
			i_pstStatus.q_stMainAxisStatus.q_xMotorSetupDone	:= FALSE;
		
			IF NOT fbMpAxisBasic.PowerOn THEN
				fbMotorPhasing.Axis										:= i_pAxisADR;
				fbMotorPhasing.Command									:= mcSTART;
				fbMotorPhasing.Configuration.DatObj.Name				:= 'TempPha';
				fbMotorPhasing.Configuration.DatObj.Type				:= mcDATOBJ;
				fbMotorPhasing.Configuration.SetupMotorPhasingPar		:= i_pstParameter.i_stMotorPhasingConfig;
				fbMotorPhasing.Configuration.SetupMotorPhasingPar.Mode	:= mcSTEPPER;
				fbMotorPhasing.Execute									:= TRUE;
				
				eMainAxisStep	:= MOTOR_PHASING_1;
			END_IF
		
		MOTOR_PHASING_1:	(* Wait Phasing Done *)
			IF fbMotorPhasing.Done THEN
				i_pstStatus.q_stMainAxisStatus.q_rMotorPhasingOffset	:= fbMotorPhasing.SetupResult.CommutationOffset;
				i_pstStatus.q_stMainAxisStatus.q_usiMotorPolepairs		:= fbMotorPhasing.SetupResult.PolePairs;
				i_pstStatus.q_stMainAxisStatus.q_rMotorPhasingQuality	:= fbMotorPhasing.SetupOutput.Quality;
				fbMotorPhasing.Execute	:= FALSE;
				
				eMainAxisStep	:= MOTOR_PHASING_2;
			END_IF
		
		MOTOR_PHASING_2:	(* Save Motor Phasing in RAM *)
			IF NOT fbMotorPhasing.Done THEN
				fbMotorPhasing.Command		:= mcSAVE;
				fbMotorPhasing.Execute		:= TRUE;
				
				eMainAxisStep 	:= MOTOR_PHASING_3;
			END_IF
	
		MOTOR_PHASING_3: 	(* Find old DataObj in ROM *)		
			IF fbMotorPhasing.Done THEN
				fbMotorPhasing.Execute	:= FALSE;
				udiDatObjPhasingRam := fbMotorPhasing.SetupOutput.DataObjectIdent;
				
				fbDatObjInfo.pName	:= ADR(strDataObjPhasing);
				fbDatObjInfo.enable	:= TRUE;
				
				eMainAxisStep 			:= MOTOR_PHASING_4;
			END_IF
		
		MOTOR_PHASING_4:
			IF fbDatObjInfo.enable THEN
				IF fbDatObjInfo.status = ERR_OK THEN
					udiDatObjPhasingRom	:= fbDatObjInfo.ident;
					eMainAxisStep		:= MOTOR_PHASING_5;
				ELSIF fbDatObjInfo.status = doERR_MODULNOTFOUND THEN
					eMainAxisStep	:= MOTOR_PHASING_7;
				END_IF
			END_IF
		
		MOTOR_PHASING_5:	(* Delete old DataObj in RAM *)
			fbDatObjInfo.enable := FALSE;
			
			fbDatObjDelete.ident	:= udiDatObjPhasingRom;
			fbDatObjDelete.enable	:= TRUE;
	
			eMainAxisStep	:= MOTOR_PHASING_6;
		
		MOTOR_PHASING_6:
			IF fbDatObjDelete.enable = TRUE THEN
				IF fbDatObjDelete.status = ERR_OK THEN
					eMainAxisStep	:= MOTOR_PHASING_7;
				END_IF
			END_IF
		
		MOTOR_PHASING_7:	(* Copy new DataObj in ROM with new name *)
			fbDatObjDelete.enable := FALSE;
			
			fbDatObjCopy.ident			:= udiDatObjPhasingRam;
			fbDatObjCopy.pNameTarget	:= ADR(strDataObjPhasing);
			fbDatObjCopy.MemTypeTarget	:= doUSRROM;
			fbDatObjCopy.enable			:= TRUE;
						
			eMainAxisStep	:= MOTOR_PHASING_8;
		
		MOTOR_PHASING_8:
			IF fbDatObjCopy.status = ERR_OK	THEN
				fbDatObjCopy.enable	:= FALSE;
				
				eMainAxisStep := MOTOR_PHASING_9;
			END_IF
		
		MOTOR_PHASING_9:	(* Delete temporaty DataObj in RAM *)
			fbDatObjDelete.ident	:= udiDatObjPhasingRam;
			fbDatObjDelete.enable	:= TRUE;
		
			eMainAxisStep	:= MOTOR_PHASING_10;
		
		MOTOR_PHASING_10:
			IF fbDatObjDelete.status = ERR_OK THEN
				eMainAxisStep	:= INDUCTION_MOTOR_SETUP_11;
			END_IF
		
		MOTOR_PHASING_11:
			fbDatObjDelete.enable	:= FALSE;
			i_pstStatus.q_stMainAxisStatus.q_xMotorSetupDone	:= TRUE;
			
			IF NOT i_pstCmd.i_xThirdPartySetup THEN
				eMainAxisStep 	:= WAIT_FOR_POWER;
			END_IF
		
		AXIS_ERROR:
			fbMpAxisBasic.Power 				:= FALSE;
			fbMpAxisBasic.Home					:= FALSE;
			fbMpAxisBasic.MoveVelocity 			:= FALSE;
			fbMpAxisBasic.MoveAdditive 			:= FALSE;
			fbMpAxisBasic.MoveAbsolute 			:= FALSE;
			fbMpAxisCyclicSet.CyclicVelocity	:= FALSE;
			fbMpAxisCamSequencer.StartSequence 	:= FALSE;
			fbMpAxisCamSequencer.PhaseShift		:= FALSE;
			fbMpAxisBasic.ErrorReset 			:= FALSE;
			fbMpAxisCamSequencer.ErrorReset 	:= FALSE;
			fbMpAxisBasic.Stop					:= FALSE;
			
			(* In case of restore variabile permanent fault the xHomeValid flag is reset *)
			IF fbMpAxisBasic.Error AND
				fbMpAxisBasic.Info.Diag.Internal.Code = 5038 		AND
				NOT i_xVelocityControl								AND
				NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply	AND
				i_pstStatus.q_stMainAxisStatus.q_xAxisReal 			THEN

				i_pstAxisHome.xHomeValid	:= FALSE;
				xFirstHomeDone				:= FALSE;
			END_IF
			
			IF xMasterMovedWhilePhasing AND i_pstCmd.i_xErrorReset THEN
				xMasterMovedWhilePhasing := FALSE;
			END_IF
			
			IF fbWriteParID.Error AND i_pstCmd.i_xErrorReset THEN
				fbWriteParID.Execute := FALSE;	
			END_IF
			
			IF fbMotorPhasing.Error AND i_pstCmd.i_xErrorReset THEN
				fbMotorPhasing.Execute := FALSE;
			END_IF
			
			IF fbReadParID.Error AND i_pstCmd.i_xErrorReset THEN
				fbReadParID.Execute := FALSE;
			END_IF
			
			IF fbReadCyclicParID.Error AND i_pstCmd.i_xErrorReset THEN
				fbReadCyclicParID.Execute := FALSE;
			END_IF
			
			IF fbMpAxisCamSequencer.ErrorReset AND fbMpAxisCamSequencer.Error THEN
				fbMpAxisCamSequencer.Enable	:= FALSE;
			END_IF
			
			IF fbMpAxisCyclicSet.ErrorReset AND fbMpAxisCyclicSet.Error THEN
				fbMpAxisCyclicSet.Enable := FALSE;
			END_IF

			IF fbMpAxisCamSequencer.Error THEN
				fbMpAxisCamSequencer.Enable := FALSE;
			END_IF
			
			IF fbMpAxisCyclicSet.Error THEN
				fbMpAxisCyclicSet.Enable := FALSE;
			END_IF

			IF fbSetOverride.Error THEN
				fbSetOverride.Enable := FALSE;
			END_IF
			
			fbMpAxisBasic.ErrorReset 		:= i_pstCmd.i_xErrorReset AND fbMpAxisBasic.Error;
			fbMpAxisCamSequencer.ErrorReset	:= i_pstCmd.i_xErrorReset AND fbMpAxisCamSequencer.Error;
			fbMpAxisCyclicSet.ErrorReset	:= i_pstCmd.i_xErrorReset AND fbMpAxisCyclicSet.Error;

			IF NOT fbMpAxisBasic.Error	AND NOT fbMpAxisCamSequencer.Error	AND NOT fbMpAxisCyclicSet.Error	AND NOT fbWriteParID.Error	AND
				NOT fbReadParID.Error	AND NOT fbReadCyclicParID.Error		AND NOT fbMotorPhasing.Error	AND NOT xMasterMovedWhilePhasing	AND NOT fbSetOverride.Error THEN

				i_pstStatus.q_stMainAxisStatus.q_xPowerFault	:= FALSE;
				IF NOT xMasterParIdInitDone THEN
					eMainAxisStep	:= INIT;
				ELSE
					eMainAxisStep	:= WAIT_FOR_POWER;
				END_IF
			END_IF
		
		WAIT_FOR_CONNECTION:
			stBasicParameter.Velocity			:= 1.0;
			stBasicParameter.Acceleration		:= 1.0;
			stBasicParameter.Deceleration		:= 1.0;
			
			fbMpAxisBasic.Power 				:= FALSE;
			fbMpAxisBasic.Home					:= FALSE;
			fbMpAxisBasic.MoveVelocity 			:= FALSE;
			fbMpAxisBasic.MoveAdditive 			:= FALSE;
			fbMpAxisBasic.MoveAbsolute 			:= FALSE;
			fbMpAxisBasic.ErrorReset 			:= FALSE;
			
			fbMpAxisCamSequencer.ErrorReset 	:= FALSE;
			fbMpAxisCamSequencer.StartSequence 	:= FALSE;
			
			fbSetOverride.AccFactor				:= 1.0;
			fbSetOverride.Enable				:= FALSE;
			fbReadCyclicParID.Execute			:= FALSE;
			
			i_pstStatus.q_stMainAxisStatus.q_xInitDone	:= FALSE;
			
			IF fbMpAxisBasic.Info.BootState = mpAXIS_BLP_DONE THEN
				IF fbMpAxisCamSequencer.ErrorReset AND fbMpAxisCamSequencer.Error THEN
					fbMpAxisCamSequencer.Enable	:= FALSE;
				END_IF
				
				fbMpAxisBasic.ErrorReset 		:= i_pstCmd.i_xErrorReset AND fbMpAxisBasic.Error;
				fbMpAxisCamSequencer.ErrorReset	:= i_pstCmd.i_xErrorReset AND fbMpAxisCamSequencer.Error;
				
				IF NOT fbMpAxisBasic.Error AND NOT fbMpAxisCamSequencer.Error AND NOT fbSetOverride.Error THEN
					fbMpAxisBasic.ErrorReset 						:= FALSE;
					fbMpAxisCamSequencer.ErrorReset 				:= FALSE;
					fbMpAxisCamSequencer.Enable						:= FALSE;
					fbSetOverride.Enable							:= TRUE;
					fbReadCyclicParID.Execute						:= TRUE;
					i_pstStatus.q_stMainAxisStatus.q_xPowerFault	:= FALSE;
					eMainAxisStep									:= INIT;
				END_IF
			END_IF
	END_CASE

	(****************************************)
	(***** SECONDARY AXIS STATE MACHINE *****)
	(****************************************)
	
	(* No comunication catch or Write ParId error *)
	IF (eSecondaryAxisStep >= S_INIT AND fbMpAxisBasic.Info.BootState = mpAXIS_BLP_NETWORK_INACTIVE) THEN
		eSecondaryAxisStep := S_CONNECTION_LOST;
	ELSIF fbWriteParID.Error AND eSecondaryAxisStep >= S_INIT AND eSecondaryAxisStep < S_INIT_TORQUE_CTRL THEN
		eSecondaryAxisStep := S_CONNECTION_LOST;
	ELSIF eSecondaryAxisStep >= S_INIT_MP_AXIS_BASIC AND eSecondaryAxisStep < S_AXIS_ERROR AND fbMpAxisBasicSecondary.Error OR fbTorqueControl.Error THEN (* FBs errors *)
		eSecondaryAxisStep := S_AXIS_ERROR;
	ELSIF FALSE AND ( eSecondaryAxisStep >= S_RAMPING_UP AND eSecondaryAxisStep <= S_READY AND (xCmdStopActive OR fbMpAxisBasic.Velocity < 350)) THEN (* Emergency stop or Shutdown handling *)
		eSecondaryAxisStep := S_CMD_STOP_HANDLING;
	ELSIF eMainAxisStep >= AXIS_ERROR AND eSecondaryAxisStep < S_AXIS_ERROR AND eSecondaryAxisStep >= S_WAIT_FOR_POWER THEN (* Master Error Catch. The Secondary will be powered off *)
		eSecondaryAxisStep := S_MAIN_AXIS_ERROR;
	END_IF
	
	CASE eSecondaryAxisStep OF
		S_DISABLE: (* DISABLE *)
			fbTorqueControl.Enable			:= FALSE;
			fbMpAxisBasicSecondary.Enable	:= FALSE;
			IF i_xEnable 									AND
				i_pSecondaryAxisADR <> 0 					AND
				i_pSecondaryAxisMpLink <> 0					AND
				eMainAxisStep >= OPEN_POSITION_LOOP 		AND
				eMainAxisStep < AXIS_ERROR 					AND
				i_pstStatus.q_stMainAxisStatus.q_xAxisReal 	AND
				NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
				
				eSecondaryAxisStep := S_WAIT_SAFETY_READY;
			END_IF

		S_WAIT_SAFETY_READY: (* Wait safety Ready and primary axis initialization done *)
			IF i_pstStatus.q_stSecondaryAxisStatus.iq_xNotErrEncoder AND i_pstStatus.q_stSecondaryAxisStatus.iq_xOperational THEN
				eSecondaryAxisStep := S_INIT;
			END_IF
		
		S_INIT: (* INIT torque control : ACP10PAR_VAR_R4_0 + 0 **** PRELOAD *)
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Busy THEN
				rTemp	:= i_pstParameter.i_rTorquePreload;

				fbWriteParID.ParID			:= ACP10PAR_VAR_R4_0 + 0;
				fbWriteParID.DataType		:= ncPAR_TYP_REAL;
				fbWriteParID.DataAddress	:= ADR(rTemp);
				fbWriteParID.Axis			:= i_pSecondaryAxisADR;
				fbWriteParID.Execute		:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = (ACP10PAR_VAR_R4_0 + 0) AND fbWriteParID.Axis = i_pSecondaryAxisADR THEN
				fbWriteParID.Execute		:= FALSE;
				eSecondaryAxisStep			:= S_INIT_TORQUE_CTRL;
			END_IF
	
		(****************************************)
		S_INIT_TORQUE_CTRL:	(* INIT torque control *)
			stSecondaryAxis		ACCESS i_pSecondaryAxisADR;
			
			(* Torque Control  initialization *)
			fbTorqueControl.Axis			:= i_pSecondaryAxisADR;
			fbTorqueControl.TorqueRamp 		:= i_pstParameter.i_rTorqueRamp; (* Nm/s *)
			fbTorqueControl.TorqueParID		:= 0;
			fbTorqueControl.Torque			:= i_pstParameter.i_rTorquePreload;	(* Nm used during shutdown phases *)
			fbTorqueControl.Acceleration	:= 1000;	(* PLCopen units /s^2 *)
			fbTorqueControl.PosMaxVelocity	:= 1000;	(* PLCopen units /s *)
			fbTorqueControl.NegMaxVelocity	:= -1000;	(* PLCopen units /s *)
			fbTorqueControl.Mode			:= mcV_LIMIT_OFF + mcCHECK_HOMING_OFF;
			fbTorqueControl.TorqueParID		:= 0;
			fbTorqueControl.InitData		:= FALSE;
			eSecondaryAxisStep 				:= S_INIT_MP_AXIS_BASIC;
							
		S_INIT_MP_AXIS_BASIC: (* INIT MpAxisBasic *)
			fbMpAxisBasicSecondary.MpLink		:= i_pSecondaryAxisMpLink;
			fbMpAxisBasicSecondary.Axis			:= i_pSecondaryAxisADR;
			fbMpAxisBasicSecondary.Parameters	:= ADR(stSecondaryBasicParameter);
			
			stSecondaryBasicParameter.CyclicRead.TorqueMode	:= mpAXIS_READ_MULTIPLEXED;
			fbMpAxisBasicSecondary.Enable		:= TRUE;

			IF fbMpAxisBasicSecondary.Active AND eMainAxisStep >= OPEN_POSITION_LOOP THEN
				IF i_pstParameter.i_rMaxGearboxTorque < rTorqueLimitSecondary THEN
					rTorqueLimitSecondary		:= MAX(i_pstParameter.i_rMaxGearboxTorque, 0.5);
					eSecondaryAxisStep 			:= S_SET_TORQUE_LIMIT;
				ELSE
					eSecondaryAxisStep 			:= S_WAIT_FOR_POWER;
				END_IF
			END_IF
		
		S_SET_TORQUE_LIMIT: (* SET THE TORQUE LIMIT *)
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done  THEN
				fbWriteParID.Axis				:= i_pSecondaryAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_LIM_T1_POS;
				fbWriteParID.DataAddress		:= ADR(rTorqueLimitSecondary);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_LIM_T1_POS AND (fbWriteParID.Axis = i_pSecondaryAxisADR) THEN
				fbWriteParID.Execute	:= FALSE;
				eSecondaryAxisStep		:= S_SET_TORQUE_LIMIT_1;
			END_IF
		
		S_SET_TORQUE_LIMIT_1:
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done THEN
				fbWriteParID.Axis				:= i_pSecondaryAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_LIM_T1_NEG;
				fbWriteParID.DataAddress		:= ADR(rTorqueLimitSecondary);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_LIM_T1_NEG AND (fbWriteParID.Axis = i_pSecondaryAxisADR) THEN
				fbWriteParID.Execute	:= FALSE;
				eSecondaryAxisStep		:= S_SET_TORQUE_LIMIT_2;
			END_IF
		
		S_SET_TORQUE_LIMIT_2:
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done THEN
				fbWriteParID.Axis				:= i_pSecondaryAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_LIM_T2_POS;
				fbWriteParID.DataAddress		:= ADR(rTorqueLimitSecondary);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_LIM_T2_POS AND (fbWriteParID.Axis = i_pSecondaryAxisADR) THEN
				fbWriteParID.Execute	:= FALSE;
				eSecondaryAxisStep 		:= S_SET_TORQUE_LIMIT_3;
			END_IF
		
		S_SET_TORQUE_LIMIT_3:
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done  THEN
				fbWriteParID.Axis				:= i_pSecondaryAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_LIM_T2_NEG;
				fbWriteParID.DataAddress		:= ADR(rTorqueLimitSecondary);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_LIM_T2_NEG AND (fbWriteParID.Axis = i_pSecondaryAxisADR) THEN
				fbWriteParID.Execute	:= FALSE;
				eSecondaryAxisStep 		:= S_SET_TORQUE_LIMIT_4;
			END_IF
		
		S_SET_TORQUE_LIMIT_4:
			rTempTorque :=	rTorqueLimitSecondary / 4;
			
			IF NOT fbWriteParID.Execute AND NOT fbWriteParID.Done THEN
				fbWriteParID.Axis				:= i_pSecondaryAxisADR;
				fbWriteParID.ParID				:= ACP10PAR_KSCTRL_TORQUE_LIM;
				fbWriteParID.DataAddress		:= ADR(rTempTorque);
				fbWriteParID.DataType			:= ncPAR_TYP_REAL;
				fbWriteParID.Execute			:= TRUE;
			ELSIF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_KSCTRL_TORQUE_LIM AND (fbWriteParID.Axis = i_pSecondaryAxisADR) THEN
				fbWriteParID.Execute	:= FALSE;
				eSecondaryAxisStep 		:= S_WAIT_FOR_POWER;
			END_IF

		S_WAIT_FOR_POWER:(* WAIT FOR POWER *)
			IF fbMpAxisBasicSecondary.Info.ReadyToPowerOn AND NOT i_pstCmd.i_xEmergencyStop AND
				NOT i_pstCmd.i_xShutdown AND fbMpAxisBasic.PowerOn THEN	(* Wait until the main axis is powered on *)
				
				fbTorqueControl.Torque			:= i_pstParameter.i_rTorquePreload;
				fbMpAxisBasicSecondary.Power 	:= TRUE;
				eSecondaryAxisStep 				:= S_POWERING;
			END_IF
		
		S_POWERING:	(* Powering *)
			IF fbMpAxisBasicSecondary.PowerOn THEN
				IF NOT fbTorqueControl.Active AND NOT fbTorqueControl.Busy THEN
					fbTorqueControl.Enable		:= TRUE;
				ELSIF fbTorqueControl.WaitingForStart THEN
					fbTorqueControl.InitData	:= FALSE;
					fbTorqueControl.StartSignal	:= TRUE;
					eSecondaryAxisStep 			:= S_RAMPING_UP;
				END_IF
			END_IF
		
		S_RAMPING_UP: (* Ramping up *)
			IF fbTorqueControl.InTorque THEN
				eSecondaryAxisStep 	:= S_POSITIVE_PRELOAD;
			END_IF
		
		S_POSITIVE_PRELOAD:	(* Preload on the front side *)
			fbTorqueControl.TorqueParID	:= ACP10PAR_ARITH_VALUE_R4 + 0;
			fbTorqueControl.TorqueRamp	:= 2 * i_pstParameter.i_rTorquePreload / 0.2;
			fbTorqueControl.InitData	:= TRUE;
			
			IF fbTorqueControl.InitData AND fbTorqueControl.DataInitialized THEN
				fbTorqueControl.InitData	:= FALSE;
				eSecondaryAxisStep 			:= S_POSITIVE_PRELOAD_2;
			END_IF
	
		S_POSITIVE_PRELOAD_2:
			tonStepSecondary(IN := TRUE, PT := t#400ms);
			
			IF tonStepSecondary.Q THEN
				tonStepSecondary(IN := FALSE);
				fbTorqueControl.TorqueRamp	:= 0;
				fbTorqueControl.InitData	:= TRUE;
				eSecondaryAxisStep 			:= S_READY;
			END_IF
	
		S_READY: (* STEP READY *)
			IF fbTorqueControl.InitData AND fbTorqueControl.DataInitialized THEN
				fbTorqueControl.InitData := FALSE;
			END_IF

			IF (i_pstCmd.i_xEmergencyStop OR i_pstCmd.i_xShutdown) THEN
				eSecondaryAxisStep := S_RAMPING_DOWN; (* RAMPING DOWN for SHUT DOWN *)
			END_IF

		(******************************************************************************)
		S_CMD_STOP_HANDLING: (* CmdStop Handling *)
			IF (i_pstCmd.i_xEmergencyStop OR i_pstCmd.i_xShutdown) THEN
				eSecondaryAxisStep := S_RAMPING_DOWN;(* RAMPING DOWN for SHUT DOWN *)
			END_IF

		(****** SHUT DOWN AXIS PROCEDURE *****)
		S_RAMPING_DOWN:	(* RAMPING DOWN 1 *)
			IF ABS(i_pstStatus.q_stMainAxisStatus.q_rVelocity) <= i_pstParameter.i_rRunningThreshold THEN
				fbTorqueControl.InitData		:= TRUE;
				fbTorqueControl.TorqueRamp 		:= i_pstParameter.i_rTorqueRamp;
				fbTorqueControl.Torque			:= LREAL_TO_REAL(q_lrSecondaryAxisTorque);
				fbTorqueControl.TorqueParID		:= 0; (* In case of zero in TorqueParID parameter the block uses the Torque input *)
				eSecondaryAxisStep 				:= S_RAMPING_DOWN_1;
			END_IF
		
		S_RAMPING_DOWN_1: (* RAMPING DOWN 2 *)
			IF NOT fbTorqueControl.InitData AND fbTorqueControl.InTorque THEN
				fbTorqueControl.InitData		:= TRUE;
				fbTorqueControl.TorqueRamp 		:= i_pstParameter.i_rTorqueRamp;
				fbTorqueControl.Torque			:= 0.1;
				eSecondaryAxisStep 				:= S_WAIT_FOR_STOPPING;
			ELSIF fbTorqueControl.DataInitialized THEN
				fbTorqueControl.InitData		:= FALSE;
			END_IF
		
		S_WAIT_FOR_STOPPING: (* WAIT FOR STOPPING 2 *)
			IF NOT fbTorqueControl.InitData AND fbTorqueControl.InTorque THEN
				eSecondaryAxisStep 			:= S_POWER_OFF;
			ELSIF fbTorqueControl.DataInitialized THEN
				fbTorqueControl.InitData	:= FALSE;
			END_IF
		
		S_POWER_OFF: (* POWER OFF *)
			fbMpAxisBasicSecondary.Power :=	FALSE;
			
			IF NOT fbMpAxisBasicSecondary.PowerOn THEN (* fbTorqueControl aborted by power off *)
				fbTorqueControl.Enable		:= FALSE;
				fbTorqueControl.StartSignal	:= FALSE;
				fbTorqueControl.InitData	:= FALSE;

				eSecondaryAxisStep := S_WAIT_FOR_POWER; (* WAIT FOR POWER *)
			END_IF

		(***********************************************)
		(************* ERROR HANDLING ******************)
		(***********************************************)
		S_MAIN_AXIS_ERROR:
			fbMpAxisBasicSecondary.Power 		:= FALSE;
			fbTorqueControl.Enable				:= FALSE;
			fbTorqueControl.StartSignal			:= FALSE;
			fbTorqueControl.InitData			:= FALSE;
			fbTorqueControl.TorqueParID			:= 0;
			fbTorqueControl.TorqueRamp 			:= i_pstParameter.i_rTorqueRamp;
			
			fbMpAxisBasicSecondary.ErrorReset 	:= FALSE;
			
			IF eMainAxisStep < AXIS_ERROR THEN
				eSecondaryAxisStep	:= S_WAIT_FOR_POWER;
			END_IF
		
		S_AXIS_ERROR: (* SECONDARY AXIS ERROR *)
			fbMpAxisBasicSecondary.Power 		:= FALSE;
			fbTorqueControl.Enable				:= FALSE;
			fbTorqueControl.StartSignal			:= FALSE;
			fbTorqueControl.InitData			:= FALSE;
			fbTorqueControl.TorqueParID			:= 0;
			fbTorqueControl.TorqueRamp 			:= i_pstParameter.i_rTorqueRamp;
			
			fbMpAxisBasicSecondary.ErrorReset	:= i_pstCmd.i_xErrorReset AND fbMpAxisBasicSecondary.Error;

			IF NOT fbTorqueControl.Error THEN
				fbTorqueControl.Enable				:= FALSE;
				fbTorqueControl.StartSignal			:= FALSE;
				fbTorqueControl.InitData			:= FALSE;
			ELSIF i_pstCmd.i_xErrorReset THEN
				fbTorqueControl.Enable				:= FALSE;
				fbTorqueControl.StartSignal			:= FALSE;
				fbTorqueControl.InitData			:= FALSE;
			END_IF
			
			IF NOT fbMpAxisBasicSecondary.Error AND NOT fbMpAxisBasicSecondary.Error AND eMainAxisStep < 9000 THEN
				fbMpAxisBasicSecondary.ErrorReset 	:= FALSE;
				eSecondaryAxisStep					:= S_WAIT_FOR_POWER; (* WAIT FOR POWER *)
			END_IF
		
		S_CONNECTION_LOST: (* Connection Lost *)
			fbMpAxisBasicSecondary.Power 		:= FALSE;
			
			fbTorqueControl.Enable				:= FALSE;
			fbTorqueControl.StartSignal			:= FALSE;
			fbTorqueControl.InitData			:= FALSE;
			fbTorqueControl.TorqueParID			:= 0;
			fbTorqueControl.TorqueRamp 			:= i_pstParameter.i_rTorqueRamp;
		
			IF fbMpAxisBasic.Info.BootState = mpAXIS_BLP_DONE THEN
				fbMpAxisBasicSecondary.ErrorReset	:= i_pstCmd.i_xErrorReset AND fbMpAxisBasicSecondary.Error;
				IF fbWriteParID.Error AND i_pstCmd.i_xErrorReset THEN
					fbWriteParID.Execute	:= FALSE;
				END_IF
				
				IF NOT fbTorqueControl.Error THEN
					fbTorqueControl.Enable				:= FALSE;
					fbTorqueControl.StartSignal			:= FALSE;
					fbTorqueControl.InitData			:= FALSE;
				ELSIF i_pstCmd.i_xErrorReset THEN
					fbTorqueControl.Enable				:= FALSE;
					fbTorqueControl.StartSignal			:= FALSE;
					fbTorqueControl.InitData			:= FALSE;
				END_IF
			
				IF NOT fbMpAxisBasicSecondary.Error AND NOT fbMpAxisBasicSecondary.Error AND NOT fbWriteParID.Error AND eMainAxisStep < 9000 THEN
					fbMpAxisBasicSecondary.ErrorReset 	:= FALSE;
					fbWriteParID.Execute				:= FALSE;
					eSecondaryAxisStep					:= S_WAIT_SAFETY_READY; (* WAIT SAFETY *)
				END_IF
			END_IF
	END_CASE

	lrOldPosition := fbMpAxisBasic.Position;

	Act_AxisStatus;
	Act_SetOverride;
END_FUNCTION_BLOCK
