(*OPC VARIABLES - CHANGE THEM REQUIRES TO CHANGE OPC CONFIGURATION AND A WARM RESTART*)

TYPE
	EIT_Type : 	STRUCT 
		Version : INT;
		Reason : DINT; (*Common - Reason code that stop the production on machine*)
		StopBit : BOOL; (*Common - Stop bit*)
		ProductionSpeed : REAL; (*Common - Production speed in CPM (Container per minute)*)
		SetSpeed : REAL; (*Common - Set speed*)
		UnitPerCount : INT; (*Common - Unit Per count*)
		SKU : INT; (*Common - SKU*)
		RecipeName : STRING[80]; (*Common - Recipe name*)
		OperatorPresence : BOOL; (*Common - Operator presence*)
		Format : STRING[20]; (*Common - Format*)
		MachineStatus : USINT; (*Common - Machine Status*)
		Count : EITCount_Type; (*Common - Specific Count tag different for each machine on the EITCount definition*)
		Measure : EITMeasure_Type; (*Common - Specific Measure tag different for each machine on the WITMeasure definition*)
		EZ : EITEZ_Type;
		SBO : EITSBO_Type;
		CapFeed : EITCapFeed_Type; (*Common - Uses for filler with Cap feeder*)
		Capper : EITCapper_Type; (*Common - Uses for filler with capper*)
		RunningEvent : EITRunningEvent_Type;
	END_STRUCT;
	EITCount_NotUsed_Type : 	STRUCT 
		FillerRotationTotalizer : DINT; (*Filler - Number of filler revolution*)
		CapperRotationTotalizer : DINT; (*Filler - Number of capper revolution*)
		RinserRotationTotalizer : DINT; (*Filler - Number of rinser revolution*)
		BadFillingCount : DINT; (*Filler - Number of Bad filling count*)
		BadCappingCount : DINT; (*Filler - Number of Bad capping count*)
		BadRinsingCount : DINT; (*Filler - Number of Bad rinsing count*)
		ContainerOut : DINT; (*Filler - Count of container produced*)
		ContainerEjected : DINT; (*Filler - Count of container ejected*)
	END_STRUCT;
	EITCount_Type : 	STRUCT 
		InfeedCount : UDINT; (*Filler - Count of infeed container on the machine*)
		ContainersBurstCount : UDINT; (*Filler - Number of Burst container count*)
		ContainersEjectManually : UDINT; (*Filler - Count of container ejected manually*)
		LowLevelEjectCount : UDINT;
		LPCA : UDINT; (*Filler - FlowLPCA V4.A.A.1.6.14k*)
		General_CO2 : UDINT;
		ClosingUnit_CO2 : UDINT;
		N2 : UDINT;
		ProcessWater : UDINT;
		CopWater : UDINT;
		BottleBottomCoolingWater : UDINT; (*V4.A.A.1.6.14k*)
		Product : UDINT;
		Steam : UDINT;
		FoodSteam : UDINT;
		ProductWater : UDINT; (*V4.A.A.1.6.14k*)
		Syrup : UDINT;
		ElectricalEnergy : UDINT; (*V4.A.A.1.6.14k*)
	END_STRUCT;
	EITMeasure_Type : 	STRUCT 
		FlowLPCA : REAL; (*Filler - FlowLPCA V4.A.A.1.6.14k*)
		ElectricalPower : REAL; (*Filler - Electrical power KW*)
	END_STRUCT;
	EITEZ_Type : 	STRUCT 
		StopBit : BOOL;
		Reason : INT;
	END_STRUCT;
	EITSBO_Type : 	STRUCT 
		StopBit : BOOL;
		Reason : INT;
	END_STRUCT;
	EITCapFeed_Type : 	STRUCT 
		StopBit : BOOL;
		Reason : INT;
	END_STRUCT;
	EITCapper_Type : 	STRUCT 
		StopBit : BOOL;
		Reason : INT;
	END_STRUCT;
	EITRunningEvent_Type : 	STRUCT 
		CapsLowLevel : BOOL;
		LidLowLevel : BOOL;
	END_STRUCT;
	EIT_ChangeOver_Type : 	STRUCT 
		ToHLI : EIT_ChangeOver_To_Type;
		FromHLI : EIT_ChangeOver_From_Type;
	END_STRUCT;
	EIT_ChangeOver_From_Type : 	STRUCT 
		NextProductReady : BOOL;
		PrepareForChange : BOOL;
		RinseRequested : BOOL;
		StopProduction : BOOL;
		WatchDog : INT;
		ProductToLoad : INT;
		NextRecipeId : UDINT;
		RemainingProdToDo : UDINT;
	END_STRUCT;
	EIT_ChangeOver_To_Type : 	STRUCT 
		ChangeOverDone : BOOL;
		ChangeOverOptionOn : BOOL;
		ProductionEnded : BOOL;
		NextProductValidationRequest : BOOL;
		WatchDog : INT;
		ActualProduct : INT;
		ActualRecipeId : UDINT;
		ProductionBatchAvailable : UDINT;
	END_STRUCT;
	EIT_OMAC_Type : 	STRUCT 
		Status : EIT_PMLs_Type;
		Command : EIT_PMLc_Type;
		Admin : EIT_PLMa_Type;
	END_STRUCT;
	EIT_PLMa_Type : 	STRUCT 
		Alarm : EIT_PMLa_Alarm_Type;
	END_STRUCT;
	EIT_PMLa_Alarm_Type : 	STRUCT 
		ID : UDINT;
		Value : UDINT;
		Message : STRING[80];
	END_STRUCT;
	EIT_PMLc_Type : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	EIT_PMLs_Type : 	STRUCT 
		UnitModeCurrent : UDINT;
		StateCurrent : UDINT;
	END_STRUCT;
	WS_Type : 	STRUCT 
		Communication : WS_Communication_Type;
		Tracking : WS_Tracking_Type;
		OperatingMode : WS_OperatingMode_Type;
		Omac : WS_Omac_Type;
		Fault : WS_Fault_Type;
		Pointer : WS_Pointer_Type;
		Parameter : WS_Parameter_Type;
		Counters : WS_Counters_Type;
	END_STRUCT;
	WS_Communication_Type : 	STRUCT 
		WS_Error : UDINT; (*Tag-Number: 00000*)
		WS_PDACONT_Lenght : UDINT; (*Tag-Number: 00001*)
		WS_Test_Unsigned32_1 : UDINT; (*Tag-Number: 00011*)
		WS_Test_Unsigned32_2 : UDINT; (*Tag-Number: 00012*)
		WS_Test_Unsigned32_3 : UDINT; (*Tag-Number: 00013*)
		WS_Test_Signed32_1 : DINT; (*Tag-Number: 00014*)
		WS_Test_Signed32_2 : DINT; (*Tag-Number: 00015*)
		WS_Test_Signed32_3 : DINT; (*Tag-Number: 00016*)
		WS_Test_Real_1 : REAL; (*Tag-Number: 00017*)
		WS_Test_Real_2 : REAL; (*Tag-Number: 00018*)
		WS_Test_Real_3 : REAL; (*Tag-Number: 00019*)
		WS_Test_Hex32_1 : DWORD; (*Tag-Number: 00020*)
		WS_Test_Hex32_2 : DWORD; (*Tag-Number: 00021*)
		WS_Test_Hex32_3 : DWORD; (*Tag-Number: 00022*)
		WS_Test_String16_1 : STRING[1]; (*Tag-Number: 00023*)
		WS_Test_String16_2 : STRING[1]; (*Tag-Number: 00024*)
		WS_Test_String16_3 : STRING[1]; (*Tag-Number: 00025*)
	END_STRUCT;
	WS_Tracking_Type : 	STRUCT 
		WS_Set_Batch_ID_L : DINT; (*Tag-Number: 00061*)
		WS_Set_Batch_ID_H : DINT; (*Tag-Number: 00062*)
		WS_Cur_Batch_ID_L : DINT; (*Tag-Number: 00063*)
		WS_Cur_Batch_ID_H : DINT; (*Tag-Number: 00064*)
	END_STRUCT;
	WS_OperatingMode_Type : 	STRUCT 
		WS_Cur_Mode : UDINT; (*Tag-Number: 00100*)
		WS_Cur_Prog : UDINT; (*Tag-Number: 00200*)
		WS_Prog_Step : UDINT; (*Tag-Number: 00210*)
		WS_Cur_State : UDINT; (*Tag-Number: 00300*)
	END_STRUCT;
	WS_Omac_Type : 	STRUCT 
		WS_Cur_Mach_Spd : REAL; (*Tag-Number: 00401*)
		WS_Set_Mach_Spd : REAL; (*Tag-Number: 00402*)
		WS_Mach_Design_Spd : REAL; (*Tag-Number: 00403*)
		WS_Mach_Cycle : UDINT; (*Tag-Number: 00501*)
		WS_Mat_Ready : DWORD; (*Tag-Number: 00601*)
		WS_Mat_Low : DWORD; (*Tag-Number: 00602*)
		WS_Prod_Ratio : UDINT; (*Tag-Number: 00701*)
	END_STRUCT;
	WS_Fault_Type : 	STRUCT 
		WS_Not_Of_Fail_Code : UDINT; (*Tag-Number: 10000*)
	END_STRUCT;
	WS_Pointer_Type : 	STRUCT 
		WS_Pointer_Code : UDINT; (*Tag-Number: 20000*)
	END_STRUCT;
	WS_Parameter_Type : 	STRUCT 
		WS_Container_Type : UDINT; (*Tag-Number: 30003*)
		WS_Beer_Type : UDINT; (*Tag-Number: 30004*)
	END_STRUCT;
	WS_Measured_Type : 	STRUCT 
		WS_Press_Bottling : REAL; (*Tag-Number: 40051*)
		WS_Temp_Bottling : REAL; (*Tag-Number: 40052*)
		WS_Temp_Product : REAL; (*Tag-Number: 40081*)
		WS_Cond_Product : REAL; (*Tag-Number: 40082*)
		WS_PH_Product : REAL; (*Tag-Number: 40083*)
		WS_O2_Product : REAL; (*Tag-Number: 40084*)
		WS_CO2_Product : REAL; (*Tag-Number: 40085*)
		WS_O_Press_Cleanroom : REAL; (*Tag-Number: 40121*)
	END_STRUCT;
	WS_Counters_Type : 	STRUCT 
		WS_Tot_Containers : UDINT; (*Tag-Number: 50005*)
		WS_Good_Containers : UDINT; (*Tag-Number: 50006*)
		WS_Burst_Containers : UDINT; (*Tag-Number: 50009*)
		WS_Tot_Rej : UDINT; (*Tag-Number: 50011*)
	END_STRUCT;
END_TYPE
