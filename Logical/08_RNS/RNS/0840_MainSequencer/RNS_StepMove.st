ACTION RNS_StepMove:
//CYCLE START
	IF VAR_RNS_ModeWait THEN//vrma
		VAR_RNS_SeqPermanent.SeqMode1.0 := VAR_RNS_FMDProduction;
		VAR_RNS_SeqPermanent.SeqMode1.1 := VAR_RNS_FMDCip;
		VAR_RNS_SeqPermanent.SeqMode1.2 := FALSE;
		VAR_RNS_SeqPermanent.SeqMode1.3 := VAR_RNS_FMDDrain;
		VAR_RNS_SeqPermanent.SeqMode1.5	:= VAR_RNS_FMDControl;
	END_IF
	
	IF VAR_RNS_ModeProduction AND VAR_RNS_FMDDrain THEN
		VAR_RNS_SeqPermanent.SeqMode2.0 := TRUE;//drain in production
	END_IF
	
	IF VAR_RNS_ModeProduction AND VAR_RNS_FMDControl THEN
		VAR_RNS_SeqPermanent.SeqMode2.1 := FALSE; // leo TRUE;//Nozzle control in production
	END_IF
		
	IF VAR_RNS_FMDProduction AND VAR_RNS_StepControlDone THEN//vrma
		VAR_RNS_SeqPermanent.SeqMode2.1 := FALSE;
	END_IF
	
	//STEP 00 ********************************************************************************************************************
	(* Wait *)
	VAR_RNS_SEQ_Step.Step[0].Config.Laps_Counter_Enable	:= FALSE;
	VAR_RNS_SEQ_Step.Step[0].Config.Laps_Request		:= 0;
	VAR_RNS_SEQ_Step.Step[0].Config.T_TimeSTART			:= FALSE;
	VAR_RNS_SEQ_Step.Step[0].Config.T_TimeSTOP			:= FALSE;
	VAR_RNS_SEQ_Step.Step[0].Config.T_TimeRESET			:= FALSE;
	VAR_RNS_SEQ_Step.Step[0].Config.T_TimePr			:= 0;
	VAR_RNS_SEQ_Step.Step[0].Config.TON_TimeSTART		:= FALSE;
	VAR_RNS_SEQ_Step.Step[0].Config.TON_TimePr			:= 0;
	VAR_RNS_SEQ_Step.Step[0].Config.TO_TimePr			:= 0;
	VAR_RNS_SEQ_Step.Step[0].Config.Cycle_RESET	        := TRUE;
	VAR_RNS_SEQ_Step.Step[0].Config.HMI_ID				:= 0;
	
	VAR_RNS_SEQ_Step.Step[0].Jump[0].Condition		:= VAR_RNS_ModeWait AND VAR_RNS_SeqPermanent.SeqMode1.0 AND NOT RNS.DataOut.ByPassed; //PRODUCTION
	VAR_RNS_SEQ_Step.Step[0].Jump[0].Number			:= 11;
	VAR_RNS_SEQ_Step.Step[0].Jump[1].Condition		:= VAR_RNS_ModeWait AND VAR_RNS_SeqPermanent.SeqMode1.1;//CIP																													; //CIP
	VAR_RNS_SEQ_Step.Step[0].Jump[1].Number			:= 40;//cip
	VAR_RNS_SEQ_Step.Step[0].Jump[2].Condition		:= VAR_RNS_ModeWait AND VAR_RNS_SeqPermanent.SeqMode1.3 AND NOT RNS.DataOut.ByPassed; //DRAIN
	VAR_RNS_SEQ_Step.Step[0].Jump[2].Number			:= 50; 
	VAR_RNS_SEQ_Step.Step[0].Jump[4].Condition		:= VAR_RNS_ModeWait AND VAR_RNS_SeqPermanent.SeqMode1.5; //CONTROL
	VAR_RNS_SEQ_Step.Step[0].Jump[4].Number			:= 70;

	//STEP 01..10 ****************************************************************************************************************
	
	//STEP 11 ********************************************************************************************************************
	(* START-UP - Waiting for Water Ready *)
	VAR_RNS_SEQ_Step.Step[11].Config.TON_TimeSTART			:= 	FSB[220].OUT_OnDelayed AND FTB[202].OUT_SpReached;//vrma
																
	VAR_RNS_SEQ_Step.Step[11].Config.TON_TimePr				:= 10;
	VAR_RNS_SEQ_Step.Step[11].Config.TO_TimePr				:= 300;
	VAR_RNS_SEQ_Step.Step[11].Config.HMI_ID					:= 14;
	
	VAR_RNS_SEQ_Step.Step[11].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[11].Jump[0].Number					:= 13;
	VAR_RNS_SEQ_Step.Step[11].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[11].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[11].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqProdAbortRequest;
	VAR_RNS_SEQ_Step.Step[11].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 13 ********************************************************************************************************************
	(* START-UP - Priming Nozzle Check Pressure and Flow *)
	VAR_RNS_SEQ_Step.Step[13].Config.TON_TimeSTART			:= PTB[220].OUT_SpReached AND FTB[202].OUT_SpReached;
	VAR_RNS_SEQ_Step.Step[13].Config.TON_TimePr				:= 1;
	VAR_RNS_SEQ_Step.Step[13].Config.TO_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[13].Config.HMI_ID					:= 50;//change text 
	
	VAR_RNS_SEQ_Step.Step[13].Jump[0].Condition						:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[13].Jump[0].Number						:= 14;
	VAR_RNS_SEQ_Step.Step[13].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[13].Jump[MAX_JUMP_CFG-1].Number			:= 101;
	
	//STEP 14 ********************************************************************************************************************
	(* START-UP - Priming Nozzle *)
	VAR_RNS_SEQ_Step.Step[14].Config.Laps_Counter_Enable	:= PTB[220].OUT_SpReached AND FTB[202].OUT_SpReached;
	VAR_RNS_SEQ_Step.Step[14].Config.Laps_Request			:= 2;
	VAR_RNS_SEQ_Step.Step[14].Config.TON_TimeSTART			:= VAR_RNS_SEQ_Step.Laps_Done;
	VAR_RNS_SEQ_Step.Step[14].Config.TO_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[14].Config.Cycle_RESET			:= FALSE;
	VAR_RNS_SEQ_Step.Step[14].Config.HMI_ID					:= 51;
	
	VAR_RNS_SEQ_Step.Step[14].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[14].Jump[0].Number					:= 16;
	VAR_RNS_SEQ_Step.Step[14].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[14].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[14].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqProdAbortRequest;
	VAR_RNS_SEQ_Step.Step[14].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 15 ********************************************************************************************************************//vrma
	(* START-UP - Machine Stopped *)
	VAR_RNS_SEQ_Step.Step[15].Config.TON_TimeSTART			:= NOT MNM.DataOut.MachineRunning;//vrma
	VAR_RNS_SEQ_Step.Step[15].Config.TON_TimePr				:= 1;
	VAR_RNS_SEQ_Step.Step[15].Config.TO_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[15].Config.HMI_ID					:= 3;//change text 
	
	VAR_RNS_SEQ_Step.Step[15].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[15].Jump[0].Number					:= 16;
	VAR_RNS_SEQ_Step.Step[15].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[15].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[15].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqProdAbortRequest;
	VAR_RNS_SEQ_Step.Step[15].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP  16 ********************************************************************************************************************
	(* START-UP - Waiting for Containers *)
	VAR_RNS_SEQ_Step.Step[16].Config.TON_TimeSTART			:= NOT SFT.DataOut.MachineEmpty;
	VAR_RNS_SEQ_Step.Step[16].Config.TON_TimePr				:= 1;
	VAR_RNS_SEQ_Step.Step[16].Config.TO_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[16].Config.HMI_ID					:= 3;
	
	VAR_RNS_SEQ_Step.Step[16].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[16].Jump[0].Number					:= 20;
	VAR_RNS_SEQ_Step.Step[16].Jump[1].Condition					:= VAR_RNS_ModeProduction AND VAR_RNS_SeqPermanent.SeqMode2.1; //CONTROL
	VAR_RNS_SEQ_Step.Step[16].Jump[1].Number					:= 70;
	VAR_RNS_SEQ_Step.Step[16].Jump[2].Condition					:= VAR_RNS_SeqPermanent.SeqMode2.0;//DRAIN
	VAR_RNS_SEQ_Step.Step[16].Jump[2].Number					:= 50;
	VAR_RNS_SEQ_Step.Step[16].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[16].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[16].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqProdAbortRequest;
	VAR_RNS_SEQ_Step.Step[16].Jump[MAX_JUMP_CFG].Number			:= 101;
	//STEP 17..19 ****************************************************************************************************************
	
	//STEP 20 ********************************************************************************************************************
	(* PRODUCTION - Running Water Only *)
	VAR_RNS_SEQ_Step.Step[20].Config.TON_TimeSTART		:= SFT.DataOut.MachineEmpty;
	VAR_RNS_SEQ_Step.Step[20].Config.TON_TimePr			:= 2;
	VAR_RNS_SEQ_Step.Step[20].Config.HMI_ID				:= 4;//vrma
	
	VAR_RNS_SEQ_Step.Step[20].Jump[1].Condition					:= FALSE; // leo VAR_RNS_ModeProduction AND VAR_RNS_TankLevelHigh;
	VAR_RNS_SEQ_Step.Step[20].Jump[1].Number					:= 29;
	VAR_RNS_SEQ_Step.Step[20].Jump[2].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[20].Jump[2].Number					:= 16;
	VAR_RNS_SEQ_Step.Step[20].Jump[3].Condition					:= VAR_RNS_SeqPermanent.SeqMode2.0;//DRAIN
	VAR_RNS_SEQ_Step.Step[20].Jump[3].Number					:= 50;
	VAR_RNS_SEQ_Step.Step[20].Jump[4].Condition					:= CvoFlr.StartWaterFromPastorizer;
	VAR_RNS_SEQ_Step.Step[20].Jump[4].Number					:= 22;
	VAR_RNS_SEQ_Step.Step[20].Jump[MAX_JUMP_CFG-3].Condition	:= VAR_RNS_ModeProduction AND VAR_RNS_SeqPermanent.SeqMode2.1 AND SFT.DataOut.MachineEmpty; //CONTROL
	VAR_RNS_SEQ_Step.Step[20].Jump[MAX_JUMP_CFG-3].Number		:= 70;
	VAR_RNS_SEQ_Step.Step[20].Jump[MAX_JUMP_CFG-1].Condition	:= FALSE; // leo VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[20].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[20].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqProdAbortRequest;
	VAR_RNS_SEQ_Step.Step[20].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 21 ********************************************************************************************************************
	(* PRODUCTION - Water Shower Request *)
	VAR_RNS_SEQ_Step.Step[21].Config.TON_TimeSTART				:= NOT SFT.DataOut.OutletShowerReq;
	VAR_RNS_SEQ_Step.Step[21].Config.TON_TimePr					:= 2;
	VAR_RNS_SEQ_Step.Step[21].Config.HMI_ID						:= 4;//vrma

	VAR_RNS_SEQ_Step.Step[21].Jump[2].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[21].Jump[2].Number					:= 20;
	VAR_RNS_SEQ_Step.Step[21].Jump[3].Condition					:= VAR_RNS_SeqPermanent.SeqMode2.0;//DRAIN
	VAR_RNS_SEQ_Step.Step[21].Jump[3].Number					:= 50;
	VAR_RNS_SEQ_Step.Step[21].Jump[MAX_JUMP_CFG-3].Condition	:= VAR_RNS_ModeProduction AND VAR_RNS_SeqPermanent.SeqMode2.1 AND SFT.DataOut.MachineEmpty; //CONTROL
	VAR_RNS_SEQ_Step.Step[21].Jump[MAX_JUMP_CFG-3].Number		:= 70;
	VAR_RNS_SEQ_Step.Step[21].Jump[MAX_JUMP_CFG-1].Condition	:= FALSE; // leo VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[21].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[21].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqProdAbortRequest;
	VAR_RNS_SEQ_Step.Step[21].Jump[MAX_JUMP_CFG].Number			:= 101;

	//STEP 22 ********************************************************************************************************************
	(* PRODUCTION - Water Pasto Request *)
	VAR_RNS_SEQ_Step.Step[22].Config.TON_TimeSTART				:= NOT CvoFlr.StartWaterFromPastorizer;
	VAR_RNS_SEQ_Step.Step[22].Config.TON_TimePr					:= 2;
	VAR_RNS_SEQ_Step.Step[22].Config.HMI_ID						:= 4;//vrma
	
	VAR_RNS_SEQ_Step.Step[22].Jump[1].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END; // leo VAR_RNS_ModeProduction AND VAR_RNS_TankLevelHigh;
	VAR_RNS_SEQ_Step.Step[22].Jump[1].Number					:= 20;
	VAR_RNS_SEQ_Step.Step[22].Jump[3].Condition					:= VAR_RNS_SeqPermanent.SeqMode2.0;//DRAIN
	VAR_RNS_SEQ_Step.Step[22].Jump[3].Number					:= 50;
	VAR_RNS_SEQ_Step.Step[22].Jump[MAX_JUMP_CFG-3].Condition	:= VAR_RNS_ModeProduction AND VAR_RNS_SeqPermanent.SeqMode2.1 AND SFT.DataOut.MachineEmpty; //CONTROL
	VAR_RNS_SEQ_Step.Step[22].Jump[MAX_JUMP_CFG-3].Number		:= 70;
	VAR_RNS_SEQ_Step.Step[22].Jump[MAX_JUMP_CFG-1].Condition	:= FALSE; // leo VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[22].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[22].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqProdAbortRequest;
	VAR_RNS_SEQ_Step.Step[22].Jump[MAX_JUMP_CFG].Number			:= 101;
	//STEP 29 ********************************************************************************************************************
	(* PRODUCTION - Running: Recovery Skid High level *)
	VAR_RNS_SEQ_Step.Step[29].Config.TON_TimeSTART		:= VAR_RNS_TankLevelLow;
	VAR_RNS_SEQ_Step.Step[29].Config.TON_TimePr			:= 1;
	VAR_RNS_SEQ_Step.Step[29].Config.HMI_ID				:= 25;
	
	VAR_RNS_SEQ_Step.Step[29].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[29].Jump[0].Number					:= 13;//vrma
	VAR_RNS_SEQ_Step.Step[29].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[29].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[29].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqProdAbortRequest;
	VAR_RNS_SEQ_Step.Step[29].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 30 ********************************************************************************************************************
	(* PRODUCTION - Running: Air Only *)
	VAR_RNS_SEQ_Step.Step[30].Config.TON_TimeSTART		:= NOT VAR_RNS_FMDProduction;
	VAR_RNS_SEQ_Step.Step[30].Config.TON_TimePr			:= 1;
	VAR_RNS_SEQ_Step.Step[30].Config.HMI_ID				:= 26;
	
	VAR_RNS_SEQ_Step.Step[30].Jump[0].Condition					:= SFT.DataOut.MachineEmpty;
	VAR_RNS_SEQ_Step.Step[30].Jump[0].Number					:= 12;
	VAR_RNS_SEQ_Step.Step[30].Jump[1].Condition					:= FTB[201].OUT_LowLimit; //Air not ok
	VAR_RNS_SEQ_Step.Step[30].Jump[1].Number					:= 10;
	VAR_RNS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG-3].Condition	:= VAR_RNS_ModeProduction AND VAR_RNS_SeqPermanent.SeqMode1.5; //CONTROL
	VAR_RNS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG-3].Number		:= 70;
	VAR_RNS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG-2].Condition	:= VAR_RNS_ModeProduction AND VAR_RNS_SeqPermanent.SeqMode1.6 AND SFT.DataOut.MachineEmpty; //BYPASS
	VAR_RNS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG-2].Number		:= 90;
	VAR_RNS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqProdAbortRequest;
	VAR_RNS_SEQ_Step.Step[30].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 31 ********************************************************************************************************************
	(* PRODUCTION - Stopped *)
	VAR_RNS_SEQ_Step.Step[31].Config.TON_TimeSTART		:= NOT VAR_RNS_SeqProdStopAlarm;
	VAR_RNS_SEQ_Step.Step[31].Config.TON_TimePr			:= 3;
	VAR_RNS_SEQ_Step.Step[31].Config.HMI_ID				:= 8;
	
	VAR_RNS_SEQ_Step.Step[31].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END AND SFT.DataOut.MachineEmpty;			//Montanarini: tolto AND VAR_RNS_PBResetEp 
	VAR_RNS_SEQ_Step.Step[31].Jump[0].Number					:= 13;//vrma
	VAR_RNS_SEQ_Step.Step[31].Jump[1].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END AND NOT SFT.DataOut.MachineEmpty;		//Montanarini: tolto AND VAR_RNS_PBResetEp 
	VAR_RNS_SEQ_Step.Step[31].Jump[1].Number					:= 20;//vrma
	VAR_RNS_SEQ_Step.Step[31].Jump[MAX_JUMP_CFG-3].Condition	:= VAR_RNS_ModeProduction AND VAR_RNS_SeqPermanent.SeqMode1.5; //CONTROL
	VAR_RNS_SEQ_Step.Step[31].Jump[MAX_JUMP_CFG-3].Number		:= 70;
	VAR_RNS_SEQ_Step.Step[31].Jump[MAX_JUMP_CFG-2].Condition	:= VAR_RNS_ModeProduction AND VAR_RNS_SeqPermanent.SeqMode1.6 AND SFT.DataOut.MachineEmpty; //BYPASS
	VAR_RNS_SEQ_Step.Step[31].Jump[MAX_JUMP_CFG-2].Number		:= 90;
	VAR_RNS_SEQ_Step.Step[31].Jump[MAX_JUMP_CFG-1].Condition	:= FALSE;
	VAR_RNS_SEQ_Step.Step[31].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[31].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqProdAbortRequest;
	VAR_RNS_SEQ_Step.Step[31].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 32..39 ****************************************************************************************************************

	//STEP 40 ********************************************************************************************************************
	(* CIP - Wait Condition *)
	VAR_RNS_SEQ_Step.Step[40].Config.TON_TimeSTART		:= FSB[220].OUT; //[267].OUT_ClosedFiltered;//vrma
	VAR_RNS_SEQ_Step.Step[40].Config.TON_TimePr			:= 3;
	VAR_RNS_SEQ_Step.Step[40].Config.HMI_ID				:= 27;
	
	VAR_RNS_SEQ_Step.Step[40].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END AND TNK.DataOut.StartCipRinser AND MAU_DumCon.DataOut.InstallDone;
	VAR_RNS_SEQ_Step.Step[40].Jump[0].Number					:= 42;
	VAR_RNS_SEQ_Step.Step[40].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqCipStopRequest;
	VAR_RNS_SEQ_Step.Step[40].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[40].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqCipAbortRequest;
	VAR_RNS_SEQ_Step.Step[40].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 41 ********************************************************************************************************************
	(* CIP - Execution *)
	VAR_RNS_SEQ_Step.Step[41].Config.TON_TimeSTART		:= TRUE; //NOT (VAR_RNS_SeqPermanent.SeqMode1.1);//vrma
	VAR_RNS_SEQ_Step.Step[41].Config.TON_TimePr			:= 1;
	VAR_RNS_SEQ_Step.Step[41].Config.HMI_ID				:= 9;
	
	IF VAR_RNS_SEQ_Step.StepActual = 41 THEN												
		VAR_RNS_SeqPermanent.SeqMode1.7 := FALSE;
	END_IF
	 
	VAR_RNS_SEQ_Step.Step[41].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END AND TNK.DataOut.CipDrainMode;
	VAR_RNS_SEQ_Step.Step[41].Jump[0].Number					:= 47;
	VAR_RNS_SEQ_Step.Step[41].Jump[1].Condition					:= NOT TNK.DataOut.StartCipRinser;
	VAR_RNS_SEQ_Step.Step[41].Jump[1].Number					:= 40;
	VAR_RNS_SEQ_Step.Step[41].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqCipStopRequest;
	VAR_RNS_SEQ_Step.Step[41].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[41].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqCipAbortRequest;
	VAR_RNS_SEQ_Step.Step[41].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 42 ********************************************************************************************************************
	(* CIP - Wait Condition *)
	VAR_RNS_SEQ_Step.Step[42].Config.TON_TimeSTART		:= TRUE; //[267].OUT_ClosedFiltered;//vrma
	VAR_RNS_SEQ_Step.Step[42].Config.TON_TimePr			:= 1;
	VAR_RNS_SEQ_Step.Step[42].Config.HMI_ID				:= 27;
	
	IF VAR_RNS_SEQ_Step.StepActual = 42 THEN												
		VAR_RNS_SeqPermanent.SeqMode1.7 := TRUE;
	END_IF
	
	VAR_RNS_SEQ_Step.Step[42].Jump[0].Condition					:= MNM.DataOut.ConfigReqLoaded;
	VAR_RNS_SEQ_Step.Step[42].Jump[0].Number					:= 41;
	
	//STEP 42..46 ****************************************************************************************************************
		
	//STEP 47 ********************************************************************************************************************
	(* CIP - Drain *)
	VAR_RNS_SEQ_Step.Step[47].Config.TON_TimeSTART		:= LTB[202].OUT_ActValue < 3; 
	VAR_RNS_SEQ_Step.Step[47].Config.TON_TimePr			:= 10;
	VAR_RNS_SEQ_Step.Step[47].Config.HMI_ID				:= 52;
	
	VAR_RNS_SEQ_Step.Step[47].Jump[0].Condition						:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[47].Jump[0].Number						:= 48;
	VAR_RNS_SEQ_Step.Step[47].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_RNS_SeqCipStopRequest;
	VAR_RNS_SEQ_Step.Step[47].Jump[MAX_JUMP_CFG-1].Number			:= 101;
	VAR_RNS_SEQ_Step.Step[47].Jump[MAX_JUMP_CFG].Condition			:= VAR_RNS_SeqCipAbortRequest;
	VAR_RNS_SEQ_Step.Step[47].Jump[MAX_JUMP_CFG].Number				:= 101;

	//STEP 48 ********************************************************************************************************************
	(* CIP - End cycle *)
	VAR_RNS_SEQ_Step.Step[48].Config.TON_TimeSTART		:= TRUE;
	VAR_RNS_SEQ_Step.Step[48].Config.TON_TimePr			:= 5;
	VAR_RNS_SEQ_Step.Step[48].Config.HMI_ID				:= 29;
	
	VAR_RNS_SEQ_Step.Step[48].Jump[0].Condition						:= NOT TNK.DataOut.CipDrainMode;
	VAR_RNS_SEQ_Step.Step[48].Jump[0].Number						:= 0;//vrma
	VAR_RNS_SEQ_Step.Step[48].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_RNS_SeqCipStopRequest;
	VAR_RNS_SEQ_Step.Step[48].Jump[MAX_JUMP_CFG-1].Number			:= 101;
	VAR_RNS_SEQ_Step.Step[48].Jump[MAX_JUMP_CFG].Condition			:= VAR_RNS_SeqCipAbortRequest;
	VAR_RNS_SEQ_Step.Step[48].Jump[MAX_JUMP_CFG].Number				:= 101;
	
	//STEP 49 ********************************************************************************************************************
	(* CIP -  Stopped *)
	VAR_RNS_SEQ_Step.Step[49].Config.TON_TimeSTART		:= TRUE;
	VAR_RNS_SEQ_Step.Step[49].Config.TON_TimePr			:= 1;
	VAR_RNS_SEQ_Step.Step[49].Config.HMI_ID				:= 10;
	
	VAR_RNS_SEQ_Step.Step[49].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END AND VAR_RNS_PBResetEp AND NOT VAR_RNS_SeqCipStopAlarm;
	VAR_RNS_SEQ_Step.Step[49].Jump[0].Number					:= 40;
	VAR_RNS_SEQ_Step.Step[49].Jump[1].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END AND VAR_RNS_MemPBStop;
	VAR_RNS_SEQ_Step.Step[49].Jump[1].Number					:= 55;
	//	VAR_RNS_SEQ_Step.Step[49].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqCipStopRequest;
	//	VAR_RNS_SEQ_Step.Step[49].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	//	VAR_RNS_SEQ_Step.Step[49].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqCipAbortRequest;
	//	VAR_RNS_SEQ_Step.Step[49].Jump[MAX_JUMP_CFG].Number			:= 101;

	//STEP 50 ********************************************************************************************************************
	(* DRAINING - Tank and circuit emptying *)

	VAR_RNS_SEQ_Step.Step[50].Config.HMI_ID					:= 5;
	
	VAR_RNS_SEQ_Step.Step[50].Jump[0].Condition						:= LSB[210].OUT_OffDelayed OR LTB[202].OUT_ActValue < 3.0;//vrma
	VAR_RNS_SEQ_Step.Step[50].Jump[0].Number						:= 51;
	VAR_RNS_SEQ_Step.Step[50].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_RNS_SeqDrainStopRequest;
	VAR_RNS_SEQ_Step.Step[50].Jump[MAX_JUMP_CFG-1].Number			:= 101;
	VAR_RNS_SEQ_Step.Step[50].Jump[MAX_JUMP_CFG].Condition			:= VAR_RNS_SeqDrainAbortRequest;
	VAR_RNS_SEQ_Step.Step[50].Jump[MAX_JUMP_CFG].Number				:= 101;
	
	//STEP 51 ********************************************************************************************************************
	(* DRAINING - End drain cycle *)
	VAR_RNS_SEQ_Step.Step[51].Config.TON_TimeSTART		:= TNK.DataOut.Wait;//vrma
	VAR_RNS_SEQ_Step.Step[51].Config.TON_TimePr			:= 2;//vrma
	VAR_RNS_SEQ_Step.Step[51].Config.HMI_ID				:= 6;
	
	VAR_RNS_SEQ_Step.Step[51].Jump[0].Condition						:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[51].Jump[0].Number						:= 0;
	VAR_RNS_SEQ_Step.Step[51].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_RNS_SeqDrainStopRequest;
	VAR_RNS_SEQ_Step.Step[51].Jump[MAX_JUMP_CFG-1].Number			:= 101;
	VAR_RNS_SEQ_Step.Step[51].Jump[MAX_JUMP_CFG].Condition			:= VAR_RNS_SeqDrainAbortRequest;
	VAR_RNS_SEQ_Step.Step[51].Jump[MAX_JUMP_CFG].Number				:= 101;
	
	//STEP 52..53 ****************************************************************************************************************

	//STEP 54 ********************************************************************************************************************
	(* DRAINING - Stopped *)
	VAR_RNS_SEQ_Step.Step[54].Config.TON_TimeSTART		:= TRUE;
	VAR_RNS_SEQ_Step.Step[54].Config.TON_TimePr			:= 1;
	VAR_RNS_SEQ_Step.Step[54].Config.HMI_ID				:= 32;
	
	VAR_RNS_SEQ_Step.Step[54].Jump[0].Condition						:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[54].Jump[0].Number						:= 0; 
	VAR_RNS_SEQ_Step.Step[54].Jump[MAX_JUMP_CFG-1].Condition		:= FALSE;
	VAR_RNS_SEQ_Step.Step[54].Jump[MAX_JUMP_CFG-1].Number			:= 101;
	VAR_RNS_SEQ_Step.Step[54].Jump[MAX_JUMP_CFG].Condition			:= VAR_RNS_SeqDrainAbortRequest;
	VAR_RNS_SEQ_Step.Step[54].Jump[MAX_JUMP_CFG].Number				:= 101;
	
	//STEP 55 ********************************************************************************************************************
	(* DRAINING - Circuit emptying during COP *)
	VAR_RNS_SEQ_Step.Step[55].Config.TON_TimeSTART		:= NOT COP.DataOut.RcpActive;
	VAR_RNS_SEQ_Step.Step[55].Config.TON_TimePr			:= 10;
	VAR_RNS_SEQ_Step.Step[55].Config.HMI_ID				:= 33;
	
	VAR_RNS_SEQ_Step.Step[55].Jump[0].Condition						:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[55].Jump[0].Number						:= 0; 
	VAR_RNS_SEQ_Step.Step[55].Jump[MAX_JUMP_CFG-2].Condition		:= VAR_RNS_ModeDrain AND VAR_RNS_SeqPermanent.SeqMode1.6 AND SFT.DataOut.MachineEmpty; //BYPASS
	VAR_RNS_SEQ_Step.Step[55].Jump[MAX_JUMP_CFG-2].Number			:= 90;
	VAR_RNS_SEQ_Step.Step[55].Jump[MAX_JUMP_CFG-1].Condition		:= VAR_RNS_SeqDrainStopRequest;
	VAR_RNS_SEQ_Step.Step[55].Jump[MAX_JUMP_CFG-1].Number			:= 101;
	VAR_RNS_SEQ_Step.Step[55].Jump[MAX_JUMP_CFG].Condition			:= VAR_RNS_SeqDrainAbortRequest;
	VAR_RNS_SEQ_Step.Step[55].Jump[MAX_JUMP_CFG].Number				:= 101;
	
	//STEP 56..69 *****************************************************************************************************************
	
	//STEP 70 ********************************************************************************************************************
	(* CONTROL - Check Selection and Speed *)
	VAR_RNS_SEQ_Step.Step[70].Config.TON_TimeSTART			:= 	MNM.DataOut.RnsSpeedReqReached AND SFT.DataOut.MachineEmpty;
	VAR_RNS_SEQ_Step.Step[70].Config.TON_TimePr				:= 1;
	VAR_RNS_SEQ_Step.Step[70].Config.TO_TimePr				:= 3;
	VAR_RNS_SEQ_Step.Step[70].Config.HMI_ID					:= 34;

	VAR_RNS_SEQ_Step.Step[70].Jump[1].Condition					:= VAR_RNS_SeqPermanent.SeqMode2.1 AND VAR_RNS_ControlInsercionRequest;
	VAR_RNS_SEQ_Step.Step[70].Jump[1].Number					:= 71;
	VAR_RNS_SEQ_Step.Step[70].Jump[3].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END AND VAR_RNS_ControlInsercionRequest;
	VAR_RNS_SEQ_Step.Step[70].Jump[3].Number					:= 71;
	VAR_RNS_SEQ_Step.Step[70].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqControlStopRequest;
	VAR_RNS_SEQ_Step.Step[70].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[70].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqControlAbortRequest;
	VAR_RNS_SEQ_Step.Step[70].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 71 ********************************************************************************************************************
	(* CONTROL - Insercion Device *)
	VAR_RNS_SEQ_Step.Step[71].Config.TON_TimeSTART			:= GNS.DataOut.RnsCtrlDevInserted;
	VAR_RNS_SEQ_Step.Step[71].Config.TON_TimePr				:= 10;
	VAR_RNS_SEQ_Step.Step[71].Config.TO_TimePr				:= 30;
	VAR_RNS_SEQ_Step.Step[71].Config.HMI_ID					:= 35;
	
	VAR_RNS_SEQ_Step.Step[71].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[71].Jump[0].Number					:= 74;
	VAR_RNS_SEQ_Step.Step[71].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqControlStopRequest;
	VAR_RNS_SEQ_Step.Step[71].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[71].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqControlAbortRequest;
	VAR_RNS_SEQ_Step.Step[71].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 72 ********************************************************************************************************************
	(* CONTROL - Air Startup Insertion *)
	VAR_RNS_SEQ_Step.Step[72].Config.TON_TimeSTART		:= FTB[201].OUT_SpReached;
	VAR_RNS_SEQ_Step.Step[72].Config.TON_TimePr			:= 10;
	VAR_RNS_SEQ_Step.Step[72].Config.TO_TimePr			:= 300;
	VAR_RNS_SEQ_Step.Step[72].Config.HMI_ID				:= 36;
	
	VAR_RNS_SEQ_Step.Step[72].Jump[0].Condition					:= VAR_RNS_ModeControl AND VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[72].Jump[0].Number					:= 73;
	VAR_RNS_SEQ_Step.Step[72].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqControlStopRequest;
	VAR_RNS_SEQ_Step.Step[72].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[72].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqControlAbortRequest;
	VAR_RNS_SEQ_Step.Step[72].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 73 ********************************************************************************************************************
	(* CONTROL - Insercion Air *)
	VAR_RNS_SEQ_Step.Step[73].Config.Laps_Counter_Enable	:= TRUE;
	VAR_RNS_SEQ_Step.Step[73].Config.Laps_Request			:= REAL_TO_UINT(HMI_PAM_1._086);
	VAR_RNS_SEQ_Step.Step[73].Config.T_TimeSTART			:= FALSE;
	VAR_RNS_SEQ_Step.Step[73].Config.T_TimeSTOP				:= FALSE;
	VAR_RNS_SEQ_Step.Step[73].Config.T_TimeRESET			:= FALSE;
	VAR_RNS_SEQ_Step.Step[73].Config.T_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[73].Config.TON_TimeSTART			:= FALSE;
	VAR_RNS_SEQ_Step.Step[73].Config.TON_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[73].Config.TO_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[73].Config.Cycle_RESET	        := TRUE;
	VAR_RNS_SEQ_Step.Step[73].Config.HMI_ID					:= 37;
	
	VAR_RNS_SEQ_Step.Step[73].Jump[0].Condition					:= VAR_RNS_ModeControl AND VAR_RNS_SEQ_Step.Laps_Done AND VAR_RNS_WaterTreatment;
	VAR_RNS_SEQ_Step.Step[73].Jump[0].Number					:= 74;
	VAR_RNS_SEQ_Step.Step[73].Jump[1].Condition					:= VAR_RNS_ModeControl AND VAR_RNS_SEQ_Step.Laps_Done AND NOT VAR_RNS_WaterTreatment;
	VAR_RNS_SEQ_Step.Step[73].Jump[1].Number					:= 81;
	VAR_RNS_SEQ_Step.Step[73].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqControlStopRequest;
	VAR_RNS_SEQ_Step.Step[73].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[73].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqControlAbortRequest;
	VAR_RNS_SEQ_Step.Step[73].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 74 ********************************************************************************************************************
	(* CONTROL - Water Startup Insertion *)
	VAR_RNS_SEQ_Step.Step[74].Config.TON_TimeSTART		:= FSB[220].OUT_OnDelayed AND FTB[202].OUT_SpReached;
	VAR_RNS_SEQ_Step.Step[74].Config.TON_TimePr			:= 10;
	VAR_RNS_SEQ_Step.Step[74].Config.TO_TimePr			:= 300;
	VAR_RNS_SEQ_Step.Step[74].Config.HMI_ID				:= 38;
	
	VAR_RNS_SEQ_Step.Step[74].Jump[0].Condition					:= VAR_RNS_ModeControl AND VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[74].Jump[0].Number					:= 75;
	VAR_RNS_SEQ_Step.Step[74].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqControlStopRequest;
	VAR_RNS_SEQ_Step.Step[74].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[74].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqControlAbortRequest;
	VAR_RNS_SEQ_Step.Step[74].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 75 ********************************************************************************************************************
	(* CONTROL - Insercion Water *)
	VAR_RNS_SEQ_Step.Step[75].Config.Laps_Counter_Enable	:= TRUE;
	VAR_RNS_SEQ_Step.Step[75].Config.Laps_Request			:= REAL_TO_UINT(HMI_PAM_1._087);
	VAR_RNS_SEQ_Step.Step[75].Config.T_TimeSTART			:= FALSE;
	VAR_RNS_SEQ_Step.Step[75].Config.T_TimeSTOP				:= FALSE;
	VAR_RNS_SEQ_Step.Step[75].Config.T_TimeRESET			:= FALSE;
	VAR_RNS_SEQ_Step.Step[75].Config.T_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[75].Config.TON_TimeSTART			:= FALSE;
	VAR_RNS_SEQ_Step.Step[75].Config.TON_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[75].Config.TO_TimePr				:= 0;
//	VAR_RNS_SEQ_Step.Step[75].Config.Cycle_RESET	        := TRUE;
	VAR_RNS_SEQ_Step.Step[75].Config.HMI_ID					:= 39;
	
	VAR_RNS_SEQ_Step.Step[75].Jump[0].Condition					:= VAR_RNS_ModeControl AND VAR_RNS_SEQ_Step.Laps_Done AND NOT VAR_RNS_AirTreatment;
	VAR_RNS_SEQ_Step.Step[75].Jump[0].Number					:= 81;
	VAR_RNS_SEQ_Step.Step[75].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqControlStopRequest;
	VAR_RNS_SEQ_Step.Step[75].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[75].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqControlAbortRequest;
	VAR_RNS_SEQ_Step.Step[75].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 78 ********************************************************************************************************************
	(* CONTROL - Water Startup Continous *)
	VAR_RNS_SEQ_Step.Step[78].Config.TON_TimeSTART		:= FSB[220].OUT_OnDelayed AND FTB[202].OUT_SpReached AND 
	(NOT CFG_Par.Rinser.ExternalRecoverySkid OR (CFG_Par.Rinser.ExternalRecoverySkid AND WttFlr.ProductAvailable));
	VAR_RNS_SEQ_Step.Step[78].Config.TON_TimePr			:= 10;
	VAR_RNS_SEQ_Step.Step[78].Config.TO_TimePr			:= 300;
	VAR_RNS_SEQ_Step.Step[78].Config.HMI_ID				:= 42;
	
	VAR_RNS_SEQ_Step.Step[78].Jump[0].Condition					:= VAR_RNS_ModeControl AND VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[78].Jump[0].Number					:= 79;
	VAR_RNS_SEQ_Step.Step[78].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqControlStopRequest;
	VAR_RNS_SEQ_Step.Step[78].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[78].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqControlAbortRequest;
	VAR_RNS_SEQ_Step.Step[78].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 79 ********************************************************************************************************************
	(* CONTROL - Continous Water *)
	VAR_RNS_SEQ_Step.Step[79].Config.Laps_Counter_Enable	:= TRUE;
	VAR_RNS_SEQ_Step.Step[79].Config.Laps_Request			:= REAL_TO_UINT(HMI_PAM_1._089);
	VAR_RNS_SEQ_Step.Step[79].Config.T_TimeSTART			:= FALSE;
	VAR_RNS_SEQ_Step.Step[79].Config.T_TimeSTOP				:= FALSE;
	VAR_RNS_SEQ_Step.Step[79].Config.T_TimeRESET			:= FALSE;
	VAR_RNS_SEQ_Step.Step[79].Config.T_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[79].Config.TON_TimeSTART			:= FALSE;
	VAR_RNS_SEQ_Step.Step[79].Config.TON_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[79].Config.TO_TimePr				:= 0;
	VAR_RNS_SEQ_Step.Step[79].Config.Cycle_RESET	        := TRUE;
	VAR_RNS_SEQ_Step.Step[79].Config.HMI_ID					:= 43;
	
	VAR_RNS_SEQ_Step.Step[79].Jump[0].Condition					:= VAR_RNS_ModeControl AND VAR_RNS_SEQ_Step.Laps_Done;
	VAR_RNS_SEQ_Step.Step[79].Jump[0].Number					:= 81;
	VAR_RNS_SEQ_Step.Step[79].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqControlStopRequest;
	VAR_RNS_SEQ_Step.Step[79].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[79].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqControlAbortRequest;
	VAR_RNS_SEQ_Step.Step[79].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 80 ********************************************************************************************************************
	(* CONTROL - Stopped *)
	VAR_RNS_SEQ_Step.Step[80].Config.TON_TimeSTART		:= NOT VAR_RNS_SeqControlStopAlarm;
	VAR_RNS_SEQ_Step.Step[80].Config.TON_TimePr			:= 2;
	VAR_RNS_SEQ_Step.Step[80].Config.TO_TimePr			:= 3;
	VAR_RNS_SEQ_Step.Step[80].Config.HMI_ID				:= 44;
	
	VAR_RNS_SEQ_Step.Step[80].Jump[0].Condition					:= VAR_RNS_ModeControl AND VAR_RNS_SEQ_Step.TON_Time_END AND VAR_RNS_PBResetEp;
	VAR_RNS_SEQ_Step.Step[80].Jump[0].Number					:= 0;
	VAR_RNS_SEQ_Step.Step[80].Jump[MAX_JUMP_CFG-1].Condition	:= FALSE;
	VAR_RNS_SEQ_Step.Step[80].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[80].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqControlAbortRequest;
	VAR_RNS_SEQ_Step.Step[80].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 81 ********************************************************************************************************************
	(* CONTROL - Done *)	
	VAR_RNS_SEQ_Step.Step[81].Config.TON_TimeSTART		:= TRUE;
	VAR_RNS_SEQ_Step.Step[81].Config.TON_TimePr			:= 5;
	VAR_RNS_SEQ_Step.Step[81].Config.TO_TimePr			:= 100;
	VAR_RNS_SEQ_Step.Step[81].Config.HMI_ID				:= 45;
	
	VAR_RNS_SEQ_Step.Step[81].Jump[0].Condition					:= NOT VAR_RNS_SeqPermanent.SeqMode1.0 AND VAR_RNS_SEQ_Step.TON_Time_END;//vrma
	VAR_RNS_SEQ_Step.Step[81].Jump[0].Number					:= 0;
	VAR_RNS_SEQ_Step.Step[81].Jump[1].Condition					:= VAR_RNS_SeqPermanent.SeqMode1.0 AND VAR_RNS_SEQ_Step.TON_Time_END;//vrma
	VAR_RNS_SEQ_Step.Step[81].Jump[1].Number					:= 13;
	VAR_RNS_SEQ_Step.Step[81].Jump[MAX_JUMP_CFG-1].Condition	:= VAR_RNS_SeqControlStopRequest;
	VAR_RNS_SEQ_Step.Step[81].Jump[MAX_JUMP_CFG-1].Number		:= 101;
	VAR_RNS_SEQ_Step.Step[81].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqControlAbortRequest;
	VAR_RNS_SEQ_Step.Step[81].Jump[MAX_JUMP_CFG].Number			:= 101;
	//STEP 82..89 ****************************************************************************************************************
	
	//STEP 90 ********************************************************************************************************************
	(* BYPASSED - Check Request *)
	VAR_RNS_SEQ_Step.Step[90].Config.TON_TimeSTART		:= NOT MNM.DataOut.MachineRunning AND SFT.DataOut.MachineEmpty;
	VAR_RNS_SEQ_Step.Step[90].Config.TON_TimePr			:= 1;
	VAR_RNS_SEQ_Step.Step[90].Config.HMI_ID				:= 46;
	
	VAR_RNS_SEQ_Step.Step[90].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END AND VAR_RNS_BypassRequest;
	VAR_RNS_SEQ_Step.Step[90].Jump[0].Number					:= 91;
	VAR_RNS_SEQ_Step.Step[90].Jump[1].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END AND NOT VAR_RNS_BypassRequest;
	VAR_RNS_SEQ_Step.Step[90].Jump[1].Number					:= 93;
	VAR_RNS_SEQ_Step.Step[90].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqBypassStopAlarm OR VAR_RNS_SeqBypassAbortRequest;
	VAR_RNS_SEQ_Step.Step[90].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 91 ********************************************************************************************************************
	(* BYPASSED - Rinser Bypassed *)
	VAR_RNS_SEQ_Step.Step[91].Config.TON_TimeSTART		:= RNS.DataOut.ByPassed;
	VAR_RNS_SEQ_Step.Step[91].Config.TON_TimePr			:= 1;
	VAR_RNS_SEQ_Step.Step[91].Config.TO_TimePr			:= 2;
	VAR_RNS_SEQ_Step.Step[91].Config.HMI_ID				:= 47;
	
	VAR_RNS_SEQ_Step.Step[91].Jump[0].Condition		:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[91].Jump[0].Number		:= 0;
	VAR_RNS_SEQ_Step.Step[91].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqBypassStopAlarm OR VAR_RNS_SeqBypassAbortRequest;
	VAR_RNS_SEQ_Step.Step[91].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 92 ********************************************************************************************************************
	(* BYPASSED - Error *)
	//Spare
	
	//STEP 93 ********************************************************************************************************************
	(* BYPASSED - Check Request *)
	VAR_RNS_SEQ_Step.Step[93].Config.TON_TimeSTART		:= NOT MNM.DataOut.MachineRunning AND SFT.DataOut.MachineEmpty;
	VAR_RNS_SEQ_Step.Step[93].Config.TON_TimePr			:= 1;
	VAR_RNS_SEQ_Step.Step[93].Config.HMI_ID				:= 46;
	
	VAR_RNS_SEQ_Step.Step[93].Jump[0].Condition		:= VAR_RNS_SEQ_Step.TON_Time_END AND NOT VAR_RNS_BypassRequest;
	VAR_RNS_SEQ_Step.Step[93].Jump[0].Number		:= 94;
	VAR_RNS_SEQ_Step.Step[93].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqBypassStopAlarm OR VAR_RNS_SeqBypassAbortRequest;
	VAR_RNS_SEQ_Step.Step[93].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 94 ********************************************************************************************************************
	(* BYPASSED - Rinser Inserted  *)
	VAR_RNS_SEQ_Step.Step[94].Config.TON_TimeSTART		:= NOT RNS.DataOut.ByPassed;
	VAR_RNS_SEQ_Step.Step[94].Config.TON_TimePr			:= 1;
	VAR_RNS_SEQ_Step.Step[94].Config.TO_TimePr			:= 2;
	VAR_RNS_SEQ_Step.Step[94].Config.HMI_ID				:= 49;
	
	VAR_RNS_SEQ_Step.Step[94].Jump[0].Condition					:= VAR_RNS_SEQ_Step.TON_Time_END;
	VAR_RNS_SEQ_Step.Step[94].Jump[0].Number					:= 0;
	VAR_RNS_SEQ_Step.Step[94].Jump[MAX_JUMP_CFG].Condition		:= VAR_RNS_SeqBypassStopAlarm OR VAR_RNS_SeqBypassAbortRequest;
	VAR_RNS_SEQ_Step.Step[94].Jump[MAX_JUMP_CFG].Number			:= 101;
	
	//STEP 95..100 *****************************************************************************************************************

	//STEP 101 ********************************************************************************************************************
	(* PRODUCTION/CIP/DRAINING - Stopping *)
	VAR_RNS_SEQ_Step.Step[101].Config.TON_TimeSTART	:= TRUE;
	VAR_RNS_SEQ_Step.Step[101].Config.TON_TimePr	:= 1;
	
	IF VAR_RNS_ModeProduction THEN
		VAR_RNS_SEQ_Step.Step[101].Config.HMI_ID	:= 7;
	ELSIF VAR_RNS_ModeCip	THEN
		VAR_RNS_SEQ_Step.Step[101].Config.HMI_ID	:= 28;
	ELSE	
		VAR_RNS_SEQ_Step.Step[101].Config.HMI_ID	:= 31;
	END_IF
	
	IF FB_RNS_SEQ.OUT_StepActual = 101 THEN
		VAR_RNS_SeqPermanent.SeqBackupStep 	:= FB_RNS_SEQ.OUT_StepPrevious;
		HMI_RNS_PB[PB_CmdPause].LampON		:= FALSE;
	END_IF
	//vrma
	VAR_RNS_SEQ_Step.Step[101].Jump[0].Condition	:= VAR_RNS_SEQ_Step.TON_Time_END AND AID.DataOut.Reset AND (VAR_RNS_SeqProdAbortRequest OR VAR_RNS_SeqDrainAbortRequest OR VAR_RNS_SeqControlAbortRequest OR VAR_RNS_SeqCipAbortRequest);
	VAR_RNS_SEQ_Step.Step[101].Jump[0].Number		:= 0;
	VAR_RNS_SEQ_Step.Step[101].Jump[1].Condition	:= VAR_RNS_SEQ_Step.TON_Time_END AND AID.DataOut.Reset AND VAR_RNS_SeqProdStopRequest;
	VAR_RNS_SEQ_Step.Step[101].Jump[1].Number		:= 31;
	VAR_RNS_SEQ_Step.Step[101].Jump[2].Condition	:= VAR_RNS_SEQ_Step.TON_Time_END AND AID.DataOut.Reset AND TNK.DataOut.CipMode AND (NOT VAR_RNS_SeqCipStopRequest AND VAR_RNS_ModeCip OR VAR_RNS_SeqCipAbortRequest);
	VAR_RNS_SEQ_Step.Step[101].Jump[2].Number		:= 40;//vrma
	VAR_RNS_SEQ_Step.Step[101].Jump[3].Condition	:= VAR_RNS_SEQ_Step.TON_Time_END AND AID.DataOut.Reset AND VAR_RNS_SeqDrainStopRequest;
	VAR_RNS_SEQ_Step.Step[101].Jump[3].Number		:= 54;
	VAR_RNS_SEQ_Step.Step[101].Jump[4].Condition	:= VAR_RNS_SEQ_Step.TON_Time_END AND AID.DataOut.Reset AND VAR_RNS_ModeCop;
	VAR_RNS_SEQ_Step.Step[101].Jump[4].Number		:= 54;
	VAR_RNS_SEQ_Step.Step[101].Jump[5].Condition	:= VAR_RNS_SEQ_Step.TON_Time_END AND AID.DataOut.Reset AND VAR_RNS_ModeControl;
	VAR_RNS_SEQ_Step.Step[101].Jump[5].Number		:= 80;
	VAR_RNS_SEQ_Step.Step[101].Jump[6].Condition	:= VAR_RNS_SEQ_Step.TON_Time_END AND AID.DataOut.Reset AND VAR_RNS_ModeBypass;
	VAR_RNS_SEQ_Step.Step[101].Jump[6].Number		:= 90;
	
	//*******************************************************************************************************************************
	//*******************************************************************************************************************************
	//*******************************************************************************************************************************
	
	FOR VAR_index := 0 TO MAX_JUMP_CFG DO
		IF VAR_RNS_SEQ_Step.Step[LIMIT(0, VAR_RNS_SEQ_Step.StepActual, MAX_STEP_CFG)].Jump[VAR_index].Condition THEN
			VAR_RNS_SeqPermanent.SeqActualStep 	:= VAR_RNS_SEQ_Step.Step[LIMIT(0, VAR_RNS_SEQ_Step.StepActual, MAX_STEP_CFG)].Jump[VAR_index].Number;
		END_IF	
	END_FOR

	FB_RNS_SEQ(
	IN_Step 				:= VAR_RNS_SeqPermanent.SeqActualStep,
	IN_StepConfig			:= VAR_RNS_SEQ_Step.Step[LIMIT(0, VAR_RNS_SeqPermanent.SeqActualStep, MAX_STEP_CFG)].Config,
	IN_T_TimeClock			:= AID.DataOut.Blink1Hz,
	IN_Pause_Request 		:= VAR_RNS_MemSSPause,
	IN_FillingValveNr 		:= HMI_PAC_1._200, 
	IN_StepCounter 			:= SFT.DataOut.RinserFillerSteps,
	CyclesCounter 			:= VAR_RNS_SeqCyclesCounter,
	);
	
	VAR_RNS_SEQ_Step.StepActual		:= FB_RNS_SEQ.OUT_StepActual;
	VAR_RNS_SeqActualStep			:= VAR_RNS_SEQ_Step.StepActual;

	VAR_RNS_SEQ_Step.Laps_Done 		:= FB_RNS_SEQ.OUT_Laps_Done;
	VAR_RNS_SEQ_Step.Cycles_Done    := FB_RNS_SEQ.OUT_Cycles_Done;
	VAR_RNS_SEQ_Step.T_Time_END 	:= FB_RNS_SEQ.OUT_T_Time_END;
	VAR_RNS_SEQ_Step.TO_Time_END 	:= FB_RNS_SEQ.OUT_TO_Time_END;
	VAR_RNS_SEQ_Step.TON_Time_END 	:= FB_RNS_SEQ.OUT_TON_Time_END;
	
	IF VAR_RNS_SeqPermanent.SeqActualStep = 0 THEN
		VAR_RNS_SeqPermanent.SeqMode1 	:= 0;
		VAR_RNS_SeqPermanent.SeqMode2.0 := FALSE;
		VAR_RNS_SeqPermanent.SeqMode2.1 := FALSE;
		VAR_RNS_SeqPermanent.SeqMode2.4 := FALSE;
	END_IF	
	
END_ACTION
