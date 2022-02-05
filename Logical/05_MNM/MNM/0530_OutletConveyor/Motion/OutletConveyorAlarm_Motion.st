ACTION OutletConveyorAlarm_Motion: 
	IF NOT IO_OutCvr.DI_ManSwitchON THEN
		ALR[7041].Active	:= TRUE;
	ELSIF AID.DataOut.Reset THEN
		ALR[7041].Active	:= FALSE;
	END_IF
	
	ALR[4638].Active	:= _236DSE.OUT_Alarm;//v1.7.2
	ALR[4633].Active	:= _230DSE.OUT_Alarm;//v1.7.2

END_ACTION
