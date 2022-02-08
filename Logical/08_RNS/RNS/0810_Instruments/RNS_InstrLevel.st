ACTION RNS_InstrLevel:
//LSB209 COOLING RECOVERY TANK HIGH LEVEL PROBE
	LSB[209](
	IN_ConfigPresent 	:= LSB[209].IN_ConfigPresent,
	IN_Alarm 			:= VAR_RNS_SEQ.Device.LSB209.ALR,
	IN_AlarmOnReq		:= LSB[209].IN_WaitOff,
	IN_AlarmOffReq 		:= LSB[209].IN_WaitOn,
	IN_SwitchDelay 		:= T#500ms,
	IN_WaitOn 			:= VAR_RNS_SEQ.Device.LSB209.WAIT_ON,
	IN_WaitOff 			:= VAR_RNS_SEQ.Device.LSB209.WAIT_OFF,
	IN_OnDelay			:= T#5s,
	IN_OffDelay			:= T#5s,
	IN_Reset	 		:= VAR_RNS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_LSB[209],
	HMI 				:= HMI_LSB[209]
	);

//LSB210 RECOVERY TANK LOW LEVEL PROBE 
	LSB[210](
	IN_ConfigPresent 	:= LSB[210].IN_ConfigPresent,
	IN_Alarm 			:= VAR_RNS_SEQ.Device.LSB210.ALR,
	IN_AlarmOnReq		:= LSB[210].IN_WaitOn,
	IN_AlarmOffReq 		:= LSB[210].IN_WaitOff,
	IN_SwitchDelay 		:= T#500ms,
	IN_WaitOn 			:= VAR_RNS_SEQ.Device.LSB210.WAIT_ON,
	IN_WaitOff 			:= VAR_RNS_SEQ.Device.LSB210.WAIT_OFF,
	IN_OnDelay			:= T#1s,
	IN_OffDelay			:= T#1s,
	IN_Reset	 		:= VAR_RNS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_LSB[210],
	HMI 				:= HMI_LSB[210]
	);

	TMR_TON_TankLowLevelLost(
	IN := LSB[210].OUT_OffDelayed OR LTB[202].OUT_ActValue < 3.0 , 
	PT := t#3s
	);
	
	VAR_RNS_TankLevelTooLow		:= TMR_TON_TankLowLevelLost.Q;
	VAR_RNS_TankLevelLow		:= LTB[202].OUT_ActValue > 30.0;
	VAR_RNS_TankLevelHigh		:= LSB[209].OUT_OnDelayed OR (LTB[202].OUT_ActValue > 70.0);
	VAR_RNS_TankLevelMedium		:= LSB[299].OUT_OnDelayed OR (LTB[202].OUT_ActValue > 50.0);
	
	
//LSB299 RECOVERY TANK MEDIUM LEVEL PROBE //v1.4
	LSB[299](
	IN_ConfigPresent 	:= LSB[299].IN_ConfigPresent,
	IN_Alarm 			:= VAR_RNS_SEQ.Device.LSB299.ALR,
	IN_AlarmOnReq		:= LSB[299].IN_WaitOn,
	IN_AlarmOffReq 		:= LSB[299].IN_WaitOff,
	IN_SwitchDelay 		:= T#500ms,
	IN_WaitOn 			:= VAR_RNS_SEQ.Device.LSB299.WAIT_ON,
	IN_WaitOff 			:= VAR_RNS_SEQ.Device.LSB299.WAIT_OFF,
	IN_Reset	 		:= VAR_RNS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_LSB[299],
	HMI 				:= HMI_LSB[299]
	);
	
	LTB[202](//vRMA
	IN_ConfigPresent 	:= LTB[202].IN_ConfigPresent, 
	IN_FaultOutMode 	:= 0, 
	IN_EngScale 		:= LTB[202].IN_EngScale,
	IN_AlarmEn 			:= TRUE,		  
	IN_MaskEn 			:= TRUE, 
	IN_Reset 			:= VAR_RNS_PBResetEp, 
	IN_HighLimitEn 		:= VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn, 
	IN_HighLimitSP 		:= VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP, 
	(*IN_HighLimitHyst 	:= VAR_RNS_SEQ.Device.LTB202.,*) 
	IN_HighLimitDelay 	:= T#100ms,
	IN_LowLimitEn 		:= VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn, 
	IN_LowLimitSP 		:= VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP, 
	IN_LowLimitHyst 	:= 2.0, 
	IN_LowLimitDelay 	:= T#100ms,
	IN_TotPulseWeight 	:= FALSE,
	IN_TotType 			:= 0,
	IN_PLCCounterEn 	:= FALSE,
	IN_PLCCounterSP 	:= 0.0,
	IN_PLCCounterReset	:= FALSE,
	IN_HMITotEn 		:= FALSE, 
	IN_HMITotReset 		:= FALSE,
	IO 					:= IO_LTB[202],
	HMI 				:= HMI_LTB[202]
	);
	
	
	
END_ACTION
