ACTION OutletConveyorSeq_Run_VFD:	
	//v1.61 New Management
	VAR_MNM_OutCvrAlarm			:= ALR[4633].Active OR ALR[4638].Active OR ALR[7039].Active OR ALR[7041].Active OR ALR[7042].Active;
	_OutCvr.IN_AutoCnd			:= FALSE;
	_OutCvr.IN_AutoSpeed		:= 0.0;
	
	//VAR_MNM_OptionNoGripper -> To be setted
	VAR_MNM_OptionNoGripper := TRUE;//VAR_MNM_OptionNoGripper := TRUE means that the outlet starwheel is without gripper //V4.A.A.1.6.6
									//VAR_MNM_OptionNoGripper := FALSE means that the outlet starwheel is with gripper //V4.A.A.1.6.6
	
	//Speed Linearization
	FB_ScalConveyor(
	x	:= MC_InputOutput.Network.Machine.Status.ActualSpeed,
	x1	:= 0.0,
	y1	:= 0.0,
	x2	:= MC_InputOutput.Network.Machine.Status.MachineMaxSpeed * 1.1,
	y2	:= _OutCvr.IN_FrequencyMax + (_OutCvr.IN_FrequencyMax * HMI_PAR_1._162 / 100.0) * 1.1,
	);
	
	//Speed Limit Threshold
	VAR_MNM_OutCvrFixSpeedLimit := MC_InputOutput.Network.Machine.Status.ActualSpeed > 10000.0;
	
	//Fixed Speed Calculation
	IF EDGEPOS(VAR_MNM_OutCvrFixSpeedLimit) OR EDGENEG(VAR_MNM_OutCvrFixSpeedLimit) THEN
		VAR_MNM_OutCvrFixSpeed		:= FB_ScalConveyor.y;	
	END_IF	
	
	//Fixed Speed Calculation in case of data loss
	IF VAR_MNM_OutCvrFixSpeed = 0 THEN
		VAR_MNM_OutCvrFixSpeed		:= 20.0;
	END_IF	
	
	//State Management
	CASE VAR_MNM_OutletConveyorSeq_VFD OF
		MNM_OutCvrIdle:		
			IF VAR_MNM_ConveyorProduction THEN//v1.61
				VAR_MNM_OutletConveyorSeq_VFD := MNM_OutCvrAuto;
			ELSIF VAR_MNM_ConveyorClean THEN
				_OutCvr.IN_AutoCnd	:= TRUE;
				VAR_MNM_OutletConveyorSeq_VFD := MNM_OutCvrCleaning;
			ELSIF VAR_MNM_OutCvrAlarm THEN
				VAR_MNM_OutletConveyorSeq_VFD := MNM_OutCvrFault;
			END_IF
		
		MNM_OutCvrAuto:
			
			_OutCvr.IN_AutoCnd		:= FB_ScalConveyor.y>0.0;//V4.A.A.1.6.6
			_OutCvr.IN_AutoSpeed	:= FB_ScalConveyor.y;
			
			IF NOT VAR_MNM_ConveyorProduction THEN	
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrIdle;
			ELSIF VAR_MNM_ConveyorProduction AND VAR_MNM_OptionNoGripper AND VAR_MNM_OutCvrFixSpeedLimit THEN//v1.61
				VAR_MNM_OutletConveyorSeq_VFD := MNM_OutCvrAutoOption;//v1.61
			ELSIF VAR_MNM_OutCvrAlarm THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrFault;
			END_IF
		
		MNM_OutCvrAutoOption:
			
			_OutCvr.IN_AutoCnd		:= FB_ScalConveyor.y>0.0;//V4.A.A.1.6.6
			_OutCvr.IN_AutoSpeed	:= FB_ScalConveyor.y;
		
			IF NOT VAR_MNM_ConveyorProduction OR (NOT VAR_MNM_OutCvrFixSpeedLimit AND NOT MC_InputOutput.Network.Machine.Commands.MachineStart) THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrAutoFixSpeed;
			ELSIF VAR_MNM_OutCvrAlarm THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrFault;
			END_IF
				
		MNM_OutCvrAutoFixSpeed:
			_OutCvr.IN_AutoCnd			:= FB_ScalConveyor.y>0.0;//V4.A.A.1.6.6
			TMR_TON_MNM_OutCvrFix.IN 	:= TRUE;
			
			IF MC_InputOutput.Network.Machine.Commands.MachineStart OR VAR_MNM_OutCvrFixSpeedLimit THEN
				_OutCvr.IN_AutoSpeed 		:= FB_ScalConveyor.y;
			ELSIF NOT VAR_MNM_OutCvrFixSpeedLimit AND NOT MC_InputOutput.Network.Machine.Commands.MachineStart THEN
				_OutCvr.IN_AutoSpeed 		:= VAR_MNM_OutCvrFixSpeed;
			END_IF
			
			IF MC_InputOutput.Network.Machine.Commands.MachineStart AND VAR_MNM_ConveyorProduction THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrAuto;
			ELSIF TMR_TON_MNM_OutCvrFix.Q THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrAutoRampDown;
				VAR_MNM_OutCvrRampDwStart		:= _OutCvr.IN_AutoSpeed;
			ELSIF VAR_MNM_OutCvrAlarm THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrFault;
			END_IF
		
		MNM_OutCvrAutoRampDown:
			_OutCvr.IN_AutoCnd			:= TRUE;
			_OutCvr.IN_AutoSpeed 		:= VAR_MNM_OutCvrRampDwStart - 
											(VAR_MNM_OutCvrRampDwStart * (UDINT_TO_REAL(TIME_TO_UDINT(TMR_TON_MNM_OutCvrRamp.ET))) /
											(UDINT_TO_REAL(TIME_TO_UDINT(TMR_TON_MNM_OutCvrRamp.PT))));
			TMR_TON_MNM_OutCvrRamp.IN 	:= TRUE;
			
			IF MC_InputOutput.Network.Machine.Commands.MachineStart AND VAR_MNM_ConveyorProduction THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrAuto;
			ELSIF TMR_TON_MNM_OutCvrRamp.Q THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrIdle;
			ELSIF VAR_MNM_OutCvrAlarm THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrFault;
			END_IF
		
		MNM_OutCvrCleaning:
			_OutCvr.IN_AutoCnd		:= TRUE;
			_OutCvr.IN_AutoSpeed	:= 20.0;
			
			IF NOT VAR_MNM_ConveyorClean THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrIdle;
			ELSIF VAR_MNM_OutCvrAlarm THEN
				VAR_MNM_OutletConveyorSeq_VFD	:= MNM_OutCvrFault;
			END_IF
		
		MNM_OutCvrFault:
			IF AID.DataOut.Reset THEN
				VAR_MNM_OutletConveyorSeq_VFD := MNM_OutCvrIdle;
			END_IF
	END_CASE
	

	TMR_TON_MNM_OutCvrFix	(IN:= (VAR_MNM_OutletConveyorSeq_VFD = MNM_OutCvrAutoFixSpeed), PT := t#120s);//<<Change this time to decide how long the conveyour runs after the last bottle or machine stop.
	TMR_TON_MNM_OutCvrRamp	(IN:= (VAR_MNM_OutletConveyorSeq_VFD = MNM_OutCvrAutoRampDown), PT := t#5s);
END_ACTION