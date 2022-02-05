(*GENERAL SAFETY*)

TYPE
	GNS_Type : 	STRUCT 
		DataOut : GNS_DataOut_Type;
	END_STRUCT;
	GNS_DataOut_Type : 	STRUCT 
		AuxiliaryOn : BOOL;
		FillerAirCarousel : BOOL;
		ContainerStop : BOOL; (*//1.63*)
		RnsCtrlDevInserted : BOOL; (*V4.A.A.1.7.0*)
		RnsByPassed : BOOL; (*V4.A.A.1.7.0*)
		RnsByPassConfigured : BOOL; (*V4.A.A.1.7.0*)
		RnsByPassAlarm : BOOL; (*V4.A.A.1.7.0*)
		RnsCtrlPistonAlarm : BOOL; (*V4.A.A.1.7.0*)
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
