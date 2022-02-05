ACTION InletConveyorAlarm_VFD: 
//	
//	ALR[7029].Active		:= _InCvr.OUT_OverloadFault;
//	ALR[7031].Active		:= _InCvr.OUT_IsolatedFault;
//	ALR[7032].Active		:= _InCvr.OUT_DriveFault;
	
	ALR[7029].Active		:= _InCvrFC280.OUT_OverloadFault;
	ALR[7031].Active		:= _InCvrFC280.OUT_IsolatedFault;
	ALR[7032].Active		:= _InCvrFC280.OUT_DriveFault;
END_ACTION
