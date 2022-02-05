
TYPE
	HMI_OPS_Zone_Type : 	STRUCT 
		Closed : BOOL;
		Locked : BOOL;
		LockSafety : BOOL;
		ShortSafety : BOOL;
		UnlockCommand : BOOL;
		Unlocked : BOOL;
		UnlockEnable : BOOL;
		UnlockRequest : BOOL;
		UnlockSafety : BOOL;
	END_STRUCT;
	HMI_OPS_Door_Type : 	STRUCT 
		Confirm : BOOL;
		Lock1oo2 : BOOL;
		LockSafety : BOOL;
		Opened : BOOL;
		ShortCircuit : BOOL;
		UnLock : BOOL;
	END_STRUCT;
	HMI_OPS_Emergency_Type : 	STRUCT 
		I_Pressed : BOOL;
		I_short_Fault : BOOL;
	END_STRUCT;
	HMI_OPS_Jog_Type : 	STRUCT 
		ShCircPlug : BOOL;
		ShCircStop : BOOL;
		Stop : BOOL;
		Plugged : BOOL;
	END_STRUCT;
	HMI_SafetyWidget_Type : 	STRUCT 
		ZoneAlarm : ARRAY[MIN_CFG_SafetyZone..MAX_CFG_SafetyZone]OF BOOL;
		BufferAlarm : BOOL;
	END_STRUCT;
	HMI_OPS_Pictogram_Type : 	STRUCT 
		AccesOk : BOOL;
		AccesReq : BOOL;
		Acces : BOOL;
		Chemical : BOOL;
		Temperature : BOOL;
	END_STRUCT;
	HMI_OPS_RfidAccess_Type : 	STRUCT 
		Present : BOOL; (*Module Present*)
		CodeFault : BOOL; (*Code discrepancy*)
		KeyFault : BOOL; (*Key not recognised*)
		KeyOk : BOOL; (*Key present and recognised*)
	END_STRUCT;
	HMI_OPS_SafetySwitch_Type : 	STRUCT  (*V4.A.A.1.7.1*) (* *) (*139*)
		ShortFault : BOOL; (*Short circuit fault on PB*) (* *) (*141*)
		SwitchOn : BOOL; (*Switch active*) (* *) (*143*)
		Visibility : BOOL; (*Switch present*) (* *) (*144*)
	END_STRUCT;
END_TYPE
