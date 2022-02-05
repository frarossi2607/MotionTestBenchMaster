(*PRODUCTION RECIPE MANAGER*)

TYPE
	RCP_Type : 	STRUCT 
		DataOut : RCP_DataOut_Type;
	END_STRUCT;
	RCP_DataOut_Type : 	STRUCT 
		RecipeDownload : BOOL;
		RecipeDownloaded : BOOL;
	END_STRUCT;
END_TYPE
