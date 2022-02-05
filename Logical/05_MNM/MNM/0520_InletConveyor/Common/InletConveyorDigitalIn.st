ACTION InletConveyorDigitalIn: 
	InletSafetyLow1(
	IN_ConfigPresent	:= InletSafetyLow1.IN_ConfigPresent,
	IN_Alarm			:= TRUE,
	IN_Reset			:= AID.DataOut.Reset,
	IO					:= IO_InletSafetyLow1,
	HMI					:= HMI_InletSafetyLow1
	);
	
	InletSafetyHigh1(
	IN_ConfigPresent	:= InletSafetyHigh1.IN_ConfigPresent,
	IN_Alarm			:= TRUE,
	IN_Reset			:= AID.DataOut.Reset,
	IO					:= IO_InletSafetyHigh1,
	HMI					:= HMI_InletSafetyHigh1
	);
	
	InletSafetyLow2(
	IN_ConfigPresent	:= InletSafetyLow2.IN_ConfigPresent,
	IN_Alarm			:= TRUE,
	IN_Reset			:= AID.DataOut.Reset,
	IO					:= IO_InletSafetyLow2,
	HMI					:= HMI_InletSafetyLow2
	);
	
	InletSafetyHigh2(
	IN_ConfigPresent	:= InletSafetyHigh2.IN_ConfigPresent,
	IN_Alarm			:= TRUE,
	IN_Reset			:= AID.DataOut.Reset,
	IO					:= IO_InletSafetyHigh2,
	HMI					:= HMI_InletSafetyHigh2
	);
END_ACTION
