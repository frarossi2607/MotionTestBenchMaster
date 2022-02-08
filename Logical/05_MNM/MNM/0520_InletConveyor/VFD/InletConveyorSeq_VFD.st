ACTION InletConveyorSeq_Run_VFD:	

	VAR_MNM_InCvrAlarm			:= ALR[7029].Active OR ALR[7031].Active OR ALR[7032].Active;
	_InCvrFC280.IN_AutoCnd			:= FALSE;
	_InCvrFC280.IN_AutoSpeed		:= 0.0;
	
	//Speed Linearization
	FB_ScalConveyorInlet(
	x	:= MC_InputOutput.Network.Machine.Status.ActualSpeed,
	x1	:= 0.0,
	y1	:= 0.0,
	x2	:= MC_InputOutput.Network.Machine.Status.MachineMaxSpeed * 1.1,
	y2	:= _InCvrFC280.IN_FrequencyMax + (_InCvrFC280.IN_FrequencyMax * HMI_PAR_1._160 / 100.0) * 1.1,
	);	
	
	//State Management
	CASE VAR_MNM_InletConveyorSeq_VFD OF
		MNM_InCvrIdle:		
			IF MNM.DataOut.MachineRunning AND NOT COP.DataOut.RcpActive AND NOT OPS.DataOut.FlrModeSelectorAdjustment THEN
				VAR_MNM_InletConveyorSeq_VFD := MNM_InCvrAuto;
			ELSIF COP.DataOut.RcpActive THEN
				_InCvrFC280.IN_AutoCnd	:= TRUE;
				VAR_MNM_InletConveyorSeq_VFD := MNM_InCvrCleaning;
			ELSIF VAR_MNM_InCvrAlarm THEN
				VAR_MNM_InletConveyorSeq_VFD := MNM_InCvrFault;
			END_IF
		
		MNM_InCvrAuto:
			
			_InCvrFC280.IN_AutoCnd		:= FB_ScalConveyorInlet.y>0.0;
			_InCvrFC280.IN_AutoSpeed	:= FB_ScalConveyorInlet.y;
			
			IF NOT MNM.DataOut.MachineRunning THEN	
				VAR_MNM_InletConveyorSeq_VFD	:= MNM_InCvrIdle;
			ELSIF VAR_MNM_InCvrAlarm THEN
				VAR_MNM_InletConveyorSeq_VFD	:= MNM_InCvrFault;
			END_IF
		
				
		MNM_InCvrCleaning:
			_InCvrFC280.IN_AutoCnd		:= MC_InputOutput.Network.Machine.Status.MachineRunning;
			_InCvrFC280.IN_AutoSpeed	:= 10.0;
			
			IF NOT COP.DataOut.RcpActive THEN
				VAR_MNM_InletConveyorSeq_VFD	:= MNM_InCvrIdle;
			ELSIF VAR_MNM_InCvrAlarm THEN
				VAR_MNM_InletConveyorSeq_VFD	:= MNM_InCvrFault;
			END_IF
		
		MNM_InCvrFault:
			IF AID.DataOut.Reset THEN
				VAR_MNM_InletConveyorSeq_VFD := MNM_InCvrIdle;
			END_IF
	END_CASE
	

	TMR_TON_MNM_InCvrFix	(IN:= (VAR_MNM_InletConveyorSeq_VFD = MNM_InCvrAutoFixSpeed), PT := t#120s);
	TMR_TON_MNM_InCvrRamp	(IN:= (VAR_MNM_InletConveyorSeq_VFD = MNM_InCvrAutoRampDown), PT := t#5s);
END_ACTION