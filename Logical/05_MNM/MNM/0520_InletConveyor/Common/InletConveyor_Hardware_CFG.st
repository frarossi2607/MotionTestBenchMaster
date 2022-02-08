ACTION InletConveyor_Hardware_CFG:
	(*****SENSORS*****)
	InletSafetyLow1.IN_ConfigPresent	:= TRUE;
	InletSafetyLow1.IN_OffDelay			:= t#200ms;
	InletSafetyLow1.IN_OnDelay			:= t#200ms;
	InletSafetyLow1.IN_SwitchDelay		:= t#0ms;
	
	InletSafetyHigh1.IN_ConfigPresent	:= TRUE;
	InletSafetyHigh1.IN_OffDelay		:= t#200ms;
	InletSafetyHigh1.IN_OnDelay			:= t#200ms;
	InletSafetyHigh1.IN_SwitchDelay		:= t#0ms;
	
	InletSafetyLow2.IN_ConfigPresent	:= FALSE;
	InletSafetyLow2.IN_OffDelay			:= t#200ms;
	InletSafetyLow2.IN_OnDelay			:= t#200ms;
	InletSafetyLow2.IN_SwitchDelay		:= t#0ms;
	
	InletSafetyHigh2.IN_ConfigPresent	:= FALSE;
	InletSafetyHigh2.IN_OffDelay		:= t#200ms;
	InletSafetyHigh2.IN_OnDelay			:= t#200ms;
	InletSafetyHigh2.IN_SwitchDelay		:= t#0ms;
	
//	(*****MOTORS*****)//For Inverter Model FC302, old Hardware standard  
//	_InCvr.IN_ConfigPresent			:= FALSE;
//	_InCvr.IN_SafetyCtrlEn			:= TRUE;
//	_InCvr.IN_Simulation			:= FALSE;
//	_InCvr.IN_FBKDelay				:= t#1200ms;
	
	(*****MOTORS*****)//For Inverter Model FC280, new Hardware standard  
	_InCvrFC280.IN_ConfigPresent	:= TRUE;
	_InCvrFC280.IN_SafetyCtrlEn		:= TRUE;
	_InCvrFC280.IN_Simulation		:= FALSE;
	_InCvrFC280.IN_FBKDelay			:= t#1200ms;
	
END_ACTION
