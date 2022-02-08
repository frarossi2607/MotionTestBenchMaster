ACTION DOS_MotorsFB:

	MMJ[201](
	IN_ConfigPresent 	:= MMJ[201].IN_ConfigPresent, 
	IN_Enable			:= MMJ[201].IN_Enable,
	IN_AutoCnd			:= MMJ[201].IN_AutoCnd,
	IN_AutoSpeed		:= MMJ[201].IN_AutoSpeed, 
	IN_FrequencyMin		:= 0.0,
	IN_FrequencyMax		:= 60.0,
	IN_Reset			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce		:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_QuickStopCmd		:= NOT MMJ[201].IN_Enable,
	IN_ManEn			:= MMJ[201].IN_ManEn,
	IN_MaskEn			:= MMJ[201].IN_MaskEn,
	IN_ScaleMax			:= 60.0,
	HMI_Danfoss			:= HMI_VFD_MMJ[201],
	HMI_Motor			:= HMI_MMJ[201],
	IO_DanfossFC280		:= IO_VFD_MMJ[201],
	IO_MotorFC280		:= IO_MMJ[201]
	);
	
	MMF[205](
	IN_ConfigPresent 	:= MMF[205].IN_ConfigPresent, 
	IN_Enable			:= MMF[205].IN_Enable,
	IN_AutoCnd			:= MMF[205].IN_AutoCnd,
	IN_AutoSpeed		:= LIMIT(MMF[205].IN_FrequencyMin, MAX(ABS(VAR_DOS_MMF205.SpActual[mm] - VAR_DOS_MMF205.PosActual[mm])*5.0, 10.0),MMF[205].IN_FrequencyMax),
	IN_FrequencyMin		:= 0.0,
	IN_FrequencyMax		:= 60.0,
	IN_Reverse			:= MMF[205].IN_Reverse,
	IN_Reset			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce		:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_QuickStopCmd		:= NOT MMF[205].IN_Enable,
	IN_ManEn			:= MMF[205].IN_ManEn,
	IN_MaskEn			:= MMF[205].IN_MaskEn,
	IN_ScaleMax			:= 100.0,
	HMI_Danfoss			:= HMI_VFD_MMF[205],
	HMI_Motor			:= HMI_MMF[205],
	IO_DanfossFC280		:= IO_VFD_MMF[205],
	IO_MotorFC280		:= IO_MMF[205]
	);
	
	MMF[206](
	IN_ConfigPresent 	:= MMF[206].IN_ConfigPresent, 
	IN_Enable			:= MMF[206].IN_Enable,
	IN_AutoCnd			:= MMF[206].IN_AutoCnd,
	IN_AutoSpeed		:= LIMIT(MMF[206].IN_FrequencyMin, MAX(ABS(VAR_DOS_MMF206.SpActual[mm] - VAR_DOS_MMF206.PosActual[mm])*5.0, 10.0),MMF[206].IN_FrequencyMax),
	IN_FrequencyMin		:= 0.0,
	IN_FrequencyMax		:= 60.0,
	IN_Reverse			:= MMF[206].IN_Reverse,
	IN_Reset			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce		:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_QuickStopCmd		:= NOT MMF[206].IN_Enable,
	IN_ManEn			:= MMF[206].IN_ManEn,
	IN_MaskEn			:= MMF[206].IN_MaskEn,
	IN_ScaleMax			:= 100.0,
	HMI_Danfoss			:= HMI_VFD_MMF[206],
	HMI_Motor			:= HMI_MMF[206],
	IO_DanfossFC280			:= IO_VFD_MMF[206],
	IO_MotorFC280			:= IO_MMF[206]
	);
		
	VAR_DOS_MotorReady := VAR_DOS_MotorEnable AND NOT MMJ[201].OUT_DriveFault;
	VAR_DOS_MotorFault := VAR_DOS_MotorEnable AND MMJ[201].OUT_DriveFault;
END_ACTION
