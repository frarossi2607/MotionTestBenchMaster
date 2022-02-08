ACTION OutletConveyorMotors_VFD: 
//	_OutCvr(//Management with FC302
//	IN_Enable		:= OPS.DataOut.EnableDrive,
//	IN_AutoCnd		:= _OutCvr.IN_AutoCnd,
//	IN_FrequencyMin	:= 0.0,
//	IN_FrequencyMax	:= 100.0,
//	IN_ManEn		:= TRUE,
//	IN_MaskEn		:= TRUE,
//	IN_Reset		:= AID.DataOut.Reset,
//	IN_HMIAutoForce	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
//	IN_QuickStopCmd	:= NOT OPS.DataOut.EnableDrive,
//	IN_CoastingCmd	:= FALSE,
//	IN_ScaleMax		:= 100.0,
//	HMI_Danfoss		:= HMI_VFD_OutCvr,
//	HMI_Motor		:= HMI_OutCvr,
//	IO_Danfoss		:= IO_VFD_OutCvr,
//	IO_Motor		:= IO_OutCvr
//	);
	
	_OutCvrFC280.IN_AutoCnd 	:= _OutCvr.IN_AutoCnd;
	_OutCvrFC280.IN_AutoSpeed	:= _OutCvr.IN_AutoSpeed;	//Montanarini: appoggio velocità
	
	_OutCvrFC280(
	IN_Enable		:= OPS.DataOut.EnableDrive,
	IN_AutoCnd		:= _OutCvrFC280.IN_AutoCnd,
	IN_FrequencyMin	:= 0.0,
	IN_FrequencyMax	:= 100.0,
	IN_ManEn		:= TRUE,
	IN_MaskEn		:= TRUE,
	IN_Reset		:= AID.DataOut.Reset,
	IN_HMIAutoForce	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_QuickStopCmd	:= NOT OPS.DataOut.EnableDrive,
	IN_CoastingCmd	:= FALSE,
	IN_ScaleMax		:= 100.0,
	HMI_Danfoss		:= HMI_VFD_OutCvr,
	HMI_Motor		:= HMI_OutCvr,
	IO_DanfossFC280		:= IO_VFD_OutCvrFC280,
	IO_MotorFC280		:= IO_OutCvrFC280
	);

END_ACTION
