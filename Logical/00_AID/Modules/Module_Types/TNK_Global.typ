(*TANK*)

TYPE
	TNK_Type : 	STRUCT 
		DataOut : TNK_DataOut_Type;
	END_STRUCT;
	TNK_DataOut_Type : 	STRUCT 
		Wait : BOOL;
		CipMode : BOOL;
		CipDrainMode : BOOL;
		RinseMode : BOOL;
		DrainMode : BOOL;
		ProdMode : BOOL;
		PushBackMode : BOOL;
		StartUp : BOOL;
		SipMode : BOOL;
		DeEnergization : BOOL;
		EndProduction : BOOL;
		Calibration : BOOL; (*V4.A.A.1.6.13*)
		ContainerStop : BOOL; (*//1.63*)
		DummyContainersIns : BOOL;
		DummyContainersDis : BOOL;
		CopInProductionActive : BOOL; (*V4.A.A.1.7.0*)
	END_STRUCT;
END_TYPE
