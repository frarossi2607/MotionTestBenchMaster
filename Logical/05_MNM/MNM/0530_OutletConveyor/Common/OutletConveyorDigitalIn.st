ACTION OutletConveyorDigitalIn:
	_230DSE(
	IN_ConfigPresent	:= _230DSE.IN_ConfigPresent,
	IN_Reset			:= AID.DataOut.Reset,
	IN_MaskEn			:= FALSE,
	IN_WaitOn			:= TRUE,
	IN_AlarmOffReq		:= TRUE,
	IO					:= IO_230DSE,
	HMI					:= HMI_230DSE
	);

	_236DSE(
	IN_ConfigPresent	:= _236DSE.IN_ConfigPresent,
	IN_Reset			:= AID.DataOut.Reset,
	IN_MaskEn			:= FALSE,
	IN_WaitOn			:= TRUE,	
	IN_AlarmOffReq		:= TRUE,
	IO					:= IO_236DSE,
	HMI					:= HMI_236DSE
	);
END_ACTION
