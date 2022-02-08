ACTION DOS_StepMove:
//CYCLE START
	 
	IF VAR_DOS_ModeWait AND VAR_DOS_MemPBStart THEN
		VAR_DOS_SeqPermanent.SeqMode1.0 := VAR_DOS_FMDProduction;
		VAR_DOS_SeqPermanent.SeqMode1.1 := VAR_DOS_FMDCip;
		VAR_DOS_SeqPermanent.SeqMode1.2 := VAR_DOS_FMDRinse;
		VAR_DOS_SeqPermanent.SeqMode1.3 := VAR_DOS_FMDDrain;
		//VAR_DOS_SeqPermanent.SeqMode1.5	:= VAR_DOS_FMDPositioning;
	END_IF
	
	IF VAR_DOS_ModeWait AND EDGEPOS(VAR_DOS_FMDProductionFillerOnly) THEN
		VAR_DOS_SeqPermanent.SeqMode1.8 := TRUE;
	END_IF
	
	IF VAR_DOS_FMDCop AND COP.DataOut.DoserPositioningReq THEN
		VAR_DOS_SeqPermanent.SeqMode1.4 := TRUE;
	END_IF
	
	IF VAR_DOS_ModeProduction AND VAR_DOS_FMDDrain THEN
		VAR_DOS_SeqPermanent.SeqMode2.0 := TRUE;
	END_IF
	
	IF VAR_DOS_SeqPermanent.SeqActualStep = 0 AND NOT MNM.DataOut.MachineRunning THEN
		VAR_DOS_SeqPermanent.SeqMode2.4 := TRUE;
		VAR_DOS_SeqPermanent.SeqMode2.5 := FALSE;
		VAR_DOS_SeqPermanent.SeqMode2.6 := FALSE;
	END_IF	
	
	VAR_DOS_SeqPermanent.SeqMode1.7 := VAR_DOS_FMDPositionRequest;
	
	IF EDGEPOS(VAR_DOS_SeqPermanent.SeqActualStep = 0) THEN
		HMI_DOS_SS2P[SS2P_DOS_CamDosByPass].ON		:= FALSE; 
		HMI_DOS_SS2P[SS2P_DOS_CamDosInclusion].ON 	:= FALSE; 
	END_IF
	
	//STEP 00 ********************************************************************************************************************
	(* Wait *)
	VAR_DOS_SEQ_Step.Step[0].Config.Laps_Counter_Enable	:= FALSE;
	VAR_DOS_SEQ_Step.Step[0].Config.Laps_Request		:= 0;
	VAR_DOS_SEQ_Step.Step[0].Config.T_TimeSTART			:= FALSE;
	VAR_DOS_SEQ_Step.Step[0].Config.T_TimeSTOP			:= FALSE;
	VAR_DOS_SEQ_Step.Step[0].Config.T_TimeRESET			:= FALSE;
	VAR_DOS_SEQ_Step.Step[0].Config.T_TimePr			:= 0;
	VAR_DOS_SEQ_Step.Step[0].Config.TON_TimeSTART		:= FALSE;
	VAR_DOS_SEQ_Step.Step[0].Config.TON_TimePr			:= 0;
	VAR_DOS_SEQ_Step.Step[0].Config.TO_TimePr			:= 0;
	VAR_DOS_SEQ_Step.Step[0].Config.Cycle_RESET	        := TRUE;
	VAR_DOS_SEQ_Step.Step[0].Config.HMI_ID				:= 0;
	
	IF VAR_DOS_SEQ_Step.StepActual = 0 THEN	
		VAR_DOS_RinseCycle := 0.0;
	END_IF
	
	VAR_DOS_SEQ_Step.Step[0].Jump[0].Condition		:= VAR_DOS_ModeWait AND VAR_DOS_SeqPermanent.SeqMode1.0; //PRODUCTION
	VAR_DOS_SEQ_Step.Step[0].Jump[0].Number			:= 160;
	VAR_DOS_SEQ_Step.Step[0].Jump[1].Condition		:= VAR_DOS_ModeWait AND VAR_DOS_SeqPermanent.SeqMode1.1; //CIP
	VAR_DOS_SEQ_Step.Step[0].Jump[1].Number			:= 60;
	VAR_DOS_SEQ_Step.Step[0].Jump[2].Condition		:= VAR_DOS_ModeWait AND VAR_DOS_SeqPermanent.SeqMode1.2; //RINSE
	VAR_DOS_SEQ_Step.Step[0].Jump[2].Number			:= 60; 
	VAR_DOS_SEQ_Step.Step[0].Jump[3].Condition		:= VAR_DOS_ModeWait AND VAR_DOS_SeqPermanent.SeqMode1.3; //DRAIN 
	VAR_DOS_SEQ_Step.Step[0].Jump[3].Number			:= 160;
	VAR_DOS_SEQ_Step.Step[0].Jump[4].Condition		:= VAR_DOS_ModeWait AND VAR_DOS_SeqPermanent.SeqMode1.4; //MANUAL COP
	VAR_DOS_SEQ_Step.Step[0].Jump[4].Number			:= 160;
	VAR_DOS_SEQ_Step.Step[0].Jump[5].Condition		:= VAR_DOS_ModeWait AND VAR_DOS_SeqPermanent.SeqMode1.8; //DOSER EXCLUDED 
	VAR_DOS_SEQ_Step.Step[0].Jump[5].Number			:= 160;
	VAR_DOS_SEQ_Step.Step[0].Jump[6].Condition		:= VAR_DOS_ModeWait AND (HMI_DOS_SS2P[SS2P_DOS_CamDosInclusion].ON OR HMI_DOS_SS2P[SS2P_DOS_CamDosByPass].ON); //MANUAL CAM POSITIONING not available in RMA
	VAR_DOS_SEQ_Step.Step[0].Jump[6].Number			:= 150;

	//STEP 01****************************************************************************************************************
	(* START-UP PRODUCTION - Cam Position Control *)
	VAR_DOS_SEQ_Step.Step[1].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[1].Config.TON_TimePr		:= 5;
	VAR_DOS_SEQ_Step.Step[1].Config.HMI_ID			:= 1;
	
	VAR_DOS_SEQ_Step.Step[1].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND NOT VAR_DOS_SeqPositionReached;
	VAR_DOS_SEQ_Step.Step[1].Jump[0].Number			:= 2;
	VAR_DOS_SEQ_Step.Step[1].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPositionReached AND VAR_DOS_HotProductControl; //se RMH ?? altrimenti salto step Heating ?? FILIPPO
	VAR_DOS_SEQ_Step.Step[1].Jump[1].Number			:= 5; //HEATING 
	VAR_DOS_SEQ_Step.Step[1].Jump[2].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPositionReached; 
	VAR_DOS_SEQ_Step.Step[1].Jump[2].Number			:= 20; //FAST PROD
	VAR_DOS_SEQ_Step.Step[1].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[1].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[1].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest;
	VAR_DOS_SEQ_Step.Step[1].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 02****************************************************************************************************************
	 (* START-UP PRODUCTION - Cam Positioning to Recipe Value *)
	VAR_DOS_SEQ_Step.Step[2].Config.TON_TimeSTART	:= VAR_DOS_SeqPositionReached;
	VAR_DOS_SEQ_Step.Step[2].Config.TON_TimePr		:= 2;
	VAR_DOS_SEQ_Step.Step[2].Config.HMI_ID			:= 2;
	
	VAR_DOS_SEQ_Step.Step[2].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END; 
	VAR_DOS_SEQ_Step.Step[2].Jump[0].Number			:= 1;
	VAR_DOS_SEQ_Step.Step[2].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[2].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[2].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest;
	VAR_DOS_SEQ_Step.Step[2].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP DI HEATING
	//STEP 05****************************************************************************************************************
	(* Start Up Production - Pulp Doser -Wait For Hot Water Sending From Pasto *)
	VAR_DOS_SEQ_Step.Step[5].Config.TON_TimeSTART	:= PstFlr.HeatingWithWater; 
	VAR_DOS_SEQ_Step.Step[5].Config.TON_TimePr		:= 2;
	VAR_DOS_SEQ_Step.Step[5].Config.HMI_ID			:= 3;
	
	VAR_DOS_SEQ_Step.Step[5].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END; 
	VAR_DOS_SEQ_Step.Step[5].Jump[0].Number			:= 6;
	VAR_DOS_SEQ_Step.Step[5].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[5].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[5].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[5].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 06****************************************************************************************************************
	(* Start Up Production - Pulp Doser -Tank Filling For Heating *)
	VAR_DOS_SEQ_Step.Step[6].Config.TON_TimeSTART	:= PstFlr.HeatingWithWater; 
	VAR_DOS_SEQ_Step.Step[6].Config.TON_TimePr		:= 5;
	VAR_DOS_SEQ_Step.Step[6].Config.HMI_ID			:= 4;
	
	VAR_DOS_SEQ_Step.Step[6].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND LTJ[203].OUT_SpReached; 
	VAR_DOS_SEQ_Step.Step[6].Jump[0].Number			:= 7;
	VAR_DOS_SEQ_Step.Step[6].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[6].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[6].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[6].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 07****************************************************************************************************************
	(* Start Up Production - Pulp Doser -Heating From Spray Ball *)
	VAR_DOS_SEQ_Step.Step[7].Config.TON_TimeSTART	:= PstFlr.HeatingWithWater; 
	VAR_DOS_SEQ_Step.Step[7].Config.TON_TimePr		:= 20;//200;
	VAR_DOS_SEQ_Step.Step[7].Config.HMI_ID			:= 5;
	
	VAR_DOS_SEQ_Step.Step[7].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END; 
	VAR_DOS_SEQ_Step.Step[7].Jump[0].Number			:= 8;
	VAR_DOS_SEQ_Step.Step[7].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[7].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[7].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[7].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 08****************************************************************************************************************
	(* Start Up Production - Pulp Doser -Heating *)
	VAR_DOS_SEQ_Step.Step[8].Config.TON_TimeSTART	:= PstFlr.HeatingWithWater; 
	VAR_DOS_SEQ_Step.Step[8].Config.TON_TimePr		:= 20;
	VAR_DOS_SEQ_Step.Step[8].Config.HMI_ID			:= 6;
	
	VAR_DOS_SEQ_Step.Step[8].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END; 
	VAR_DOS_SEQ_Step.Step[8].Jump[0].Number			:= 9;
	VAR_DOS_SEQ_Step.Step[8].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[8].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[8].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[8].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 09****************************************************************************************************************
	(* Start Up Production -Water recirculation For Heating *)
	VAR_DOS_SEQ_Step.Step[9].Config.TON_TimeSTART	:= PstFlr.HeatingWithWater AND TTJ[203].OUT_SpReached; 
	VAR_DOS_SEQ_Step.Step[9].Config.TON_TimePr		:= REAL_TO_UINT(HMI_PAM_3._616);
	VAR_DOS_SEQ_Step.Step[9].Config.HMI_ID			:= 7;
	
	VAR_DOS_SEQ_Step.Step[9].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.DrainRequest; 
	VAR_DOS_SEQ_Step.Step[9].Jump[0].Number			:= 15;
	VAR_DOS_SEQ_Step.Step[9].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[9].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[9].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[9].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 15 ********************************************************************************************************************
	(* START-UP PRODUCTION -Machine Pipes Drainages *)
	VAR_DOS_SEQ_Step.Step[15].Config.TON_TimeSTART	:= VAR_DOS_TankEmpted AND NOT VAR_DOS_SeqPermanent.SeqMode1.3 ;
	VAR_DOS_SEQ_Step.Step[15].Config.TON_TimePr		:= 120; //valuta se si svuota davvero
	VAR_DOS_SEQ_Step.Step[15].Config.HMI_ID			:= 8;
	
	VAR_DOS_SEQ_Step.Step[15].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[15].Jump[0].Number		:= 17;
	VAR_DOS_SEQ_Step.Step[15].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[15].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[15].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[15].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 17 ********************************************************************************************************************
	(* START-UP PRODUCTION -Machine Draining End *)
	VAR_DOS_SEQ_Step.Step[17].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[17].Config.TON_TimePr		:= 120; //VALUTARE SE TANK SI SVUOTA
	VAR_DOS_SEQ_Step.Step[17].Config.HMI_ID			:= 9;
	
	VAR_DOS_SEQ_Step.Step[17].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[17].Jump[0].Number		:= 20;
	VAR_DOS_SEQ_Step.Step[17].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[17].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[17].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[17].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 20 ********************************************************************************************************************
	(* START-UP PRODUCTION -Wait "Product Available" From PASTO *)
	VAR_DOS_SEQ_Step.Step[20].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[20].Config.TON_TimePr		:= 1;
	VAR_DOS_SEQ_Step.Step[20].Config.HMI_ID			:= 10;
	
	VAR_DOS_SEQ_Step.Step[20].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.ProductAvailable;
	VAR_DOS_SEQ_Step.Step[20].Jump[0].Number		:= 22;
	VAR_DOS_SEQ_Step.Step[20].Jump[1].Condition		:= PstFlr.DrainRequest;
	VAR_DOS_SEQ_Step.Step[20].Jump[1].Number		:= 49;
	VAR_DOS_SEQ_Step.Step[20].Jump[2].Condition		:= PstFlr.RinseAfterProd;
	VAR_DOS_SEQ_Step.Step[20].Jump[2].Number		:= 100;
	VAR_DOS_SEQ_Step.Step[20].Jump[3].Condition		:= PstFlr.ProductRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[20].Jump[3].Number		:= 40;
	VAR_DOS_SEQ_Step.Step[20].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[20].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[20].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[20].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 22 ********************************************************************************************************************
	(* START-UP PRODUCTION - Load Product at level *)
	VAR_DOS_SEQ_Step.Step[22].Config.HMI_ID			:= 11;
	
	VAR_DOS_SEQ_Step.Step[22].Jump[0].Condition		:= LTJ[203].OUT_SpReached;
	VAR_DOS_SEQ_Step.Step[22].Jump[0].Number		:= 30; //23 Se c'è priming
	VAR_DOS_SEQ_Step.Step[22].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[22].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[22].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[22].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 23 ********************************************************************************************************************
	(* START-UP PRODUCTION -Filling Valve Priming, Filling Valves Opening *)
	VAR_DOS_SEQ_Step.Step[23].Config.Laps_Counter_Enable 	:= TRUE; 
	VAR_DOS_SEQ_Step.Step[23].Config.Laps_Request			:= 1;
	VAR_DOS_SEQ_Step.Step[23].Config.HMI_ID					:= 12;
	
	VAR_DOS_SEQ_Step.Step[23].Jump[0].Condition		:= VAR_DOS_SEQ_Step.Laps_Done;
	VAR_DOS_SEQ_Step.Step[23].Jump[0].Number		:= 30;
	VAR_DOS_SEQ_Step.Step[23].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[23].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[23].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[23].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 24 ********************************************************************************************************************
	(*START-UP PRODUCTION -Filling Valve Priming, Drain Tray Washing*)
	VAR_DOS_SEQ_Step.Step[24].Config.TON_TimeSTART	:= AVJ[210].OUT_OpenedFiltered; //DrainTrayWashingEnable;
	VAR_DOS_SEQ_Step.Step[24].Config.TON_TimePr		:= 20;
	VAR_DOS_SEQ_Step.Step[24].Config.HMI_ID			:= 13;
	
	VAR_DOS_SEQ_Step.Step[24].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[24].Jump[0].Number		:= 30;
	VAR_DOS_SEQ_Step.Step[24].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[24].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[24].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[24].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 30 ********************************************************************************************************************
	(*START-UP PRODUCTION -Wait For Product Tank at Set-Point Level*)
	VAR_DOS_SEQ_Step.Step[30].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[30].Config.TON_TimePr		:= 1;
	VAR_DOS_SEQ_Step.Step[30].Config.HMI_ID			:= 14;

	VAR_DOS_SEQ_Step.Step[30].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND LTJ[203].OUT_SpReached;
	VAR_DOS_SEQ_Step.Step[30].Jump[0].Number		:= 35;
	VAR_DOS_SEQ_Step.Step[30].Jump[1].Condition		:= NOT PstFlr.ProductAvailable;
	VAR_DOS_SEQ_Step.Step[30].Jump[1].Number		:= 20;
	VAR_DOS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 35 ********************************************************************************************************************
	(*PRODUCTION -Machine on Production*)
	VAR_DOS_SEQ_Step.Step[35].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[35].Config.TON_TimePr		:= 1;
	VAR_DOS_SEQ_Step.Step[35].Config.HMI_ID			:= 15;
		
	VAR_DOS_SEQ_Step.Step[35].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND LTJ[203].OUT_LowLimit;
	VAR_DOS_SEQ_Step.Step[35].Jump[0].Number		:= 37;
	VAR_DOS_SEQ_Step.Step[35].Jump[1].Condition		:= PstFlr.EndProductionReq; //OR TNK.DataOut.EndProduction ??
	VAR_DOS_SEQ_Step.Step[35].Jump[1].Number		:= 46;
	VAR_DOS_SEQ_Step.Step[35].Jump[2].Condition		:= PstFlr.DrainRequest;
	VAR_DOS_SEQ_Step.Step[35].Jump[2].Number		:= 49;
	VAR_DOS_SEQ_Step.Step[35].Jump[3].Condition		:= PstFlr.RinseAfterProd;
	VAR_DOS_SEQ_Step.Step[35].Jump[3].Number		:= 100;
	VAR_DOS_SEQ_Step.Step[35].Jump[4].Condition		:= PstFlr.ProductRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[35].Jump[4].Number		:= 40;
	VAR_DOS_SEQ_Step.Step[35].Jump[5].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND TTJ[203].OUT_LowLimit AND VAR_DOS_HotProductControl;
	VAR_DOS_SEQ_Step.Step[35].Jump[5].Number		:= 40; //RICIRCOLO IN PROD FILIPPO
	VAR_DOS_SEQ_Step.Step[35].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[35].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[35].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[35].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 37 ********************************************************************************************************************
	(*PRODUCTION -Minimum Tank Level*)
	VAR_DOS_SEQ_Step.Step[37].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[37].Config.TON_TimePr		:= 1;
	VAR_DOS_SEQ_Step.Step[37].Config.HMI_ID			:= 16;
	
	VAR_DOS_SEQ_Step.Step[37].Jump[0].Condition		:= LTJ[203].OUT_SpReached AND VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[37].Jump[0].Number		:= 35;
	VAR_DOS_SEQ_Step.Step[37].Jump[1].Condition		:= LTJ[203].OUT_ActValue < (LTJ[203].IN_LowLimitSP - LTJ[203].IN_LowLimitHyst) AND VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[37].Jump[1].Number		:= 38;
	VAR_DOS_SEQ_Step.Step[37].Jump[2].Condition		:= PstFlr.EndProductionReq; //OR TNK.DataOut.EndProduction
	VAR_DOS_SEQ_Step.Step[37].Jump[2].Number		:= 46;
	VAR_DOS_SEQ_Step.Step[37].Jump[3].Condition		:= PstFlr.DrainRequest;
	VAR_DOS_SEQ_Step.Step[37].Jump[3].Number		:= 49;
	VAR_DOS_SEQ_Step.Step[37].Jump[4].Condition		:= PstFlr.ProductRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[37].Jump[4].Number		:= 40;
	VAR_DOS_SEQ_Step.Step[37].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[37].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[37].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[37].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 38 ********************************************************************************************************************
	(*PRODUCTION -Safety Tank Level*)
	VAR_DOS_SEQ_Step.Step[38].Config.HMI_ID			:= 17; //--> BOTTLE BLOCK
	
	VAR_DOS_SEQ_Step.Step[38].Jump[0].Condition		:= SFT.DataOut.MachineEmpty; 
	VAR_DOS_SEQ_Step.Step[38].Jump[0].Number		:= 20;
	VAR_DOS_SEQ_Step.Step[38].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[38].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[38].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[38].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 40 ********************************************************************************************************************
	(*PRODUCTION - Recirculation *)
	VAR_DOS_SEQ_Step.Step[40].Config.TON_TimeSTART	:= VAR_DOS_TankEmpted;
	VAR_DOS_SEQ_Step.Step[40].Config.TON_TimePr		:= 3;
	VAR_DOS_SEQ_Step.Step[40].Config.HMI_ID			:= 62;
	
	VAR_DOS_SEQ_Step.Step[40].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[40].Jump[0].Number		:= 41;
	VAR_DOS_SEQ_Step.Step[40].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[40].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[40].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[40].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 41 ********************************************************************************************************************
	(*PRODUCTION - Recirculation END*)
	VAR_DOS_SEQ_Step.Step[41].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[41].Config.TON_TimePr		:= 3;
	VAR_DOS_SEQ_Step.Step[41].Config.HMI_ID			:= 64; 

	VAR_DOS_SEQ_Step.Step[41].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[41].Jump[0].Number		:= 20;
	VAR_DOS_SEQ_Step.Step[41].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[41].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[41].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[41].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 46 ********************************************************************************************************************
	(*PRODUCTION -End Production Request from PASTO*)
	VAR_DOS_SEQ_Step.Step[46].Config.TON_TimeSTART	:= PstFlr.EndProductionReq AND NOT PstFlr.ProductAvailable ;//VAR_DOS_ProdEndAvailableLiters < 3.0;  
	VAR_DOS_SEQ_Step.Step[46].Config.TON_TimePr		:= 3;
	VAR_DOS_SEQ_Step.Step[46].Config.HMI_ID			:= 18;
	
	VAR_DOS_SEQ_Step.Step[46].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.ProductAvailable AND NOT PstFlr.ProductCompleted;
	VAR_DOS_SEQ_Step.Step[46].Jump[0].Number		:= 35;
	VAR_DOS_SEQ_Step.Step[46].Jump[1].Condition		:= VAR_DOS_EndProdStopContainer AND VAR_DOS_SEQ_Step.TON_Time_END; //OR VAR_DOS_ProdEndAvailableLiters < 3.0; //VAR_DOS_SEQ_Step.TON_Time_END AND NOT PstFlr.ProductAvailable AND PstFlr.ProductCompleted;
	VAR_DOS_SEQ_Step.Step[46].Jump[1].Number		:= 49;
	VAR_DOS_SEQ_Step.Step[46].Jump[2].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND SFT.DataOut.MachineEmpty;
	VAR_DOS_SEQ_Step.Step[46].Jump[2].Number		:= 52;
	VAR_DOS_SEQ_Step.Step[46].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[46].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[46].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[46].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 49 ********************************************************************************************************************
	(*END PRODUCTION -Wait Filler Empty*)
	VAR_DOS_SEQ_Step.Step[49].Config.TON_TimeSTART	:= SFT.DataOut.MachineEmpty; //VAR_DOS_ProdEndAvailableLiters < 3.0; //VAR_DOS_TankEmpted; 
	VAR_DOS_SEQ_Step.Step[49].Config.TON_TimePr		:= 10;
	VAR_DOS_SEQ_Step.Step[49].Config.HMI_ID			:= 19;
	
	VAR_DOS_SEQ_Step.Step[49].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.ProductAvailable AND NOT PstFlr.ProductCompleted;
	VAR_DOS_SEQ_Step.Step[49].Jump[0].Number		:= 35;
//	VAR_DOS_SEQ_Step.Step[49].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND NOT PstFlr.ProductAvailable AND PstFlr.ProductCompleted;
//	VAR_DOS_SEQ_Step.Step[49].Jump[1].Number		:= 52;
	VAR_DOS_SEQ_Step.Step[49].Jump[2].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND SFT.DataOut.MachineEmpty AND PstFlr.RinseAfterProd; 
	VAR_DOS_SEQ_Step.Step[49].Jump[2].Number		:= 100;
	VAR_DOS_SEQ_Step.Step[49].Jump[3].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND SFT.DataOut.MachineEmpty;
	VAR_DOS_SEQ_Step.Step[49].Jump[3].Number		:= 52;
	VAR_DOS_SEQ_Step.Step[49].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[49].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 52 ********************************************************************************************************************
	(*END PRODUCTION -Machine Drainage*)
	VAR_DOS_SEQ_Step.Step[52].Config.TON_TimeSTART	:= VAR_DOS_TankEmpted;
	VAR_DOS_SEQ_Step.Step[52].Config.TON_TimePr		:= 120;
	VAR_DOS_SEQ_Step.Step[52].Config.HMI_ID			:= 20;
	
	VAR_DOS_SEQ_Step.Step[52].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.RinseAfterProd AND SFT.DataOut.MachineEmpty;
	VAR_DOS_SEQ_Step.Step[52].Jump[0].Number		:= 100;
	VAR_DOS_SEQ_Step.Step[52].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[52].Jump[1].Number		:= 0; 
	VAR_DOS_SEQ_Step.Step[52].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[52].Jump[MAX_JUMP_CFG-1].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[52].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[52].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 55 ********************************************************************************************************************
	(* PRODUCTION - Stopped *)
	VAR_DOS_SEQ_Step.Step[55].Config.TON_TimeSTART		:= NOT VAR_DOS_SeqProdStopAlarm;
	VAR_DOS_SEQ_Step.Step[55].Config.TON_TimePr			:= 3;
	VAR_DOS_SEQ_Step.Step[55].Config.HMI_ID				:= 53;

	VAR_DOS_SEQ_Step.Step[55].Jump[0].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_PBResetEp AND TTJ[203].OUT_LowLimit AND VAR_DOS_HotProductControl;
	VAR_DOS_SEQ_Step.Step[55].Jump[0].Number			:= 40; //RICIRCOLO IN PROD FILIPPO
	VAR_DOS_SEQ_Step.Step[55].Jump[1].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_PBResetEp AND VAR_DOS_HotProductControl; //RMH
	VAR_DOS_SEQ_Step.Step[55].Jump[1].Number			:= VAR_DOS_SeqPermanent.SeqBackupStep;
	VAR_DOS_SEQ_Step.Step[55].Jump[2].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_PBResetEp AND NOT VAR_DOS_HotProductControl; //RMA
	VAR_DOS_SEQ_Step.Step[55].Jump[2].Number			:= VAR_DOS_SeqPermanent.SeqBackupStep;
	VAR_DOS_SEQ_Step.Step[55].Jump[MAX_JUMP_CFG-1].Condition	:= FALSE;
	VAR_DOS_SEQ_Step.Step[55].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[55].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqProdAbortRequest;
	VAR_DOS_SEQ_Step.Step[55].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 59(* CIP -Wait Filler Dummy Bottles Insertion *)
	VAR_DOS_SEQ_Step.Step[59].Config.TON_TimeSTART	:= VAR_DOS_SeqPositionReached AND MAU_DumCon.DataOut.InstallDone;
	VAR_DOS_SEQ_Step.Step[59].Config.TON_TimePr		:= 1;
	VAR_DOS_SEQ_Step.Step[59].Config.HMI_ID			:= 22;
	
	VAR_DOS_SEQ_Step.Step[59].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END; 
	VAR_DOS_SEQ_Step.Step[59].Jump[0].Number		:= 160;
	VAR_DOS_SEQ_Step.Step[59].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[59].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[59].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[59].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 60 ********************************************************************************************************************
	(*C.I.P. -Wait For Pulp Doser on Sanitation Tank Height*)
	VAR_DOS_SEQ_Step.Step[60].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[60].Config.TON_TimePr		:= 5;
	VAR_DOS_SEQ_Step.Step[60].Config.HMI_ID			:= 22;
	
	VAR_DOS_SEQ_Step.Step[60].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPositionReached AND VAR_DOS_SeqPermanent.SeqMode1.1; //CIP
	VAR_DOS_SEQ_Step.Step[60].Jump[0].Number		:= 61;
	VAR_DOS_SEQ_Step.Step[60].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPositionReached AND VAR_DOS_SeqPermanent.SeqMode1.2; //RINSE
	VAR_DOS_SEQ_Step.Step[60].Jump[1].Number		:= 100;
	VAR_DOS_SEQ_Step.Step[60].Jump[2].Condition		:= TNK.DataOut.CipMode AND MAU_DumCon.DataOut.InstallDone;
	VAR_DOS_SEQ_Step.Step[60].Jump[2].Number		:= 160;
	VAR_DOS_SEQ_Step.Step[60].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest OR VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[60].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[60].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest OR VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[60].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 61 ********************************************************************************************************************
	(*C.I.P. -Tank Empty*)
	VAR_DOS_SEQ_Step.Step[61].Config.TON_TimeSTART	:= VAR_DOS_TankEmpted;
	VAR_DOS_SEQ_Step.Step[61].Config.TON_TimePr		:= 10; 
	VAR_DOS_SEQ_Step.Step[61].Config.HMI_ID			:= 23;

	VAR_DOS_SEQ_Step.Step[61].Jump[0].Condition		:= TNK.DataOut.CipMode AND MAU_DumCon.DataOut.InstallDone; 
	VAR_DOS_SEQ_Step.Step[61].Jump[0].Number		:= 160;
	VAR_DOS_SEQ_Step.Step[61].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[61].Jump[1].Number		:= 160;
	VAR_DOS_SEQ_Step.Step[61].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[61].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[61].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[61].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 65 ********************************************************************************************************************
	(*C.I.P. -Filling Valve Closing and Waiting Conical Valve Extraction on Position*)
	VAR_DOS_SEQ_Step.Step[65].Config.Laps_Counter_Enable := VAR_DOS_SEQ.Mem.LapsCounter;
	VAR_DOS_SEQ_Step.Step[65].Config.Laps_Request	:= 1;
	VAR_DOS_SEQ_Step.Step[65].Config.TON_TimeSTART	:= VAR_DOS_SEQ_Step.Laps_Done;
	VAR_DOS_SEQ_Step.Step[65].Config.TON_TimePr		:= 30;
	VAR_DOS_SEQ_Step.Step[65].Config.HMI_ID			:= 24;
	
	VAR_DOS_SEQ_Step.Step[65].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;// AND CONICAL VALVE IN CIP POSITION 
	VAR_DOS_SEQ_Step.Step[65].Jump[0].Number		:= 66;
	VAR_DOS_SEQ_Step.Step[65].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[65].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[65].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[65].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 66 ********************************************************************************************************************
	(*C.I.P. -Conical Valve Extraction*)
	VAR_DOS_SEQ_Step.Step[66].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[66].Config.TON_TimePr		:= 45;
	VAR_DOS_SEQ_Step.Step[66].Config.HMI_ID			:= 25;
	
	VAR_DOS_SEQ_Step.Step[66].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[66].Jump[0].Number		:= 69;
	VAR_DOS_SEQ_Step.Step[66].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.CipRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[66].Jump[1].Number		:= 70;
	VAR_DOS_SEQ_Step.Step[66].Jump[2].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[66].Jump[2].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[66].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[66].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[66].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[66].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 67 ********************************************************************************************************************
	(*C.I.P. -Conical Valve Extraction 1st Group Cleaning*)
	VAR_DOS_SEQ_Step.Step[67].Config.T_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[67].Config.T_TimeSTOP		:= NOT MNM.DataOut.MachineRunning OR NOT PstFlr.CipRunning OR PstFlr.CipFlipAllowed;
	VAR_DOS_SEQ_Step.Step[67].Config.T_TimePr		:= 20;
	VAR_DOS_SEQ_Step.Step[67].Config.HMI_ID			:= 26;
	
	VAR_DOS_SEQ_Step.Step[67].Jump[0].Condition		:= VAR_DOS_SEQ_Step.T_Time_END; 
	VAR_DOS_SEQ_Step.Step[67].Jump[0].Number		:= 68;		
	VAR_DOS_SEQ_Step.Step[67].Jump[1].Condition		:= PstFlr.CipRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[67].Jump[1].Number		:= 70;
	VAR_DOS_SEQ_Step.Step[67].Jump[2].Condition		:= PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[67].Jump[2].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[67].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[67].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[67].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[67].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 68 ********************************************************************************************************************
	(*C.I.P. -Conical Valve Extraction 2nd Group Cleaning*)
	VAR_DOS_SEQ_Step.Step[68].Config.T_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[68].Config.T_TimeSTOP		:= NOT MNM.DataOut.MachineRunning OR NOT PstFlr.CipRunning OR PstFlr.CipFlipAllowed;
	VAR_DOS_SEQ_Step.Step[68].Config.T_TimePr		:= 20;
	VAR_DOS_SEQ_Step.Step[68].Config.HMI_ID			:= 27;
	
	VAR_DOS_SEQ_Step.Step[68].Jump[0].Condition		:= VAR_DOS_SEQ_Step.T_Time_END; 
	VAR_DOS_SEQ_Step.Step[68].Jump[0].Number		:= 69;		
	VAR_DOS_SEQ_Step.Step[68].Jump[1].Condition		:= PstFlr.CipRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[68].Jump[1].Number		:= 70;
	VAR_DOS_SEQ_Step.Step[68].Jump[2].Condition		:= PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[68].Jump[2].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[68].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[68].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[68].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[68].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 69 ********************************************************************************************************************
	(*C.I.P. -Conical Valve Extraction 3rd Group Cleaning*)
	VAR_DOS_SEQ_Step.Step[69].Config.T_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[69].Config.T_TimeSTOP		:= NOT MNM.DataOut.MachineRunning OR NOT PstFlr.CipRunning OR PstFlr.CipFlipAllowed;
	VAR_DOS_SEQ_Step.Step[69].Config.T_TimePr		:= 20;
	VAR_DOS_SEQ_Step.Step[69].Config.HMI_ID			:= 28;
	
	VAR_DOS_SEQ_Step.Step[69].Jump[0].Condition		:= FALSE AND VAR_DOS_SEQ_Step.T_Time_END; 
	VAR_DOS_SEQ_Step.Step[69].Jump[0].Number		:= 67;		
	VAR_DOS_SEQ_Step.Step[69].Jump[1].Condition		:= PstFlr.CipRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[69].Jump[1].Number		:= 70;
	VAR_DOS_SEQ_Step.Step[69].Jump[2].Condition		:= PstFlr.CipDrainRequest; 
	VAR_DOS_SEQ_Step.Step[69].Jump[2].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[69].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[69].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[69].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[69].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 70 ********************************************************************************************************************
	(*C.I.P. -Conical Valve Extraction Drain*)
	VAR_DOS_SEQ_Step.Step[70].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[70].Config.TON_TimePr		:= 180;
	VAR_DOS_SEQ_Step.Step[70].Config.HMI_ID			:= 29;
	
	VAR_DOS_SEQ_Step.Step[70].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[70].Jump[0].Number		:= 71;
	VAR_DOS_SEQ_Step.Step[70].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[70].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[70].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[70].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 71 ********************************************************************************************************************
	(*C.I.P. -Conical Valve Extraction Insertion*)
	VAR_DOS_SEQ_Step.Step[71].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[71].Config.TON_TimePr		:= 30;
	VAR_DOS_SEQ_Step.Step[71].Config.HMI_ID			:= 30;
	
	VAR_DOS_SEQ_Step.Step[71].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[71].Jump[0].Number		:= 82;
	VAR_DOS_SEQ_Step.Step[71].Jump[1].Condition		:= PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[71].Jump[1].Number		:= 86;	
	VAR_DOS_SEQ_Step.Step[71].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[71].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[71].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[71].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 73 ********************************************************************************************************************
	(*C.I.P. -Wait for Product Tank at CIP Level*)
	VAR_DOS_SEQ_Step.Step[73].Config.TON_TimeSTART	:= PstFlr.CipProductSending;
	VAR_DOS_SEQ_Step.Step[73].Config.TON_TimePr		:= 10;
	VAR_DOS_SEQ_Step.Step[73].Config.HMI_ID			:= 31;
	
	VAR_DOS_SEQ_Step.Step[73].Jump[0].Condition		:= LTJ[203].OUT_SpReached AND VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.CipReturnEnabled; //PstFlr.CipReturnEnabled PER RMA106
	VAR_DOS_SEQ_Step.Step[73].Jump[0].Number		:= 75;
	VAR_DOS_SEQ_Step.Step[73].Jump[1].Condition		:= PstFlr.CipRecipeCompleted;
	VAR_DOS_SEQ_Step.Step[73].Jump[1].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[73].Jump[2].Condition		:= PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[73].Jump[2].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[73].Jump[3].Condition		:= PstFlr.CipRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[73].Jump[3].Number		:= 82;
	VAR_DOS_SEQ_Step.Step[73].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[73].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[73].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[73].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 75 ********************************************************************************************************************
	(*C.I.P. -Piston Washing*)
	VAR_DOS_SEQ_Step.Step[75].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[75].Config.TON_TimePr		:= REAL_TO_UINT(HMI_PAM_3._622); //Pulp Doser Cip Piston Valve Time
	VAR_DOS_SEQ_Step.Step[75].Config.HMI_ID			:= 32;

	VAR_DOS_SEQ_Step.Step[75].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[75].Jump[0].Number		:= 77;
	VAR_DOS_SEQ_Step.Step[75].Jump[1].Condition		:= PstFlr.CipRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[75].Jump[1].Number		:= 82;
	VAR_DOS_SEQ_Step.Step[75].Jump[2].Condition		:= NOT PstFlr.CipProductSending OR NOT MNM.DataOut.MachineRunning;
	VAR_DOS_SEQ_Step.Step[75].Jump[2].Number		:= 81;
	VAR_DOS_SEQ_Step.Step[75].Jump[3].Condition		:= PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[75].Jump[3].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[75].Jump[4].Condition		:= PstFlr.CipRecipeCompleted;
	VAR_DOS_SEQ_Step.Step[75].Jump[4].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[75].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[75].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[75].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[75].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 77 ********************************************************************************************************************
	(*C.I.P. -Filling Valve Washing*)
	VAR_DOS_SEQ_Step.Step[77].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[77].Config.TON_TimePr		:= REAL_TO_UINT(HMI_PAM_3._623); //Pulp Doser Cip Filling Valve Time
	VAR_DOS_SEQ_Step.Step[77].Config.HMI_ID			:= 33;

	VAR_DOS_SEQ_Step.Step[77].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[77].Jump[0].Number		:= 79;
	VAR_DOS_SEQ_Step.Step[77].Jump[1].Condition		:= PstFlr.CipRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[77].Jump[1].Number		:= 82;
	VAR_DOS_SEQ_Step.Step[77].Jump[2].Condition		:= NOT PstFlr.CipProductSending OR NOT MNM.DataOut.MachineRunning;
	VAR_DOS_SEQ_Step.Step[77].Jump[2].Number		:= 81;
	VAR_DOS_SEQ_Step.Step[77].Jump[3].Condition		:= PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[77].Jump[3].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[77].Jump[4].Condition		:= PstFlr.CipRecipeCompleted;
	VAR_DOS_SEQ_Step.Step[77].Jump[4].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[77].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[77].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[77].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[77].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 79 ********************************************************************************************************************
	(*C.I.P. -Duct Washing*)
	VAR_DOS_SEQ_Step.Step[79].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[79].Config.TON_TimePr		:= 240;
	VAR_DOS_SEQ_Step.Step[79].Config.HMI_ID			:= 34;

	VAR_DOS_SEQ_Step.Step[79].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[79].Jump[0].Number		:= 81;
	VAR_DOS_SEQ_Step.Step[79].Jump[1].Condition		:= PstFlr.CipRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[79].Jump[1].Number		:= 82;
	VAR_DOS_SEQ_Step.Step[79].Jump[2].Condition		:= NOT PstFlr.CipProductSending OR NOT MNM.DataOut.MachineRunning;
	VAR_DOS_SEQ_Step.Step[79].Jump[2].Number		:= 81;
	VAR_DOS_SEQ_Step.Step[79].Jump[3].Condition		:= PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[79].Jump[3].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[79].Jump[4].Condition		:= PstFlr.CipRecipeCompleted;
	VAR_DOS_SEQ_Step.Step[79].Jump[4].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[79].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[79].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[79].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[79].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 81 ********************************************************************************************************************
	(*C.I.P. -End Cleaning Cycle -Cleaning Continuing*)
	VAR_DOS_SEQ_Step.Step[81].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[81].Config.TON_TimePr		:= 5;
	VAR_DOS_SEQ_Step.Step[81].Config.HMI_ID			:= 35;

	VAR_DOS_SEQ_Step.Step[81].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.CipRunning AND PstFlr.CipProductSending AND MNM.DataOut.MachineRunning;
	VAR_DOS_SEQ_Step.Step[81].Jump[0].Number		:= 73; //75
	VAR_DOS_SEQ_Step.Step[81].Jump[1].Condition		:= PstFlr.CipRecoveryRequest;
	VAR_DOS_SEQ_Step.Step[81].Jump[1].Number		:= 82;
	VAR_DOS_SEQ_Step.Step[81].Jump[2].Condition		:= PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[81].Jump[2].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[81].Jump[3].Condition		:= PstFlr.RinseMode; //anche negli altri step?
	VAR_DOS_SEQ_Step.Step[81].Jump[3].Number		:= 73;
	VAR_DOS_SEQ_Step.Step[81].Jump[4].Condition		:= PstFlr.CipRecipeCompleted;
	VAR_DOS_SEQ_Step.Step[81].Jump[4].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[81].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[81].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[81].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[81].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 82 ********************************************************************************************************************
	(*C.I.P. -End Cleaning Cycle -Sanitizer Recovery Running*)
	VAR_DOS_SEQ_Step.Step[82].Config.TON_TimeSTART	:= VAR_DOS_TankEmpted;
	VAR_DOS_SEQ_Step.Step[82].Config.TON_TimePr		:= 15;
	VAR_DOS_SEQ_Step.Step[82].Config.HMI_ID			:= 36;

	VAR_DOS_SEQ_Step.Step[82].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[82].Jump[0].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[82].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[82].Jump[1].Number		:= 83;
	VAR_DOS_SEQ_Step.Step[82].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[82].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[82].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[82].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 83 ********************************************************************************************************************
	(*C.I.P. -End Cleaning Cycle -Sanitizer Recovery Compleated*)
	VAR_DOS_SEQ_Step.Step[83].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[83].Config.TON_TimePr		:= 5;
	VAR_DOS_SEQ_Step.Step[83].Config.HMI_ID			:= 37;
	
	VAR_DOS_SEQ_Step.Step[83].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.CipDrainRequest;
	VAR_DOS_SEQ_Step.Step[83].Jump[0].Number		:= 86;
	VAR_DOS_SEQ_Step.Step[83].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.CipRunning;
	VAR_DOS_SEQ_Step.Step[83].Jump[1].Number		:= 73;
	VAR_DOS_SEQ_Step.Step[83].Jump[2].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.RinseMode;
	VAR_DOS_SEQ_Step.Step[83].Jump[2].Number		:= 73;
	VAR_DOS_SEQ_Step.Step[83].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[83].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[83].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[83].Jump[MAX_JUMP_CFG].Number			:= 201;

	//STEP 86 ********************************************************************************************************************
	(*C.I.P. -End Cleaning Cycle -Drain Running*)
	VAR_DOS_SEQ_Step.Step[86].Config.TON_TimeSTART	:= VAR_DOS_TankEmpted;
	VAR_DOS_SEQ_Step.Step[86].Config.TON_TimePr		:= REAL_TO_UINT(HMI_PAM_3._624); // PARAMETRO DI TEMPO DI DRENAGGIO
	VAR_DOS_SEQ_Step.Step[86].Config.HMI_ID			:= 38;
	IF EDGEPOS(VAR_DOS_SEQ_Step.StepActual = 86) THEN
		VAR_DOS_SeqCipStopRequest := FALSE;
	END_IF
	
	VAR_DOS_SEQ_Step.Step[86].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[86].Jump[0].Number		:= 87;
	VAR_DOS_SEQ_Step.Step[86].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[86].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[86].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[86].Jump[MAX_JUMP_CFG].Number			:= 0;
	
	//STEP 87 ********************************************************************************************************************
	(*C.I.P. - End Cleaning Cycle -Drain Compleated*)
	VAR_DOS_SEQ_Step.Step[87].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[87].Config.TON_TimePr		:= 5;
	VAR_DOS_SEQ_Step.Step[87].Config.HMI_ID			:= 39;

	VAR_DOS_SEQ_Step.Step[87].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.CipRecipeCompleted;
	VAR_DOS_SEQ_Step.Step[87].Jump[0].Number		:= 88;
	VAR_DOS_SEQ_Step.Step[87].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND PstFlr.CipRunning;
	VAR_DOS_SEQ_Step.Step[87].Jump[1].Number		:= 73;
	VAR_DOS_SEQ_Step.Step[87].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[87].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[87].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[87].Jump[MAX_JUMP_CFG].Number			:= 0;
	
	////STEP 88 ********************************************************************************************************************	
	////(*C.I.P. End -Final COP Cycle Running Check*) //COP AUTOMATICO //(*From Filler: on CIP - COP Auto Cycle not Configured or Ended*) FILIPPO
	VAR_DOS_SEQ_Step.Step[88].Config.TON_TimeSTART	:= TRUE; 
	VAR_DOS_SEQ_Step.Step[88].Config.TON_TimePr		:= 15;
	VAR_DOS_SEQ_Step.Step[88].Config.HMI_ID			:= 40;
	
	IF VAR_DOS_SEQ_Step.StepActual = 88 THEN
		VAR_DOS_SeqPositionReached := FALSE;
	END_IF
	
	VAR_DOS_SEQ_Step.Step[88].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND COP.DataOut.DoserPositioningReq;
	VAR_DOS_SEQ_Step.Step[88].Jump[0].Number		:= 89;
	VAR_DOS_SEQ_Step.Step[88].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND NOT COP.DataOut.DoserPositioningReq;
	VAR_DOS_SEQ_Step.Step[88].Jump[1].Number		:= 0; //130
	VAR_DOS_SEQ_Step.Step[88].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[88].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[88].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[88].Jump[MAX_JUMP_CFG].Number			:= 0;

	//STEP 89 ********************************************************************************************************************
	(*C.O.P - HEMA Positioning to Max Height*)
	VAR_DOS_SEQ_Step.Step[89].Config.TON_TimeSTART	:= TRUE; //VAR_DOS_FMDCop; 
	VAR_DOS_SEQ_Step.Step[89].Config.TON_TimePr		:= 5;
	VAR_DOS_SEQ_Step.Step[89].Config.HMI_ID			:= 63;
	
	IF VAR_DOS_SEQ_Step.StepActual = 89 THEN
		VAR_DOS_SeqPermanent.SeqMode1.1 := FALSE; //CIP
		VAR_DOS_SeqPermanent.SeqMode1.4 := TRUE; //COP
	END_IF

	VAR_DOS_SEQ_Step.Step[89].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPositionReached;
	VAR_DOS_SEQ_Step.Step[89].Jump[0].Number		:= 90;
	VAR_DOS_SEQ_Step.Step[89].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND COP.DataOut.Idle; //COP.DataOut.RcpDone;
	VAR_DOS_SEQ_Step.Step[89].Jump[1].Number		:= 0;

	//STEP 90 ********************************************************************************************************************
	(*C.O.P - Cop In Execution*)
	VAR_DOS_SEQ_Step.Step[90].Config.TON_TimeSTART	:= COP.DataOut.RcpActive; 
	VAR_DOS_SEQ_Step.Step[90].Config.TON_TimePr		:= 5;
	VAR_DOS_SEQ_Step.Step[90].Config.HMI_ID			:= 57;

	VAR_DOS_SEQ_Step.Step[90].Jump[0].Condition		:= COP.DataOut.RcpDone; //se faccio abort COP
	VAR_DOS_SEQ_Step.Step[90].Jump[0].Number		:= 91; //change
	
	//STEP 91 ********************************************************************************************************************
	(*C.O.P - Drain Duct*) //change
	VAR_DOS_SEQ_Step.Step[91].Config.TON_TimeSTART	:= NOT LSJ[201].OUT; 
	VAR_DOS_SEQ_Step.Step[91].Config.TON_TimePr		:= 30;
	VAR_DOS_SEQ_Step.Step[91].Config.HMI_ID			:= 51;

	VAR_DOS_SEQ_Step.Step[91].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[91].Jump[0].Number		:= 0;
	
	//92: (* CIP -Wait Dummy Bottles Disinsertion *)
	
	//STEP 95 ********************************************************************************************************************
	(*CIP -  Stopped *)
	VAR_DOS_SEQ_Step.Step[95].Config.TON_TimeSTART		:= NOT VAR_DOS_SeqCipStopAlarm;
	VAR_DOS_SEQ_Step.Step[95].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[95].Config.HMI_ID				:= 54;
	
	VAR_DOS_SEQ_Step.Step[95].Jump[0].Condition					:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_PBResetEp;
	VAR_DOS_SEQ_Step.Step[95].Jump[0].Number					:= VAR_DOS_SeqPermanent.SeqBackupStep; 
	VAR_DOS_SEQ_Step.Step[95].Jump[1].Condition					:= VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[95].Jump[1].Number					:= 0;
	
	//STEP 96 ********************************************************************************************************************
	(* C.I.P. -Press "STOP" to End the Cycle or Press "START" for a New Sequence*)
	VAR_DOS_SEQ_Step.Step[96].Config.TON_TimeSTART			:= TRUE;
	VAR_DOS_SEQ_Step.Step[96].Config.TON_TimePr				:= 2;
	VAR_DOS_SEQ_Step.Step[96].Config.HMI_ID					:= 65;
	
	IF VAR_DOS_SEQ_Step.StepActual = 96 AND VAR_DOS_SEQ_Step.TON_Time_END THEN
		IF VAR_DOS_MemPBStart OR VAR_DOS_MemPBStop THEN
			VAR_DOS_SeqCipAbortRequest		:= FALSE;
		END_IF
	END_IF
	
	VAR_DOS_SEQ_Step.Step[96].Jump[0].Condition	:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_ModeCip AND VAR_DOS_MemPBStart;
	VAR_DOS_SEQ_Step.Step[96].Jump[0].Number		:= 60;
	VAR_DOS_SEQ_Step.Step[96].Jump[1].Condition	:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_MemPBStop;
	VAR_DOS_SEQ_Step.Step[96].Jump[1].Number		:= 86;

	//STEP 100 ********************************************************************************************************************
	(*RINSE -Tank Emptying*)
	VAR_DOS_SEQ_Step.Step[100].Config.TON_TimeSTART		:= VAR_DOS_TankEmpted;
	VAR_DOS_SEQ_Step.Step[100].Config.TON_TimePr		:= 20;
	VAR_DOS_SEQ_Step.Step[100].Config.HMI_ID			:= 42;

	IF VAR_DOS_SEQ_Step.StepActual = 100 THEN  
		VAR_DOS_SeqPermanent.SeqMode1.2 := TRUE;
	END_IF
	
	VAR_DOS_SEQ_Step.Step[100].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[100].Jump[0].Number			:= 101;
	VAR_DOS_SEQ_Step.Step[100].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[100].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[100].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[100].Jump[MAX_JUMP_CFG].Number		:= 201;

	//STEP 101 ********************************************************************************************************************
	(*RINSE -Product Pipe Washing*)
	VAR_DOS_SEQ_Step.Step[101].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[101].Config.TON_TimePr		:= 200;
	VAR_DOS_SEQ_Step.Step[101].Config.HMI_ID		:= 43;

	VAR_DOS_SEQ_Step.Step[101].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[101].Jump[0].Number			:= 103; 
	VAR_DOS_SEQ_Step.Step[101].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[101].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[101].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[101].Jump[MAX_JUMP_CFG].Number		:= 201;
	
	//STEP 102 ********************************************************************************************************************
	(*RINSE -Tank Emtying*)
	VAR_DOS_SEQ_Step.Step[102].Config.TON_TimeSTART		:= VAR_DOS_TankEmpted AND (PstFlr.RinseSending OR PstFlr.RinseAfterProd);
	VAR_DOS_SEQ_Step.Step[102].Config.TON_TimePr		:= 90;
	VAR_DOS_SEQ_Step.Step[102].Config.HMI_ID			:= 44;

	VAR_DOS_SEQ_Step.Step[102].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[102].Jump[0].Number			:= 103;
	VAR_DOS_SEQ_Step.Step[102].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[102].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[102].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[102].Jump[MAX_JUMP_CFG].Number		:= 201;
	
	//STEP 103 ********************************************************************************************************************
	(*RINSE -Tank Filling at Set-Point Level*)
	VAR_DOS_SEQ_Step.Step[103].Config.HMI_ID			:= 45;

	VAR_DOS_SEQ_Step.Step[103].Jump[0].Condition		:= LTJ[203].OUT_SpReached;
	VAR_DOS_SEQ_Step.Step[103].Jump[0].Number			:= 104;
	VAR_DOS_SEQ_Step.Step[103].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[103].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[103].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[103].Jump[MAX_JUMP_CFG].Number		:= 201;
	
	//STEP 104 ********************************************************************************************************************
	(*RINSE -Piston Washing*)
	VAR_DOS_SEQ_Step.Step[104].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[104].Config.TON_TimePr 	:= REAL_TO_UINT(HMI_PAM_3._641); //RINSE PISTON WASHING TIME
	VAR_DOS_SEQ_Step.Step[104].Config.HMI_ID		:= 46;

	VAR_DOS_SEQ_Step.Step[104].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[104].Jump[0].Number			:= 105;
	VAR_DOS_SEQ_Step.Step[104].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[104].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[104].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[104].Jump[MAX_JUMP_CFG].Number		:= 201;
	
	//STEP 105 ********************************************************************************************************************
	(*RINSE -Duct Washing*)
	VAR_DOS_SEQ_Step.Step[105].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[105].Config.TON_TimePr 		:= 60;
	VAR_DOS_SEQ_Step.Step[105].Config.HMI_ID		:= 47;

	VAR_DOS_SEQ_Step.Step[105].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[105].Jump[0].Number			:= 106;
	VAR_DOS_SEQ_Step.Step[105].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[105].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[105].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[105].Jump[MAX_JUMP_CFG].Number		:= 201;
	
	//STEP 106 ********************************************************************************************************************
	(*RINSE -Filling Valve Washing*)
	VAR_DOS_SEQ_Step.Step[106].Config.Laps_Counter_Enable := VAR_DOS_SEQ.Mem.LapsCounter AND PstFlr.RinseSending OR NOT PstFlr.RinseAfterProd;
	VAR_DOS_SEQ_Step.Step[106].Config.Laps_Request		:= REAL_TO_UINT(HMI_PAM_3._643);
	VAR_DOS_SEQ_Step.Step[106].Config.TON_TimeSTART		:= VAR_DOS_SEQ_Step.Laps_Done;
	VAR_DOS_SEQ_Step.Step[106].Config.TON_TimePr		:= 1;
	VAR_DOS_SEQ_Step.Step[106].Config.HMI_ID			:= 48;
	
	IF VAR_DOS_SEQ_Step.StepActual = 106 THEN 
		IF EDGEPOS(VAR_DOS_SEQ_Step.Laps_Done) THEN
			VAR_DOS_RinseCycle := VAR_DOS_RinseCycle + 1.0;
		END_IF
	END_IF

	VAR_DOS_SEQ_Step.Step[106].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND (VAR_DOS_RinseCycle < HMI_PAM_3._642);
	VAR_DOS_SEQ_Step.Step[106].Jump[0].Number			:= 104;
	VAR_DOS_SEQ_Step.Step[106].Jump[1].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND (VAR_DOS_RinseCycle >= HMI_PAM_3._642);
	VAR_DOS_SEQ_Step.Step[106].Jump[1].Number			:= 108;
	VAR_DOS_SEQ_Step.Step[106].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[106].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[106].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[106].Jump[MAX_JUMP_CFG].Number		:= 201;
	
	////STEP 108 ********************************************************************************************************************
	(*RINSE -Tank Drain*)
	VAR_DOS_SEQ_Step.Step[108].Config.TON_TimeSTART		:= VAR_DOS_TankEmpted;
	VAR_DOS_SEQ_Step.Step[108].Config.TON_TimePr		:= REAL_TO_UINT(HMI_PAM_3._624);
	VAR_DOS_SEQ_Step.Step[108].Config.HMI_ID			:= 49;

	IF VAR_DOS_SEQ_Step.StepActual = 108 THEN 
		VAR_DOS_RinseCycle := 0.0;
	END_IF
	
	VAR_DOS_SEQ_Step.Step[108].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[108].Jump[0].Number			:= 109;
	VAR_DOS_SEQ_Step.Step[108].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[108].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[108].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[108].Jump[MAX_JUMP_CFG].Number		:= 201;
	
	//STEP 109 ********************************************************************************************************************
	(*RINSE -Filling Valve Closing*)
	VAR_DOS_SEQ_Step.Step[109].Config.Laps_Counter_Enable := VAR_DOS_SEQ.Mem.LapsCounter;
	VAR_DOS_SEQ_Step.Step[109].Config.Laps_Request		:= 1;
	VAR_DOS_SEQ_Step.Step[109].Config.TON_TimeSTART		:= VAR_DOS_SEQ_Step.Laps_Done;
	VAR_DOS_SEQ_Step.Step[109].Config.TON_TimePr		:= 1;
	VAR_DOS_SEQ_Step.Step[109].Config.HMI_ID			:= 50;

	VAR_DOS_SEQ_Step.Step[109].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[109].Jump[0].Number			:= 0;
	VAR_DOS_SEQ_Step.Step[109].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[109].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[109].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[109].Jump[MAX_JUMP_CFG].Number		:= 201;

	//STEP 115 ********************************************************************************************************************
	(* RINSING - Stopped *)
	VAR_DOS_SEQ_Step.Step[115].Config.TON_TimeSTART			:= NOT VAR_DOS_SeqRinseStopAlarm;
	VAR_DOS_SEQ_Step.Step[115].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[115].Config.HMI_ID				:= 55;
	
	VAR_DOS_SEQ_Step.Step[115].Jump[0].Condition					:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_PBResetEp;
	VAR_DOS_SEQ_Step.Step[115].Jump[0].Number						:= VAR_DOS_SeqPermanent.SeqBackupStep; 
	VAR_DOS_SEQ_Step.Step[115].Jump[MAX_JUMP_CFG-1].Condition		:= FALSE;
	VAR_DOS_SEQ_Step.Step[115].Jump[MAX_JUMP_CFG-1].Number			:= 201;
	VAR_DOS_SEQ_Step.Step[115].Jump[MAX_JUMP_CFG].Condition			:= VAR_DOS_SeqRinseAbortRequest;
	VAR_DOS_SEQ_Step.Step[115].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	////STEP 130 ********************************************************************************************************************
	(*DRAIN -Final Drain*)
	VAR_DOS_SEQ_Step.Step[130].Config.TON_TimeSTART		:= TRUE;
	VAR_DOS_SEQ_Step.Step[130].Config.TON_TimePr		:= REAL_TO_UINT(HMI_PAM_3._645);
	VAR_DOS_SEQ_Step.Step[130].Config.HMI_ID			:= 51;
	
	VAR_DOS_SEQ_Step.Step[130].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_TankEmpted;
	VAR_DOS_SEQ_Step.Step[130].Jump[0].Number			:= 131;
	VAR_DOS_SEQ_Step.Step[130].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqDrainStopRequest;
	VAR_DOS_SEQ_Step.Step[130].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[130].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqDrainAbortRequest;
	VAR_DOS_SEQ_Step.Step[130].Jump[MAX_JUMP_CFG].Number		:= 201;
	
	////STEP 131 ********************************************************************************************************************
	(*DRAIN -Filling Valve Closing*)
	VAR_DOS_SEQ_Step.Step[131].Config.TON_TimeSTART		:= TRUE;
	VAR_DOS_SEQ_Step.Step[131].Config.TON_TimePr		:= 5;
	VAR_DOS_SEQ_Step.Step[131].Config.HMI_ID			:= 52;
	
	VAR_DOS_SEQ_Step.Step[131].Jump[0].Condition		:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[131].Jump[0].Number			:= 0;
	VAR_DOS_SEQ_Step.Step[131].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_DOS_SeqDrainStopRequest;
	VAR_DOS_SEQ_Step.Step[131].Jump[MAX_JUMP_CFG-1].Number		:= 201;
	VAR_DOS_SEQ_Step.Step[131].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqDrainAbortRequest;
	VAR_DOS_SEQ_Step.Step[131].Jump[MAX_JUMP_CFG].Number		:= 201;
	
	//STEP 135 ********************************************************************************************************************
	(* DRAINING - Stopped *)
	VAR_DOS_SEQ_Step.Step[135].Config.TON_TimeSTART			:= NOT VAR_DOS_SeqDrainStopAlarm AND NOT VAR_DOS_SeqCipStopAlarm;
	VAR_DOS_SEQ_Step.Step[135].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[135].Config.HMI_ID				:= 56;
	
	VAR_DOS_SEQ_Step.Step[135].Jump[0].Condition					:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_PBResetEp;
	VAR_DOS_SEQ_Step.Step[135].Jump[0].Number						:= VAR_DOS_SeqPermanent.SeqBackupStep; 
	VAR_DOS_SEQ_Step.Step[135].Jump[MAX_JUMP_CFG-1].Condition		:= FALSE;
	VAR_DOS_SEQ_Step.Step[135].Jump[MAX_JUMP_CFG-1].Number			:= 201;
	VAR_DOS_SEQ_Step.Step[135].Jump[MAX_JUMP_CFG].Condition			:= VAR_DOS_SeqDrainAbortRequest;
	VAR_DOS_SEQ_Step.Step[135].Jump[MAX_JUMP_CFG].Number			:= 201;
	
	//STEP 150 ********************************************************************************************************************
	(* BYPASS - Check Request *)
	VAR_DOS_SEQ_Step.Step[150].Config.TON_TimeSTART			:= TRUE;
	VAR_DOS_SEQ_Step.Step[150].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[150].Config.HMI_ID				:= 58;
	
	VAR_DOS_SEQ_Step.Step[150].Jump[0].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.8 AND GNS.DataOut.DosIncluded; //PRODUCTION ONLY FILLER
	VAR_DOS_SEQ_Step.Step[150].Jump[0].Number				:= 154; //151;
	VAR_DOS_SEQ_Step.Step[150].Jump[1].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.0 AND GNS.DataOut.DosByPassed; //PRODUCTION
	VAR_DOS_SEQ_Step.Step[150].Jump[1].Number				:= 154;//151;
	VAR_DOS_SEQ_Step.Step[150].Jump[2].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.8 AND GNS.DataOut.DosByPassed; //PRODUCTION ONLY FILLER
	VAR_DOS_SEQ_Step.Step[150].Jump[2].Number				:= 155;
	VAR_DOS_SEQ_Step.Step[150].Jump[3].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.0 AND GNS.DataOut.DosIncluded; //PRODUCTION
	VAR_DOS_SEQ_Step.Step[150].Jump[3].Number				:= 155;
//	VAR_DOS_SEQ_Step.Step[150].Jump[4].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END; //MANUAL CAM POSITIONING
//	VAR_DOS_SEQ_Step.Step[150].Jump[4].Number				:= 151;
	
	//STEP 151 ********************************************************************************************************************
	(* BYPASS - Waiting for Machine Stop *)
	VAR_DOS_SEQ_Step.Step[151].Config.TON_TimeSTART			:= NOT MNM.DataOut.MachineRunning AND SFT.DataOut.MachineEmpty AND OPS.DataOut.DoorsOk;
	VAR_DOS_SEQ_Step.Step[151].Config.TON_TimePr			:= 2;
	VAR_DOS_SEQ_Step.Step[151].Config.HMI_ID				:= 74;
	
	VAR_DOS_SEQ_Step.Step[151].Jump[0].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.8;
	VAR_DOS_SEQ_Step.Step[151].Jump[0].Number				:= 152;
	VAR_DOS_SEQ_Step.Step[151].Jump[1].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.0;
	VAR_DOS_SEQ_Step.Step[151].Jump[1].Number				:= 153;
	VAR_DOS_SEQ_Step.Step[151].Jump[2].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND HMI_DOS_SS2P[SS2P_DOS_CamDosByPass].ON; //MANUAL CAM POSITIONING
	VAR_DOS_SEQ_Step.Step[151].Jump[2].Number				:= 152;
	VAR_DOS_SEQ_Step.Step[151].Jump[3].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND HMI_DOS_SS2P[SS2P_DOS_CamDosInclusion].ON; //MANUAL CAM POSITIONING
	VAR_DOS_SEQ_Step.Step[151].Jump[3].Number				:= 153;
	VAR_DOS_SEQ_Step.Step[151].Jump[MAX_JUMP_CFG].Condition	:= VAR_DOS_SeqBypassStopAlarm OR VAR_DOS_SeqBypassAbortRequest;
	VAR_DOS_SEQ_Step.Step[151].Jump[MAX_JUMP_CFG].Number	:= 154;

	//STEP 152 ********************************************************************************************************************
	(* BYPASS - Doser Bypass *)
	VAR_DOS_SEQ_Step.Step[152].Config.TON_TimeSTART		:= GNS.DataOut.DosByPassed;
	VAR_DOS_SEQ_Step.Step[152].Config.TON_TimePr		:= 2;
	VAR_DOS_SEQ_Step.Step[152].Config.HMI_ID			:= 59;
	
	IF VAR_DOS_SEQ_Step.StepActual = 152 AND VAR_DOS_SEQ_Step.TON_Time_END THEN
		VAR_DOS_SeqPermanent.SeqMode1.6 := FALSE;
	END_IF
	
	IF VAR_DOS_SEQ_Step.StepActual = 152 THEN
		VAR_DOS_SeqPermanent.SeqMode2.2 := TRUE;
		VAR_DOS_SeqPermanent.SeqMode2.3 := FALSE;
	END_IF
	
	VAR_DOS_SEQ_Step.Step[152].Jump[0].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[152].Jump[0].Number				:= 155;
	VAR_DOS_SEQ_Step.Step[152].Jump[MAX_JUMP_CFG].Condition	:= VAR_DOS_SeqBypassStopAlarm OR VAR_DOS_SeqBypassAbortRequest; 
	VAR_DOS_SEQ_Step.Step[152].Jump[MAX_JUMP_CFG].Number	:= 154;
	
	//STEP 153 ********************************************************************************************************************
	(* BYPASS - Doser Included  *)
	VAR_DOS_SEQ_Step.Step[153].Config.TON_TimeSTART		:= GNS.DataOut.DosIncluded;
	VAR_DOS_SEQ_Step.Step[153].Config.TON_TimePr		:= 2;
	VAR_DOS_SEQ_Step.Step[153].Config.HMI_ID			:= 61;
	
	IF VAR_DOS_SEQ_Step.StepActual = 153 AND VAR_DOS_SEQ_Step.TON_Time_END THEN
		VAR_DOS_SeqPermanent.SeqMode1.6 := FALSE;
	END_IF
	
	IF VAR_DOS_SEQ_Step.StepActual = 153 THEN
		VAR_DOS_SeqPermanent.SeqMode2.2 := FALSE;
		VAR_DOS_SeqPermanent.SeqMode2.3 := TRUE;
	END_IF
	
	VAR_DOS_SEQ_Step.Step[153].Jump[0].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[153].Jump[0].Number					:= 155;
	VAR_DOS_SEQ_Step.Step[153].Jump[MAX_JUMP_CFG].Condition		:= VAR_DOS_SeqBypassStopAlarm OR VAR_DOS_SeqBypassAbortRequest;
	VAR_DOS_SEQ_Step.Step[153].Jump[MAX_JUMP_CFG].Number		:= 154;
	
	//STEP 154 ********************************************************************************************************************
	(* BYPASS - Error *)
	VAR_DOS_SEQ_Step.Step[154].Config.TON_TimeSTART			:= TRUE; //NOT VAR_DOS_SeqBypassStopAlarm;
	VAR_DOS_SEQ_Step.Step[154].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[154].Config.HMI_ID				:= 60;
	
	VAR_DOS_SEQ_Step.Step[154].Jump[0].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_PBResetEp;
	VAR_DOS_SEQ_Step.Step[154].Jump[0].Number				:= 150; 
	VAR_DOS_SEQ_Step.Step[154].Jump[1].Condition			:= VAR_DOS_SeqBypassAbortRequest;
	VAR_DOS_SEQ_Step.Step[154].Jump[1].Number				:= 0; 
	
	//STEP 155 ********************************************************************************************************************
	(* BYPASS - Operation Completed *)
	VAR_DOS_SEQ_Step.Step[155].Config.TON_TimeSTART			:= TRUE;
	VAR_DOS_SEQ_Step.Step[155].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[155].Config.HMI_ID				:= 73;
	
	VAR_DOS_SEQ_Step.Step[155].Jump[0].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.8; //PRODUCTION ONLY FILLER
	VAR_DOS_SEQ_Step.Step[155].Jump[0].Number					:= 170;
	VAR_DOS_SEQ_Step.Step[155].Jump[1].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.0; //PRODUCTION
	VAR_DOS_SEQ_Step.Step[155].Jump[1].Number					:= 1;
	VAR_DOS_SEQ_Step.Step[155].Jump[2].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END; //MANUAL CAM POSITIONING
	VAR_DOS_SEQ_Step.Step[155].Jump[2].Number					:= 0;

	//STEP 160 ********************************************************************************************************************
	(* MOTORIZATION - Doser Axis Check *)
	VAR_DOS_SEQ_Step.Step[160].Config.TON_TimeSTART			:= TRUE;
	VAR_DOS_SEQ_Step.Step[160].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[160].Config.HMI_ID				:= 66;
	
	VAR_DOS_SEQ_Step.Step[160].Jump[0].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.1 AND NOT TNK.DataOut.CipMode; //CIP
	VAR_DOS_SEQ_Step.Step[160].Jump[0].Number					:= 161;
	VAR_DOS_SEQ_Step.Step[160].Jump[1].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.2 AND MNM.DataOut.DoserAxisDisabled; //RINSE
	VAR_DOS_SEQ_Step.Step[160].Jump[1].Number					:= 161;
	VAR_DOS_SEQ_Step.Step[160].Jump[2].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.3 AND MNM.DataOut.DoserAxisDisabled; //DRAIN
	VAR_DOS_SEQ_Step.Step[160].Jump[2].Number					:= 161;
	VAR_DOS_SEQ_Step.Step[160].Jump[3].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.4; //MANUAL COP
	VAR_DOS_SEQ_Step.Step[160].Jump[3].Number					:= 161;
	VAR_DOS_SEQ_Step.Step[160].Jump[4].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.0 AND MNM.DataOut.DoserAxisDisabled; //PRODUCTION
	VAR_DOS_SEQ_Step.Step[160].Jump[4].Number					:= 161;
	VAR_DOS_SEQ_Step.Step[160].Jump[5].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.8 AND NOT MNM.DataOut.DoserAxisDisabled; //PRODUCTION ONLY FILLER
	VAR_DOS_SEQ_Step.Step[160].Jump[5].Number					:= 161;
	VAR_DOS_SEQ_Step.Step[160].Jump[6].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND TNK.DataOut.CipMode AND MAU_DumCon.DataOut.InstallDone AND NOT MNM.DataOut.DoserAxisDisabled; //CIP WITH FILLER
	VAR_DOS_SEQ_Step.Step[160].Jump[6].Number					:= 161;
	VAR_DOS_SEQ_Step.Step[160].Jump[7].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND NOT TNK.DataOut.CipMode;
	VAR_DOS_SEQ_Step.Step[160].Jump[7].Number					:= 164;

	//STEP 161 ********************************************************************************************************************
	(* MOTORIZATION - Waiting for Machine Stop for Enabling/Disabling Axis *)
	VAR_DOS_SEQ_Step.Step[161].Config.TON_TimeSTART			:= NOT MNM.DataOut.MachineRunning AND SFT.DataOut.MachineEmpty;
	VAR_DOS_SEQ_Step.Step[161].Config.TON_TimePr			:= 1;
	IF VAR_DOS_SeqPermanent.SeqMode1.8 THEN
		VAR_DOS_SEQ_Step.Step[161].Config.HMI_ID				:= 67;
	ELSE 
		VAR_DOS_SEQ_Step.Step[161].Config.HMI_ID				:= 68;
	END_IF
	
	IF TNK.DataOut.CipMode AND MAU_DumCon.DataOut.RemoveDone THEN 
		VAR_DOS_SeqPermanent.SeqMode2.6 := FALSE;
	END_IF
		
	VAR_DOS_SEQ_Step.Step[161].Jump[0].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.8; //DISABLE
	VAR_DOS_SEQ_Step.Step[161].Jump[0].Number					:= 163;
	VAR_DOS_SEQ_Step.Step[161].Jump[1].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND TNK.DataOut.CipMode AND MAU_DumCon.DataOut.InstallDone; //CIP WITH FILLER 
	VAR_DOS_SEQ_Step.Step[161].Jump[1].Number					:= 162;
	VAR_DOS_SEQ_Step.Step[161].Jump[2].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND NOT VAR_DOS_SeqPermanent.SeqMode1.8 AND NOT TNK.DataOut.CipMode; //ENABLE
	VAR_DOS_SEQ_Step.Step[161].Jump[2].Number					:= 162;

	//STEP 162 ********************************************************************************************************************
	(* MOTORIZATION - Doser Axis Enabling in Progress *)
	VAR_DOS_SEQ_Step.Step[162].Config.TON_TimeSTART			:= NOT MNM.DataOut.MachineRunning;
	VAR_DOS_SEQ_Step.Step[162].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[162].Config.HMI_ID				:= 69;
	
	IF VAR_DOS_SEQ_Step.StepActual = 162 AND (TNK.DataOut.CipMode OR VAR_DOS_SeqPermanent.SeqMode1.1 OR VAR_DOS_SeqPermanent.SeqMode1.4) THEN 
		VAR_DOS_SeqPermanent.SeqMode2.6 := TRUE;
	END_IF
	
		IF VAR_DOS_SEQ_Step.StepActual = 162 THEN
		VAR_DOS_SeqPermanent.SeqMode2.4 := TRUE;
		VAR_DOS_SeqPermanent.SeqMode2.5 := FALSE;
	END_IF
	
	VAR_DOS_SEQ_Step.Step[162].Jump[0].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_MemFillerAxisOffReq AND MNM.DataOut.FillerAxisDisabled AND NOT MNM.DataOut.DoserAxisDisabled;
	VAR_DOS_SEQ_Step.Step[162].Jump[0].Number					:= 164;	
	VAR_DOS_SEQ_Step.Step[162].Jump[1].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_MemDoserAxisOn AND NOT MNM.DataOut.DoserAxisDisabled;
	VAR_DOS_SEQ_Step.Step[162].Jump[1].Number					:= 164;
	
	//STEP 163 ********************************************************************************************************************
	(* MOTORIZATION - Doser Axis Disabling in Progress *)
	VAR_DOS_SEQ_Step.Step[163].Config.TON_TimeSTART			:= NOT MNM.DataOut.MachineRunning;
	VAR_DOS_SEQ_Step.Step[163].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[163].Config.HMI_ID				:= 70;
	
	IF VAR_DOS_SEQ_Step.StepActual = 163 THEN
		VAR_DOS_SeqPermanent.SeqMode2.4 := FALSE;
		VAR_DOS_SeqPermanent.SeqMode2.5 := TRUE;
	END_IF
	
	VAR_DOS_SEQ_Step.Step[163].Jump[0].Condition				:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_MemDoserAxisOff AND MNM.DataOut.DoserAxisDisabled;
	VAR_DOS_SEQ_Step.Step[163].Jump[0].Number					:= 164;
	
	//STEP 164 ********************************************************************************************************************
	(* MOTORIZATION - Operation Completed *)
	VAR_DOS_SEQ_Step.Step[164].Config.TON_TimeSTART			:= TRUE;
	VAR_DOS_SEQ_Step.Step[164].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[164].Config.HMI_ID				:= 71;
	
	VAR_DOS_SEQ_Step.Step[164].Jump[0].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.0; //PRODUCTION
	VAR_DOS_SEQ_Step.Step[164].Jump[0].Number				:= 150;
	VAR_DOS_SEQ_Step.Step[164].Jump[1].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.1;// AND MNM.DataOut.FillerAxisDisabled; //CIP PROVVISORIO
	VAR_DOS_SEQ_Step.Step[164].Jump[1].Number				:= 73;
	VAR_DOS_SEQ_Step.Step[164].Jump[2].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.2; //RINSE
	VAR_DOS_SEQ_Step.Step[164].Jump[2].Number				:= 101; 
	VAR_DOS_SEQ_Step.Step[164].Jump[3].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.3; //DRAIN
	VAR_DOS_SEQ_Step.Step[164].Jump[3].Number				:= 130;
	VAR_DOS_SEQ_Step.Step[164].Jump[4].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.4; //MANUAL COP
	VAR_DOS_SEQ_Step.Step[164].Jump[4].Number				:= 89;
	VAR_DOS_SEQ_Step.Step[164].Jump[5].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_SeqPermanent.SeqMode1.8; //DOSER EXCLUDED
	VAR_DOS_SEQ_Step.Step[164].Jump[5].Number				:= 150;
	VAR_DOS_SEQ_Step.Step[164].Jump[6].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END AND TNK.DataOut.CipMode; //CIP WITH FILLER
	VAR_DOS_SEQ_Step.Step[164].Jump[6].Number				:= 60;

	//STEP 165 ********************************************************************************************************************
	(* MOTORIZATION - Error *)
	VAR_DOS_SEQ_Step.Step[165].Config.TON_TimeSTART			:= VAR_DOS_PBResetEp;
	VAR_DOS_SEQ_Step.Step[165].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[165].Config.HMI_ID				:= 75;
	
	VAR_DOS_SEQ_Step.Step[165].Jump[0].Condition			:= VAR_DOS_SEQ_Step.TON_Time_END;
	VAR_DOS_SEQ_Step.Step[165].Jump[0].Number				:= 160; 
	
	//STEP 170 ********************************************************************************************************************
	(* PRODUCTION - Doser Excluded *)
	VAR_DOS_SEQ_Step.Step[170].Config.TON_TimeSTART			:= TRUE;
	VAR_DOS_SEQ_Step.Step[170].Config.TON_TimePr			:= 1;
	VAR_DOS_SEQ_Step.Step[170].Config.HMI_ID				:= 72;
	
	VAR_DOS_SEQ_Step.Step[170].Jump[0].Condition				:= TNK.DataOut.Wait;
	VAR_DOS_SEQ_Step.Step[170].Jump[0].Number					:= 0;
	
	//STEP 201 ********************************************************************************************************************
	(* PRODUCTION/rinse/CIP/DRAINING - Stopping *)
	VAR_DOS_SEQ_Step.Step[201].Config.TON_TimeSTART	:= TRUE;
	VAR_DOS_SEQ_Step.Step[201].Config.TON_TimePr	:= 1;
	
	IF VAR_DOS_ModeProduction THEN
		VAR_DOS_SEQ_Step.Step[201].Config.HMI_ID	:= 53;
	ELSIF VAR_DOS_ModeCip	THEN
		VAR_DOS_SEQ_Step.Step[201].Config.HMI_ID	:= 54;
	ELSIF VAR_DOS_ModeRinse THEN
		VAR_DOS_SEQ_Step.Step[201].Config.HMI_ID	:= 55;
	ELSIF VAR_DOS_ModeDrain THEN
		VAR_DOS_SEQ_Step.Step[201].Config.HMI_ID	:= 56;
	ELSE
		VAR_DOS_SEQ_Step.Step[201].Config.HMI_ID	:= 60;
	END_IF
	
//	IF FB_DOS_SEQ.OUT_StepActual = 201 THEN
//		IF FB_DOS_SEQ.OUT_StepPrevious < 20  THEN 
//			VAR_DOS_SeqPermanent.SeqBackupStep := 1;
//		END_IF
//		HMI_DOS_PB[PB_CmdPause].LampON		:= FALSE;
//	END_IF
	
	VAR_DOS_SEQ_Step.Step[201].Jump[0].Condition	:= VAR_DOS_SEQ_Step.TON_Time_END AND (VAR_DOS_SeqProdAbortRequest OR VAR_DOS_SeqDrainAbortRequest OR VAR_DOS_SeqRinseAbortRequest);
	VAR_DOS_SEQ_Step.Step[201].Jump[0].Number		:= 0;
	VAR_DOS_SEQ_Step.Step[201].Jump[1].Condition	:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_ModeCip AND VAR_DOS_SeqCipAbortRequest;
	VAR_DOS_SEQ_Step.Step[201].Jump[1].Number		:= 96;
	VAR_DOS_SEQ_Step.Step[201].Jump[2].Condition	:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_ModeProduction AND VAR_DOS_SeqProdStopRequest;
	VAR_DOS_SEQ_Step.Step[201].Jump[2].Number		:= 55;
	VAR_DOS_SEQ_Step.Step[201].Jump[3].Condition	:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_ModeCip AND VAR_DOS_SeqCipStopRequest;
	VAR_DOS_SEQ_Step.Step[201].Jump[3].Number		:= 95;
	VAR_DOS_SEQ_Step.Step[201].Jump[4].Condition	:= VAR_DOS_SEQ_Step.TON_Time_END AND (VAR_DOS_ModeCip OR VAR_DOS_ModeDrain) AND VAR_DOS_SeqDrainStopRequest;
	VAR_DOS_SEQ_Step.Step[201].Jump[4].Number		:= 135;
	VAR_DOS_SEQ_Step.Step[201].Jump[5].Condition	:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_ModeRinse AND VAR_DOS_SeqRinseStopRequest;
	VAR_DOS_SEQ_Step.Step[201].Jump[5].Number		:= 115;
	VAR_DOS_SEQ_Step.Step[201].Jump[6].Condition	:= VAR_DOS_SEQ_Step.TON_Time_END AND VAR_DOS_ModeBypass;
	VAR_DOS_SEQ_Step.Step[201].Jump[6].Number		:= 152;
	VAR_DOS_SEQ_Step.Step[201].Jump[7].Condition	:= VAR_DOS_SEQ_Step.TON_Time_END AND NOT VAR_DOS_ModeBypass;
	VAR_DOS_SEQ_Step.Step[201].Jump[7].Number		:= 0;
	
//	//FLIP STATUS TO HMI ***********************************************************************************************************
//	IF VAR_DOS_FlipSeqStart AND VAR_DOS_FlipSeqEnable AND NOT VAR_DOS_FlipSeqEnd (*AND TMR_TON_SequenceText.Q*) THEN
//		VAR_DOS_SEQ_Step.Step[VAR_DOS_SEQ_Step.StepActual].Config.HMI_ID := 999;
//	END_IF
	
	//*******************************************************************************************************************************
	//*******************************************************************************************************************************
	//*******************************************************************************************************************************
	
	//V1.2.4
	VAR_DOS_SeqBackupAllowed := VAR_DOS_SeqPermanent.SeqActualStep <> 201;
	FOR VAR_DOS_SeqFor := 0 TO MAX_JUMP_CFG DO
		IF VAR_DOS_SEQ_Step.Step[LIMIT(0,VAR_DOS_SeqPermanent.SeqActualStep, MAX_STEP_CFG)].Jump[VAR_DOS_SeqFor].Condition THEN //CHECK FOR A JUMP CONDITION
			IF VAR_DOS_SeqBackupAllowed THEN //DIFFERENT FROM TRANSITION STEP
				VAR_DOS_SeqPermanent.SeqBackupStep := VAR_DOS_SeqPermanent.SeqActualStep; //BACKUP OF THE STEP BEFORE TO GO TO NEXT
			END_IF
			VAR_DOS_SeqPermanent.SeqActualStep 	:= VAR_DOS_SEQ_Step.Step[LIMIT(0, VAR_DOS_SeqPermanent.SeqActualStep, MAX_STEP_CFG)].Jump[VAR_DOS_SeqFor].Number; //NEXT STEP TO REACH
			EXIT;
		END_IF	
	END_FOR
	
	FB_DOS_SEQ(
	IN_Step 				:= VAR_DOS_SeqPermanent.SeqActualStep,
	IN_StepConfig			:= VAR_DOS_SEQ_Step.Step[LIMIT(0, VAR_DOS_SeqPermanent.SeqActualStep, MAX_STEP_CFG)].Config,
	IN_T_TimeClock			:= AID.DataOut.Blink1Hz,
	IN_Pause_Request 		:= VAR_DOS_MemSSPause,
	IN_FillingValveNr 		:= HMI_PAC_1._500, //DOSER FILLING VALVES NUMBER
	IN_StepCounter 			:= SFT.DataOut.DoserFillerSteps,
	CyclesCounter 			:= VAR_DOS_SeqCyclesCounter,
	);
	
	VAR_DOS_SEQ_Step.StepActual		:= FB_DOS_SEQ.OUT_StepActual;
	VAR_DOS_SeqActualStep			:= VAR_DOS_SEQ_Step.StepActual;

	VAR_DOS_SEQ_Step.Laps_Done 		:= FB_DOS_SEQ.OUT_Laps_Done;
	VAR_DOS_SEQ_Step.Cycles_Done    := FB_DOS_SEQ.OUT_Cycles_Done;
	VAR_DOS_SEQ_Step.T_Time_END 	:= FB_DOS_SEQ.OUT_T_Time_END;
	VAR_DOS_SEQ_Step.TO_Time_END 	:= FB_DOS_SEQ.OUT_TO_Time_END;
	VAR_DOS_SEQ_Step.TON_Time_END 	:= FB_DOS_SEQ.OUT_TON_Time_END;
	
	IF VAR_DOS_SeqPermanent.SeqActualStep = 0 THEN
		VAR_DOS_SeqPermanent.SeqMode1 	:= 0;
		VAR_DOS_SeqPermanent.SeqMode2.0 := FALSE;
	END_IF	
END_ACTION
