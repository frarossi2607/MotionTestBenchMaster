ACTION DOS_DataOut:
	
	//SEQUENCE
	DOS.DataOut.WaitMode		:= VAR_DOS_ModeWait;
	DOS.DataOut.ProdMode		:= VAR_DOS_ModeProduction;
	DOS.DataOut.CipMode 		:= VAR_DOS_ModeCip;
	DOS.DataOut.RinseMode		:= VAR_DOS_ModeRinse;
	DOS.DataOut.CopMode			:= VAR_DOS_ModeCop AND VAR_DOS_SeqPositionReached;
	DOS.DataOut.DrainMode		:= VAR_DOS_ModeDrain;
	DOS.DataOut.CopAfterCipReq  := VAR_DOS_SEQ.Mem.CopAfterCipRequest;
	DOS.DataOut.CopRunning		:= VAR_DOS_StepCopRunning;
	
	//SIGNALS INTERCHANGE
	DOS.DataOut.FillingProd		:= VAR_DOS_StepProdProducing OR VAR_DOS_StepProdEndProduction;
	DOS.DataOut.CommandToValve	:= VAR_DOS_SEQ.Mem.ValveOpening OR COP.DataOut.RcpActive;
	DOS.DataOut.ProductRequest	:= VAR_DOS_SEQ.ITC.PROD_ProductRequest; //PULP REQ
	DOS.DataOut.ProductionEnd	:= VAR_DOS_SEQ.ITC.PROD_EndProductionCompleted;
	DOS.DataOut.ReadyForHeating := VAR_DOS_SEQ.ITC.PROD_ReadyForHeating; //HOT WATER REQ
	DOS.DataOut.DoserInTemperature := TTJ[203].OUT_SpReached;
	DOS.DataOut.DoserFull		:= LTJ[203].OUT_SpReached AND VAR_DOS_StepProdHeating; //ONLY IN START UP ?
	DOS.DataOut.AVJ201Open		:= AVJ[201].OUT_OpenedFiltered;
	DOS.DataOut.DoserEmpty		:= VAR_DOS_TankEmpted;
	DOS.DataOut.RecoveryEnd		:= VAR_DOS_SEQ.ITC.PROD_ProductRecoveryEnd;
	
	DOS.DataOut.CipConditionOk	:= VAR_DOS_ModeCip AND VAR_DOS_SeqPositionReached AND NOT VAR_DOS_SeqCipStopAlarm AND TTJ[203].OUT_SpReached; //CIP SOLUT REQ AND CIP SOLUTION RETURN
	DOS.DataOut.CipSolutionReq	:= VAR_DOS_SEQ.ITC.CIP_CleaningRequest;
	DOS.DataOut.CipAlarm		:= VAR_DOS_SeqCipStopAlarm; //VALUTA
	DOS.DataOut.CipRecovery		:= VAR_DOS_StepCipRecovery AND IO_AVJ[216].DI_Opened AND AVJ[217].OUT (*AND IO_AVJ[218].DI_Opened*) AND PPJ[202].OUT_InOperation; 
	DOS.DataOut.CipRecoveryEnd  := VAR_DOS_SEQ.ITC.CIP_ChangeEnded; 
	DOS.DataOut.CipSystemFlooded := VAR_DOS_SEQ.ITC.CIP_FloodingEnded; 
	DOS.DataOut.CipDrainEnd		:= VAR_DOS_SEQ.ITC.CIP_DrainEnded;
	DOS.DataOut.CipLevelReached := LTJ[203].OUT_SpReached AND VAR_DOS_ModeCip; //Allo step 73 A2 aspetta che tutti i partner siano a livelloCIP e poi chiude tutto in loop
	
	DOS.DataOut.RinseReq		:= VAR_DOS_SEQ.ITC.CIP_RinseRunning;
	DOS.DataOut.RinseEnd		:= VAR_DOS_SEQ.ITC.CIP_RinseEnded; 
	DOS.DataOut.RinseAfterProdReq := VAR_DOS_SEQ.ITC.PROD_WaterRequestAfterProd;
	DOS.DataOut.RinseAfterProdEnd := VAR_DOS_SEQ.ITC.CIP_RinseEnded;
	
	DOS.DataOut.EjectionRequest	:= VAR_DOS_RejectExpulsionRequest;
	DOS.DataOut.HotWaterReq		:= VAR_DOS_StepCipDraining; //At the end of the CIP, rinse of hot water 
	
	DOS.DataOut.NecessaryBottleEndProd := VAR_DOS_ProdEndNecessaryBottle;

	//FIX SPEED
	DOS.DataOut.FixSpeedRequest := (VAR_DOS_ModeCip AND NOT TNK.DataOut.CipMode) OR VAR_DOS_ModeCop OR (VAR_DOS_ModeRinse AND NOT TNK.DataOut.RinseMode);
	
	IF VAR_DOS_ModeCip OR VAR_DOS_ModeRinse THEN
		DOS.DataOut.FixSpeedValue := HMI_PAM_3._631;
	ELSIF VAR_DOS_FMDCop THEN
		DOS.DataOut.FixSpeedValue := HMI_PAM_3._632;
	END_IF
	
	//MOTION
	DOS.DataOut.MachineStart			:= VAR_DOS_SEQ.Mem.MachineStart;
	DOS.DataOut.MachineStop				:= VAR_DOS_SEQ.Mem.MachineStop;
	DOS.DataOut.DoserExcluded 			:= VAR_DOS_MemDoserByPassed; 
	DOS.DataOut.DoserIncluded			:= VAR_DOS_MemDoserIncluded;
	DOS.DataOut.ByPassed				:= GNS.DataOut.DosByPassed;
	
	IF OPS.DataOut.FlrModeSelectorAdjustment AND NOT MNM.DataOut.MachineRunning THEN //machine running non so se serve
		DOS.DataOut.AxisDisableRequest		:= FALSE;	
		DOS.DataOut.FillerAxisDisableRequest := FALSE;
	ELSE
		DOS.DataOut.AxisDisableRequest		:= VAR_DOS_MemDoserAxisOff;				 
		DOS.DataOut.AxisEnableRequest		:= VAR_DOS_MemDoserAxisOn;
		DOS.DataOut.FillerAxisDisableRequest := VAR_DOS_MemFillerAxisOffReq;
	END_IF
	
	DOS.DataOut.StepCounterRequest		:= VAR_DOS_SEQ.Mem.LapsCounter;
	
	DOS.DataOut.PositionReached 		:= VAR_DOS_SeqPositionReached;
	
	//FILLER SELECTION ENABLE
	DOS.DataOut.FillerProdStartEnable	:= VAR_DOS_ModeWait OR VAR_DOS_ModeProduction;
	DOS.DataOut.FillerCipStartEnable	:= VAR_DOS_ModeWait OR (VAR_DOS_ModeCip AND VAR_DOS_StepCipFillerStartEnable); 
	DOS.DataOut.FillerRinseStartEnable	:= VAR_DOS_ModeWait OR VAR_DOS_ModeRinse; //VALUTARE: AND NOT VAR_DOS_StepRinseInExecution)
END_ACTION
