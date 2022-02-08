ACTION DOS_InstrVolume:
	//FILIPPO
	
	_205MEF(
	IN_ConfigPresent	:= _205MEF.IN_ConfigPresent,
	IN_Reset			:= AID.DataOut.Reset,
	IN_ActualSP			:= _205MEF.IN_ActualSP,
	IN_Delta			:= Delta_205MEF,
	IO					:= IO_205MEF,
	HMI					:= HMI_205MEF
	);
	
	_206MEF(
	IN_ConfigPresent	:= _206MEF.IN_ConfigPresent,
	IN_Reset			:= AID.DataOut.Reset,
	IN_ActualSP			:= _206MEF.IN_ActualSP,
	IN_Delta			:= Delta_206MEF,
	IO					:= IO_206MEF,
	HMI					:= HMI_206MEF
	);
	
	
	_212DSF( //MAX VOLUME
		IN_ConfigPresent 	:= _212DSF.IN_ConfigPresent,
		IN_OnDelay			:= T#1s,
		IN_OffDelay			:= T#1s,
		IN_SwitchDelay		:= T#1s,
		IN_Reset	 		:= VAR_DOS_PBResetEp,
		IN_MaskEn 			:= TRUE,
		IO 					:= IO_212DSF,
		HMI 				:= HMI_212DSF
		);
	
	_213DSF( //MIN VOLUME
		IN_ConfigPresent 	:= _213DSF.IN_ConfigPresent,
		IN_OnDelay			:= T#1s,
		IN_OffDelay			:= T#1s,
		IN_SwitchDelay		:= T#1s,
		IN_Reset	 		:= VAR_DOS_PBResetEp,
		IN_MaskEn 			:= TRUE,
		IO 					:= IO_213DSF,
		HMI 				:= HMI_213DSF
		);

	_212DSF.IN_WaitOn	:= VAR_DOS_LiftMMF205SeqMem.Sensor.SensorMaxVolWaitOn;
	_212DSF.IN_WaitOff	:= VAR_DOS_LiftMMF205SeqMem.Sensor.SensorMaxVolWaitOff;
	_213DSF.IN_WaitOn	:= VAR_DOS_LiftMMF205SeqMem.Sensor.SensorLowPosWaitOn;
	_213DSF.IN_WaitOff	:= VAR_DOS_LiftMMF205SeqMem.Sensor.SensorHighPosWaitOff;

END_ACTION
