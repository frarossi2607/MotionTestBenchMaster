ACTION RNS_PumpsFB:
//PPB209 RINSER RECOVERY PUMP
	PPB[209](
	IN_Simulation 		:= FALSE,
	IN_ConfigPresent 	:= PPB[209].IN_ConfigPresent,
	IN_Enable 			:= PPB[209].IN_Enable,
	IN_AutoCnd 			:= PPB[209].IN_AutoCnd,
	IN_AutoSpeed 		:= PPB[209].IN_AutoSpeed,
	IN_Reverse 			:= FALSE,
	IN_FrequencyMin 	:= HMI_PAM_B1._040,
	IN_FrequencyMax 	:= HMI_PAM_B1._041,
	IN_ManEn 			:= TRUE,
	IN_MaskEn 			:= TRUE,
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_QuickStopCmd		:= NOT IO_PPB[209].DI_SafetyEnable,
	IN_JOGMode 			:= FALSE,
	IN_JOGCnd 			:= FALSE,
	IN_CoastingCmd 		:= PPB[209].IN_CoastingCmd,
	IN_FBKDelay 		:= T#1000MS,
	IN_SafetyCtrlEn 	:= FALSE,
	IN_ScaleMax 		:= 100.0,
	HMI_Danfoss 		:= HMI_VFD_PPB[209],
	HMI_Motor 			:= HMI_PPB[209],
	IO_DanfossFC280 			:= IO_VFD_PPB[209],
	IO_MotorFC280 			:= IO_PPB[209]
	);
	
	HMI_CFG_PAM_B1._040 := PPB[209].IN_ConfigPresent;
	HMI_CFG_PAM_B1._041 := PPB[209].IN_ConfigPresent;
END_ACTION
