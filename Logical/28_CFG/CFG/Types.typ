
TYPE
	FmCmd_Type : 	STRUCT 
		FolderCreate : BOOL;
		Load : BOOL;
		Save : BOOL;
	END_STRUCT;
	FmAck_Type : 	STRUCT 
		CommandError : BOOL;
		CommandBusy : BOOL;
		CommandDone : BOOL;
		ErrorCode : UINT;
		ErroreState : FileManagerError_Type;
	END_STRUCT;
	FileManagerError_Type : 
		(
		NO_ERROR,
		ERR_FOLDER_CREATE,
		ERR_LOAD,
		ERR_SAVE
		);
END_TYPE
