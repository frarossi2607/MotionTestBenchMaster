ACTION OutletConveyorAlarm_VFD: 
//	ALR[7039].Active		:= _OutCvr.OUT_OverloadFault;//Management with FC302
//	ALR[7041].Active		:= _OutCvr.OUT_IsolatedFault//Management with FC302
//	ALR[7042].Active		:= _OutCvr.OUT_DriveFault//Management with FC302
	
	ALR[7039].Active		:= _OutCvrFC280.OUT_OverloadFault;
	ALR[7041].Active		:= _OutCvrFC280.OUT_IsolatedFault;
	ALR[7042].Active		:= _OutCvrFC280.OUT_DriveFault;
	
	ALR[4638].Active	:= _236DSE.OUT_Alarm;
	ALR[4633].Active	:= _230DSE.OUT_Alarm;

END_ACTION
