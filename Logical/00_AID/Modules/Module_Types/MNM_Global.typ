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
		RnsSpeedReqReached : BOOL;
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
		ContainerStop : BOOL;
		DesyncroRequest : BOOL;
		CapperPositioningDone : BOOL;
		SingleAxisInPosition : BOOL;
		RinserAxisDisabled : BOOL;
		DoserAxisDisabled : BOOL;
		FillerAxisDisabled : BOOL;
		FillingValvePositioningDone : BOOL;
		ReversePositioningDone : BOOL;
		DmcPositioningDone : BOOL;
		PhaseDone : BOOL;
		ConfigReqLoaded : BOOL;
		StartRequest : BOOL;
		InletSpeed : REAL;
	END_STRUCT;
END_TYPE
