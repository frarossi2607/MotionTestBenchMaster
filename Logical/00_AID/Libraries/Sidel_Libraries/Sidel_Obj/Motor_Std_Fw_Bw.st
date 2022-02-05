FUNCTION_BLOCK Motor_Std_Fw_Bw
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
			IO.DO_MotorFw := FALSE;
			IO.DO_MotorBw := FALSE;
		ELSIF VAR_Auto AND NOT IN_Backward THEN
			IO.DO_MotorFw := IN_AutoCnd;
			IO.DO_MotorBw := FALSE;
		ELSIF VAR_Auto AND IN_Backward THEN
			IO.DO_MotorFw := FALSE;
			IO.DO_MotorBw := IN_AutoCnd;
		ELSIF NOT VAR_Auto AND NOT IN_Backward	THEN		
			IO.DO_MotorFw := HMI.ManOn;
		ELSIF NOT VAR_Auto AND IN_Backward	THEN		
			IO.DO_MotorBw := HMI.ManOn;
		END_IF
	    
		IF NOT IN_FbkCheck THEN
			IO.DI_ContactorFBK := NOT IO.DO_MotorFw AND NOT IO.DO_MotorBw;
		END_IF
		(*****************************************************************)
		(**************************ALARM LOGIC****************************)
		(*****************************************************************)
		TMR_TON(IN := IO.DO_MotorFw OR IO.DO_MotorBw ,
				PT := IN_FBKDelay);
				
		TMR_TOF(IN := NOT IO.DO_MotorFw AND NOT IO.DO_MotorBw,
				PT := IN_FBKDelay);
		
		IF IN_Reset THEN
			VAR_ContactorFBK	:= FALSE;
			VAR_Overload		:= FALSE;
			VAR_DiFault			:= FALSE;
		END_IF
			
		IF ((TMR_TON.Q AND IO.DI_ContactorFBK) OR (TMR_TOF.Q AND NOT IO.DI_ContactorFBK)) AND NOT IN_ConfigType AND NOT VAR_Mask THEN
			VAR_ContactorFBK := NOT IN_Simulation;
		END_IF
		
		IF IO.DI_Fault AND NOT VAR_Mask THEN
			VAR_DiFault := NOT IN_Simulation;
		END_IF
		
		IF NOT IO.DI_ManSwitchON AND NOT VAR_Mask THEN
			VAR_Isolated := NOT IN_Simulation;
		END_IF
		
		IF NOT IO.DI_OverloadOK AND NOT IN_ConfigType AND NOT VAR_Mask THEN
			VAR_Overload := NOT IN_Simulation;
		END_IF
		
		VAR_Fault := (VAR_ContactorFBK OR VAR_Isolated OR VAR_DiFault OR VAR_Overload AND IN_Enable) AND NOT IN_Simulation;
		
		(*****************************************************************)
		(******************************HMI********************************)
		(*****************************************************************)
		HMI.Out				:= IO.DO_MotorFw OR IO.DO_MotorBw;
		HMI.Alarm			:= VAR_Fault;
		HMI.Isolated		:= VAR_Isolated;
		HMI.Overload		:= VAR_Overload;
		HMI.FeedBack		:= VAR_ContactorFBK;
		HMI.ConfigPresent	:= IN_ConfigPresent;
		HMI.ManEnable		:= IN_ManEn;
		HMI.MaskEnable		:= IN_MaskEn;
	
		(*****************************************************************)
		(******************************OUT********************************)
		(*****************************************************************)
		OUT_Running				:= IO.DO_MotorFw OR IO.DO_MotorBw;
		OUT_IsolatedFault		:= VAR_Isolated;
		OUT_ContactorFBKFault	:= VAR_ContactorFBK;
		OUT_OverloadFault		:= VAR_Overload;
		OUT_Alarm				:= VAR_Fault;
	ELSE
		memset(ADR(HMI), 0, SIZEOF(HMI));
		OUT_Running				:= FALSE;
		OUT_ContactorFBKFault	:= FALSE;
		OUT_OverloadFault		:= FALSE;
		OUT_Alarm				:= FALSE;
		IO.DO_MotorFw 			:= FALSE;
		IO.DO_MotorBw           := FALSE;
	END_IF
END_FUNCTION_BLOCK