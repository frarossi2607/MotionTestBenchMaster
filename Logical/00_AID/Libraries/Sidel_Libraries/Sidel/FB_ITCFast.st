FUNCTION_BLOCK FB_HMI_ITC_FastDigitalByte
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 16, 0));

	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Auto	:= TRUE;
		VAR_Man		:= FALSE;
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 16 * VAR_OldPage)) AND IN_Visibility THEN
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
			HMI_Data.DigitalOut[VAR_ProgressiveId].LampState	:= SEL(VAR_Auto, VAR_Man, ITC);
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
			HMI_Data.DigitalIn[VAR_ProgressiveId].LampState 	:= SEL(VAR_Auto, VAR_Man, ITC);
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
	Index	:= Index + 1;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_HMI_ITC_FastAnalogInt
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 4 * VAR_OldPage)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= INT_TO_REAL(VAR_ManValue);
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man	:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man	:= INT_TO_REAL(VAR_ManValue);
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= SEL(VAR_Man, INT_TO_REAL(ITC), INT_TO_REAL(VAR_ManValue));
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
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= SEL(VAR_Man, INT_TO_REAL(ITC), INT_TO_REAL(VAR_ManValue));
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
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility	:= FALSE;
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

FUNCTION_BLOCK FB_HMI_ITC_FastAnalogDInt
	VAR_ProgressiveId := INT_TO_UINT(FC_ReminderShift(UINT_TO_INT(Index), 4, 0));
	
	IF IN_ReadOnly OR IN_HMIAutoForce THEN
		VAR_Man		:= FALSE;
	END_IF
	
	IF VAR_OldPage <> HMI_Page.PageNum THEN
		VAR_PageSwitch	:= TRUE;
	END_IF
	
	IF (Index = (VAR_ProgressiveId + 4 * VAR_OldPage)) AND IN_Visibility THEN
		IF VAR_PageSwitch THEN
			IF IN_IOType THEN
				HMI_Data.AnalogOut[VAR_ProgressiveId].Man		:= VAR_Man;
				HMI_Data.AnalogOut[VAR_ProgressiveId].PV_Man	:= DINT_TO_REAL(VAR_ManValue);
			ELSE
				HMI_Data.AnalogIn[VAR_ProgressiveId].Man	:= VAR_Man;
				HMI_Data.AnalogIn[VAR_ProgressiveId].PV_Man	:= DINT_TO_REAL(VAR_ManValue);
			END_IF
			VAR_PageSwitch	:= FALSE;
		END_IF
		
		IF IN_IOType THEN
			HMI_Data.AnalogOut[VAR_ProgressiveId].Visibility	:= IN_Visibility;
			HMI_Data.AnalogOut[VAR_ProgressiveId].Enable		:= NOT IN_ReadOnly AND NOT IN_HMIAutoForce;
			HMI_Data.AnalogOut[VAR_ProgressiveId].PV			:= SEL(VAR_Man, DINT_TO_REAL(ITC), DINT_TO_REAL(VAR_ManValue));
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
			HMI_Data.AnalogIn[VAR_ProgressiveId].PV				:= SEL(VAR_Man, DINT_TO_REAL(ITC), DINT_TO_REAL(VAR_ManValue));
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
			HMI_Data.AnalogIn[VAR_ProgressiveId].Visibility	:= FALSE;
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