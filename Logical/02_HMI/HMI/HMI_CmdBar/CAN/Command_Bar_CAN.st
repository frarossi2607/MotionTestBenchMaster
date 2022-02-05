ACTION HMI_CommandBar_Visibility_CAN:
	HMI_CmdBar_PB[PB_FillerSeamerCoupled].Visibility	:= TRUE;
	HMI_CmdBar_PB[PB_FillerStartStop].Visibility		:= TRUE;
	HMI_CmdBar_PB[PB_SeamerStartStop].Visibility		:= TRUE;
	HMI_CmdBar_PB[PB_FillerProcessStart].Visibility		:= TRUE;
	HMI_CmdBar_PB[PB_MixerProcessStart].Visibility		:= FALSE;
	HMI_CmdBar_PB[PB_ContainerBlock1].Visibility		:= TRUE;
	HMI_CmdBar_PB[PB_ContainerRelease1].Visibility		:= TRUE;
	HMI_CmdBar_PB[PB_ContainerBlock2].Visibility		:= CFG_Par.Motors.DoubleInlet;
	HMI_CmdBar_PB[PB_ContainerRelease2].Visibility		:= CFG_Par.Motors.DoubleInlet;
	HMI_CmdBar_PB[PB_FillerDoorUnlock].Visibility		:= TRUE;
	HMI_CmdBar_PB[PB_SeamerDoorUnlock].Visibility		:= TRUE;
END_ACTION

ACTION HMI_CommandBar_Command_CAN: 
	VAR_CoupledModality(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_FillerSeamerCoupled].ON) AND NOT VAR_CoupledModality.Q1,
	RESET	:= EDGEPOS(HMI_CmdBar_PB[PB_FillerSeamerCoupled].ON) AND VAR_CoupledModality.Q1
	);
	
	VAR_ContUnblock1(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease1].ON) AND NOT VAR_ContUnblock1.Q1,
	RESET	:= (EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease1].ON) AND VAR_ContUnblock1.Q1) OR EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock1].ON) OR EDGEPOS(SFT.DataOut.COPInletContConvEmptyRunning)
	);
	
	VAR_ContBlock1(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock1].ON) AND NOT VAR_ContBlock1.Q1,
	RESET	:= (EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock1].ON) AND VAR_ContBlock1.Q1) OR EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease1].ON)
	);
	
	VAR_ContUnblock2(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease2].ON) AND NOT VAR_ContUnblock2.Q1,
	RESET	:= (EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease2].ON) AND VAR_ContUnblock2.Q1) OR EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock2].ON) OR EDGEPOS(SFT.DataOut.COPInletContConvEmptyRunning)
	);
	
	VAR_ContBlock2(
	SET1	:= EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock2].ON) AND NOT VAR_ContBlock2.Q1,
	RESET	:= (EDGEPOS(HMI_CmdBar_PB[PB_ContainerBlock2].ON) AND VAR_ContBlock2.Q1) OR EDGEPOS(HMI_CmdBar_PB[PB_ContainerRelease2].ON)
	);
	
	HMI_CmdBar_PB[PB_FillerSeamerCoupled].Command	:= VAR_CoupledModality.Q1;
	HMI_CmdBar_PB[PB_FillerStartStop].Command		:= HMI_CmdBar_PB[PB_FillerStartStop].ON;
	HMI_CmdBar_PB[PB_SeamerStartStop].Command		:= HMI_CmdBar_PB[PB_SeamerStartStop].ON;
	HMI_CmdBar_PB[PB_FillerProcessStart].Command	:= HMI_CmdBar_PB[PB_FillerProcessStart].ON;
	HMI_CmdBar_PB[PB_MixerProcessStart].Command		:= HMI_CmdBar_PB[PB_MixerProcessStart].ON;
	HMI_CmdBar_PB[PB_ContainerBlock1].Command		:= VAR_ContBlock1.Q1 AND NOT (SFT.DataOut.COPInletContConvEmptyRunning XOR SFT.DataOut.COPInletContConvEmptyDone);
	HMI_CmdBar_PB[PB_ContainerRelease1].Command		:= VAR_ContUnblock1.Q1;
	HMI_CmdBar_PB[PB_ContainerBlock2].Command		:= VAR_ContBlock2.Q1 AND NOT (SFT.DataOut.COPInletContConvEmptyRunning XOR SFT.DataOut.COPInletContConvEmptyDone);
	HMI_CmdBar_PB[PB_ContainerRelease2].Command		:= VAR_ContUnblock2.Q1;
	HMI_CmdBar_PB[PB_FillerDoorUnlock].Command		:= HMI_CmdBar_PB[PB_FillerDoorUnlock].ON;
	HMI_CmdBar_PB[PB_SeamerDoorUnlock].Command		:= HMI_CmdBar_PB[PB_SeamerDoorUnlock].ON;
END_ACTION

ACTION HMI_CommandBar_Enable_CAN: 
	IF MC_InputOutput.Network.Machine.Status.MultiModalityActive THEN
		HMI_CmdBar_PB[PB_FillerSeamerCoupled].Enable	:= NOT MC_InputOutput.Network.Filler.Status.ModuleRunning AND  NOT MC_InputOutput.Network.Outlet.Status.ModuleRunning;
	ELSE
		HMI_CmdBar_PB[PB_FillerSeamerCoupled].Enable	:= NOT MC_InputOutput.Network.Machine.Status.MachineRunning;
	END_IF

	HMI_CmdBar_PB[PB_FillerStartStop].Enable		:= OPS.DataOut.FlrModeSelectorAuto AND
														(MC_InputOutput.Network.Machine.Status.MultiModalityActive) AND NOT FmcFlr.FillingManualTestActive;
	//HMI_CmdBar_PB[PB_SeamerStartStop].Enable		:= OPS.DataOut.SmrModeSelectorAuto AND
	//													(MC_InputOutput.Network.Machine.Status.MultiModalityActive);
	//HMI_CmdBar_PB[PB_FillerProcessStart].Enable		:= SkdFlr.HMI_ProcessStartEnable AND HMI_CmdBar_PB[PB_FillerSeamerCoupled].Command AND NOT SMR.DataOut.CleaningReq;
	HMI_CmdBar_PB[PB_MixerProcessStart].Enable		:= FALSE;
	HMI_CmdBar_PB[PB_ContainerBlock1].Enable		:= TRUE;
	HMI_CmdBar_PB[PB_ContainerRelease1].Enable		:= (SFT.DataOut.ManualContainersReleaseEnable OR HMI_CmdBar_PB[PB_ContainerRelease1].Command) AND NOT SFT.DataOut.COPInletContConvEmptyRunning;
	HMI_CmdBar_PB[PB_ContainerBlock2].Enable		:= TRUE;
	HMI_CmdBar_PB[PB_ContainerRelease2].Enable		:= (SFT.DataOut.ManualContainersReleaseEnable OR HMI_CmdBar_PB[PB_ContainerRelease2].Command) AND NOT SFT.DataOut.COPInletContConvEmptyRunning;
	HMI_CmdBar_PB[PB_FillerDoorUnlock].Enable		:= NOT MC_InputOutput.Network.Machine.Status.MachineRunning AND NOT MC_InputOutput.Network.Filler.Status.ModuleRunning AND NOT TNK.DataOut.CipMode;
	HMI_CmdBar_PB[PB_SeamerDoorUnlock].Enable		:= NOT MC_InputOutput.Network.Machine.Status.MachineRunning AND NOT MC_InputOutput.Network.Outlet.Status.ModuleRunning;
END_ACTION

ACTION HMI_CommandBar_Status_CAN: 
	HMI_CmdBar_PB[PB_FillerSeamerCoupled].LampON	:= HMI_CmdBar_PB[PB_FillerSeamerCoupled].Command;
	//HMI_CmdBar_PB[PB_FillerStartStop].LampON		:= MNM.DataOut.StartFlrLightFixRequest;
	//HMI_CmdBar_PB[PB_FillerStartStop].Blink			:= MNM.DataOut.StartFlrLightBlinkRequest;
	//HMI_CmdBar_PB[PB_SeamerStartStop].LampON		:= MNM.DataOut.StartSmrLightFixRequest;
	//HMI_CmdBar_PB[PB_SeamerStartStop].Blink			:= MNM.DataOut.StartSmrLightBlinkRequest;
	HMI_CmdBar_PB[PB_FillerProcessStart].LampON		:= SkdFlr.HMI_ProcessStartLampOn;
	HMI_CmdBar_PB[PB_FillerProcessStart].Blink		:= SkdFlr.HMI_ProcessStartBlink;
	HMI_CmdBar_PB[PB_MixerProcessStart].LampON		:= HMI_CmdBar_PB[PB_MixerProcessStart].Command;
	HMI_CmdBar_PB[PB_ContainerBlock1].LampON		:= HMI_CmdBar_PB[PB_ContainerBlock1].Command;
	HMI_CmdBar_PB[PB_ContainerBlock1].Blink			:= VAR_ContBlock1.Q1 AND NOT HMI_CmdBar_PB[PB_ContainerBlock1].Command;
	HMI_CmdBar_PB[PB_ContainerRelease1].LampON		:= HMI_CmdBar_PB[PB_ContainerRelease1].Command;
	HMI_CmdBar_PB[PB_ContainerBlock2].LampON		:= HMI_CmdBar_PB[PB_ContainerBlock2].Command;
	HMI_CmdBar_PB[PB_ContainerBlock2].Blink			:= VAR_ContBlock2.Q1 AND NOT HMI_CmdBar_PB[PB_ContainerBlock2].Command;
	HMI_CmdBar_PB[PB_ContainerRelease2].LampON		:= HMI_CmdBar_PB[PB_ContainerRelease2].Command;
	//HMI_CmdBar_PB[PB_FillerDoorUnlock].LampON		:= OPS.DataOut.HmiFlrDoorUnlock;
	//HMI_CmdBar_PB[PB_SeamerDoorUnlock].LampON		:= OPS.DataOut.HmiSmrDoorUnlock;
END_ACTION