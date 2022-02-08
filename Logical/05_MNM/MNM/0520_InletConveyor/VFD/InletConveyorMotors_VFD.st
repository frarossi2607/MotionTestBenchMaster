ACTION InletConveyorMotors_VFD: 
//	_InCvr(//Management with FC302
//	IN_Enable		:= OPS.DataOut.EnableDrive,
//	IN_AutoCnd		:= _InCvr.IN_AutoCnd,
//	IN_FrequencyMin	:= 0.0,
//	IN_FrequencyMax	:= 100.0,
//	IN_ManEn		:= TRUE,
//	IN_MaskEn		:= TRUE,
//	IN_Reset		:= AID.DataOut.Reset,
//	IN_HMIAutoForce	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
//	IN_QuickStopCmd	:= NOT OPS.DataOut.EnableDrive,
//	IN_CoastingCmd	:= FALSE,
//	IN_ScaleMax		:= 100.0,
//	HMI_Danfoss		:= HMI_VFD_InCvr,
//	HMI_Motor		:= HMI_InCvr,
//	IO_Danfoss		:= IO_VFD_InCvr,
//	IO_Motor		:= IO_InCvr
//	);
	
	_InCvrFC280(
	IN_Enable		:= OPS.DataOut.EnableDrive,
	IN_AutoCnd		:= _InCvrFC280.IN_AutoCnd,
	IN_FrequencyMin	:= 0.0,
	IN_FrequencyMax	:= 100.0,
	IN_ManEn		:= TRUE,
	IN_MaskEn		:= TRUE,
	IN_Reset		:= AID.DataOut.Reset,
	IN_HMIAutoForce	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_QuickStopCmd	:= NOT OPS.DataOut.EnableDrive,
	IN_CoastingCmd	:= FALSE,
	IN_ScaleMax		:= 100.0,
	HMI_Danfoss		:= HMI_VFD_InCvr,
	HMI_Motor		:= HMI_InCvr,
	IO_DanfossFC280	:= IO_VFD_InCvrFC280,
	IO_MotorFC280	:= IO_InCvrFC280
	);
	
END_ACTION
