ACTION RNS_InstrFlow: 
//FSB201 RINSER
	FSB[201](
	IN_ConfigPresent 	:= FSB[201].IN_ConfigPresent,
	IN_Alarm 			:= TNK.DataOut.ProdMode AND MNM.DataOut.MachineRunning AND AVB[228].IN_AutoCnd,
	IN_AlarmOnReq		:= FALSE,
	IN_AlarmOffReq 		:= (AVB[228].IN_ConfigPresent AND TNK.DataOut.ProdMode AND MNM.DataOut.MachineRunning AND AVB[228].IN_AutoCnd),
	IN_SwitchDelay 		:= T#50ms,
	IN_WaitOn 			:= AVB[228].IN_AutoCnd,
	IN_WaitOff 			:= FALSE,
	IN_Reset	 		:= VAR_RNS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_FSB[201],
	HMI 				:= HMI_FSB[201]
	);
	
//FSB220 RINSER SPRAY FLOWSWITCH

	//Alarm Delay//V4.A.A.1.7.0
	TMR_TON_WtrFlowSwitchDelay.IN := VAR_RNS_SEQ.Device.FSB220.ALR  AND SFT.DataOut.NoBottleNoSprayActive AND VAR_RNS_InletProductIncoming;//vrma
	TMR_TON_WtrFlowSwitchDelay.PT := T#5s; 
	TMR_TON_WtrFlowSwitchDelay();
	
	FSB[220](//V4.A.A.1.7.0
	IN_ConfigPresent 	:= FSB[220].IN_ConfigPresent,
	IN_Alarm 			:= TMR_TON_WtrFlowSwitchDelay.Q,
	IN_AlarmOnReq		:= FALSE,
	IN_AlarmOffReq 		:= TMR_TON_WtrFlowSwitchDelay.Q,
	IN_SwitchDelay 		:= T#50ms,
	IN_WaitOn 			:= VAR_RNS_SEQ.Device.FSB220.WAIT_ON,
	IN_WaitOff 			:= FALSE,
	IN_Reset	 		:= VAR_RNS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_FSB[220],
	HMI 				:= HMI_FSB[220]
	);
	
	IF FSB[220].OUT_Alarm THEN//V4.A.A.1.7.0
		VAR_RNS_WaterFlowMissing :=  TRUE ;
	ELSIF VAR_RNS_PBResetEp THEN
		VAR_RNS_WaterFlowMissing :=  FALSE;
	END_IF
	
	
//FTB201 RINSER FLOW TRASMITTER AIR
	
	//Alarm Delay
	TMR_TON_AirFlowLowLimitDelay.IN := VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn;
	TMR_TON_AirFlowLowLimitDelay.PT := T#5s; 
	TMR_TON_AirFlowLowLimitDelay();

	IF TMR_TON_AirFlowLowLimitDelay.Q THEN 
		FTB[201].IN_LowLimitDelay := T#1s;
	ELSE
		FTB[201].IN_LowLimitDelay := T#5s;
	END_IF
	
	FTB[201](
	IN_ConfigPresent 	:= FTB[201].IN_ConfigPresent,
	IN_EngScale 		:= FTB[201].IN_EngScale, 
	IN_CompareMode 		:= VAR_RNS_SEQ.Device.FTB201.CMP, 
	IN_AlarmEn 			:= TRUE,		  
	IN_MaskEn 			:= TRUE,
	IN_Reset 			:= VAR_RNS_PBResetEp, 
	IN_ActualSP 		:= VAR_RNS_SEQ.Device.FTB201.SP,
	IN_MinDev 			:= VAR_RNS_SEQ.Device.FTB201.MinDev,
	IN_MaxDev 			:= VAR_RNS_SEQ.Device.FTB201.MaxDev,
	IN_WaitDelay 		:= T#500ms,
	IN_HighLimitEn 		:= VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn,
	IN_HighLimitSP 		:= VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP,
	IN_HighLimitHyst 	:= 0.0,
	IN_HighLimitDelay 	:= T#1s,
	IN_LowLimitEn 		:= VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn,
	IN_LowLimitSP 		:= VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP,
	IN_LowLimitHyst 	:= 0.0,
	IN_LowLimitDelay 	:= FTB[201].IN_LowLimitDelay,
	IN_TotPulseWeight 	:= 0.0,
	IN_TotType 			:= 0,
	IN_PLCCounterEn 	:= FALSE,
	IN_PLCCounterSP 	:= 0.0,
	IN_PLCCounterReset	:= FALSE,
	IN_HMITotEn 		:= FALSE, 
	IN_HMITotReset 		:= FALSE, 
	IO 					:= IO_FTB[201], 
	HMI 				:= HMI_FTB[201]
	);

	VAR_RNS_AirFlowTooHigh := FTB[201].OUT_HighLimit;
	
	IF FTB[201].OUT_LowLimit THEN
		VAR_RNS_AirFlowTooLow	:= TRUE;
	ELSIF VAR_RNS_PBResetEp THEN
		VAR_RNS_AirFlowTooLow	:= FALSE;
	END_IF
	
	VAR_RNS_AirFlowLowWarning := NOT FTB[201].OUT_SpReached AND (FTB[201].OUT_ActValue < FTB[201].IN_ActualSP);
	
//FTB202 RINSER FLOW TRASMITTER H2O

	//Alarm Delay
	TMR_TON_WtrFlowLowLimitDelay.IN := VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn AND SFT.DataOut.NoBottleNoSprayActive AND VAR_RNS_InletProductIncoming;//vrma
	TMR_TON_WtrFlowLowLimitDelay.PT := T#5s; 
	TMR_TON_WtrFlowLowLimitDelay();

	IF TMR_TON_WtrFlowLowLimitDelay.Q THEN 
		FTB[202].IN_LowLimitDelay := T#1s;
	ELSE
		FTB[202].IN_LowLimitDelay := T#5s;
	END_IF
	
	FTB[202](
	IN_ConfigPresent 	:= FTB[202].IN_ConfigPresent,
	IN_EngScale 		:= FTB[202].IN_EngScale, 
	IN_CompareMode 		:= VAR_RNS_SEQ.Device.FTB202.CMP, 
	IN_AlarmEn 			:= TRUE,		  
	IN_MaskEn 			:= TRUE,
	IN_Reset 			:= VAR_RNS_PBResetEp, 
	IN_ActualSP 		:= VAR_RNS_SEQ.Device.FTB202.SP,
	IN_MinDev 			:= VAR_RNS_SEQ.Device.FTB202.MinDev,
	IN_MaxDev 			:= VAR_RNS_SEQ.Device.FTB202.MaxDev,
	IN_WaitDelay 		:= T#500ms,
	IN_HighLimitEn 		:= VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn AND SFT.DataOut.NoBottleNoSprayActive,
	IN_HighLimitSP 		:= VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP,
	IN_HighLimitHyst 	:= 0.0,
	IN_HighLimitDelay 	:= T#1s,
	IN_LowLimitEn 		:= VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn AND SFT.DataOut.NoBottleNoSprayActive AND VAR_RNS_InletProductIncoming,
	IN_LowLimitSP 		:= VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP,
	IN_LowLimitHyst 	:= 0.0,
	IN_LowLimitDelay 	:= FTB[202].IN_LowLimitDelay,
	IN_TotPulseWeight 	:= 0.0,
	IN_TotType 			:= 0,
	IN_PLCCounterEn 	:= FALSE,
	IN_PLCCounterSP 	:= 0.0,
	IN_PLCCounterReset	:= FALSE,
	IN_HMITotEn 		:= FALSE, 
	IN_HMITotReset 		:= FALSE, 
	IO 					:= IO_FTB[202], 
	HMI 				:= HMI_FTB[202]
	);	
	
	VAR_RNS_WaterFlowTooHigh := FTB[202].OUT_HighLimit;
	
	IF FTB[202].OUT_LowLimit THEN
		VAR_RNS_WaterFlowTooLow	:= NOT SFT.DataOut.MachineEmpty;
	ELSIF VAR_RNS_PBResetEp THEN
		VAR_RNS_WaterFlowTooLow	:= FALSE;
	END_IF
	
	IF VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn AND SFT.DataOut.NoBottleNoSprayActive AND VAR_RNS_InletProductIncoming  THEN//vrma
		VAR_RNS_WaterFlowLowWarning := NOT FTB[202].OUT_SpReached AND (FTB[202].OUT_ActValue < FTB[202].IN_ActualSP);
	ELSE
		VAR_RNS_WaterFlowLowWarning := FALSE;
	END_IF
	
END_ACTION