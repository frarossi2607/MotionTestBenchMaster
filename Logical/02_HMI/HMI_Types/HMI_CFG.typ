
TYPE
	HMI_PAO_Type : 	STRUCT 
		FirstConfigLoaded : BOOL;
		Saved : BOOL;
		Loaded : BOOL;
		Busy : BOOL;
		ErrorLoading : BOOL;
		ErrorSaving : BOOL;
	END_STRUCT;
	HMI_CFG_Display_Type : 	STRUCT 
		Name : STRING[100];
		Visibility : BOOL;
		ValueR : REAL;
		PresentR : BOOL;
		ValueB : BOOL;
		PresentB : BOOL;
		ValueI : DINT;
		PresentI : BOOL;
		ValueSt : STRING[100];
		PresentSt : BOOL;
	END_STRUCT;
END_TYPE
