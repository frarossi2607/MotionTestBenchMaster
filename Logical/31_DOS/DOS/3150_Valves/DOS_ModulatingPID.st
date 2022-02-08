ACTION DOS_ModulatingPID:
//RVJ201
	VAR_DOS_RVJ201Auto	:= NOT HMI_RVJ[201].ManOff AND NOT HMI_RVJ[201].ManOn;
	
	FB_PID_RVJ201[PID_MODE_PRD].IN_ConfigPresent	:= RVJ[201].IN_ConfigPresent;
	FB_PID_RVJ201[PID_MODE_PRD].IN_FixOut			:= RVJ[201].IN_Enable AND NOT VAR_DOS_SEQ.Device.RVJ201_PID.PID_Mode AND VAR_DOS_RVJ201Auto;
	FB_PID_RVJ201[PID_MODE_PRD].IN_Auto				:= RVJ[201].IN_Enable AND VAR_DOS_SEQ.Device.RVJ201_PID.PID_Mode AND VAR_DOS_RVJ201Auto;
	
	FB_PID_RVJ201[PID_MODE_PRD](
	IN_ConfigPresent	:= FB_PID_RVJ201[PID_MODE_PRD].IN_ConfigPresent,
	IN_Reverse 			:= TRUE,
	IN_Gain 			:= 2.0,//CREA PAM
	IN_TI 				:= 1.0,
	IN_TD 				:= 0.0,
	IN_PV 				:= LTJ[203].OUT_ActValue,
	IN_Auto				:= VAR_DOS_SEQ.Device.RVJ201_PID.PID_Enable AND FB_PID_RVJ201[PID_MODE_PRD].IN_Auto ,
	IN_FixOut			:= VAR_DOS_SEQ.Device.RVJ201_PID.PID_Enable AND FB_PID_RVJ201[PID_MODE_PRD].IN_FixOut,
	IN_FixOutValue 		:= VAR_DOS_SEQ.Device.RVJ201_PID.FIX_Value,
	IN_IntHold 			:= FALSE,
	IN_AutoSP 			:= VAR_DOS_SEQ.Device.RVJ201_PID.Auto_SP_Value,
	IN_Disv 			:= 0.0,
	IN_Slew 			:= FALSE,
	IN_SPSlew 			:= 0.0,
	IN_MaxScale			:= RVJ[201].IN_OutMax,
	IN_MinDev			:= 1.0,//PAM
	IN_MaxDev			:= 1.0,
	IN_OutMin 			:= RVJ[201].IN_OutMin,
	IN_OutMax 			:= RVJ[201].IN_OutMax,
	IN_CycleTime 		:= T#200ms,
	IN_TIInit 			:= FALSE,
	IN_TIInitValue 		:= 0.0,
	HMI 				:= HMI_PID_RVJ[201].Mode[PID_MODE_PRD]
	);
END_ACTION
