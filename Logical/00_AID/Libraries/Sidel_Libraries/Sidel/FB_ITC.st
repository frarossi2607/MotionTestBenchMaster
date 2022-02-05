FUNCTION_BLOCK FB_HMI_ITC_DigitalBool
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 16, 0));

	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Auto	:= TRUE;
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		ITC_IO 	:= SEL(VAR_Auto, VAR_Man, ITC);
	ELSE
		ITC 	:= SEL(VAR_Auto, VAR_Man, ITC_IO);
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 16 * HMI_Page.PageNum)) AND IN_Visibility THEN	
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto	:= VAR_Auto;
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man	:= VAR_Man;
			ELSE
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto	:= VAR_Auto;
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man	:= VAR_Man;
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.DigitalOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.DigitalOut[VAR_ProgressiveId].LampState	:= ITC_IO;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Alarm		:= IN_Alarm;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Description	:= IN_Description;
			
			IF EDGEPOS(HMI_Data.DigitalOut[VAR_ProgressiveId].Auto) THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man := FALSE;
			ELSIF EDGEPOS(HMI_Data.DigitalOut[VAR_ProgressiveId].Man) THEN 
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto := FALSE;
			END_IF
			
			IF IN_ReadOnly OR IN_HMIAutoForce THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto	:= TRUE;
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man	:= FALSE;
			END_IF
			
			VAR_Auto	:= HMI_Data.DigitalOut[VAR_ProgressiveId].Auto;
			VAR_Man		:= HMI_Data.DigitalOut[VAR_ProgressiveId].Man;
		ELSE
			HMI_Data.DigitalIn[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.DigitalIn[VAR_ProgressiveId].LampState 	:= ITC;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Alarm			:= IN_Alarm;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Description	:= IN_Description;
			
			IF EDGEPOS(HMI_Data.DigitalIn[VAR_ProgressiveId].Auto) THEN
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man := FALSE;
			ELSIF EDGEPOS(HMI_Data.DigitalIn[VAR_ProgressiveId].Man) THEN 
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto := FALSE;
			END_IF
			
			IF IN_ReadOnly OR IN_HMIAutoForce THEN
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto	:= TRUE;
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man	:= FALSE;
			END_IF
			
			VAR_Auto	:= HMI_Data.DigitalIn[VAR_ProgressiveId].Auto;
			VAR_Man		:= HMI_Data.DigitalIn[VAR_ProgressiveId].Man;
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 16 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.DigitalOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.DigitalIn[VAR_ProgressiveId].Visibility	:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
	
	HMI_Data.ManActive	:= NOT VAR_Auto OR HMI_Data.ManActive;
	
	IF (Index > (16 + 16 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
		
	OUT_Man			:= NOT VAR_Auto;
	OUT_ManValue	:= VAR_Man;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_DigitalByte
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 16, 0));

	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Auto	:= TRUE;
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		FOR VAR_BitIndex := 0 TO 7 DO
			IF VAR_BitIndex = INT_TO_USINT(IN_BitNumber) THEN
				IF NOT VAR_Auto THEN
					VAR_BitArray[VAR_BitIndex] := VAR_Man;
				ELSE
					VAR_BitArray[VAR_BitIndex] := ITC;
				END_IF
			ELSE
				VAR_BitArray[VAR_BitIndex] := (ITC_IO AND REAL_TO_BYTE(pow(2, VAR_BitIndex))) <> 0;
			END_IF
		END_FOR
		
		ITC_IO	:= 0;
	
		FOR VAR_BitIndex := 0 TO 7 DO
			ITC_IO	:= ITC_IO OR UINT_TO_BYTE(((REAL_TO_UINT(pow(2, VAR_BitIndex))) * VAR_BitArray[VAR_BitIndex]));
		END_FOR
	ELSE
		IF NOT VAR_Auto THEN
			ITC		:= VAR_Man;
		ELSE
			ITC		:= (ITC_IO AND REAL_TO_BYTE(pow(2, IN_BitNumber))) <> 0;
		END_IF
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 16 * HMI_Page.PageNum)) AND IN_Visibility THEN	
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto	:= VAR_Auto;
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man	:= VAR_Man;
			ELSE
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto	:= VAR_Auto;
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man	:= VAR_Man;
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.DigitalOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.DigitalOut[VAR_ProgressiveId].LampState	:= (ITC_IO AND REAL_TO_BYTE(pow(2, IN_BitNumber))) <> 0;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Alarm		:= IN_Alarm;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Description	:= IN_Description;
			
			IF EDGEPOS(HMI_Data.DigitalOut[VAR_ProgressiveId].Auto) THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man := FALSE;
			ELSIF EDGEPOS(HMI_Data.DigitalOut[VAR_ProgressiveId].Man) THEN 
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto := FALSE;
			END_IF
			
			IF IN_ReadOnly OR IN_HMIAutoForce THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto	:= TRUE;
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man	:= FALSE;
			END_IF
			
			VAR_Auto	:= HMI_Data.DigitalOut[VAR_ProgressiveId].Auto;
			VAR_Man		:= HMI_Data.DigitalOut[VAR_ProgressiveId].Man;
		ELSE
			HMI_Data.DigitalIn[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.DigitalIn[VAR_ProgressiveId].LampState 	:= ITC;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Alarm			:= IN_Alarm;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Description	:= IN_Description;
			
			IF EDGEPOS(HMI_Data.DigitalIn[VAR_ProgressiveId].Auto) THEN
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man := FALSE;
			ELSIF EDGEPOS(HMI_Data.DigitalIn[VAR_ProgressiveId].Man) THEN 
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto := FALSE;
			END_IF
			
			IF IN_ReadOnly OR IN_HMIAutoForce THEN
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto	:= TRUE;
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man	:= FALSE;
			END_IF
			
			VAR_Auto	:= HMI_Data.DigitalIn[VAR_ProgressiveId].Auto;
			VAR_Man		:= HMI_Data.DigitalIn[VAR_ProgressiveId].Man;
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 16 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.DigitalOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.DigitalIn[VAR_ProgressiveId].Visibility	:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
	
	HMI_Data.ManActive	:= NOT VAR_Auto OR HMI_Data.ManActive;
	
	IF (Index > (16 + 16 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
		
	OUT_Man			:= NOT VAR_Auto;
	OUT_ManValue	:= VAR_Man;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_DigitalUsint
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 16, 0));

	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Auto	:= TRUE;
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		FOR VAR_BitIndex := 0 TO 7 DO
			IF VAR_BitIndex = INT_TO_USINT(IN_BitNumber) THEN
				IF NOT VAR_Auto THEN
					VAR_BitArray[VAR_BitIndex] := VAR_Man;
				ELSE
					VAR_BitArray[VAR_BitIndex] := ITC;
				END_IF
			ELSE
				VAR_BitArray[VAR_BitIndex] := (ITC_IO AND REAL_TO_USINT(pow(2, VAR_BitIndex))) <> 0;
			END_IF
		END_FOR
	
		ITC_IO	:= 0;
	
		FOR VAR_BitIndex := 0 TO 7 DO
			ITC_IO	:= ITC_IO OR UINT_TO_USINT(((REAL_TO_UINT(pow(2, VAR_BitIndex))) * VAR_BitArray[VAR_BitIndex]));
		END_FOR
	ELSE
		IF NOT VAR_Auto THEN
			ITC		:= VAR_Man;
		ELSE
			ITC		:= (ITC_IO AND REAL_TO_USINT(pow(2, IN_BitNumber))) <> 0;
		END_IF
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 16 * HMI_Page.PageNum(*VAR_OldPage*))) AND IN_Visibility THEN	
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto	:= VAR_Auto;
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man	:= VAR_Man;
			ELSE
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto	:= VAR_Auto;
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man	:= VAR_Man;
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.DigitalOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.DigitalOut[VAR_ProgressiveId].LampState	:= (ITC_IO AND REAL_TO_USINT(pow(2, IN_BitNumber))) <> 0;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Alarm		:= IN_Alarm;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Description	:= IN_Description;
			
			IF EDGEPOS(HMI_Data.DigitalOut[VAR_ProgressiveId].Auto) THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man := FALSE;
				VAR_Man		:= FALSE;
			ELSIF EDGEPOS(HMI_Data.DigitalOut[VAR_ProgressiveId].Man) THEN 
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto := FALSE;
				VAR_Auto	:= FALSE;
			END_IF
			
			IF IN_ReadOnly OR IN_HMIAutoForce THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto	:= TRUE;
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man	:= FALSE;
			END_IF
			
			VAR_Auto	:= HMI_Data.DigitalOut[VAR_ProgressiveId].Auto;
			VAR_Man		:= HMI_Data.DigitalOut[VAR_ProgressiveId].Man;
		ELSE
			HMI_Data.DigitalIn[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.DigitalIn[VAR_ProgressiveId].LampState 	:= ITC;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Alarm			:= IN_Alarm;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Description	:= IN_Description;
			
			IF EDGEPOS(HMI_Data.DigitalIn[VAR_ProgressiveId].Auto) THEN
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man := FALSE;
			ELSIF EDGEPOS(HMI_Data.DigitalIn[VAR_ProgressiveId].Man) THEN 
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto := FALSE;
			END_IF
			
			IF IN_ReadOnly OR IN_HMIAutoForce THEN
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto	:= TRUE;
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man	:= FALSE;
			END_IF
			
			VAR_Auto	:= HMI_Data.DigitalIn[VAR_ProgressiveId].Auto;
			VAR_Man		:= HMI_Data.DigitalIn[VAR_ProgressiveId].Man;
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 16 * HMI_Page.PageNum(*VAR_OldPage*))) THEN
		IF IN_IOType THEN
			HMI_Data.DigitalOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.DigitalIn[VAR_ProgressiveId].Visibility	:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
	
	HMI_Data.ManActive	:= NOT VAR_Auto OR HMI_Data.ManActive;
	
	IF (Index > (16 + 16 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
		
	OUT_Man			:= NOT VAR_Auto;
	OUT_ManValue	:= VAR_Man;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_DigitalInt
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 16, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Auto	:= TRUE;
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		FOR VAR_BitIndex := 0 TO 15 DO
			IF VAR_BitIndex = INT_TO_USINT(IN_BitNumber) THEN
				IF NOT VAR_Auto THEN
					VAR_BitArray[VAR_BitIndex] := VAR_Man;
				ELSE
					VAR_BitArray[VAR_BitIndex] := ITC;
				END_IF
			ELSE
				VAR_BitArray[VAR_BitIndex] := (ITC_IO AND REAL_TO_INT(pow(2, VAR_BitIndex))) <> 0;
			END_IF
		END_FOR
	
		ITC_IO	:= 0;
	
		FOR VAR_BitIndex := 0 TO 15 DO
			ITC_IO	:= ITC_IO OR UINT_TO_INT(((REAL_TO_UINT(pow(2, VAR_BitIndex))) * VAR_BitArray[VAR_BitIndex]));
		END_FOR
	ELSE
		IF NOT VAR_Auto THEN
			ITC		:= VAR_Man;
		ELSE
			ITC		:= (ITC_IO AND REAL_TO_INT(pow(2, IN_BitNumber))) <> 0;
		END_IF
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 16 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto	:= VAR_Auto;
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man	:= VAR_Man;
			ELSE
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto	:= VAR_Auto;
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man	:= VAR_Man;
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.DigitalOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.DigitalOut[VAR_ProgressiveId].LampState	:= (ITC_IO AND REAL_TO_INT(pow(2, IN_BitNumber))) <> 0;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Alarm		:= IN_Alarm;
			HMI_Data.DigitalOut[VAR_ProgressiveId].Description	:= IN_Description;
			
			IF EDGEPOS(HMI_Data.DigitalOut[VAR_ProgressiveId].Auto) THEN
				HMI_Data.DigitalOut[VAR_ProgressiveId].Man := FALSE;
			ELSIF EDGEPOS(HMI_Data.DigitalOut[VAR_ProgressiveId].Man) THEN 
				HMI_Data.DigitalOut[VAR_ProgressiveId].Auto := FALSE;
			END_IF
			
			VAR_Auto	:= HMI_Data.DigitalOut[VAR_ProgressiveId].Auto;
			VAR_Man		:= HMI_Data.DigitalOut[VAR_ProgressiveId].Man;
		ELSE
			HMI_Data.DigitalIn[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.DigitalIn[VAR_ProgressiveId].LampState 	:= ITC;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Alarm			:= IN_Alarm;
			HMI_Data.DigitalIn[VAR_ProgressiveId].Description	:= IN_Description;
			
			IF EDGEPOS(HMI_Data.DigitalIn[VAR_ProgressiveId].Auto) THEN
				HMI_Data.DigitalIn[VAR_ProgressiveId].Man := FALSE;
			ELSIF EDGEPOS(HMI_Data.DigitalIn[VAR_ProgressiveId].Man) THEN 
				HMI_Data.DigitalIn[VAR_ProgressiveId].Auto := FALSE;
			END_IF
			
			VAR_Auto	:= HMI_Data.DigitalIn[VAR_ProgressiveId].Auto;
			VAR_Man		:= HMI_Data.DigitalIn[VAR_ProgressiveId].Man;
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 16 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.DigitalOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.DigitalIn[VAR_ProgressiveId].Visibility	:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
	
	HMI_Data.ManActive	:= NOT VAR_Auto OR HMI_Data.ManActive;
	
	IF (Index > (16 + 16 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= NOT VAR_Auto;
	OUT_ManValue	:= VAR_Man;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogByte
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		ITC_IO 		:= SEL(VAR_Man, ITC, VAR_ManValue);
	ELSE									
		ITC 		:= SEL(VAR_Man, ITC_IO, VAR_ManValue);
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= BYTE_TO_REAL(VAR_ManValue);
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man		:= BYTE_TO_REAL(VAR_ManValue);
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= BYTE_TO_REAL(ITC_IO);
			HMI_Data.AnalogOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogOut[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_BYTE(HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man);
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= IN_Visibility;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Enable			:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= BYTE_TO_REAL(ITC);
			HMI_Data.AnalogIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogIn[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_BYTE(HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man);
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
	
	HMI_Data.ManActive	:= VAR_Man OR HMI_Data.ManActive;
	
	IF (Index > (4 + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= VAR_Man;
	OUT_ManValue	:= VAR_ManValue;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogUsint
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		ITC_IO 		:= SEL(VAR_Man, ITC, VAR_ManValue);
	ELSE									
		ITC 		:= SEL(VAR_Man, ITC_IO, VAR_ManValue);
	END_IF
		
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= USINT_TO_REAL(VAR_ManValue);
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man		:= USINT_TO_REAL(VAR_ManValue);
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= USINT_TO_REAL(ITC_IO);
			HMI_Data.AnalogOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogOut[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_USINT(HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man);
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= IN_Visibility;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Enable			:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= USINT_TO_REAL(ITC);
			HMI_Data.AnalogIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogIn[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_USINT(HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man);
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
	
	HMI_Data.ManActive	:= VAR_Man OR HMI_Data.ManActive;
	
	IF (Index > (4 + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= VAR_Man;
	OUT_ManValue	:= VAR_ManValue;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogInt
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		VAR_Value 	:= SEL(VAR_Man, ITC, VAR_ManValue);
		ITC_IO 		:= SEL(HMI_Data.ComSwap, VAR_Value, swapINT(VAR_Value));
	ELSE
		VAR_Value 	:= SEL(HMI_Data.ComSwap, ITC_IO, swapINT(ITC_IO));
		ITC 		:= SEL(VAR_Man, VAR_Value, VAR_ManValue);
	END_IF

	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= INT_TO_REAL(VAR_ManValue);
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man		:= INT_TO_REAL(VAR_ManValue);
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
	
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= INT_TO_REAL(VAR_Value);
			HMI_Data.AnalogOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogOut[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man);
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= IN_Visibility;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Enable			:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= INT_TO_REAL(ITC);
			HMI_Data.AnalogIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MinValue		:= IN_MinValue;	
			
			VAR_Man			:= HMI_Data.AnalogIn[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man);
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
	
	HMI_Data.ManActive	:= VAR_Man OR HMI_Data.ManActive;
	
	IF (Index > (4 + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= VAR_Man;
	OUT_ManValue	:= VAR_ManValue;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogIntOverUsint
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		VAR_Value		:= SEL(VAR_Man, ITC, VAR_ManValue);
		VAR_RawValue	:= SEL(HMI_Data.ComSwap, VAR_Value, swapINT(VAR_Value));
		memcpy(ADR(ITC_IO), ADR(VAR_RawValue), SIZEOF(ITC));
	ELSE
		memcpy(ADR(VAR_RawValue), ADR(ITC_IO), SIZEOF(ITC));
		VAR_Value	:= SEL(HMI_Data.ComSwap, VAR_RawValue, swapINT(VAR_RawValue));
		ITC			:= SEL(VAR_Man, VAR_Value, VAR_ManValue);
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= INT_TO_REAL(VAR_ManValue);
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man		:= INT_TO_REAL(VAR_ManValue);
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= INT_TO_REAL(VAR_Value);
			HMI_Data.AnalogOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogOut[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man);
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= IN_Visibility;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Enable			:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= INT_TO_REAL(ITC);
			HMI_Data.AnalogIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogIn[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man);
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
	
	HMI_Data.ManActive	:= VAR_Man OR HMI_Data.ManActive;
	
	IF (Index > (4 + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= VAR_Man;
	OUT_ManValue	:= VAR_ManValue;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogUintOverUsint
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		VAR_Value		:= SEL(VAR_Man, ITC, VAR_ManValue);
		VAR_RawValue	:= SEL(HMI_Data.ComSwap, VAR_Value, swapINT(VAR_Value));
		memcpy(ADR(ITC_IO), ADR(VAR_RawValue), SIZEOF(ITC));
	ELSE
		memcpy(ADR(VAR_RawValue), ADR(ITC_IO), SIZEOF(ITC));
		VAR_Value	:= SEL(HMI_Data.ComSwap, VAR_RawValue, swapINT(VAR_RawValue));
		ITC			:= SEL(VAR_Man, VAR_Value, VAR_ManValue);
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= INT_TO_REAL(VAR_ManValue);
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man		:= INT_TO_REAL(VAR_ManValue);
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= INT_TO_REAL(VAR_Value);
			HMI_Data.AnalogOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogOut[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man);
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= IN_Visibility;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Enable			:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= INT_TO_REAL(ITC);
			HMI_Data.AnalogIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogIn[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man);
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
	
	HMI_Data.ManActive	:= VAR_Man OR HMI_Data.ManActive;
	
	IF (Index > (4 + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= VAR_Man;
	OUT_ManValue	:= VAR_ManValue;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogDInt
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		VAR_Value	:= SEL(VAR_Man, ITC, VAR_ManValue);
		ITC_IO		:= SEL(HMI_Data.ComSwap, VAR_Value, swapDINT(VAR_Value));
	ELSE
		VAR_Value	:= SEL(HMI_Data.ComSwap, ITC_IO, swapDINT(ITC_IO));
		ITC			:= SEL(VAR_Man, VAR_Value, VAR_ManValue);
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF

	IF (Index = (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= DINT_TO_REAL(VAR_ManValue);
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man		:= DINT_TO_REAL(VAR_ManValue);
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= DINT_TO_REAL(VAR_Value);
			HMI_Data.AnalogOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogOut[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man);
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= IN_Visibility;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Enable			:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= DINT_TO_REAL(ITC);
			HMI_Data.AnalogIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogIn[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man);
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
		
	HMI_Data.ManActive	:= VAR_Man OR HMI_Data.ManActive;
	
	IF (Index > (4 + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= VAR_Man;
	OUT_ManValue	:= VAR_ManValue;
	Index	:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogUdint
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		VAR_Value	:= SEL(VAR_Man, ITC, VAR_ManValue);
		ITC_IO		:= SEL(HMI_Data.ComSwap, VAR_Value, swapUDINT(VAR_Value));
	ELSE
		VAR_Value	:= SEL(HMI_Data.ComSwap, ITC_IO, swapUDINT(ITC_IO));
		ITC			:= SEL(VAR_Man, VAR_Value, VAR_ManValue);
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF

	IF (Index = (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= UDINT_TO_REAL(VAR_ManValue);
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man		:= UDINT_TO_REAL(VAR_ManValue);
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= UDINT_TO_REAL(VAR_Value);
			HMI_Data.AnalogOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogOut[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man);
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= IN_Visibility;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Enable			:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= UDINT_TO_REAL(ITC);
			HMI_Data.AnalogIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogIn[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man);
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
		
	HMI_Data.ManActive	:= VAR_Man OR HMI_Data.ManActive;
	
	IF (Index > (4 + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= VAR_Man;
	OUT_ManValue	:= VAR_ManValue;
	Index	:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogDIntOverUsint
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		VAR_Value		:= SEL(VAR_Man, ITC, VAR_ManValue);
		VAR_RawValue	:= SEL(HMI_Data.ComSwap, VAR_Value, swapDINT(VAR_Value));
		memcpy(ADR(ITC_IO), ADR(VAR_RawValue), SIZEOF(ITC));
	ELSE
		memcpy(ADR(VAR_RawValue), ADR(ITC_IO), SIZEOF(ITC));
		VAR_Value	:= SEL(HMI_Data.ComSwap, VAR_RawValue, swapDINT(VAR_RawValue));
		ITC			:= SEL(VAR_Man, VAR_Value, VAR_ManValue);
	END_IF
			
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF

	IF (Index = (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= DINT_TO_REAL(VAR_ManValue);
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man		:= DINT_TO_REAL(VAR_ManValue);
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= DINT_TO_REAL(VAR_Value);
			HMI_Data.AnalogOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogOut[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man);
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= IN_Visibility;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Enable			:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= DINT_TO_REAL(ITC);
			HMI_Data.AnalogIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogIn[VAR_ProgressiveId].Man;
			VAR_ManValue	:= REAL_TO_INT(HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man);
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
		
	HMI_Data.ManActive	:= VAR_Man OR HMI_Data.ManActive;
	
	IF (Index > (4 + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= VAR_Man;
	OUT_ManValue	:= VAR_ManValue;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogReal
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		VAR_Value	:= SEL(VAR_Man, ITC, VAR_ManValue);
		ITC_IO		:= SEL(HMI_Data.ComSwap, VAR_Value, swapREAL(VAR_Value));
	ELSE
		VAR_Value	:= SEL(HMI_Data.ComSwap, ITC_IO, swapREAL(ITC_IO));
		ITC			:= SEL(VAR_Man, VAR_Value, VAR_ManValue);
	END_IF

	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= VAR_ManValue;
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man	:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man	:= VAR_ManValue;
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= VAR_Value;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogOut[VAR_ProgressiveId].Man;
			VAR_ManValue	:= HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= IN_Visibility;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Enable			:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= ITC;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogIn[VAR_ProgressiveId].Man;
			VAR_ManValue	:= HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man;
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
		
	HMI_Data.ManActive	:= VAR_Man OR HMI_Data.ManActive;
	
	IF (Index > (4 + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= VAR_Man;
	OUT_ManValue	:= VAR_ManValue;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_AnalogRealOverUsint
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF IN_IOType THEN
		VAR_Value	:= SEL(VAR_Man, ITC, VAR_ManValue);
		VAR_RawValue	:= SEL(HMI_Data.ComSwap, VAR_Value, swapREAL(VAR_Value));
		memcpy(ADR(ITC_IO), ADR(VAR_RawValue), SIZEOF(ITC));
	ELSE
		memcpy(ADR(VAR_RawValue), ADR(ITC_IO), SIZEOF(ITC));
		VAR_Value	:= SEL(HMI_Data.ComSwap, VAR_RawValue, swapREAL(VAR_RawValue));
		ITC		:= SEL(VAR_Man, VAR_Value, VAR_ManValue);
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= VAR_ManValue;
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man		:= VAR_ManValue;
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			VAR_Value	:= swapREAL(ITC_IO);
			memcpy(ADR(RealValue), ADR(VAR_Value), SIZEOF(RealValue));
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= VAR_Value;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogOut[VAR_ProgressiveId].MinValue		:= IN_MinValue;
		
			VAR_Man			:= HMI_Data.AnalogOut[VAR_ProgressiveId].Man;
			VAR_ManValue	:= HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= IN_Visibility;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Enable			:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= ITC;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Wait			:= IN_Wait;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Description	:= IN_Description;
			HMI_Data.AnalogIn[VAR_ProgressiveId].Unit			:= IN_Unit;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MaxValue		:= IN_MaxValue;
			HMI_Data.AnalogIn[VAR_ProgressiveId].MinValue		:= IN_MinValue;
			
			VAR_Man			:= HMI_Data.AnalogIn[VAR_ProgressiveId].Man;
			VAR_ManValue	:= HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man;
		END_IF
	ELSIF (Index < (VAR_ProgressiveId + 4 * HMI_Page.PageNum)) THEN
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= FALSE;
		ELSE
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility		:= FALSE;
		END_IF
	END_IF
	
	VAR_OldPage := HMI_Page.PageNum;
		
	HMI_Data.ManActive	:= VAR_Man OR HMI_Data.ManActive;
	
	IF (Index > (4 + 4 * HMI_Page.PageNum)) AND IN_Visibility THEN
		HMI_Data.PageUp.Enable := TRUE;
	END_IF
	
	IF HMI_Page.PageNum <> 0 THEN
		HMI_Data.PageDown.Enable := TRUE;
	END_IF
	
	OUT_Man			:= VAR_Man;
	OUT_ManValue	:= VAR_ManValue;
	Index			:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_End
	IF IN_IODigAnalog THEN
		VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
		IF Index < (4 + 4 * HMI_Page.PageNum) THEN
			FOR i := Index TO (4 + Index - VAR_ProgressiveId) DO
				IF IN_IOType THEN
					HMI_Data.AnalogOut[VAR_ProgressiveId + i - Index].Visibility	:= FALSE;
				ELSE
					HMI_Data.AnalogIn[VAR_ProgressiveId + i - Index].Visibility		:= FALSE;
				END_IF
			END_FOR
		END_IF
	ELSE
		VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 16, 0));
		IF Index < (16 + 16 * HMI_Page.PageNum) THEN
			FOR i := Index TO (16 + Index - VAR_ProgressiveId) DO
				IF IN_IOType THEN
					HMI_Data.DigitalOut[VAR_ProgressiveId + i - Index].Visibility	:= FALSE;
				ELSE
					HMI_Data.DigitalIn[VAR_ProgressiveId + i - Index].Visibility	:= FALSE;
				END_IF
			END_FOR
		END_IF
	END_IF
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_Start
	FOR i := 1 TO 16 DO
		HMI_Data.DigitalIn[i].Visibility	:= FALSE;
		HMI_Data.DigitalOut[i].Visibility	:= FALSE;
		IF i <= 4 THEN
			HMI_Data.AnalogOut[i].Visibility	:= FALSE;
			HMI_Data.AnalogIn[i].Visibility		:= FALSE;
		END_IF
	END_FOR
	
	HMI_Data.PageDown.Enable	:= FALSE;
	HMI_Data.PageUp.Enable		:= FALSE;
	HMI_Data.ManActive			:= FALSE;
	
	DigitalIndexIn	:= 1;
	AnalogIndexIn	:= 1;
	DigitalIndexOut	:= 1;
	AnalogIndexOut	:= 1;
END_FUNCTION_BLOCK