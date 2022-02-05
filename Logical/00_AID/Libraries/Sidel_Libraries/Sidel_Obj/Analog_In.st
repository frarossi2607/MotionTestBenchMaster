FUNCTION_BLOCK Analog_In
	IF IN_ConfigPresent THEN
	
		(*****************************************************************)
		(****************************VALUE SCALING************************)
		(*****************************************************************)
		TON_ChannelOk(IN := IO.DI_ChannelOk, PT := t#400ms);
		
		IF IN_EngScale THEN
			VAR_ChannelActive := IO.AI_Raw < 32767;
		ELSIF TON_ChannelOk.Q THEN
			IF IN_0_20mA THEN
				VAR_ChannelActive := (IO.AI_Raw > 6000);
			ELSE
				VAR_ChannelActive := NOT ((IO.AI_Raw < -90) OR (IO.AI_Raw > 32767));
			END_IF
			OUT_RawOverflow 	:= (IO.AI_Raw > 32767) AND NOT HMI.Mask;
			OUT_RawUnderflow	:= NOT VAR_ChannelActive AND (IO.AI_Raw < 32767) AND NOT HMI.Mask;
		ELSE
			VAR_ChannelActive := FALSE;
			OUT_RawOverflow	  := FALSE;
			OUT_RawUnderflow  := FALSE;
		END_IF
		
		IF VAR_ChannelActive THEN
			IF IN_EngScale THEN
				VAR_Out := INT_TO_REAL(IO.AI_Raw) / 10.0;
			ELSE
				IF IN_0_20mA THEN
					LCRLimScal_0_20mA(
					x	:= INT_TO_REAL(IO.AI_Raw),
					x1	:= 6553.4, 
					y1	:= IN_ScaleLOW,
					x2	:= 32767.0, 
					y2	:= IN_ScaleHIGH
					);
					
					VAR_Out := LCRLimScal_0_20mA.y;
				ELSE	
					LCRLimScal_4_20mA(
					x	:= INT_TO_REAL(IO.AI_Raw),
					x1	:= 0.0, 
					y1	:= IN_ScaleLOW,
					x2	:= 32767.0, 
					y2	:= IN_ScaleHIGH
					);
					
					VAR_Out := LCRLimScal_4_20mA.y;
				END_IF
			END_IF
		END_IF
		
		(*****************************************************************)
		(****************************FAULTS*******************************)
		(*****************************************************************)
		IF OUT_RawOverflow OR OUT_RawUnderflow THEN
			VAR_iFault := NOT VAR_Mask;
		ELSIF IN_Reset THEN
			VAR_iFault	:= FALSE;
		END_IF
		
		IF NOT IN_Simulation THEN
			OUT_ActValue 	:= VAR_Out;
			VAR_Mask		:= HMI.Mask AND IN_MaskEn;
			VAR_Fault 		:= VAR_iFault;
		ELSE
			OUT_ActValue 	:= HMI.PV;
			VAR_Mask		:= HMI.Mask;
			VAR_Fault 		:= FALSE;
		END_IF
		
		IF VAR_Fault THEN	
			IF IN_FaultOutMode = CST_AI_FaultMode_Low THEN
				VAR_Out := IN_ScaleLOW;
			ELSIF IN_FaultOutMode = CST_AI_FaultMode_High THEN
				VAR_Out := IN_ScaleHIGH;
			END_IF
			OUT_Alarm := NOT VAR_Mask;
		ELSIF IN_Reset THEN
			OUT_Alarm := FALSE;
		END_IF
		
		(*****************************************************************)
		(****************************LIMITS*******************************)
		(*****************************************************************)
		IF IN_HighLimitEn AND NOT VAR_Mask THEN
			TMR_TON_HighLimitDelay.IN := (OUT_ActValue >= IN_HighLimitSP);
			IF TMR_TON_HighLimitDelay.Q THEN
				OUT_HighLimit 	:= TRUE;
			ELSIF (OUT_ActValue <= (IN_HighLimitSP - IN_HighLimitHyst)) THEN
				OUT_HighLimit 	:= FALSE;
			END_IF
		ELSE
			TMR_TON_HighLimitDelay.IN 	:= FALSE;
			OUT_HighLimit 				:= FALSE;
		END_IF
		TMR_TON_HighLimitDelay(PT := IN_HighLimitDelay);
		
		IF IN_LowLimitEn AND NOT VAR_Mask THEN
			TMR_TON_LowLimitDelay.IN := (OUT_ActValue <= IN_LowLimitSP);
			IF TMR_TON_LowLimitDelay.Q THEN
				OUT_LowLimit 	:= TRUE;
			ELSIF (OUT_ActValue >= (IN_LowLimitSP + IN_LowLimitHyst)) THEN
				OUT_LowLimit 	:= FALSE;
			END_IF
		ELSE
			TMR_TON_LowLimitDelay.IN 	:= FALSE;
			OUT_LowLimit 				:= FALSE;
		END_IF
		TMR_TON_LowLimitDelay(PT := IN_LowLimitDelay);
		(*****************************************************************)
		(*************************COMPARE MODE****************************)
		(*****************************************************************)
		IF VAR_Mask THEN
			VAR_SpReached	:= TRUE;
			VAR_Wait		:= FALSE;	
		ELSE
			CASE IN_CompareMode OF
				CST_AI_Compare_OFF:
					VAR_SpReached	:= FALSE;
					VAR_Wait		:= FALSE;
					HMI.SP			:= HMI.PV;
					
				CST_AI_Compare_LT:
					VAR_SpReached	:=  OUT_ActValue < (IN_ActualSP + IN_MinDev);
					VAR_Wait		:= NOT VAR_SpReached AND IN_AlarmEn;
					HMI.SP			:= IN_ActualSP;
					
				CST_AI_Compare_GT:
					VAR_SpReached	:=  OUT_ActValue > (IN_ActualSP - IN_MaxDev);
					VAR_Wait		:= NOT VAR_SpReached AND IN_AlarmEn;
					HMI.SP			:= IN_ActualSP;
					
				CST_AI_Compare_EQ:
					VAR_SpReached	:= (OUT_ActValue < (IN_ActualSP + IN_MaxDev)) AND (OUT_ActValue > (IN_ActualSP - IN_MinDev));
					VAR_Wait		:= NOT VAR_SpReached AND IN_AlarmEn;
					HMI.SP			:= IN_ActualSP;
					
				CST_AI_Compare_ON:
					VAR_SpReached	:= TRUE;
					VAR_Wait		:= FALSE;
					HMI.SP			:= HMI.PV;
			END_CASE
		END_IF
	ELSE
		VAR_SpReached 	:= TRUE;
		VAR_Wait		:= FALSE;
		HMI.SP			:= HMI.PV;
		OUT_LowLimit	:= FALSE;
		OUT_HighLimit 	:= FALSE;
	END_IF
	
	TMR_TOF_SpReached(IN:= VAR_SpReached, PT:= IN_WaitDelay);
	OUT_SpReached	:= TMR_TOF_SpReached.Q AND TON_ChannelOk.Q;
	
	(*****************************************************************)
	(***************************TOTALIZER*****************************)
	(*****************************************************************)
	IF IN_HMITotEn THEN
		HMITotalizer(
		IN_Pulse			:= IO.DI_Pulse,
		IN_AnalogPV			:= VAR_Out,
		IN_PulseWeight		:= IN_TotPulseWeight,
		IN_ConfigType		:= IN_TotType,
		IN_Reset			:= IN_HMITotReset OR HMI.ResetTot,
		OUT_TotalCounter	:= HMI.Tot);
			
		HMI.ConfigTot	:= TRUE;
	ELSE
		HMI.ConfigTot	:= FALSE;
		HMI.Tot 		:= 0.0;
	END_IF
	
	IF IN_PLCCounterEn THEN
		PLCCounter(
		IN_Pulse			:= IO.DI_Pulse,
		IN_AnalogPV			:= VAR_Out,
		IN_PulseWeight		:= IN_TotPulseWeight,
		IN_ConfigType		:= IN_TotType,
		IN_Reset			:= IN_PLCCounterReset,
		OUT_TotalCounter	:= HMI.PV_Counter);
			
		HMI.ConfigCounter	:= TRUE;
	ELSE
		HMI.ConfigCounter	:= FALSE;
		HMI.PV_Counter		:= 0.0;
	END_IF

	OUT_PLCCounterReached := (HMI.PV_Counter >= IN_PLCCounterSP);
	
	HMI.ConfigAlarm		:= IN_ConfigPopup;
	HMI.ConfigPresent 	:= IN_ConfigPresent;
	HMI.SP_Counter		:= IN_PLCCounterSP;
	HMI.WaitCounter		:= IN_PLCCounterEn AND NOT OUT_PLCCounterReached;
	HMI.Wait			:= VAR_Wait;
	HMI.Alarm			:= OUT_Alarm;
	HMI.PV 				:= OUT_ActValue;
	
	IF NOT IN_Simulation THEN
		HMI.MaskEnable	:= IN_MaskEn;
		HMI.ConfigPopUp	:= IN_ConfigPopup;
	ELSE
		HMI.MaskEnable	:= TRUE;
		HMI.ConfigPopUp	:= TRUE;
	END_IF
END_FUNCTION_BLOCK

