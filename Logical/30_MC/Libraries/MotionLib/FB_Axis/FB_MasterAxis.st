FUNCTION_BLOCK FB_MasterAxis
	(* The master position is built from the external struct *)
	IF i_xExternalEncoder OR i_xExternalPositionFormat THEN//V4.A.A.1.7.0
		diMasterPosition	:= i_pstExtEncoderPosition;
	ELSE
		diMasterPosition	:= LREAL_TO_DINT(i_pstMasterPositionStruct.VLab_LRealPosition * 100); //0..36000 * 100 to reach 0..3600000
	END_IF
	
	IF i_uiNumberOfSteps = 0 THEN
		i_uiNumberOfSteps := 1;
	END_IF
	
	IF i_udiExternalSignalPeriod = 0 THEN
		i_udiExternalSignalPeriod	:= 3600000;
	END_IF
	
	(* Master communication fault, Master Encoder not referenced *)
	IF eDigitalSynchroStep > SYNCHRO_INIT THEN
		IF NOT i_xEnable THEN	//V4.A.A.1.6.10
			eDigitalSynchroStep := SYNCHRO_INIT;
		ELSIF NOT i_xCmdEnableCurves AND eDigitalSynchroStep < ERROR THEN
			eDigitalSynchroStep	:= ERROR;
		ELSIF fbWriteParID.Error THEN //Read ParID error
			eDigitalSynchroStep	:= ERROR;
		ELSIF fbCyclicWrite_ExtrEncPos.Error	OR fbCyclicWrite_RefExtrEncPos.Error 
			OR fbCyclicRead_ScaledPos.Error		OR fbCyclicRead_ModuloPos.Error 		OR fbCyclicRead_RefModuloPos.Error THEN //Cyclic communication error
			
			eDigitalSynchroStep	:= ERROR;
		END_IF
	END_IF

	fbRTInfo.enable	:= TRUE;	//V4.A.A.1.6.10
	fbRTInfo();	//V4.A.A.1.6.10
	
	CASE eDigitalSynchroStep OF
		SYNCHRO_INIT:
			i_pstParameter.i_pdiMasterScaledPos	:= ADR(diMasterScaledPos);
			i_pstParameter.i_plrMasterPosition	:= ADR(lrExternalRefPosition);
			i_pstParameter.i_prMasterVelocity	:= ADR(rExternalRefVelocity);
			i_pstParameter.i_xMachineMaster		:= TRUE;
			
			i_pstParameter.i_uiMasterParId		:= ACP10PAR_CURVE_VALUE_I4 + 1;
		
			TON_WaitCurveStabilization.PT		:= T#500ms; // Wait for CURVE FBK stable output
			TON_WaitCurveStabilization.IN		:= FALSE;
	
			fbPeriodicToContinuePosition.i_xEnable 	:= FALSE;
			
			(* === Parameters for cyclic data exchange between plc and drive === *)
			fbCyclicRead_ScaledPos.Axis				:= i_pAxisADR;
			fbCyclicRead_ScaledPos.ParID			:= ACP10PAR_CURVE_VALUE_I4 +1;
			fbCyclicRead_ScaledPos.DataAddress		:= ADR(diMasterScaledPos);
			fbCyclicRead_ScaledPos.DataType			:= ncPAR_TYP_DINT;
			fbCyclicRead_ScaledPos.Mode				:= mcEVERY_RECORD;
			fbCyclicRead_ScaledPos.Enable			:= FALSE;
	
			fbCyclicRead_ModuloPos.Axis				:= i_pAxisADR;
			fbCyclicRead_ModuloPos.ParID			:= ACP10PAR_CURVE_VALUE_REL_I4 +1;
			fbCyclicRead_ModuloPos.DataAddress		:= ADR(diMasterModuloPos);
			fbCyclicRead_ModuloPos.DataType			:= ncPAR_TYP_DINT;
			fbCyclicRead_ModuloPos.Mode				:= mcEVERY_RECORD;
			fbCyclicRead_ModuloPos.Enable			:= FALSE;
			
			fbCyclicWrite_ExtrEncPos.Axis			:= i_pAxisADR;
			fbCyclicWrite_ExtrEncPos.ParID			:= ACP10PAR_VAR_I4_0;
			fbCyclicWrite_ExtrEncPos.DataAddress	:= ADR(diMasterPosToSpt);
			fbCyclicWrite_ExtrEncPos.DataType		:= ncPAR_TYP_DINT;
			fbCyclicWrite_ExtrEncPos.Mode			:= mcEVERY_RECORD;
			fbCyclicWrite_ExtrEncPos.Enable			:= FALSE;
		
			(* === Non - Filtered parameter computation for positioning error check === *) 
			fbCyclicWrite_RefExtrEncPos.Axis		:= i_pAxisADR;
			fbCyclicWrite_RefExtrEncPos.ParID		:= ACP10PAR_VAR_I4_3;
			fbCyclicWrite_RefExtrEncPos.DataAddress	:= ADR(diRefExtrEncPos);
			fbCyclicWrite_RefExtrEncPos.DataType	:= ncPAR_TYP_DINT;
			fbCyclicWrite_RefExtrEncPos.Mode		:= mcEVERY_RECORD;
			fbCyclicWrite_RefExtrEncPos.Enable		:= FALSE;
		
			fbCyclicRead_RefModuloPos.Axis			:= i_pAxisADR;
			fbCyclicRead_RefModuloPos.ParID			:= ACP10PAR_CURVE_VALUE_REL_I4 +4;
			fbCyclicRead_RefModuloPos.DataAddress	:= ADR(diRefModuloPos);
			fbCyclicRead_RefModuloPos.DataType		:= ncPAR_TYP_DINT;	
//			fbCyclicRead_RefModuloPos.Mode			:= mcEVERY_RECORD;	V 1.1
			fbCyclicRead_RefModuloPos.Enable		:= FALSE;
		
			IF i_xEnable THEN
				eDigitalSynchroStep		:= CURVES_DISABLE;
			END_IF
					
		CURVES_DISABLE:
			IF NOT fbWriteParID.Busy THEN
				uiCurveMode					:= 0; //DISABLE
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.DataAddress	:= ADR(uiCurveMode);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_MODE + 0;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_MODE + 0 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= CURVES_DISABLE_1;
			END_IF
		
		CURVES_DISABLE_1:
			IF NOT fbWriteParID.Busy THEN
				uiCurveMode					:= 0; //DISABLE
				fbWriteParID.DataAddress	:= ADR(uiCurveMode);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_MODE + 1;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_MODE + 1 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= CURVES_DISABLE_2;
			END_IF
		
		CURVES_DISABLE_2:
			IF NOT fbWriteParID.Busy THEN
				uiCurveMode					:= 0; //DISABLE
				fbWriteParID.DataAddress	:= ADR(uiCurveMode);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_MODE + 3;
				fbWriteParID.Execute		:= TRUE;	
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_MODE + 3 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= CURVES_DISABLE_3;
			END_IF
		
		CURVES_DISABLE_3:
			IF NOT fbWriteParID.Busy THEN
				uiCurveMode					:= 0; //DISABLE
				fbWriteParID.DataAddress	:= ADR(uiCurveMode);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_MODE + 4;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_MODE + 4 THEN
				TON_WaitCurveStabilization.IN	:= FALSE;
				fbWriteParID.Execute			:= FALSE;
				eDigitalSynchroStep				:= ZERO_OFFSET;
			END_IF
			
		(* In order to be sure that the OFFSET is zero at the startup the value is force *)
		ZERO_OFFSET:			
			IF NOT fbWriteParID.Busy THEN
				q_diOffsetModuloPos			:= 0;
				fbWriteParID.DataAddress	:= ADR(q_diOffsetModuloPos);
				fbWriteParID.DataType		:= ncPAR_TYP_DINT;
				fbWriteParID.ParID			:= ACP10PAR_VAR_I4_1 +0;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_VAR_I4_1 + 0 THEN
				fbWriteParID.Execute 	:= FALSE;
				q_xPositionRestored 	:= TRUE;
				eDigitalSynchroStep 	:= WRITE_MA_PERIOD;
			END_IF
		
		WRITE_MA_PERIOD:
			IF NOT fbWriteParID.Busy THEN
				diMasterPeriod				:= i_udiExternalSignalPeriod;
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.DataAddress	:= ADR(diMasterPeriod);
				fbWriteParID.DataType		:= ncPAR_TYP_DINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_X_FACTOR + 0;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_X_FACTOR + 0 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= WRITE_MA_PERIOD_1;
			END_IF
		
		WRITE_MA_PERIOD_1:
			IF NOT fbWriteParID.Busy THEN
				diMasterPeriod				:= i_udiExternalSignalPeriod;
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.DataAddress	:= ADR(diMasterPeriod);
				fbWriteParID.DataType		:= ncPAR_TYP_DINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_X_FACTOR + 3;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_X_FACTOR + 3 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= WRITE_SL_PERIOD;
			END_IF
		
		WRITE_SL_PERIOD:
			IF NOT fbWriteParID.Busy THEN
				diSlavePeriod				:= i_uiNumberOfSteps * 360 * c_uiAxisFactor;
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.DataAddress	:= ADR(diSlavePeriod);
				fbWriteParID.DataType		:= ncPAR_TYP_DINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_Y_FACTOR + 0;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_Y_FACTOR + 0 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= WRITE_SL_PERIOD_1;
			END_IF
		
		WRITE_SL_PERIOD_1:
			IF NOT fbWriteParID.Busy THEN
				diSlavePeriod				:= i_uiNumberOfSteps * 360 * c_uiAxisFactor;
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.DataAddress	:= ADR(diSlavePeriod);
				fbWriteParID.DataType		:= ncPAR_TYP_DINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_Y_FACTOR + 3;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_Y_FACTOR + 3 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= INIT_FILTERS;
			END_IF
		
		INIT_FILTERS:
			lrFilterTime 	:= UINT_TO_LREAL(i_uiFilteringCoefficient) * c_rTf_min; (* s *)
			lrExtrTime 		:= (UDINT_TO_LREAL(fbRTInfo.cycle_time) / 1E6) * UINT_TO_LREAL(i_uiNumberOfEplCycles) + c_timCompensationIPL; (* s *)	//V4.A.A.1.6.10
			
			(* Periodic to continue position enable *)
			fbPeriodicToContinuePosition.i_xEnable 	:= TRUE;
			
			(* Reference filter enable *)
			(* The enable is done only in case of i_uiFilteringCoefficient > 0 *)
				
			fbEXTR_RefFilter.Enable		:= lrFilterTime > 0;
			
			(* Extrapolation filter enable *)
			fbPT1_EncFilter.Enable 		:= fbEXTR_RefFilter.Enable;
			
			IF i_udiExternalSignalPeriod > 0 THEN
				diInitialOffset	:= diMasterPosition - (diMasterPosition MOD UDINT_TO_DINT(i_udiExternalSignalPeriod));
			END_IF
			
			IF fbEXTR_RefFilter.Enable AND fbPT1_EncFilter.Enable THEN
				IF fbPT1_EncFilter.Valid THEN
					fbEXTR_EncFilter.Enable	:= TRUE;
					IF fbEXTR_EncFilter.Valid AND fbEXTR_RefFilter.Valid THEN
						TON_WaitCurveStabilization.IN	:= FALSE;
						eDigitalSynchroStep 			:= DISABLE_IPL;
					END_IF
				END_IF
			ELSE
				TON_WaitCurveStabilization.IN	:= FALSE;
				eDigitalSynchroStep 			:= DISABLE_IPL;
			END_IF
		
		DISABLE_IPL:
			IF NOT fbWriteParID.Busy THEN
				uiIPLMode					:= 0;
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.DataAddress	:= ADR(uiIPLMode);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_IPL_MODE + 0;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			TON_WaitCurveStabilization.IN	:= fbWriteParID.Done;
			TON_WaitCurveStabilization.PT	:= T#0.5S;
			
			IF TON_WaitCurveStabilization.Q AND fbWriteParID.ParID = ACP10PAR_IPL_MODE + 0 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= INIT_CYCLIC_READ_WRITE;
			END_IF

		INIT_CYCLIC_READ_WRITE:
			fbCyclicWrite_ExtrEncPos.Enable		:= TRUE;
			fbCyclicWrite_RefExtrEncPos.Enable	:= TRUE;
			
			fbCyclicRead_ScaledPos.Enable		:= TRUE;
			fbCyclicRead_ModuloPos.Enable 		:= TRUE;
			fbCyclicRead_RefModuloPos.Enable	:= TRUE;
		
			q_xCyclicComValid	:= fbCyclicWrite_ExtrEncPos.Valid AND fbCyclicWrite_RefExtrEncPos.Valid AND fbCyclicRead_ScaledPos.Valid AND
									fbCyclicRead_ModuloPos.Valid AND fbCyclicRead_RefModuloPos.Valid;
			
			IF fbCyclicWrite_ExtrEncPos.Error OR fbCyclicWrite_RefExtrEncPos.Error OR fbCyclicRead_ScaledPos.Error OR fbCyclicRead_ModuloPos.Error OR fbCyclicRead_RefModuloPos.Error THEN
				q_xCyclicComValid 	:= FALSE;
				eDigitalSynchroStep := ERROR;
			ELSIF q_xCyclicComValid THEN
				TON_WaitCurveStabilization.IN	:= FALSE;
				eDigitalSynchroStep 			:= WRITE_IPL_CYCLIE_TIME;
			END_IF
				
		WRITE_IPL_CYCLIE_TIME:
			IF NOT fbWriteParID.Busy THEN
				
				IF i_xExternalEncoder THEN
					udiCycleTime				:= fbRTInfo.cycle_time * 10;	//V4.A.A.1.6.10
				ELSIF i_xExternalPositionFormat THEN//V4.A.A.1.7.0
					udiCycleTime				:= fbRTInfo.cycle_time * 2;//V4.A.A.1.7.0
				ELSE
					udiCycleTime				:= fbRTInfo.cycle_time;	//V4.A.A.1.6.10
				END_IF
				
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.DataAddress	:= ADR(udiCycleTime);
				fbWriteParID.DataType		:= ncPAR_TYP_UDINT;
				fbWriteParID.ParID			:= ACP10PAR_IPL_CYCLE_TIME + 0;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_IPL_CYCLE_TIME + 0 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= ENABLE_IPL;
			END_IF
		
		ENABLE_IPL:
			IF NOT fbWriteParID.Busy THEN
				uiIPLMode					:= 1;
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.DataAddress	:= ADR(uiIPLMode);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_IPL_MODE + 0;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			TON_WaitCurveStabilization.IN	:= fbWriteParID.Done;
			TON_WaitCurveStabilization.PT	:= T#0.5S;
			
			IF TON_WaitCurveStabilization.Q AND fbWriteParID.ParID = ACP10PAR_IPL_MODE + 0 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= CURVES_ENABLE;
			END_IF
		
		CURVES_ENABLE:
			IF NOT fbWriteParID.Busy THEN
				uiCurveMode					:= 2;
				fbWriteParID.Axis			:= i_pAxisADR;
				fbWriteParID.DataAddress	:= ADR(uiCurveMode);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_MODE + 0;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_MODE + 0 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= CURVES_ENABLE_1;
			END_IF
		
		CURVES_ENABLE_1:
			IF NOT fbWriteParID.Busy THEN
				uiCurveMode					:= 2;
				fbWriteParID.DataAddress	:= ADR(uiCurveMode);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_MODE + 1;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_MODE + 1 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= CURVES_ENABLE_2;
			END_IF
		
		CURVES_ENABLE_2:
			IF NOT fbWriteParID.Busy THEN
				uiCurveMode					:= 2;
				fbWriteParID.DataAddress	:= ADR(uiCurveMode);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_MODE + 3;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_MODE + 3 THEN
				fbWriteParID.Execute	:= FALSE;
				eDigitalSynchroStep		:= CURVES_ENABLE_3;
			END_IF
		
		CURVES_ENABLE_3:
			IF NOT fbWriteParID.Busy THEN
				uiCurveMode					:= 2;
				fbWriteParID.DataAddress	:= ADR(uiCurveMode);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_CURVE_MODE + 4;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CURVE_MODE + 4 THEN
				fbWriteParID.Execute			:= FALSE;
				TON_WaitCurveStabilization.IN	:= FALSE;
				eDigitalSynchroStep				:= WAIT_CURVES_STABILIZATION;
			END_IF
		
		WAIT_CURVES_STABILIZATION:
			IF diOldScaledPos = diMasterScaledPos AND diOldModuloPos = diMasterModuloPos THEN
				TON_WaitCurveStabilization.IN	:= TRUE;
				IF TON_WaitCurveStabilization.Q THEN
					TON_WaitCurveStabilization.IN	:= FALSE;
					q_xPositionValid 				:= TRUE;
					eDigitalSynchroStep				:= RESTORE_CALIBRATION_OFFSET;
				END_IF
			ELSE
				TON_WaitCurveStabilization.IN := FALSE;
				diOldScaledPos := diMasterScaledPos;
				diOldModuloPos := diMasterModuloPos;
			END_IF
		
		RESTORE_CALIBRATION_OFFSET:
			IF NOT fbWriteParID.Busy THEN
				q_diOffsetModuloPos			:= i_pstAbsEncPerm.diAbsEncOffset;
				fbWriteParID.DataAddress	:= ADR(q_diOffsetModuloPos);
				fbWriteParID.DataType		:= ncPAR_TYP_DINT;
				fbWriteParID.ParID			:= ACP10PAR_VAR_I4_1 +0;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_VAR_I4_1 + 0 THEN
				fbWriteParID.Execute := FALSE;
				
				q_xPositionRestored := TRUE;
				eDigitalSynchroStep := ABS_ENC_READY;
			END_IF
		
		ABS_ENC_READY:
			q_xCyclicComValid	:= fbCyclicWrite_ExtrEncPos.Valid AND fbCyclicWrite_RefExtrEncPos.Valid AND fbCyclicRead_ScaledPos.Valid AND
									fbCyclicRead_ModuloPos.Valid AND fbCyclicRead_RefModuloPos.Valid;
						
			IF NOT q_xCyclicComValid OR NOT i_xCmdEnableCurves THEN
				eDigitalSynchroStep		:= ERROR;
			ELSIF i_pstStatus.q_stMainAxisStatus.q_xSynchroWithOffset AND i_pstCmd.i_xPhaseCompensation THEN //V4.A.A.1.6.10
				eDigitalSynchroStep		:= OFFSET_RESET;
			ELSIF i_xCmdHoming THEN
				eDigitalSynchroStep		:= CALIBRATION;
			END_IF
			
		OFFSET_RESET:
			q_diOffsetModuloPos	:= REAL_TO_DINT(i_pstAxisHome.rPhaseOffsetValue * c_uiAxisFactor) + i_pstAbsEncPerm.diAbsEncOffset;
			
			i_pstAxisHome.rPhaseOffsetValue		:= 0;
			i_pstAbsEncPerm.diAbsEncOffset		:= q_diOffsetModuloPos;
			i_pstAbsEncPerm.xCalibrationDone	:= FALSE;
			eDigitalSynchroStep					:= WRITE_NEW_CALIBRATION_VALUE;
		
		CALIBRATION:
			q_diOffsetModuloPos := LREAL_TO_DINT(i_pstStatus.q_stMainAxisStatus.q_lrPosition * c_uiAxisFactor) - diRefModuloPos;
			
			IF q_diOffsetModuloPos < 0 THEN
				q_diOffsetModuloPos := q_diOffsetModuloPos + 36000;
			END_IF
			
			i_pstAbsEncPerm.diAbsEncOffset		:= q_diOffsetModuloPos;
			i_pstAbsEncPerm.xCalibrationDone	:= FALSE;
		
			eDigitalSynchroStep 	:= WRITE_NEW_CALIBRATION_VALUE;

		WRITE_NEW_CALIBRATION_VALUE:
			IF NOT fbWriteParID.Busy THEN
				fbWriteParID.Axis			:= i_pAxisADR; 
				fbWriteParID.DataAddress	:= ADR(q_diOffsetModuloPos);
				fbWriteParID.DataType		:= ncPAR_TYP_DINT;
				fbWriteParID.ParID			:= ACP10PAR_VAR_I4_1;
				fbWriteParID.Execute		:= TRUE;	
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_VAR_I4_1 AND NOT i_pstCmd.i_xPhaseCompensation AND NOT i_xCmdHoming THEN
				fbWriteParID.Execute 				:= FALSE;
				i_pstAbsEncPerm.xCalibrationDone	:= TRUE;
				q_xPositionRestored					:= TRUE;
				eDigitalSynchroStep					:= WAIT_CURVES_STABILIZATION;
			END_IF
				
		(*****************************************)
		ERROR:
			q_xPositionRestored						:= FALSE;
			q_xCyclicComValid						:= FALSE;
			q_xPositionValid  						:= FALSE;	

			TON_WaitCurveStabilization.IN 			:= FALSE;
			fbPeriodicToContinuePosition.i_xEnable 	:= FALSE;
			
			IF i_pstCmd.i_xErrorReset THEN
				fbCyclicWrite_ExtrEncPos.Enable		:= FALSE;
				fbCyclicWrite_RefExtrEncPos.Enable	:= FALSE;
		
				fbCyclicRead_ScaledPos.Enable		:= FALSE;
				fbCyclicRead_ModuloPos.Enable 		:= FALSE;
				fbCyclicRead_RefModuloPos.Enable	:= FALSE;
			
				fbPT1_EncFilter.Enable 	:= FALSE;
				fbEXTR_EncFilter.Enable	:= FALSE;
				fbEXTR_RefFilter.Enable	:= FALSE;
				IF fbWriteParID.Error THEN
					fbWriteParID.Execute := FALSE;
				END_IF
			END_IF
			
			IF NOT fbCyclicWrite_ExtrEncPos.Error AND NOT fbCyclicWrite_RefExtrEncPos.Error AND NOT fbCyclicRead_ScaledPos.Error AND
				NOT fbCyclicRead_ModuloPos.Error AND NOT fbCyclicRead_RefModuloPos.Error AND NOT fbWriteParID.Error THEN
				
				eDigitalSynchroStep := ERROR_1;
			END_IF
			
		ERROR_1: (* Wait Master data are OK *)
			IF i_xCmdEnableCurves THEN
				eDigitalSynchroStep := CURVES_DISABLE;
			END_IF
	END_CASE

	(* Timer for curve stabilization *)
	TON_WaitCurveStabilization();
	
	fbWriteParID();
	
	fbCyclicRead_ScaledPos();
	fbCyclicRead_ModuloPos();
	fbCyclicRead_RefModuloPos();
	fbCyclicWrite_ExtrEncPos();
	fbCyclicWrite_RefExtrEncPos();
	
	(* Periodic TO Continue DINT position *)
	IF NOT i_xExternalEncoder THEN
		fbPeriodicToContinuePosition.i_diInPosition	:= diMasterPosition;
		fbPeriodicToContinuePosition.i_udiPeriod	:= i_udiExternalSignalPeriod;
		fbPeriodicToContinuePosition();
	END_IF
	
	IF fbPT1_EncFilter.Enable THEN
		IF NOT i_xExternalEncoder THEN (* External Value filtering *)
			fbPT1_EncFilter.T1	:= lrFilterTime;
			fbPT1_EncFilter.U	:= fbPeriodicToContinuePosition.q_diPosition;
		ELSE (* External Value filtering *)
			fbPT1_EncFilter.T1	:= lrFilterTime;
			fbPT1_EncFilter.U	:= (diMasterPosition - diInitialOffset);
		END_IF

		fbPT1_EncFilter();
		
		(* External value extrapolation *)
		fbEXTR_EncFilter.T_ext	:= lrExtrTime + lrFilterTime;
		fbEXTR_EncFilter.U		:= fbPT1_EncFilter.X;
		fbEXTR_EncFilter();
		
		(* External Value filtering *)
		IF NOT i_xExternalEncoder THEN 
			diMasterPosToSpt	 	:= fbEXTR_EncFilter.X;
		ELSE
			uiMasterPositionSampling := uiMasterPositionSampling + 1;	//v1.2
			IF uiMasterPositionSampling >= 10 THEN				//v1.2
				diMasterPosToSpt	 	:= fbEXTR_EncFilter.X;
				uiMasterPositionSampling	:= 0;			//v1.2
			END_IF
		END_IF
			
		(* Non-filtered position extrapolation *)
		IF NOT i_xExternalEncoder THEN (* External Value filtering *)
			fbEXTR_RefFilter.T_ext	:= lrExtrTime;
			fbEXTR_RefFilter.U	:= fbPeriodicToContinuePosition.q_diPosition;
		ELSE (* External Value filtering *)
			fbEXTR_RefFilter.T_ext	:= lrExtrTime;
			fbEXTR_RefFilter.U	:= (diMasterPosition - diInitialOffset);
		END_IF
		fbEXTR_RefFilter();
			
		diRefExtrEncPos			:= fbEXTR_RefFilter.X;
	
		(* Extrapolation error computing *)
		IF EDGEPOS(q_xPositionValid) THEN
			diRefModuloOffset := diMasterModuloPos - diRefModuloPos;
		END_IF
	
		q_diRefPosError := diMasterModuloPos - diRefModuloPos - diRefModuloOffset;
		
		IF ABS(q_diRefPosError + 360 * c_uiAxisFactor) < ABS(q_diRefPosError) THEN
			q_diRefPosError := q_diRefPosError + 360 * c_uiAxisFactor;
		ELSIF ABS(q_diRefPosError - 360 * c_uiAxisFactor) < ABS(q_diRefPosError) THEN
			q_diRefPosError := q_diRefPosError - 360 * c_uiAxisFactor;
		END_IF
	ELSIF NOT i_xExternalEncoder THEN
		diMasterPosToSpt	:= fbPeriodicToContinuePosition.q_diPosition;
		diRefExtrEncPos		:= fbPeriodicToContinuePosition.q_diPosition;
	ELSE
		uiMasterPositionSampling := uiMasterPositionSampling + 1;	//v1.2
		IF uiMasterPositionSampling >= 10 THEN				//v1.2
			diMasterPosToSpt	 	:= diMasterPosition;
			uiMasterPositionSampling	:= 0;			//v1.2
		END_IF
		
		diRefExtrEncPos		:= diMasterPosition;
	END_IF
	
	(* External reference position and velocity *)
	lrExternalRefPosition  := UDINT_TO_LREAL(diMasterModuloPos) / c_uiAxisFactor;
	
	fbVelocity.i_diPosition	:= diMasterScaledPos;
	fbVelocity();
	rExternalRefVelocity	:= fbVelocity.q_rVelocity / c_uiAxisFactor;
END_FUNCTION_BLOCK
