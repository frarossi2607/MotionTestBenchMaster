
TYPE
	HMI_RNS_ManualCapsSelection_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		Value : USINT;
		Visibility : BOOL;
	END_STRUCT;
	HMI_RNS_State_Type : 	STRUCT (*V4.A.A.1.7.4*)
		Sequencer : Seq_Type; (*Step Actual*)
		Signals : Signals_Type;
	END_STRUCT;
END_TYPE
