(*LAMP TEST*)

TYPE
	HMI_Beacon_Type : 	STRUCT 
		LightGreen : HMI_BeaconLamp_Type;
		LightBlue : HMI_BeaconLamp_Type;
		LightYellow : HMI_BeaconLamp_Type;
		LightRed : HMI_BeaconLamp_Type;
		LightWhite : HMI_BeaconLamp_Type;
		Horn : HMI_BeaconLamp_Type;
	END_STRUCT;
	HMI_BeaconLamp_Type : 	STRUCT 
		Present : BOOL;
		ON : BOOL;
		Blink : BOOL;
	END_STRUCT;
	HMI_BeaconHome_Type : 	STRUCT 
		Present : BOOL;
		LightGreen : HMI_BeaconLamp_Type;
		LightBlue : HMI_BeaconLamp_Type;
		LightYellow : HMI_BeaconLamp_Type;
		LightRed : HMI_BeaconLamp_Type;
		LightWhite : HMI_BeaconLamp_Type;
		Horn : HMI_BeaconLamp_Type;
	END_STRUCT;
END_TYPE
