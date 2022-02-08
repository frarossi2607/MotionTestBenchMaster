(*DBA glass Status*)

TYPE
	HMI_DMC_Status : 	STRUCT 
		Sector1Position : USINT;
		Sector1PistonDown : USINT;
		Sector1RotationToProd : USINT;
		Sector1RotationToCip : USINT;
		Sector1PistonUp : USINT;
		Sector2Position : USINT;
		Sector2PistonDown : USINT;
		Sector2RotationToProd : USINT;
		Sector2RotationToCip : USINT;
		Sector2PistonUp : USINT;
	END_STRUCT;
END_TYPE

(*COMMON*)

TYPE
	HMI_UV_Lamp_Type : 	STRUCT 
		ConfigPresent : USINT;
		On : USINT;
		Ready : USINT;
		Alarm : USINT;
	END_STRUCT;
END_TYPE

(*GREASING*)

TYPE
	HMI_GrLb_Data_Type : 	STRUCT 
		Alarm : BOOL;
		Pause : UINT; (*[laps]*)
		CycleTimeOut : UINT; (*[s]*)
		CycleNr : UINT; (*[#]*)
	END_STRUCT;
END_TYPE

(*SAFE LOGIC*)

TYPE
	HMI_SL_Info_Type : 	STRUCT 
		RemoteCtrlStatus : UINT;
		CRC : UDINT;
		Password : ARRAY[0..15]OF USINT;
		Date : STRING[15];
		Author : STRING[32];
		IDMissed : STRING[80];
		IDMismatches : STRING[80];
		IDDiffFirmware : STRING[80];
		Led : HMI_SL_Led_Type;
	END_STRUCT;
	HMI_SL_Led_Type : 	STRUCT 
		FAIL : USINT;
		FW_ACKN : USINT;
		MXCHG : USINT;
		RE : USINT;
	END_STRUCT;
	HMI_SL_PB_Type : 	STRUCT 
		Ack_SK : PB_Type;
		Ack1UdId : PB_Type;
		Ack2UdId : PB_Type;
		Ack3UdId : PB_Type;
		Ack4UdId : PB_Type;
		AckMore4UdId : PB_Type;
		AckFW : PB_Type;
		LedTest : PB_Type;
		Scan : PB_Type;
	END_STRUCT;
	HMI_MAU_ChlRns_Type : 	STRUCT  (*master nuovo*)
		AVE260_PauseTimeWithBottles : UINT;
		AVE260_WorkTimeWithBottles : UINT;
		AVE260_PauseTimeWithoutBottles : UINT;
		AVE260_WorkTimeWithoutBottles : UINT;
		AVE261_PauseTimeWithoutBottles : UINT;
		AVE261_WorkTimeWithoutBottles : UINT;
		PauseTimeMaxWithoutChlRns : UINT;
		WorkTimeMaxWithoutChlRns : UINT;
	END_STRUCT;
END_TYPE
