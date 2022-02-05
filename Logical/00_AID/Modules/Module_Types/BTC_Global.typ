(*BOTTLE BOTTOM COOLING*)

TYPE
	BTC_Type : 	STRUCT 
		DataOut : BTC_DataOut_Type;
	END_STRUCT;
	BTC_DataOut_Type : 	STRUCT 
		Idle : BOOL; (*v1.4*)
		StepCountReq : BOOL;
		CipMode : BOOL;
		CipDrainMode : BOOL;
		RinseMode : BOOL;
		DrainMode : BOOL;
		ProdMode : BOOL;
		StartUp : BOOL;
		CopMode : BOOL;
		DeEnergization : BOOL;
		SamplingCommand : BOOL; (*V4.A.A.1.6.12*)
		SamplingInPosition : BOOL; (*V4.A.A.1.6.12*)
		ContainerStop : BOOL; (*//1.63*)
		WaterFlow : REAL;
		Temperature : REAL;
		TemperatureGlicol : REAL; (*V4.A.A.1.7.1*)
	END_STRUCT;
END_TYPE
