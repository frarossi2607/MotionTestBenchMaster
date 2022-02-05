FUNCTION_BLOCK Analog_In_Direct_Inverse
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

		LCRLimScal_0_20mA(
		x	:= INT_TO_REAL(IO.AI_Raw), 
		x1	:= 6553.4, 
		y1	:= IN_ScaleLOW, 
		x2	:= 32767.0, 
		y2	:= IN_ScaleHIGH
		);
		
		LCRLimScal_4_20mA(
		x	:= INT_TO_REAL(IO.AI_Raw), 
		x1	:= 0.0, 
		y1	:= IN_ScaleLOW, 
		x2	:= 32767.0, 
		y2	:= IN_ScaleHIGH
		);
				
		IF VAR_ChannelActive THEN
			IF IN_EngScale THEN
				VAR_Out := INT_TO_REAL(IO.AI_Raw) / 10.0;
			ELSE
			    IF IN_0_20mA AND IN_Direct_Inverse THEN
					VAR_Out := IN_Delta + (IN_ScaleHIGH - IN_ScaleLOW) - LCRLimScal_0_20mA.y;
				ELSIF NOT IN_0_20mA AND IN_Direct_Inverse THEN
					VAR_Out := IN_Delta + (IN_ScaleHIGH - IN_ScaleLOW) - LCRLimScal_4_20mA.y;
				ELSIF IN_0_20mA AND NOT IN_Direct_Inverse THEN
					VAR_Out := IN_Delta + LCRLimScal_0_20mA.y;
				ELSIF NOT IN_0_20mA AND NOT IN_Direct_Inverse THEN
					VAR_Out := IN_Delta + LCRLimScal_4_20mA.y;
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
			OUT_ActValue 	:= VAR_Out;
			VAR_Mask		:= HMI.Mask AND IN_MaskEn AND IN_AlarmEn ;
			VAR_Fault 		:= VAR_iFault;
		ELSE
			OUT_ActValue 	:= HMI.PV;
			VAR_Mask		:= HMI.Mask;
			VAR_Fault 		:= FALSE;
		END_IF
		
		IF VAR_Fault AND IN_AlarmEn THEN	
			IF IN_FaultOutMode = CST_AI_FaultMode_Low THEN
				VAR_Out := IN_ScaleLOW;
			ELSIF IN_FaultOutMode = CST_AI_FaultMode_High THEN
				VAR_Out := IN_ScaleHIGH;
			END_IF
			OUT_Alarm := TRUE;
		ELSIF IN_Reset THEN
			OUT_Alarm := FALSE;
		END_IF
		
				
		IF IN_HighLimitEn AND NOT VAR_Mask THEN
			TMR_TON_HighLimitDelay(	IN := (OUT_ActValue >= IN_HighLimitSP), 
			PT := IN_HighLimitDelay);
									
			IF TMR_TON_HighLimitDelay.Q THEN
				OUT_HighLimit 	:= TRUE;
			ELSIF (OUT_ActValue <= (IN_HighLimitSP - IN_HighLimitHyst)) THEN	
				OUT_HighLimit 	:= FALSE;
			END_IF
		ELSE
			OUT_HighLimit := FALSE;
		END_IF
		
		IF IN_LowLimitEn AND NOT VAR_Mask THEN
			TMR_TON_LowLimitDelay(	IN := (OUT_ActValue <= IN_LowLimitSP), 
			PT := IN_LowLimitDelay);
		
			IF TMR_TON_LowLimitDelay.Q THEN
				OUT_LowLimit 	:= TRUE;
			ELSIF (OUT_ActValue >= (IN_LowLimitSP + IN_LowLimitHyst)) THEN
				OUT_LowLimit 	:= FALSE;
			END_IF
		ELSE
			OUT_LowLimit := FALSE;
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
					VAR_SpReached := FALSE;
					VAR_Wait := FALSE;
					HMI.SP	:= HMI.PV;
					
				CST_AI_Compare_LT:
					VAR_SpReached :=  OUT_ActValue < (IN_ActualSP + IN_MinDev);
					VAR_Wait := NOT VAR_SpReached;
					HMI.SP	:= IN_ActualSP;
					
				CST_AI_Compare_GT:
					VAR_SpReached :=  OUT_ActValue > (IN_ActualSP - IN_MaxDev);
					VAR_Wait := NOT VAR_SpReached;
					HMI.SP	:= IN_ActualSP;
					
				CST_AI_Compare_EQ:
					VAR_SpReached := (OUT_ActValue < (IN_ActualSP + IN_MaxDev)) AND (OUT_ActValue > (IN_ActualSP - IN_MinDev));
					VAR_Wait := NOT VAR_SpReached;
					HMI.SP	:= IN_ActualSP;
					
				CST_AI_Compare_ON:
					VAR_SpReached := TRUE;		
					VAR_Wait := FALSE;	
					HMI.SP	:= HMI.PV;
			END_CASE
		END_IF
	ELSE
		OUT_SpReached 			:= TRUE;		
		OUT_LowLimit			:= FALSE;
		OUT_HighLimit 			:= FALSE;		
	END_IF
	
	TMR_TOF_SpReached(IN:= VAR_SpReached, PT:= IN_WaitDelay);
	OUT_SpReached	:= TMR_TOF_SpReached.Q;
		
	HMI.ConfigAlarm		:= IN_AlarmEn;
	HMI.ConfigPresent 	:= IN_ConfigPresent;
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

