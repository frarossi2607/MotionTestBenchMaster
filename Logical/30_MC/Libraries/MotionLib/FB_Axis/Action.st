(**************** CAM FOR STATIC GEAR *******************)
ACTION NegativeStaticCamInit://v999
	
	stCamParameters.Configuration.State[0].Event[0].Attribute        :=ncAT_ONCE;
	stCamParameters.Configuration.State[0].Event[0].Type                :=ncS_START;
	stCamParameters.Configuration.State[0].Event[0].NextState        :=1;
       
	stCamParameters.Configuration.State[1].CamProfileIndex                :=16#FFFF;
	stCamParameters.Configuration.State[1].MasterFactor                        := 360 * c_uiAxisFactor;;
	stCamParameters.Configuration.State[1].SlaveFactor                        := 360 * c_uiAxisFactor;;
	stCamParameters.Configuration.State[1].CompMode                                :=ncONLYCOMP;
	stCamParameters.Configuration.State[1].MasterCompDistance        :=360;
	stCamParameters.Configuration.State[1].SlaveCompDistance        :=360;
       
	stCamParameters.Configuration.State[1].Event[0].Type                :=ncST_END;
	stCamParameters.Configuration.State[1].Event[0].Attribute        :=ncST_END;
	stCamParameters.Configuration.State[1].Event[0].NextState        :=2;
       
	stCamParameters.Configuration.State[1].Event[1].Type                :=ncST_END+ncNEGATIVE;
	stCamParameters.Configuration.State[1].Event[1].Attribute        :=ncST_END;
	stCamParameters.Configuration.State[1].Event[1].NextState        :=2;
       
	stCamParameters.Configuration.State[2].CamProfileIndex                :=16#FFFF;
	stCamParameters.Configuration.State[2].MasterFactor                        := 360 * c_uiAxisFactor;;
	stCamParameters.Configuration.State[2].SlaveFactor                        := 360 * c_uiAxisFactor;;
       
	stCamParameters.Configuration.State[2].Event[0].Type                :=ncST_END;
	stCamParameters.Configuration.State[2].Event[0].Attribute        :=ncST_END;
	stCamParameters.Configuration.State[2].Event[0].NextState        :=2;
       
	stCamParameters.Configuration.State[2].Event[1].Type                :=ncST_END+ncNEGATIVE;
	stCamParameters.Configuration.State[2].Event[1].Attribute        :=ncST_END;
	stCamParameters.Configuration.State[2].Event[1].NextState        :=2;

	fbMpAxisCamSequencer.Enable := TRUE;
END_ACTION

ACTION StaticCamInit:
	(* CamAutomat initialization for static gear *)
	stCamParameters.Configuration.StartState		:= 0;
	stCamParameters.Configuration.StartPosition 	:= LREAL_TO_REAL(fbMpAxisBasic.Position);
	stCamParameters.Configuration.StartInterval		:= 360.0;
	stCamParameters.Configuration.MasterParID		:= i_pstParameter.i_uiMasterParId;
	
	(* State 0 - Basic state *)
	stCamParameters.Configuration.State[0].Event[0].Type 		:= ncST_END;
	stCamParameters.Configuration.State[0].Event[0].Attribute 	:= ncST_END;
	stCamParameters.Configuration.State[0].Event[0].NextState 	:= 3;

	(* State 1 - Spare Not Used *)
	(* State 2 - Spare Not Used *)

	(* State 3 - Compensation *)	
	stCamParameters.Configuration.State[3].CamProfileIndex		:= 16#FFFF;
	stCamParameters.Configuration.State[3].MasterFactor			:= LREAL_TO_DINT(720.0 - fbMpAxisBasic.Position) * c_uiAxisFactor;
	stCamParameters.Configuration.State[3].SlaveFactor			:= LREAL_TO_DINT(720.0 - fbMpAxisBasic.Position) * c_uiAxisFactor;
	stCamParameters.Configuration.State[3].CompMode				:= ncOFF;
	
	stCamParameters.Configuration.State[3].Event[0].Type 		:= ncST_END;//test
	stCamParameters.Configuration.State[3].Event[0].Attribute 	:= ncST_END;
	stCamParameters.Configuration.State[3].Event[0].NextState 	:= 4;

	(* State 4 - Synchro *)
	stCamParameters.Configuration.State[4].CamProfileIndex		:= 16#FFFF;
	stCamParameters.Configuration.State[4].MasterFactor			:= 360 * c_uiAxisFactor;
	stCamParameters.Configuration.State[4].SlaveFactor			:= 360 * c_uiAxisFactor;
	stCamParameters.Configuration.State[4].CompMode				:= ncOFF;
	
	stCamParameters.Configuration.State[4].Event[0].Type 		:= ncSIGNAL1;
	stCamParameters.Configuration.State[4].Event[0].Attribute 	:= ncST_END;
	stCamParameters.Configuration.State[4].Event[0].NextState	:= 8;
	
	stCamParameters.Configuration.State[4].Event[2].Type 		:= ncST_END;//test
	stCamParameters.Configuration.State[4].Event[2].Attribute 	:= ncST_END;
	stCamParameters.Configuration.State[4].Event[2].NextState 	:= 4;
	
	fbMpAxisCamSequencer.Enable := TRUE;
END_ACTION

(**************** CAM FOR on-fly GEAR *******************)
ACTION OnFlyCamInit:
	(* CamAutomat initialization for on-fly gear *)
	rSlaveVelocity		:= fbMpAxisBasic.Velocity;
	rAccelerationTime	:= ABS(prMasterVelocity - rSlaveVelocity) / (0.25 * i_pstParameter.i_rEndlessAcceleration);
	
	(* 	We assume that in an acceleration profile with a poly5 and starting with Vslave = 0 the acceleration is cubic and the
	   	area OF this curve is the same of a rectangle with the same base [same acceleration time] but with an height OF
		0.6 * maximum height of the acceleration curve. With this condition the space covered by the same is equal to
		0.5 * MasterVelocity ^2 / (0.6 * MaxCurveAccelerationValue) *)
	
	iNumberOfSlaveSteps := REAL_TO_UINT((0.5 * prMasterVelocity * prMasterVelocity) / (360.0 * 0.6 * i_pstParameter.i_rEndlessAcceleration)) + 1;
	
	(* 	In order to be sure that the rules above works without overshoots and undershoots the ratio between MasterCompensationDistance and
		SlaveCompensationDistance is always 2. The phase is made with an appropriate calculation of the MasterStartPosition *)
	
	IF i_pstParameter.i_uiMasterParId = 0 THEN
		stCamParameters.Configuration.StartPosition 		:= LREAL_TO_REAL(fbMpAxisBasic.Position);
		stCamParameters.Configuration.StartState			:= 0;
		stCamParameters.Configuration.StartMaRelPos			:= 0;
		stCamParameters.Configuration.MaxMasterVelocity		:= prMasterVelocity;
		stCamParameters.Configuration.StartInterval			:= 360.0;
	ELSE
		diMasterSynchPosition								:= pdiMasterScaledPos - LREAL_TO_DINT(c_uiAxisFactor * (plrMasterPosition - fbMpAxisBasic.Position - 3 * 360.0)); 
		stCamParameters.Configuration.StartState			:= 0;
		stCamParameters.Configuration.StartPositionDINT		:= diMasterSynchPosition;
		stCamParameters.Configuration.MasterStartPosMode	:= 129;
		stCamParameters.Configuration.MaxMasterVelocity		:= prMasterVelocity * c_uiAxisFactor * 2.0; 
		stCamParameters.Configuration.MasterParID			:= i_pstParameter.i_uiMasterParId;
	END_IF
	
	(******************** State 0 - Basic state  ****************************)
	(* ncS_START can be used only in State 0 *)
	stCamParameters.Configuration.State[0].Event[0].Type 		:= ncS_START;
	stCamParameters.Configuration.State[0].Event[0].Attribute 	:= ncAT_ONCE;
	stCamParameters.Configuration.State[0].Event[0].NextState 	:= 2;
	
	(*********************** State 2 - Acceleration *******************************)
	(* On compensationDistance the system works on engineering units. On master and slave factor no. *)
	(* In this way the nearest zero position in advance in calculated *)
	stCamParameters.Configuration.State[2].CamProfileIndex		:= 16#FFFE;
	stCamParameters.Configuration.State[2].MasterFactor			:= 1;
	stCamParameters.Configuration.State[2].SlaveFactor			:= 1;
	
	IF rSlaveVelocity > i_pstParameter.i_rMaxBackwardMovement THEN
		(* STARTING IN VELOCITY *)
		IF stCamParameters.Configuration.MasterParID = 0 THEN
			stCamParameters.Configuration.State[2].MasterCompDistance	:= prMasterVelocity * rAccelerationTime;
		ELSE
			stCamParameters.Configuration.State[2].MasterCompDistance	:= prMasterVelocity * rAccelerationTime * c_uiAxisFactor;
		END_IF
		
		stCamParameters.Configuration.StartMaRelPos					:= -1;
		stCamParameters.Configuration.State[2].SlaveCompDistance	:= ABS(prMasterVelocity - rSlaveVelocity) * rAccelerationTime / 2;
		stCamParameters.Configuration.State[2].CompMode				:= ncV_COMP_A_CYC;
		stCamParameters.Configuration.State[2].SlaveCompJoltTime	:= rAccelerationTime/2;
		stCamParameters.Configuration.State[2].MaxSlaveAccelComp1	:= i_pstParameter.i_rEndlessAcceleration;
		stCamParameters.Configuration.State[2].MaxSlaveAccelComp2	:= i_pstParameter.i_rEndlessAcceleration;
		stCamParameters.Configuration.State[2].ExtendedCompLimits	:= ncON;
		stCamParameters.Configuration.StartState					:= 2;
	ELSE
		(* STARTING FROM STAND-STILL *)
		stCamParameters.Configuration.State[2].MasterCompDistance	:= iNumberOfSlaveSteps * 360.0  * 2.0;
		
		(*	The Master and Slave compensation distance internally are used on Acopos units, in our case 36000 units/step.
			If the MasterParID is equal to zero the multiplication with the factor is automatically made. Otherwise is necessary to take it in account *)
		
		IF stCamParameters.Configuration.MasterParID <> 0 THEN
			stCamParameters.Configuration.State[2].MasterCompDistance	:= stCamParameters.Configuration.State[2].MasterCompDistance * c_uiAxisFactor;
		END_IF
		
		stCamParameters.Configuration.State[2].SlaveCompDistance	:= LREAL_TO_REAL(iNumberOfSlaveSteps * 360.0);
		stCamParameters.Configuration.State[2].CompMode				:= ncONLYCOMP_DIRECT;
		stCamParameters.Configuration.State[2].ExtendedCompLimits	:= ncOFF;
		stCamParameters.Configuration.StartState					:= 0;
	END_IF
	
	stCamParameters.Configuration.State[2].Event[0].Type 		:= ncST_END;
	stCamParameters.Configuration.State[2].Event[0].Attribute 	:= ncST_END;
	stCamParameters.Configuration.State[2].Event[0].NextState 	:= 4;
	
	(************************ State 3 - Compensation ***************************)
	(****** NOT USED *****)
	
	(************************ State 4 - Synchro ********************************)
	stCamParameters.Configuration.State[4].CamProfileIndex		:= 16#FFFF;
	stCamParameters.Configuration.State[4].MasterFactor			:= 360 * c_uiAxisFactor;
	stCamParameters.Configuration.State[4].SlaveFactor			:= 360 * c_uiAxisFactor;
	stCamParameters.Configuration.State[4].CompMode				:= ncOFF;
	
	stCamParameters.Configuration.State[4].Event[0].Type 		:= ncSIGNAL1;
	stCamParameters.Configuration.State[4].Event[0].Attribute 	:= ncST_END;
	stCamParameters.Configuration.State[4].Event[0].NextState 	:= 8;
		
	stCamParameters.Configuration.State[4].Event[2].Type 		:= ncST_END;
	stCamParameters.Configuration.State[4].Event[2].Attribute 	:= ncST_END;
	stCamParameters.Configuration.State[4].Event[2].NextState 	:= 4;
	
	fbMpAxisCamSequencer.Enable := TRUE;
END_ACTION

(**************** IN MOTION COMPENSATION CAM INIT *******************)
ACTION CompCamInit:
	rDeltaV				:= (prMasterVelocity * rSlaveVelocityRatio - prMasterVelocity);
	rAccelerationTime	:= ABS(rDeltaV) / i_pstParameter.i_rPositioningAccDec;

	rSlaveCompDist		:= ABS(rDeltaV) / rDeltaV * 0.5 * i_pstParameter.i_rPositioningAccDec * rAccelerationTime * rAccelerationTime + prMasterVelocity * rAccelerationTime;
	rMasterCompDist		:= prMasterVelocity * rAccelerationTime;

	IF stCamParameters.Configuration.MasterParID <> 0 THEN
		rMasterCompDist := rMasterCompDist * c_uiAxisFactor;
	END_IF
	
	(* State 8 - Comp negative *)
	stCamParameters.Configuration.State[8].CamProfileIndex		:= 16#FFFE;
	stCamParameters.Configuration.State[8].MasterFactor			:= 360 * c_uiAxisFactor;
	stCamParameters.Configuration.State[8].SlaveFactor			:= REAL_TO_DINT(360 * c_uiAxisFactor * rSlaveVelocityRatio);
	stCamParameters.Configuration.State[8].MasterCompDistance	:= rMasterCompDist;
	stCamParameters.Configuration.State[8].SlaveCompDistance	:= rSlaveCompDist;
	stCamParameters.Configuration.State[8].CompMode				:= ncONLYCOMP_DIRECT;
	
	stCamParameters.Configuration.State[9].Event[0].Type 		:= ncSIGNAL3;
	stCamParameters.Configuration.State[9].Event[0].Attribute 	:= ncAT_ONCE;
	stCamParameters.Configuration.State[9].Event[0].NextState 	:= 10;
	
	stCamParameters.Configuration.State[8].Event[1].Type 		:= ncST_END;
	stCamParameters.Configuration.State[8].Event[1].Attribute 	:= ncST_END;
	stCamParameters.Configuration.State[8].Event[1].NextState 	:= 9;
	
	(* State 9 - Comp negative *)
	stCamParameters.Configuration.State[9].CamProfileIndex		:= 16#FFFF;
	stCamParameters.Configuration.State[9].MasterFactor			:= 360 * c_uiAxisFactor;
	stCamParameters.Configuration.State[9].SlaveFactor			:= REAL_TO_DINT(360 * c_uiAxisFactor * rSlaveVelocityRatio);
	stCamParameters.Configuration.State[9].CompMode				:= ncOFF;
	
	stCamParameters.Configuration.State[9].Event[0].Type 		:= ncSIGNAL3;
	stCamParameters.Configuration.State[9].Event[0].Attribute 	:= ncAT_ONCE;
	stCamParameters.Configuration.State[9].Event[0].NextState 	:= 10;

	stCamParameters.Configuration.State[9].Event[1].Type 		:= ncST_END;
	stCamParameters.Configuration.State[9].Event[1].Attribute 	:= ncST_END;
	stCamParameters.Configuration.State[9].Event[1].NextState 	:= 9;
	
	(* State 10 - Comp negative *)
	stCamParameters.Configuration.State[10].CamProfileIndex		:= 16#FFFE;
	stCamParameters.Configuration.State[10].MasterFactor		:= 360 * c_uiAxisFactor;
	stCamParameters.Configuration.State[10].SlaveFactor			:= 360 * c_uiAxisFactor;
	stCamParameters.Configuration.State[10].MasterCompDistance	:= rMasterCompDist;
	stCamParameters.Configuration.State[10].SlaveCompDistance	:= rSlaveCompDist;
	stCamParameters.Configuration.State[10].CompMode			:= ncONLYCOMP_DIRECT;
	
	stCamParameters.Configuration.State[10].Event[0].Type 		:= ncST_END;
	stCamParameters.Configuration.State[10].Event[0].Attribute 	:= ncST_END;
	stCamParameters.Configuration.State[10].Event[0].NextState 	:= 4;
END_ACTION

(**************** AXES FBs CALL AND STATUS *******************)
ACTION Act_AxisStatus:
	q_udiCycleTime	:= fbRTInfo.cycle_time;
	i_pstStatus.q_stMainAxisStatus.q_xAxisDisabled		:= xAxisDisabled;
	i_pstStatus.q_stMainAxisStatus.q_xThirdPartyMotor	:= i_xThirdPartyMotor 							AND 
															i_pstStatus.q_stMainAxisStatus.q_xInitDone 	AND 
															i_pstStatus.q_stMainAxisStatus.q_xAxisReal 	AND 
															NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply;
	i_pstStatus.q_stMainAxisStatus.q_rHomingOffset		:= 0;
	
	IF eMainAxisStep >= WAIT_FOR_POWER AND eMainAxisStep < WAIT_FOR_CONNECTION  AND NOT fbReadSlowlyCyclicParID.Error THEN
		fbReadSlowlyCyclicParID.Execute := i_pstStatus.q_stMainAxisStatus.q_xAxisReal;
		fbReadSlowlyCyclicParID.Axis	:= i_pAxisADR;
		IF i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
			fbReadSlowlyCyclicParID.ParID			:= ACP10PAR_UDC_ACT;
			i_pstStatus.q_stMainAxisStatus.q_rDcBus := rLagErrorDcBusValue;
		ELSE
			fbReadSlowlyCyclicParID.ParID				:= ACP10PAR_PCTRL_LAG_ERROR;
			i_pstStatus.q_stMainAxisStatus.q_rLagError	:= rLagErrorDcBusValue/c_uiAxisFactor;
		END_IF
		
		fbReadSlowlyCyclicParID.DataType	:= ncPAR_TYP_REAL;
		fbReadSlowlyCyclicParID.DataAddress := ADR(rLagErrorDcBusValue);
	ELSE
		rLagErrorDcBusValue	:= 0;
		IF i_pstStatus.q_stMainAxisStatus.q_xPowerSupply THEN
			i_pstStatus.q_stMainAxisStatus.q_rDcBus 	:= rLagErrorDcBusValue;
		ELSE
			i_pstStatus.q_stMainAxisStatus.q_rLagError	:= rLagErrorDcBusValue;
		END_IF
		fbReadSlowlyCyclicParID.Execute := FALSE;
	END_IF
	
	fbReadSlowlyCyclicParID();

	(*AXIS_STEP_WAIT_FOR_POWER*) 
	IF eMainAxisStep >= WAIT_FOR_POWER THEN
		IF (memcmp(ADR(stBasicParameter), ADR(stBasicParameterOld), SIZEOF(stBasicParameterOld)) <> 0) AND NOT fbMpAxisBasic.UpdateDone THEN
			fbMpAxisBasic.Update := TRUE;
		END_IF
		
		(* Update Done ---> Update RESET *)
		IF fbMpAxisBasic.Update AND fbMpAxisBasic.UpdateDone THEN
			fbMpAxisBasic.Update	:= FALSE;
			stBasicParameterOld		:= stBasicParameter;
		END_IF
	END_IF
		
	i_pstStatus.q_stMainAxisStatus.q_xPhaseShiftDone := fbMpAxisCamSequencer.PhasingDone OR (i_pstCmd.i_xPhaseShift AND i_pstParameter.i_rPhaseShiftDistance <> 0 AND xCmdStopActive);
				
	(*Main axis *)
	TimerSynchro();

	fbMpAxisBasic();
	fbMpAxisBasicConfig();
	fbMpAxisCamSequencer();

	(* Timer In Velocity *)	
	tonInVelocity(IN := fbMpAxisBasic.InVelocity AND NOT fbMpAxisBasic.Update AND NOT fbMpAxisBasic.UpdateDone, PT := T#30ms);
	
	(*Timeout on write AND read parameter *)
	tonWriteParameter(IN := (uiOldWriteParId = fbWriteParID.ParID) 	AND fbWriteParID.Execute 	AND fbWriteParID.Done, PT := t#30s);
	tonReadParameter (IN := (uiOldReadParId = fbReadParID.ParID) 	AND fbReadParID.Execute 	AND fbReadParID.Done, PT := t#30s);
	
	IF tonWriteParameter.Q THEN
		fbWriteParID.Execute :=	FALSE;
	END_IF
	
	IF tonReadParameter.Q THEN
		fbReadParID.Execute := FALSE;
	END_IF

	IF uiOldWriteParId <> fbWriteParID.ParID THEN
		uiOldWriteParId := fbWriteParID.ParID;
	END_IF
	
	IF uiOldReadParId <> fbReadParID.ParID THEN
		uiOldReadParId := fbReadParID.ParID;
	END_IF

	fbMpAxisCyclicSet();
	fbReadParID();
	fbMotorPhasing();
	
	
	fbTorqueControl();
	fbWriteParID();
	tonReadTemperature();
	
	(* Axis Stopped Ton *)
	tonAxisStopped.IN	:= (ABS(fbMpAxisBasic.Velocity) < i_pstParameter.i_rRunningThreshold) OR NOT fbMpAxisBasic.PowerOn;
	
	tonAxisStopped.PT	:= t#500ms;
	tonAxisStopped();
	i_pstStatus.q_stMainAxisStatus.q_xStopped	:= tonAxisStopped.Q;

	q_xActive									:= fbMpAxisBasic.Active;
	i_pstStatus.q_stMainAxisStatus.q_xActive	:= q_xActive;
	
	q_xError := fbMpAxisBasic.Error				OR fbMpAxisCamSequencer.Error	OR fbTorqueControl.Error OR
												fbMpAxisCyclicSet.Error OR xMasterMovedWhilePhasing OR
												i_pstStatus.q_stMainAxisStatus.q_rEncoderTemperature >= CST_MaxTemperatureEncoder;
	
	i_pstStatus.q_stMainAxisStatus.q_xError		:= q_xError;
	i_pstStatus.q_stMainAxisStatus.q_xMasterMovedWhilePhasing := xMasterMovedWhilePhasing;
	
	i_pstStatus.q_stMainAxisStatus.q_xVelocityControl	:= i_xVelocityControl;
	i_pstStatus.q_stMainAxisStatus.q_xInduction			:= i_xInductionMotorType;
	i_pstStatus.q_stMainAxisStatus.q_xCommandAborted	:= fbMpAxisBasic.CommandAborted	OR fbMpAxisCamSequencer.CommandAborted;
	i_pstStatus.q_stMainAxisStatus.q_xCommandBusy		:= fbMpAxisBasic.CommandBusy 	OR fbMpAxisCamSequencer.CommandBusy;
	
	i_pstStatus.q_stMainAxisStatus.q_xBleederFault		:= (i_pstStatus.q_stMainAxisStatus.q_xPowerSupply AND (usiPhaseMonitor AND CST_BleederError) <>0) OR (fbMpAxisBasic.Info.Diag.Internal.Code = 38008);//V1.3
	
	i_pstStatus.q_stMainAxisStatus.q_ePLCopenStatus		:= fbMpAxisBasic.Info.PLCopenState;
	
	i_pstStatus.q_stMainAxisStatus.q_xSynchronized		:= (fbMpAxisCamSequencer.InSync AND (fbMpAxisCamSequencer.ActualStateIndex >= 3)) OR
															fbMpAxisCyclicSet.Active OR i_xVelocityControl;
	
	i_pstStatus.q_stMainAxisStatus.q_xIsHomed			:= (i_pstAxisHome.xHomeValid AND fbMpAxisBasic.IsHomed) OR i_xVelocityControl;
	i_pstStatus.q_stMainAxisStatus.q_xInVelocity		:= fbMpAxisBasic.InVelocity;
	i_pstStatus.q_stMainAxisStatus.q_xInPosition		:= fbMpAxisBasic.InPosition;
	i_pstStatus.q_stMainAxisStatus.q_xMoveActive		:= fbMpAxisBasic.MoveActive;
	
	i_pstStatus.q_stMainAxisStatus.q_xSynchroWithOffset	:= lrTotalPhaseOffset <> 0;
	
	i_pstStatus.q_stMainAxisStatus.q_lrPosition			:= FC_LongRealReminder(fbMpAxisBasic.Position + fbMpAxisBasic.Velocity * rExtrPositionTime, rAxisPeriod, 0);
	i_pstStatus.q_stMainAxisStatus.q_rVelocity			:= fbMpAxisBasic.Velocity;
	i_pstStatus.q_stMainAxisStatus.q_stInfo				:= fbMpAxisBasic.Info;
	i_pstStatus.q_stMainAxisStatus.q_rTotalOffset		:= i_pstAxisHome.rPhaseOffsetValue;
	i_pstStatus.q_stMainAxisStatus.q_xReadyForACommand	:= (eMainAxisStep = AXIS_READY);//v4.A.A.1.6.12f
	
	IF i_pstParameter.i_plrMasterPosition <> 0 AND eMainAxisStep > 10 THEN
		i_pstStatus.q_stMainAxisStatus.q_lrMasterPosition	:= plrMasterPosition;
	END_IF
	
	IF fbMpAxisBasic.Info.CyclicRead.Torque.Valid THEN
		q_lrMainAxisTorque							:= fbMpAxisBasic.Info.CyclicRead.Torque.Value;
		i_pstStatus.q_stMainAxisStatus.q_lrTorque	:= q_lrMainAxisTorque;
	END_IF
	
	tonReadTemperature.PT := CST_timReadTemperature;
	tonReadTemperature.IN := NOT i_pstStatus.q_stMainAxisStatus.q_xPowerSupply AND i_pstStatus.q_stMainAxisStatus.q_xAxisReal AND i_pstStatus.q_stMainAxisStatus.q_xInitDone;

	IF tonReadTemperature.Q THEN
		CASE eReadTempStep OF
			MOTOR:
				IF NOT i_xInductionMotorType AND (NOT i_xThirdPartyMotor OR NOT i_xVelocityControl) THEN
					IF NOT fbReadParID.Execute AND NOT fbReadParID.Done THEN
						fbReadParID.Axis		:= i_pAxisADR;
						fbReadParID.ParID		:= ACP10PAR_TEMP_MOTOR;
						fbReadParID.DataType	:= ncPAR_TYP_REAL;
						fbReadParID.DataAddress := ADR(rTemp);
						fbReadParID.Execute 	:= TRUE;
					ELSIF fbReadParID.Done AND (fbReadParID.ParID = ACP10PAR_TEMP_MOTOR) AND (fbReadParID.Axis = i_pAxisADR) THEN
							i_pstStatus.q_stMainAxisStatus.q_rMotorTemperature := rTemp;
							fbReadParID.Execute 	:= FALSE;
							tonReadTemperature.IN 	:= FALSE;
							eReadTempStep			:= ENCODER;
					END_IF
				ELSE
					IF NOT fbReadParID.Execute AND NOT fbReadParID.Done THEN
						fbReadParID.Axis		:= i_pAxisADR;
						fbReadParID.ParID		:= ACP10PAR_TEMP_MOTOR_MODELL;
						fbReadParID.DataType	:= ncPAR_TYP_REAL;
						fbReadParID.DataAddress := ADR(rTemp);
						fbReadParID.Execute 	:= TRUE;
					ELSIF fbReadParID.Done AND (fbReadParID.ParID = ACP10PAR_TEMP_MOTOR_MODELL) AND (fbReadParID.Axis = i_pAxisADR) THEN
						i_pstStatus.q_stMainAxisStatus.q_rMotorTemperature := rTemp;
						fbReadParID.Execute 	:= FALSE;
						tonReadTemperature.IN 	:= FALSE;
					END_IF
				END_IF
			
			ENCODER:
				IF NOT fbReadParID.Execute AND NOT fbReadParID.Done THEN
					fbReadParID.Axis		:= i_pAxisADR;
					fbReadParID.ParID		:= ACP10PAR_ENCOD_TEMP;
					fbReadParID.DataType	:= ncPAR_TYP_REAL;
					fbReadParID.DataAddress := ADR(rTemp);
					fbReadParID.Execute 	:= TRUE;
				ELSIF fbReadParID.Done AND (fbReadParID.ParID = ACP10PAR_ENCOD_TEMP) AND (fbReadParID.Axis = i_pAxisADR) THEN
					i_pstStatus.q_stMainAxisStatus.q_rEncoderTemperature := rTemp;
					fbReadParID.Execute 	:= FALSE;
					tonReadTemperature.IN 	:= FALSE;
					
					eReadTempStep		:= MOTOR;
				END_IF		
		END_CASE
	END_IF
	
	IF eMainAxisStep <> eMainAxisStepOld THEN
		CASE eMainAxisStep OF
			DISABLE:					strcpy(ADR(q_strMainStep), ADR('Disable'));
			
			INIT:						strcpy(ADR(q_strMainStep), ADR('Init'));
			INIT_1:						strcpy(ADR(q_strMainStep), ADR('Init_1'));
			INIT_2:						strcpy(ADR(q_strMainStep), ADR('Init_2'));
			INIT_3: 					strcpy(ADR(q_strMainStep), ADR('Init_3'));
			INIT_4: 					strcpy(ADR(q_strMainStep), ADR('Init_4'));
			INIT_5: 					strcpy(ADR(q_strMainStep), ADR('Init_5'));
			INIT_6: 					strcpy(ADR(q_strMainStep), ADR('Init_6'));
			INIT_7: 					strcpy(ADR(q_strMainStep), ADR('Init_7'));
			INIT_8: 					strcpy(ADR(q_strMainStep), ADR('Init_8'));
			
			INIT_IND_1:					strcpy(ADR(q_strMainStep), ADR('Init Induction_1'));
			INIT_IND_2:					strcpy(ADR(q_strMainStep), ADR('Init Induction_2'));
			INIT_IND_3: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_3'));
			INIT_IND_4: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_4'));
			INIT_IND_5: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_5'));
			INIT_IND_6: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_6'));
			INIT_IND_7: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_7'));
			INIT_IND_8: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_8'));
			INIT_IND_9: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_9'));
			INIT_IND_10: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_10'));
			INIT_IND_11: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_11'));
			INIT_IND_12: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_12'));
			INIT_IND_13: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_13'));
			INIT_IND_14: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_14'));
			INIT_IND_15: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_15'));
			INIT_IND_16: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_16'));
			INIT_IND_17: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_17'));
			INIT_IND_18: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_18'));
			INIT_IND_19: 				strcpy(ADR(q_strMainStep), ADR('Init Induction_19'));
			
			INIT_THIRD_1:				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_1'));
			INIT_THIRD_2:				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_2'));
			INIT_THIRD_3: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_3'));
			INIT_THIRD_4: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_4'));
			INIT_THIRD_5: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_5'));
			INIT_THIRD_6: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_6'));
			INIT_THIRD_7: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_7'));
			INIT_THIRD_8: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_8'));
			INIT_THIRD_9: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_9'));
			INIT_THIRD_10: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_10'));
			INIT_THIRD_11: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_11'));
			INIT_THIRD_12: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_12'));
			INIT_THIRD_13: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_13'));
			INIT_THIRD_14: 				strcpy(ADR(q_strMainStep), ADR('Init Third Party Motor_14'));
			
			WRITE_I_MAX_ACTION:			strcpy(ADR(q_strMainStep), ADR('Write I Max'));
			READ_BRAKE_PARID:			strcpy(ADR(q_strMainStep), ADR('Read brake ParID'));
			
			READ_ACP_PARID:				strcpy(ADR(q_strMainStep), ADR('Read ACOPOS ParID'));
			READ_ACP_PARID_1:			strcpy(ADR(q_strMainStep), ADR('Read ACOPOS ParID_1'));
			READ_ACP_PARID_2:			strcpy(ADR(q_strMainStep), ADR('Read ACOPOS ParID_2'));
			READ_ACP_PARID_3:			strcpy(ADR(q_strMainStep), ADR('Read ACOPOS ParID_3'));
			READ_ACP_PARID_4:			strcpy(ADR(q_strMainStep), ADR('Read ACOPOS ParID_4'));
			
			MAX_TORQUE_CALCULATION:		strcpy(ADR(q_strMainStep), ADR('Max torque calculation'));
			
			SET_TORQUE_LIMIT:			strcpy(ADR(q_strMainStep), ADR('Set torque limit'));
			SET_TORQUE_LIMIT_1:			strcpy(ADR(q_strMainStep), ADR('Set torque limit_1'));
			SET_TORQUE_LIMIT_2:			strcpy(ADR(q_strMainStep), ADR('Set torque limit_2'));
			SET_TORQUE_LIMIT_3:			strcpy(ADR(q_strMainStep), ADR('Set torque limit_3'));
			SET_TORQUE_LIMIT_4:			strcpy(ADR(q_strMainStep), ADR('Set torque limit_4'));
			
			SET_ACC_LIMIT_1:			strcpy(ADR(q_strMainStep), ADR('Set Acceleration positive limit'));
			SET_ACC_LIMIT_2:			strcpy(ADR(q_strMainStep), ADR('Set Acceleration positive limit'));
			SET_ACC_LIMIT_3:			strcpy(ADR(q_strMainStep), ADR('Set Acceleration negative limit'));
			SET_ACC_LIMIT_4:			strcpy(ADR(q_strMainStep), ADR('Set Acceleration negative limit'));
			SET_ASTOP_LIMIT:			strcpy(ADR(q_strMainStep), ADR('Set Acceleration Stop limit'));
			
			WAIT_FOR_POWER:				strcpy(ADR(q_strMainStep), ADR('Wait for power'));
			
			POWERING:					strcpy(ADR(q_strMainStep), ADR('Powering'));
			
			SYSTEM_HOMING:				strcpy(ADR(q_strMainStep), ADR('System homing'));
			
			WAIT_SECONDARY_AXIS_READY: 	strcpy(ADR(q_strMainStep), ADR('Wait secondary axis ready'));
			
			AXIS_READY:					strcpy(ADR(q_strMainStep), ADR('Ready'));//v4.A.A.1.6.12f
			
			ENDLESS_RUN1:				strcpy(ADR(q_strMainStep), ADR('Endless run'));
			ENDLESS_RUN2:				strcpy(ADR(q_strMainStep), ADR('Endless run'));
			ENDLESS_GEAR_STOP:			strcpy(ADR(q_strMainStep), ADR('Endless Gear Stop'));
			
			SLOW_MOTION:				strcpy(ADR(q_strMainStep), ADR('Slow motion'));
			
			JOG_POSITIVE:				strcpy(ADR(q_strMainStep), ADR('Jog positive'));
			
			MOVE_ADDITIVE:				strcpy(ADR(q_strMainStep), ADR('Move additive'));
			
			GEAR_VELOCITY:				strcpy(ADR(q_strMainStep), ADR('Gear Velocity'));
			GEAR_VELOCITY_1:			strcpy(ADR(q_strMainStep), ADR('Gear Velocity 1'));
			GEAR_VELOCITY_2:			strcpy(ADR(q_strMainStep), ADR('Gear Velocity 2'));
			GEAR_VELOCITY_3:			strcpy(ADR(q_strMainStep), ADR('Gear Velocity 3'));
			GEAR_VELOCITY_4:			strcpy(ADR(q_strMainStep), ADR('Gear Velocity 4'));
			GEAR_VELOCITY_5:			strcpy(ADR(q_strMainStep), ADR('Gear Velocity 5'));
			
			GEAR:						strcpy(ADR(q_strMainStep), ADR('GEAR'));
			GEAR_1:						strcpy(ADR(q_strMainStep), ADR('GEAR_1'));
			GEAR_2:						strcpy(ADR(q_strMainStep), ADR('GEAR_2'));
			GEAR_3:						strcpy(ADR(q_strMainStep), ADR('GEAR_3'));
			GEAR_4:						strcpy(ADR(q_strMainStep), ADR('GEAR_4'));
			
			ONE_PITCH_SHIFT:			strcpy(ADR(q_strMainStep), ADR('One pitch shift'));
			
			VELOCITY_SHIFT:				strcpy(ADR(q_strMainStep), ADR('VELOCITY SHIFT'));
			
			HOMING_1:					strcpy(ADR(q_strMainStep), ADR('Homing'));
			HOMING_2:					strcpy(ADR(q_strMainStep), ADR('Homing'));
			HOMING_3:					strcpy(ADR(q_strMainStep), ADR('Homing'));
			HOMING_4:					strcpy(ADR(q_strMainStep), ADR('Homing'));
			
			WAIT_HOMING_DONE:			strcpy(ADR(q_strMainStep), ADR('Wait homing done'));
			
			STOP:						strcpy(ADR(q_strMainStep), ADR('STOP'));
			QUICK_STOP:					strcpy(ADR(q_strMainStep), ADR('QUICK STOP'));
			SLOW_DOWN:					strcpy(ADR(q_strMainStep), ADR('SLOW DOWN'));
			STOP_IN_PHASE:				strcpy(ADR(q_strMainStep), ADR('STOP IN PHASE'));
			WAIT_FOR_STOPPED:			strcpy(ADR(q_strMainStep), ADR('WAIT FOR STOPPED'));
			NO_MOVE_POWER_OFF:			strcpy(ADR(q_strMainStep), ADR('NO MOVE POWER OFF'));
			STOPPED:					strcpy(ADR(q_strMainStep), ADR('STOPPED'));
			BRAKE_RELEASE:				strcpy(ADR(q_strMainStep), ADR('BRAKE RELEASE'));
			BRAKE_RELEASE_1:			strcpy(ADR(q_strMainStep), ADR('BRAKE RELEASE 1'));
				
			AXIS_ERROR:					strcpy(ADR(q_strMainStep), ADR('ERROR'));
			
			WAIT_FOR_CONNECTION: 		strcpy(ADR(q_strMainStep), ADR('Wait for connection'));
		
			INDUCTION_MOTOR_SETUP: 		strcpy(ADR(q_strMainStep), ADR('Induction motor setup'));
			INDUCTION_MOTOR_SETUP_1: 	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_1'));
			INDUCTION_MOTOR_SETUP_2: 	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_2'));
			INDUCTION_MOTOR_SETUP_3: 	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_3'));
			INDUCTION_MOTOR_SETUP_4: 	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_4'));
			INDUCTION_MOTOR_SETUP_5: 	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_5'));
			INDUCTION_MOTOR_SETUP_6: 	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_6'));
			INDUCTION_MOTOR_SETUP_7: 	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_7'));
			INDUCTION_MOTOR_SETUP_8: 	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_8'));
			INDUCTION_MOTOR_SETUP_9: 	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_9'));
			INDUCTION_MOTOR_SETUP_10:	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_10'));
			INDUCTION_MOTOR_SETUP_11:	strcpy(ADR(q_strMainStep), ADR('Induction motor setup_11'));
			
			MOTOR_PHASING: 				strcpy(ADR(q_strMainStep), ADR('Wait for connection'));
			MOTOR_PHASING_1: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_1'));
			MOTOR_PHASING_2: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_2'));
			MOTOR_PHASING_3: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_3'));
			MOTOR_PHASING_4: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_4'));
			MOTOR_PHASING_5: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_5'));
			MOTOR_PHASING_6: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_6'));
			MOTOR_PHASING_7: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_7'));
			MOTOR_PHASING_8: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_8'));
			MOTOR_PHASING_9: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_9'));
			MOTOR_PHASING_10: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_10'));
			MOTOR_PHASING_11: 			strcpy(ADR(q_strMainStep), ADR('Wait for connection_11'));
				
			ELSE
				strcpy(ADR(q_strMainStep), ADR('Unknown Step'));
		END_CASE
		eMainAxisStepOld	:= eMainAxisStep;
	END_IF
END_ACTION

ACTION Act_SetOverride:
	IF NOT xWaitForVelocity AND rOldTargetSpeed <> stBasicParameter.Velocity THEN
		tonWaitOverride.IN 	:= TRUE;
		xWaitForVelocity	:= TRUE;
		tonWaitOverride.PT	:= T#20ms;
	END_IF
	tonWaitOverride();

	IF tonWaitOverride.Q THEN
		tonWaitOverride.IN 	:= FALSE;
		rOldTargetSpeed 	:= stBasicParameter.Velocity;
		xWaitForVelocity 	:= FALSE;
	END_IF
	
	IF i_pstStatus.q_stMainAxisStatus.q_ePLCopenStatus = mpAXIS_ERRORSTOP OR (i_xVelocityControl AND i_pstCmd.i_xGear) THEN
		fbSetOverride.AccFactor	:= 1.0;
		xRampDown				:= FALSE;
		usiDebug				:= 1;
	ELSIF i_pstCmd.i_xShutdown THEN
		fbSetOverride.AccFactor	:= i_pstParameter.i_rShutdownDeceleration /	stBasicParameter.Deceleration;
		xRampDown				:= FALSE;
		usiDebug				:= 2;
	ELSIF fbMpAxisBasic.Stop OR eMainAxisStep = STOP_IN_PHASE THEN (* Positioning for stop in phase *)
		fbSetOverride.AccFactor	:= 1.0;
		rAcc					:= 0;
		rTime 					:= 0;
		xTimeInitialized		:= TRUE;
		xRampDown				:= FALSE;
		usiDebug				:= 3;
	ELSIF fbMpAxisBasic.MoveAbsolute OR fbMpAxisBasic.MoveAdditive OR 
		i_pstStatus.q_stMainAxisStatus.q_ePLCopenStatus = mpAXIS_DISCRETE_MOTION OR eMainAxisStep = GEAR_1 OR eMainAxisStep = MOVE_ADDITIVE THEN
		
		fbSetOverride.AccFactor := rSetAcceleration/stBasicParameter.Acceleration;
		rAcc					:= 0;
		rTime 					:= 0;
		xTimeInitialized		:= TRUE;
		xRampDown				:= FALSE;
		usiDebug				:= 4;
	ELSIF i_pstStatus.q_stMainAxisStatus.q_ePLCopenStatus = mpAXIS_CONTINUOUS_MOTION OR
		(i_pstStatus.q_stMainAxisStatus.q_ePLCopenStatus = mpAXIS_SYNCHRONIZED_MOTION AND fbMpAxisBasic.MoveVelocity) THEN
		IF fbMpAxisBasic.InVelocity THEN
			fbSetOverride.AccFactor := 0;
			rAcc					:= 0;
			rTime 					:= 0;
			xTimeInitialized		:= TRUE;
			xRampDown				:= FALSE;
			usiDebug				:= 5;
		ELSIF NOT fbMpAxisBasic.Update AND NOT fbMpAxisBasic.UpdateDone AND (NOT xWaitForVelocity OR i_pstCmd.i_xShutdown) THEN
			IF stBasicParameter.Velocity > (fbMpAxisBasic.Velocity + 0.5) THEN
				(*** ACCELERATION ***)
				IF i_pstParameter.i_rEndlessJerk > 0 AND xJerkControl THEN
					IF (stBasicParameter.Velocity - fbMpAxisBasic.Velocity) < (rAcc * rAcc) / (2 * i_pstParameter.i_rEndlessJerk) THEN
						(* Ramp Down *)
						rTime				:= MAX(rTime - UDINT_TO_REAL(fbRTInfo.cycle_time) / 1000.0, 0.0);
						rAcc				:= SQRT(2 * i_pstParameter.i_rEndlessJerk * ABS(fbMpAxisBasic.Velocity - stBasicParameter.Velocity));
						usiDebug			:= 6;
					ELSIF rAcc >= rSetAcceleration THEN
						(* Constant acceleration *)
						rAcc 				:= rSetAcceleration;
						usiDebug			:= 7;
					ELSIF xTimeInitialized THEN
						(* Ramp up*)
						rTime				:= rTime + UDINT_TO_REAL(fbRTInfo.cycle_time) / 1000.0;
						rAcc 				:= MIN(i_pstParameter.i_rEndlessJerk * rTime / 1000.0, rSetAcceleration);
						usiDebug			:= 8;
					ELSE
						rTime 				:= 0;
						rAcc				:= 0;
						xTimeInitialized	:= TRUE;
						usiDebug			:= 9;
					END_IF
				ELSE
					rAcc 					:= rSetAcceleration;
					rTime 					:= 0;
					xTimeInitialized		:= FALSE;
					usiDebug				:= 10;
				END_IF
				
				fbSetOverride.AccFactor 	:= rAcc/stBasicParameter.Acceleration;
				
			ELSIF stBasicParameter.Velocity < (fbMpAxisBasic.Velocity - 0.5) THEN
				(*** DECELERATION ***)
				IF i_pstParameter.i_rEndlessJerk > 0 AND xJerkControl AND NOT i_pstCmd.i_xShutdown THEN
					IF (fbMpAxisBasic.Velocity - stBasicParameter.Velocity) < (rAcc * rAcc) / (2 * i_pstParameter.i_rEndlessJerk) OR xRampDown THEN
						(* Ramp Down *)
						rTime				:= MAX(rTime - UDINT_TO_REAL(fbRTInfo.cycle_time) / 1000.0, 0.0);
						rAcc 				:= SQRT(2 * i_pstParameter.i_rEndlessJerk * ABS(stBasicParameter.Velocity - fbMpAxisBasic.Velocity));
						xRampDown			:= TRUE;
						usiDebug			:= 11;
					ELSIF rAcc >= rSetDeceleration THEN
						(* Constant deceleration *)
						rAcc 				:= rSetDeceleration;
						usiDebug			:= 12;
					ELSIF xTimeInitialized AND NOT xRampDown THEN
						(* Ramp up*)
						rTime				:= rTime + UDINT_TO_REAL(fbRTInfo.cycle_time) / 1000.0;
						rAcc 				:= MIN(i_pstParameter.i_rEndlessJerk * rTime / 1000.0, rSetDeceleration);
						usiDebug			:= 13;
					ELSE
						rTime				:= 0;
						rAcc				:= 0;
						xTimeInitialized	:= TRUE;
						usiDebug			:= 14;
					END_IF
				ELSE
					rAcc 					:= rSetDeceleration;
					rTime 					:= 0;
					xTimeInitialized		:= FALSE;
					usiDebug				:= 15;
				END_IF
				fbSetOverride.AccFactor 	:= rAcc/stBasicParameter.Deceleration;
			END_IF
		ELSIF xWaitForVelocity AND rAcc <= 0.5 THEN
			xTimeInitialized		:= FALSE;
			usiDebug				:= 17;
		END_IF
	ELSIF i_pstStatus.q_stMainAxisStatus.q_xStopped	AND i_pstStatus.q_stMainAxisStatus.q_ePLCopenStatus = mpAXIS_STANDSTILL THEN
		usiDebug				:= 19;

		fbSetOverride.AccFactor := 0;
		rAcc					:= 0;
		rTime 					:= 0;
		xTimeInitialized		:= TRUE;
		xRampDown				:= FALSE;
	ELSE
		fbSetOverride.AccFactor := 1;
		rTime 					:= 0;
		rAcc					:= 0;
		xTimeInitialized		:= TRUE;
		usiDebug				:= 20;
	END_IF
	
	fbSetOverride.AccFactor := LIMIT(0.0001, fbSetOverride.AccFactor, 1.0);
	fbSetOverride();
END_ACTION
