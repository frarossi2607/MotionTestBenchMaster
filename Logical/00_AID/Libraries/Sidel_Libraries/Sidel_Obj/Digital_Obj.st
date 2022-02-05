FUNCTION_BLOCK Digital_Obj
	IF IN_ConfigPresent THEN
		VAR_Mask := IN_MaskEn AND HMI.Mask;
		IF VAR_Mask THEN
			VAR_Signal := IN_WaitOn AND NOT IN_WaitOff;
		ELSE
			VAR_Signal := IO.DI_Input;
		END_IF
	
		TMR_TON_SwOn(	IN := VAR_Signal,
						PT := IN_SwitchDelay);
	
		TMR_TON_SwOff(	IN := NOT VAR_Signal,
						PT := IN_SwitchDelay);
		
		IF TMR_TON_SwOn.Q THEN 
			HMI.On := TRUE;
		ELSIF TMR_TON_SwOff.Q THEN
			HMI.On := FALSE;
		END_IF
	
		TMR_TON_OnAlarm(	IN := IN_Alarm AND IN_AlarmOnReq AND HMI.On AND NOT VAR_Mask,
							PT := IN_OnDelay);
	
		TMR_TON_OffAlarm(	IN := IN_Alarm AND IN_AlarmOffReq AND NOT HMI.On AND NOT VAR_Mask,
							PT := IN_OffDelay);
		
		IF (TMR_TON_OnAlarm.Q OR TMR_TON_OffAlarm.Q) THEN
			OUT_Alarm := TRUE;
		ELSIF IN_Reset THEN
			OUT_Alarm := FALSE ;
		END_IF
		
		TMR_TON_OnTime(	IN := HMI.On,
						PT := IN_OnDelay);
	
		TMR_TON_OffTime(IN := NOT HMI.On,
						PT := IN_OffDelay);
		
		OUT_OnDelayed	:= TMR_TON_OnTime.Q;
		OUT_OffDelayed	:= TMR_TON_OffTime.Q;
		
		OUT					:= HMI.On;
		HMI.ConfigPresent 	:= IN_ConfigPresent;
		HMI.ConfigAlarm 	:= IN_Alarm OR IN_MaskEn;	
		HMI.Alarm 			:= OUT_Alarm; 
		HMI.Wait			:= (IN_WaitOn AND NOT HMI.On) OR (IN_WaitOff AND HMI.On);	
		HMI.MaskEnable		:= IN_MaskEn;
	ELSE
		OUT_Alarm			:= FALSE;
		OUT					:= FALSE;
		OUT_OffDelayed		:= FALSE;
		OUT_OnDelayed		:= FALSE;
		HMI.On 				:= FALSE;
		HMI.MaskEnable		:= FALSE;
		HMI.ConfigPresent 	:= FALSE;
		HMI.ConfigAlarm 	:= FALSE;	
		HMI.Alarm 			:= FALSE;
		HMI.Wait			:= FALSE;
	END_IF
END_FUNCTION_BLOCK

FUNCTION_BLOCK GateDoorDigital_Obj
	IF IN_ConfigPresent THEN
		VAR_Signal := IO_Production.DI_Input;
	
		TMR_TON_ProdSwOn(	IN := VAR_Signal,
			PT := IN_SwitchDelay);
	
		TMR_TON_ProdSwOff(	IN := NOT VAR_Signal,
			PT := IN_SwitchDelay);
		
		IF TMR_TON_ProdSwOn.Q THEN 
			HMI.Production.On := TRUE;
		ELSIF TMR_TON_ProdSwOff.Q THEN
			HMI.Production.On := FALSE;
		END_IF
		
		//Controllo se il sensore di Produzione è impegnato durante il CIP (AlarmOpenReq)
		TMR_TON_ProdOnAlarm(	IN := IN_Alarm AND IN_AlarmOpenReq AND HMI.Production.On AND NOT HMI.Production.Mask,
			PT := IN_OnDelay);
	
		//Controllo se il sensore di Produzione è disimpegnato durante la Produzione (AlarmCloseReq)
		TMR_TON_ProdOffAlarm(	IN := IN_Alarm AND IN_AlarmCloseReq AND NOT HMI.Production.On AND NOT HMI.Production.Mask,
			PT := IN_OffDelay);
				
		VAR_Signal := IN_SafetyClosed;
	
		TMR_TON_CleanSwOn(	IN := VAR_Signal,
			PT := IN_SwitchDelay);
	
		TMR_TON_CleanSwOff(	IN := NOT VAR_Signal,
			PT := IN_SwitchDelay);
		
		IF TMR_TON_CleanSwOn.Q THEN 
			HMI.Cleaning.On := TRUE;
		ELSIF TMR_TON_CleanSwOff.Q THEN
			HMI.Cleaning.On := FALSE;
		END_IF
	
		//Controllo se il sensore di CIP è impegnato durante il Produzione (AlarmCloseReq)
		TMR_TON_CleanOnAlarm(	IN := IN_Alarm AND IN_AlarmCloseReq AND HMI.Cleaning.On AND NOT HMI.Cleaning.Mask,
			PT := IN_OnDelay);
		
		//Controllo se il sensore di CIP è impegnato durante il CIP (AlarmOpenReq)
		TMR_TON_CleanOffAlarm(	IN := IN_Alarm AND IN_AlarmOpenReq AND NOT HMI.Cleaning.On AND NOT HMI.Cleaning.Mask,
			PT := IN_OffDelay);
		
		VAR_ProdFault	:= (TMR_TON_ProdOnAlarm.Q OR TMR_TON_ProdOffAlarm.Q) OR (HMI.Production.On AND HMI.Cleaning.On);
		VAR_CleanFault	:= (TMR_TON_CleanOnAlarm.Q OR TMR_TON_CleanOffAlarm.Q) OR (HMI.Production.On AND HMI.Cleaning.On);

		IF VAR_ProdFault OR VAR_CleanFault THEN
			OUT_Alarm := TRUE;
		ELSIF IN_Reset THEN
			OUT_Alarm := FALSE ;
		END_IF
		
		OUT_Opened	:= HMI.Production.On AND NOT HMI.Cleaning.On;
		OUT_Closed	:= NOT HMI.Production.On AND HMI.Cleaning.On;
		
		HMI.Opened						:= OUT_Opened;
		HMI.ShortSafety					:= IN_SafetyShortCircuit;
		HMI.Production.ConfigPresent 	:= IN_ConfigPresent;
		HMI.Cleaning.ConfigPresent 		:= IN_ConfigPresent;
		HMI.Production.MaskEnable		:= FALSE;
		HMI.Cleaning.MaskEnable			:= FALSE;
		HMI.Production.ConfigAlarm 		:= IN_Alarm;	
		HMI.Cleaning.ConfigAlarm 		:= IN_Alarm;
		HMI.Production.Alarm			:= VAR_ProdFault;
		HMI.Cleaning.Alarm				:= VAR_CleanFault;
		HMI.Production.Wait				:= (IN_WaitOpen AND NOT HMI.Production.On);
		HMI.Cleaning.Wait				:= (IN_WaitClose AND NOT HMI.Cleaning.On);
	ELSE
		OUT_Alarm						:= FALSE;
		OUT_Opened						:= IN_AlarmOpenReq;
		OUT_Closed						:= IN_AlarmCloseReq;
		HMI.Opened						:= TRUE;
		HMI.ShortSafety					:= FALSE;
		HMI.Production.On				:= TRUE;
		HMI.Cleaning.On					:= FALSE;
		HMI.Production.ConfigPresent 	:= FALSE;
		HMI.Cleaning.ConfigPresent 		:= FALSE;
		HMI.Production.MaskEnable		:= FALSE;
		HMI.Cleaning.MaskEnable			:= FALSE;
		HMI.Production.ConfigAlarm 		:= FALSE;	
		HMI.Cleaning.ConfigAlarm 		:= FALSE;
		HMI.Production.Alarm			:= FALSE;
		HMI.Cleaning.Alarm				:= FALSE;
		HMI.Production.Wait				:= FALSE;
		HMI.Cleaning.Wait				:= FALSE;
	END_IF
END_FUNCTION_BLOCK