ACTION MNM_DataOut:
	MNM.DataOut.HornFlrRequest		:= VAR_MNM_HornFlrRequest;

	MNM.DataOut.ReadyForVortexCalib	:= VAR_MNM_AutoVortexCalibActive;

	MNM.DataOut.ReadyForCoupling	:= MC_InputOutput.Network.Machine.Status.EnableCombi;
	
	MNM.DataOut.FixSpeedRequest 	:= VAR_MNM_FixSpeedReq; 	
	
	MNM.DataOut.COPInletContBlockSpeedReached	:= VAR_FixSpeed[10].Reached;
	
	MNM.DataOut.MachineRunning		:= SEL(MC_InputOutput.Network.Machine.Status.MultiModalityActive, MC_InputOutput.Network.Machine.Status.MachineRunning, MC_InputOutput.Network.Filler.Status.ModuleRunning); //V1.0
	MNM.DataOut.RinserAxisDisabled    	:= MC_InputOutput.Network.Filler.Status.RinserAxisDisabled;//V4.A.A.1.7.0
	
	IF CFG_Par.Machine.Combi.BF THEN
		IF BlrFlr.ReadyToRun THEN 
			TMR_TON_BlowerStopper.IN := FALSE;
			MNM.DataOut.PartnerReadyToRun	:= TRUE;
		ELSE
			TMR_TON_BlowerStopper.IN := BlrFlr.Stopped;
			MNM.DataOut.PartnerReadyToRun	:= NOT TMR_TON_BlowerStopper.Q;
		END_IF
	ELSIF CFG_Par.Machine.Combi.BLF THEN
		IF HMI_CmdBar_PB[PB_FillerLabellerCoupling].Command THEN
			MNM.DataOut.PartnerReadyToRun	:= LbrFlr.ReadyToRun OR LbrFlr.PbStartLamp;//V4.A.A.1.7.0
		END_IF
	ELSIF CFG_Par.Machine.Combi.BAF THEN//V4.A.A.1.7.0
		IF HMI_CmdBar_PB[PB_FillerActisCoupled].Command THEN
			MNM.DataOut.PartnerReadyToRun	:= ActFlr.ReadyToRun;
		END_IF	
	END_IF
	
	TMR_TON_BlowerStopper(PT := t#5s);
	
	IF EDGEPOS(IO_PB_FlStart.ON)	OR EDGENEG(IO_PB_FlStop.ON)	THEN
		MNM.DataOut.OperatorPresence	:= 	TRUE;
	END_IF
END_ACTION
