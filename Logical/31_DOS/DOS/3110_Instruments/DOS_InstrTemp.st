ACTION DOS_InstrTemp:
	
	TTJ[203](
	IN_ConfigPresent 	:= TTJ[203].IN_ConfigPresent,
	IN_FaultOutMode 	:= CST_AI_FaultMode_High,
	IN_EngScale 		:= TTJ[203].IN_EngScale,
	IN_CompareMode 		:= VAR_DOS_SEQ.Device.TTJ203.CMP,
	IN_AlarmEn 			:= TRUE,	  
	IN_MaskEn 			:= TRUE,
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_ActualSP 		:= VAR_DOS_SEQ.Device.TTJ203.SP, //INT_TO_REAL(PstFlr.SPTemp / 10)  o quel segnale è solo in CIP il SetPoint? FILIPPO
	IN_MinDev 			:= VAR_DOS_SEQ.Device.TTJ203.MinDev,
	IN_MaxDev 			:= VAR_DOS_SEQ.Device.TTJ203.MaxDev,
	IN_WaitDelay 		:= T#500ms,
	IN_HighLimitEn 		:= VAR_DOS_SEQ.Device.TTJ203.ALR_HighLimitEn,
	IN_HighLimitSP 		:= VAR_DOS_SEQ.Device.TTJ203.ALR_HighLimitSP,
	IN_HighLimitHyst 	:= 3.0,
	IN_HighLimitDelay 	:= T#3s,
	IN_LowLimitEn 		:= VAR_DOS_SEQ.Device.TTJ203.ALR_LowLimitEn,
	IN_LowLimitSP 		:= VAR_DOS_SEQ.Device.TTJ203.ALR_LowLimitSP,
	IN_LowLimitHyst 	:= 3, 
	IN_LowLimitDelay 	:= T#3s,
	IN_TotPulseWeight 	:= 0.0,
	IN_TotType 			:= 0,
	IN_PLCCounterEn 	:= FALSE,
	IN_PLCCounterSP 	:= 0.0,
	IN_PLCCounterReset	:= FALSE,
	IN_HMITotEn 		:= FALSE, 
	IN_HMITotReset 		:= FALSE, 
	IO 					:= IO_TTJ[203], 
	HMI 				:= HMI_TTJ[203]
	);
	
	TMR_TON_TemperatureTooLow.IN := TTJ[203].OUT_LowLimit; 
	TMR_TON_TemperatureTooLow.PT := T#20S;
	TMR_TON_TemperatureTooLow();
	
	//VAR_DOS_ChillingRequest			:= VAR_DOS_SEQ.Device.TTJ[203].CMP>0 AND NOT TTJ[203].OUT_SpReached AND NOT TTJ[203].OUT_LowLimit;
	VAR_DOS_WaterTemperatureTooHigh	:= TTJ[203].OUT_HighLimit;
	VAR_DOS_WaterTemperatureTooLow	:= TMR_TON_TemperatureTooLow.Q;
	
END_ACTION
