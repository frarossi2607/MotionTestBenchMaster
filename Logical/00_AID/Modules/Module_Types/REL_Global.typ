(*ELECTRONIC FUSES*)

TYPE
	REL_Type : 	STRUCT 
		DataOut : REL_DataOut_Type;
	END_STRUCT;
	REL_DataOut_Type : 	STRUCT 
		ElectronicFusesPresence : BOOL;
		GlobalPowerOn : BOOL := TRUE;
		Station : ARRAY[1..16]OF REL_Channel_Type;
	END_STRUCT;
	REL_Channel_Type : 	STRUCT 
		Ch : ARRAY[1..16]OF REL_Status_Type;
	END_STRUCT;
	REL_Status_Type : 	STRUCT 
		ConfigurationError : BOOL;
		PoweredOn : BOOL;
		Overload : BOOL;
		ShortCircuit : BOOL;
	END_STRUCT;
END_TYPE
