FUNCTION_BLOCK UVtronic_Std
	IF NOT VAR_FirstCycle THEN
		HMI.ManOff		:= FALSE;
		HMI.ManOn		:= FALSE;	
		VAR_FirstCycle	:= TRUE;
	END_IF

	IF IN_ConfigPresent THEN
		(*****************************************************************)
		(*****************************START*******************************)
		(*****************************************************************)
		IF (EDGENEG(IN_ManEn) AND HMI.ManOn) OR IN_HMIAutoForce THEN
			HMI.ManOn	:= FALSE;
			HMI.ManOff	:= FALSE;
		END_IF
		
		VAR_Mask := HMI.Mask AND IN_MaskEn;
		VAR_Auto := NOT HMI.ManOff AND NOT HMI.ManOn;
		
		IF VAR_Fault OR NOT IN_Enable THEN
			IO.DO_MotorON := FALSE;
		ELSIF VAR_Auto THEN
			IO.DO_MotorON := IN_AutoCnd;				
		ELSE			
			IO.DO_MotorON := HMI.ManOn;
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
			VAR_GeneralFault	:= FALSE;
			VAR_Overload		:= FALSE;
			VAR_NotReady		:= FALSE;
		END_IF
			
		IF ((TMR_TON.Q AND IO.DI_ContactorFBK) OR (TMR_TOF.Q AND NOT IO.DI_ContactorFBK)) AND NOT IN_ConfigType AND NOT VAR_Mask THEN
			VAR_ContactorFBK := NOT IN_Simulation;
		END_IF
		
		IF IO.DI_GeneralFault AND NOT VAR_Mask THEN
			VAR_GeneralFault := NOT IN_Simulation;
		END_IF
		
		IF NOT IO.DI_OverloadOK AND NOT IN_ConfigType AND NOT VAR_Mask THEN
			VAR_Overload := NOT IN_Simulation;
		END_IF
		
		IF NOT IO.DI_Ready AND NOT VAR_Mask THEN
			VAR_NotReady := NOT IN_Simulation;
		END_IF
		
		VAR_Fault := (VAR_ContactorFBK OR VAR_GeneralFault OR VAR_Overload OR VAR_NotReady AND IN_Enable) AND NOT IN_Simulation;
		
		(*****************************************************************)
		(******************************HMI********************************)
		(*****************************************************************)
		HMI.Out				:= IO.DO_MotorON;
		HMI.Alarm			:= VAR_Fault;
		HMI.Isolated		:= FALSE;
		HMI.Overload		:= VAR_Overload;
		HMI.FeedBack		:= VAR_ContactorFBK;
		HMI.ConfigPresent	:= IN_ConfigPresent;
		HMI.ManEnable		:= IN_ManEn;
		HMI.MaskEnable		:= IN_MaskEn;
	
		(*****************************************************************)
		(******************************OUT********************************)
		(*****************************************************************)
		OUT_Running				:= IO.DO_MotorON;
		OUT_NotReady			:= VAR_NotReady;
		OUT_GeneralFault		:= VAR_GeneralFault;
		OUT_ContactorFBKFault	:= VAR_ContactorFBK;
		OUT_OverloadFault		:= VAR_Overload;
		OUT_Alarm				:= VAR_Fault;
	ELSE
		memset(ADR(HMI), 0, SIZEOF(HMI));
		OUT_Running				:= FALSE;
		OUT_NotReady			:= FALSE;
		OUT_GeneralFault		:= FALSE;
		OUT_ContactorFBKFault	:= FALSE;
		OUT_OverloadFault		:= FALSE;
		OUT_Alarm				:= FALSE;
		IO.DO_MotorON			:= FALSE;	
	END_IF
END_FUNCTION_BLOCK