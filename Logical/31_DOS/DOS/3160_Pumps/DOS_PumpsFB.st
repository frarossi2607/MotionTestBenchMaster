ACTION DOS_PumpsFB:
	
//PPJ201
	PPJ[201](
	IN_Simulation 		:= FALSE,
	IN_ConfigPresent 	:= PPJ[201].IN_ConfigPresent,
	IN_Enable 			:= PPJ[201].IN_Enable,
	IN_AutoCnd 			:= PPJ[201].IN_AutoCnd,
	IN_AutoSpeed 		:= PPJ[201].IN_AutoSpeed,
	IN_Reverse 			:= FALSE,
	IN_FrequencyMin 	:= 0.0,
	IN_FrequencyMax 	:= 100.0,
	IN_ManEn 			:= TRUE,
	IN_MaskEn 			:= TRUE,
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_QuickStopCmd		:= NOT IO_PPJ[201].DI_SafetyEnable,
	IN_JOGMode 			:= FALSE,
	IN_JOGCnd 			:= FALSE,
	IN_CoastingCmd 		:= NOT OPS.DataOut.EnablePump,
	IN_FBKDelay 		:= T#1000MS,
	IN_SafetyCtrlEn 	:= FALSE,
	IN_ScaleMax 		:= 100.0,
	HMI_Danfoss 		:= HMI_VFD_PPJ[201],
	HMI_Motor 			:= HMI_PPJ[201],
	IO_DanfossFC280			:= IO_VFD_PPJ[201],
	IO_MotorFC280			:= IO_PPJ[201]
	);

//PPJ202
	PPJ[202](
	IN_Simulation 		:= FALSE,
	IN_ConfigPresent 	:= PPJ[202].IN_ConfigPresent,
	IN_Enable 			:= PPJ[202].IN_Enable,
	IN_AutoCnd 			:= PPJ[202].IN_AutoCnd,
	IN_AutoSpeed 		:= PPJ[202].IN_AutoSpeed,
	IN_Reverse 			:= FALSE,
	IN_FrequencyMin 	:= 0.0,
	IN_FrequencyMax 	:= 60.0,
	IN_ManEn 			:= TRUE,
	IN_MaskEn 			:= TRUE,
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_QuickStopCmd		:= NOT IO_PPJ[202].DI_SafetyEnable,
	IN_JOGMode 			:= FALSE,
	IN_JOGCnd 			:= FALSE,
	IN_CoastingCmd 		:= NOT OPS.DataOut.EnablePump,
	IN_FBKDelay 		:= T#1000MS,
	IN_SafetyCtrlEn 	:= FALSE,
	IN_ScaleMax 		:= 100.0,
	HMI_Danfoss 		:= HMI_VFD_PPJ[202],
	HMI_Motor 			:= HMI_PPJ[202],
	IO_DanfossFC280 			:= IO_VFD_PPJ[202],
	IO_MotorFC280			:= IO_PPJ[202]
	);

//PPJ203
	PPJ203(
	IN_ConfigPresent 	:= PPJ203.IN_ConfigPresent,
	IN_Enable 			:= PPJ203.IN_Enable,
	IN_AutoCnd 			:= PPJ203.IN_AutoCnd,
	IN_AutoVal 			:= PPJ203.IN_AutoVal, 
	IN_OpeningRampEn 	:= FALSE, 
	IN_OpeningRampValue := 0.0, 
	IN_ClosingRampEn 	:= OPS.DataOut.EmergencyOk AND OPS.DataOut.DoorsOk, 
	IN_ClosingRampValue := 10.0, 
	IN_OutMin 			:= HMI_PAM_A1._400, 
	IN_OutMax 			:= HMI_PAM_A1._401,  //6 bar
	IN_ManEn 			:= NOT PPJ203.IN_HMIAutoForce,
	IN_MaskEn 			:= TRUE,
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	HMI 				:= HMI_PPJ203,
	IO		 			:= IO_PPJ203
	);
	
	PPJ203_AuxScale( //SENTRONIC Conversion from EngValue to %
	x	:= PPJ203.OUT_Cv,
	x1	:= 0.0,
	y1	:= 6553.4,
	x2	:= 6, //bar
	y2	:= 32767.0,
	); 
	
	IO_PPJ203.AO_Raw := REAL_TO_INT(PPJ203_AuxScale.y); 
END_ACTION
