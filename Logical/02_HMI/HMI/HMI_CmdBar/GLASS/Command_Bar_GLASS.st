ACTION HMI_CommandBar_Visibility_GLASS:
	HMI_CmdBar_PB[PB_MixerProcessStart].Visibility		:= CFG_Par.Process.BlendFill;
	HMI_CmdBar_PB[PB_FillerProcessStart].Visibility		:= NOT CFG_Par.Process.BlendFill;(*master nuovo*)
	HMI_CmdBar_PB[PB_FillerDoorUnlock].Visibility		:= TRUE;
	HMI_CmdBar_PB[PB_ContainerBlock1].Visibility		:= NOT CFG_Par.Machine.Combi.BF AND NOT CFG_Par.Machine.Combi.BFL AND NOT CFG_Par.Machine.Combi.BLF;
	HMI_CmdBar_PB[PB_ContainerRelease1].Visibility		:= NOT CFG_Par.Machine.Combi.BF AND NOT CFG_Par.Machine.Combi.BFL AND NOT CFG_Par.Machine.Combi.BLF;

END_ACTION

ACTION HMI_CommandBar_Command_GLASS: 
	HMI_CmdBar_PB[PB_MixerProcessStart].Command			:= HMI_CmdBar_PB[PB_MixerProcessStart].ON		OR BlrFlr.PbMxrProcessCommand;
	HMI_CmdBar_PB[PB_FillerProcessStart].Command		:= HMI_CmdBar_PB[PB_FillerProcessStart].ON		OR BlrFlr.PbFlrProcessCommand;
	HMI_CmdBar_PB[PB_FillerDoorUnlock].Command			:= HMI_CmdBar_PB[PB_FillerDoorUnlock].ON		OR BlrFlr.PbFlrDoorCommand;

	VAR_ContUnblock1(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease1].ON) AND NOT VAR_ContUnblock1.Q1,
	RESET	:= (EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease1].ON OR SFT.DataOut.ManualContainersReleaseEnable) AND VAR_ContUnblock1.Q1) OR EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock1].ON) OR EDGEPOS(SFT.DataOut.COPInletContConvEmptyRunning)(*master nuovo*)

	);
	
	VAR_ContBlock1(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock1].ON) AND NOT VAR_ContBlock1.Q1,
	RESET	:= (EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock1].ON) AND VAR_ContBlock1.Q1) OR EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease1].ON)
	);
	
	HMI_CmdBar_PB[PB_ContainerBlock1].Command			:= VAR_ContBlock1.Q1;
	HMI_CmdBar_PB[PB_ContainerRelease1].Command			:= VAR_ContUnblock1.Q1;
	HMI_CmdBar_PB[PB_MixerProcessStart].Command			:= HMI_CmdBar_PB[PB_MixerProcessStart].ON		OR BlrFlr.PbMxrProcessCommand OR LbrFlr.PbFlrMixerCommand;(*master nuovo*)

	
END_ACTION

ACTION HMI_CommandBar_Enable_GLASS: 
	HMI_CmdBar_PB[PB_MixerProcessStart].Enable			:= SEL(CFG_Par.Process.BlendFill,SkdFlr.HMI_ProcessStartEnable,CrbFlr.HMI_ProcessStartEnable);;(*master nuovo*)
	HMI_CmdBar_PB[PB_FillerProcessStart].Enable			:= SEL(CFG_Par.Process.BlendFill,SkdFlr.HMI_ProcessStartEnable,CrbFlr.HMI_ProcessStartEnable);
	HMI_CmdBar_PB[PB_FillerDoorUnlock].Enable			:= NOT MC_InputOutput.Network.Machine.Status.MachineRunning;
	HMI_CmdBar_PB[PB_ContainerBlock1].Enable			:= TRUE;
	HMI_CmdBar_PB[PB_ContainerRelease1].Enable			:= (SFT.DataOut.ManualContainersReleaseEnable OR HMI_CmdBar_PB[PB_ContainerRelease1].Command) AND NOT SFT.DataOut.COPInletContConvEmptyRunning;	

END_ACTION

ACTION HMI_CommandBar_Status_GLASS: 
	HMI_CmdBar_PB[PB_MixerProcessStart].LampON			:= SEL(CFG_Par.Process.BlendFill,SkdFlr.HMI_ProcessStartLampOn, CrbFlr.HMI_ProcessStartLampOn);	(*master nuovo*)
	HMI_CmdBar_PB[PB_FillerProcessStart].LampON			:= SEL(CFG_Par.Process.BlendFill, SkdFlr.HMI_ProcessStartLampOn, CrbFlr.HMI_ProcessStartLampOn);
	HMI_CmdBar_PB[PB_FillerDoorUnlock].LampON			:= OPS.DataOut.HMIDoorUnlock;
	HMI_CmdBar_PB[PB_FillerProcessStart].Blink			:= SEL(CFG_Par.Process.BlendFill, SkdFlr.HMI_ProcessStartBlink, CrbFlr.HMI_ProcessStartBlink);
	HMI_CmdBar_PB[PB_ContainerBlock1].Blink				:= VAR_ContBlock1.Q1 AND NOT HMI_CmdBar_PB[PB_ContainerBlock1].Command;
	HMI_CmdBar_PB[PB_ContainerRelease1].LampON			:= HMI_CmdBar_PB[PB_ContainerRelease1].Command;
	HMI_CmdBar_PB[PB_ContainerBlock1].LampON			:= HMI_CmdBar_PB[PB_ContainerBlock1].Command;

	
END_ACTION