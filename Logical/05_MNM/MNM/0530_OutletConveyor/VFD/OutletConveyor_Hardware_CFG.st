ACTION OutletConveyor_Hardware_CFG:
	(*****MOTORS*****)//For Inverter Model FC302, old Hardware standard  
//	_OutCvr.IN_ConfigPresent	:= FALSE;
//	_OutCvr.IN_SafetyCtrlEn		:= TRUE;
//	_OutCvr.IN_Simulation		:= FALSE;
//	_OutCvr.IN_FBKDelay			:= t#1200ms;
	
	(*****MOTORS*****)//For Inverter Model FC280, new Hardware standard  
	_OutCvrFC280.IN_ConfigPresent	:= TRUE;
	_OutCvrFC280.IN_SafetyCtrlEn		:= TRUE;
	_OutCvrFC280.IN_Simulation		:= FALSE;
	_OutCvrFC280.IN_FBKDelay			:= t#1200ms;
	(*****SENSORS*****)
	// Exit Spot #1
	_230DSE.IN_ConfigPresent	:= TRUE;
	_230DSE.IN_Alarm			:= TRUE;
	_230DSE.IN_OffDelay			:= t#0s;
	_230DSE.IN_OnDelay			:= t#500ms;
	_230DSE.IN_SwitchDelay		:= t#0ms;	
	// Outlet Conveyor Guide
	_236DSE.IN_ConfigPresent	:= FALSE;
	_236DSE.IN_Alarm			:= TRUE;
	_236DSE.IN_OffDelay			:= t#0s;
	_236DSE.IN_OnDelay			:= t#500ms;
	_236DSE.IN_SwitchDelay		:= t#0ms;
	
END_ACTION
