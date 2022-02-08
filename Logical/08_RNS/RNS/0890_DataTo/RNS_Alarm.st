ACTION RNS_Alarm:
//	ALR[1501].Active	:= VAR_RNS_ModeProduction AND LTB[202].OUT_LowLimit;//vrma CONTROLLA
	
	ALR[1502].Active	:= LSB[210].OUT_OffDelayed AND VAR_RNS_ModeCip;
	
	ALR[1506].Active	:= FTB[220].OUT_Alarm OR FTB[270].OUT_Alarm;

	ALR[1513].Active	:= TNK.DataOut.ProdMode AND FSB[201].OUT_Alarm;

	ALR[1512].ActionEn 	:= VAR_RNS_ModeControl OR VAR_RNS_ModeProduction OR VAR_RNS_ModeCop;
	ALR[1512].Active 	:= VAR_RNS_AVB_ValveFault;
	ALR[1514].Active	:= GNS.DataOut.RnsCtrlPistonAlarm;
	
	ALR[1517].Active	:= _202DSB.OUT_Alarm;
	
	ALR[1521].ActionEn 	:= VAR_RNS_ModeControl OR VAR_RNS_ModeProduction OR VAR_RNS_ModeCop;
	ALR[1521].Active 	:= AVB[273].OUT_Alarm;
	
	ALR[1522].ActionEn 	:= VAR_RNS_ModeControl OR VAR_RNS_ModeProduction OR VAR_RNS_ModeCop;
	ALR[1522].Active 	:= AVB[261].OUT_Alarm;

	ALR[1523].Active	:= PPB[209].OUT_OverloadFault;

	ALR[1525].Active	:= PPB[209].OUT_IsolatedFault;

	ALR[1551].Active	:= GNS.DataOut.RnsCtrlDevInserted;
		
//	ALR[1571].Active	:= VAR_RNS_ModeProduction AND PTB[290].OUT_LowLimit;//vrma CONTROLLA
	
	ALR[1577].Active	:= VAR_RNS_StepControl; //VAR_RNS_SEQ.Mem.ControlContinous OR VAR_RNS_SEQ.Mem.ControlInsercion;//V4.A.A.1.7.0
	
	ALR[1578].Active	:= HMI_RNS_SS2P[SS2P_SelAutoMan].LampON;//V4.A.A.1.7.0
		
	ALR[1586].Active	:= VAR_RNS_WaterFlowLowWarning;//V4.A.A.1.7.0

	ALR[1593].Active	:= PPB[209].OUT_DriveFault;
	ALR[1594].ActionEn 	:= (VAR_RNS_ModeControl OR VAR_RNS_ModeProduction) AND (CFG_Par.Rinser.ExternalRecoverySkid AND VAR_RNS_WaterTreatment);
	ALR[1594].Active := FALSE;
	ALR[1600].Active	:= VAR_RNS_WaterFlowTooLow;//vrma
	ALR[1601].Active 	:= VAR_RNS_SEQ.Mem.ControlContinous OR VAR_RNS_SEQ.Mem.ControlInsercion;//V4.A.A.1.7.0
	ALR[1607].ActionEn 	:= VAR_RNS_ModeProduction;
	ALR[1607].Active 	:= AVB[264].OUT_Alarm OR PI.OPValveFault.3;
	//V4.A.A.1.7.0 New Alarm
	ALR[1608].ActionEn 	:= TRUE;
	ALR[1608].Active 	:= AVB[265].OUT_Alarm OR PI.OPValveFault.4;
	//V4.A.A.1.7.0 New Alarm
	ALR[1609].ActionEn 	:= VAR_RNS_ModeControl OR VAR_RNS_ModeProduction OR VAR_RNS_ModeCop;
	ALR[1609].Active 	:= AVB[266].OUT_Alarm OR PI.OPValveFault.5;
	//V4.A.A.1.7.0 New Alarms 
	ALR[1610].Active 	:= (VAR_RNS_ContinousAirAlarm > 0) OR (VAR_RNS_InsercionAirAlarm > 0);
	ALR[1611].Active 	:= (VAR_RNS_ContinousWaterAlarm > 0) OR (VAR_RNS_InsercionWaterAlarm > 0);	
	ALR[1612].Active	:= SFT.DataOut.NoBottleNoSprayPistonFault;//vrma test
	ALR[1613].ActionEn	:= VAR_RNS_ModeCip;//vrma test
	ALR[1613].Active 	:= LTB[202].OUT_HighLimit;//vrma test
	ALR[1614].Active	:= LTB[202].OUT_Alarm;//vrma test
	ALR[1615].Active	:= TNK.DataOut.ProdMode AND VAR_RNS_SEQ.Mem.ContainersStop;//vrma 
	ALR[1616].Active	:= VAR_RNS_WaterFlowMissing;//vrma
	
END_ACTION
