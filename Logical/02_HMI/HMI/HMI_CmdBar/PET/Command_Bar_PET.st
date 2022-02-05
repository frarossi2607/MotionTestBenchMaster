ACTION HMI_CommandBar_Visibility_PET:
	HMI_CmdBar_PB[PB_MixerProcessStart].Visibility		:= CFG_Par.Process.BlendFill;
	HMI_CmdBar_PB[PB_FillerProcessStart].Visibility		:= NOT CFG_Par.Process.BlendFill; //v1.6
	HMI_CmdBar_PB[PB_FillerStartStop].Visibility		:= CFG_Par.Machine.Combi.BF OR CFG_Par.Machine.Combi.BFL OR CFG_Par.Machine.Combi.BLF OR CFG_Par.Machine.Combi.BAF;//V4.A.A.1.6.12
	HMI_CmdBar_PB[PB_ContainerBlock1].Visibility		:= NOT CFG_Par.Machine.Combi.BF AND NOT CFG_Par.Machine.Combi.BFL AND NOT CFG_Par.Machine.Combi.BLF AND NOT CFG_Par.Machine.Combi.BAF;//V4.A.A.1.6.12
	HMI_CmdBar_PB[PB_ContainerRelease1].Visibility		:= NOT CFG_Par.Machine.Combi.BF AND NOT CFG_Par.Machine.Combi.BFL AND NOT CFG_Par.Machine.Combi.BLF AND NOT CFG_Par.Machine.Combi.BAF;//V4.A.A.1.6.12
	HMI_CmdBar_PB[PB_FillerDoorUnlock].Visibility		:= TRUE;
	HMI_CmdBar_PB[PB_FillerLabellerCoupling].Visibility	:= CFG_Par.Machine.Combi.BLF;
	HMI_CmdBar_PB[PB_FillerBlowerCoupling].Visibility	:= CFG_Par.Machine.Combi.BF OR CFG_Par.Machine.Combi.BFL;
	HMI_CmdBar_PB[PB_FillerActisCoupled].Visibility		:= CFG_Par.Machine.Combi.BAF;//V4.A.A.1.6.12
END_ACTION

ACTION HMI_CommandBar_Command_PET:
	VAR_LbrCombiModality(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_FillerLabellerCoupling].ON) AND NOT VAR_LbrCombiModality.Q1,
	RESET	:= EDGEPOS(HMI_CmdBar_PB[PB_FillerLabellerCoupling].ON) AND VAR_LbrCombiModality.Q1
	);
	
	VAR_BlrCombiModalityReset := FALSE; //V4.A.A.1.6.12h
	IF CFG_Par.Machine.Combi.BF AND NOT OPS.DataOut.FlrModeSelectorAuto THEN //V4.A.A.1.6.12h
		VAR_BlrCombiModalityReset := TRUE;									//V4.A.A.1.6.12h
	END_IF	
	
	//Old Management
	VAR_BlrCombiModality(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_FillerBlowerCoupling].ON) AND NOT VAR_BlrCombiModality.Q1,
	RESET	:= EDGEPOS(HMI_CmdBar_PB[PB_FillerBlowerCoupling].ON) AND VAR_BlrCombiModality.Q1
	);
	
	//New Management
//	VAR_BlrCombiModality(
//	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_FillerBlowerCoupling].ON) AND NOT VAR_BlrCombiModality.Q1 AND NOT VAR_BlrCombiModalityReset,//V4.A.A.1.6.12h
//	RESET	:= (EDGEPOS(HMI_CmdBar_PB[PB_FillerBlowerCoupling].ON) AND VAR_BlrCombiModality.Q1) OR VAR_BlrCombiModalityReset,//V4.A.A.1.6.12h
//	);

	VAR_ActCombiModality(//V4.A.A.1.6.12
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_FillerActisCoupled].ON) AND NOT VAR_ActCombiModality.Q1,
	RESET	:= EDGEPOS(HMI_CmdBar_PB[PB_FillerActisCoupled].ON) AND VAR_ActCombiModality.Q1
	);
	
	VAR_ContUnblock1(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease1].ON) AND NOT VAR_ContUnblock1.Q1,
	RESET	:= (EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease1].ON) AND VAR_ContUnblock1.Q1) OR EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock1].ON) OR EDGEPOS(SFT.DataOut.COPInletContConvEmptyRunning)
	);
	
	VAR_ContBlock1(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock1].ON) AND NOT VAR_ContBlock1.Q1,
	RESET	:= (EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock1].ON) AND VAR_ContBlock1.Q1) OR EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease1].ON)
	);
	
	HMI_CmdBar_PB[PB_MixerProcessStart].Command			:= BlrFlr.PbMxrProcessCommand OR LbrFlr.PbFlrMixerCommand OR ActFlr.PbFlrMixerCommand;(*V1.61*)(*V4.A.A.1.6.12*)
	HMI_CmdBar_PB[PB_FillerProcessStart].Command		:= HMI_CmdBar_PB[PB_FillerProcessStart].ON		OR BlrFlr.PbFlrProcessCommand OR LbrFlr.PbFlrProcessCommand OR ActFlr.PbFlrProcessCommand;//V4.A.A.1.6.12
	HMI_CmdBar_PB[PB_FillerStartStop].Command			:= HMI_CmdBar_PB[PB_FillerStartStop].ON;
	HMI_CmdBar_PB[PB_ContainerBlock1].Command			:= VAR_ContBlock1.Q1 AND NOT (SFT.DataOut.COPInletContConvEmptyRunning XOR SFT.DataOut.COPInletContConvEmptyDone);
	HMI_CmdBar_PB[PB_ContainerRelease1].Command			:= VAR_ContUnblock1.Q1;;
	HMI_CmdBar_PB[PB_FillerDoorUnlock].Command			:= HMI_CmdBar_PB[PB_FillerDoorUnlock].ON		OR BlrFlr.PbFlrDoorCommand	OR LbrFlr.PbFlrDoorCommand OR ActFlr.PbFlrDoorCommand;//V4.A.A.1.6.12
	HMI_CmdBar_PB[PB_FillerLabellerCoupling].Command	:= VAR_LbrCombiModality.Q1;
	HMI_CmdBar_PB[PB_FillerBlowerCoupling].Command		:= VAR_BlrCombiModality.Q1;
	HMI_CmdBar_PB[PB_FillerActisCoupled].Command		:= VAR_ActCombiModality.Q1;//V4.A.A.1.6.12
END_ACTION

ACTION HMI_CommandBar_Enable_PET: 	
	HMI_CmdBar_PB[PB_MixerProcessStart].Enable			:= CrbFlr.HMI_ProcessStartEnable;(*V1.61*)
	HMI_CmdBar_PB[PB_FillerProcessStart].Enable			:= SEL(CFG_Par.Process.BlendFill, SkdFlr.HMI_ProcessStartEnable, CrbFlr.HMI_ProcessStartEnable);
	HMI_CmdBar_PB[PB_FillerStartStop].Enable			:= OPS.DataOut.FlrModeSelectorAuto AND NOT AID.DataOut.OneMachineStopAlarm AND//V4.A.A.1.7.0
															(MC_InputOutput.Network.Machine.Status.AutoModalityActive OR MC_InputOutput.Network.Machine.Status.MultiModalityActive) AND NOT FmcFlr.FillingManualTestActive;

	HMI_CmdBar_PB[PB_ContainerBlock1].Enable			:= TRUE;
	HMI_CmdBar_PB[PB_ContainerRelease1].Enable			:= (SFT.DataOut.ManualContainersReleaseEnable OR HMI_CmdBar_PB[PB_ContainerRelease1].Command) AND NOT SFT.DataOut.COPInletContConvEmptyRunning;	
	HMI_CmdBar_PB[PB_FillerDoorUnlock].Enable			:= NOT MC_InputOutput.Network.Machine.Status.MachineRunning AND NOT MC_InputOutput.Network.Filler.Status.ModuleRunning AND NOT MC_InputOutput.Network.Inlet.Status.ModuleRunning;
	HMI_CmdBar_PB[PB_FillerLabellerCoupling].Enable		:= LbrFlr.ReadyForCoupling AND LbrFlr.Stopped AND LbrFlr.MachOutFree AND //V1.7.2
															(MNM.DataOut.ReadyForCoupling OR HMI_CmdBar_PB[PB_FillerLabellerCoupling].LampON) AND NOT MC_InputOutput.Network.Machine.Status.MachineRunning; //V4.A.A.1.6.10a
	HMI_CmdBar_PB[PB_FillerBlowerCoupling].Enable		:= BlrFlr.BlrReadyForCoupling AND BlrFlr.Stopped AND
															(MNM.DataOut.ReadyForCoupling OR HMI_CmdBar_PB[PB_FillerBlowerCoupling].LampON) AND NOT MC_InputOutput.Network.Machine.Status.MachineRunning; //V4.A.A.1.6.10a
	HMI_CmdBar_PB[PB_FillerActisCoupled].Enable			:= ActFlr.ReadyForCoupling AND ActFlr.Stopped AND 
															(MNM.DataOut.ReadyForCoupling OR HMI_CmdBar_PB[PB_FillerActisCoupled].LampON) AND NOT MC_InputOutput.Network.Machine.Status.MachineRunning;//V4.A.A.1.6.12
	BP_ActisFillingCoupled.Enable						:= HMI_CmdBar_PB[PB_FillerActisCoupled].Enable;//V4.A.A.1.7.0
END_ACTION

ACTION HMI_CommandBar_Status_PET: 
	HMI_CmdBar_PB[PB_MixerProcessStart].LampON			:= CrbFlr.HMI_ProcessStartLampOn;(*V1.61*)
	HMI_CmdBar_PB[PB_FillerProcessStart].LampON			:= SEL(CFG_Par.Process.BlendFill, SkdFlr.HMI_ProcessStartLampOn, CrbFlr.HMI_ProcessStartLampOn);
	HMI_CmdBar_PB[PB_ContainerBlock1].Blink				:= VAR_ContBlock1.Q1 AND NOT HMI_CmdBar_PB[PB_ContainerBlock1].Command;
	HMI_CmdBar_PB[PB_ContainerRelease1].LampON			:= HMI_CmdBar_PB[PB_ContainerRelease1].Command;
	HMI_CmdBar_PB[PB_FillerStartStop].LampON 			:= MNM.DataOut.StartLightFixRequest;
	HMI_CmdBar_PB[PB_FillerDoorUnlock].LampON			:= OPS.DataOut.HMIDoorUnlock;
	HMI_CmdBar_PB[PB_FillerLabellerCoupling].LampON		:= HMI_CmdBar_PB[PB_FillerLabellerCoupling].Command;
	HMI_CmdBar_PB[PB_FillerBlowerCoupling].LampON		:= HMI_CmdBar_PB[PB_FillerBlowerCoupling].Command;
	HMI_CmdBar_PB[PB_FillerActisCoupled].LampON			:= HMI_CmdBar_PB[PB_FillerActisCoupled].Command;//V4.A.A.1.6.12
	BP_ActisFillingCoupled.State						:= HMI_CmdBar_PB[PB_FillerActisCoupled].LampON;//V4.A.A.1.7.0
	
	HMI_CmdBar_PB[PB_FillerStartStop].Blink				:= MNM.DataOut.StartLightBlinkRequest;
	HMI_CmdBar_PB[PB_FillerProcessStart].Blink			:= SEL(CFG_Par.Process.BlendFill, SkdFlr.HMI_ProcessStartBlink, CrbFlr.HMI_ProcessStartBlink);
END_ACTION