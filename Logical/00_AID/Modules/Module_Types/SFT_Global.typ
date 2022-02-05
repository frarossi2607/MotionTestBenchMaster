(*CONTAINERS SHIFT REGISTER*)

TYPE
	SFT_Type : 	STRUCT 
		DataOut : SFT_DataOut_Type;
	END_STRUCT;
	SFT_DataOut_Type : 	STRUCT 
		Alarm : SFT_Alarm_Type;
		ContainersBlock1 : BOOL; (*Block container in corrispondence of FV disable*)
		ContainersBlock2 : BOOL; (*Block container in corrispondence of FV disable*)
		ContainerStop : BOOL; (*//1.63*)
		ContainersReleaseEarlier1 : BOOL;
		ContainersReleaseEarlier2 : BOOL;
		ContainersAtCarouselOutlet : BOOL;
		ContainerAtMachineOutlet : BOOL;
		CombiEmpty : BOOL; (*No containers in the combi*)
		MachineEmpty : BOOL; (*No containers in the machine*)
		_20Bottles_AtExit : BOOL; (*Signals For Conveyor - Information 20 bottles at machine exit*)
		RinserTreatmentRequest : BOOL;
		BottleCoolingRequest : BOOL;
		InletConveyorEmpty : BOOL;
		OutletConveyorEmpty : BOOL;
		CapsAirRequest : BOOL; (*Closing Unit - Air Blow*)
		CapsReleaseProductionReady : BOOL;
		CapsReleaseEmptyingReady : BOOL;
		CapsReleaseEmpty : BOOL; (*v1.5*)
		CappingHeadAtMachineGetData : BOOL; (*V4.A.A.1.6.12*)
		CapOnCappingHead : BOOL; (*v1.5*)
		FMC_PreClosingContainerReq : BOOL;
		FMC_ContainerPresenceReq : BOOL;
		FMC_WashCenteringCup : BOOL;
		FMC_StartFillingReq : BOOL;
		FillingValveRinseReq : BOOL;
		ManPreformLoadingReq : BOOL;
		VBS_Presence : BOOL;
		DmcNotInserted : BOOL;
		DmcNotRemoved : BOOL;
		CounterDone : BOOL;
		ValveDisabledPreformBlock : BOOL;
		ValveDisabledLbrBottleEjection : BOOL;
		SlowDownContBlockReq : BOOL;
		ContBlockSpeedReq : BOOL;
		ManualContainersReleaseEnable : BOOL; (*Block container in corrispondence of FV disable*)
		OutletShowerReq : BOOL;
		NeckRinseReq : BOOL;
		MachineInletStatus : BOOL;
		COPInletContSlowSpeedReq : BOOL;
		COPInletContConvEmptyRunning : BOOL;
		COPInletContConvEmptyDone : BOOL;
		FillingValvePositionReq : BOOL; (*Filling valve positioning request*)
		PreformManualLoading : BOOL; (*v1.6*)
		CapTreatmentStart : BOOL; (*V4.A.A.1.7.0*)
		NoBottleNoSprayPistonFault : BOOL; (*vrma*)
		NoBottleNoSprayActive : BOOL; (*vrma*)
		FillingValveAtMachineInlet : INT;
		CappingHeadAtMachineInlet : INT;
		CapHeadNumberInTangency : INT; (*V4.A.A.1.6.12*)
		RinsingNozzleAtMachineInlet : INT; (*V4.A.A.1.6.12*)
		RinserBypassedPointer : INT; (*V4.A.A.1.6.12*)
		BottleBurstWashRampActivation : ARRAY[1..3]OF BOOL; (*master nuovo*)
		FoamerRequest : BOOL;
		CrownsReleaseProductionReady : BOOL;
		CrownsAirRequest : BOOL;
		ContainersInFiller : UINT; (*Number of containers in the machine*)
		ContainersInMachine : UINT; (*Number of containers in the machine*)
		ContainersToFillFillerOnly : UINT;
		ContainersToFill : UINT; (*Number of containers to be filled (From Container Block To Inlet Tangency)*)
		ContainersToCap : UINT; (*Number of containers to be filled (From Container Block To Inlet Tangency) V4.A.A.1.7.0*)
		BottleCoolingFillerSteps : UINT;
		RinserFillerSteps : UINT; (*V4.A.A.1.6.12*)
		NumberDmcInserted : UINT;
		FillingValvePosValue : UINT; (*Number of filling valve to position in the ispection point*)
		ContBlockSpeedValue : REAL;
		COPInletContBlockSpeedValue : REAL;
	END_STRUCT;
	SFT_Alarm_Type : 	STRUCT 
		BottMissingForFillerFault : BOOL;
		Category : DINT;
		ID : DINT;
		OmacCode : DINT;
	END_STRUCT;
END_TYPE

(*SHIFT*)

TYPE
	MachineShift_Type : 	STRUCT 
		ShiftInfo : UINT;
		FillingNozzle : USINT;
		CrownerHead : USINT;
		CappingHead : USINT;
		RinsingNozzle : USINT; (*V4.A.A.1.7.0*)
	END_STRUCT;
	CombiShift_Type : 	STRUCT 
		MoldNumber : UINT; (*V1.61*)
		CombiInfo : UINT;
		AlarmId : UDINT;
		Category : UDINT;
		OmacCode : UDINT;
	END_STRUCT;
END_TYPE
