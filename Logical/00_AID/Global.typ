(*HMI/IO BOTTON TYPE*)

TYPE
	PB_Type : 	STRUCT  (*Push button (ON-OFF;) 0=OFF - 1=ON*)
		Enable : BOOL; (*State: Command Enabled*)
		LampON : BOOL; (*State: Lamp Command ON*)
		Blink : BOOL; (*State: Blink LampOn*)
		Visibility : BOOL; (*Configuration: Present*)
		ON : BOOL; (*Command: Push Button ON*)
	END_STRUCT;
	SS2P_Type : 	STRUCT  (*Selector 2 position (Auto-Man; ON-OFF;) 0=Auto/OFF - 1=Man/ON*)
		Enable : BOOL; (*State: Command Enabled*)
		LampON : BOOL; (*State: Lamp Command ON*)
		Blink : BOOL; (*State: Blink LampOn*)
		Visibility : BOOL; (*Configuration: Present*)
		ON : BOOL; (*Command: Selector Button ON*)
	END_STRUCT;
	SS3P_Type : 	STRUCT  (*Selector 3 position (Auto-0-Man)*)
		Enable : BOOL; (*State: Command Enabled*)
		LampON : BOOL; (*State: Lamp Command ON*)
		Blink : BOOL; (*State: Blink LampOn*)
		Visibility : BOOL; (*Configuration: Present*)
		Auto : BOOL := TRUE; (*Command: Automatic Mode*)
		Man : BOOL; (*Command: Manual Mode ON*)
	END_STRUCT;
	CmdBarPB_Type : 	STRUCT  (*Push button (ON-OFF;) 0=OFF - 1=ON*)
		Enable : BOOL; (*State: Command Enabled*)
		LampON : BOOL; (*State: Lamp Command ON*)
		Blink : BOOL; (*State: Blink LampOn*)
		Visibility : BOOL; (*Configuration: Present*)
		ON : BOOL; (*Command: Push Button ON*)
		Command : BOOL; (*Command: Push Button On from HMI OR Command from ITC*)
	END_STRUCT;
	SS2PCustom_Type : 	STRUCT  (*V4.A.A.1.6.13*)
		Enable : BOOL; (*State: Command Enabled*)
		LampON : BOOL; (*State: Lamp Command ON*)
		Blink : BOOL; (*State: Blink LampOn*)
		Visibility : BOOL; (*Configuration: Present*)
		ON : BOOL; (*Command: Selector Button ON*)
		Description : STRING[25];
	END_STRUCT;
	PB_Type_Actis : 	STRUCT  (*V4.A.A.1.7.0*)
		State : BOOL; (*State: Command Status*)
		Enable : BOOL; (*State: Command Enabled*)
		Command : BOOL; (*State: Command*)
	END_STRUCT;
END_TYPE

(*OUTPUT TYPE*)

TYPE
	IO_Beacon_Type : 	STRUCT 
		DO_LightGreen : BOOL;
		DO_LightYellow : BOOL;
		DO_LightBlue : BOOL;
		DO_LightWhite : BOOL;
		DO_LightRed : BOOL;
		DO_Horn : BOOL;
	END_STRUCT;
END_TYPE
