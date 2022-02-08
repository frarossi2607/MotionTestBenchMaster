ACTION RNS_InstrSaf: 
//Rinser Released Pairs Safety
	_202DSB(
	IN_ConfigPresent 	:= FSB[201].IN_ConfigPresent,
	IN_Alarm 			:= TRUE,
	IN_AlarmOnReq		:= FALSE,
	IN_AlarmOffReq 		:= TRUE,
	IN_SwitchDelay 		:= T#1ms,
	IN_WaitOn 			:= TRUE,
	IN_WaitOff 			:= FALSE,
	IN_Reset	 		:= VAR_RNS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_202DSB,
	HMI 				:= HMI_202DSB
	);
END_ACTION