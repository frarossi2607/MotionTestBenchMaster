ACTION DOS_HMI:
	VAR_DOS_MemPBStart			:= FALSE;
	VAR_DOS_MemPBStop			:= FALSE;
	VAR_DOS_MemPBAbort			:= FALSE;
	VAR_DOS_MemPBSkipForward	:= FALSE;
	
	IF NOT HMI_SS2P[SS2P_HMI_SelEnable].ON THEN
		HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON := FALSE;
	END_IF

	//SS2P
	//MODE MAN/AUTO
	VAR_DOS_SS2PSelectionEnable := VAR_DOS_ModeWait AND SFT.DataOut.MachineEmpty;
	
	HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].Visibility		:= _205MEF.IN_ConfigPresent AND _206MEF.IN_ConfigPresent; 
	HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].Enable			:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND VAR_DOS_ModeWait AND OPS.DataOut.FlrModeSelectorAdjustment AND NOT (VAR_DOS_LiftMoveStep = DSR_ProbeZeroWaitSensLowPos) AND NOT (VAR_DOS_LiftMoveStep = DSR_ProbeZeroDone) AND NOT HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON;
	HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].LampON			:= HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON AND HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].Enable; 
	
	IF EDGEPOS(VAR_DOS_MemDoserByPassed) THEN
		HMI_DOS_SS2P[SS2P_DOS_CamDosByPass].ON := FALSE;
	END_IF 
	HMI_DOS_SS2P[SS2P_DOS_CamDosByPass].Visibility			:= GNS.DataOut.DosByPassConfigured AND NOT CFG_Par.Machine.Type.SRMA; 
	HMI_DOS_SS2P[SS2P_DOS_CamDosByPass].Enable				:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND VAR_DOS_ModeWait AND TNK.DataOut.Wait AND NOT MNM.DataOut.MachineRunning AND NOT VAR_DOS_MemDoserByPassed;
	HMI_DOS_SS2P[SS2P_DOS_CamDosByPass].LampON				:= HMI_DOS_SS2P[SS2P_DOS_CamDosByPass].ON OR VAR_DOS_MemDoserByPassed;

	IF EDGEPOS(VAR_DOS_MemDoserIncluded) THEN
		HMI_DOS_SS2P[SS2P_DOS_CamDosInclusion].ON := FALSE;
	END_IF 
	HMI_DOS_SS2P[SS2P_DOS_CamDosInclusion].Visibility		:= GNS.DataOut.DosByPassConfigured AND NOT CFG_Par.Machine.Type.SRMA; 
	HMI_DOS_SS2P[SS2P_DOS_CamDosInclusion].Enable			:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND VAR_DOS_ModeWait  AND TNK.DataOut.Wait AND NOT MNM.DataOut.MachineRunning AND NOT VAR_DOS_MemDoserIncluded;
	HMI_DOS_SS2P[SS2P_DOS_CamDosInclusion].LampON			:= HMI_DOS_SS2P[SS2P_DOS_CamDosInclusion].ON OR VAR_DOS_MemDoserIncluded;
	
	HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].Visibility		:= TRUE;
	HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].Enable			:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND VAR_DOS_ModeWait AND HMI_DOS_LiftPosition.Value = 0 AND OPS.DataOut.FlrModeSelectorAdjustment AND NOT HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON; 
	HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].LampON			:= HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON AND HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].Enable;
	
	//SS2P DOSER LIFTING
	HMI_DOS_SS2P[SS2P_DOS_ManualMMF206].Visibility	:= TRUE;
	HMI_DOS_SS2P[SS2P_DOS_ManualMMF206].Enable		:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND OPS.DataOut.FlrModeSelectorAdjustment AND OPS.DataOut.FlrDoorsOk	AND OPS.DataOut.EmergencyOk AND HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON AND VAR_DOS_ModeWait AND NOT HMI_DOS_SS2P[SS2P_DOS_ManualMMF205].LampON;
	HMI_DOS_SS2P[SS2P_DOS_ManualMMF206].LampON		:= HMI_DOS_SS2P[SS2P_DOS_ManualMMF206].ON AND HMI_DOS_SS2P[SS2P_DOS_ManualMMF206].Enable;
	
	//SS2P DOSER LIFTING
	HMI_DOS_SS2P[SS2P_DOS_ManualMMF205].Visibility	:= TRUE;
	HMI_DOS_SS2P[SS2P_DOS_ManualMMF205].Enable		:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND OPS.DataOut.FlrModeSelectorAdjustment AND OPS.DataOut.FlrDoorsOk	AND OPS.DataOut.EmergencyOk AND HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON AND VAR_DOS_ModeWait AND NOT HMI_DOS_SS2P[SS2P_DOS_ManualMMF206].LampON;
	HMI_DOS_SS2P[SS2P_DOS_ManualMMF205].LampON		:= HMI_DOS_SS2P[SS2P_DOS_ManualMMF205].ON AND HMI_DOS_SS2P[SS2P_DOS_ManualMMF205].Enable;

	//SS2P DOSER PROD
	HMI_DOS_SS2P[SS2P_DOS_ModeProdFast].Visibility	:= TRUE;
	HMI_DOS_SS2P[SS2P_DOS_ModeProdFast].Enable		:= VAR_DOS_SS2PSelectionEnable AND REAL_TO_BOOL(HMI_PAR_1._216) AND PstFlr.ProductionMode AND NOT TNK.DataOut.CipMode AND NOT TNK.DataOut.RinseMode;
	HMI_DOS_SS2P[SS2P_DOS_ModeProdFast].LampON		:= HMI_DOS_SS2P[SS2P_DOS_ModeProdFast].ON;

	IF EDGEPOS(VAR_DOS_ModeProduction) THEN //RESTORE SELECTION IN CASE OF POWER OFF 
		HMI_DOS_SS2P[SS2P_DOS_ModeProdFast].ON := TRUE;
	END_IF
	
	//SS2P DOSER DRAIN
	HMI_DOS_SS2P[SS2P_DOS_ModeDrain].Visibility	:= TRUE;
	HMI_DOS_SS2P[SS2P_DOS_ModeDrain].Enable		:= VAR_DOS_SS2PSelectionEnable;
	HMI_DOS_SS2P[SS2P_DOS_ModeDrain].LampON		:= HMI_DOS_SS2P[SS2P_DOS_ModeDrain].ON;

	IF EDGEPOS(VAR_DOS_ModeDrain) THEN //RESTORE SELECTION IN CASE OF POWER OFF 
		HMI_DOS_SS2P[SS2P_DOS_ModeDrain].ON := TRUE;
	END_IF
	
	//SS2P DOSER CIP
	HMI_DOS_SS2P[SS2P_DOS_ModeCip].Visibility	:= TRUE;
	HMI_DOS_SS2P[SS2P_DOS_ModeCip].Enable		:= VAR_DOS_SS2PSelectionEnable AND PstFlr.CipRunning AND NOT TNK.DataOut.ProdMode;
	HMI_DOS_SS2P[SS2P_DOS_ModeCip].LampON		:= HMI_DOS_SS2P[SS2P_DOS_ModeCip].ON;

	IF EDGEPOS(VAR_DOS_ModeCip) THEN //RESTORE SELECTION IN CASE OF POWER OFF 
		HMI_DOS_SS2P[SS2P_DOS_ModeCip].ON := TRUE;
	END_IF
	
	//SS2P DOSER RINSE
	HMI_DOS_SS2P[SS2P_DOS_ModeRinse].Visibility	:= TRUE;
	HMI_DOS_SS2P[SS2P_DOS_ModeRinse].Enable		:= VAR_DOS_SS2PSelectionEnable AND NOT TNK.DataOut.ProdMode;
	HMI_DOS_SS2P[SS2P_DOS_ModeRinse].LampON		:= HMI_DOS_SS2P[SS2P_DOS_ModeRinse].ON;

	IF EDGEPOS(VAR_DOS_ModeRinse) THEN //RESTORE SELECTION IN CASE OF POWER OFF 
		HMI_DOS_SS2P[SS2P_DOS_ModeRinse].ON := TRUE;
	END_IF
	
	//SS2P DOSER QUICK RINSE
	HMI_DOS_SS2P[SS2P_DOS_ModeQuickRinse].Visibility	:= FALSE;
	HMI_DOS_SS2P[SS2P_DOS_ModeQuickRinse].Enable		:= VAR_DOS_ModeWait;
	HMI_DOS_SS2P[SS2P_DOS_ModeQuickRinse].LampON		:= HMI_DOS_SS2P[SS2P_DOS_ModeQuickRinse].ON;

	//SS2P DOSER FAST RINSE
	HMI_DOS_SS2P[SS2P_DOS_ModeFastRinse].Visibility	:= FALSE;
	HMI_DOS_SS2P[SS2P_DOS_ModeFastRinse].Enable		:= VAR_DOS_ModeWait;
	HMI_DOS_SS2P[SS2P_DOS_ModeFastRinse].LampON		:= HMI_DOS_SS2P[SS2P_DOS_ModeFastRinse].ON;
	
//PB
	//Start Lifting Position button
	HMI_DOS_PB[PB_CmdLiftMotorStart].Visibility	:= TRUE;
	HMI_DOS_PB[PB_CmdLiftMotorStart].Enable		:= HMI_DOS_LiftPosition.Value <> 0 AND VAR_DOS_MotorEnable;
	HMI_DOS_PB[PB_CmdLiftMotorStart].LampON		:= HMI_DOS_PB[PB_CmdLiftMotorStart].ON;
	
	//Stop Lifting Position button
	HMI_DOS_PB[PB_CmdLiftMotorStop].Visibility	:= TRUE;
	HMI_DOS_PB[PB_CmdLiftMotorStop].Enable		:= HMI_DOS_LiftPosition.Value <> 0 AND VAR_DOS_MotorEnable;
	HMI_DOS_PB[PB_CmdLiftMotorStop].LampON		:= HMI_DOS_PB[PB_CmdLiftMotorStop].ON;

	//Manual Up Push Button
	HMI_DOS_PB[PB_DOS_Up].Visibility	:= TRUE;
	HMI_DOS_PB[PB_DOS_Up].LampON		:= HMI_DOS_PB[PB_DOS_Up].ON AND HMI_DOS_PB[PB_DOS_Up].Enable; 

	//Manual Down Push Button
	HMI_DOS_PB[PB_DOS_Down].Visibility	:= TRUE;
	HMI_DOS_PB[PB_DOS_Down].LampON		:= HMI_DOS_PB[PB_DOS_Down].ON AND HMI_DOS_PB[PB_DOS_Down].Enable;
	
	//PB Mode Start
	HMI_DOS_PB[PB_CmdDosStart].Visibility				:= TRUE;
	HMI_DOS_PB[PB_CmdDosStart].Enable					:= (VAR_DOS_ModeWait OR VAR_DOS_SEQ.Mem.PBStartEnable);
	HMI_DOS_PB[PB_CmdDosStart].LampON					:= HMI_DOS_PB[PB_CmdDosStart].ON;
	HMI_DOS_PB[PB_CmdDosStart].Blink					:= VAR_DOS_ModeWait AND HMI_DOS_PB[PB_CmdDosStart].Enable AND (HMI_DOS_SS2P[SS2P_DOS_ModeProdFast].LampON OR HMI_DOS_SS2P[SS2P_DOS_ModeDrain].LampON OR HMI_DOS_SS2P[SS2P_DOS_ModeCip].LampON OR HMI_DOS_SS2P[SS2P_DOS_ModeRinse].LampON);
	
	//PB Mode Stop
	HMI_DOS_PB[PB_CmdDosStop].Visibility				:= TRUE;
	HMI_DOS_PB[PB_CmdDosStop].Enable					:= NOT VAR_DOS_ModeWait AND VAR_DOS_SEQ.Mem.PBStopEnable;
	HMI_DOS_PB[PB_CmdDosStop].LampON					:= HMI_DOS_PB[PB_CmdDosStop].ON;
	HMI_DOS_PB[PB_CmdDosStop].Blink						:= NOT VAR_DOS_ModeWait AND HMI_DOS_PB[PB_CmdDosStop].Enable;
	
	//PB Mode Skip
	HMI_DOS_PB[PB_CmdDosSkip].Visibility				:= FALSE;
	HMI_DOS_PB[PB_CmdDosSkip].Enable					:= NOT VAR_DOS_ModeWait;
	HMI_DOS_PB[PB_CmdDosSkip].LampON					:= HMI_DOS_PB[PB_CmdDosSkip].ON;
	
	//PB Mode Pause
	HMI_DOS_PB[PB_CmdDosPause].Visibility				:= FALSE;
	HMI_DOS_PB[PB_CmdDosPause].Enable					:= NOT VAR_DOS_ModeWait;
	HMI_DOS_PB[PB_CmdDosPause].LampON					:= HMI_DOS_PB[PB_CmdDosPause].ON;
	
	//PB Mode Abort
	HMI_DOS_PB[PB_CmdDosAbort].Visibility				:= TRUE;
	HMI_DOS_PB[PB_CmdDosAbort].Enable					:= NOT VAR_DOS_ModeWait AND VAR_DOS_SEQ.Mem.PBAbortEnable;
	HMI_DOS_PB[PB_CmdDosAbort].LampON					:= HMI_DOS_PB[PB_CmdDosAbort].ON;
	
	//SS3P
	HMI_DOS_SS3P[SS3P_DOS_FillingValveOpen].Visibility	:= TRUE;
	HMI_DOS_SS3P[SS3P_DOS_FillingValveOpen].Enable		:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND DOS.DataOut.ProdMode;
	HMI_DOS_SS3P[SS3P_DOS_FillingValveOpen].LampON		:= IO_210CPF.DO_Opened;
		
	//STATUS BAR
	HMI_DOS_State.Sequencer.TextBar[0].Visibility	:= TRUE;
	HMI_DOS_State.Sequencer.TextBar[0].IndexNr		:= FB_DOS_SEQ.IN_Step;
	HMI_DOS_State.Sequencer.TextBar[0].IndexText	:= FB_DOS_SEQ.OUT_HMI_ID;
	
	HMI_DOS_State.Sequencer.TextBar[1].Visibility	:= FALSE;
	HMI_DOS_State.Sequencer.TextBar[1].IndexNr		:= 0;
	HMI_DOS_State.Sequencer.TextBar[1].IndexText	:= 0;
	
	// HMI VARIABLES
	IF (VAR_DOS_ModeProduction OR VAR_DOS_FMDProductionFillerOnly OR (VAR_DOS_ModeWait AND (HMI_DOS_LiftPosition.Value = 1))) THEN
		HMI_DOS_DosingVolumeSp :=  HMI_PAR_1._215;
	ELSIF ((VAR_DOS_ModeCip OR VAR_DOS_ModeRinse) OR (VAR_DOS_ModeWait AND (HMI_DOS_LiftPosition.Value = 3))) THEN
		HMI_DOS_DosingVolumeSp := VAR_DOS_Lift_State.CmdCipHeight.Sp;
	ELSIF ((VAR_DOS_ModeCop AND COP.DataOut.DoserPositioningReq) OR (VAR_DOS_ModeWait AND (HMI_DOS_LiftPosition.Value = 2))) THEN 
		HMI_DOS_DosingVolumeSp := 0; ////High sensor _215DSF, SP in mm in COP
	ELSE 
		HMI_DOS_DosingVolumeSp := 0;  
	END_IF
	
	HMI_DOS_DosingVolumePv							:= VAR_DOS_MMF205.PosActual[ml];						
	HMI_DOS_Bypass_State.Active						:= GNS.DataOut.DosByPassed;
	HMI_DOS_Bypass_State.Fault						:= GNS.DataOut.DosByPassAlarm;
	HMI_DOS_PstFlrEndProductionReq					:= PstFlr.EndProductionReq; //rma106
	HMI_DOS_ProdEndNecessaryBottle					:= REAL_TO_DINT(VAR_DOS_ProdEndNecessaryBottle);
	
	//INFO BOX:STEPS
	HMI_DOS_State.Sequencer.InfoBox[0].Visibility			:= FB_DOS_SEQ.OUT_StepTimePr_T>0 OR FB_DOS_SEQ.OUT_StepTimePr_TON>0;
	HMI_DOS_State.Sequencer.InfoBox[0].IndexText			:= '@Lbl_Step@ time';
	HMI_DOS_State.Sequencer.InfoBox[0].Unit					:= 0;
	HMI_DOS_State.Sequencer.InfoBox[0].ProgressVisibility	:= TRUE;
	HMI_DOS_State.Sequencer.InfoBox[0].Progress				:= UINT_TO_REAL(FB_DOS_SEQ.OUT_StepProgressiveTime);
	IF FB_DOS_SEQ.OUT_StepTimePr_T>0 THEN
		HMI_DOS_State.Sequencer.InfoBox[0].Preset			:= UINT_TO_REAL(FB_DOS_SEQ.OUT_StepTimePr_T);
	ELSE
		HMI_DOS_State.Sequencer.InfoBox[0].Preset			:= UINT_TO_REAL(FB_DOS_SEQ.OUT_StepTimePr_TON); 
	END_IF
	IF FB_DOS_SEQ.OUT_StepTimePr_T>0 THEN
		HMI_DOS_State.Sequencer.InfoBox[0].Actual			:= UINT_TO_REAL(FB_DOS_SEQ.OUT_StepTimeCV_T);
	ELSE
		HMI_DOS_State.Sequencer.InfoBox[0].Actual			:= UINT_TO_REAL(FB_DOS_SEQ.OUT_StepTimeCV_TON);
	END_IF
	//SIGNALS STATE:PRODUCTION
	//DigitalIn[0]
	HMI_DOS_State.Signals.DigitalIn[1].Visibility	:= TRUE;						
	HMI_DOS_State.Signals.DigitalIn[1].LampState	:= PstFlr.ProductionMode;
	HMI_DOS_State.Signals.DigitalIn[1].Description	:= '@External Signal Production Enable';
	
	HMI_DOS_State.Signals.DigitalOut[1].Visibility	:= TRUE;
	HMI_DOS_State.Signals.DigitalOut[1].LampState	:= VAR_DOS_ModeWait; 
	HMI_DOS_State.Signals.DigitalOut[1].Description	:= '@Filler Signal Production Enable';
	
	//SIGNALS STATE:DRAIN
	//DigitalIn[1]
	HMI_DOS_State.Signals.DigitalIn[2].Visibility	:= TRUE;
	HMI_DOS_State.Signals.DigitalIn[2].LampState	:= TRUE;
	HMI_DOS_State.Signals.DigitalIn[2].Description	:= '@External Signal Drain Enable';
	
	HMI_DOS_State.Signals.DigitalOut[2].Visibility	:= TRUE;
	HMI_DOS_State.Signals.DigitalOut[2].LampState	:= VAR_DOS_ModeWait;
	HMI_DOS_State.Signals.DigitalOut[2].Description	:= '@Filler Signal Drain Enable';

	//SIGNALS STATE:Alive
	//DigitalIn[2]
	HMI_DOS_State.Signals.DigitalIn[3].Visibility	:= FALSE;
	HMI_DOS_State.Signals.DigitalIn[3].LampState	:= FALSE;
	HMI_DOS_State.Signals.DigitalIn[3].Description	:= '@Alive';
	
	HMI_DOS_State.Signals.DigitalOut[3].Visibility	:= FALSE;
	HMI_DOS_State.Signals.DigitalOut[3].LampState	:= FALSE;
	HMI_DOS_State.Signals.DigitalOut[3].Description	:= '@Alive';
		
	//SIGNALS STATE:CLEANING
	//DigitalIn[3]
	HMI_DOS_State.Signals.DigitalIn[4].Visibility	:= TRUE; 
	HMI_DOS_State.Signals.DigitalIn[4].LampState	:= PstFlr.CipRunning;
	HMI_DOS_State.Signals.DigitalIn[4].Description	:= '@External Signal CIP Enable';
		
	HMI_DOS_State.Signals.DigitalOut[4].Visibility	:= TRUE; 
	HMI_DOS_State.Signals.DigitalOut[4].LampState	:= VAR_DOS_ModeWait;
	HMI_DOS_State.Signals.DigitalOut[4].Description	:= '@Filler Signal CIP Enable';

	//SIGNALS STATE:RINSE
	//DigitalIn[4]
	HMI_DOS_State.Signals.DigitalIn[5].Visibility	:= TRUE;
	HMI_DOS_State.Signals.DigitalIn[5].LampState	:= PstFlr.RinseMode;
	HMI_DOS_State.Signals.DigitalIn[5].Description	:= '@External Signal Rinse Enable';
	
	HMI_DOS_State.Signals.DigitalOut[5].Visibility	:= TRUE;
	HMI_DOS_State.Signals.DigitalOut[5].LampState	:= VAR_DOS_ModeWait;
	HMI_DOS_State.Signals.DigitalOut[5].Description	:= '@Filler Signal Rinse Enable';

END_ACTION
