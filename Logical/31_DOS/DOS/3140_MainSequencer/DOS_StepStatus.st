ACTION DOS_StepStatus:
	//MODE
	VAR_DOS_ModeWait					:= VAR_DOS_SeqPermanent.SeqActualStep = 0;
	VAR_DOS_ModeProduction				:= VAR_DOS_SeqPermanent.SeqMode1.0;
	VAR_DOS_ModeCip						:= VAR_DOS_SeqPermanent.SeqMode1.1;
	VAR_DOS_ModeRinse					:= VAR_DOS_SeqPermanent.SeqMode1.2;
	VAR_DOS_ModeDrain					:= VAR_DOS_SeqPermanent.SeqMode1.3;
	VAR_DOS_ModeCop						:= VAR_DOS_SeqPermanent.SeqMode1.4;
	VAR_DOS_ModePositioning				:= VAR_DOS_SeqPermanent.SeqMode1.5;
	VAR_DOS_ModeBypass					:= VAR_DOS_SeqPermanent.SeqMode1.6;
	VAR_DOS_ModePositionRequest			:= VAR_DOS_SeqPermanent.SeqMode1.7;
	VAR_DOS_ModeProductionExcluded		:= VAR_DOS_SeqPermanent.SeqMode1.8;
	VAR_DOS_MemProdDrain				:= VAR_DOS_SeqPermanent.SeqMode2.0; 
	VAR_DOS_ModeWaitOperator			:= FALSE;
	
	VAR_DOS_MemDoserByPassed			:= VAR_DOS_SeqPermanent.SeqMode2.2;
	VAR_DOS_MemDoserIncluded			:= VAR_DOS_SeqPermanent.SeqMode2.3;
	
	VAR_DOS_MemDoserAxisOn				:= VAR_DOS_SeqPermanent.SeqMode2.4;
	VAR_DOS_MemDoserAxisOff				:= VAR_DOS_SeqPermanent.SeqMode2.5;
	VAR_DOS_MemFillerAxisOffReq			:= VAR_DOS_SeqPermanent.SeqMode2.6;
	
	//STEP PRODUCTION
	VAR_DOS_StepProdHeating				:= VAR_DOS_SEQ_Step.StepActual > 6 AND VAR_DOS_SeqActualStep < 15;
	VAR_DOS_StepProdProducing			:= VAR_DOS_SEQ_Step.StepActual = 35 OR VAR_DOS_SEQ_Step.StepActual = 37 OR VAR_DOS_SEQ_Step.StepActual = 38 OR
											VAR_DOS_SEQ_Step.StepActual = 22 OR VAR_DOS_SEQ_Step.StepActual = 23 OR VAR_DOS_SEQ_Step.StepActual = 30;
	VAR_DOS_StepProdLowLevel			:= VAR_DOS_SEQ_Step.StepActual = 37;
	VAR_DOS_StepProdRecovery			:= VAR_DOS_SEQ_Step.StepActual = 40;
	VAR_DOS_StepProdStopped				:= VAR_DOS_SEQ_Step.StepActual = 55;
	VAR_DOS_StepProdEndProduction		:= VAR_DOS_SEQ_Step.StepActual >= 46 AND VAR_DOS_SeqActualStep <= 52;
	VAR_DOS_StepProdAborted				:= VAR_DOS_SEQ_Step.StepActual = 0;		 
	
	//STEP CIP
	VAR_DOS_StepCipCleaning				:= VAR_DOS_SEQ_Step.StepActual > 73 AND VAR_DOS_SeqActualStep <=79;		//<	83
	VAR_DOS_StepCipDraining				:= VAR_DOS_SEQ_Step.StepActual >= 86 AND VAR_DOS_SeqActualStep <= 87;			
	VAR_DOS_StepCipRecovery				:= VAR_DOS_SEQ_Step.StepActual = 82;			
	VAR_DOS_StepCipStopped				:= VAR_DOS_SEQ_Step.StepActual = 95;
	VAR_DOS_StepCipAborted				:= VAR_DOS_SEQ_Step.StepActual = 96 OR VAR_DOS_SEQ_Step.StepActual = 0;		
	VAR_DOS_StepCipEnded				:= VAR_DOS_SEQ_Step.StepActual = 88;
	VAR_DOS_StepCipFillerStartEnable	:= VAR_DOS_SEQ_Step.StepActual = 60 OR VAR_DOS_SeqActualStep = 61; //Segnale per SKID 
	
	//STEP RINSE
	VAR_DOS_StepRinseReq				:=  VAR_DOS_SEQ_Step.StepActual >= 101 AND VAR_DOS_SeqActualStep <=106;
	VAR_DOS_StepRinseInExecution		:=  VAR_DOS_SEQ_Step.StepActual >= 101 AND VAR_DOS_SeqActualStep <=109;
	VAR_DOS_StepRinseAborted			:= VAR_DOS_SEQ_Step.StepActual = 0;
	VAR_DOS_StepRinseStopped			:= VAR_DOS_SEQ_Step.StepActual = 115;
	
	//STEP DRAIN
	VAR_DOS_StepDrainStopped			:= VAR_DOS_SEQ_Step.StepActual = 135;		
	VAR_DOS_StepDrainAborted			:= VAR_DOS_SEQ_Step.StepActual = 0;	
	
	//STEP COP
	VAR_DOS_StepCopRunning				:= VAR_DOS_SEQ_Step.StepActual = 90;
	
	//STEP BYPASS
	VAR_DOS_StepCamPositioning				:= VAR_DOS_SeqActualStep >= 150 AND VAR_DOS_SeqActualStep <= 155;
	VAR_DOS_StepCamPosRequest				:= VAR_DOS_SeqActualStep = 151;
	VAR_DOS_StepCamPosInProgress			:= VAR_DOS_SeqActualStep >= 151 AND VAR_DOS_SeqActualStep <= 154;
	VAR_DOS_StepBypassAborted				:= VAR_DOS_SeqActualStep = 0;

	//STEP MOTION
	VAR_DOS_StepMotorization				:= VAR_DOS_SeqActualStep >= 161 AND VAR_DOS_SeqActualStep <= 163;
END_ACTION
