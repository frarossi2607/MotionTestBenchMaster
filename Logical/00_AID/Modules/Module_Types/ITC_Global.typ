(*INTERCHANGE*)

TYPE
	ITC_Type : 	STRUCT 
		DataOut : ITC_DataOut_Type;
	END_STRUCT;
	ITC_DataOut_Type : 	STRUCT 
		SlowDownReq : BOOL; (*//V4.A.A.1.6.11*)
		HoenleOverloadAlarm : BOOL; (*v1.4*)
		AdrExternalPosition : UDINT; (*//V4.A.A.1.6.12*)
		EquTotalMaxConsecutiveError : BOOL; (*//V4.A.A.1.6.11*)
		EquHeadMaxConsecutiveError : BOOL; (*//V4.A.A.1.6.11*)
	END_STRUCT;
	ITC_CommStatus_Type : 	STRUCT 
		Disabled : BOOL;
		ConnectionOk : BOOL;
		ConnectionLoss : BOOL;
	END_STRUCT;
END_TYPE

(*BLOWER COMMUNICATION*)

TYPE
	FlrBlr_Type : 	STRUCT 
		BOOL1 : BOOL;
		PbLbrFlrCouplingState : BOOL; (*"LF Coupling Push Button" state  Labeler-Filler on "LF Machine Coupled" *)
		PbFlrProcessPresent : BOOL; (*PB "Filler Process Start Push Button" Present*)
		PbFlrProcessEnable : BOOL; (*PB "Filler Process Start Push Button" Enabled*)
		PbFlrProcessState : BOOL; (*PB "Filler Process Start Push Button" state*)
		PbMxrProcessPresent : BOOL; (*PB "Mixer Start/Stop Push Button" Present*)
		PbMxrProcessEnable : BOOL; (*PB "Mixer Start/Stop  Push Button" Enabled*)
		PbMxrProcessState : BOOL; (*PB "Mixer Start/Stop  Push Button" state *)
		PbFlrDoorEnable : BOOL; (*PB "Filler Doors Release Push Button" Enabled*)
		PbFlrDoorState : BOOL; (*PB "Filler Doors Release Push Button" state*)
		BOOL11 : BOOL;
		BOOL12 : BOOL;
		BOOL13 : BOOL;
		BOOL14 : BOOL;
		BOOL15 : BOOL;
		BOOL16 : BOOL;
		PbBlrFlrCouplingState : BOOL; (*PB "BF Coupling Push Button" state  Blower-Filler on "BF Machine Coupling" *)
		BOOL18 : BOOL;
		BOOL19 : BOOL;
		PbStart : BOOL; (*PB "Filler Start Push Button" Pressed*)
		PbStop : BOOL; (*PB "Filler Stop Push Button" Pressed *)
		SsAuto : BOOL; (*SS "Filler on Automatic Mode" Selected *)
		PbReset : BOOL; (*PB "Alarms Reset Push Button" Pressed *)
		BOOL24 : BOOL;
		PbResetLamp : BOOL; (*PB "Alarms Reset Push Button" Lamp Requested*)
		BOOL26 : BOOL;
		BOOL27 : BOOL;
		BOOL28 : BOOL;
		BOOL29 : BOOL;
		ReadyToRun : BOOL; (*Filler is ready to Run on Auto/Jog Mode*)
		RedLightConfinementZone : BOOL; (*Doors Opened to be Confirmed (Red Light Confinement Zone)*)
		NoAlarm : BOOL; (*No alarm on Filler (Ready to Run, no Critical Fault)*)
		Empty : BOOL; (*Filler Machine is Empty*)
		Stopped : BOOL; (*Filler Machine is Stopped*)
		Load : BOOL; (*Filler is Ready to Load Preforms (load Preform Enabled)*)
		SynchroDone : BOOL; (*Filler Syncronized with Blower (ready to Start Blower on Syncro Mode)*)
		Production : BOOL; (*Filler in production*)
		ProductionStop : BOOL; (*Filler production stop*)
		StandBy : BOOL; (*Filler on Standby Output Rate*)
		UnlockRequest : BOOL; (*Filler Transfer Doors Unlock Requested*)
		StopRequest : BOOL; (*Filler  Critical Stop Requested*)
		RecipeChangeRequest : BOOL; (*Filler Change Recipe (for Low Speed during Production) Requested*)
		SpeedChangeRequest : BOOL; (*Filler Change Speed (for Fix Speed) Requested*)
		HeatingRequest : BOOL; (*Oven heating Requested*)
		PreformAndBottleEjectionRequest : BOOL; (*Preform and Bottles Ejection on Transfert Requested*)
		LoadingStopRequest : BOOL; (*Loading Stop (stop or eject single preform with signal TRUE) Requested*)
		DesynchroReq : BOOL; (*Desynchronization Requested (Power OFF)*)
		ICOstopProductionRequest : BOOL; (*Stop the loading production for "Change over on fly"*)
		BOOL49 : BOOL;
		DownstreamFault : BOOL; (*Downstream fault stoppage*)
		UpstreamFault : BOOL; (*Upstream fault stoppage*)
		ExternalFault : BOOL; (*External fault stoppage*)
		InternalFault : BOOL; (*Internal fault stoppage*)
		BadFillingPresent : BOOL; (*Counter Bad Filling Present*)
		BottleBurstPresent : BOOL; (*Counter Bottle Burst Present*)
		BadCappingPresent : BOOL; (*Counter Bad Capping Present*)
		BadBottlePresent : BOOL; (*Counter Bad Bottle Present*)
		BOOL58 : BOOL;
		BOOL59 : BOOL;
		BOOL60 : BOOL;
		BOOL61 : BOOL;
		BOOL62 : BOOL;
		BOOL63 : BOOL;
		BOOL64 : BOOL;
		FaultPeriphEquipment : BOOL; (*Fault on Peripheral to change the speed (after a set point time)*)
		BOOL66 : BOOL;
		BOOL67 : BOOL;
		BOOL68 : BOOL;
		BOOL69 : BOOL;
		BOOL70 : BOOL;
		BOOL71 : BOOL;
		BOOL72 : BOOL;
		RedLampFix : BOOL; (*Red Lamp Fix ON state (on Coupled Mode BF, BLF)*)
		RedLampFlash : BOOL; (*Red Lamp Flashing ON state (on Coupled Mode BF, BLF)*)
		BlueLampFix : BOOL; (*Blue Lamp Fix ON state (on Coupled Mode BF, BLF)*)
		BlueLampFlash : BOOL; (*Blue Lamp Flashing ON state (on Coupled Mode BF, BLF)*)
		BOOL77 : BOOL;
		BOOL78 : BOOL;
		BOOL79 : BOOL;
		BOOL80 : BOOL;
		BOOL81 : BOOL;
		BOOL82 : BOOL;
		BOOL83 : BOOL;
		BOOL84 : BOOL;
		BOOL85 : BOOL;
		BOOL86 : BOOL;
		BOOL87 : BOOL;
		BOOL88 : BOOL;
		BOOL89 : BOOL;
		BOOL90 : BOOL;
		BOOL91 : BOOL;
		BOOL92 : BOOL;
		BOOL93 : BOOL;
		BOOL94 : BOOL;
		BOOL95 : BOOL;
		BOOL96 : BOOL;
		BOOL97 : BOOL;
		BOOL98 : BOOL;
		BOOL99 : BOOL;
		BOOL100 : BOOL;
		BOOL101 : BOOL;
		BOOL102 : BOOL;
		BOOL103 : BOOL;
		BOOL104 : BOOL;
		BOOL105 : BOOL;
		BOOL106 : BOOL;
		BOOL107 : BOOL;
		BOOL108 : BOOL;
		BOOL109 : BOOL;
		BOOL110 : BOOL;
		BOOL111 : BOOL;
		BOOL112 : BOOL;
		BOOL113 : BOOL;
		BOOL114 : BOOL;
		BOOL115 : BOOL;
		BOOL116 : BOOL;
		BOOL117 : BOOL;
		BOOL118 : BOOL;
		BOOL119 : BOOL;
		BOOL120 : BOOL;
		BOOL121 : BOOL;
		BOOL122 : BOOL;
		BOOL123 : BOOL;
		BOOL124 : BOOL;
		BOOL125 : BOOL;
		BOOL126 : BOOL;
		BOOL127 : BOOL;
		BOOL128 : BOOL;
		INT16 : INT; (*Filler Identification*)
		NumberOfPitch : INT; (*Filler number of Pitch*)
		NumberOfValve : INT; (*Filling Valve number*)
		CapdisHole : INT; (*Hole of preforms acceptable for Capdis v4.A.A.1.7.0*)
		INT24 : INT;
		INT26 : INT;
		INT28 : INT;
		INT30 : INT;
		INT32 : INT;
		INT34 : INT;
		INT36 : INT;
		INT38 : INT;
		INT40 : INT;
		INT42 : INT;
		INT44 : INT;
		INT46 : INT;
		INT48 : INT;
		INT50 : INT;
		INT52 : INT;
		INT54 : INT;
		INT56 : INT;
		INT58 : INT;
		INT60 : INT;
		INT62 : INT;
		INT64 : INT;
		INT66 : INT;
		INT68 : INT;
		INT70 : INT;
		INT72 : INT;
		INT74 : INT;
		INT76 : INT;
		INT78 : INT;
		CodeFault : DINT; (*Code Fault Stop Prod*)
		SpeedChangeReference : DINT; (*Filler Change Speed Reference (b/h)*)
		JogSpeed : DINT;
		CounterBadFilling : DINT; (*Counter Bad Filling  *)
		CounterBurstBottle : DINT; (*Counter Bottle Burst  *)
		CounterBadCapping : DINT; (*Counter Bad Capping  *)
		CounterBadBottle : DINT; (*Counter Bad Bottles from Bottles Inspector*)
		DINT108 : DINT;
		DINT112 : DINT;
		DINT116 : DINT;
		DINT120 : DINT;
		DINT124 : DINT;
		DINT128 : DINT;
		DINT132 : DINT;
		DINT136 : DINT;
		DINT140 : DINT;
	END_STRUCT;
	BlrFlr_Type : 	STRUCT 
		BOOL1 : BOOL;
		BOOL2 : BOOL;
		PbFlrProcessCommand : BOOL; (*PB "Filler Process Start Push Button" pressed  (on Blower Panel)*)
		PbMxrProcessCommand : BOOL; (*PB "Mixer Process Push Button" pressed  (on Blower Panel)*)
		PbFlrSpareCommand : BOOL; (*PB "Filler Spare Push Button" pressed  (on Blower Panel)*)
		PbFlrDoorCommand : BOOL; (*PB "Filler Doors Release Push Button" pressed  (on Blower Panel)*)
		BOOL7 : BOOL;
		BOOL8 : BOOL;
		BOOL9 : BOOL;
		PbPreformLoadingState : BOOL; (*PB "Preform Loading Push Button" state  (on Blower Panel) v4.A.A.1.7.0*)
		BOOL11 : BOOL;
		BOOL12 : BOOL;
		BOOL13 : BOOL;
		BOOL14 : BOOL;
		BOOL15 : BOOL;
		BOOL16 : BOOL;
		BlrReadyForCoupling : BOOL; (*Blower condition is ready for Coupling with Filler *)
		BOOL18 : BOOL;
		BOOL19 : BOOL;
		PbStart : BOOL; (*PB "Blower Start Push Button" Pressed *)
		PbStop : BOOL; (*PB "Blower Stop Push Button" Pressed *)
		SsAuto : BOOL; (*SS "Blower on Automatic Mode" Selected*)
		BOOL23 : BOOL;
		PbReset : BOOL; (*PB "Alarms Reset Push Button" Pressed *)
		PbResetLamp : BOOL; (*PB "Alarms Reset Push Button" Lamp Requested*)
		PbStartLampFix : BOOL; (*PB "Machine Start Push Button" Fix Lamp State V4.A.A.1.7.0 *)
		PbStartLampFlash : BOOL; (*PB "Machine Start Push Button" Flashing Lamp State  V4.A.A.1.7.0 *)
		BOOL28 : BOOL;
		BOOL29 : BOOL;
		ReadyToRun : BOOL; (*Blower is ready to Run on Auto/Jog Mode*)
		RedLightConfinementZone : BOOL; (*Doors Opened to be Confirmed (Red Light Confinement Zone)*)
		NoAlarm : BOOL; (*No alarm on Blower (Ready to Run, no Critical Fault))*)
		Empty : BOOL; (*Blower Machine is Empty *)
		Stopped : BOOL; (*Blower Machine is Stopped*)
		CmdStart : BOOL; (*Blower Internal Syncro Done, Ready to Synchronization *)
		LoadingInProgress : BOOL; (*Blower is Loading Preforms (Loading preform in progress)*)
		BottlePresentAtBlrOutfeed : BOOL; (*Bottle present in the outfeed machine*)
		RefPosValid : BOOL; (*Position Valid for Synchronization *)
		MachOutFree : BOOL; (*No Bottles at Machine Outfeed*)
		UnlockRequest : BOOL; (*Blower Transfer Doors Unlock Requested*)
		StopRequest : BOOL; (*Blower Critical Stop Requested*)
		RecipeChangeEnable : BOOL; (*Blower Recipe Change (Low Speed Recipe) Enable*)
		RecipeChangeRunning : BOOL; (*Blower Recipe Changed (Low Speed Recipe) Running*)
		SpeedChangeRunning : BOOL; (*Blower Speed Changed (on Speed Requested) Running*)
		BottleRejectionAtOufeedRequest : BOOL; (*Bottle to be rejected in the outfeed machine Requested*)
		VisionRejectionRequest : BOOL; (*Blower Vision Reject Bottle Requested*)
		DesynchroReq : BOOL; (*Desynchronization Requested (Power OFF)*)
		BOOL48 : BOOL;
		BOOL49 : BOOL;
		PbResetYieldCommand : BOOL; (*PB "Reset output yield Push Button" pressed  (on Blower Panel)*)
		IsolationDoorOpeningInProgress : BOOL; (*Isolation doors opening in progress*)
		BOOL52 : BOOL; (*Green button on MC1 for reseting the 24V fault (First combi generation)*)
		WaitTemperatureAt90 : BOOL; (*Wait 90°C temperature for anticipated restart*)
		CappingOnOddMold : BOOL; (*Used for loading 1/2 mold option*)
		AuthorizationCleanningCycle : BOOL; (*Autorisation cleaning cycle*)
		InitWheel : BOOL; (*Blower Reference position, Information for FCI*)
		CapdisWarm : BOOL; (*Authorization for CAPDIS warming up v4.A.A.1.7.0*)
		BOOL58 : BOOL;
		BOOL59 : BOOL;
		BOOL60 : BOOL;
		BOOL61 : BOOL;
		BOOL62 : BOOL;
		BOOL63 : BOOL;
		BOOL64 : BOOL;
		MachineClock : BOOL; (*Machine Clock for One Bottle Ejection*)
		Load : BOOL; (*Blower is Ready to Load Preforms (load Preform Enabled)*)
		BOOL67 : BOOL;
		BOOL68 : BOOL;
		BOOL69 : BOOL;
		BOOL70 : BOOL;
		BOOL71 : BOOL;
		BOOL72 : BOOL;
		RedLampFix : BOOL; (*Red Lamp Fix ON state (on Coupled Mode BF, BLF)*)
		RedLampFlash : BOOL; (*Red Lamp Flashing ON state (on Coupled Mode BF, BLF)*)
		BlueLampFix : BOOL; (*Blue Lamp Fix ON state (on Coupled Mode BLF)*)
		BlueLampFlash : BOOL; (*Blue Lamp Flashing ON state (on Coupled Mode BLF)*)
		BOOL77 : BOOL;
		BOOL78 : BOOL;
		BOOL79 : BOOL;
		BOOL80 : BOOL;
		BOOL81 : BOOL;
		BOOL82 : BOOL;
		BOOL83 : BOOL;
		BOOL84 : BOOL;
		BOOL85 : BOOL;
		BOOL86 : BOOL;
		BOOL87 : BOOL;
		BOOL88 : BOOL;
		BOOL89 : BOOL;
		BOOL90 : BOOL;
		BOOL91 : BOOL;
		BOOL92 : BOOL;
		BOOL93 : BOOL;
		BOOL94 : BOOL;
		BOOL95 : BOOL;
		BOOL96 : BOOL;
		BOOL97 : BOOL;
		BOOL98 : BOOL;
		BOOL99 : BOOL;
		BOOL100 : BOOL;
		BOOL101 : BOOL;
		BOOL102 : BOOL;
		BOOL103 : BOOL;
		BOOL104 : BOOL;
		BOOL105 : BOOL;
		BOOL106 : BOOL;
		BOOL107 : BOOL;
		BOOL108 : BOOL;
		BOOL109 : BOOL;
		BOOL110 : BOOL;
		BOOL111 : BOOL;
		BOOL112 : BOOL;
		BOOL113 : BOOL;
		BOOL114 : BOOL;
		BOOL115 : BOOL;
		BOOL116 : BOOL;
		BOOL117 : BOOL;
		BOOL118 : BOOL;
		BOOL119 : BOOL;
		BOOL120 : BOOL;
		BOOL121 : BOOL;
		BOOL122 : BOOL;
		BOOL123 : BOOL;
		BOOL124 : BOOL;
		BOOL125 : BOOL;
		BOOL126 : BOOL;
		BOOL127 : BOOL;
		BOOL128 : BOOL;
		INT16 : INT;
		INT18 : INT;
		INT20 : INT;
		INT22 : INT;
		NumberOfItemsInBlr : INT; (*Number items present in Blower*)
		ItemsBetweenRejectAndInfeed : INT; (*Number of steps between bottle reject and infeed on downstream equipment  *)
		NumberOfStepBeforeLoading : INT; (*Number of step before loading used for loading on X mold*)
		INT30 : INT;
		INT32 : INT;
		INT34 : INT;
		INT36 : INT;
		INT38 : INT;
		INT40 : INT;
		INT42 : INT;
		INT44 : INT;
		INT46 : INT;
		INT48 : INT;
		INT50 : INT;
		INT52 : INT;
		INT54 : INT;
		INT56 : INT;
		INT58 : INT;
		INT60 : INT;
		INT62 : INT;
		INT64 : INT;
		INT66 : INT;
		INT68 : INT;
		INT70 : INT;
		INT72 : INT;
		INT74 : INT;
		INT76 : INT;
		INT78 : INT;
		PositionReference : DINT; (*Actis Encoder position (0..3600000)  V4.A.A.1.7.0*)
		SpeedReference : DINT; (*Output Speed (b/h)*)
		DINT88 : DINT;
		DINT92 : DINT;
		DINT96 : DINT;
		DINT100 : DINT;
		DINT104 : DINT;
		DINT108 : DINT;
		DINT112 : DINT;
		DINT116 : DINT;
		DINT120 : DINT;
		DINT124 : DINT;
		DINT128 : DINT;
		DINT132 : DINT;
		DINT136 : DINT;
		DINT140 : DINT;
	END_STRUCT;
	BlrFlrMotion_Type : 	STRUCT 
		UINT1 : UINT;
		UINT2 : UINT;
		UDINT1 : UDINT;
		UDINT2 : UDINT;
		UDINT3 : UDINT;
		VM1_POSITION_LREAL : LREAL;
		UDINT5 : UDINT;
		UDINT6 : UDINT;
		UDINT7 : UDINT;
		UDINT8 : UDINT;
		UDINT9 : UDINT;
		UDINT10 : UDINT;
		UDINT11 : UDINT;
		UDINT12 : UDINT;
		UDINT14 : UDINT;
		UDINT13 : UDINT;
	END_STRUCT;
END_TYPE

(*LABELLER COMMUNICATION*)

TYPE
	FlrLbr_Type : 	STRUCT 
		BOOL1 : BOOL;
		BOOL2 : BOOL;
		BOOL3 : BOOL;
		BOOL4 : BOOL;
		BOOL5 : BOOL;
		PbLbrFlrCouplingState : BOOL; (*PB "LF Coupling Push Button" State  Labeler-Filler on "LF Machine Coupled" *)
		BOOL7 : BOOL;
		PbFlrProcessPresent : BOOL; (*PB "Filler Process Start Push Button" Present*)
		PbFlrProcessEnable : BOOL; (*PB "Filler Process Start Push Button" Enabled*)
		PbFlrProcessState : BOOL; (*PB "Filler Process Start Push Button" State*)
		PbFlrMixerPresent : BOOL; (*PB "Mixer Start/Stop Push Button" Present *)
		PbFlrMixerEnable : BOOL; (*PB "Mixer Start/Stop Push Button" Enabled *)
		PbFlrMixerState : BOOL; (*PB "Mixer Start/Stop Push Button" State*)
		PbFlrDoorEnable : BOOL; (*PB "Filler Doors Release Push Button" Enabled*)
		PbFlrDoorState : BOOL; (*PB "Filler Doors Release Push Button" State*)
		BOOL16 : BOOL;
		BOOL17 : BOOL;
		BOOL18 : BOOL;
		BOOL19 : BOOL;
		PbFlrStart : BOOL; (*PB "Filler Start Push Button" Pressed*)
		BOOL21 : BOOL;
		SsAuto : BOOL; (*SS "Filler on Automatic Mode" Selected*)
		BOOL23 : BOOL;
		PbReset : BOOL; (*PB "Alarms Reset Push Button" Pressed*)
		BOOL25 : BOOL;
		BOOL26 : BOOL;
		BOOL27 : BOOL;
		BOOL28 : BOOL;
		BOOL29 : BOOL;
		ReadyToRun : BOOL; (*Filler is ready to Run on Auto/Jog Mode*)
		ConfirmLamp : BOOL; (*Doors Opened to be Confirmed (Lamp Confinement Zone)*)
		NoAlarm : BOOL; (*No alarm on Filler (Ready to Run, no Critical Fault)*)
		Empty : BOOL; (*Filler Machine is Empty*)
		Stopped : BOOL; (*Filler Machine is Stopped*)
		SynchroDone : BOOL; (*Filler Syncronized with Labeler (ready to Start Labeler on Syncro Mode)*)
		BOOL36 : BOOL;
		TrGateOpened : BOOL; (*Labeller/Filler Transfer Gate Opened*)
		BOOL38 : BOOL;
		BotPresInlet : BOOL; (*Bottles presence at Inlet*)
		UnlockRequest : BOOL; (*Filler Transfer Doors Unlock Requested*)
		StopRequest : BOOL; (*Filler  Critical Stop Requested*)
		SpeedChangeRequest : BOOL; (*Filler Change Speed (for Fix Speed) Requested*)
		BOOL43 : BOOL;
		NoLabel : BOOL; (*Bottles without Label required*)
		BottleEjectionRequest : BOOL; (*Bottles Ejection on Transfer Requested*)
		EjectionOneBottleRequest : BOOL; (*Eject single specific Bottle (with signal TRUE) Requested*)
		DesynchroReq : BOOL; (*Desynchronization Requested (Power OFF)*)
		BatchModeReq : BOOL; (*Batch Mode for high temperature on the Filler V4.A.A.1.6.12*)
		BOOL49 : BOOL;
		BOOL50 : BOOL;
		BOOL51 : BOOL;
		BOOL52 : BOOL;
		BOOL53 : BOOL;
		BOOL54 : BOOL;
		BOOL55 : BOOL;
		BOOL56 : BOOL;
		BOOL57 : BOOL;
		BOOL58 : BOOL;
		BOOL59 : BOOL;
		BOOL60 : BOOL;
		BOOL61 : BOOL;
		BOOL62 : BOOL;
		BOOL63 : BOOL;
		BOOL64 : BOOL;
		BOOL65 : BOOL;
		Load : BOOL; (*Filler is Ready to Load Preforms (load Preform Enabled)*)
		BOOL67 : BOOL;
		BOOL68 : BOOL;
		BOOL69 : BOOL;
		BOOL70 : BOOL;
		BOOL71 : BOOL;
		BOOL72 : BOOL;
		RedLampFix : BOOL; (*Red Lamp Fix ON state (on Coupled Mode LF, BLF)*)
		RedLampFlash : BOOL; (*Red Lamp Flashing ON state (on Coupled Mode LF, BLF)*)
		BlueLampFix : BOOL; (*Blue Lamp Fix ON state (on Coupled Mode BLF)*)
		BlueLampFlash : BOOL; (*Blue Lamp Flashing ON state (on Coupled Mode BLF)*)
		BOOL77 : BOOL;
		BOOL78 : BOOL;
		BOOL79 : BOOL;
		BOOL80 : BOOL;
		BOOL81 : BOOL;
		BOOL82 : BOOL;
		BOOL83 : BOOL;
		BOOL84 : BOOL;
		BOOL85 : BOOL;
		BOOL86 : BOOL;
		BOOL87 : BOOL;
		BOOL88 : BOOL;
		BOOL89 : BOOL;
		BOOL90 : BOOL;
		BOOL91 : BOOL;
		BOOL92 : BOOL;
		BOOL93 : BOOL;
		BOOL94 : BOOL;
		BOOL95 : BOOL;
		BOOL96 : BOOL;
		BOOL97 : BOOL;
		BOOL98 : BOOL;
		BOOL99 : BOOL;
		BOOL100 : BOOL;
		BOOL101 : BOOL;
		BOOL102 : BOOL;
		BOOL103 : BOOL;
		BOOL104 : BOOL;
		BOOL105 : BOOL;
		BOOL106 : BOOL;
		BOOL107 : BOOL;
		BOOL108 : BOOL;
		BOOL109 : BOOL;
		BOOL110 : BOOL;
		BOOL111 : BOOL;
		BOOL112 : BOOL;
		BOOL113 : BOOL;
		BOOL114 : BOOL;
		BOOL115 : BOOL;
		BOOL116 : BOOL;
		BOOL117 : BOOL;
		BOOL118 : BOOL;
		BOOL119 : BOOL;
		BOOL120 : BOOL;
		BOOL121 : BOOL;
		BOOL122 : BOOL;
		BOOL123 : BOOL;
		BOOL124 : BOOL;
		BOOL125 : BOOL;
		BOOL126 : BOOL;
		BOOL127 : BOOL;
		BOOL128 : BOOL;
		INT16 : INT;
		INT18 : INT;
		NumberOfValve : INT; (*Filling Valve number*)
		FillingValve : INT; (*Bottle Filling Valve Number*)
		CappingHead : INT; (*Bottle Capping Head Number*)
		INT26 : INT;
		INT28 : INT;
		INT30 : INT;
		INT32 : INT;
		INT34 : INT;
		INT36 : INT;
		INT38 : INT;
		INT40 : INT;
		INT42 : INT;
		INT44 : INT;
		INT46 : INT;
		INT48 : INT;
		INT50 : INT;
		INT52 : INT;
		INT54 : INT;
		INT56 : INT;
		INT58 : INT;
		INT60 : INT;
		INT62 : INT;
		INT64 : INT;
		INT66 : INT;
		INT68 : INT;
		INT70 : INT;
		INT72 : INT;
		INT74 : INT;
		INT76 : INT;
		INT78 : INT;
		SpeedChangeReference : DINT; (*Filler Change Speed Reference (b/h)*)
		DINT84 : DINT;
		JogSpeed : DINT; (*JOG Safe Limit Speed SLS (b/h)*)
		DINT92 : DINT;
		DINT96 : DINT;
		DINT100 : DINT;
		DINT104 : DINT;
		DINT108 : DINT;
		DINT112 : DINT;
		DINT116 : DINT;
		DINT120 : DINT;
		DINT124 : DINT;
		DINT128 : DINT;
		DINT132 : DINT;
		DINT136 : DINT;
		DINT140 : DINT;
	END_STRUCT;
	LbrFlr_Type : 	STRUCT 
		BOOL1 : BOOL;
		PbBlrLbrCouplingState : BOOL; (*PB "BL Coupling Push Button" state  Blower-Labeler on "BL Machine Coupled" *)
		BOOL3 : BOOL;
		BOOL4 : BOOL;
		BOOL5 : BOOL;
		BOOL6 : BOOL;
		BOOL7 : BOOL;
		BOOL8 : BOOL;
		BOOL9 : BOOL;
		BOOL10 : BOOL;
		BOOL11 : BOOL;
		BOOL12 : BOOL;
		BOOL13 : BOOL;
		ReadyForCoupling : BOOL; (*Labeler condition is ready for Coupling with Filler *)
		PbFlrProcessCommand : BOOL; (*PB "Filler Process Start Push Button" pressed *)
		PbFlrMixerCommand : BOOL; (*PB "Mixer Start/Stop Push Button" pressed *)
		PbFlrDoorCommand : BOOL; (*PB "Filler Doors Release Push Button" pressed*)
		BOOL18 : BOOL;
		BOOL19 : BOOL;
		BOOL20 : BOOL;
		BOOL21 : BOOL;
		SsAuto : BOOL; (*SS "Labeler on Automatic Mode" Selected*)
		BOOL23 : BOOL;
		BOOL24 : BOOL;
		PbResetLamp : BOOL; (*PB "Alarms Reset Push Button" Lamp Requested*)
		PbStartLamp : BOOL; (*PB "Machine Start Push Button" Lamp Requested*)
		BOOL27 : BOOL;
		BOOL28 : BOOL;
		BOOL29 : BOOL;
		ReadyToRun : BOOL; (*Labeler is ready to Run on Auto/Jog Mode*)
		ConfirmLamp : BOOL; (*Doors Opened to be Confirmed (Lamp Confinement Zone)*)
		NoAlarm : BOOL; (*No alarm on Labeler (Ready to Run, no Critical Fault))*)
		Empty : BOOL; (*Labeler Machine is Empty *)
		Stopped : BOOL; (*Labeler Machine is Stopped*)
		CmdStart : BOOL; (*Running Start Command (LF Machine Coupled)*)
		RefPosValid : BOOL; (*Position Valid for Synchronization *)
		BottlesOutfeed : BOOL; (*Bottle present in the outfeed machine*)
		BOOL38 : BOOL;
		MachOutFree : BOOL; (*No Bottles at Machine Outfeed*)
		UnlockRequest : BOOL; (*Labeler Transfer Doors Unlock Requested*)
		StopRequest : BOOL; (*Labeler Critical Stop Requested*)
		SpeedChangedRunning : BOOL; (*Labeler Speed Changed (on Speed Requested) Running*)
		BOOL43 : BOOL;
		BOOL44 : BOOL;
		BOOL45 : BOOL;
		BOOL46 : BOOL;
		DesynchroReq : BOOL; (*Desynchronization Requested (Power OFF)*)
		BOOL48 : BOOL;
		BOOL49 : BOOL;
		BOOL50 : BOOL;
		BOOL51 : BOOL;
		BOOL52 : BOOL;
		BOOL53 : BOOL;
		BOOL54 : BOOL;
		BOOL55 : BOOL;
		InitPosition : BOOL; (*Labeler reference position, Information for FCI*)
		BOOL57 : BOOL;
		BOOL58 : BOOL;
		BOOL59 : BOOL;
		BOOL60 : BOOL;
		BOOL61 : BOOL;
		BOOL62 : BOOL;
		BOOL63 : BOOL;
		BOOL64 : BOOL;
		MachineClock : BOOL; (*Machine Clock for One Bottle Ejection*)
		Load : BOOL; (*Labeler is Ready to Load Preforms (load Preform Enabled)*)
		BOOL67 : BOOL;
		BOOL68 : BOOL;
		BOOL69 : BOOL;
		BOOL70 : BOOL;
		BOOL71 : BOOL;
		BOOL72 : BOOL;
		RedLampFix : BOOL; (*Red Lamp Fix ON state (on Coupled Mode LF, BLF)*)
		RedLampFlash : BOOL; (*Red Lamp Flashing ON state (on Coupled Mode LF, BLF)*)
		BlueLampFix : BOOL; (*Blue Lamp Fix ON state (on Coupled Mode BLF)*)
		BlueLampFlash : BOOL; (*Blue Lamp Flashing ON state (on Coupled Mode BLF)*)
		BOOL77 : BOOL;
		BOOL78 : BOOL;
		BOOL79 : BOOL;
		BOOL80 : BOOL;
		BOOL81 : BOOL;
		BOOL82 : BOOL;
		BOOL83 : BOOL;
		BOOL84 : BOOL;
		BOOL85 : BOOL;
		BOOL86 : BOOL;
		BOOL87 : BOOL;
		BOOL88 : BOOL;
		BOOL89 : BOOL;
		BOOL90 : BOOL;
		BOOL91 : BOOL;
		BOOL92 : BOOL;
		BOOL93 : BOOL;
		BOOL94 : BOOL;
		BOOL95 : BOOL;
		BOOL96 : BOOL;
		BOOL97 : BOOL;
		BOOL98 : BOOL;
		BOOL99 : BOOL;
		BOOL100 : BOOL;
		BOOL101 : BOOL;
		BOOL102 : BOOL;
		BOOL103 : BOOL;
		BOOL104 : BOOL;
		BOOL105 : BOOL;
		BOOL106 : BOOL;
		BOOL107 : BOOL;
		BOOL108 : BOOL;
		BOOL109 : BOOL;
		BOOL110 : BOOL;
		BOOL111 : BOOL;
		BOOL112 : BOOL;
		BOOL113 : BOOL;
		BOOL114 : BOOL;
		BOOL115 : BOOL;
		BOOL116 : BOOL;
		BOOL117 : BOOL;
		BOOL118 : BOOL;
		BOOL119 : BOOL;
		BOOL120 : BOOL;
		BOOL121 : BOOL;
		BOOL122 : BOOL;
		BOOL123 : BOOL;
		BOOL124 : BOOL;
		BOOL125 : BOOL;
		BOOL126 : BOOL;
		BOOL127 : BOOL;
		BOOL128 : BOOL;
		NumberOfItemsInLbr : INT; (*Number Items present in Labeler*)
		INT18 : INT;
		NumberOfPlate : INT; (*Labeler Carousel Plate number*)
		INT22 : INT;
		INT24 : INT;
		INT26 : INT;
		INT28 : INT;
		INT30 : INT;
		INT32 : INT;
		INT34 : INT;
		INT36 : INT;
		INT38 : INT;
		INT40 : INT;
		INT42 : INT;
		INT44 : INT;
		INT46 : INT;
		INT48 : INT;
		INT50 : INT;
		INT52 : INT;
		INT54 : INT;
		INT56 : INT;
		INT58 : INT;
		INT60 : INT;
		INT62 : INT;
		INT64 : INT;
		INT66 : INT;
		INT68 : INT;
		INT70 : INT;
		INT72 : INT;
		INT74 : INT;
		INT76 : INT;
		INT78 : INT;
		SpeedReference : DINT; (*Output Speed (b/h)*)
		DINT84 : DINT;
		DINT88 : DINT;
		DINT92 : DINT;
		DINT96 : DINT;
		DINT100 : DINT;
		DINT104 : DINT;
		DINT108 : DINT;
		DINT112 : DINT;
		DINT116 : DINT;
		DINT120 : DINT;
		DINT124 : DINT;
		DINT128 : DINT;
		DINT132 : DINT;
		DINT136 : DINT;
		DINT140 : DINT;
	END_STRUCT;
	LbrFlrMotion_Type : 	STRUCT 
		UINT1 : UINT;
		UINT2 : UINT;
		VLAB_POSITION : UDINT; (*0..36000 // Position of Virtual Labeler*)
		UDINT2 : UDINT;
		UDINT3 : UDINT;
		VLAB_POSITION_LREAL : LREAL;
		UDINT5 : UDINT;
		UDINT6 : UDINT;
		UDINT7 : UDINT;
		UDINT8 : UDINT;
		UDINT9 : UDINT;
		UDINT10 : UDINT;
		UDINT11 : UDINT;
		UDINT12 : UDINT;
		UDINT13 : UDINT;
		UDINT14 : UDINT;
	END_STRUCT;
END_TYPE

(*ACTIS COMUNICATION*)

TYPE
	FlrAct_Type : 	STRUCT  (*V4.A.A.1.6.12*)
		BOOL1 : BOOL;
		BOOL2 : BOOL;
		BOOL3 : BOOL;
		BOOL4 : BOOL;
		BOOL5 : BOOL;
		PbActFlrCouplingState : BOOL; (*PB "BF Coupling Push Button" state  Actis-Filler on "AF Machine Coupling" *)
		BOOL7 : BOOL;
		PbFlrProcessPresent : BOOL; (*PB "Filler Process Start Push Button" Present *)
		PbFlrProcessEnable : BOOL; (*PB "Filler Process Start Push Button" Enabled*)
		PbFlrProcessState : BOOL; (*PB "Filler Process Start Push Button" State*)
		PbFlrMixerPresent : BOOL; (*PB "Mixer Start/Stop Push Button" Present *)
		PbFlrMixerEnable : BOOL; (*PB "Mixer Start/Stop Push Button" Enabled*)
		PbFlrMixerState : BOOL; (*PB "Mixer Start/Stop Push Button" State*)
		PbFlrDoorEnable : BOOL; (*PB "Filler Doors Release Push Button" Enabled*)
		PbFlrDoorState : BOOL; (*PB "Filler Doors Release Push Button" State*)
		BOOL16 : BOOL;
		BOOL17 : BOOL;
		BOOL18 : BOOL;
		BOOL19 : BOOL;
		PbStart : BOOL; (*PB "Filler Start Push Button" Pressed*)
		PbStop : BOOL; (*PB "Filler Stop Push Button" Pressed V4.A.A.1.7.0*)
		SsAuto : BOOL; (*SS "Filler on Automatic Mode" Selected *)
		PbReset : BOOL; (*PB "Alarms Reset Push Button" Pressed *)
		BOOL24 : BOOL;
		PbResetLamp : BOOL; (*PB "Alarms Reset Push Button" Lamp Requested V4.A.A.1.7.0*)
		PbStartLamp : BOOL; (*PB "Machine Start Push Button" Lamp Requested V4.A.A.1.7.0*)
		BOOL27 : BOOL;
		BOOL28 : BOOL;
		BOOL29 : BOOL;
		ReadyToRun : BOOL; (*Filler is ready to Run on Auto/Jog Mode*)
		RedLightConfinementZone : BOOL; (*Doors Opened to be Confirmed (Red Light Confinement Zone)*)
		NoAlarm : BOOL; (*No alarm on Filler (Ready to Run, no Critical Fault)*)
		Empty : BOOL; (*Filler Machine is Empty*)
		Stopped : BOOL; (*Filler Machine is Stopped*)
		SynchroDone : BOOL; (*Filler Syncronized with Blower (ready to Start Blower on Syncro Mode)*)
		Production : BOOL; (*Filler in production V4.A.A.1.7.0*)
		ProductionStop : BOOL; (*Filler production stop V4.A.A.1.7.0*)
		StandBy : BOOL; (*Filler on Standby Output Rate V4.A.A.1.7.0*)
		BOOL39 : BOOL;
		UnlockRequest : BOOL; (*Filler Transfer Door Unlock Request*)
		StopRequest : BOOL; (*Filler  Critical Stop Requested V4.A.A.1.7.0*)
		SpeedChangeRequest : BOOL; (*Filler Change Speed (for Fix Speed) Requested*)
		BOOL43 : BOOL;
		BOOL44 : BOOL;
		BOOL45 : BOOL;
		BOOL46 : BOOL;
		BOOL47 : BOOL;
		BOOL48 : BOOL;
		BOOL49 : BOOL;
		BOOL50 : BOOL;
		BOOL51 : BOOL;
		BOOL52 : BOOL;
		BOOL53 : BOOL;
		BOOL54 : BOOL;
		BOOL55 : BOOL;
		BOOL56 : BOOL;
		BOOL57 : BOOL;
		Valve1 : BOOL; (*Filler valve #1 at Init to laser printer*)
		Head1 : BOOL; (*Capper device #1 at Init to laser printer*)
		Nozzle1 : BOOL; (*Rinser device #1 at Init to laser printer*)
		RinserByPass : BOOL; (*By-Pass Rinser*)
		BOOL62 : BOOL;
		BOOL63 : BOOL;
		BOOL64 : BOOL;
		BOOL65 : BOOL;
		Load : BOOL; (*Filler is ready to Load Preform (load Preform Enabled)*)
		ComunicationStatus : BOOL; (*Comunication Status*)
		BOOL68 : BOOL;
		BOOL69 : BOOL;
		BOOL70 : BOOL;
		BOOL71 : BOOL;
		BOOL72 : BOOL;
		RedLampFix : BOOL; (*Red Lamp Fix ON state (on Coupled Mode BF, BAF)*)
		RedLampFlash : BOOL; (*Red Lamp Flashing ON state (on Coupled Mode BF, BAF)*)
		BlueLampFix : BOOL; (*Blue Lamp Fix ON state (on Coupled Mode BF, BAF)*)
		BlueLampFlash : BOOL; (*Blue Lamp Flashing ON state (on Coupled Mode BF, BAF)*)
		BOOL77 : BOOL;
		BOOL78 : BOOL;
		BOOL79 : BOOL;
		BOOL80 : BOOL;
		BOOL81 : BOOL;
		BOOL82 : BOOL;
		BOOL83 : BOOL;
		BOOL84 : BOOL;
		BOOL85 : BOOL;
		BOOL86 : BOOL;
		BOOL87 : BOOL;
		BOOL88 : BOOL;
		BOOL89 : BOOL;
		BOOL90 : BOOL;
		BOOL91 : BOOL;
		BOOL92 : BOOL;
		BOOL93 : BOOL;
		BOOL94 : BOOL;
		BOOL95 : BOOL;
		BOOL96 : BOOL;
		BOOL97 : BOOL;
		BOOL98 : BOOL;
		BOOL99 : BOOL;
		BOOL100 : BOOL;
		BOOL101 : BOOL;
		BOOL102 : BOOL;
		BOOL103 : BOOL;
		BOOL104 : BOOL;
		BOOL105 : BOOL;
		BOOL106 : BOOL;
		BOOL107 : BOOL;
		BOOL108 : BOOL;
		BOOL109 : BOOL;
		BOOL110 : BOOL;
		BOOL111 : BOOL;
		BOOL112 : BOOL;
		BOOL113 : BOOL;
		BOOL114 : BOOL;
		BOOL115 : BOOL;
		BOOL116 : BOOL;
		BOOL117 : BOOL;
		BOOL118 : BOOL;
		BOOL119 : BOOL;
		BOOL120 : BOOL;
		BOOL121 : BOOL;
		BOOL122 : BOOL;
		BOOL123 : BOOL;
		BOOL124 : BOOL;
		BOOL125 : BOOL;
		BOOL126 : BOOL;
		BOOL127 : BOOL;
		BOOL128 : BOOL;
		NumberOfNozzle : INT; (*Rinsing Nozzle number*)
		NumberOfValve : INT; (*Filling Valve number*)
		NumberOfHead : INT; (*Capping Head number*)
		INT22 : INT;
		INT24 : INT;
		INT26 : INT;
		INT28 : INT;
		INT30 : INT;
		INT32 : INT;
		INT34 : INT;
		INT36 : INT;
		INT38 : INT;
		INT40 : INT;
		INT42 : INT;
		INT44 : INT;
		INT46 : INT;
		INT48 : INT;
		INT50 : INT;
		INT52 : INT;
		INT54 : INT;
		INT56 : INT;
		INT58 : INT;
		INT60 : INT;
		INT62 : INT;
		INT64 : INT;
		INT66 : INT;
		INT68 : INT;
		INT70 : INT;
		INT72 : INT;
		INT74 : INT;
		INT76 : INT;
		INT78 : INT;
		DINT80 : DINT;
		DINT84 : DINT;
		JogSpeed : DINT; (*JOG Safe Speed SLS (b/h)*)
		DINT92 : DINT;
		DINT96 : DINT;
		DINT100 : DINT;
		DINT104 : DINT;
		DINT108 : DINT;
		DINT112 : DINT;
		DINT116 : DINT;
		DINT120 : DINT;
		DINT124 : DINT;
		DINT128 : DINT;
		DINT132 : DINT;
		DINT136 : DINT;
		DINT140 : DINT;
	END_STRUCT;
	ActFlr_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		BOOL1 : BOOL;
		PbBlrActCouplingState : BOOL; (*PB "BA Copling Push Button" state Blower-Actis on "BA Machine Coupled"*)
		BOOL3 : BOOL;
		BOOL4 : BOOL;
		BOOL5 : BOOL;
		BOOL6 : BOOL;
		BOOL7 : BOOL;
		BOOL8 : BOOL;
		BOOL9 : BOOL;
		BOOL10 : BOOL;
		BOOL11 : BOOL;
		BOOL12 : BOOL;
		BOOL13 : BOOL;
		ReadyForCoupling : BOOL; (*Actis condition is ready for coupling with Filler*)
		PbFlrProcessCommand : BOOL; (*PB "Filler Process Start Push Button" Pressed *)
		PbFlrMixerCommand : BOOL; (*PB "Mixer Start/Stop Push Button" Pressed *)
		PbFlrDoorCommand : BOOL; (*PB "Filler Doors Release Push Button" Pressed *)
		BOOL18 : BOOL;
		BOOL19 : BOOL;
		BOOL20 : BOOL;
		BOOL21 : BOOL;
		SsAuto : BOOL; (*SS "Actis on Automatic Mode" Selected*)
		BOOL23 : BOOL;
		BOOL24 : BOOL;
		PbResetLamp : BOOL; (*PB "Alarms Reset Push Button" Flashing Lamp Requested*)
		PbStartLamp : BOOL; (*PB "Machine Start Push Button" Flashing Lamp Requested*)
		BOOL27 : BOOL;
		BOOL28 : BOOL;
		BOOL29 : BOOL;
		ReadyToRun : BOOL; (*Actis is ready to Run on Auto/Jog Mode*)
		ConfirmLamp : BOOL; (*Doors Opened to be Confirmed (Red Light Confinement Zone)*)
		NoAlarm : BOOL; (*No alarm on Actis (Ready to Run, no Critical Fault))*)
		Empty : BOOL; (*Actis Machine is Empty *)
		Stopped : BOOL; (*Actis Machine is Stopped*)
		CmdStart : BOOL; (*Running Start Command(BAF-AF Machine coupled)*)
		RefPosValid : BOOL; (*Position Valid for Synchronization *)
		BottleOutfeed : BOOL; (*Bottle present in the outfeed machine*)
		BOOL38 : BOOL;
		BOOL39 : BOOL;
		UnlockRequest : BOOL; (*Actis Transfer Doors Unlock Requested*)
		StopRequest : BOOL; (*Actis Critical Stop Requested V4.A.A.1.7.0*)
		BOOL42 : BOOL;
		BOOL43 : BOOL;
		BOOL44 : BOOL;
		BOOL45 : BOOL;
		BOOL46 : BOOL;
		BOOL47 : BOOL;
		BOOL48 : BOOL;
		BOOL49 : BOOL;
		BOOL50 : BOOL;
		BOOL51 : BOOL;
		BOOL52 : BOOL;
		BOOL53 : BOOL;
		BOOL54 : BOOL;
		BOOL55 : BOOL;
		EncoderHomed : BOOL; (*Actis Encoder Homed*)
		BOOL57 : BOOL;
		BOOL58 : BOOL;
		BOOL59 : BOOL;
		BOOL60 : BOOL;
		BOOL61 : BOOL;
		BOOL62 : BOOL;
		BOOL63 : BOOL;
		BOOL64 : BOOL;
		MachineClock : BOOL; (*Machine Clock for One Bottle Ejection*)
		Load : BOOL; (*Actis is Ready to Load Preforms (load Preform Enabled)*)
		ComunicationStatus : BOOL; (*Comunication Status*)
		WheelBypassed : BOOL; (*Actis Wheel Bypassed*)
		BOOL69 : BOOL;
		BOOL70 : BOOL;
		BOOL71 : BOOL;
		BOOL72 : BOOL;
		RedLampFix : BOOL; (*Red Lamp Fix ON state (on Coupled Mode AF, BAF)*)
		RedLampFlash : BOOL; (*Red Lamp Flashing ON state (on Coupled Mode AF, BAF)*)
		BlueLampFix : BOOL; (*Blue Lamp Fix ON state (on Coupled Mode BAF)*)
		BlueLampFlash : BOOL; (*Blue Lamp Flashing ON state (on Coupled Mode BAF)*)
		BOOL77 : BOOL;
		BOOL78 : BOOL;
		BOOL79 : BOOL;
		BOOL80 : BOOL;
		BOOL81 : BOOL;
		BOOL82 : BOOL;
		BOOL83 : BOOL;
		BOOL84 : BOOL;
		BOOL85 : BOOL;
		BOOL86 : BOOL;
		BOOL87 : BOOL;
		BOOL88 : BOOL;
		BOOL89 : BOOL;
		BOOL90 : BOOL;
		BOOL91 : BOOL;
		BOOL92 : BOOL;
		BOOL93 : BOOL;
		BOOL94 : BOOL;
		BOOL95 : BOOL;
		BOOL96 : BOOL;
		BOOL97 : BOOL;
		BOOL98 : BOOL;
		BOOL99 : BOOL;
		BOOL100 : BOOL;
		BOOL101 : BOOL;
		BOOL102 : BOOL;
		BOOL103 : BOOL;
		BOOL104 : BOOL;
		BOOL105 : BOOL;
		BOOL106 : BOOL;
		BOOL107 : BOOL;
		BOOL108 : BOOL;
		BOOL109 : BOOL;
		BOOL110 : BOOL;
		BOOL111 : BOOL;
		BOOL112 : BOOL;
		BOOL113 : BOOL;
		BOOL114 : BOOL;
		BOOL115 : BOOL;
		BOOL116 : BOOL;
		BOOL117 : BOOL;
		BOOL118 : BOOL;
		BOOL119 : BOOL;
		BOOL120 : BOOL;
		BOOL121 : BOOL;
		BOOL122 : BOOL;
		BOOL123 : BOOL;
		BOOL124 : BOOL;
		BOOL125 : BOOL;
		BOOL126 : BOOL;
		BOOL127 : BOOL;
		BOOL128 : BOOL;
		NumberOfItemsInAct : INT; (*Number items present in Actis*)
		ItemsBetweenRejectAndInfeed : INT; (*Number of steps between bottle reject and infeed Filler*)
		CavityNumber : INT; (*Number of cavity*)
		INT22 : INT;
		INT24 : INT;
		INT26 : INT;
		INT28 : INT;
		INT30 : INT;
		INT32 : INT;
		INT34 : INT;
		INT36 : INT;
		INT38 : INT;
		INT40 : INT;
		INT42 : INT;
		INT44 : INT;
		INT46 : INT;
		INT48 : INT;
		INT50 : INT;
		INT52 : INT;
		INT54 : INT;
		INT56 : INT;
		INT58 : INT;
		INT60 : INT;
		INT62 : INT;
		INT64 : INT;
		INT66 : INT;
		INT68 : INT;
		INT70 : INT;
		INT72 : INT;
		INT74 : INT;
		INT76 : INT;
		INT78 : INT;
		PositionReference : DINT; (*Actis Encoder position (0..3600000)*)
		SpeedReference : DINT; (*Actis sized Speed  (0..40000 b/h)*)
		DINT88 : DINT;
		DINT92 : DINT;
		DINT96 : DINT;
		DINT100 : DINT;
		DINT104 : DINT;
		DINT108 : DINT;
		DINT112 : DINT;
		DINT116 : DINT;
		DINT120 : DINT;
		DINT124 : DINT;
		DINT128 : DINT;
		DINT132 : DINT;
		DINT136 : DINT;
		DINT140 : DINT;
	END_STRUCT;
	ActFlrMotion_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		UINT1 : UINT;
		UINT2 : UINT;
		UDINT1 : UDINT;
		UDINT2 : UDINT;
		UDINT3 : UDINT;
		UDINT4 : UDINT;
		UDINT5 : UDINT;
		UDINT6 : UDINT;
		UDINT7 : UDINT;
		UDINT8 : UDINT;
		UDINT9 : UDINT;
		UDINT10 : UDINT;
		UDINT11 : UDINT;
		UDINT12 : UDINT;
		UDINT14 : UDINT;
		UDINT13 : UDINT;
	END_STRUCT;
END_TYPE

(*SIDEL PROCESS COMMUNICATION*)

TYPE
	FlrSidelPrc_Type : 	STRUCT 
		Alive : BOOL; (*Alive Bit*)
		ResetPB : BOOL; (*Command: Skid Reset *)
		BOOL2 : BOOL; (*Command:*)
		BOOL3 : BOOL; (*Command:*)
		BOOL4 : BOOL; (*Command:*)
		BOOL5 : BOOL; (*Command:*)
		AVF254Op : BOOL; (*Device State: Filler Valve AVF254 Opened*)
		AVF254Cl : BOOL; (*Device State: Filler Valve AVF254 Closed*)
		LSF201H : BOOL; (*Instrument State: Rotary tank level switch 1*)
		LSF202H : BOOL; (*Instrument State: Rotary tank level switch 2*)
		LSF203H : BOOL; (*Instrument State: Rotary tank level switch 3*)
		LSF204H : BOOL; (*Instrument State: Rotary tank level switch 4*)
		LSF207 : BOOL; (*Instrument State: Tank level switch LSF207 (RMO) v1.4*)
		AVF268Op : BOOL; (*Device State: Filler Valve AVF268 Opened V4.A.A.1.7.1*)
		AVF268Cl : BOOL; (*Device State: Filler Valve AVF268 Closed V4.A.A.1.7.1*)
		BOOL15 : BOOL; (*Instrument State:*)
		BOOL16 : BOOL; (*Instrument State:*)
		BOOL17 : BOOL; (*Instrument State:*)
		BOOL18 : BOOL; (*Instrument State:*)
		BOOL19 : BOOL; (*Instrument State:*)
		BOOL20 : BOOL; (*Instrument State:*)
		BOOL21 : BOOL; (*Instrument State:*)
		BOOL22 : BOOL; (*Instrument State:*)
		BOOL23 : BOOL; (*Instrument State:*)
		AVS219Cmd : BOOL; (*Device Command: AVS219 Open Command*)
		AVE233Cmd : BOOL; (*Device Command: AVE233 Open Command*)
		AVE234Cmd : BOOL; (*Device Command: AVE234 Open Command*)
		AVE235Cmd : BOOL; (*Device Command: AVE235 Open Command*)
		AVE251Cmd : BOOL; (*Device Command: AVE251 Open Command*)
		AVE238Cmd : BOOL; (*Device Command: AVE238 Open Command*)
		BOOL30 : BOOL; (*Device Command:*)
		BOOL31 : BOOL; (*Device Command:*)
		AVG260Op : BOOL; (*Device State: Filler Valve AVG260 Opened*)
		AVG260Cl : BOOL; (*Device State: Filler Valve AVG260 Closed*)
		BOOL34 : BOOL; (*Device Command:*)
		BOOL35 : BOOL; (*Device Command:*)
		BOOL36 : BOOL; (*Device Command:*)
		BOOL37 : BOOL; (*Device Command:*)
		BOOL38 : BOOL; (*Device Command:*)
		BOOL39 : BOOL; (*Device Command:*)
		AlarmPresent : BOOL; (*Memory: Filler on Safety Stop Alarm*)
		ModeReady : BOOL; (*Memory: Filler Ready to Start Selection Mode*)
		EndCont : BOOL; (*Memory: End production - Filler Containers Stop for End Production*)
		WaterPushAck : BOOL; (*Memory: End production - Water Push Acknoledge*)
		BOOL44 : BOOL; (*Memory:*)
		BOOL45 : BOOL; (*Memory:*)
		CoStarted : BOOL; (*Memory: ChangeOver - End containers, Change start*)
		CoRecipeDownloaded : BOOL; (*Memory: ChangeOver - Recipe downloaded*)
		CoRinseRequested : BOOL; (*Memory: ChangeOver - Rinse requested*)
		CoProductionEnded : BOOL; (*Memory: ChangeOver - Production Ended*)
		CoNextProductReady : BOOL; (*Memory: ChangeOver - Next product ready*)
		BOOL51 : BOOL; (*Memory:*)
		BOOL52 : BOOL; (*Memory:*)
		BOOL53 : BOOL; (*Memory:*)
		MachineReadyToLoad : BOOL; (*Memory: Filler Machine Ready to Load Containers*)
		ContainersRelease : BOOL; (*Memory: Filler Containers Release*)
		FillerStopped : BOOL; (*Memory: Filler Mechanical Stopped*)
		FillerEmpty : BOOL; (*Memory: Filler Machine Empty*)
		FillerRunning : BOOL; (*Memory: Filler Machine Running*)
		FilCopEnd : BOOL; (*Memory: Filler on CIP COP Auto Cycle not Configured or Ended*)
		DmcInserted : BOOL; (*Memory: Filler on CIP Dummy Containers Inserted*)
		DmcExtracted : BOOL; (*Memory: Filler on CIP Dummy Containers Extracted*)
		DmcManualCfg : BOOL; (*Memory: Manual Dummy Containers Configured V1.7.2*)
		FixSpeed : BOOL; (*Fix Speed in Execution *)
		BOOL64 : BOOL; (*Memory:*)
		FoamerRunning : BOOL; (*Memory: Foamer Jet Running*)
		BOOL66 : BOOL; (*Memory:*)
		BOOL67 : BOOL; (*Memory:*)
		FilCopRunning : BOOL; (*Memory: COP cycle running*)
		ValveWashingRunning : BOOL; (*Memory: Valve Washing Running*)
		ContainersPrimingOk : BOOL; (*Memory: Priming in containers ok*)
		MachineEmpty : BOOL; (*Memory: Machine Empty (All Combi)*)
		SynchroDone : BOOL; (*Memory: Machine Syncronized*)
		BOOL73 : BOOL; (*Memory:*)
		BOOL74 : BOOL; (*Memory:*)
		BOOL75 : BOOL; (*Memory:*)
		BOOL76 : BOOL; (*Memory:*)
		BOOL77 : BOOL; (*Memory:*)
		BOOL78 : BOOL; (*Memory:*)
		BOOL79 : BOOL; (*Memory:*)
		FMC_SequPriming : BOOL; (*Memory: FMC Priming Sequence Running (Start-Up)*)
		FMC_SequFlushing : BOOL; (*Memory: FMC Flushing Sequence Running (Start-Up)*)
		FMC_SequPurge : BOOL; (*Memory: FMC Purge Sequence Running (Production)*)
		FMC_SequRinse1 : BOOL; (*Memory: FMC Rinse 1 Sequence Running (Rinse Chamber)*)
		FMC_SequRinse2 : BOOL; (*Memory: FMC Rinse 2 Sequence Running (Rinse Opening)*)
		FMC_SequDrain : BOOL; (*Memory: FMC Drain Sequence Running (Valves Drain)*)
		BOOL86 : BOOL; (*Memory: FMC Sequence*)
		BOOL87 : BOOL; (*Memory: FMC Sequence*)
		FMC_AirBlowOff : BOOL; (*Memory: FMC Valve air Blow OFF Request (1 = Air Unload Request)*)
		FMC_AirOff : BOOL; (*Memory: FMC Not Air Pressure on Electronic Valve (Pressure Switch)*)
		FMC_PurgeVolume : BOOL; (*Memory: FMC Purge Volume Running*)
		FMC_FVReadyToStartCIP : BOOL; (*Memory: FMC FV Ready To Start CIP*)
		FMC_NotReady : BOOL; (*Memory: FMC Not Ready For Execution V4.A.A.1.7.0*)
		BOOL93 : BOOL; (*Memory: FMC*)
		BOOL94 : BOOL; (*Memory: FMC*)
		FMC_FillingManualRunning : BOOL; (*Memory: FMC Filling Manual Running or Calibration Valve Running (RMO) V4.A.A.1.6.13*)
		FMC_ValveOff : BOOL; (*Memory: FMC Valves Sector OFF (Total Closed)*)
		FMC_FaultFlow : BOOL; (*Memory: FMC Valves Flow Control Fault*)
		FMC_VortexCalibration : BOOL; (*Memory: FMC Vortex Calibration Active*)
		FMC_FillingTest : BOOL; (*Memory: FMC Filling Test Selected*)
		BOOL100 : BOOL; (*Memory:*)
		BOOL101 : BOOL; (*Memory:*)
		BOOL102 : BOOL; (*Memory:*)
		BOOL103 : BOOL; (*Memory:*)
		BOOL104 : BOOL;
		BOOL105 : BOOL;
		BOOL106 : BOOL;
		BOOL107 : BOOL;
		BOOL108 : BOOL;
		BOOL109 : BOOL;
		RecipeDownloadStarted : BOOL; (*Download Recipe Started*)
		RecipeOnlineEditAct : BOOL; (*Online Edit Recipe Active*)
		RecipeDownloadEnded : BOOL; (*Download Recipe Ended*)
		HMI_APCOCommand : BOOL; (*APCO Enable SS2P Command //v1.65*)
		HMI_PrcChRcp_Command : BOOL; (*APCO Change Recipe from Proces SS2P Command*)
		BOOL115 : BOOL;
		BOOL116 : BOOL;
		BOOL117 : BOOL;
		BOOL118 : BOOL;
		BOOL119 : BOOL;
		HMI_SelectorEnable : BOOL; (*HMI: Manual Selector Enable*)
		HMI_DeviceEnable : BOOL; (*HMI: Manual Device Enable*)
		HMI_ProcessStartOn : BOOL; (*HMI: Filler Process Start ON*)
		HMI_ParInitialization : BOOL; (*HMI: Parameter Initialization*)
		BOOL124 : BOOL;
		BOOL125 : BOOL;
		BOOL126 : BOOL;
		BOOL127 : BOOL;
		BOOL128 : BOOL;
		BOOL129 : BOOL;
		BOOL130 : BOOL;
		BOOL131 : BOOL;
		TrayInPosition : BOOL; (*Procedure of Priming in Tray In Position v1.4*)
		BOOL133 : BOOL;
		CipStartEnable : BOOL; (*Enable to start Cip*)
		CipStopRequest : BOOL; (*Request of Cip cycle stop*)
		SMR_CipRunning : BOOL; (*Seamer Function Mode -CIP Running*)
		SMR_CopRunning : BOOL; (*Seamer Funcion-Foaming Running*)
		BOOL138 : BOOL;
		SmplUV1InPosition : BOOL; (*Sample Sequencer: UVLamp1 In Position*)
		SmplUV2InPosition : BOOL; (*Sample Sequencer: UVLamp2 In Position*)
		SmplCOPInPosition : BOOL; (*Sample Sequencer: COP Sample In Position*)
		BOOL142 : BOOL;
		BOOL143 : BOOL;
		BOOL144 : BOOL;
		BOOL145 : BOOL;
		ValveWashingCfg : BOOL; (*Valve for Valve Washing Configured v1.6*)
		TrayWashing : BOOL; (*Tray Washing Valve Opened v1.6*)
		BOOL148 : BOOL;
		BOOL149 : BOOL;
		CopGatesInstalled : BOOL; (*Cop Gates Installed V4.A.A.1.7.0*)
		DoorsOpenExceptGloves : BOOL; (*Doors Open Exluded Doors with Gloves V4.A.A.1.7.0*)
		COP_CipModeActive : BOOL; (*Remote Exchange to Process*)
		COP_CipRequest : BOOL; (*Remote Exchange to Process*)
		COP_CipSolutionFlow : BOOL; (*Remote Exchange to Process*)
		BOOL155 : BOOL;
		BOOL156 : BOOL;
		BOOL157 : BOOL;
		GatewayCommMask : BOOL; (*Gateway A+B Comm Mask V4.A.A.1.7.0*)
		BOOL159 : BOOL;
		FMC_StpStartSector : USINT; (*FMC Step Delay Start Valve Sector*)
		FMC_SectorCfg : USINT; (*FMC Sector Configuration*)
		FMC_NumValveExec : USINT; (*FMC Number of Valve Executing Valve Output Config*)
		LotoStep : USINT; (*Actual Step of de-energization sequence*)
		PAC_FillerValveNr : INT; (*PAC: Number of Filling Valves*)
		FillerSteps : INT; (*Steps Counter*)
		ContainersInMachine : INT; (*Number of Containers Inside Machine (Filler+Labeler+Blower) Counter*)
		PTF204 : INT; (*Ring Tank Pressure PV*)
		PTF203 : INT; (*Ring Tank Differential Inlet pressure Probe Read PV *)
		TTF201 : INT; (*Ring Tank Temperature Process Probe Read PV *)
		DmcNr : INT; (*Number of Dummy Container*)
		PTB299 : INT; (*Foamer Pressure*)
		TTB201 : INT; (*Jetter Temperature v1.4*)
		AlarmNr : INT; (*Number of First Alarm (for Alarm Handler)*)
		FMC_NecessaryLiters : INT; (*FMC Litres necessary to fill the carousell*)
		INT11 : INT;
		INT12 : INT;
		INT13 : INT;
		CoCheckPointsActive : INT; (*ChangeOver - Check Points Active*)
		CoType : INT; (*ChangeOver - Type of Change*)
		CoNextRecipe : INT; (*ChangeOver - Next Recipe Selected*)
		ChangeOverWorkRecipe : INT; (*ChangeOver - Work Recipe*)
		INT18 : INT;
		INT19 : INT;
		INT20 : INT;
		INT21 : INT;
		INT22 : INT;
		INT23 : INT;
		INT24 : INT;
		INT25 : INT;
		INT26 : INT;
		FBT_FVTargetPosition : INT; (*Filling valve opening target position in calibration procedure (RMO) //V4.A.A.1.6.11*)
		FBT_PressureIndex : INT; (*Pressure Index used in calibration procedure (RMO) //V4.A.A.1.6.11*)
		TankPressureSetra : INT; (*Tank Pressure (Setra sensor) mBar (RMO) //V4.A.A.1.6.11*)
		LotoDevices : INT; (*Status of device request from procedure*)
		LTF200 : INT; (*Probe Tank Level Probe Read PV (RMO) //V4.A.A.1.6.11*)
		PAR_ContainerSize : REAL; (*PAR: Containers Size (ml)*)
		FillerSpeed : REAL; (*Filler Speed Actual Value Read Containers/hour Format 0 -:- Max Speed*)
		FillerProductFlowrate : REAL; (*FMC Actual Product Flowrate (l/min)*)
		PAR_SizeSpeed : REAL; (*PAR: Max size Speed (c/h)*)
		REAL4 : REAL;
		REAL5 : REAL;
		REAL6 : REAL;
		REAL7 : REAL;
		ContainersProduced : REAL; (*Totalizer Containers Produced (Not Resettable)*)
		BatchProduced : REAL; (*Batch Totalizer*)
	END_STRUCT;
	SidelPrcFlr_Type : 	STRUCT 
		Alive : BOOL; (*Alive Bit*)
		BOOL1 : BOOL; (*Command:*)
		BOOL2 : BOOL; (*Command:*)
		BOOL3 : BOOL; (*Command:*)
		BOOL4 : BOOL; (*Command:*)
		BOOL5 : BOOL; (*Command:*)
		BOOL6 : BOOL; (*Command:*)
		GeneralAirOut : BOOL; (*Instrument State: Filler Outlet General Air ON (Valve "203EVG")*)
		GeneralAirIn : BOOL; (*Instrument State: Filler General Air ON (Pressure Switch "201PSG")*)
		WaterPressureOk : BOOL; (*Instrument State: Filler Water Inlet (Pressure Switch "PSE201")*)
		BOOL10 : BOOL; (*Instrument State:*)
		BOOL11 : BOOL; (*Instrument State:*)
		BOOL12 : BOOL; (*Instrument State:*)
		BOOL13 : BOOL; (*Instrument State:*)
		BOOL14 : BOOL; (*Instrument State:*)
		BOOL15 : BOOL; (*Instrument State:*)
		LubWaterFlowOk : BOOL; (*Instrument State: Lubrication Water Flowswitch ("FSE202")*)
		LubSoapFlowOk : BOOL; (*Instrument State: Lubrication Soap Flowswitch ("FSE203")*)
		BOOL18 : BOOL; (*Instrument State:*)
		BOOL19 : BOOL; (*Instrument State:*)
		BOOL20 : BOOL; (*Instrument State:*)
		BOOL21 : BOOL; (*Instrument State:*)
		BOOL22 : BOOL; (*Instrument State:*)
		BOOL23 : BOOL; (*Instrument State:*)
		AVF266Op : BOOL; (*Device State: Filler Valve AVF266 Opened*)
		AVF266Cl : BOOL; (*Device State: Filler Valve AVF266 Closed*)
		AVS219Op : BOOL; (*Device State: Filler Valve AVS219 Opened*)
		AVS219Cl : BOOL; (*Device State: Filler Valve AVS219 Closed*)
		AVE233Op : BOOL; (*Device State: Filler Valve AVE233 Opened*)
		AVE233Cl : BOOL; (*Device State: Filler Valve AVE233 Closed*)
		AVE234Op : BOOL; (*Device State: Filler Valve AVE234 Opened*)
		AVE234Cl : BOOL; (*Device State: Filler Valve AVE234 Closed*)
		AVE235Op : BOOL; (*Device State: Filler Valve AVE235 Opened*)
		AVE235Cl : BOOL; (*Device State: Filler Valve AVE235 Closed*)
		AVE238Op : BOOL; (*Device State: Filler Valve AVE238 Opened*)
		AVE238Cl : BOOL; (*Device State: Filler Valve AVE238 Closed*)
		BOOL36 : BOOL; (*Device State:*)
		BOOL37 : BOOL; (*Device State:*)
		BOOL38 : BOOL; (*Device State:*)
		BOOL39 : BOOL; (*Device State:*)
		TankAlarm : BOOL; (*Memory: Buffer tank on Alarm, Filler Machine Stop*)
		TankWarning : BOOL; (*Memory: Buffer Tank on Warning, Filler Containers Stop*)
		WaterPush : BOOL; (*Memory: Water Push on End Production*)
		ModeStartEnable : BOOL; (*Memory: Start Production Mode from Blower Push Button Enable*)
		VortexCalibrationOk : BOOL; (*Memory: Vortex Calibration condition OK*)
		CoStartEnable : BOOL; (*Memory: ChangeOver - Change Start SS Enable*)
		CoWaitRecipe : BOOL; (*Memory: ChangeOver - Drain ended, Wait for new recipe*)
		CoChangeDone : BOOL; (*Memory: ChangeOver - Product change done*)
		AVF201Cmd : BOOL; (*Sequencer Configuration: Rotating Tank Air Blow-Off 1*)
		AVF202Cmd : BOOL; (*Sequencer Configuration: Rotating Tank Air Blow-Off 2*)
		AVF203Cmd : BOOL; (*Sequencer Configuration: Rotating Tank Air Blow-Off 3*)
		AVF204Cmd : BOOL; (*Sequencer Configuration: Rotating Tank Air Blow-Off 4*)
		AVF205Cmd : BOOL; (*Sequencer Configuration: Rotating Tank Air Blow-Off Start-Up*)
		AVF207Cmd : BOOL; (*Sequencer Configuration: Rotating Tank Air Blow-Off Start-Up*)
		AVF208Cmd : BOOL; (*Sequencer Configuration: Rotating Tank Air Blow-Off Start-Up*)
		AVF254Cmd : BOOL; (*Sequencer Configuration: Rotating Tank Gas Inlet By-Pass*)
		AVG260Cmd : BOOL; (*Sequencer Configuration: Rotating Tank Air Injection*)
		BOOL57 : BOOL; (*Sequencer Configuration:*)
		BOOL58 : BOOL; (*Sequencer Configuration:*)
		BOOL59 : BOOL; (*Sequencer Configuration:*)
		AVB206Cmd : BOOL; (*Sequencer Configuration: Foamer Jet On Command*)
		AVB207Cmd : BOOL; (*Sequencer Configuration: Foamer Jet Discharge On Command v1.4*)
		ReduceSpeedRequest : BOOL; (*Sequencer Configuration: Reduce Speed Request*)
		FixSpeedRequest : BOOL; (*Sequencer Configuration: Fix Speed Request*)
		ContainerStop : BOOL; (*Sequencer Configuration: Container Stop Control (1 = Containers Stop)*)
		MachineStop : BOOL; (*Sequencer Configuration: Machine Stop Control (1 = Machine Stop)*)
		MachineStart : BOOL; (*Sequencer Configuration: Machine Start Control (1 = Machine Start)*)
		HighSpeed : BOOL; (*Sequencer Configuration: Machine on High Speed*)
		StepCount : BOOL; (*Sequencer Configuration: Step Counting Request*)
		MachineWashing : BOOL; (*Sequencer Configuration: Machine Washing Valve Command*)
		ValveEnable : BOOL; (*Sequencer Configuration: Filling Valve Open Enable*)
		ValveOpening : BOOL; (*Sequencer Configuration: Filling Valve Open command*)
		BOOL72 : BOOL; (*Sequencer Configuration:*)
		CopCycle : BOOL; (*Sequencer Configuration: COP Cycle Check Requested*)
		DummyContainersIns : BOOL; (*Sequencer Configuration: Dummy Containers INSERTION*)
		DummyContainersExt : BOOL; (*Sequencer Configuration: Dummy Containers EXTRACTION*)
		Calibration : BOOL; (*Sequencer Configuration: Mode Calibration (RMO) (V4.A.A.1.6.12h)*)
		BOOL77 : BOOL; (*Sequencer Configuration:*)
		BOOL78 : BOOL; (*Sequencer Configuration:*)
		BOOL79 : BOOL; (*Sequencer Configuration:*)
		FMC_SequPriming : BOOL; (*Sequencer Configuration: FMC Priming Sequence Request (Start-Up)*)
		FMC_SequFlushing : BOOL; (*Sequencer Configuration: FMC Flushing Sequence Request (Start-Up)*)
		FMC_SequPurge : BOOL; (*Sequencer Configuration: FMC Purge Sequence Request (Production)*)
		FMC_SequRinse1 : BOOL; (*Sequencer Configuration: FMC Rinse 1 Sequence Request (Rinse Chamber)*)
		FMC_SequRinse2 : BOOL; (*Sequencer Configuration: FMC Rinse 2 Sequence Request (Rinse Opening)*)
		FMC_SequDrain : BOOL; (*Sequencer Configuration: FMC Drain Sequence Request (Valves Drain)*)
		BOOL86 : BOOL; (*Sequencer Configuration: FMC Sequence*)
		BOOL87 : BOOL; (*Sequencer Configuration: FMC Sequence*)
		FMC_Valve1 : BOOL; (*Sequencer Configuration: FMC Valve1*)
		FMC_Valve2 : BOOL; (*Sequencer Configuration: FMC Valve2*)
		FMC_Valve3 : BOOL; (*Sequencer Configuration: FMC Valve3*)
		FMC_Valve4 : BOOL; (*Sequencer Configuration: FMC Valve4*)
		FMC_Valve5 : BOOL; (*Sequencer Configuration: FMC Valve5*)
		FMC_Valve6 : BOOL; (*Sequencer Configuration: FMC Valve6*)
		FMC_Valve7 : BOOL; (*Sequencer Configuration: FMC Valve7*)
		FMC_Valve8 : BOOL; (*Sequencer Configuration: FMC Valve8*)
		FMC_Sector : BOOL; (*Sequencer Configuration: FMC Sector Control Enable*)
		FMC_Flow : BOOL; (*Sequencer Configuration: FMC Valves Flow Control Enable*)
		BOOL98 : BOOL; (*Sequencer Configuration:*)
		FMC_CalibInhibition : BOOL; (*Sequencer Configuration: FMC Calibration Inhibition  (RMO)(V4.A.A.1.6.12h)*)
		FBT_ReadyForCalibration : BOOL; (*Sequencer Configuration: Filler ready for FBT calibration procedure //V4.A.A.1.6.11*)
		CipDrain : BOOL; (*Sequencer Configuration: Mode Cip - Drain*)
		CipRecovery : BOOL; (*Sequencer Configuration: Mode Cip - Recovery*)
		StartUp : BOOL; (*Sequencer Configuration: Mode Production - StartUp*)
		Prod : BOOL; (*Sequencer Configuration: Mode Production*)
		Cip : BOOL; (*Sequencer Configuration: Mode Cip*)
		Drain : BOOL; (*Sequencer Configuration: Mode Drain*)
		Rinse : BOOL; (*Sequencer Configuration: Mode Rinse*)
		DeEnergization : BOOL; (*Sequencer Configuration: Mode DeEnergization*)
		EndProduction : BOOL; (*Sequencer Configuration: Mode Production - End Production*)
		RecipeDownloadEn : BOOL; (*Download Recipe Enable*)
		RecipeOnlineEditEn : BOOL; (*Online Edit Recipe Enable*)
		RecipeDownloadRecived : BOOL; (*Download Recipe Recived*)
		HMI_APCOVisibility : BOOL; (*APCO Enable SS2P Visibility //v1.65*)
		HMI_APCOEnable : BOOL; (*APCO Enable SS2P Enable //v1.65*)
		HMI_APCOState : BOOL; (*APCO Enable SS2P State //v1.65*)
		APCO_CoRequest : BOOL; (*APCO Change Over Request from Process //v1.65*)
		HMI_PrcChRcp_Visibility : BOOL; (*APCO Change Recipe from Process SS2P Visibility //v1.65*)
		HMI_PrcChRcp_Enable : BOOL; (*APCO Change Recipe from Proces SS2P Enable //v1.65*)
		HMI_PrcChRcp_State : BOOL; (*APCO Change Recipe from Proces SS2P State //v1.65*)
		HMI_ProcessStartEnable : BOOL; (*HMI: Filler Process Start Enable*)
		HMI_ProcessStartLampOn : BOOL; (*HMI: Filler Process Start Lamp ON*)
		HMI_ProcessStartBlink : BOOL; (*HMI: Filler Process Start Blink*)
		BOOL123 : BOOL;
		BOOL124 : BOOL;
		BOOL125 : BOOL;
		BOOL126 : BOOL;
		BOOL127 : BOOL;
		CriticalAcknoledgeReq : BOOL; (*Critical Acknoledge Request*)
		AlarmAcknoledgeReq : BOOL; (*Alarm Acknoledge Request*)
		BOOL130 : BOOL;
		PrimingInTrayCfg : BOOL; (*Procedure of Priming in Tray Configured v1.4*)
		PrimingInTray : BOOL; (*Procedure of Priming in Tray Active v1.4*)
		PrimingInContainerCfg : BOOL; (*Procedure of Priming in Container Configured v1.4*)
		PrimingInContainer : BOOL; (*Procedure of Priming in Container Active*)
		ArticlesRejectionRequest : BOOL; (*Preform and Bottles Ejection Request to Blower*)
		SmplSeqHMIPBActv : BOOL; (*Sample Sequencer: HMI Sampling PB Active*)
		SmplSeqUV1 : BOOL; (*Sample Sequencer: UVLamp1 Command*)
		SmplSeqUV2 : BOOL; (*Sample Sequencer: UVLamp2 Command*)
		SmplSeqCOP : BOOL; (*Sample Sequencer: COP Sample Command*)
		AVS219_CIP_Open : BOOL; (*AVS219 CIP Cleaning Open For Bottle Cooling*)
		COPWIP_Request : BOOL; (*COP Washing In Production Request*)
		AirBlowOffEn : BOOL; (*Ring Tank Drain - Filling Valves Air Blow Off Selector Enable*)
		AirBlowOffCmd : BOOL; (*Ring Tank Drain - Filling Valves Air Blow Off Command*)
		AVF221Cmd : BOOL; (*AVF221 Command (RMO) //V4.A.A.1.6.11*)
		AVF244Cmd : BOOL; (*AVF244 Command (RMO) //V4.A.A.1.6.11*)
		TrayWashingCfg : BOOL; (*Procedure of Tray Washing Configured v1.5*)
		TrayWashing : BOOL; (*Procedure of Tray Washing Active v1.5*)
		AVF267Cmd : BOOL; (*AVF267 Command (RMO)(V4.A.A.1.6.12h)*)
		AVF268Cmd : BOOL; (*AVF268 Command (RMO)(V4.A.A.1.6.12h)*)
		TankSafetyValveCmd : BOOL; (*Tank Safety Valve Command (RMO)(V4.A.A.1.6.12h)*)
		CopInProductionActive : BOOL; (*Step of Cop In Production in Execution V4.A.A.1.7.0*)
		COP_CipAvailable : BOOL; (*Remote Exchange to Filler*)
		COP_CipProductSending : BOOL; (*Remote Exchange to Filler*)
		COP_CipCompleted : BOOL; (*Remote Exchange to Filler*)
		BOOL155 : BOOL;
		InletProdPressONSetPoint : BOOL; (*Inlet Product Pressure on Set Point (PTF200) V4.A.A.1.7.0*)
		SkidToGatewayAlive : BOOL; (*Alive Bit from Skid to Gateway A+B V4.A.A.1.7.0*)
		GatewayToSkidAlive : BOOL; (*Alive Bit from Gateway A+B to Skid V4.A.A.1.7.0*)
		Batch_Reset : BOOL; (*Batch Totalizer Reset Cmd*)
		BYTE0 : USINT;
		BYTE1 : USINT;
		BYTE2 : USINT;
		LotoStep : USINT; (*Actual Step of de-energization sequence*)
		StepNr : INT; (*Process Step Number*)
		FMC_SectorNr : INT; (*FMC Sector Valve Number*)
		FMC_SectorStepsDelay : INT; (*FMC Steps delay start valve sector*)
		INT3 : INT;
		INT4 : INT;
		INT5 : INT;
		AlarmCategory : INT; (*OMAC Alarm Category*)
		AlarmCode : INT; (*OMAC Alarm Code*)
		AlarmIndex : INT; (*OMAC Alarm Index*)
		AlarmNr : INT; (*Number of First Alarm (for Alarm Handler)*)
		AlarmOp1 : INT; (*Alarm Operation Interger1 (Lower Part)*)
		AlarmOp2 : INT; (*Alarm Operation Interger2 (Higher Part)*)
		ExtAlarmNr : INT; (*Number of First External Alarm (for Alarm Handler)*)
		INT13 : INT;
		INT14 : INT;
		INT15 : INT;
		INT16 : INT;
		INT17 : INT;
		INT18 : INT;
		CoTypeOfChangeCFG : INT; (*Change Over - Type of change Visibility*)
		CoCheckPointsCFG : INT; (*Change Over - Check Points Visibility*)
		INT21 : INT;
		INT22 : INT;
		INT23 : INT;
		INT24 : INT;
		FTE201 : INT; (*Water Inlet Flow Meter v1.4*)
		INT26 : INT;
		INT27 : INT;
		FBT_RcpMaxFlowrate : INT; (*Maximum flowrate following pressure in format recipe (RMO) V4.A.A.1.7.1*)
		FBT_SpInCalibration : INT; (*Pressure SP for calibration step in calibration procedure (RMO) //V4.A.A.1.6.11*)
		TotalizersPulses : INT; (*Instrument Pulses for HMI Totalizer*)
		INT31 : INT;
		LTF200PV : REAL; (*Buffer Tank Level*)
		LTF200LitAvailable : REAL; (*Buffer Tank Litres Available*)
		OffsetForProdAvail : REAL; (*Offset of bottom part of Storage Tank (For Available Product)*)
		End_ProductionContainers : REAL; (*Containers Needed for End Production V4.A.A.1.7.1*)
		FixSpeedSP : REAL; (*Fix Speed SetPoint Request*)
		PTF204 : REAL; (*Ring Tank Pressure Scaled*)
		TTF201 : REAL; (*Ring Tank Temperature Process Probe Scaled*)
		PTF208_ActSp : REAL; (*Storage Tank Actual SetPoint*)
		PPF201_PidPV : REAL; (*PID Actual PV of product pump in production*)
		REAL9 : REAL;
	END_STRUCT;
END_TYPE

(*CAPFEEDER COMMUNICATION*)

TYPE
	FlrCfd_TypeOld : 	STRUCT 
		Alive : BOOL;
		RunEnable : BOOL; (*Remote enable to run auxiliary motors (air conveyors…)*)
		CleanOutRequest : BOOL; (*Remote clean out mode request*)
		FaultReset : BOOL; (*Remote fault reset*)
		CapsCounterEnable : BOOL; (*Remote enable upside down cap reject counter (option)*)
		CapsCounterReset : BOOL; (*Remote upside down cap reject counter reset (option)*)
		EnableToStart : BOOL; (*Remote enable elevator to start*)
		SelSideA : BOOL; (*Cap starvation side "A" (left)*)
		SelSideB : BOOL; (*Cap starvation side "B" (right) (option)*)
	END_STRUCT;
	CfdFlr_TypeOld : 	STRUCT 
		Alive : BOOL;
		RunProduction : BOOL; (*Cap/Crown feeder ready and running production*)
		CleanOut : BOOL; (*Cap/Crown feeder in clean out mode*)
		TripVibratorOctabin1 : BOOL; (*Thermal trip failure vibrator octabin dumper 1 (option)*)
		TripVibratorOctabin2 : BOOL; (*Thermal trip failure vibrator octabin dumper 2 (option)*)
		TripElevator : BOOL; (*Thermal trip failure elevator belt motor*)
		EmergencyStop : BOOL; (*Emergency stop relay activated*)
		ReadyToRun : BOOL; (*Ready to run (no alarm)*)
		AirSupplyFault : BOOL; (*Main air supply fault*)
		RejectionUnitFault : BOOL; (*Upside down rejection unit jam fault (option)*)
		OutfeedJam : BOOL; (*Cap Feeder exit jam fault*)
		DischargeFullEvent : BOOL; (*Discharge Full*)
		Octabin1LowLevel : BOOL; (*Octabin dumper 1 low level (option)*)
		Octabin2LowLevel : BOOL; (*Octabin dumper 2 low level (option)*)
		HopperLowLevelEvent : BOOL; (*Hopper low level*)
		HopperJamFault : BOOL; (*Hopper jam fault (option)*)
		ElevatorRunning : BOOL; (*Belt elevator motor running*)
		DischargeFull : BOOL; (*Discharge full sensor status*)
		HopperLowLevel : BOOL; (*Hopper low level sensor status*)
		PressureOk : BOOL; (*Main air supply pressure switch feedback*)
		MainEVOpen : BOOL; (*Main nozzle blowing valve status*)
		JamEVOpen : BOOL; (*Jam nozzle blowing valve status*)
		CleanOutEVOpen : BOOL; (*Clean out nozzle blowing valve status*)
		OctabinD1VibratorOn : BOOL; (*Octabin dumper 1 vibrator status  (option)*)
		OctabinD2VibratorOn : BOOL; (*Octabin dumper 2 vibrator status  (option)*)
		OctabinD1LowLevel : BOOL; (*Octabin dumper 1 low level sensor status (option)*)
		OctabinD2LowLevel : BOOL; (*Octabin dumper 2 low level sensor status (option)*)
		BeltSelection : BOOL; (*Elevator belt side "B" selected if dual machine (option)*)
		CapInspectorBeltRunning : BOOL; (*Cap inspector belt running*)
		CapInspectorCameraReady : BOOL; (*Cap inspector camera ready*)
		ElevatorAReady : BOOL; (*Elevator "A" ready (left) *)
		ElevatorBReady : BOOL; (*Elevator "B" ready (right) (option)*)
		Conveyor1Running : BOOL; (*Air conveyor motor 1 running (option)*)
		Conveyor1Fault : BOOL; (*Air conveyor motor 1 failure (option)*)
		Conveyor2Running : BOOL; (*Air conveyor motor 2 running (option)*)
		Conveyor2Fault : BOOL; (*Air conveyor motor 2 failure (option)*)
		Conveyor3Running : BOOL; (*Air conveyor motor 3 running (option)*)
		Conveyor3Fault : BOOL; (*Air conveyor motor 3 failure (option)*)
		Conveyor4Running : BOOL; (*Air conveyor motor 4 running (option)*)
		Conveyor4Fault : BOOL; (*Air conveyor motor 4 failure (option)*)
		Conveyor5Running : BOOL; (*Air conveyor motor 5 running (option)*)
		Conveyor5Fault : BOOL; (*Air conveyor motor 5 failure (option)*)
		Dedustin1Running : BOOL; (*Dedusting unit 1 vacuum pump running (option)*)
		Dedustin1Fault : BOOL; (*Dedusting unit 1 vacuum pump failure (option)*)
		Ionizer1Blowing : BOOL; (*Ioniser unit 1 and air blow nozzle valve open (option)*)
		Ionizer2Blowing : BOOL; (*Ioniser unit 2 and air blow nozzle valve open (option)*)
		Ionizer1Fault : BOOL; (*Ioniser unit 1 fault (option)*)
		Ionizer2Fault : BOOL; (*Ioniser unit 2 fault (option)*)
		RejectCounter : INT; (*Upside down cap reject counter (option)*)
	END_STRUCT;
	FlrCfd_Type : 	STRUCT 
		Alive : BOOL;
		AuxiliaryRunEnable : BOOL; (*Remote enable to run auxiliary motors (air conveyors…)*)
		EnableToStart : BOOL; (*Remote enable Capfeeder to start*)
		FaultReset : BOOL;
		CleanOutRequest : BOOL;
		RunEnable : BOOL;
		ResetEmergency : BOOL; (*Remote filler emergency stop reset*)
		CapsCounterEnable : BOOL; (*Remote enable upside down cap reject counter (option)*)
		CapsCounterReset : BOOL; (*Remote upside down cap reject counter reset (option)*)
		StarvationAtInfeed : BOOL; (*Cap starvation at capper infeed*)
		Sel_SideA : BOOL;
		Sel_SideB : BOOL;
		StartRequest : BOOL; (*For Zalkin*)
		StopRequest : BOOL; (*For Zalkin*)
		EmptyingRequest : BOOL; (*For ZALKIN*)
		EmptyingDone : BOOL; (*For ZALKIN*)
		Requested_format : INT; (*For Zalkin*)
	END_STRUCT;
	CfdFlr_Type : 	STRUCT 
		Alive : BOOL;
		ReadyToRun : BOOL; (*Cap/Crown feeder ready for Remote Start*)
		RunProduction : BOOL; (*Cap/Crown feeder ready and running production*)
		CleanOut : BOOL; (*Cap/Crown feeder in clean out mode*)
		Fault : BOOL; (*Cap/Crown feeder fault*)
		ProcessFault : BOOL; (*Cap/Crown feeder fault(Automatic Restart) For Zalkin*)
		EmergencyStop : BOOL; (*Emergency stop relay activated*)
		FaultElevator : BOOL; (*Elevator belt motor fault*)
		FaultPusher : BOOL; (*Cap pusher motor fault*)
		FaultStarwheel : BOOL; (*Starwheel motor fault*)
		JamStarwheel : BOOL; (*Cap/crown feeder starwheel jam fault*)
		JamOutfeed : BOOL; (*Cap/crown feeder exit jam fault*)
		DischargeFullEvent : BOOL; (*Discharge Full*)
		HopperLowLevelEvent : BOOL; (*Hopper low level*)
		CapsAtFiller : BOOL; (*Presence of caps infeed filler (option if cap buffer in conveyors)*)
		HopperJamFault : BOOL; (*Hopper jam fault (option)*)
		PressureOk : BOOL; (*Main air supply pressure switch feedback (option)*)
		AirSupplyFault : BOOL; (*Main air supply fault (Option)*)
		MainEvOpen : BOOL; (*Main nozzle blowing valve status (option)*)
		JamEVOpen : BOOL; (*Jam nozzle blowing valve status (option)*)
		CleanOutEvOpen : BOOL; (*Clean out nozzle blowing valve status (option)*)
		TripVibratorOctabin1 : BOOL; (*Thermal trip failure vibrator octabin dumper 1 (option)*)
		TripVibratorOctabin2 : BOOL; (*Thermal trip failure vibrator octabin dumper 2 (option)*)
		Octabin1VibratorOn : BOOL; (*Octabin dumper 1 vibrator status  (option)*)
		Octabin2VibratorOn : BOOL; (*Octabin dumper 2 vibrator status  (option)*)
		Octabin1LowLevel : BOOL; (*Octabin dumper 1 low level (option)*)
		Octabin2LowLevel : BOOL; (*Octabin dumper 2 low level (option)*)
		CapInspectorRunning : BOOL; (*Cap inspector (option)*)
		CapInspectorCameraReady : BOOL; (*Cap inspector camera ready (option)*)
		Conveyor1Running : BOOL; (*Air conveyor motor 1 running (option)*)
		Conveyor1Fault : BOOL; (*Air conveyor motor 1 failure (option)*)
		Conveyor2Running : BOOL; (*Air conveyor motor 2 running (option)*)
		Conveyor2Fault : BOOL; (*Air conveyor motor 2 failure (option)*)
		Conveyor3Running : BOOL; (*Air conveyor motor 3 running (option)*)
		Conveyor3Fault : BOOL; (*Air conveyor motor 3 failure (option)*)
		Conveyor4Running : BOOL; (*Air conveyor motor 4 running (option)*)
		Conveyor4Fault : BOOL; (*Air conveyor motor 4 failure (option)*)
		Conveyor5Running : BOOL; (*Air conveyor motor 5 running (option)*)
		Conveyor5Fault : BOOL; (*Air conveyor motor 5 failure (option)*)
		Dedustin1Running : BOOL; (*Dedusting unit 1 vacuum pump running (option)*)
		Dedustin1Fault : BOOL; (*Dedusting unit 1 vacuum pump failure (option)*)
		Ionizer1Running : BOOL; (*Ioniser unit 1 and air blow nozzle valve open (option)*)
		Ionizer2Blowing : BOOL;
		Ionizer1Blowing : BOOL;
		ElevatorBReady : BOOL;
		ElevatorAReady : BOOL;
		PrescoAlarm : BOOL;
		BeltSelection : BOOL;
		OctabinD2LowLevel : BOOL;
		OctabinD1LowLevel : BOOL;
		DischargeLowLevel : BOOL;
		DischargeFull : BOOL;
		ElevatorRunning : BOOL;
		RejectionUnitFault : BOOL;
		TripElevator : BOOL;
		Ionizer2Fault : BOOL; (*Ioniser unit 2 fault (option)*)
		Ionizer1Fault : BOOL; (*Ioniser unit 1 fault (option)*)
		HighLevelChute1 : BOOL; (*High Level Chuter 1 For ZALKIN*)
		HighLevelChute2 : BOOL; (*High Level Chuter 2 For ZALKIN*)
		HighLevelChute3 : BOOL; (*High Level Chuter 3 For ZALKIN*)
		MaxLevelBuffer1 : BOOL; (*Max Level Buffer 1 For ZALKIN*)
		MaxLevelBuffer2 : BOOL; (*Max Level Buffer 2 For ZALKIN*)
		EmptyingRunning : BOOL; (*For ZALKIN*)
		EmptyingDone : BOOL; (*For ZALKIN*)
		RejectCounter : INT; (*Upside down cap reject counter (option)*)
	END_STRUCT;
END_TYPE

(*CAPDIS COMMUNICATION V4.A.A.1.7.0*)

TYPE
	FlrCds_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		Alive : BOOL; (*Send 0.0:*)
		EmergencyOk : BOOL; (*Send 0.1: Safety circuit ok*)
		FaultReset : BOOL; (*Send 0.2:Reset request*)
		CapsRequest : BOOL; (*Send 0.3:Caps supply request*)
		CopSopEnable : BOOL; (*Send 0.4:Clean enable*)
		Send05 : BOOL; (*Send 0.5:*)
		Send06 : BOOL; (*Send 0.6:*)
		Send07 : BOOL; (*Send 0.7:*)
		B1A : BOOL; (*Send 1.0: Inlet chute caps Presence*)
		Send11 : BOOL; (*Send 1.1:*)
		Send12 : BOOL; (*Send 1.2:*)
		Send13 : BOOL; (*Send 1.3:*)
		Send14 : BOOL; (*Send 1.4:*)
		Send15 : BOOL; (*Send 1.5:*)
		Send16 : BOOL; (*Send 1.6:*)
		EmptyingRequest : BOOL; (*Send 1.7: Request to empty*)
		FillerMode : INT; (*REQ Operation Mode (0=OFF 1=SOP 2=SterilePROD 3 = NotSterileROD 4=COP)*)
		MachineSpeed : INT; (*Machine Speed in cps*)
		Send60 : INT; (*Send 6/7*)
		Send80 : INT; (*Send 8/9*)
		Send100 : BOOL; (*Send 10.0:*)
		Send101 : BOOL; (*Send 10.1:*)
		Send102 : BOOL; (*Send 10.2:*)
		VaporizationRequrest : BOOL; (*Send 10.3: Vaporization in auto*)
		Running : BOOL; (*Send 10.4: Running*)
		WarmRequest : BOOL; (*Send 10.5: Evaporator warming up*)
		Send106 : BOOL; (*Send 10.6:*)
		Send107 : BOOL; (*Send 10.7:*)
		Send110 : BOOL; (*Send 11.0:*)
		Send111 : BOOL; (*Send 11.1:*)
		Send112 : BOOL; (*Send 11.2:*)
		SOPSolutionRequest : BOOL; (*Send 11.3: SOP Water+PAA (300ppm) Request*)
		Send114 : BOOL; (*Send 11.4: *)
		Send115 : BOOL; (*Send 11.5:*)
		Send116 : BOOL; (*Send 11.6:*)
		Send117 : BOOL; (*Send 11.7:*)
		MachineSpeedR : DINT; (*Machine Speed in cps REAL*)
		Send160 : BOOL; (*Send 16.0:*)
		Send161 : BOOL; (*Send 16.1:*)
		Send162 : BOOL; (*Send 16.2:*)
		Send163 : BOOL; (*Send 16.3:*)
		PrimingRequest : BOOL; (*Send 16.4: Priming request*)
		BlowerEmpty : BOOL; (*Send 16.5: *)
		Send166 : BOOL; (*Send 16.6:*)
		EmptyingSkip : BOOL; (*Send 16.7: Emptying procedure stop*)
	END_STRUCT;
	CdsFlr_Type : 	STRUCT  (*V4.A.A.1.7.0*)
		Alive : BOOL; (*Receive 0.0 : Toggle bit 1Hz*)
		FingerRunBack : BOOL; (*Receive 0.1 : Finger moving to zero*)
		MachineClean : BOOL; (*Receive 0.2 : Cleaning completed*)
		ProductionAvailable : BOOL; (*Receive 0.3 : Ready to production*)
		SterilityOk : BOOL; (*Receive 0.4 : On sterility*)
		CapsAvailable : BOOL; (*Receive 0.5 : CapsAvailable In the Chute*)
		InletCapsSensor : BOOL; (*Receive 0.6 : Caps available at inlet*)
		CriticalFaultPresent : BOOL; (*Receive 0.7 : On critical alarm*)
		AlarmPresent : BOOL; (*Receive 1.0 : One alarm present*)
		InfoPresent : BOOL; (*Receive 1.1 : One info present*)
		MessagePresent : BOOL; (*Receive 1.2 : One message present*)
		PusherRunning : BOOL; (*Receive 1.3 : Finger is moving*)
		ProductionFreeze : BOOL; (*Receive 1.4 : Frozen*)
		Rec15 : BOOL; (*Receive 1.5 : *)
		Rec16 : BOOL; (*Receive 1.6 : *)
		Rec17 : BOOL; (*Receive 1.7 : *)
		CapDisMode : INT; (*0: Idle,1: SIP/SOP ,2:Steril Prod ,3: No Steril Prod,4: COP*)
		Rec40 : BOOL; (*Receive 4.0 : *)
		Rec41 : BOOL; (*Receive 4.1 : *)
		Rec42 : BOOL; (*Receive 4.2 : *)
		_002EOG_Filtered : BOOL; (*Receive 4.3 : Caps entering in Filler chute*)
		_004EOG_Filtered : BOOL; (*Receive 4.3 : Caps  slowing In the Chute*)
		Rec45 : BOOL; (*Receive 4.5 : Cleaning/Sterilization in progress*)
		Rec46 : BOOL; (*Receive 4.6 : *)
		Rec47 : BOOL; (*Receive 4.7 : *)
		Rec50 : BOOL; (*Receive 5.0 : *)
		Rec51 : BOOL; (*Receive 5.1 : *)
		Rec52 : BOOL; (*Receive 5.2 : *)
		_001EOG_Filtered : BOOL; (*Receive 5.3 : *)
		Rec54 : BOOL; (*Receive 5.4 : *)
		Rec55 : BOOL; (*Receive 5.5 : *)
		Rec56 : BOOL; (*Receive 5.6 : *)
		Rec57 : BOOL; (*Receive 5.7 : *)
		Rec60 : INT; (*Receive 6/7*)
		Rec80 : INT; (*Receive 8/9*)
		Rec100 : BOOL; (*Receive 10.0 : *)
		Rec101 : BOOL; (*Receive 10.1 : *)
		Rec102 : BOOL; (*Receive 10.2 : *)
		Rec103 : BOOL; (*Receive 10.3 : *)
		BottleBlockRequest : BOOL; (*Receive 10.4 : Bottle block only message*)
		EmptyingDone : BOOL; (*Receive 10.5 : Cycle completed*)
		Rec106 : BOOL; (*Receive 10.6 : *)
		Rec107 : BOOL; (*Receive 10.7 : *)
		SOPProductOk : BOOL; (*Receive 11.0 : SOP Product is in request parameters range*)
		SOPInletValveEnable : BOOL; (*Receive 11.1 : SOP inlet valve (AVE234) on Filler external cleaning circuit is enable to open*)
		Rec112 : BOOL; (*Receive 11.2 : *)
		Rec113 : BOOL; (*Receive 11.3 : *)
		Rec114 : BOOL; (*Receive 11.4 : *)
		Rec115 : BOOL; (*Receive 11.5 : *)
		Rec116 : BOOL; (*Receive 11.6 : *)
		Rec117 : BOOL; (*Receive 11.7 : *)
		MaxNumberOfCaps : INT; (*Receive 12 : Max Capacity*)
		ActualNumberOfCaps : INT; (*Receive 14 : Actual number of Caps*)
		Rec160 : BOOL; (*Receive 16.0 : *)
		BlowerDischargeRequest : BOOL; (*Receive 16.1 : Request of discharge*)
		Rec162 : BOOL; (*Receive 16.2 : *)
		PrimingInProgress : BOOL; (*Receive 16.3 : Priming In progress*)
		PrimingDone : BOOL; (*Receive 16.4 : Priming Done*)
		InletStarStopped : BOOL; (*Receive 16.5 : Inlet Tunnel Starwheel Stopped*)
		Rec166 : BOOL; (*Receive 16.6 : *)
		Rec167 : BOOL; (*Receive 16.6 : *)
		CapdisInManualMode : BOOL; (*Receive 16.7 : CapdisInManualMode*)
		Rec170 : BOOL; (*Receive 17.0 : *)
		Rec171 : BOOL; (*Receive 17.1 : *)
		Rec172 : BOOL; (*Receive 17.2 : *)
		Rec173 : BOOL; (*Receive 17.3 : *)
		CycleProgress : BOOL; (*Receive 17.4 : Cleaning/Sterilization in progress*)
		Rec175 : BOOL; (*Receive 17.5 : *)
		Rec176 : BOOL; (*Receive 17.6 : *)
		Rec177 : BOOL; (*Receive 17.7 : *)
		CapsInChute : DINT; (*Receive 26 : Estimated number of caps discharged*)
	END_STRUCT;
END_TYPE

(*INLET CONVEYOR COMMUNICATION V4.A.A.1.6.14*)

TYPE
	FlrCvi_Type : 	STRUCT 
		Alive : BOOL;
		MachineReady : BOOL; (*Signal = 0: stop without autorestart.

Signal = 1: run or ready to run.*)
		ContainersStopOpened : BOOL; (*Signal = 0: the infeed containers stop is closed, machine don't load containers.

Signal = 1: the infeed containers stop is opened, machine load containers.*)
		MachineEmpty : BOOL; (*Signal = 0: conatiners in filler/combi.

Signal = 1: no containers in filler/combi.*)
		OutfeedConveyorRunning : BOOL; (*signal =1: the outfeed bottles conveyor is running 

 signal =0: the outfeed bottles conveyor is not  running *)
		Last20Containers : BOOL; (*Signal = 0: the signal remains at 0 during 20 containers in exit machine.

Signal = 1: the signal remains at 1 during 20 containers in exit machine.*)
		FciSampling : BOOL; (*Signal recived from FCI: FCI Sampling*)
		MachineSpeed : INT; (*The readed value from the filler main frequency inverter or tachometer is multiplied by a coefficient to give container/min.

This value should be accurate and refresh at least every 100ms*)
		OutletConveyorSpeed : INT; (*[dm/min] This signal is used to synchronize the discharge conveyors (reject table and next conveyors following the first discharge conveyor).

This value should be accurate and refresh at least every 100ms*)
	END_STRUCT;
	CviFlr_Type : 	STRUCT 
		Alive : BOOL;
		LblSpeedReq : BOOL;
		MachineStartAndStop : BOOL;
		OutletConveyorReady : BOOL; (*Signal = 0: there is a trouble on the discharge conveyors (conveyors switch off or electrical fault). The filler has to stop as fast as possible.

Manual restart of the machine only (by the operator).

Signal = 1: discharge conveyors running or ready.*)
		OutletConveyorRunning : BOOL; (*Signal = 0: there is a trouble on the discharge conveyors (conveyors switch off or electrical fault). The filler has to stop as fast as possible.

Manual restart of the machine only (by the operator).

Signal = 1: discharge conveyors running or ready.*)
		OutletContainersLoadEnabled : BOOL; (*Signal = 0: the filler closes the container stop. Discharge conveyors are full with enough available space for the filler emptying.

Restart loading automatically when signal goes to 1.

Signal = 1: the filler can open the containers stop to load bottles.*)
		OutletConveyorLowSpeed : BOOL; (*Signal = 0: line at production speed.

Signal = 1: discharge conveyor is soon full, reduced speed before signal "containers stop dischage".*)
		RejectTableFull : BOOL; (*Signal = 0: the reject table is not full ( or reject table not existing).

Signal = 1: the reject table is full.

Put the information on the operator display of the filler (to know if you have to stop the filler, check the signal 10.1 and 10.2)*)
		FCIFault : BOOL; (*Signal = 0: the discharge container inspector is ready or container inspector not existing or cabled directly on the machine.

Signal = 1: the discharge container inspector is not ready.

Put the information on the operator display of the filler (to know if you have to stop the filler, check the signal 10.1 and 10.2)*)
		FCITooManyReject : BOOL; (*Signal = 0: the discharge container inspector is ready or container inspector not existing or cabled directly on the machine.

Signal = 1: the discharge container inspector reject too many containers.

Put the information on the operator display of the filler (to know if you have to stop the filler, check the signal 10.1 and 10.2)*)
		InfeedConveyorRunning : BOOL; (*Signal = 0: there is a trouble on the infeed conveyors (conveyors switch off or electrical fault). The filler has to stop as fast as possible.

Manual restart of the machine only (by the operator).

Signal = 1: infeed conveyors running or ready.*)
		InfeedContainersLoadEnabled : BOOL; (*Signal = 0: the filler closes the container stop. Infeed conveyors are full with enough available space for the filler emptying.

Restart loading automatically when signal goes to 1.

Signal = 1: the filler can open the containers stop to load bottles.*)
		InfeedConveyorLowSpeed : BOOL; (*Signal = 0: line at production speed.

Signal = 1: infeed conveyor is soon empty, reduced speed before signal "containers stop dischage".*)
		OverSpeedFromInfeed : BOOL; (*Signal = 0: normal accumulation, filler follow the line speed

Signal = 1: infeed conveyor is too much full. The machine run at the maximum speed*)
		LineSpeedReference : INT; (*It informs the filler of the line speed. This value is fixed by format. The machine could follow thi speed instead of filler operator settin on (HMI)*)
	END_STRUCT;
END_TYPE

(*OUTLET CONVEYOR COMMUNICATION*)

TYPE
	FlrCvo_Type : 	STRUCT 
		Alive : BOOL;
		MachineReady : BOOL; (*Signal = 0: stop without autorestart.
Signal = 1: run or ready to run.*)
		ContainersStopOpened : BOOL; (*Signal = 0: the infeed containers stop is closed, machine don't load containers.
Signal = 1: the infeed containers stop is opened, machine load containers.*)
		MachineEmpty : BOOL; (*Signal = 0: conatiners in filler/combi.
Signal = 1: no containers in filler/combi.*)
		Last20Containers : BOOL; (*Signal = 0: the signal remains at 0 during 20 containers in exit machine.
Signal = 1: the signal remains at 1 during 20 containers in exit machine.*)
		FciSampling : BOOL; (*Signal recived from FCI: FCI Sampling*)
		MachineSpeed : INT; (*The readed value from the filler main frequency inverter or tachometer is multiplied by a coefficient to give container/min.
This value should be accurate and refresh at least every 100ms*)
		OutletConveyorSpeed : INT; (*[dm/min] This signal is used to synchronize the discharge conveyors (reject table and next conveyors following the first discharge conveyor).
This value should be accurate and refresh at least every 100ms*)
	END_STRUCT;
	CvoFlr_Type : 	STRUCT 
		Alive : BOOL;
		OutletConveyorRunning : BOOL; (*Signal = 0: there is a trouble on the discharge conveyors (conveyors switch off or electrical fault). The filler has to stop as fast as possible.
Manual restart of the machine only (by the operator).
Signal = 1: discharge conveyors running or ready.*)
		OutletContainersLoadEnabled : BOOL; (*Signal = 0: the filler closes the container stop. Discharge conveyors are full with enough available space for the filler emptying.
Restart loading automatically when signal goes to 1.
Signal = 1: the filler can open the containers stop to load bottles.*)
		OutletConveyorLowSpeed : BOOL; (*Signal = 0: line at production speed.
Signal = 1: discharge conveyor is soon full, reduced speed before signal "containers stop dischage".*)
		RejectTableFull : BOOL; (*Signal = 0: the reject table is not full ( or reject table not existing).
Signal = 1: the reject table is full.
Put the information on the operator display of the filler (to know if you have to stop the filler, check the signal 10.1 and 10.2)*)
		FCIFault : BOOL; (*Signal = 0: the discharge container inspector is ready or container inspector not existing or cabled directly on the machine.
Signal = 1: the discharge container inspector is not ready.
Put the information on the operator display of the filler (to know if you have to stop the filler, check the signal 10.1 and 10.2)*)
		FCITooManyReject : BOOL; (*Signal = 0: the discharge container inspector is ready or container inspector not existing or cabled directly on the machine.
Signal = 1: the discharge container inspector reject too many containers.
Put the information on the operator display of the filler (to know if you have to stop the filler, check the signal 10.1 and 10.2)*)
		InfeedConveyorRunning : BOOL; (*Signal = 0: there is a trouble on the infeed conveyors (conveyors switch off or electrical fault). The filler has to stop as fast as possible.
Manual restart of the machine only (by the operator).
Signal = 1: infeed conveyors running or ready.*)
		InfeedContainersLoadEnabled : BOOL; (*Signal = 0: the filler closes the container stop. Infeed conveyors are full with enough available space for the filler emptying.
Restart loading automatically when signal goes to 1.
Signal = 1: the filler can open the containers stop to load bottles.*)
		InfeedConveyorLowSpeed : BOOL; (*Signal = 0: line at production speed.
Signal = 1: infeed conveyor is soon empty, reduced speed before signal "containers stop dischage".*)
		OverSpeedFromInfeed : BOOL; (*Signal = 0: normal accumulation, filler follow the line speed
Signal = 1: infeed conveyor is too much full. The machine run at the maximum speed*)
		FaultPressureInlinerSectionLeft : BOOL; (*V4.A.A.1.6.13*)
		FaultInpectorSectionLeft : BOOL;
		FaultRinserInfeedSectionLeft : BOOL;
		FaultFillerInfeedSectionLeft : BOOL;
		FaultPressureInlinerSectionRight : BOOL;
		FaultInpectorSectionRight : BOOL;
		FaultRinserInfeedSectionRight : BOOL;
		FaultFillerInfeedSectionRight : BOOL;
		LineSpeedReference : INT; (*It informs the filler of the line speed. This value is fixed by format. The machine could follow thi speed instead of filler operator settin on (HMI)*)
	END_STRUCT;
END_TYPE

(*VACUUM BARRIER COMPANY*)

TYPE
	FlrVbc_Type : 	STRUCT 
		ContainerPresence : BOOL;
		CopRunning : BOOL; (*Terboven*)
		ClockFine : BOOL; (*Terboven*)
		Clock : BOOL;
	END_STRUCT;
	VbcFlr_Type : 	STRUCT 
		Alarm : BOOL;
		LowLevel : BOOL;
	END_STRUCT;
END_TYPE

(*FULL CONTAINERS INSPECTOR*)

TYPE
	FlrFci_Type : 	STRUCT 
		ContainersPresence : BOOL; (*SIS-FT System-Pressco-Stratec-Filtec-Heuft*)
		Clock : BOOL; (*SIS-FT System-Pressco-Stratec-Filtec-Heuft*)
		ClockFine : BOOL; (*Heuft-Stratec*)
		FillingValve1 : BOOL; (*SIS-FT System-Pressco-Stratec-Filtec-Heuft*)
		ClosingHead1 : BOOL; (*SIS-FT System-Pressco-Stratec-Filtec-Heuft*)
		DoserHead1 : BOOL; (*SIS*)
		FirstContainersForcedRejected : BOOL; (*Stratec Optional*)
		BlowerMold1 : BOOL; (*SIS*)
		LabelerPlate1 : BOOL; (*SIS*)
		CrownerBottleBurst : BOOL; (*Heuft - Only for glass Filler*)
		BottleBurst2 : BOOL; (*Heuft - Only for glass Filler*)
		BottleBurst1 : BOOL; (*Heuft - Only for glass Filler*)
	END_STRUCT;
	FciFlr_Type : 	STRUCT 
		Fault : BOOL; (*FT System-Pressco-Stratec-Filtec-Heuft*)
		SystemReady : BOOL; (*SIS //v1.65*)
		WarningAlarms : BOOL; (*SIS //v1.65*)
		BottleRejection : BOOL; (*SIS  //v1.65*)
		TooManyReject : BOOL; (*FT System-Pressco-Stratec-Filtec-Heuft*)
		ConsecutiveReject : BOOL; (*Heuft*)
		Sampling : BOOL; (*SIS-FT System-Pressco-Stratec-Filtec-Heuft*)
	END_STRUCT;
END_TYPE

(*SIKO COMMUNICATION*)

TYPE
	FlrSiko_Type : 	STRUCT  (* *) (* *) (*84*)
		PKE : UINT; (* *) (* *) (*85*)
		IND : UINT; (* *) (* *) (*86*)
		PWE_H : UINT; (* *) (* *) (*87*)
		PWE_L : UINT; (* *) (* *) (*88*)
		STW : UINT; (* *) (* *) (*89*)
		HSW_H : UINT; (* *) (* *) (*90*)
		HSW_L : UINT; (* *) (* *) (*91*)
	END_STRUCT;
	SikoFlr_Type : 	STRUCT  (* *) (* *) (*93*)
		PKE : UINT; (* *) (* *) (*94*)
		IND : UINT; (* *) (* *) (*95*)
		PWE_H : UINT; (* *) (* *) (*96*)
		PWE_L : UINT; (* *) (* *) (*97*)
		ZSW : UINT; (* *) (* *) (*98*)
		HIW_H : UINT; (* *) (* *) (*99*)
		HIW_L : UINT; (* *) (* *) (*100*)
	END_STRUCT;
END_TYPE

(*COP COMMUNICATION*)

TYPE
	FlrCop_Type : 	STRUCT 
		ReadyForFoaming : BOOL;
		FoamingCycleStopReq : BOOL;
	END_STRUCT;
	CopFlr_Type : 	STRUCT 
		Alive : BOOL;
		CycleActive : BOOL;
		CycleEnded : BOOL;
		StationAlarm : BOOL;
		Section : ARRAY[1..7]OF BOOL;
	END_STRUCT;
END_TYPE

(*DOSER COMMUNICATION // V4.A.A.1.6.11*)

TYPE
	DosFlr_Type : 	STRUCT 
		AliveIncrement : INT;
		Head_1 : BOOL;
		Fault : BOOL;
		Alarm : BOOL;
		ContainerBlock : BOOL;
		OutOfService : BOOL;
		RotationRequest : BOOL;
		Positioning : BOOL;
		CipReady : BOOL;
		CipRunning : BOOL;
		ProdReady : BOOL;
		PrimingCycleProgress : BOOL;
		SettingCycleInProgress : BOOL;
		SampleCycleInProgress : BOOL;
		TankLevel : INT;
	END_STRUCT;
	FlrDos_Type : 	STRUCT 
		AliveIncrement : INT;
		FillingValve1 : BOOL;
		Clock : BOOL;
		FillerFault : BOOL;
		ValvePositioningDone : BOOL;
		AromePodReq : BOOL;
		ContainersPresence : BOOL;
		FillerSpeed : INT;
	END_STRUCT;
END_TYPE

(*UV LAMP CAPS TREATMENTS v1.4*)

TYPE
	FlrUvl_Type : 	STRUCT 
		Alive : BOOL;
		Emergency1 : BOOL;
		Emergency2 : BOOL;
		ShutterRequest : BOOL; (*1 : ON > Closes the optical cabinet for CIP 0 : OFF*)
		StartRequest : BOOL; (*1 : ON > Initializes Claranor + allows Indexing mode  0 : OFF + Indexing automatically engages*)
		ProductionRequest : BOOL; (*1 : ON > Enables Claranor to flash into production mode 0 : Flash disabled, do not consume caps*)
		Caps_Consumption : BOOL; (*1 : Consummed caps downstream to Claranor 0 : no caps flow (Used for cap jam detection)*)
		Fun_Run : BOOL; (*1 : ON > Enables Fan into production mode 0 : Fan disabled, do not consume caps v.1.63*)
		Lamp_On : BOOL; (*1: ON  > Enables Hoenle UV Lamp //V4.A.A.1.6.11*)
	END_STRUCT;
	UvlFlr_Type : 	STRUCT 
		Alive : BOOL;
		Hoenle_UvRun : BOOL; (*Lamp Powered On*)
		Hoenle_LampError : BOOL; (*Lamp is Supposed To Be on But Is Not On*)
		Hoenle_EVGSUMError : BOOL; (*Short Circuit, Overtemperature, Lamp Error or Phase Failure *)
		Hoenle_UvReady : BOOL; (*On the Minimum Necessary Power Is Reached*)
		Hoenle_ShutterOpen : BOOL; (*Feedback from Shutter*)
		Hoenle_ShutterClosed : BOOL; (*Feedback from Shutter*)
		Hoenle_FanRun : BOOL; (*Feedback from Exauster Fan*)
		Hoenle_SafetyEnable : BOOL; (*Feedback from Safety*)
		Hoenle_SupplyOverloadOk : BOOL := TRUE; (*Overload OK*)
		Claranor_No_Error : BOOL := TRUE; (*1 : No error 0 : Error*)
		Claranor_No_Warning : BOOL; (*1: OK 0 : Warning  See message on the HMI*)
		Claranor_Ready : BOOL; (*1 : Ready 0: Not Ready*)
		Claranor_Caps_Sensor : BOOL; (*1 : Caps flow > Allows to detect the caps flow in the optical cabinet, in an amount of one pulse per cap once in production mode*)
		Claranor_Shutter_Info : BOOL; (*1:  Optical cabinet Closed >This is compulsory for the optical cabinet to be closed before running CIP; 0 : Opened*)
		Claranor_Indexing_Info : BOOL; (*1 : Indexing OFF 0 : Indexing caps In progress*)
		Claranor_Emergency1 : BOOL;
		Claranor_Emergency2 : BOOL;
	END_STRUCT;
END_TYPE

(*CAP COMMUNICATION // V4.A.A.1.6.11*)

TYPE
	CapFlr_Type : 	STRUCT 
		Zalkin : ZalkinFlr_Type;
		SikoMbd : MbdSikoFlr_Type;
		Equatorque : EquFlr_Type; (* // V4.A.A.1.6.11*)
		Hrm : HrmFlr_Type; (* // V4.A.A.1.6.11*)
	END_STRUCT;
	FlrCap_Type : 	STRUCT 
		Zalkin : FlrZalkin_Type;
		SikoMbd : FlrSikoMbd_Type;
		Equatorque : FlrEqu_Type; (* // V4.A.A.1.6.11*)
		Hrm : FlrHrm_Type; (* // V4.A.A.1.6.11*)
	END_STRUCT;
END_TYPE

(*Zalkin Type*)

TYPE
	ZalkinFlr_Type : 	STRUCT 
		USINT1 : USINT;
		LastRunningHead : USINT;
		ActualBrushlessRecipe : USINT;
		MaintenanceModeInUse : USINT;
		ActualScrewingTorque : UINT;
		ActualScrewingSpeed : UINT;
		ActualTolerance : USINT;
		USINT10 : USINT;
		HeadPositionForCapPickUp : UINT;
		HeadPositionForHeadPositioning : UINT;
		CapPLCAck : UINT;
		UINT17 : UINT;
		UINT19 : UINT;
		UINT21 : UINT;
		UINT23 : UINT;
		UINT25 : UINT;
		UINT27 : UINT;
		UINT29 : UINT;
		UINT31 : UINT;
		EncoderPosition : UINT;
		CapPLCStatus : USINT;
		FBKFault : USINT;
		TorqueFBKAvailableOnHead1To16 : UINT;
		TorqueFBKAvailableOnHead17To32 : UINT;
		UINT41 : UINT;
		UINT43 : UINT;
		UINT45 : UINT;
		UINT47 : UINT;
		HeadDiagnostic : ARRAY[0..32]OF Head_Diagnostic_Type;
	END_STRUCT;
	FlrZalkin_Type : 	STRUCT 
		LifeBit : USINT;
		USINT1 : USINT;
		RequestedRecipe : USINT;
		MaintenanceMode : BOOL;
		ScrewingTorqueRequested : UINT;
		ScrewingSpeedRequested : UINT;
		ScrewingToleranceRequested : USINT;
		HeadNumberForCalibration : USINT;
		PickUpAangle : UINT;
		PositioningAngle : UINT;
		MotorStartAndPowerOn : UINT;
		MachineHeadConfig_1_16 : UINT;
		MachineHeadConfig_17_32 : UINT;
		TorqueFbkAvailableOnHead1To16 : UINT;
		TorqueFbkAvailableOnHead17To32 : UINT;
		BottlePresence_1_16 : UINT;
		BottlePresence_17_32 : UINT;
		USINT30 : USINT;
	END_STRUCT;
END_TYPE

(*Equatorque Type*)

TYPE
	EquFlr_Type : 	STRUCT 
		Status_Bit : InStatusBit_Type; (*Capper AROL Equatorque Status Bit*)
		Status_Spare1 : UINT; (*Capper AROL Equatorque Status Bit*)
		Multibody_Status_Bit : UINT; (*Capper AROL Multibody Status Bit*)
		Multibody_Status_Spare1 : UINT; (*Capper AROL Multibody Status Bit*)
		CConfig_Version : UINT; (*Capper AROL Equatorque Configuration -Software Version*)
		CConfig_Heads : UINT; (*Capper AROL Equatorque Configuration -Heads Number*)
		CConfig_StartMainAngle : UINT; (*Capper AROL Equatorque Configuration -Start Main Angle*)
		CConfig_DownMainAngle : UINT; (*Capper AROL Equatorque Configuration -Down Main Angle*)
		CConfig_CloseMainAngle : UINT; (*Capper AROL Equatorque Configuration -Close Main Angle*)
		CConfig_EndMainAngle : UINT; (*Capper AROL Equatorque Configuration -End Main Angle*)
		CConfig_BottleInMainAngle : UINT; (*Capper AROL Equatorque Configuration -Bottle In Main Angle*)
		CConfig_CloseGripMainAngle : UINT; (*Capper AROL Equatorque Configuration -Close Grip Main Angle*)
		CConfig_OpenGripMainAngle : UINT; (*Capper AROL Equatorque Configuration -Open Grip Main Angle*)
		CConfig_CapSensorMainAngle : UINT; (*Capper AROL Equatorque Configuration -Cap Sensor Main Angle*)
		CConfig_Spare1 : UINT; (*Capper AROL Equatorque Configuration -*)
		CConfig_Spare2 : UINT; (*Capper AROL Equatorque Configuration -*)
		HConfig_Version : UINT; (*HEAD AROL Equatorque Configuration -Head Software Version*)
		HConfig_IDHead : UINT; (*HEAD AROL Equatorque Configuration -Head ID*)
		HConfig_Disabled : UINT; (*HEAD AROL Equatorque Configuration -Head Disabled*)
		HConfig_TorqueOffset : UINT; (*HEAD AROL Equatorque Configuration -Head Torque Offset*)
		HConfig_RealKT : UINT; (*HEAD AROL Equatorque Configuration -Head Real KT*)
		HConfig_TorqueCorrection : UINT; (*HEAD AROL Equatorque Configuration -Head Torque Correction*)
		HConfig_Spare1 : UINT; (*HEAD AROL Equatorque Configuration -*)
		HConfig_Spare2 : UINT; (*HEAD AROL Equatorque Configuration -*)
		CSetup_Version : UINT; (*CLOSURE SETUP AROL Equatorque -Version*)
		CSetup_ScrewCW : UINT; (*CLOSURE SETUP AROL Equatorque -Screw Clock Wise*)
		CSetup_LockMode : UINT; (*CLOSURE SETUP AROL Equatorque -Lock Mode*)
		CSetup_ClosureTorque : UINT; (*CLOSURE SETUP AROL Equatorque -Closure Torque*)
		CSetup_GearingRatio : UINT; (*CLOSURE SETUP AROL Equatorque -Gearing Ratio*)
		CSetup_SlowTorque : UINT; (*CLOSURE SETUP AROL Equatorque -Slow Torque*)
		CSetup_GearingHolding : UINT; (*CLOSURE SETUP AROL Equatorque -Gearing Holding*)
		CSetup_ClosureSpeed : UINT; (*CLOSURE SETUP AROL Equatorque -Closure Speed*)
		CSetup_ClosingAcc : UINT; (*CLOSURE SETUP AROL Equatorque -Closing Acceleration*)
		CSetup_StopFactorSpeed : UINT; (*CLOSURE SETUP AROL Equatorque -Stop Factor Speed*)
		CSetup_BlindInputAngle : UINT; (*CLOSURE SETUP AROL Equatorque -Blind Input Angle*)
		CSetup_TimeInTorque : UINT; (*CLOSURE SETUP AROL Equatorque -Time In Torque*)
		CSetup_UnwrapAngle : UINT; (*CLOSURE SETUP AROL Equatorque -Unwrap Angle*)
		CSetup_UnwrapSpeed : UINT; (*CLOSURE SETUP AROL Equatorque -Unwrap Speed*)
		CSetup_UnwrapAcc : UINT; (*CLOSURE SETUP AROL Equatorque -Unwrap Acceleration*)
		CSetup_UnwrapBlindMainAngle : UINT; (*CLOSURE SETUP AROL Equatorque -Unwrap Blind Main Angle*)
		CSetup_PickOrient : UINT; (*CLOSURE SETUP AROL Equatorque -Pick Orient*)
		CSetup_PickOrientAlt : UINT; (*CLOSURE SETUP AROL Equatorque -Pick Orient Alt*)
		CSetup_InsertOrient : UINT; (*CLOSURE SETUP AROL Equatorque -Insert Orient*)
		CSetup_CloseRotation : UINT; (*CLOSURE SETUP AROL Equatorque -Close Rotation*)
		CSetup_CurrentFilter : UINT; (*CLOSURE SETUP AROL Equatorque -Current Filter*)
		CSetup_CapTurns : UINT; (*CLOSURE SETUP AROL Equatorque -Cap Turns*)
		CSetupStatusMask : InCSetupStatusMask_Type; (*CLOSURE SETUP AROL Equatorque -STATUS MASK V4.A.A.1.6.12*)
		CSetup_Spare1 : UINT; (*CLOSURE SETUP AROL Equatorque -*)
		CSetup_Spare2 : UINT; (*CLOSURE SETUP AROL Equatorque -*)
		STS_DiagCode : UINT; (*CLOSURE STATUS AROL Equatorque -PacDrive Diagnostic Code*)
		STS_EncPosition : UINT; (*CLOSURE STATUS AROL Equatorque -Main Encoder Position*)
		STS_AxisPosition : UINT; (*CLOSURE STATUS AROL Equatorque -Head Motor Axis Position*)
		STS_BPMSpeed : UINT; (*CLOSURE STATUS AROL Equatorque -Production Speed in items/m*)
		STS_CalibTorque : UINT; (*CLOSURE STATUS AROL Equatorque -Calibration Torque*)
		STS_CalibCurrent : UINT; (*CLOSURE STATUS AROL Equatorque -Calibration Current*)
		CLS_Head : UINT; (*CLOSURE STATUS SETUP AROL Equatorque -Closure Head Number*)
		CLS_Count : UINT; (*CLOSURE STATUS SETUP AROL Equatorque -Closure Count*)
		CLS_NoLoadCurr : UINT; (*CLOSURE STATUS SETUP AROL Equatorque -Closure No Load Current*)
		CLS_SwitchTurns : UINT; (*CLOSURE STATUS SETUP AROL Equatorque -Closure Switch Head Rotation*)
		CLS_LockTurns : UINT; (*CLOSURE STATUS SETUP AROL Equatorque -Closure Lock Head Rotation*)
		CLS_SwitchPositon : UINT; (*CLOSURE STATUS SETUP AROL Equatorque -Closure Switch Head Position*)
		CLS_LockPositon : UINT; (*CLOSURE STATUS SETUP AROL Equatorque -Closure Lock Head Position*)
		CLS_AppliedTorque : UINT; (*CLOSURE STATUS SETUP AROL Equatorque -Closure AppliedTorque*)
		CLS_ClosureStatus : InCLSClosureStatus_Type; (*CLOSURE STATUS SETUP AROL Equatorque -Closure Status*)
	END_STRUCT;
	FlrEqu_Type : 	STRUCT 
		Status_Bit : OutStatusBit_Type; (*Status Bit*)
		Status_Bit_Spare1 : UINT; (*Status Bit*)
		CMD_Equatorque : OutCMDEquatorque_Type; (*Command To Equatorque*)
		CMD_Equatorque_Spare1 : UINT; (*Command To Equatorque*)
		CConfig_Version : UINT; (*Write Configuration To Equatorque*)
		CConfig_Heads : UINT; (*Capper AROL Equatorque Configuration -Head Number*)
		CConfig_StartMainAngle : UINT; (*Capper AROL Equatorque Configuration -Start In Main Angle (Recipe)*)
		CConfig_DownMainAngle : UINT; (*Capper AROL Equatorque Configuration -Down Main Angle  (Recipe)*)
		CConfig_CloseMainAngle : UINT; (*Capper AROL Equatorque Configuration -Close Main Angle  (Recipe)*)
		CConfig_EndMainAngle : UINT; (*Capper AROL Equatorque Configuration -End Main Angle  (Recipe)*)
		CConfig_BottleInMainAngle : UINT; (*Capper AROL Equatorque Configuration -Bottle In Main Angle*)
		CConfig_CloseGripMainAngle : UINT; (*Capper AROL Equatorque Configuration -Close Grip Main Angle*)
		CConfig_OpenGripMainAngle : UINT; (*Capper AROL Equatorque Configuration -Open Grip Main Angle*)
		CConfig_CapSensorMainAngle : UINT; (*Capper AROL Equatorque Configuration -Cap Sensor Main Angle*)
		CConfig_Spare1 : UINT; (*Write Configuration To Equatorque*)
		CConfig_Spare2 : UINT; (*Write Configuration To Equatorque*)
		HConfig_Version : UINT; (*HEAD AROL Equatorque Configuration -Version*)
		HConfig_IDHead : UINT; (*HEAD AROL Equatorque Configuration -Head ID*)
		HConfig_Disabled : UINT; (*HEAD AROL Equatorque Configuration -Head Disable*)
		HConfig_TorqueOffset : UINT; (*HEAD AROL Equatorque Configuration -Head Torque Offset*)
		HConfig_RealKT : UINT; (*HEAD AROL Equatorque Configuration -Head Real KT*)
		HConfig_TorqueCorrection : UINT; (*HEAD AROL Equatorque Configuration -Head Torque Correction*)
		HConfig_Spare1 : UINT; (*HEAD AROL Equatorque Configuration -*)
		HConfig_Spare2 : UINT; (*HEAD AROL Equatorque Configuration -*)
		CSetup_Version : UINT; (*CLOSURE SETUP AROL Equatorque -Version*)
		CSetup_ScrewCW : UINT; (*CLOSURE SETUP AROL Equatorque -Screw Clock Wise*)
		CSetup_LockMode : UINT; (*CLOSURE SETUP AROL Equatorque -Lock Mode*)
		CSetup_ClosureTorque : UINT; (*CLOSURE SETUP AROL Equatorque -Closure Torque (Recipe)*)
		CSetup_GearingRatio : UINT; (*CLOSURE SETUP AROL Equatorque -Gearing Ratio (Recipe)*)
		CSetup_SlowTorque : UINT; (*CLOSURE SETUP AROL Equatorque -Slow Torque (Recipe)*)
		CSetup_GearingHolding : UINT; (*CLOSURE SETUP AROL Equatorque -Gearing Holding (Recipe)*)
		CSetup_ClosureSpeed : UINT; (*CLOSURE SETUP AROL Equatorque -Closure Speed (Recipe)*)
		CSetup_ClosingAcc : UINT; (*CLOSURE SETUP AROL Equatorque -Closing Acceleration (Recipe)*)
		CSetup_StopFactorSpeed : UINT; (*CLOSURE SETUP AROL Equatorque -Stop Factor Speed (Recipe)*)
		CSetup_BlindInputAngle : UINT; (*CLOSURE SETUP AROL Equatorque -Blind Input Angle (Recipe)*)
		CSetup_TimeInTorque : UINT; (*CLOSURE SETUP AROL Equatorque -Time In Torque (Recipe)*)
		CSetup_UnwrapAngle : UINT; (*CLOSURE SETUP AROL Equatorque -Unwrap Angle (Recipe)*)
		CSetup_UnwrapSpeed : UINT; (*CLOSURE SETUP AROL Equatorque -Unwrap Speed (Recipe)*)
		CSetup_UnwrapAcc : UINT; (*CLOSURE SETUP AROL Equatorque -Unwrap Acceleration (Recipe)*)
		CSetup_UnwrapBlindMainAngle : UINT; (*CLOSURE SETUP AROL Equatorque -Unwrap Blind Main Angle (Recipe)*)
		CSetup_PickOrient : UINT; (*CLOSURE SETUP AROL Equatorque -Pick Orient*)
		CSetup_PickOrientAlt : UINT; (*CLOSURE SETUP AROL Equatorque -Pick Orient Alt*)
		CSetup_InsertOrient : UINT; (*CLOSURE SETUP AROL Equatorque -Insert Orient*)
		CSetup_CloseRotation : UINT; (*CLOSURE SETUP AROL Equatorque -Close Rotation*)
		CSetup_CurrentFilter : UINT; (*CLOSURE SETUP AROL Equatorque -Current Filter*)
		CSetup_CapTurns : UINT; (*CLOSURE SETUP AROL Equatorque -Cap Turns (Recipe)*)
		CSetupStatusMask : OutCSetupStatusMask_Type; (*CLOSURE SETUP AROL Equatorque -STATUS MASK (Recipe)*)
		CSetup_Spare1 : UINT; (*CLOSURE SETUP AROL Equatorque -*)
		CSetup_Spare2 : UINT; (*CLOSURE SETUP AROL Equatorque -*)
		CSetup_Spare3 : UINT; (*AROL Equatorque -*)
		CMD_Multibody : OutCMDMultibody_Type; (*Command To Multibody*)
		Pos_CentralGuide : UINT; (*Multibody Position -Central Guide*)
		Pos_BodySkate : UINT; (*Multibody Position -Body Skate*)
		Pos_ExtractSkate : UINT; (*Multibody Position -Extract Skate*)
		Pos_Spare1 : UINT; (*Multibody Position -*)
		Pos_Selection : UINT; (*Multibody Position - 1=Central Guide - 2=Body Skate - 3=Extract Skate*)
		Spare1 : UINT; (*To Equatorque -*)
		Spare2 : UINT; (*To Equatorque -*)
		Spare3 : UINT; (*To Equatorque -*)
		Spare4 : UINT; (*To Equatorque -*)
		Spare5 : UINT; (*To Equatorque -*)
		Spare6 : UINT; (*To Equatorque -*)
		Spare7 : UINT; (*To Equatorque -*)
		Spare8 : UINT; (*To Equatorque -*)
	END_STRUCT;
	OutStatusBit_Type : 	STRUCT 
		Spare0_0 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare0_1 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare0_2 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare0_3 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare0_4 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare0_5 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare0_6 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare0_7 : BOOL; (*To AROL Equatorque Status Bit -*)
		WatchDog : BOOL; (*To AROL Equatorque Status Bit -WatchDog signal (1s ON and  1s OFF)*)
		Writing : BOOL; (*To AROL Equatorque Status Bit -Data Writing to Driver*)
		Spare1_2 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare1_3 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare1_4 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare1_5 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare1_6 : BOOL; (*To AROL Equatorque Status Bit -*)
		Spare1_7 : BOOL; (*To AROL Equatorque Status Bit -*)
	END_STRUCT;
	OutCSetupStatusMask_Type : 	STRUCT 
		Spare0_0 : BOOL; (*To AROL Equatorque -STATUS MASK*)
		Spare0_1 : BOOL; (*To AROL Equatorque -STATUS MASK*)
		Spare0_2 : BOOL; (*To AROL Equatorque -STATUS MASK*)
		Spare0_3 : BOOL; (*To AROL Equatorque -STATUS MASK*)
		Spare0_4 : BOOL; (*To AROL Equatorque -STATUS MASK*)
		Spare0_5 : BOOL; (*To AROL Equatorque -STATUS MASK*)
		Spare0_6 : BOOL; (*To AROL Equatorque -STATUS MASK*)
		Spare0_7 : BOOL; (*To AROL Equatorque -STATUS MASK*)
		RejectionSignal : BOOL; (*To AROL Equatorque -STATUS MASK -RejectionSignal*)
		NoLoad : BOOL; (*To AROL Equatorque -STATUS MASK -No Load*)
		NoClosure : BOOL; (*To AROL Equatorque -STATUS MASK -No Closure*)
		InTorque : BOOL; (*To AROL Equatorque -STATUS MASK -In Torque*)
		CapsTurn : BOOL; (*To AROL Equatorque -STATUS MASK -Caps Turn*)
		FollowingError : BOOL; (*To AROL Equatorque -STATUS MASK -Following Error*)
		BadClosure : BOOL; (*To AROL Equatorque -STATUS MASK -Bad closure*)
		NoUnwrap : BOOL; (*To AROL Equatorque -STATUS MASK -No Unwrap*)
	END_STRUCT;
	OutCMDEquatorque_Type : 	STRUCT 
		Closure_Start : BOOL; (*To AROL Equatorque Command Bit -Closure Start*)
		Calibration_Start : BOOL; (*To AROL Equatorque Command Bit -Calibration Start*)
		Enable : BOOL; (*To AROL Equatorque Command Bit -Enable Equatorque (Must be TRUE to work)*)
		Closure_Disable : BOOL; (*To AROL Equatorque Command Bit -Closure Disable*)
		Spare0_4 : BOOL; (*To AROL Equatorque Command Bit -*)
		ZeroHeadAxis : BOOL; (*To AROL Equatorque Command Bit -Zero Head Axis*)
		Reset : BOOL; (*To AROL Equatorque Command Bit -Reset Equatorque*)
		Zero_Encoder : BOOL; (*To AROL Equatorque Command Bit -Zero Encoder*)
		StoreConfig : BOOL; (*To AROL Equatorque Command Bit -Store Configuration*)
		RestoreConfig : BOOL; (*To AROL Equatorque Command Bit -Restore Configuration*)
		DefaultConfig : BOOL; (*To AROL Equatorque Command Bit -Default Configuration*)
		StoreSetup : BOOL; (*To AROL Equatorque Command Bit -Store Setup*)
		RestoreSetup : BOOL; (*To AROL Equatorque Command Bit -Restore Setup*)
		DefaultSetup : BOOL; (*To AROL Equatorque Command Bit -Default Setup*)
		StartLogger : BOOL; (*To AROL Equatorque Command Bit -Start Logger*)
		StoreHistory : BOOL; (*To AROL Equatorque Command Bit -Store History*)
	END_STRUCT;
	OutCMDMultibody_Type : 	STRUCT 
		CentralGuide_Homing : BOOL; (*To AROL Multibody Command Bit -Central Guide Homing*)
		BodySkate_Homing : BOOL; (*To AROL Multibody Command Bit -Body Skate Homing*)
		ExtractSkate_Homing : BOOL; (*To AROL Multibody Command Bit -Extract Skate Homing*)
		Spare0_3 : BOOL; (*To AROL Multibody Command Bit -*)
		Spare0_4 : BOOL; (*To AROL Multibody Command Bit -*)
		Spare0_5 : BOOL; (*To AROL Multibody Command Bit -*)
		Spare0_6 : BOOL; (*To AROL Multibody Command Bit -*)
		Spare0_7 : BOOL; (*To AROL Multibody Command Bit -*)
		CentralGuide_Start : BOOL; (*To AROL Multibody Command Bit -Central Guide Start*)
		BodySkate_Start : BOOL; (*To AROL Multibody Command Bit -Body Skate Start*)
		ExtractSkate_Start : BOOL; (*To AROL Multibody Command Bit -Extract Skate Start*)
		Spare1_3 : BOOL; (*To AROL Multibody Command Bit -*)
		CentralGuide_Brake : BOOL; (*To AROL Multibody Command Bit -Central Guide Brake*)
		BodySkate_Brake : BOOL; (*To AROL Multibody Command Bit -Body Skate Brake*)
		ExtractSkate_Brake : BOOL; (*To AROL Multibody Command Bit -Extract Skate Brake*)
		Spare1_7 : BOOL; (*To AROL Multibody Command Bit -*)
	END_STRUCT;
	InStatusBit_Type : 	STRUCT 
		ClosureKO : BOOL; (*From AROL Equatorque Status Bit -Closure not OK*)
		ClosureOK : BOOL; (*From AROL Equatorque Status Bit -Closure OK V4.A.A.1.6.12*)
		Spare0_2 : BOOL; (*From AROL Equatorque Status Bit -*)
		Spare0_3 : BOOL; (*From AROL Equatorque Status Bit -*)
		Spare0_4 : BOOL; (*From AROL Equatorque Status Bit -*)
		Spare0_5 : BOOL; (*From AROL Equatorque Status Bit -*)
		EqtqReady : BOOL; (*From AROL Equatorque Status Bit -If FALSE the communication
system with the motors is not
active or the capper is not ready.
The turret must be held stopped
until the value becomes TRUE. V4.A.A.1.6.12*)
		Alarm : BOOL; (*From AROL Equatorque Status Bit -PacDrive Controller Alarm*)
		WatchDog : BOOL; (*From AROL Equatorque Status Bit -WatchDog signal (1s ON and  1s OFF)*)
		Eqtq_WR : BOOL; (*From AROL Equatorque Status Bit -Equatorque is Writing*)
		ConfigNotOK : BOOL; (*From AROL Equatorque Status Bit -Configuration is not stored in CompactFlash*)
		SetupNotOK : BOOL; (*From AROL Equatorque Status Bit -Setup is not stored in CompactFlash*)
		Spare1_4 : BOOL; (*From AROL Equatorque Status Bit -*)
		Spare1_5 : BOOL; (*From AROL Equatorque Status Bit -*)
		Spare1_6 : BOOL; (*From AROL Equatorque Status Bit -*)
		Spare1_7 : BOOL; (*From AROL Equatorque Status Bit -*)
	END_STRUCT;
	InCSetupStatusMask_Type : 	STRUCT 
		Spare0_0 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_1 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_2 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_3 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_4 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_5 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_6 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_7 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		RejectionSignal : BOOL; (*From AROL Equatorque -STATUS MASK -RejectionSignal*)
		NoLoad : BOOL; (*From AROL Equatorque -STATUS MASK -No Load*)
		NoClosure : BOOL; (*From AROL Equatorque -STATUS MASK -No Closure*)
		InTorque : BOOL; (*From AROL Equatorque -STATUS MASK -In Torque (Recipe)*)
		CapsTurn : BOOL; (*From AROL Equatorque -STATUS MASK -Caps Turn*)
		FollowingError : BOOL; (*From AROL Equatorque -STATUS MASK -Following Error*)
		BadClosure : BOOL; (*From AROL Equatorque -STATUS MASK -Bad Closure (Recipe)*)
		NoUnwrap : BOOL; (*From AROL Equatorque -STATUS MASK -No Unwrap*)
	END_STRUCT;
	InCLSClosureStatus_Type : 	STRUCT  (*Comunication With AROL Equatorque -Profibus DP DATA IN*)
		Spare0_0 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_1 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_2 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_3 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_4 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_5 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_6 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		Spare0_7 : BOOL; (*From AROL Equatorque -STATUS MASK*)
		RejectionSignal : BOOL; (*From AROL Equatorque -STATUS MASK -RejectionSignal*)
		NoLoad : BOOL; (*From AROL Equatorque -STATUS MASK -No Load*)
		NoClosure : BOOL; (*From AROL Equatorque -STATUS MASK -No Closure*)
		InTorque : BOOL; (*From AROL Equatorque -STATUS MASK -In Torque (Recipe)*)
		CapsTurn : BOOL; (*From AROL Equatorque -STATUS MASK -Caps Turn*)
		FollowingError : BOOL; (*From AROL Equatorque -STATUS MASK -Following Error*)
		BadClosure : BOOL; (*From AROL Equatorque -STATUS MASK -Bad Closure (Recipe)*)
		NoUnwrap : BOOL; (*From AROL Equatorque -STATUS MASK -No Unwrap*)
	END_STRUCT;
END_TYPE

(*HRM Type*)

TYPE
	HrmFlr_Type : 	STRUCT 
		STS_StatusBits : InStatusBitHrm_Type; (*0*)
		STS_1 : UINT; (*2*)
		STS_2 : UINT; (*4*)
		STS_WDCount : UINT; (*6*)
		CConfig_NR_Heads : UINT; (*8*)
		CConfig_MotorDirection : UINT; (*10*)
		CConfig_GearIn : UDINT; (*12*)
		CConfig_GearOut : UDINT; (*16*)
		CConfig_Res_1 : UINT; (*20*)
		CConfig_Res_2 : UINT; (*22*)
		CConfig_Res_3 : UINT; (*24*)
		CSetup_Mode : UINT; (*26*)
		CSetup_Acc : UINT; (*28*)
		CSetup_Dec : UINT; (*30*)
		CSetup_EDec : UINT; (*32*)
		CSetup_Gearing : UINT; (*34*)
		CSetup_JogSpeed : UINT; (*36*)
		CSetup_JogAcc : UINT; (*38*)
		CSetup_JogDec : UINT; (*40*)
		CSetup_Rpm_at_00K : UINT; (*42*)
		CSetup_Rpm_at_05K : UINT; (*44*)
		CSetup_Rpm_at_10K : UINT; (*46*)
		CSetup_Rpm_at_15K : UINT; (*48*)
		CSetup_Rpm_at_20K : UINT; (*50*)
		CSetup_Rpm_at_25K : UINT; (*52*)
		CSetup_Rpm_at_30K : UINT; (*54*)
		CSetup_Rpm_at_35K : UINT; (*56*)
		CSetup_Rpm_at_40K : UINT; (*58*)
		CSetup_Rpm_at_45K : UINT; (*60*)
		CSetup_Rpm_at_50K : UINT; (*62*)
		CSetup_Rpm_at_55K : UINT; (*64*)
		CSetup_Rpm_at_60K : UINT; (*66*)
		CSetup_Rpm_at_65K : UINT; (*68*)
		CSetup_Rpm_at_70K : UINT; (*70*)
		CSetup_Rpm_at_75K : UINT; (*72*)
		CSetup_Rpm_at_80K : UINT; (*74*)
		CSetup_Rpm_at_85K : UINT; (*76*)
		CSetup_Rpm_at_90K : UINT; (*78*)
		CSetup_Rpm_at_95K : UINT; (*80*)
		CSetup_Rpm_at_100K : UINT; (*82*)
		CSetup_Res_1 : UINT; (*84*)
		CSetup_Res_2 : UINT; (*86*)
		CSetup_Res_3 : UINT; (*88*)
		STS_DiagCode : UINT;
		STS_3 : UINT; (*90*)
		STS_4 : UINT; (*92*)
		STS_ProdSpeedRPM : UINT; (*94*)
		STS_ProdSpeedBPH : UINT; (*96*)
		STS_HeadSpeedRPM : UINT; (*98*)
		STS_5 : UINT; (*100*)
		STS_ActualCurrent : UDINT; (*102*)
		Spare_0 : UINT; (*104*)
		Spare_1 : UINT; (*108*)
		Spare_2 : UINT; (*110*)
		Spare_3 : UINT; (*112*)
		Spare_4 : UINT; (*114*)
		Spare_5 : UINT; (*118*)
		Spare_6 : UINT; (*120*)
		Spare_7 : UINT; (*122*)
		Spare_8 : UINT; (*124*)
		Spare_9 : UINT; (*126*)
	END_STRUCT;
	FlrHrm_Type : 	STRUCT 
		CMD_CommandBits : OutCMDHrm_Type; (*0*)
		CMD_1 : UINT; (*2*)
		CMD_2 : UINT; (*4*)
		CMD_3 : UINT; (*6*)
		CConfig_NR_Heads : UINT; (*8*)
		CConfig_MotorDirection : UINT; (*10*)
		CConfig_GearIn : UDINT; (*12*)
		CConfig_GearOut : UDINT; (*16*)
		CConfig_Res_1 : UINT; (*20*)
		CConfig_Res_2 : UINT; (*22*)
		CConfig_Res_3 : UINT; (*24*)
		CSetup_Mode : UINT; (*26*)
		CSetup_Acc : UINT; (*28*)
		CSetup_Dec : UINT; (*30*)
		CSetup_EDec : UINT; (*32*)
		CSetup_Gearing : UINT; (*34*)
		CSetup_JogSpeed : UINT; (*36*)
		CSetup_JogAcc : UINT; (*38*)
		CSetup_JogDec : UINT; (*40*)
		CSetup_Rpm_at_00K : UINT; (*42*)
		CSetup_Rpm_at_05K : UINT; (*44*)
		CSetup_Rpm_at_10K : UINT; (*46*)
		CSetup_Rpm_at_15K : UINT; (*48*)
		CSetup_Rpm_at_20K : UINT; (*50*)
		CSetup_Rpm_at_25K : UINT; (*52*)
		CSetup_Rpm_at_30K : UINT; (*54*)
		CSetup_Rpm_at_35K : UINT; (*56*)
		CSetup_Rpm_at_40K : UINT; (*58*)
		CSetup_Rpm_at_45K : UINT; (*60*)
		CSetup_Rpm_at_50K : UINT; (*62*)
		CSetup_Rpm_at_55K : UINT; (*64*)
		CSetup_Rpm_at_60K : UINT; (*66*)
		CSetup_Rpm_at_65K : UINT; (*68*)
		CSetup_Rpm_at_70K : UINT; (*70*)
		CSetup_Rpm_at_75K : UINT; (*72*)
		CSetup_Rpm_at_80K : UINT; (*74*)
		CSetup_Rpm_at_85K : UINT; (*76*)
		CSetup_Rpm_at_90K : UINT; (*78*)
		CSetup_Rpm_at_95K : UINT; (*80*)
		CSetup_Rpm_at_100K : UINT; (*82*)
		CSetup_Res_1 : UINT; (*84*)
		CSetup_Res_2 : UINT; (*86*)
		CSetup_Res_3 : UINT; (*88*)
		Spare_0 : UINT; (*90*)
		Spare_1 : UINT; (*92*)
		Spare_2 : UINT; (*94*)
		Spare_3 : UINT; (*96*)
		Spare_4 : UINT; (*98*)
		Spare_5 : UINT; (*100*)
		Spare_6 : UINT; (*102*)
		Spare_7 : UINT; (*104*)
		Spare_8 : UINT; (*106*)
		Spare_9 : UINT; (*108*)
		Spare_10 : UINT; (*110*)
		Spare_11 : UINT; (*112*)
		Spare_12 : UINT; (*114*)
		Spare_13 : UINT; (*116*)
		Spare_14 : UINT; (*118*)
		Spare_15 : UINT; (*120*)
		Spare_16 : UINT; (*122*)
		Spare_17 : UINT; (*124*)
		Spare_18 : UINT; (*126*)
	END_STRUCT;
	InStatusBitHrm_Type : 	STRUCT 
		ModeAuto : BOOL; (*From AROL HRM Status Bit - Closure Start command request active*)
		Spare0_1 : BOOL; (*From AROL HRM Status Bit -*)
		Enabled : BOOL; (*From AROL HRM Status Bit - Enable command request active*)
		Spare0_3 : BOOL; (*From AROL HRM Status Bit -*)
		GetDiag_DONE : BOOL; (*From AROL HRM Status Bit - System Diagnostic request executed*)
		Spare0_5 : BOOL; (*From AROL HRM Status Bit -*)
		Ready : BOOL; (*From AROL HRM Status Bit - 1: System Active*)
		Alarm : BOOL; (*From AROL HRM Status Bit -PacDrive Controller Alarm*)
		WatchDog : BOOL; (*From AROL HRM Status Bit -WatchDog signal (1s ON and  1s OFF)*)
		HRM_WR : BOOL; (*From AROL HRM Status Bit -HRM is Writing*)
		ConfigNotOK : BOOL; (*From AROL HRM Status Bit -Configuration is not stored in CompactFlash*)
		SetupNotOK : BOOL; (*From AROL HRM Status Bit -Setup is not stored in CompactFlash*)
		Spare1_4 : BOOL; (*From AROL HRM Status Bit -*)
		Spare1_5 : BOOL; (*From AROL HRM Status Bit -*)
		JogForward : BOOL; (*From AROL HRM Status Bit - Manual Command Forward*)
		JogBackward : BOOL; (*From AROL HRM Status Bit - Manual Command Backward*)
	END_STRUCT;
	OutCMDHrm_Type : 	STRUCT 
		ClosureStart : BOOL; (*From AROL HRM Status Bit - Closure Start command request active*)
		Spare0_1 : BOOL; (*From AROL HRM Status Bit -*)
		Enable : BOOL; (*From AROL HRM Status Bit - Enable command request active*)
		Spare0_3 : BOOL; (*From AROL HRM Status Bit -*)
		GetDiag : BOOL; (*From AROL HRM Status Bit - System Diagnostic request executed*)
		Spare0_5 : BOOL; (*From AROL HRM Status Bit -*)
		Reset : BOOL; (*From AROL HRM Status Bit - 1: System Active*)
		Spare0_7 : BOOL; (*From AROL HRM Status Bit -PacDrive Controller Alarm*)
		WatchDog : BOOL; (*From AROL HRM Status Bit -WatchDog signal (1s ON and  1s OFF)*)
		StoreConfig : BOOL; (*From AROL HRM Status Bit -HRM is Writing*)
		StoreSetup : BOOL; (*From AROL HRM Status Bit -Configuration is not stored in CompactFlash*)
		Spare1_3 : BOOL; (*From AROL HRM Status Bit -Setup is not stored in CompactFlash*)
		Spare1_4 : BOOL; (*From AROL HRM Status Bit -*)
		Spare1_5 : BOOL; (*From AROL HRM Status Bit -*)
		JogForward : BOOL; (*From AROL HRM Status Bit - Manual Command Forward*)
		JogBackward : BOOL; (*From AROL HRM Status Bit - Manual Command Backward*)
	END_STRUCT;
END_TYPE

(*Syko Multibody Type*)

TYPE
	FlrSikoMbd_Type : 	STRUCT 
		SikoCmd : ARRAY[0..5]OF MotorSikoCmd_Type;
		iWatchDog : INT; (*Input WatchDog*)
	END_STRUCT;
	MbdSikoFlr_Type : 	STRUCT 
		SikoSts : ARRAY[0..5]OF MotorSikoSts_Type;
		iWatchDog : INT; (*Input WatchDog*)
	END_STRUCT;
	MotorSikoCmd_Type : 	STRUCT 
		xEnable : BOOL; (*Enable motor*)
		xReset : BOOL; (*Reset error*)
		xStartPos : BOOL; (*Start positioning*)
		xJogForward : BOOL; (*Jog forward*)
		xJogBackward : BOOL; (*Jog backward*)
		xSetZero : BOOL; (*Set zero position*)
		xWriteParam : BOOL; (*Write parameter*)
		xReadParam : BOOL; (*Read parameter*)
		wCmdSpare : INT; (*Spare commands word*)
		xTargetPosition : DINT; (*Target position*)
		wPositionVelocity : INT; (*Position velocity*)
		wJogVelocity : INT; (*Jog velocity*)
		bCurrentLimit : BYTE; (*Current limit*)
		bSenseOfRotation : BYTE; (*Sense of rotation*)
		wSpare : INT; (*Sense of rotation*)
		wSpare1 : INT; (*Sense of rotation*)
		wSpare2 : INT; (*Sense of rotation*)
		wSpare3 : INT; (*Sense of rotation*)
	END_STRUCT;
	MotorSikoSts_Type : 	STRUCT 
		xPowerOk : BOOL; (*Motor power supply is OK*)
		xEnabled : BOOL; (*Motor is enabled*)
		xReady : BOOL; (*Motor is ready*)
		xRunning : BOOL; (*Motor is running*)
		xInPosition : BOOL; (*Motor is in target position*)
		xBatteryWarning : BOOL; (*Motor battery warning error*)
		xError : BOOL; (*Motor generic error*)
		xSpare_1 : BOOL; (*Spare bit*)
		xParamRwBusy : BOOL; (*Parameter read/write operation is busy*)
		xParamRwError : BOOL; (*Parameter read/write operation is in error*)
		xParamRwDone : BOOL; (*Parameter read/write operation is done*)
		wSpareFdbks : UINT; (*Motor actual position*)
		diActualPosition : DINT; (*Motor actual position*)
		wPositionVelocity : INT; (*Jog velocity*)
		wJogVelocity : INT; (*Current limit*)
		bCurrentLimit : BYTE; (*Sense of rotation*)
		bSenseOfRotation : BYTE;
		wSpare0 : INT;
		wSpare1 : INT;
		wSpare2 : {REDUND_UNREPLICABLE} INT;
		wSpare3 : INT;
	END_STRUCT;
	Head_Diagnostic_Type : 	STRUCT 
		FaultNumber : USINT;
		StatusOfInverter : USINT;
		TorqueFeedbackOnHead : UINT;
	END_STRUCT;
END_TYPE

(*WATER TREATMENT V4.A.A.1.6.12*)

TYPE
	FlrWtt_Type : 	STRUCT  (*V4.A.A.1.6.12*)
		Alive : BOOL; (*Life bit signal*)
		ProductionRunning : BOOL;
		ProductRequest : BOOL;
		ProductionAlarm : BOOL; (*V4.A.A.1.7.0*)
		BOOL4 : BOOL;
		BOOL5 : BOOL;
		BOOL6 : BOOL;
		BOOL7 : BOOL;
		CipMode : BOOL; (*V4.A.A.1.7.0*)
		CipAlarm : BOOL; (*V4.A.A.1.7.0*)
		CipProductRequest : BOOL; (*V4.A.A.1.7.0*)
		ControlRunning : BOOL; (*V4.A.A.1.7.0*)
	END_STRUCT;
	WttFlr_Type : 	STRUCT  (*V4.A.A.1.6.12*)
		Alive : BOOL; (*Life bit signal*)
		ProductionMode : BOOL;
		ProductAvailable : BOOL;
		FilterCleaning : BOOL;
		OzoneLevelOk : BOOL;
		BOOL5 : BOOL;
		BOOL6 : BOOL;
		BOOL7 : BOOL;
		CipMode : BOOL; (*V4.A.A.1.7.0*)
		CipAlarm : BOOL; (*V4.A.A.1.7.0*)
		CipSending : BOOL; (*V4.A.A.1.7.0*)
		CheckSolutionOk : BOOL; (*V4.A.A.1.7.0*)
	END_STRUCT;
END_TYPE

(*DATA ACQUISITION COMMUNICATION //V4.A.A.1.6.14*)

TYPE
	FlrDaq_Type : 	STRUCT 
		Alive : BOOL;
		StopBit : BOOL; (*Common - Stop bit*)
		OperatorPresence : BOOL; (*Common - Operator presence*)
		ModeAuto : BOOL; (*Common - Operator presence*)
		ModeJog : BOOL; (*Common - Operator presence*)
		ModeSetting : BOOL; (*Common - Operator presence*)
		MachineStatus : UINT; (*Common - Machine Status*)
		SKU : UINT; (*Common - SKU*)
		RecipeNumber : UINT; (*Common - Recipe name*)
		Format : UINT; (*Common - Format*)
		Reason : UDINT; (*Common - Reason code that stop the production on machine*)
		ProductionSpeed : UDINT; (*Common - Production speed in CPM (Container per minute)*)
		SetSpeed : UDINT; (*Common - Set speed*)
		InfeedCount : UDINT; (*Filler - Count of infeed container on the machine*)
		ContainersBurstCount : UDINT; (*Filler - Number of Burst container count*)
		LowLevelEjectCount : UDINT;
	END_STRUCT;
	DaqFlr_Type : 	STRUCT 
		Alive : BOOL;
	END_STRUCT;
END_TYPE

(*CODER V4.A.A.1.7.0*)

TYPE
	FlrCdr_Type : 	STRUCT  (*//RMC275*)
		ProductionRunning : BOOL;
		BOOL1 : BOOL;
		BOOL2 : BOOL;
		BOOL3 : BOOL;
		BOOL4 : BOOL;
		BOOL5 : BOOL;
		BOOL6 : BOOL;
		BOOL7 : BOOL;
		BOOL8 : BOOL;
		BOOL9 : BOOL;
	END_STRUCT;
	CdrFlr_Type : 	STRUCT  (*//RMC275*)
		Alive : BOOL;
		Ready : BOOL; (*Ready*)
		BOOL2 : BOOL;
		BOOL3 : BOOL;
		BOOL4 : BOOL;
		BOOL5 : BOOL;
		BOOL6 : BOOL;
		BOOL7 : BOOL;
		BOOL8 : BOOL;
		BOOL9 : BOOL;
	END_STRUCT;
END_TYPE
