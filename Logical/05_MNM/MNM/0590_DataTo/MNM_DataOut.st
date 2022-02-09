ACTION MNM_DataOut:
	MNM.DataOut.HornFlrRequest		:= VAR_MNM_HornFlrRequest;

	MNM.DataOut.ReadyForVortexCalib	:= VAR_MNM_AutoVortexCalibActive;

	MNM.DataOut.ReadyForCoupling	:= MC_InputOutput.Network.Machine.Status.EnableCombi;
	
	MNM.DataOut.FixSpeedRequest 	:= VAR_MNM_FixSpeedReq; 	
	
	MNM.DataOut.COPInletContBlockSpeedReached	:= VAR_FixSpeed[10].Reached;
	
	MNM.DataOut.MachineRunning		:= SEL(MC_InputOutput.Network.Machine.Status.MultiModalityActive, MC_InputOutput.Network.Machine.Status.MachineRunning, MC_InputOutput.Network.Filler.Status.ModuleRunning); //V1.0
	
	IF EDGEPOS(IO_PB_FlStart.ON)	OR EDGENEG(IO_PB_FlStop.ON)	THEN
		MNM.DataOut.OperatorPresence	:= 	TRUE;
	END_IF

END_ACTION
