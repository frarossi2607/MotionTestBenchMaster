ACTION DOS_PumpsLogic:

	VAR_DOS_PumpEnable := OPS.DataOut.EmergencyOk AND OPS.DataOut.EnablePump(*AND ARIA OK ???*); 
	
	//PPJ201
	PPJ[201].IN_Enable 			:= VAR_DOS_PumpEnable;
	PPJ[201].IN_AutoCnd 		:= VAR_DOS_SEQ.Device.PPJ201_PID.PID_Enable;	
	PPJ[201].IN_AutoSpeed 		:= 5.0;

	//PPJ202
	PPJ[202].IN_Enable 			:= VAR_DOS_PumpEnable;
	PPJ[202].IN_AutoCnd 		:= VAR_DOS_SEQ.Device.PPJ202_PID.PID_Enable OR PstFlr.CipReturnEnabled; //segnali di CIP recovery RMA FILIPPO
	PPJ[202].IN_AutoSpeed 		:= VAR_DOS_SEQ.Device.PPJ202_PID.FIX_Value;

	//DYNAMIC COMMAND	
	TMR_TOF_FlipWork[1].IN := TMR_TON_FlipWait[1].Q;
	IF VAR_DOS_StepProdHeating THEN
		TMR_TOF_FlipWork[1].PT	:= REAL_TO_TIME((HMI_PAM_3._611)*1000); //[ms] * 1000
	ELSIF (VAR_DOS_StepCipCleaning OR VAR_DOS_StepRinseReq) THEN 
		TMR_TOF_FlipWork[1].PT	:= REAL_TO_TIME((HMI_PAM_3._634)*1000);
	END_IF
	TMR_TOF_FlipWork[1]();
	
	TMR_TON_FlipWait[1].IN	:= (VAR_DOS_StepProdHeating OR VAR_DOS_StepCipCleaning OR VAR_DOS_StepRinseReq) AND NOT TMR_TOF_FlipWork[1].Q;
	IF VAR_DOS_StepProdHeating THEN 
		TMR_TON_FlipWait[1].PT	:= REAL_TO_TIME((HMI_PAM_3._612)*1000); 
	ELSIF (VAR_DOS_StepCipCleaning OR VAR_DOS_StepRinseReq) THEN
		TMR_TON_FlipWait[1].PT	:= REAL_TO_TIME((HMI_PAM_3._635)*1000);
	END_IF
	TMR_TON_FlipWait[1]();
	
	//PPJ203 
	PPJ203.IN_Enable 			:= VAR_DOS_PumpEnable;
	PPJ203.IN_AutoCnd 			:= TMR_TOF_FlipWork[1].Q OR VAR_DOS_StepProdRecovery; //PNEUMATIC PUMP --> PRODUCT RECOVERY
	PPJ203.IN_AutoVal			:= 2.0;
END_ACTION
