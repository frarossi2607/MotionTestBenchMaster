ACTION HMI_MNM_Loading:
	HMI_MNM_PB;
	HMI_MNM_MachineSpeedAct;
	HMI_MNM_MachineSpeedReq;
	HMI_MNM_MinMachineSpeed;
	HMI_MNM_MinMachineJogSpeed := CST_JogMinimumSpeed;
	HMI_MNM_MaxMachineJogSpeed := CST_JogMaximumSpeed;
	HMI_MNM_MinInMotionAdjustement;
	HMI_MNM_MaxInMotionAdjustement;
	HMI_MNM_MaxMachineSpeed;
	HMI_MNM_AxisPositionOffset;
	HMI_MNM_AxisStepByStepOffset;
	HMI_MNM_AxisInMotionAdjustment;
	HMI_MNM_MachinePitch;
	HMI_MNM_AxisSelected;
	HMI_MNM_ConveyorSpeed;
	HMI_MNM_MachinePosition;
	HMI_MNM_FlrSpeedWidget;
	HMI_MNM_SmrSpeedWidget;
	HMI_MNM_MachineRunning;
	
	HMI_ContainerFallInlet1;
	HMI_ContainerFallInlet2;
	HMI_NoContainerInlet1;
	HMI_NoContainerInlet2;
	HMI_OutletFull;
	//MOTORS
	HMI_OutCvr;
	HMI_InCvr;(*master nuovo*)
	//DRIVERS
	HMI_VFD_OutCvr;
	HMI_VFD_InCvr;(*master nuovo*)
	//SENSORS
	HMI_236DSE;
	HMI_230DSE;
	HMI_241DSE;
	
	//V4.A.A.1.7.0
	HMI_MNM_CamName;
	
	HMI_MNM_NumOfDmcInTangentSector1;
	HMI_MNM_NumOfDmcInTangentSector2;
END_ACTION
