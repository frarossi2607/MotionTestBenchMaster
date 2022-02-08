ACTION DOS_ValvesLogic:

	VAR_DOS_ValveEnable := OPS.DataOut.EmergencyOk AND OPS.DataOut.GeneralAirOn AND OPS.DataOut.DoorsOk; 

//AVJ201
	AVJ[201].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[201].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ201.AutoCnd;	
	AVJ[201].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ201.EnableCnd;
	AVJ[201].IN_Cnd 		:= (NOT LTJ[203].OUT_SpReached AND PstFlr.ProductAvailable AND VAR_DOS_StepProdProducing) OR
	                           (NOT LTJ[203].OUT_SpReached AND PstFlr.HeatingWithWater AND VAR_DOS_StepProdHeating) OR
                               (NOT LTJ[203].OUT_SpReached AND VAR_DOS_StepCipCleaning) OR
								(NOT LTJ[203].OUT_SpReached AND VAR_DOS_StepRinseReq) OR 
								(NOT LTJ[203].OUT_SpReached AND VAR_DOS_SEQ_Step.StepActual = 46 AND  PstFlr.ProductAvailable); //46 
	AVJ[201].IN_ManEn		:= TRUE;
	AVJ[201].IN_MaskEn		:= TRUE;
	
//AVJ210
	AVJ[210].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[210].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ210.AutoCnd;	
	AVJ[210].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ210.EnableCnd;
	AVJ[210].IN_Cnd 		:= FALSE;
	AVJ[210].IN_ManEn		:= TRUE;
	AVJ[210].IN_MaskEn		:= TRUE;
	
//AVJ211
	AVJ[211].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[211].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ211.AutoCnd;	
	AVJ[211].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ211.EnableCnd;
	AVJ[211].IN_Cnd 		:= NOT LTJ[203].OUT_HighLimit;
	AVJ[211].IN_ManEn		:= TRUE;
	AVJ[211].IN_MaskEn		:= TRUE;
	
//AVJ212
	AVJ[212].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[212].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ212.AutoCnd;	
	AVJ[212].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ212.EnableCnd;
	AVJ[212].IN_Cnd 		:= NOT LTJ[203].OUT_HighLimit;
	AVJ[212].IN_ManEn		:= TRUE;
	AVJ[212].IN_MaskEn		:= TRUE;
	
//AVJ215
	AVJ[215].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[215].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ215.AutoCnd;	
	AVJ[215].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ215.EnableCnd;
	AVJ[215].IN_Cnd 		:= FALSE;
	AVJ[215].IN_ManEn		:= TRUE;
	AVJ[215].IN_MaskEn		:= TRUE;
	
//AVJ216
	AVJ[216].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[216].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ216.AutoCnd OR COP.DataOut.RcpActive ;	
	AVJ[216].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ216.EnableCnd;
	AVJ[216].IN_Cnd 		:= FALSE;
	AVJ[216].IN_ManEn		:= TRUE;
	AVJ[216].IN_MaskEn		:= TRUE;

	//DYNAMIC COMMAND	
	TMR_TON_FlipWait[0].IN	:= VAR_DOS_SEQ.Device.AVJ217.EnableCnd AND NOT TMR_TOF_FlipWork[0].Q;
	IF VAR_DOS_StepProdHeating THEN
		TMR_TON_FlipWait[0].PT	:= REAL_TO_TIME((HMI_PAM_3._614)*1000);
	ELSIF (VAR_DOS_StepCipCleaning OR VAR_DOS_StepRinseReq) THEN
		TMR_TON_FlipWait[0].PT	:= REAL_TO_TIME((HMI_PAM_3._637)*1000);
	END_IF
	TMR_TON_FlipWait[0]();
	
	TMR_TOF_FlipWork[0].IN := TMR_TON_FlipWait[0].Q;
	IF VAR_DOS_StepProdHeating THEN
		TMR_TOF_FlipWork[0].PT := REAL_TO_TIME((HMI_PAM_3._613)*1000); //[ms]*1000
	ELSIF (VAR_DOS_StepCipCleaning OR VAR_DOS_StepRinseReq) THEN
		TMR_TOF_FlipWork[0].PT := REAL_TO_TIME((HMI_PAM_3._636)*1000);
	END_IF
	TMR_TOF_FlipWork[0]();
	
	//AVJ217
	AVJ[217].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[217].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ217.AutoCnd;	
	AVJ[217].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ217.EnableCnd;
	AVJ[217].IN_Cnd 		:= TMR_TOF_FlipWork[0].Q;
	AVJ[217].IN_FlipEnable	:= FALSE;
	AVJ[217].IN_FlipRequest	:= FALSE;
	AVJ[217].IN_FlipTime	:= t#1s;
	AVJ[217].IN_ManEn		:= TRUE;
	AVJ[217].IN_MaskEn		:= TRUE;
	
//AVJ218
	AVJ[218].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[218].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ218.AutoCnd;	
	AVJ[218].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ218.EnableCnd;
	AVJ[218].IN_Cnd 		:= PPJ203.OUT_Cv > 0.2;
	AVJ[218].IN_ManEn		:= TRUE;
	AVJ[218].IN_MaskEn		:= TRUE;

//AVJ221
	AVJ[221].IN_Enable		:= TRUE;
	AVJ[221].IN_AutoCnd		:= NOT VAR_DOS_SEQ.Device.AVJ221.AutoCnd;	//NORMALLY OPEN - Sequencer managed as normally closed
	AVJ[221].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ221.EnableCnd;
	AVJ[221].IN_Cnd 		:= VAR_DOS_InletOpen OR AVJ[210].OUT_OpenedFiltered OR AVJ[211].OUT_OpenedFiltered;
	AVJ[221].IN_ManEn		:= TRUE;
	AVJ[221].IN_MaskEn		:= TRUE;
	
//AVJ230
	AVJ[230].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[230].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ230.AutoCnd;	
	AVJ[230].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ230.EnableCnd;
	AVJ[230].IN_Cnd 		:= NOT LSJ200H.OUT;
	AVJ[230].IN_ManEn		:= TRUE;
	AVJ[230].IN_MaskEn		:= TRUE;
	
//AVJ231
	AVJ[231].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[231].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ231.AutoCnd;	
	AVJ[231].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ231.EnableCnd;
	AVJ[231].IN_Cnd 		:= FALSE;
	AVJ[231].IN_ManEn		:= TRUE;
	AVJ[231].IN_MaskEn		:= TRUE;

//AVJ232
	AVJ[232].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[232].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ232.AutoCnd OR COP.DataOut.RcpActive ;	
	AVJ[232].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ232.EnableCnd;
	AVJ[232].IN_Cnd 		:= FALSE;
	AVJ[232].IN_ManEn		:= TRUE;
	AVJ[232].IN_MaskEn		:= TRUE;

//AVJ233
	AVJ[233].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[233].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ233.AutoCnd OR PstFlr.CipReturnEnabled;	
	AVJ[233].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ233.EnableCnd;
	AVJ[233].IN_Cnd 		:= FALSE;
	AVJ[233].IN_ManEn		:= TRUE;
	AVJ[233].IN_MaskEn		:= TRUE;

//AVJ234
	AVJ[234].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[234].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ234.AutoCnd;	
	AVJ[234].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ234.EnableCnd;
	AVJ[234].IN_Cnd 		:= FALSE;
	AVJ[234].IN_ManEn		:= TRUE;
	AVJ[234].IN_MaskEn		:= TRUE;

//AVJ235
	AVJ[235].IN_Enable		:= VAR_DOS_ValveEnable;
	AVJ[235].IN_AutoCnd		:= VAR_DOS_SEQ.Device.AVJ235.AutoCnd;	
	AVJ[235].IN_EnableCnd	:= VAR_DOS_SEQ.Device.AVJ235.EnableCnd;
	AVJ[235].IN_Cnd 		:= FALSE;
	AVJ[235].IN_ManEn		:= TRUE;
	AVJ[235].IN_MaskEn		:= TRUE;

	//RVJ201
	RVJ[201].IN_Enable			:= VAR_DOS_ValveEnable;
	RVJ[201].IN_AutoCnd			:= RVJ[201].IN_Enable;
	//RVJ[201].IN_AutoVal 	:= FB_PID_RVJ201.OUT; //v1.0 : SEE TNK_ValvesFB.st
	RVJ[201].IN_MaskEn			:= RVJ[201].IN_ConfigPositionAnalogFBK;

	//PDO_YV65 FILIPPO TO DELETE
	PDO_YV65.IN_ConfigPresent := TRUE;
	PDO_YV65.IN_Enable		:= VAR_DOS_ValveEnable AND VAR_DOS_PumpEnable; 
	PDO_YV65.IN_AutoCnd		:= PPJ203.IN_Enable AND VAR_DOS_SEQ.Device.PPJ203_PID.PID_Enable;	
	PDO_YV65.IN_EnableCnd	:= FALSE;
	PDO_YV65.IN_Cnd 		:= FALSE;
	PDO_YV65.IN_ManEn		:= TRUE;
	PDO_YV65.IN_MaskEn		:= TRUE;
	
	//PDO_YV5 _211CPF
	_211CPF.IN_Enable		:= VAR_DOS_ValveEnable AND VAR_DOS_ModeCop;	
	_211CPF.IN_EnableCnd	:= FALSE;
	_211CPF.IN_Cnd 			:= FALSE;
	_211CPF.IN_ManEn		:= FALSE;
	_211CPF.IN_MaskEn		:= FALSE;
	
END_ACTION
