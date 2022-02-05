
TYPE
	HMI_CRW_ManualCrwSelection_Type : 	STRUCT 
		Value : USINT;
		Visibility : BOOL;
	END_STRUCT;
	HMI_CRW_ConfigStructure_Type : 	STRUCT 
		Crown : CFG_Crw_Par_Type;
		Presence : HMI_CRW_ConfigStructPres_Type;
		SavePB : PB_Type;
		LoadPB : PB_Type;
	END_STRUCT;
	HMI_CRW_ConfigStructPres_Type : 	STRUCT 
		Channel : BOOL;
	END_STRUCT;
END_TYPE
