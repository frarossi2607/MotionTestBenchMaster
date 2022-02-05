(*SAFETY*)

TYPE
	OPS_Type : 	STRUCT 
		DataOut : OPS_DataOut_Type; (*SAFE_PLC Inputs*)
	END_STRUCT;
	OPS_DataOut_Type : 	STRUCT 
		EmergencyOk : BOOL := TRUE;
		FlrDoorsOk : BOOL := TRUE;
		DoorsOk : BOOL;
		GeneralAirOn : BOOL;
		ConfinementZoneRed : BOOL;
		BeaconHornJog : BOOL; (*Blow horn request for jog*)
		FlrModeSelectorAuto : BOOL := TRUE;
		FlrModeSelectorAdjustment : BOOL := TRUE;
		FlrModeSelectorJog : BOOL := TRUE;
		JogStartPb : BOOL := TRUE;
		SelModeChange : BOOL; (*Mode selection Error*)
		EnableDrive : BOOL;
		EnablePump : BOOL;
		EnableProcessValves : BOOL;
		EnableCopValves : BOOL; (*V4.A.A.1.6.11a*)
		EnableVerticalDrive : BOOL; (*V4.A.A.1.6.6*)
		BufferDoorOpened : BOOL;
		BufferDoorFault : BOOL;
		HMIDoorUnlock : BOOL;
		LabellerTrasferDoorOpenRequest : BOOL;
		BlowerTrasferDoorOpenRequest : BOOL;
		ActisTrasferDoorOpenRequest : BOOL; (*V4.A.A.1.6.12*)
		LabellerTrasferGateOpened : BOOL;
		BlowerTrasferGateOpened : BOOL;
		ActisTrasferGateOpened : BOOL; (*V4.A.A.1.6.12*)
		AutomaticInletGate : BOOL; (*V4.A.A.1.6.12h*)
		InletGateOpened : BOOL; (*V4.A.A.1.6.12h*)
		InletGateClosed : BOOL;
		OutletGateClosed : BOOL;
		OutletGateOpened : BOOL; (*V4.A.A.1.7.0*)
		OperatorPresence : BOOL;
		ContainerStop : BOOL; (*//1.63*)
		ConfigSaveReq : BOOL;
		FlrLiftingEnabled : BOOL;
		FillerLiftPw : BOOL;(*maste nuovo*)
		FillerLiftPwFault : BOOL;(*master nuovo*)
		DoorsOpenExceptGloves : BOOL; (*V4.A.A.1.7.0*)
	END_STRUCT;
END_TYPE
