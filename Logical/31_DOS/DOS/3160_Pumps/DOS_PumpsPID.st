ACTION DOS_PumpsPID:
//PPJ202 MANAGEMENT IN CIP 
	FB_PID_PPJ202[PID_MODE_CIP].IN_ConfigPresent	:= PPJ[202].IN_ConfigPresent;
	FB_PID_PPJ202[PID_MODE_CIP].IN_Auto				:= FB_PID_PPJ202[PID_MODE_CIP].IN_ConfigPresent AND VAR_DOS_SEQ.Device.PPJ202_PID.PID_Enable AND NOT PPJ[202].OUT_DriveFault;
	FB_PID_PPJ202[PID_MODE_CIP].IN_FixOut			:= FB_PID_PPJ202[PID_MODE_CIP].IN_Auto AND NOT VAR_DOS_SEQ.Device.PPJ202_PID.PID_Mode;
	FB_PID_PPJ202[PID_MODE_CIP].IN_Auto				:= FB_PID_PPJ202[PID_MODE_CIP].IN_Auto AND VAR_DOS_SEQ.Device.PPJ202_PID.PID_Mode;
	FB_PID_PPJ202[PID_MODE_CIP].IN_PV				:= LTJ[203].OUT_ActValue;
	
	FB_PID_PPJ202[PID_MODE_CIP](
	IN_ConfigPresent	:= FB_PID_PPJ202[PID_MODE_CIP].IN_ConfigPresent,
	IN_Reverse 			:= FALSE,
	IN_Gain 			:= HMI_PAM_D1._616,
	IN_TI 				:= HMI_PAM_D1._617,
	IN_TD 				:= HMI_PAM_D1._618,
	IN_PV 				:= FB_PID_PPJ202[PID_MODE_CIP].IN_PV,
	IN_Auto				:= FB_PID_PPJ202[PID_MODE_CIP].IN_Auto,
	IN_FixOut			:= FB_PID_PPJ202[PID_MODE_CIP].IN_FixOut,
	IN_FixOutValue 		:= VAR_DOS_SEQ.Device.PPJ202_PID.FIX_Value,
	IN_IntHold 			:= FALSE,
	IN_AutoSP 			:= VAR_DOS_SEQ.Device.PPJ202_PID.Auto_SP_Value,
	IN_Disv 			:= 0.0, // A RICETTA
	IN_Slew 			:= HMI_PAM_D1._613>0.0,
	IN_SPSlew 			:= HMI_PAM_D1._613,
	IN_MaxScale			:= PPJ[202].IN_ScaleMax,
	IN_MinDev			:= HMI_PAM_D1._611,
	IN_MaxDev			:= HMI_PAM_D1._612,
	IN_OutMin 			:= PPJ[202].IN_FrequencyMin,
	IN_OutMax 			:= PPJ[202].IN_FrequencyMax,
	IN_CycleTime 		:= T#200ms,
	IN_TIInit 			:= FALSE,
	IN_TIInitValue 		:= 0.0,
	HMI 				:= HMI_PID_PPJ[202].Mode[PID_MODE_CIP]
	);
END_ACTION
