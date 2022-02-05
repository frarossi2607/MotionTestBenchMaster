
TYPE
	CmdRemoteControl_Type : 	STRUCT 
		Command : UINT;
		Number : UINT;
		Data : UINT;
		Password : ARRAY[0..15]OF USINT;
		NewPassword : ARRAY[0..15]OF USINT;
	END_STRUCT;
	StatusRemoteControl_Type : 	STRUCT 
		Command : UINT;
		Number : UINT;
		Status : UINT;
		State : UINT;
		EnterData : UINT;
		EnterNumber : UINT;
		EnterExecuteStatus : UINT;
		SafeOSstate : USINT;
		SafeKeyChanged : USINT;
		LedTestActive : USINT;
		Scanning : USINT;
		OpenSafetyState : USINT;
		FailSafe : USINT;
		NumberOfMissingModules : UINT;
		NumberOfUdIdMismatches : UINT;
		NumberOfDiffFirmware : UINT;
		SAddr : ARRAY[0..100]OF UINT;
		MissingModules : ARRAY[0..15]OF USINT;
		UdIdMismatches : ARRAY[0..15]OF USINT;
		DiffFirmware : ARRAY[0..15]OF USINT;
	END_STRUCT;
	SafeLogicCtrl_Status : 
		(
		SafeLogic_Wait := 16#0,
		SafeLogic_ReadOsStatus := 16#5,
		SafeLogic_CMD_ReadStatus := 16#10,
		SafeLogic_ReadStatus := 16#11,
		SafeLogic_ReadCRC := 16#12,
		SafeLogic_ReadTime := 16#13,
		SafeLogic_ReadAuthor := 16#14,
		SafeLogic_CMD_Write := 16#19,
		SafeLogic_AckMore4UdId := 16#20,
		SafeLogic_Ack4UdId := 16#30,
		SafeLogic_Ack3UdId := 16#40,
		SafeLogic_Ack2UdId := 16#50,
		SafeLogic_Ack1UdId := 16#60,
		SafeLogic_Ack_FW := 16#100,
		SafeLogic_Ack_SK := 16#200,
		SafeLogic_LedTest := 16#1000,
		SafeLogic_Scan := 16#2000,
		SafeLogic_SK_Copy := 16#3000,
		SafeLogic_SK_ResumeCopy := 16#4000,
		SafeLogic_SK_ChgPassword := 16#5000,
		SafeLogic_SK_Format := 16#6000
		);
END_TYPE
