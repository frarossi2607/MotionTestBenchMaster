(*MAINTENANCE*)

TYPE
	MNT_Type : 	STRUCT  (*v1.4*)
		DataOut : MNT_DataOut_Type;
	END_STRUCT;
	MNT_DataOut_Type : 	STRUCT  (*v1.4*)
		LotoInExecution : BOOL;
		LotoValvesOpening : BOOL;
		LotoAirDischarge : BOOL;
		LotoAirDischargePilot : BOOL;
		LotoDmcOn : BOOL;
		LotoStep : USINT;
		LotoDevices : INT;
	END_STRUCT;
END_TYPE
