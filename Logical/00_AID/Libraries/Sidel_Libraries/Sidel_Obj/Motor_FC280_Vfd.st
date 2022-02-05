FUNCTION_BLOCK Motor_FC280_Vfd
	IF NOT VAR_FirstCycle THEN
		HMI_Motor.ManOff	:= FALSE;
		HMI_Motor.ManOn		:= FALSE;	
		VAR_FirstCycle		:= TRUE;
	END_IF
	
	IF IN_ConfigPresent THEN   
		(*****************************************************************)
		(**********************FREQUENCY AND START************************)
		(*****************************************************************)
		IF (EDGENEG(IN_ManEn) AND HMI_Motor.ManOn) OR IN_HMIAutoForce THEN
			HMI_Motor.ManOn	:= FALSE;
			HMI_Motor.ManOff	:= FALSE;
		END_IF
		
		VAR_Mask := HMI_Motor.Mask AND IN_MaskEn;
		VAR_Auto := NOT HMI_Motor.ManOff AND NOT HMI_Motor.ManOn;
		
		IF IN_JOGMode THEN
			VAR_AutoSpeed := 0.0;
			VAR_Start := IN_JOGCnd AND IN_Enable;
		ELSIF HMI_Motor.ManOn THEN
			VAR_AutoSpeed := HMI_Motor.OUT_Man;
			VAR_Start := IN_ManEn AND NOT IN_JOGMode AND IN_Enable;
		ELSIF VAR_Auto THEN
			VAR_AutoSpeed := IN_AutoSpeed;
			VAR_Start := IN_AutoCnd AND NOT IN_JOGMode AND IN_Enable;
		ELSE
			VAR_AutoSpeed := 0.0;
			VAR_Start := FALSE;
		END_IF
		
		VAR_AutoSpeed := LIMIT(IN_FrequencyMin, VAR_AutoSpeed, MIN(IN_FrequencyMax, IN_ScaleMax));
		
		IF NOT VAR_Start THEN
			VAR_AutoSpeed := 0.0;
		END_IF
		
		(*****************************************************************)
		(**************************START/STOP*****************************)
		(*****************************************************************)
		IF (NOT VAR_Isolated AND NOT VAR_RecSTW.Fault
			AND NOT VAR_Event.Over_Current AND NOT VAR_Event.Torque_Limit)
			AND	((IO_MotorFC280.DI_SafetyEnable AND VAR_RecSTW.T37_Ready) OR NOT IN_SafetyCtrlEn) THEN
			VAR_SendCTW.Start := VAR_Start;
		ELSE
			VAR_SendCTW.Start := FALSE;
		END_IF
	
		VAR_SendCTW.Reverse 				:= IN_Reverse;			//0- No function	1- Reverse
		VAR_SendCTW.Quick_Stop				:= NOT IN_QuickStopCmd;	//0- Quick Stop		1- Ramp
		VAR_SendCTW.Reset					:= IN_Reset;			//0- No function	1- Reset
		VAR_SendCTW.Coasting				:= NOT IN_CoastingCmd;	//0- Coasting		1- No Coasting
		VAR_SendCTW.DC_Brake				:= TRUE;				//0- DC Brake		1- Ramp
		VAR_SendCTW.Hold_Output_Frequency	:= TRUE;				//0- Hold Frequency	1- Ramp
		VAR_SendCTW.Data_Valid				:= TRUE;				//0- Data Invalid	1- Data Valid
		
		(*****************************************************************)
		(*****************************FAULT*******************************)
		(*****************************************************************)
		TMR_TON_RFeedBack(	IN := (VAR_SendCTW.Start AND VAR_AutoSpeed > 0) AND NOT OUT_InOperation AND NOT VAR_Mask,
							PT := IN_FBKDelay);
		
		TMR_TON_FaultFilter(	IN := VAR_RecSTW.Fault AND ((IO_MotorFC280.DI_SafetyEnable AND VAR_RecSTW.T37_Ready) OR NOT IN_SafetyCtrlEn),
								PT := T#200ms);
	
		TMR_TON_CurrentHigh(	IN := VAR_CurrentHigh,
								PT := T#5s);
	
		IF TMR_TON_FaultFilter.Q OR TMR_TON_CurrentHigh.Q OR TMR_TON_RFeedBack.Q OR
			VAR_Isolated OR VAR_Overload OR OUT_DriveSafetyFBKFault THEN
			VAR_Fault := TRUE;
		ELSIF IN_Reset THEN
			VAR_Fault := FALSE;
		END_IF
		
		OUT_DriveFault := VAR_Fault;
	
		IF (NOT IO_MotorFC280.DI_ManSwitchON OR (IN_FCD AND IO_MotorFC280.DI_OverloadOK AND NOT VAR_RecDI.T27 )) AND NOT VAR_Mask THEN //V4.A.A.1.6.13
			VAR_Isolated := TRUE;
		ELSIF IN_Reset THEN
			VAR_Isolated := FALSE;
		END_IF
		
		IF NOT IO_MotorFC280.DI_OverloadOK AND NOT VAR_Mask THEN
			VAR_Overload := TRUE;
		ELSIF IN_Reset THEN
			VAR_Overload := FALSE;
		END_IF
	
		TMR_TON_WarningFilter(	IN := (VAR_RecSTW.Warning AND NOT VAR_Mask) AND (IO_MotorFC280.DI_SafetyEnable OR NOT IN_SafetyCtrlEn),
								PT := T#1000ms);
	
		IF TMR_TON_WarningFilter.Q THEN
			OUT_Warning := TRUE;
		ELSIF IN_Reset THEN
			OUT_Warning := FALSE;
		END_IF
		
		(*****************************************************************)
		(********************SAFETY FEEDBACK FAULT************************)
		(*****************************************************************)
		TMR_TON_FBKTimeOut(	IN := ((VAR_RecSTW.T37_Ready XOR IO_MotorFC280.DI_SafetyEnable)) AND IN_SafetyCtrlEn,
							PT := T#3s);
		
		IF TMR_TON_FBKTimeOut.Q OR IO_MotorFC280.DI_SafetyFault THEN
			OUT_DriveSafetyFBKFault := TRUE;
		ELSIF IN_Reset THEN
			OUT_DriveSafetyFBKFault := FALSE;
		END_IF
		
		(*****************************************************************)
		(*************************ACTUAL SPEED****************************)
		(*****************************************************************)
		IO_DanfossFC280.Output.MRW := TRUNC((VAR_AutoSpeed / 100 )* 16384);
	
		IF IO_DanfossFC280.Input.MAV = 0 THEN
			OUT_ActualSpeed := 0;
		ELSE 	
			OUT_ActualSpeed := INT_TO_REAL(IO_DanfossFC280.Input.MAV)/ 16384 * 100;
		END_IF
		(*****************************************************************)
		(*****************************************************************)
		(*****************************************************************)
	
		IO_DanfossFC280.Output.CTW.2		:= VAR_SendCTW.DC_Brake;	(*not used*)
		IO_DanfossFC280.Output.CTW.3		:= VAR_SendCTW.Coasting;	
		IO_DanfossFC280.Output.CTW.4		:= VAR_SendCTW.Quick_Stop;
		IO_DanfossFC280.Output.CTW.5		:= VAR_SendCTW.Hold_Output_Frequency; (*not used*)
		IO_DanfossFC280.Output.CTW.6		:= VAR_SendCTW.Start AND NOT IN_Simulation;
		IO_DanfossFC280.Output.CTW.7		:= VAR_SendCTW.Reset;
		IO_DanfossFC280.Output.CTW.8		:= VAR_SendCTW.Start AND IN_JOGMode;
		IO_DanfossFC280.Output.CTW.10		:= VAR_SendCTW.Data_Valid;	
		IO_DanfossFC280.Output.CTW.15		:= VAR_SendCTW.Reverse;
	
		VAR_RecSTW.Fault 			:= IO_DanfossFC280.Input.STW.3;
		VAR_RecSTW.Warning 			:= IO_DanfossFC280.Input.STW.7;
		VAR_RecSTW.In_Operation 	:= IO_DanfossFC280.Input.STW.11;
//		VAR_RecSTW.T37_Ready 		:= IO_DanfossFC280.Input.STW.15;
		VAR_RecSTW.T37_Ready		:= IO_MotorFC280.DI_SafetyEnable; // da capire con danfoss
		//V4.A.A.1.6.13
		VAR_RecDI.T33				:= IO_DanfossFC280.Input.DigitalInput.0;
		VAR_RecDI.T32				:= IO_DanfossFC280.Input.DigitalInput.1;
		VAR_RecDI.T29				:= IO_DanfossFC280.Input.DigitalInput.2; //FCD:drive on safety
		VAR_RecDI.T27				:= IO_DanfossFC280.Input.DigitalInput.3; //FCD:status of the switch on board
		VAR_RecDI.T19				:= IO_DanfossFC280.Input.DigitalInput.4;
		VAR_RecDI.T18				:= IO_DanfossFC280.Input.DigitalInput.5;
//		VAR_RecDI.T37				:= IO_DanfossFC280.Input.DigitalInput.6; //FCD:safe stop
		
		OUT_ActualCurrent 		:= DINT_TO_REAL(IO_DanfossFC280.Input.ActCurrent) / 100;
		OUT_ActualFrequency		:= UDINT_TO_REAL(IO_DanfossFC280.Input.ActFreq) / 10;
		OUT_ActualPower 		:= DINT_TO_REAL(IO_DanfossFC280.Input.Power) /100;
		OUT_ActualTorque 		:= DINT_TO_REAL(IO_DanfossFC280.Input.Torque)/10;
		OUT_ActualSpeedRPM 		:= DINT_TO_REAL(IO_DanfossFC280.Input.SpeedRPM);
		OUT_SpeedReferece 	    := VAR_RecSTW.In_Operation AND IO_DanfossFC280.Output.CTW.7;
		OUT_InOperation 		:= VAR_RecSTW.In_Operation;
		OUT_IsolatedFault 		:= VAR_Isolated;
		OUT_OverloadFault 		:= VAR_Overload;
	
		(*****************************************************************)
		(****************************EVENT********************************)
		(*****************************************************************)
	
		(* Brake check 16#1*)
		VAR_Event.Brake_Check						:= IO_DanfossFC280.Input.ErrorCode.0;
		(* Power card over temperature 16#2 *)
		VAR_Event.Drive_Over_Temperature			:= IO_DanfossFC280.Input.ErrorCode.1;
		(* Earth fault 16#4 *)
		VAR_Event.Earth_Fault						:= IO_DanfossFC280.Input.ErrorCode.2;
		(* Control card over temperature 16#8 *)
		VAR_Event.Control_Card_Over_Temperature		:= IO_DanfossFC280.Input.ErrorCode.3;
		(* Control word timeout 16#10 *)
		VAR_Event.Controlword_timeout				:= IO_DanfossFC280.Input.ErrorCode.4;
		(* Over current 16#20 *)
		VAR_Event.Over_Current						:= IO_DanfossFC280.Input.ErrorCode.5;
		(* Torque limit 16#40 *)
		VAR_Event.Torque_Limit						:= IO_DanfossFC280.Input.ErrorCode.6;
		(* Motor thermistor over temp. 16#80 *)
		VAR_Event.Motor_Thermistor_Over_Temp		:= IO_DanfossFC280.Input.ErrorCode.7;
		(* Motor ETR over temperature 16#100 *)
		VAR_Event.Motor_ETR_Over_Temperature		:= IO_DanfossFC280.Input.ErrorCode.8;
		(* Inverter overloaded 16#200 *)
		VAR_Event.Inverter_Over_Loaded				:= IO_DanfossFC280.Input.ErrorCode.9;
		(* DC Link unver voltage 16#400 *)
		VAR_Event.DC_Link_Under_Voltage				:= IO_DanfossFC280.Input.ErrorCode.10;
		(* DC Link over voltage 16#800 *)
		VAR_Event.DC_Link_Over_Voltage				:= IO_DanfossFC280.Input.ErrorCode.11;
		(* Short circuit 16#1000 *)
		VAR_Event.Short_Circuit						:= IO_DanfossFC280.Input.ErrorCode.12;
		(* Inrush fault 16#2000 *)
		VAR_Event.Inrush_Fault						:= IO_DanfossFC280.Input.ErrorCode.13;
		(* Main phase loss 16#4000 *)
		VAR_Event.Mains_Phase_Loss					:= IO_DanfossFC280.Input.ErrorCode.14;
		(* AMA not ok 16#8000 *)
		VAR_Event.AMA_not_OK						:= IO_DanfossFC280.Input.ErrorCode.15;
		(* Live zero error 16# 10000 *)
		VAR_Event.Live_Zero_Error					:= IO_DanfossFC280.Input.ErrorCode.16;
		(* Internal Fault 16#20000 *)
		VAR_Event.Internal_Fault					:= IO_DanfossFC280.Input.ErrorCode.17;
		(* Brake overload 16#40000 *)
		VAR_Event.Brake_Resistor_Power_Limit		:= IO_DanfossFC280.Input.ErrorCode.18;
		(* Motor phase U is missing 16#80000 *)
		VAR_Event.Motor_Phase_U_Missing				:= IO_DanfossFC280.Input.ErrorCode.19;
		(* Motor phase V is missing 16#100000 *)
		VAR_Event.Motor_Phase_V_Missing				:= IO_DanfossFC280.Input.ErrorCode.20;
		(* Motor phase W is missing 16#200000 *)
		VAR_Event.Motor_Phase_W_Missing				:= IO_DanfossFC280.Input.ErrorCode.21;
		(* Fieldbus comm. fault 16#400000 *)
		VAR_Event.Fieldbus_Communication_Fault		:= IO_DanfossFC280.Input.ErrorCode.22;
		(* 24V supply fault 16#800000 *)
		VAR_Event._24V_Supply_Fault					:= IO_DanfossFC280.Input.ErrorCode.23;
		(* Mains failure 16#1000000 *)
		VAR_Event.Mains_Faliure						:= IO_DanfossFC280.Input.ErrorCode.24;
		(* 1.8V supply fault 16#2000000 *)
		VAR_Event._2V_Supply_Fault					:= IO_DanfossFC280.Input.ErrorCode.25;
		(* Brake resistor short circuit 16#4000000 *)
		VAR_Event.Brake_Resistor_Short_Circuit		:= IO_DanfossFC280.Input.ErrorCode.26;
		(* Brake chopper fault 16#8000000 *)
		VAR_Event.Brake_Chopper_Fault				:= IO_DanfossFC280.Input.ErrorCode.27;
		(* Option change 16#10000000 *)
		VAR_Event.Configuration_Option_Change		:= IO_DanfossFC280.Input.ErrorCode.28;
		(* Drive initialisation 16#20000000 *)
		VAR_Event.Drive_Initialisation				:= IO_DanfossFC280.Input.ErrorCode.29;
		(* Safe stop 16#40000000 *)
		VAR_Event.Safe_Stop							:= IO_DanfossFC280.Input.ErrorCode.30;
		(* Mechanical brake low 16#80000000 *)
		VAR_Event.Mecanical_Brake_Low				:= IO_DanfossFC280.Input.ErrorCode.31;
		
		VAR_CurrentHigh								:= IO_DanfossFC280.Input.STW_EX.7 ;
	   
		(*****************************************************************)
		(******************************HMI********************************)
		(*****************************************************************)
		HMI_Motor.ConfigPresent	:= IN_ConfigPresent;
		HMI_Motor.Alarm			:= OUT_DriveFault;
		HMI_Motor.FeedBack		:= OUT_DriveSafetyFBKFault AND NOT VAR_Overload;
		HMI_Motor.Isolated		:= VAR_Isolated;
		HMI_Motor.Overload		:= VAR_Overload;
		HMI_Motor.Out			:= OUT_InOperation;
		HMI_Motor.MaskEnable	:= IN_MaskEn;
		HMI_Motor.ManEnable		:= IN_ManEn;
	   	HMI_Motor.OUT_CV		:= OUT_ActualFrequency;
		
		HMI_Danfoss.PCV.Alarm					:= (UDINT_TO_DINT (IO_DanfossFC280.Input.ErrorCode));
		HMI_Danfoss.PCD_Read.Frequency			:= OUT_ActualFrequency;
		HMI_Danfoss.PCD_Read.Main_Actual_Value	:= OUT_ActualSpeed;
		HMI_Danfoss.PCD_Read.Power				:= OUT_ActualPower;
		HMI_Danfoss.PCD_Read.Status_Word		:= IO_DanfossFC280.Input.STW;
		HMI_Danfoss.PCD_Read.Torque				:= OUT_ActualTorque;
		HMI_Danfoss.PCD_Read.Motor_Current		:= OUT_ActualCurrent;
		HMI_Danfoss.PCD_Read.Speed_RPM			:= OUT_ActualSpeedRPM;	
	ELSE
		memset(ADR(HMI_Danfoss), 0, SIZEOF(HMI_Danfoss));
	END_IF
END_FUNCTION_BLOCK