(*GENERAL SAFETY*)

TYPE
	GNS_Type : 	STRUCT 
		DataOut : GNS_DataOut_Type;
	END_STRUCT;
	GNS_DataOut_Type : 	STRUCT 
		AuxiliaryOn : BOOL;
		FillerAirCarousel : BOOL;
		ContainerStop : BOOL;
		RnsCtrlDevInserted : BOOL;
		RnsByPassed : BOOL; (*Not used in Glass Machine*)
		RnsByPassConfigured : BOOL; (*Not used in Glass Machine*)
		RnsByPassAlarm : BOOL; (*Not used in Glass Machine*)
		RnsCtrlPistonAlarm : BOOL;
		DosIncluded : BOOL; (*v999hema*)
		DosByPassed : BOOL; (*v999hema*)
		DosByPassConfigured : BOOL; (*v999hema*)
		DosByPassAlarm : BOOL; (*v999hema*)
		DmcCircuitPressureOk : BOOL; (*V4.A.A.1.7.0*)
		TestBeacon : GNS_TestBeacon_Type;
	END_STRUCT;
	GNS_TestBeacon_Type : 	STRUCT 
		Active : BOOL;
		Green : BOOL;
		Blue : BOOL;
		Yellow : BOOL;
		Red : BOOL;
		White : BOOL;
		Horn : BOOL;
	END_STRUCT;
END_TYPE
