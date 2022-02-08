ACTION RNS_PumpsPID:
	//PPB209 RINSER RECOVERY PUMP MANAGEMENT IN PROD	

	IF VAR_RNS_TankLevelTooLow THEN
		VAR_RNS_SEQ.Device.PPB209.IN_FixOutValue := 0.0;
	ELSE 
		IF NOT VAR_RNS_TankLevelMedium AND NOT VAR_RNS_TankLevelHigh THEN
			VAR_RNS_SEQ.Device.PPB209.IN_FixOutValue	:= HMI_PAM_1._116;
		ELSIF VAR_RNS_TankLevelMedium AND NOT VAR_RNS_TankLevelHigh THEN
			VAR_RNS_SEQ.Device.PPB209.IN_FixOutValue	:= HMI_PAM_1._117;
		ELSIF VAR_RNS_TankLevelMedium AND VAR_RNS_TankLevelHigh THEN	
			VAR_RNS_SEQ.Device.PPB209.IN_FixOutValue	:= HMI_PAM_1._118;
		END_IF	
	END_IF
	
	//Configurazione set point per funzionamento pompa
	HMI_CFG_PAM_1._116 := PPB[209].IN_ConfigPresent;
	HMI_CFG_PAM_1._117 := PPB[209].IN_ConfigPresent;
	HMI_CFG_PAM_1._118 := PPB[209].IN_ConfigPresent;

//	FB_PID_PPB209.IN_ConfigPresent	:= TNK.DataOut.ProdMode AND PTB[290].IN_ConfigPresent;
//	FB_PID_PPB209(
//		IN_ConfigPresent 	:= FB_PID_PPB209.IN_ConfigPresent, 
//		IN_ConfigEngValue 	:= TRUE, 
//		IN_Reverse 			:= FALSE, 
//		IN_Gain 			:= HMI_PAM_D1._085, 
//		IN_TI 				:= HMI_PAM_D1._086, 
//		IN_TD 				:= HMI_PAM_D1._087, 
//		IN_PV 				:= PPB[209].OUT_ActualSpeed, 
////		IN_Auto 			:= 0.0, 
////		IN_FixOut 			:= , 
//		IN_FixOutValue 		:= HMI_PAM_1._118, 
////		IN_IntHold 			:= , 
//		IN_AutoSP 			:= PTB[290].IN_ActualSP, 
////		IN_Disv 			:= , 
//		IN_MaxScale 		:= PTB[290].IN_ScaleHIGH, 
////		IN_Slew 			:= , 
////		IN_SPSlew 			:= , 
////		IN_MinDev 			:= , 
////		IN_MaxDev 			:= , 
//		IN_OutMin 			:= PPB[209].IN_FrequencyMin, 
//		IN_OutMax 			:= PPB[209].IN_FrequencyMax, 
//		IN_CycleTime 		:= t#200ms, 
//		IN_TIInit 			:= FALSE, 
//		IN_TIInitValue 		:= 0.0, 
//		HMI 				:= HMI_PID_PPB[209]
//	);

	
END_ACTION
