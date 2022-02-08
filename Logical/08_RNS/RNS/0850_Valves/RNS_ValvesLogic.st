ACTION RNS_ValvesLogic:
	TOF_StatusMachineRunning.IN	:= SEL(MC_InputOutput.Network.Machine.Status.MultiModalityActive, MC_InputOutput.Network.Machine.Status.MachineRunning, MC_InputOutput.Network.Filler.Status.ModuleRunning);
	TOF_StatusMachineRunning.PT := t#10s;
	TOF_StatusMachineRunning();
	
	VAR_RNS_ValveEnable 	:= OPS.DataOut.EmergencyOk; 
	VAR_RNS_ValveEnableCip 	:= OPS.DataOut.EmergencyOk AND OPS.DataOut.DoorsOk;
	
	//AVB224 RINSER DISCHARGE
	AVB[224].IN_Enable		:= VAR_RNS_ValveEnable;
	AVB[224].IN_AutoCnd		:= VAR_RNS_SEQ.Device.AVB224.AutoCnd;	
	AVB[224].IN_EnableCnd	:= VAR_RNS_SEQ.Device.AVB224.EnableCnd;
	AVB[224].IN_Cnd 		:= NOT VAR_RNS_WaterTreatment;
	AVB[224].IN_ManEn		:= TRUE;
	AVB[224].IN_MaskEn		:= TRUE;
	
	//AVB228 RINSER DISCHARGE
	AVB[228].IN_Enable		:= VAR_RNS_ValveEnable;
	AVB[228].IN_AutoCnd		:= VAR_RNS_SEQ.Device.AVB228.AutoCnd OR TOF_StatusMachineRunning.Q;//vrma
	AVB[228].IN_EnableCnd	:= VAR_RNS_SEQ.Device.AVB228.EnableCnd;
	AVB[228].IN_Cnd 		:= MNM.DataOut.MachineRunning;//vrma
	AVB[228].IN_ManEn		:= TRUE;
	AVB[228].IN_MaskEn		:= TRUE;	

	//AVB234 TWISTER DISCHARGE
	AVB[234].IN_Enable      := VAR_RNS_ValveEnable;
	AVB[234].IN_AutoCnd     := VAR_RNS_SEQ.Device.AVB234.AutoCnd;//vrma
	AVB[234].IN_EnableCnd   := VAR_RNS_SEQ.Device.AVB234.EnableCnd;
	AVB[234].IN_Cnd         := FALSE;
	AVB[234].IN_ManEn       := TRUE;
	AVB[234].IN_MaskEn      := TRUE;
	
	//AVB261 H2O RINSING VALVE
	AVB[261].IN_Enable		:= VAR_RNS_ValveEnable;
	AVB[261].IN_AutoCnd		:= VAR_RNS_SEQ.Device.AVB261.AutoCnd;	
	AVB[261].IN_EnableCnd	:= VAR_RNS_SEQ.Device.AVB261.EnableCnd;
	AVB[261].IN_Cnd 		:= MNM.DataOut.MachineRunning;//vrma
	AVB[261].IN_ManEn		:= TRUE;
	AVB[261].IN_MaskEn		:= TRUE;
	
	//AVB264 RINSING CIP VALVE //V4.A.A.1.7.0
	AVB[264].IN_Enable		:= VAR_RNS_ValveEnableCip AND (TNK.DataOut.ProdMode OR TNK.DataOut.Wait);
	AVB[264].IN_AutoCnd		:= VAR_RNS_SEQ.Device.AVB264.AutoCnd;	
	AVB[264].IN_EnableCnd	:= VAR_RNS_SEQ.Device.AVB264.EnableCnd;
	AVB[264].IN_Cnd 		:= VAR_RNS_WaterTreatment AND NOT VAR_RNS_CleaningActive;
	AVB[264].IN_ManEn		:= TRUE;
	AVB[264].IN_MaskEn		:= TRUE;
	
	//AVB265 RINSING CIP VALVE //V4.A.A.1.7.0
	AVB[265].IN_Enable		:= VAR_RNS_ValveEnableCip;
	AVB[265].IN_AutoCnd		:= VAR_RNS_SEQ.Device.AVB265.AutoCnd;	
	AVB[265].IN_EnableCnd	:= VAR_RNS_SEQ.Device.AVB265.EnableCnd;
	AVB[265].IN_Cnd 		:= VAR_RNS_WaterTreatment;
	AVB[265].IN_ManEn		:= TRUE;
	AVB[265].IN_MaskEn		:= TRUE;
	
	//AVB265 RINSING CIP VALVE //V4.A.A.1.7.0
	AVB[266].IN_Enable		:= VAR_RNS_ValveEnableCip;
	AVB[266].IN_AutoCnd		:= VAR_RNS_SEQ.Device.AVB266.AutoCnd OR TOF_StatusMachineRunning.Q;//vrma	
	AVB[266].IN_EnableCnd	:= VAR_RNS_SEQ.Device.AVB266.EnableCnd;
	AVB[266].IN_Cnd 		:= FALSE;
	AVB[266].IN_ManEn		:= TRUE;
	AVB[266].IN_MaskEn		:= TRUE;
	
	//AVB267 CIP DRAIN v1.4
	AVB[267].IN_Enable		:= VAR_RNS_ValveEnable;
	AVB[267].IN_AutoCnd		:= VAR_RNS_SEQ.Device.AVB267.AutoCnd;	
	AVB[267].IN_EnableCnd	:= VAR_RNS_SEQ.Device.AVB267.EnableCnd;
	AVB[267].IN_Cnd 		:= FALSE;
	AVB[267].IN_ManEn		:= TRUE;
	AVB[267].IN_MaskEn		:= TRUE;
	
	//AVB268 COP/CIP DRAIN v1.4
	AVB[268].IN_Enable		:= VAR_RNS_ValveEnable;
	AVB[268].IN_AutoCnd		:= VAR_RNS_SEQ.Device.AVB268.AutoCnd;	
	AVB[268].IN_EnableCnd	:= VAR_RNS_SEQ.Device.AVB268.EnableCnd;
	AVB[268].IN_Cnd 		:= FALSE;
	AVB[268].IN_ManEn		:= TRUE;
	AVB[268].IN_MaskEn		:= TRUE;
	
	//AVB273 AIR RINSING VALVE
	AVB[273].IN_Enable		:= VAR_RNS_ValveEnable;
	AVB[273].IN_AutoCnd		:= VAR_RNS_SEQ.Device.AVB273.AutoCnd;	
	AVB[273].IN_EnableCnd	:= VAR_RNS_SEQ.Device.AVB273.EnableCnd;
	AVB[273].IN_Cnd 		:= VAR_RNS_AirTreatment;
	AVB[273].IN_ManEn		:= TRUE;
	AVB[273].IN_MaskEn		:= TRUE;
	
	//DYNAMIC COMMAND	
	TMR_TON_FlipWait.IN	:= VAR_RNS_StepCipCleaning AND NOT TMR_TOF_FlipWork.Q AND NOT (LTB[202].OUT_ActValue >70.0);
	TMR_TON_FlipWait.PT	:= REAL_TO_TIME(60.0*1000); //[ms]*1000
	TMR_TON_FlipWait();
	
	TMR_TOF_FlipWork.IN := TMR_TON_FlipWait.Q;
	TMR_TOF_FlipWork.PT := REAL_TO_TIME(4.0*1000); //[ms]*1000
	TMR_TOF_FlipWork();
	
	//AVB294
	IF VAR_RNS_ModeProduction THEN//vrma
		IF LTB[202].OUT_ActValue >70.0 THEN
			AVB[294].IN_AutoCnd := FALSE;
		ELSIF LTB[202].OUT_ActValue < 20.0 THEN
			AVB[294].IN_AutoCnd	:= TRUE;
		END_IF
	ELSIF VAR_RNS_ModeCip THEN //FACCIAMO FLIP
		AVB[294].IN_AutoCnd := TMR_TOF_FlipWork.Q;
	ELSE
		AVB[294].IN_AutoCnd := FALSE;
	END_IF

	AVB[294].IN_Enable		:= VAR_RNS_ValveEnable;
	AVB[294].IN_AutoCnd		:= FALSE; // leo AVB[294].IN_AutoCnd;	
	AVB[294].IN_EnableCnd	:= FALSE;
	AVB[294].IN_Cnd 		:= VAR_RNS_AirTreatment;
	AVB[294].IN_ManEn		:= TRUE;
	AVB[294].IN_MaskEn		:= TRUE;
	
END_ACTION
