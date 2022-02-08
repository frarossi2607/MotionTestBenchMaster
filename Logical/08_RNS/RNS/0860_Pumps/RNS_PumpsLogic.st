ACTION RNS_PumpsLogic:
	VAR_RNS_PumpEnable 					:= OPS.DataOut.EmergencyOk; 
	VAR_RNS_SEQ.Device.PPB209.IN_FixOut	:= (VAR_RNS_FMDProduction OR VAR_RNS_FMDControl) AND PPB[209].IN_ConfigPresent;//vrma	
										   //(VAR_RNS_FMDProduction OR VAR_RNS_FMDCip OR VAR_RNS_FMDControl) AND PPB[209].IN_ConfigPresent;//vrma
	
//	VAR_SetReset(
//	SET1 	:= LSB[210].OUT_OnDelayed AND LSB[299].OUT_OnDelayed,
//	RESET 	:= NOT LSB[210].OUT_OnDelayed);

	VAR_SetReset(
	SET1 	:= LTB[202].OUT_ActValue > 10.0,
	RESET 	:= LTB[202].OUT_ActValue < 5.0);
	
	
//PPB209 RINSER RECOVERY PUMP
	PPB[209].IN_Enable 			:= VAR_RNS_PumpEnable;
	PPB[209].IN_AutoCnd 		:= PPB[209].IN_Enable AND VAR_RNS_SEQ.Device.PPB209.IN_FixOut AND VAR_SetReset.Q1;
	PPB[209].IN_AutoSpeed 		:= VAR_RNS_SEQ.Device.PPB209.IN_FixOutValue;
	//	PPB[209].IN_CoastingCmd		:= NOT OPS.DataOut.EnablePump;
END_ACTION
