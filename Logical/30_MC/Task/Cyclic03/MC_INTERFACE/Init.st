PROGRAM _INIT
	//Init of data struct
	
	HMI_MC_MachineStatus;
	HMI_MC_GenericAxisData;
	HMI_MC_AlarmList;
	
	HMI_MC_MachineStatus.rMachineStep	:=	LREAL_TO_REAL(CFG_MC.Mechanical.MachineStep);
END_PROGRAM