ACTION DOS_InstrPosition:
//HDP UP Limit M5
	_215DSF( 
	IN_ConfigPresent 	:= _215DSF.IN_ConfigPresent,
	IN_OnDelay			:= T#1s,
	IN_OffDelay			:= T#1s,
	IN_SwitchDelay		:= T#1s,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_215DSF,
	HMI 				:= HMI_215DSF
	);
	
	//LDP UP Limit M6
	_216DSF( 
	IN_ConfigPresent 	:= _216DSF.IN_ConfigPresent,
	IN_OnDelay			:= T#1s,
	IN_OffDelay			:= T#1s,
	IN_SwitchDelay		:= T#1s,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_216DSF,
	HMI 				:= HMI_216DSF
	);

	//LDP DOWN Limit M6
	_217DSF( 
	IN_ConfigPresent 	:= _217DSF.IN_ConfigPresent,
	IN_OnDelay			:= T#1s,
	IN_OffDelay			:= T#1s,
	IN_SwitchDelay		:= T#1s,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_217DSF,
	HMI 				:= HMI_217DSF
	);
	
	_210DSX( //ARM In Cleaning Pos
	IN_ConfigPresent 	:= _210DSX.IN_ConfigPresent,
	IN_Alarm 			:= TRUE, 
	IN_AlarmOnReq		:= _210DSX.IN_WaitOff,	
	IN_AlarmOffReq 		:= _210DSX.IN_WaitOn,
	IN_OnDelay			:= T#2s,
	IN_OffDelay			:= T#2s,
	IN_SwitchDelay		:= T#100ms,
	IN_WaitOn 			:= DOS.DataOut.CopMode, 
	IN_WaitOff 			:= NOT DOS.DataOut.CopMode,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_210DSX,
	HMI 				:= HMI_210DSX
	);
	
	_211DSX( //ARM In Production Pos
	IN_ConfigPresent 	:= _211DSX.IN_ConfigPresent,
	IN_Alarm 			:= TRUE, 
	IN_AlarmOnReq		:= _211DSX.IN_WaitOff,	
	IN_AlarmOffReq 		:= _211DSX.IN_WaitOn,
	IN_OnDelay			:= T#2s,
	IN_OffDelay			:= T#2s,
	IN_SwitchDelay		:= T#100ms,
	IN_WaitOn 			:= NOT DOS.DataOut.CopMode, 
	IN_WaitOff 			:= DOS.DataOut.CopMode,
	IN_Reset	 		:= VAR_DOS_PBResetEp,
	IN_MaskEn 			:= TRUE,
	IO 					:= IO_211DSX,
	HMI 				:= HMI_211DSX
	);

	VAR_DOS_CleanArmProdPos		:= _211DSX.OUT; 
	VAR_DOS_CleanArmCopPos		:= _210DSX.OUT;
	VAR_DOS_CleanArmCopPosFault := _210DSX.OUT_Alarm OR _211DSX.OUT_Alarm;
END_ACTION