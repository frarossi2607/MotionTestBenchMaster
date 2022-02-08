ACTION RNS_StepStatus:
	//MODE
	VAR_RNS_ModeWait					:= VAR_RNS_SeqPermanent.SeqActualStep = 0;
	VAR_RNS_ModeProduction				:= VAR_RNS_SeqPermanent.SeqMode1.0;
	VAR_RNS_ModeCip						:= VAR_RNS_SeqPermanent.SeqMode1.1;
	VAR_RNS_ModeDrain					:= VAR_RNS_SeqPermanent.SeqMode1.3;
	VAR_RNS_ModeCop						:= VAR_RNS_SeqPermanent.SeqMode1.4;
	VAR_RNS_ModeControl					:= VAR_RNS_SeqPermanent.SeqMode1.5 OR VAR_RNS_SeqPermanent.SeqMode2.1;//V4.A.A.1.7.0
	VAR_RNS_ModeBypass					:= VAR_RNS_SeqPermanent.SeqMode1.6;//V4.A.A.1.7.0
	VAR_RNS_ModeDeEnergization 			:= VAR_RNS_SeqPermanent.SeqMode1.14;
	VAR_RNS_ModeFiltersSterilization 	:= VAR_RNS_SeqPermanent.SeqMode1.15;
	
	VAR_RNS_MemProdDrain				:= VAR_RNS_SeqPermanent.SeqMode2.0;//V4.A.A.1.7.0
	VAR_RNS_MemProdControl				:= VAR_RNS_SeqPermanent.SeqMode2.1;//V4.A.A.1.7.0
	VAR_RNS_MemRinserByPassed			:= VAR_RNS_SeqPermanent.SeqMode2.2;//V4.A.A.1.7.0
	VAR_RNS_MemRinserInserted			:= VAR_RNS_SeqPermanent.SeqMode2.3;//V4.A.A.1.7.0
	VAR_RNS_ModeWaitOperator			:= FALSE;
	
	//STEP PRODUCTION
	VAR_RNS_StepProdStartUp				:= VAR_RNS_SeqActualStep >= 10 AND VAR_RNS_SeqActualStep <= 19;
	//VAR_RNS_StepProdStartUpLampCtrl	:= VAR_RNS_SeqActualStep >= 10 AND VAR_RNS_SeqActualStep <= 12;
	//VAR_RNS_StepProdStartUpLampFault	:= VAR_RNS_SeqActualStep = 13;
	VAR_RNS_StepProdProducing			:= VAR_RNS_SeqActualStep >= 20 AND VAR_RNS_SeqActualStep <= 29;
	//VAR_RNS_StepProdSprayRequest		:= VAR_RNS_SeqActualStep >= 22 AND VAR_RNS_SeqActualStep <= 28;
	VAR_RNS_StepProdStopped				:= VAR_RNS_SeqActualStep = 31;
	VAR_RNS_StepProdAborted				:= VAR_RNS_SeqActualStep = 0;
	
	//STEP CIP
	VAR_RNS_StepCipCleaning			:= VAR_RNS_SeqActualStep = 41;
	VAR_RNS_StepCipEnded			:= VAR_RNS_SeqActualStep = 48;
	
	//STEP DRAIN
	VAR_RNS_StepDrainStopped			:= VAR_RNS_SeqActualStep = 54;
	VAR_RNS_StepDrainAborted			:= VAR_RNS_SeqActualStep = 0;
	
	//STEP CONTROL
	VAR_RNS_StepControl					:= VAR_RNS_SeqActualStep >= 70 AND VAR_RNS_SeqActualStep <= 80;//V4.A.A.1.7.0
	VAR_RNS_StepControlDone				:= VAR_RNS_SeqActualStep = 81;
	VAR_RNS_StepControlStopped			:= VAR_RNS_SeqActualStep = 80;
	VAR_RNS_StepControlAborted			:= VAR_RNS_SeqActualStep = 0 OR VAR_RNS_SeqActualStep = 80;
	
	IF VAR_RNS_StepControlDone THEN
		VAR_RNS_StepCtrlCipDone := TRUE;
	END_IF
	
	IF VAR_RNS_SeqActualStep = 55 OR VAR_RNS_SeqActualStep = 48 OR VAR_RNS_SeqActualStep = 0 THEN
		VAR_RNS_StepCtrlCipDone := FALSE;
	END_IF	
	
	//STEP CIP
	VAR_RNS_StepCipCleaning		:= VAR_RNS_SeqActualStep = 41;
	VAR_RNS_StepCipStopped		:= VAR_RNS_SeqActualStep = 0 OR VAR_RNS_SeqActualStep = 49 OR VAR_RNS_SeqActualStep = 101;//vrma
	VAR_RNS_StepCipAborted		:= VAR_RNS_SeqActualStep = 0 OR VAR_RNS_SeqActualStep = 49;
	
	//STEP BYPASS
	VAR_RNS_StepByPassed					:= VAR_RNS_SeqActualStep >= 90 AND VAR_RNS_SeqActualStep <= 95;//V4.A.A.1.7.0
	VAR_RNS_StepBypassAborted				:= VAR_RNS_SeqActualStep = 0;

	IF FB_RNS_SEQ.OUT_StepActual = 91 THEN
		VAR_RNS_BypassCommand := TRUE;
	ELSIF FB_RNS_SEQ.OUT_StepActual = 94 THEN
		VAR_RNS_BypassCommand := FALSE;
	ELSE
	END_IF
	
	IF RNS.DataOut.ByPassed THEN
		VAR_RNS_SeqPermanent.SeqMode2.2 := TRUE;
		VAR_RNS_SeqPermanent.SeqMode2.3 := FALSE;
	ELSE
		VAR_RNS_SeqPermanent.SeqMode2.3 := TRUE;
		VAR_RNS_SeqPermanent.SeqMode2.2 := FALSE;
	END_IF 	
	
END_ACTION
