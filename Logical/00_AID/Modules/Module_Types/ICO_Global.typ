(*INTELLI CHANGE OVER*)

TYPE
	ICO_Type : 	STRUCT 
		DataOut : ICO_DataOut_Type;
	END_STRUCT;
	ICO_DataOut_Type : 	STRUCT 
		ContainerStop : BOOL; (*//1.63*)
		Enabled : BOOL;
	END_STRUCT;
END_TYPE
