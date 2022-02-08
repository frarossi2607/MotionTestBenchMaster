ACTION DOS_InstrPress: 
	_210PTF(
	IN_ConfigPresent 	:= _210PTF.IN_ConfigPresent,
	IN_Alarm 			:= TRUE,		  
	IN_MaskEn 			:= TRUE,
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IO 					:= IO_210PTF, 
	HMI 				:= HMI_210PTF
	);
	
	//_210PTF ALR
	VAR_DOS_NoBotNoFillPressureLow		:= NOT IO_210PTF.DI_Input; //_210PTF.OUT
	VAR_DOS_NoBotNoFillPressureFault	:= _210PTF.OUT_Alarm;
END_ACTION