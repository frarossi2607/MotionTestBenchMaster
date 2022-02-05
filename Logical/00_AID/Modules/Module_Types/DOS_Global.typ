(*FLAVOR DOSER*)

TYPE
	DOS_Type : 	STRUCT 
		DataOut : DOS_DataOut_Type;
	END_STRUCT;
	DOS_DataOut_Type : 	STRUCT 
		ProdMode : BOOL;
		CipMode : BOOL;
		AromePodReq : BOOL;
		MachineStart : BOOL;
		FixSpeedValue : REAL;
		FixSpeedRequest : BOOL;
	END_STRUCT;
END_TYPE
