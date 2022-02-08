ACTION DOS_InstrLevel:
//LTJ203
//	TMR_TON_PrepTankLowLimitDelay.IN 	:= VAR_CTP_SEQ.Device.LTB201.ALR_LowLimitEn;
//	TMR_TON_PrepTankLowLimitDelay.PT	:= T#5s;
//	TMR_TON_PrepTankLowLimitDelay();
//	
//	IF TMR_TON_PrepTankLowLimitDelay.Q THEN
//		LTB[201].IN_LowLimitDelay := T#1s;
//	ELSE
//		LTB[201].IN_LowLimitDelay := T#5s;
//	END_IF	
	
	LTJ[203](
	IN_ConfigPresent 	:= LTJ[203].IN_ConfigPresent, 
	IN_FaultOutMode 	:= CST_AI_FaultMode_High, 
	IN_EngScale 		:= LTJ[203].IN_EngScale,
	IN_CompareMode 		:= VAR_DOS_SEQ.Device.LTJ203.CMP,
	IN_AlarmEn 			:= TRUE,		  
	IN_MaskEn 			:= TRUE, 
	IN_Reset 			:= VAR_DOS_PBResetEp, 
	IN_ActualSP 		:= VAR_DOS_SEQ.Device.LTJ203.SP,
	IN_MinDev 			:= HMI_PAM_3._610,
	IN_MaxDev 			:= HMI_PAM_3._610, 
	IN_WaitDelay 		:= T#500ms,
	IN_HighLimitEn 		:= VAR_DOS_SEQ.Device.LTJ203.ALR_HighLimitEn, 
	IN_HighLimitSP 		:= VAR_DOS_SEQ.Device.LTJ203.ALR_HighLimitSP, 
	IN_HighLimitHyst 	:= 5.0, 
	IN_HighLimitDelay 	:= T#1s,
	IN_LowLimitEn 		:= VAR_DOS_SEQ.Device.LTJ203.ALR_LowLimitEn, 
	IN_LowLimitSP 		:= VAR_DOS_SEQ.Device.LTJ203.ALR_LowLimitSP, 
	IN_LowLimitHyst 	:= 5.0, 
	IN_LowLimitDelay 	:= T#1s,
	IN_TotPulseWeight 	:= 0.0,
	IN_TotType 			:= 0,
	IN_PLCCounterEn 	:= FALSE,
	IN_PLCCounterSP 	:= 0.0,
	IN_PLCCounterReset	:= FALSE,
	IN_HMITotEn 		:= FALSE, 
	IN_HMITotReset 		:= FALSE,
	IO 					:= IO_LTJ[203],
	HMI 				:= HMI_LTJ[203]
	);
	
	IF LTJ[203].OUT_LowLimit THEN
		VAR_DOS_TankTooLow		:= TRUE;
	ELSIF VAR_DOS_PBResetEp THEN
		VAR_DOS_TankTooLow		:= FALSE;
	END_IF
	
	IF LTJ[203].OUT_ActValue < 3.0 THEN 
		VAR_DOS_TankSafetyLimit	:= TRUE;	
	ELSIF LTJ[203].OUT_ActValue > 5.0 THEN
		VAR_DOS_TankSafetyLimit	:= FALSE;
	END_IF

	VAR_DOS_TankTooFull := LTJ[203].OUT_HighLimit;
	VAR_DOS_TankEmpted := LTJ[203].OUT_ActValue < 3; //PER STEPMOVE
	
	//TANK LEVEL CONTROL
	//CONVERTION TO %,liters,mm v000 : QUA CAMBIA LA STRUTTURA MULTI SCALE COME QUELLA CTF.CHIEDI A HMI
	FB_DOS_Data.IN_ConfigPresent			:= TRUE;					
	FB_DOS_Data.IN_Wait						:= HMI_LTJ[203].Wait;
	FB_DOS_Data.IN_Sp_Type					:= FB_DOS_Data.IN_Sp_Type;
	FB_DOS_Data.IN_TNK_PV					:= LTJ[203].OUT_ActValue;
	FB_DOS_Data.IN_TNK_Diameter_mm			:= 540.0;
	FB_DOS_Data.IN_TNK_Bottom_liters		:= 10; //volume of Hema Tank [L]  
	FB_DOS_Data.IN_ProbeLength_mm			:= 1000.0; //lenght of the tank level probe [mm] (680.0 mm la sonda ma Tank alto 1000mm)
	FB_DOS_Data.IN_FromFloor_ToZeroProbe_mm	:= 0.0; //Height From Floor To Zero Point Of The Level Probe [mm]
	FB_DOS_Data.IN_Scale[0].ActualSP		:= VAR_DOS_SEQ.Device.LTJ203.SP;

	FB_DOS_Data(HMI := HMI_DOS_Data);	

	VAR_DOS_LevelPercentage := FB_DOS_Data.OUT_Scale[0].ActValue; //%
	VAR_DOS_LevelVolume		:= FB_DOS_Data.OUT_Scale[1].ActValue; //LITERS
	VAR_DOS_LevelHeight		:= FB_DOS_Data.OUT_Scale[2].ActValue; //mm

	//END OF PRODUCTION 
	VAR_DOS_ProdEndNecessaryLiters 	:= (INT_TO_REAL(FlrSkd.ContainersInMachine) * HMI_PAR_1._215) / 1000.0; 
	VAR_DOS_ProdEndAvailableLiters 	:= INT_TO_REAL(PstFlr.ProductAvailableLiters) + VAR_DOS_LevelVolume;
	VAR_DOS_ProdEndNecessaryBottle	:= VAR_DOS_ProdEndAvailableLiters / (HMI_PAR_1._215/1000);

	VAR_DOS_ProdEndRequest			:= VAR_DOS_MemPBStop OR PstFlr.EndProductionReq OR VAR_DOS_StepProdEndProduction;

	IF VAR_DOS_ProdEndRequest THEN
		IF VAR_DOS_ProdEndAvailableLiters <= VAR_DOS_ProdEndNecessaryLiters OR VAR_DOS_ProdEndAvailableLiters < 20.0 THEN 
			VAR_DOS_EndProdStopContainer := TRUE;
		END_IF	
	ELSE 
		VAR_DOS_EndProdStopContainer := FALSE;
	END_IF
	
	//CONTROL ON BOTTLES IN TRANSIT OVER AVAILABLE LITERS
	IF EDGEPOS(VAR_DOS_EndProdStopContainer)THEN
		VAR_DOS_ProdEndRejectContainers := (ABS (VAR_DOS_ProdEndAvailableLiters - VAR_DOS_ProdEndNecessaryLiters)/(HMI_PAR_1._215/1000.0));
	END_IF
	
	//CONTROL ON INLET CLOSING AND PRODUCT AVAILABLE
	IF FlrSkd.ContainersInMachine>0 THEN
		VAR_DOS_RejectExpulsionRequest := VAR_DOS_ProdEndRejectContainers > FlrSkd.ContainersInMachine; 
	ELSE 
		VAR_DOS_RejectExpulsionRequest 	:= FALSE;
		VAR_DOS_ProdEndRejectContainers	:= 0.0;
	END_IF

//LSJ200
	LSJ200L(
	IN_ConfigPresent 	:= LSJ200L.IN_ConfigPresent,
	IN_Alarm 			:= FALSE,
	IN_AlarmOnReq		:= LSJ200L.IN_WaitOff,
	IN_AlarmOffReq 		:= LSJ200L.IN_WaitOn,
	IN_SwitchDelay 		:= T#500ms,
	IN_WaitOn 			:= FALSE,
	IN_WaitOff 			:= FALSE,
	IN_OnDelay			:= T#5s,
	IN_OffDelay			:= T#5s,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_LSJ200L,
	HMI 				:= HMI_LSJ200L
	);
	
	LSJ200M(
	IN_ConfigPresent 	:= LSJ200M.IN_ConfigPresent,
	IN_Alarm 			:= FALSE,
	IN_AlarmOnReq		:= LSJ200M.IN_WaitOff,
	IN_AlarmOffReq 		:= LSJ200M.IN_WaitOn,
	IN_SwitchDelay 		:= T#500ms,
	IN_WaitOn 			:= FALSE,
	IN_WaitOff 			:= FALSE,
	IN_OnDelay			:= T#5s,
	IN_OffDelay			:= T#5s,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_LSJ200M,
	HMI 				:= HMI_LSJ200M
	);

	LSJ200H(
	IN_ConfigPresent 	:= LSJ200H.IN_ConfigPresent,
	IN_Alarm 			:= FALSE,
	IN_AlarmOnReq		:= LSJ200H.IN_WaitOff,
	IN_AlarmOffReq 		:= LSJ200H.IN_WaitOn,
	IN_SwitchDelay 		:= T#500ms,
	IN_WaitOn 			:= FALSE,
	IN_WaitOff 			:= FALSE,
	IN_OnDelay			:= T#5s,
	IN_OffDelay			:= T#5s,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_LSJ200H,
	HMI 				:= HMI_LSJ200H
	);

//LSJ201
	LSJ[201](
	IN_ConfigPresent 	:= LSJ[201].IN_ConfigPresent,
	IN_Alarm 			:= VAR_DOS_SEQ.Device.LSJ201.ALR,
	IN_AlarmOnReq		:= LSJ[201].IN_WaitOff,
	IN_AlarmOffReq 		:= LSJ[201].IN_WaitOn,
	IN_SwitchDelay 		:= T#500ms,
	IN_WaitOn 			:= VAR_DOS_SEQ.Device.LSJ201.WAIT_ON,
	IN_WaitOff 			:= VAR_DOS_SEQ.Device.LSJ201.WAIT_OFF,
	IN_OnDelay			:= T#5s,
	IN_OffDelay			:= T#5s,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_LSJ[201],
	HMI 				:= HMI_LSJ201H
	);

//LSJ202
	LSJ[202](
	IN_ConfigPresent 	:= LSJ[202].IN_ConfigPresent,
	IN_Alarm 			:= VAR_DOS_SEQ.Device.LSJ202.ALR,
	IN_AlarmOnReq		:= LSJ[202].IN_WaitOff,
	IN_AlarmOffReq 		:= LSJ[202].IN_WaitOn,
	IN_SwitchDelay 		:= T#500ms,
	IN_WaitOn 			:= VAR_DOS_SEQ.Device.LSJ202.WAIT_ON,
	IN_WaitOff 			:= VAR_DOS_SEQ.Device.LSJ202.WAIT_OFF,
	IN_OnDelay			:= T#5s,
	IN_OffDelay			:= T#5s,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_LSJ[202],
	HMI 				:= HMI_LSJ202H
	);
END_ACTION
