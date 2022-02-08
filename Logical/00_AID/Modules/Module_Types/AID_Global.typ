(*AUXILIARY MEMORY*)

TYPE
	AID_Type : 	STRUCT 
		DataOut : AID_DataOut_Type;
	END_STRUCT;
	AID_DataOut_Type : 	STRUCT 
		Blink05Hz : BOOL;
		Blink1Hz : BOOL;
		Blink4Hz : BOOL;
		Blink2Hz : BOOL;
		Blink5Hz : BOOL; (*v1.7.5*)
		NetBlinkSlow : BOOL; (*Almost 1Hz*)
		NetBlinkFast : BOOL; (*Almost 4Hz*)
		Reset : BOOL;
		OperatorPresence : BOOL;
		OneContainerStopAlarm : BOOL; (*V4.A.A.1.6.13*)
		OneMachineStopAlarm : BOOL; (*V4.A.A.1.6.13*)
		ALR : ActionSum_Type;
		ProjectType : USINT;
	END_STRUCT;
END_TYPE
