FUNCTION_BLOCK Analog_In_Multicompare
	IF IN_ConfigPresent THEN
	
	(*****************************************************************)
	(****************************VALUE SCALING************************)
	(*****************************************************************)
		IF IN_EngScale THEN
			VAR_ChannelActive := IO.AI_Raw < 32767;
		ELSE
			IF IN_0_20mA THEN
				VAR_ChannelActive := (IO.AI_Raw > 6000);
			ELSE
				VAR_ChannelActive := NOT ((IO.AI_Raw < -90) OR (IO.AI_Raw > 32767));
			END_IF
			OUT_RawOverflow 	:= (IO.AI_Raw > 32767) AND NOT HMI.Mask;
			OUT_RawUnderflow	:= NOT VAR_ChannelActive AND (IO.AI_Raw < 32767) AND NOT HMI.Mask;
		END_IF
	
		VAR_Index := IN_ScaleIndex;
		
		LCRLimScal_0_20mA(
			x	:= INT_TO_REAL(IO.AI_Raw), 
			x1	:= 6553.4, 
			y1	:= IN_Scale[VAR_Index].ScaleLOW, 
			x2	:= 32767.0, 
			y2	:= IN_Scale[VAR_Index].ScaleHIGH
			);
		
		LCRLimScal_4_20mA(
			x	:= INT_TO_REAL(IO.AI_Raw), 
			x1	:= 0.0, 
			y1	:= IN_Scale[VAR_Index].ScaleLOW, 
			x2	:= 32767.0, 
			y2	:= IN_Scale[VAR_Index].ScaleHIGH
			);
				
		IF VAR_ChannelActive THEN
			IF IN_EngScale THEN
				VAR_Out := INT_TO_REAL(IO.AI_Raw) / 10.0;
			ELSE
				IF IN_0_20mA THEN
					VAR_Out := LCRLimScal_0_20mA.y;
				ELSE
					VAR_Out := LCRLimScal_4_20mA.y;
				END_IF
			END_IF                     

			IF IN_Reset THEN
				VAR_iFault := FALSE;  
			END_IF	
		ELSE
			VAR_iFault := NOT VAR_Mask;  
		END_IF
		
	(*****************************************************************)
	(***********************FAULTS AND LIMITS*************************)
	(*****************************************************************)
		IF NOT IN_Simulation THEN
			OUT_Scale[VAR_Index].ActValue 	:= VAR_Out;
			VAR_Mask						:= HMI.Mask AND IN_MaskEn AND IN_AlarmEn ;
			VAR_Fault 						:= VAR_iFault;
		ELSE
			OUT_Scale[VAR_Index].ActValue 	:= HMI.PV[VAR_Index];
			VAR_Mask						:= HMI.Mask;
			VAR_Fault 						:= FALSE;
		END_IF
		
		IF VAR_Fault AND IN_AlarmEn THEN	
			IF IN_FaultOutMode = CST_AI_FaultMode_Low THEN
				VAR_Out := IN_Scale[VAR_Index].ScaleLOW;
			ELSIF IN_FaultOutMode = CST_AI_FaultMode_High THEN
				VAR_Out := IN_Scale[VAR_Index].ScaleHIGH;
			END_IF
			OUT_Alarm := TRUE;
		ELSIF IN_Reset THEN
			OUT_Alarm := FALSE;
		END_IF
		
				
		IF IN_Scale[VAR_Index].HighLimitEn AND NOT VAR_Mask THEN
			TMR_TON_HighLimitDelay(	IN := (OUT_Scale[VAR_Index].ActValue >= IN_Scale[VAR_Index].HighLimitSP), 
									PT := IN_Scale[VAR_Index].HighLimitDelay);
									
			IF TMR_TON_HighLimitDelay.Q THEN
				OUT_Scale[VAR_Index].HighLimit 	:= TRUE;
			ELSIF (OUT_Scale[VAR_Index].ActValue <= (IN_Scale[VAR_Index].HighLimitSP - IN_Scale[VAR_Index].HighLimitHyst)) THEN	
				OUT_Scale[VAR_Index].HighLimit 	:= FALSE;
			END_IF
		ELSE
			OUT_Scale[VAR_Index].HighLimit := FALSE;
		END_IF
		
		IF IN_Scale[VAR_Index].LowLimitEn AND NOT VAR_Mask THEN
			TMR_TON_LowLimitDelay(	IN := (OUT_Scale[VAR_Index].ActValue <= IN_Scale[VAR_Index].LowLimitSP), 
									PT := IN_Scale[VAR_Index].LowLimitDelay);
		
			IF TMR_TON_LowLimitDelay.Q THEN
				OUT_Scale[VAR_Index].LowLimit 	:= TRUE;
			ELSIF (OUT_Scale[VAR_Index].ActValue >= (IN_Scale[VAR_Index].LowLimitSP + IN_Scale[VAR_Index].LowLimitHyst)) THEN
				OUT_Scale[VAR_Index].LowLimit 	:= FALSE;
			END_IF
		ELSE
			OUT_Scale[VAR_Index].LowLimit := FALSE;
		END_IF

	(*****************************************************************)
	(*************************COMPARE MODE****************************)
	(*****************************************************************)
		IF VAR_Mask THEN
			VAR_SpReached := TRUE;
			VAR_Wait := FALSE;	
		ELSE
			CASE IN_CompareMode OF
				CST_AI_Compare_OFF:
					VAR_SpReached		:= FALSE;
					VAR_Wait 			:= FALSE;
					HMI.SP[VAR_Index]	:= HMI.PV[VAR_Index];
					
				CST_AI_Compare_LT:
					VAR_SpReached 		:= OUT_Scale[VAR_Index].ActValue < (IN_Scale[VAR_Index].ActualSP + IN_Scale[VAR_Index].MinDev);
					VAR_Wait 			:= NOT VAR_SpReached;
					HMI.SP[VAR_Index]	:= IN_Scale[VAR_Index].ActualSP;
					
				CST_AI_Compare_GT:
					VAR_SpReached 		:= OUT_Scale[VAR_Index].ActValue > (IN_Scale[VAR_Index].ActualSP - IN_Scale[VAR_Index].MaxDev);
					VAR_Wait 			:= NOT VAR_SpReached;
					HMI.SP[VAR_Index]	:= IN_Scale[VAR_Index].ActualSP;
					
				CST_AI_Compare_EQ:
					VAR_SpReached 		:= (OUT_Scale[VAR_Index].ActValue < (IN_Scale[VAR_Index].ActualSP + IN_Scale[VAR_Index].MaxDev)) AND (OUT_Scale[VAR_Index].ActValue > (IN_Scale[VAR_Index].ActualSP - IN_Scale[VAR_Index].MinDev));
					VAR_Wait 			:= NOT VAR_SpReached;
					HMI.SP[VAR_Index]	:= IN_Scale[VAR_Index].ActualSP;
					
				CST_AI_Compare_ON:
					VAR_SpReached 		:= TRUE;		
					VAR_Wait 			:= FALSE;	
					HMI.SP[VAR_Index]	:= HMI.PV[VAR_Index];
			END_CASE
		END_IF
	ELSE
		OUT_SpReached 					:= TRUE;		
		OUT_Scale[VAR_Index].LowLimit	:= FALSE;
		OUT_Scale[VAR_Index].HighLimit 	:= FALSE;		
	END_IF
	
	TMR_TOF_SpReached(IN:= VAR_SpReached, PT:= IN_Scale[VAR_Index].WaitDelay);
	OUT_SpReached	:= TMR_TOF_SpReached.Q;
	
	(*****************************************************************)
	(***************************TOTALIZER*****************************)
	(*****************************************************************)
	IF IN_Scale[VAR_Index].HMITotEn THEN
		HMITotalizer(
			IN_Pulse			:= IO.DI_Pulse,
			IN_AnalogPV			:= VAR_Out,
			IN_PulseWeight		:= IN_Scale[VAR_Index].TotPulseWeight,
			IN_ConfigType		:= IN_Scale[VAR_Index].TotType,
			IN_Reset			:= IN_Scale[VAR_Index].HMITotReset OR HMI.ResetTot,
			OUT_TotalCounter	:= HMI.Tot[VAR_Index]);	
		
		HMI.ConfigTot[VAR_Index]	:= TRUE;
	ELSE
		HMI.ConfigTot[VAR_Index]	:= FALSE;
		HMI.Tot[VAR_Index] 			:= 0.0;
	END_IF
	
	IF IN_PLCCounterEn THEN
		PLCCounter(
			IN_Pulse			:= IO.DI_Pulse,
			IN_AnalogPV			:= VAR_Out,
			IN_PulseWeight		:= IN_Scale[VAR_Index].TotPulseWeight,
			IN_ConfigType		:= IN_Scale[VAR_Index].TotType,
			IN_Reset			:= IN_Scale[VAR_Index].PLCCounterReset,
			OUT_TotalCounter	:= HMI.PV_Counter[VAR_Index]);
		
		HMI.ConfigCounter[VAR_Index]	:= TRUE;
	ELSE
		HMI.ConfigCounter[VAR_Index]	:= FALSE;
		HMI.PV_Counter[VAR_Index]		:= 0.0;
	END_IF

	OUT_Scale[VAR_Index].PLCCounterReached := (HMI.PV_Counter[VAR_Index] >= IN_Scale[VAR_Index].PLCCounterSP);
	
	HMI.ConfigAlarm					:= IN_AlarmEn;
	HMI.ConfigPresent 				:= IN_ConfigPresent;
	HMI.SP_Counter[VAR_Index]		:= IN_Scale[VAR_Index].PLCCounterSP;
	HMI.WaitCounter[VAR_Index]		:= IN_PLCCounterEn AND NOT OUT_Scale[VAR_Index].PLCCounterReached;
	HMI.Wait[VAR_Index]				:= VAR_Wait;
	HMI.Unit						:= VAR_Index;
	HMI.Alarm						:= OUT_Alarm;
	HMI.PV[VAR_Index]				:= OUT_Scale[VAR_Index].ActValue;
	
	IF NOT IN_Simulation THEN
		HMI.MaskEnable	:= IN_MaskEn;
		HMI.ConfigPopup	:= IN_ConfigPopup;
	ELSE
		HMI.MaskEnable	:= TRUE;
		HMI.ConfigPopup	:= TRUE;
	END_IF
END_FUNCTION_BLOCK

