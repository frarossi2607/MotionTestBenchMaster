ACTION DOS_InstrFlow:

	//FSJ201
	FSJ[201](
	IN_ConfigPresent 	:= FSJ[201].IN_ConfigPresent,
	IN_Alarm 			:= VAR_DOS_SEQ.Device.FSJ201.ALR,
	IN_AlarmOnReq		:= VAR_DOS_SEQ.Device.FSJ201.WAIT_OFF, 
	IN_AlarmOffReq 		:= VAR_DOS_SEQ.Device.FSJ201.WAIT_ON,
	IN_SwitchDelay 		:= T#500ms,
	IN_WaitOn 			:= VAR_DOS_SEQ.Device.FSJ201.WAIT_ON,
	IN_WaitOff 			:= VAR_DOS_SEQ.Device.FSJ201.WAIT_OFF,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_FSJ[201],
	HMI 				:= HMI_FSJ[201]
	);
	
	//FSJ202
	FSJ[202](
	IN_ConfigPresent 	:= FSJ[202].IN_ConfigPresent,
	IN_Alarm 			:= VAR_DOS_SEQ.Device.FSJ202.ALR,
	IN_AlarmOnReq		:= VAR_DOS_SEQ.Device.FSJ202.WAIT_OFF, 
	IN_AlarmOffReq 		:= VAR_DOS_SEQ.Device.FSJ202.WAIT_ON, 
	IN_SwitchDelay 		:= T#500ms,
	IN_WaitOn 			:= VAR_DOS_SEQ.Device.FSJ202.WAIT_ON,
	IN_WaitOff 			:= VAR_DOS_SEQ.Device.FSJ202.WAIT_OFF,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_FSJ[202],
	HMI 				:= HMI_FSJ[202]
	);
END_ACTION
