(*MAIN DRIVE CONTROL*)

TYPE
	MNM_Type : 	STRUCT 
		DataOut : MNM_DataOut_Type;
	END_STRUCT;
	MNM_DataOut_Type : 	STRUCT 
		HornFlrRequest : BOOL;
		StartLightBlinkRequest : BOOL;
		StartLightFixRequest : BOOL;
		CopSpeedReqReached : BOOL;
		RnsSpeedReqReached : BOOL; (*V4.A.A.1.7.0*)
		CapSpeedReqReached : BOOL;
		DmcSpeedReqReached : BOOL;
		SftSpeedReqReached : BOOL;
		SkidSpeedReqReached : BOOL;
		EmptySpeedReached : BOOL;
		ContBlockSpeedReached : BOOL;
		ContBlock1Requested : BOOL;
		ContBlock2Requested : BOOL;
		MachineRunning : BOOL; (*Module Running*)
		ReadyForVortexCalib : BOOL;
		ReadyForCoupling : BOOL;
		PartnerReadyToRun : BOOL;
		OperatorPresence : BOOL;
		FixSpeedRequest : BOOL;
		OutletSpeed : REAL;
		LackInlet1 : BOOL;
		LackInlet2 : BOOL;
		COPInletContBlockSpeedReached : BOOL;
		ContainerStop : BOOL; (*//1.63*)
		DesyncroRequest : BOOL;
		CapperPositioningDone : BOOL;
		SingleAxisInPosition : BOOL; (*V4.A.A.1.7.0*)
		RinserAxisDisabled : BOOL; (*V4.A.A.1.7.0*)
		FillingValvePositioningDone : BOOL;
		StartRequest : BOOL; (*V4.A.A.1.7.0*)
	END_STRUCT;
END_TYPE
