
TYPE
	Danfoss_Event_Type : 	STRUCT 
		Brake_Check : BOOL;
		Drive_Over_Temperature : BOOL;
		Earth_Fault : BOOL;
		Control_Card_Over_Temperature : BOOL;
		Controlword_timeout : BOOL;
		Over_Current : BOOL;
		Torque_Limit : BOOL;
		Motor_Thermistor_Over_Temp : BOOL;
		Motor_ETR_Over_Temperature : BOOL;
		Inverter_Over_Loaded : BOOL;
		DC_Link_Under_Voltage : BOOL;
		DC_Link_Over_Voltage : BOOL;
		Short_Circuit : BOOL;
		Inrush_Fault : BOOL;
		Mains_Phase_Loss : BOOL;
		AMA_not_OK : BOOL;
		Live_Zero_Error : BOOL;
		Internal_Fault : BOOL;
		Brake_Resistor_Power_Limit : BOOL;
		Motor_Phase_U_Missing : BOOL;
		Motor_Phase_V_Missing : BOOL;
		Motor_Phase_W_Missing : BOOL;
		Fieldbus_Communication_Fault : BOOL;
		_24V_Supply_Fault : BOOL;
		Mains_Faliure : BOOL;
		_2V_Supply_Fault : BOOL;
		Brake_Resistor_Short_Circuit : BOOL;
		Brake_Chopper_Fault : BOOL;
		Configuration_Option_Change : BOOL;
		Drive_Initialisation : BOOL;
		Safe_Stop : BOOL;
		Mecanical_Brake_Low : BOOL;
	END_STRUCT;
	Danfoss_STW_Type : 	STRUCT 
		Speed_Referece : BOOL;
		Fault : BOOL;
		Warning : BOOL;
		In_Operation : BOOL;
		T37_Ready : BOOL;
	END_STRUCT;
	Danfoss_DI_Type : 	STRUCT  (*V4.A.A.1.6.13*)
		T33 : BOOL;
		T32 : BOOL;
		T29 : BOOL;
		T27 : BOOL;
		T19 : BOOL;
		T18 : BOOL;
		T37 : BOOL;
		Bit7 : BOOL;
		Bit8 : BOOL;
		Bit9 : BOOL;
		Bit10 : BOOL;
		Bit11 : BOOL;
		Bit12 : BOOL;
		Bit13 : BOOL;
		Bit14 : BOOL;
		Bit15 : BOOL;
	END_STRUCT;
	Danfoss_CTW_Type : 	STRUCT 
		Coasting : BOOL;
		Hold_Output_Frequency : BOOL;
		DC_Brake : BOOL;
		Quick_Stop : BOOL;
		Start : BOOL;
		Reset : BOOL;
		Reverse : BOOL;
		Data_Valid : BOOL;
	END_STRUCT;
	FanZoneAlarm_Type : 	STRUCT 
		PressurizerZone : PressurizerAlarm_Type;
		Pressurizer : ARRAY[1..6]OF PressurizerAlarm_Type;
		Galvani : GalvaniAlarm_Type;
	END_STRUCT;
	GalvaniAlarm_Type : 	STRUCT 
		RunningAlarm : BOOL;
		AbsoluteFilterAlarm : BOOL;
		PrefilterExtAlarm : BOOL;
		PrefilterIntAlarm : BOOL;
		CabinetAlarm : BOOL;
		Overload : BOOL;
		SysSwitchedOff : BOOL;
		SysManSwitchedOff : BOOL;
	END_STRUCT;
	PressurizerZoneAlarm_Type : 	STRUCT 
		PressurizerZone : PressurizerAlarm_Type;
		Pressurizer : ARRAY[1..6]OF PressurizerAlarm_Type;
	END_STRUCT;
	PressurizerAlarm_Type : 	STRUCT 
		AbsoluteFilterAlarm : BOOL;
		PrefilterAlarm : BOOL;
		PressurizedOnAlarm : BOOL;
	END_STRUCT;
	ShiftPosition_Type : 	STRUCT 
		ContainerPresence : BOOL;
		ContainerBlowedFault : BOOL;
		ContainerRinsed : BOOL;
		ContainerBurst : BOOL;
		ContainerFilled : BOOL;
		ContainerEjected : BOOL;
		ClosingReleased : BOOL;
		ContainerClosed : BOOL;
	END_STRUCT;
	ShiftPositionInfo : 
		(
		ContainerPresence := 0,
		ContainerBlowedFault := 1,
		ContainerRinsed := 2,
		ContainerBurst := 3,
		ContainerFilled := 4,
		ContainerEjected := 5,
		ClosingReleased := 6,
		ContainerClosed := 7,
		EjectContainer := 8,
		ContainerPreClosed := 9, (*Master nuovo valore precedente 8*)
		DummyBottleInserted := 10,
		DummyContainerDisinserted := 11,
		ShiftPositionSpareBit12 := 12,
		ShiftPositionSpareBit13 := 13,
		ShiftPositionSpareBit14 := 14,
		ShiftPositionSpareBit15 := 15
		);
	BlowerInfo : 
		(
		FillerContainerBlock := 0,
		ContainerBlowFault := 1,
		CombiContainerPresence := 2,
		BlowerInfoSpareBit03 := 3,
		BlowerInfoSpareBit04 := 4,
		BlowerInfoSpareBit05 := 5,
		BlowerInfoSpareBit06 := 6,
		BlowerInfoSpareBit07 := 7,
		BlowerInfoSpareBit08 := 8,
		BlowerInfoSpareBit09 := 9,
		BlowerInfoSpareBit10 := 10,
		BlowerInfoSpareBit11 := 11,
		BlowerInfoSpareBit12 := 12,
		BlowerInfoSpareBit13 := 13,
		BlowerInfoSpareBit14 := 14,
		BlowerInfoSpareBit15 := 15
		);
END_TYPE
