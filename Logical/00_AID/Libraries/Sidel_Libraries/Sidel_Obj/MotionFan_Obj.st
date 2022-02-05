FUNCTION_BLOCK MotionFan_Obj
	IF IN_ConfigPresent THEN
		(*****************************************************************)
		(*****************************START*******************************)
		IF VAR_Fault OR NOT IN_Enable THEN
			IO.DO_MotorON := FALSE;
		ELSE
			IO.DO_MotorON := IN_AutoCnd;				
		END_IF
	    
		(*****************************************************************)
		(**************************ALARM LOGIC****************************)
		(*****************************************************************)
		TMR_TON(IN := IO.DO_MotorON,
				PT := IN_FBKDelay);
				
		TMR_TOF(IN := NOT IO.DO_MotorON,
				PT := IN_FBKDelay);
		
		IF IN_Reset THEN
			VAR_ContactorFBK	:= FALSE;
			VAR_Isolated		:= FALSE;
			VAR_Overload		:= FALSE;
		END_IF
			
		IF ((TMR_TON.Q AND IO.DI_ContactorFBK) OR (TMR_TOF.Q AND NOT IO.DI_ContactorFBK)) THEN
			VAR_ContactorFBK := TRUE;
		END_IF
		
		IF NOT IO.DI_ManSwitchON THEN
			VAR_Isolated := TRUE;
		END_IF
		
		IF NOT IO.DI_OverloadOK THEN
			VAR_Overload := TRUE;
		END_IF
		
		VAR_Fault := (VAR_ContactorFBK OR VAR_Isolated OR VAR_Overload);
		
		(*****************************************************************)
		(******************************OUT********************************)
		(*****************************************************************)
		OUT_Running				:= IO.DO_MotorON;
		OUT_IsolatedFault		:= VAR_Isolated;
		OUT_ContactorFBKFault	:= VAR_ContactorFBK;
		OUT_OverloadFault		:= VAR_Overload;
		OUT_Alarm				:= VAR_Fault;
	ELSE
		OUT_Running				:= FALSE;
		OUT_IsolatedFault		:= FALSE;
		OUT_ContactorFBKFault	:= FALSE;
		OUT_OverloadFault		:= FALSE;
		OUT_Alarm				:= FALSE;
		IO.DO_MotorON			:= FALSE;	
	END_IF
END_FUNCTION_BLOCK