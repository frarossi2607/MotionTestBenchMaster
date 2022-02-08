
TYPE
	FmcFlr_Type : 	STRUCT 
		BotBlockParamFault : BOOL; (*Alarm Bottle Block Parameter Fault in One Filling Card Valve (0 = No Error; 1 = Error)*)
		FixSpeedRequestRecipeDownload : BOOL; (*Information Recipe Download (0 = No Download; 1 = Download)*)
		FixSpeedRequestChecking : BOOL; (*Information Checking Parameters Active (0 = No Active; 1 = Active)*)
		BotBlockPhasing : BOOL; (*Information Bottle Block Phasing Active (0 = No Active; 1 = Active)*)
		BotBlockFillingManualTest : BOOL; (*Information Bottle Block Filling Manual Test Active (0 = No Active; 1 = Active)*)
		BotBlockTestOutputs : BOOL; (*Information Bottle Block Man Test Outputs Active (0 = No Active; 1 = Active)*)
		BotBlockFaultInitPortComm : BOOL; (*Alarm Initialization FMC Port Communication with Filling Valves (0 = No Fault; 1 = Fault)*)
		BotBlockTimeExceptionTask : BOOL; (*Alarm Bottle Block Time Exception FMC Controller Task (0 = No Error; 1 = Error)*)
		BotBlockErrorFillRepetitive : BOOL; (*Alarm Bottle Block Repetitive Error Filling on the Same Valve (0 = No Error; 1 = Error)*)
		BotBlockErrorFillConsecut : BOOL; (*Alarm Bottle Block Consecutive Error Filling on Different Valve (0 = No Error; 1 = Error)*)
		BotBlockErrorTxRepetitive : BOOL; (*Alarm Bottle Block Repetitive TX Error to the Same Valve (0 = No Fault; 1 = Fault)*)
		BotBlockErrorTxConsecut : BOOL; (*Alarm Bottle Block Consecutive TX Error to Different Valve (0 = No Error; 1 = Error)*)
		BotBlockVortexCalibrat : BOOL; (*Information Bottle Block - Vortex Coefficient Calibration Active (0 = No Active; 1 = Active)*)
		BotBlockFVCalibrPosNeed : BOOL; (*Alarm Bottle Block One or More Valves Need Calibration Position (0 = No Fault; 1 = Fault) V4.A.A.1.7.1*)
		BotBlockTargetPositFault : BOOL; (*Alarm Bottle Block One or More Valves Not Reached Target Position (0 = No Fault; 1 = Fault) V4.A.A.1.7.1*)
		BotBlockSpare17 : BOOL; (*Bottle Block - spare Alarm or Information or Message*)
		FillerStopFirmwareUpdating : BOOL; (*Information Filler Stop Firmware Updating Active (0 = No Active; 1 = Active)*)
		FillerStopNodeAddressing : BOOL; (*Information Filler Stop Node Addressing Active (0 = No Active; 1 = Active)*)
		FillerStopFMCTestModeActive : BOOL; (*Information Filler Stop FMC Test Mode Active  (0 = No Active; 1 = Active)*)
		BotStopSpare23 : BOOL; (*Bottle Stop - spare Alarm or Information or Message*)
		BotStopSpare24 : BOOL; (*Bottle Stop - spare Alarm or Information or Message*)
		BotStopSpare25 : BOOL; (*Bottle Stop - spare Alarm or Information or Message*)
		BotStopSpare26 : BOOL; (*Bottle Stop - spare Alarm or Information or Message*)
		BotStopSpare27 : BOOL; (*Bottle Stop - spare Alarm or Information or Message*)
		ErrorReadIpSubnetGateway : BOOL; (*Alarm Fault Reading Actual FMC TCP IP or SUBNET or GATEWAY (0 = No Fault; 1 = Fault)*)
		ErrorSetIpSubnetGateway : BOOL; (*Alarm Fault Setting New FMC TCP IP or SUBNET or GATEWAY (0 = No Fault; 1 = Fault)*)
		ErrorInFileFMCSetting : BOOL; (*Alarm Fault In File "FMCSetting.csv" on Compact Flash FMC(0=No Fault;1=Fault)*)
		ErrorInFileRcpBackup : BOOL; (*Alarm Fault In File "RcpBackupXXXXXXX.csv" on Compact Flash FMC(0=No Fault;1=Fault)*)
		ErrorInFileGetSData : BOOL; (*Alarm Fault In File "GetSData.csv" on Compact Flash FMC(0=No Fault;1=Fault)*)
		ErrorInFileGetIData : BOOL; (*Alarm Fault In File "GetIData.csv" on Compact Flash FMC(0=No Fault;1=Fault)*)
		ErrorClockMaster1 : BOOL; (*Alarm Fault No Clock Master1 Not Correct (0 = No Fault; 1 = Fault)*)
		ErrorClockMaster2 : BOOL; (*Alarm Fault No Clock Master2 Not Correct (0 = No Fault; 1 = Fault)*)
		ErrorClockMasterInverted : BOOL; (*Alarm Fault Clock Master Inverted (0 = No Fault; 1 = Fault)*)
		FaultLoadIOMapAndConfig : BOOL; (*Alarm Failed Loading IOMAP or CONFIG - Please Restart FMC (0 = No Fault; 1 = Fault) V4.A.A.1.7.1*)
		FaultCoilHighTemperature : BOOL; (*Alarm Temperature Coil High in One or More Valves (0 = No Fault; 1 = Fault) V4.A.A.1.7.1*)
		FaultCommDataMatrix : BOOL; (*Alarm Communication with DataMatrix (0 = No Fault; 1 = Fault)*)
		FaultBotBurst : BOOL; (*Alarm One Bottle Burst in Filler (0 = No Fault; 1 = Fault)*)
		FaultBotRepeatBurst : BOOL; (*Alarm Bottle Repetitive Burst on the Same Valve (0 = No Fault; 1 = Fault)*)
		FaultFlowLow : BOOL; (*Alarm Flow Low in One or More Valves (0 = No Fault; 1 = Fault)*)
		FaultTemperatLow : BOOL; (*Alarm Temperature in One or More Valves (0 = No Fault; 1 = Fault)*)
		BatteryFaultFMC : BOOL; (*Information FMC Battery Low or Missing - Replacement Needed (0 = No Fault; 1 = Fault)*)
		OneOrMoreValvesFillByTime : BOOL; (*Information Filling by Time Active on One or More Valves (0 = No Active; 1 = Active)*)
		ErrorModuleINPUT : BOOL; (*Information Error Module INPUT FMC  (0 = No Error; 1 = Error)*)
		ErrorModuleOrSingleOUTPUT : BOOL; (*Information Error Module or Single OUTPUT FMC (0 = No Error; 1 = Error)*)
		ErrorSensorValveN1 : BOOL; (*Information anomaly detection on carousel revlolution sensor*)
		OneOrMoreValvesFillManRcp : BOOL; (*Message One or More Valves Fill with Manual Recipe (0 = No Active; 1 = Active)*)
		CheckParametersRunning : BOOL; (*Information Check Parameters Running (0 = No Run; 1 = Run)*)
		DownloadRecipeRunning : BOOL; (*Information Download Recipe Running (0 = No Run; 1 = Run)*)
		ControlFVBeforeStartCIP : BOOL; (*Information Control FV Before Start CIP (0 = No Active; 1 = Active)*)
		PurgeValvesActive : BOOL; (*Information Purge Valves Active (0 = No Active; 1 = Active)*)
		USBKeyConnectedToFMC : BOOL; (*Message One USB Key is Connect to FMC (0 = No Connected; 1 = Connected)*)
		OneOrMoreValvesDisable : BOOL; (*Message One or more Valves Disable (0 = No Disable; 1 = Disable)*)
		ValvesDisabledNotClean : BOOL; (*Information Valves Disabled Will Not Clean During CIP*)
		SlaveFirmwareDifferVersion : BOOL; (*Message One or More Slave with Diff Firmw Vers(0 = No Different; 1 = Different)*)
		PurgeVolumeActive : BOOL; (*Information Purge Volume Active (0 = No Active; 1 = Active)*)
		PurgeTimeActive : BOOL; (*Information Purge Time Active (0 = No Active; 1 = Active)*)
		VortexAllCalibrDone : BOOL; (*Message Vortex Calibration Done (0=No Done, 1 = Done)*)
		VortexCalibrError : BOOL; (*Information Anomaly on calibration flowmeter FTF201 (0 = No Fault; 1 = Fault)*)
		ErrorModuleCounter : BOOL; (*Information Anomaly on Counter card Mass Flow (0 = No Fault; 1 = Fault)*)
		ErrorMassFlowCalibration : BOOL; (*Information Anomaly Mass Flow FTF201 (0 = No Fault; 1 = Fault)*)
		FaultCurrentLimitExceed : BOOL; (*Alarm Current Exceed Limit In One or More Valves (0 = No Fault; 1 = Fault) V4.A.A.1.7.1*)
		FaultElectronicFusePowerCutOff : BOOL; (*Alarm Elecronic Fuses Cut Off Power In One or More Valves (0 = No Fault; 1 = Fault) V4.A.A.1.7.1*)
		FaultSensorPosition : BOOL; (*Alarm Sensor Position Fault In One or More Valves (0 = No Fault; 1 = Fault) V4.A.A.1.7.1*)
		SpareOutByte077 : BOOL; (*spare Alarm or Information or Message*)
		OutByte080ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte081ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte082ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte083ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte084ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte085ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte086ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte087ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte090ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte091ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte092ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		OutByte093ReservedTCP : BOOL; (*Reserved Recipe Zenon 6.21*)
		SpareOutByte094 : BOOL; (*spare recipe*)
		SpareOutByte095 : BOOL; (*spare recipe*)
		SpareOutByte096 : BOOL; (*spare recipe*)
		RCPChangeDoneACK : BOOL; (*Recipe Change Done ACK for Zenon 7.0 (0 = Not Done; 1 = Done)*)
		OutByte10ReservedTCP : USINT; (*Reserved Recipe Zenon 6.21*)
		OutByte11ReservedTCP : USINT; (*Reserved Recipe Zenon 6.21*)
		SpareOutByte12 : USINT; (*spare signal*)
		SpareOutByte13 : USINT; (*spare signal*)
		SpareOutByte14 : USINT; (*spare signal*)
		SpareOutByte15 : USINT; (*spare signal*)
		OffsetSyncFVActTangInlet : USINT; (*Offset Syncronization FV Actual In Tangent At Inlet Starweel*)
		StepsStartFilling : USINT; (*Tang at Inlet Starweel -> Start Fill in Production*)
		StepsGetData : USINT; (*Tang at Inlet Starweel -> Step Get Data Outlet. At this Step FMC Send signal Filling OK to PLC Filler*)
		StepsGetBurst : USINT; (*Tang at Inlet Starweel -> Step Get Burst. At this Step FMC Send signal Bottle Burst to PLC Filler*)
		StepsExitFillerCam : USINT; (*Tang at Inlet Starweel -> Bottle Exit From Filler Cam*)
		StepsGetBurst2 : USINT; (*Tang at Inlet Starweel -> Step Get Burst2. At this Step FMC Send HW signal Bottle Burst2 to PLC Filler*)
		SpareOutByte22 : USINT; (*spare signal*)
		SpareOutByte23 : USINT; (*spare signal*)
		ModeRunning : BOOL; (*Mode is Running (0 = No Running; 1 = Running)*)
		OutputsManTestActive : BOOL; (*Test Manual Outputs Slave Card Active (0 = No Active; 1 = Active)*)
		FillingManualTestActive : BOOL; (*Filling Manual Test Active (0 = No Active; 1 = Active)*)
		FillingManualRunning : BOOL; (*Filling Manual Running (0 = No Running; 1 = Running)*)
		PhaseDone : BOOL; (*Filler Phase Done (0 = Not Done; 1 = Done)*)
		CheckDone : BOOL; (*Filling Valve Check Done (0 = Not Done; 1 = Done)*)
		RecipeDownloadDone : BOOL; (*Recipe Download Done (0 = Not Done; 1 = Done)*)
		FirmwUpdateActive : BOOL; (*Firmware Update Active (0 = No Active; 1 = Active)*)
		NodeAddressActive : BOOL; (*Node Addressing Active (0 = No Active; 1 = Active)*)
		FVReadyToStartCIP : BOOL; (*FV Ready To Start CIP (0 = Not Ready; 1 = Ready)*)
		RecirculationValvesRun : BOOL; (*Recirculation Valves Run (0 = No Running; 1 = Running)*)
		AliveBit : BOOL; (*Alive Bit Blinking 0.5 Hz (0 = Off; 1 = On)*)
		SpareOutByte254 : BOOL; (*Spare signal*)
		SpareOutByte255 : BOOL; (*Spare signal*)
		SpareOutByte256 : BOOL; (*Spare signal*)
		SpareOutByte257 : BOOL; (*Spare signal*)
		AutoCoeffAdjustDone : BOOL; (*Auto Coefficient Adjustment Done (0 = Not Done; 1 = Done)*)
		SniftBottleLiftDownDone : BOOL; (*Snift Bottle and force lift down req (0 = Not done; 1 = Done)*)
		SequenceRinseRun : BOOL; (*Sequence Rinse Run (0 = No Run; 1 = Run)*)
		SequenceFlushingRun : BOOL; (*Sequence Flushing Run (0 = No Run; 1 = Run)*)
		SequenceDrainRun : BOOL; (*Sequence Drain Run (0 = No Run; 1 = Run)*)
		SequencePrimingRun : BOOL; (*Sequence Priming Run (0 = No Run; 1 = Run)*)
		SpareOutByte266 : BOOL; (*spare signal*)
		VortexCalibrActive : BOOL; (*Vortex Coefficient Calibration Active (0 = No Active; 1 = Active)*)
		FillerOneStepReq : BOOL; (*Filler One Step Req (0 = No Req; 1 = Req)*)
		SpareOutByte271 : BOOL; (*Spare signal*)
		SequenceRinse2Run : BOOL; (*Sequence Rinse2 Run (0 = No Run; 1 = Run)*)
		SequencePurgeRun : BOOL; (*Sequence Purge Run (0 = No Run; 1 = Run)*)
		RcpFlatActive : BOOL; (*Flat recipe Active (0 = No Active; 1 = Active)*)
		SpareOutByte275 : BOOL; (*spare signal*)
		SpareOutByte276 : BOOL; (*spare signal*)
		SpareOutByte277 : BOOL; (*spare signal*)
		ActualFillingSetPoint : UINT; (*Actual Filling SetPoint [ml]*)
		ProductNecessary : UINT; (*Product Necessary [litres] To Fill Bottles Actual in the Carusel*)
		AvgFillingTime : UINT; (*Avarage Filling Time [ms]*)
		ActualFlowrate : UINT; (*Actual Product Flowrate (l/min) * 10*)
		ActualFlowrateRecirc : UINT; (*Actual Product Flowrate Recircul (l/min) * 10*)
		TotFVActualInFilling : USINT; (*Total Number of Filling Valves Actual in Filling*)
		TotFVActualInRecirc : USINT; (*Total Number of Filling Valves Actual in Recirculation*)
		FlushingBottleOpenTimePh0 : UINT; (*Flushing Bottle Open time Phase 0 [ms]*)
		FBT_FVTargetPosition : UINT; (*Filling Valve Target Open Position (FBT calibration) //V4.A.A.1.6.11*)
		AdvanceStepsPresenceInletTang : USINT; (*Advance steps for containers presence at inlet tangency*)
		ValveIndexData : USINT; (*Valve index data*)
		FBT_PressureIndex : USINT; (*Index Pressure used in FBT calibration procedure //V4.A.A.1.6.11*)
		SpareOutByte47 : USINT; (*spare signal*)
		SpareOutByte48 : USINT; (*spare signal*)
		FillerStopToStartCalibrat : BOOL; (*Information Filler Stop to Start Calibration with MassFlow (0 = No Stop; 1 = Stop)*)
		SpareOutByte491 : BOOL; (*spare signal*)
		SpareOutByte492 : BOOL; (*spare signal*)
		SpareOutByte493 : BOOL; (*spare signal*)
		SpareOutByte494 : BOOL; (*spare signal*)
		SpareOutByte495 : BOOL; (*spare signal*)
		SpareOutByte496 : BOOL; (*spare signal*)
		SimulBurstValve1Req : BOOL; (*Container Burst Simulation on valve 1 requested*)
		FillingOK : BOOL; (*Filling OK (0 = Error; 1 = Filling OK)*)
		BottleBurst : BOOL; (*Bottle Burst (1 = Burst; 0 = No Burst)*)
		ValveDisable : BOOL; (*Valve Actual in Get Data position, Disabled (0 = Enable; 1 = Disable)*)
		AutoClock : BOOL; (*Auto Clock Generate From FMC When Filler is Stand Still and StandStillClockPTValue is Different from Zero*)
		ValveDisableWithIndex : BOOL; (*Valve disabled used with Valve index data*)
		SpareOutByte505 : BOOL; (*spare signal*)
		SpareOutByte506 : BOOL; (*spare signal*)
		SpareOutByte507 : BOOL; (*spare signal*)
		ClockValveScroll : USINT; (*Clock N Valve Scroll with Real Clock or AutoClock*)
		FVNextInTangAtInlet : USINT; (*Next FV in Tang at Inlet Starweel *)
		FVActualInTangAtInlet : USINT; (*Actual FV in Tang at Inlet Starweel *)
		FVStartFill : USINT; (*Actual FV at Step Start Fill in Production*)
		FVBurst : USINT; (*Actual FV at Step Burst Verify (Start Washing)*)
		FVBurst2 : USINT; (*Actual FV at Step Burst2 Verify (Start Washing)*)
		FVBottleContactWithSeal : USINT; (*Actual FV at Step Bottle Contact With Seal*)
		FVGetData : USINT; (*Actual FV at Step Get Data*)
		FVExitFillingCam : USINT; (*Actual FV at Step Exit Filling Cam*)
		TankPressureSetra : INT; (*Tank Pressure (Setra Sensor) //V4.A.A.1.6.11*)
		Dba_Sector1ReadyToUp : BOOL; (*spare signal //V4.A.A.1.6.11*)
		Dba_Sector1FaultDown : BOOL;
		Dba_Sector1FaultRotationToCip : BOOL;
		Dba_Sector1FaultRotationToProd : BOOL;
		Dba_ConditionOk : BOOL;
		Dba_Sector2ReadyToUp : BOOL;
		Dba_Sector2FaultDown : BOOL;
		Dba_Sector2FaultRotationToCip : BOOL;
		Dba_Sector2FaultRotationToProd : BOOL;
		Dba_Sector1ManDownDone : BOOL;
		Dba_Sector1ManRotToCipDone : BOOL;
		Dba_Sector1ManRotToProdDone : BOOL;
		Dba_Sector1ManFault : BOOL;
		Dba_Sector2ManDownDone : BOOL;
		Dba_Sector2ManRotToCipDone : BOOL;
		Dba_Sector2ManRotToProdDone : BOOL;
		Dba_Sector2ManFault : BOOL;
	END_STRUCT;
	FlrFmc_Type : 	STRUCT 
		FillerPhaseDone : BOOL; (*Filler Phase Done (0 = Not Done; 1 = Done)*)
		SelectorsEnable : BOOL; (*Selector Enable from External Program (0 = Disable; 1 = Enable)*)
		FillerStandStill : BOOL; (*Filler Stand Still (no moving) (0 = No Still; 1 = Still)*)
		FillerEmpty : BOOL; (*Filler Empty (0 = No Empty; 1 = Empty)*)
		FVPowerAuxiliaryOK : BOOL; (*FV Power Auxiliary OK (0 = Not OK; 1 = OK)*)
		FillerProductReady : BOOL; (*Filler Product Ready to Fill (0 = Not Ready; 1 = Ready) - STOP USED*)
		ManTestEnableOk : BOOL; (*Man Test Enable Ok (0 = No Enable; 1 = Enable)*)
		ManFillButtonStartReq : BOOL; (*Man Fill Start Request from External Button (0 = No Fill; 1 = Fill)*)
		ManFillButtonAbortReq : BOOL; (*Man Fill Abort Request from External Button (0 = No Abort; 1 = Abort)*)
		PurgeValvesReq : BOOL; (*Purge Valves Request (0 = No Active; 1 = Active)*)
		AbortExtReq : BOOL; (*Abort External Request (0 = No Req; 1 = Req)*)
		ResetAlarmReq : BOOL; (*Reset Allarm Request (0 = No Reset; 1 = Reset)*)
		ResetFillingDataExtReq : BOOL; (*Reset Filling Data Ext Request (0 = No Reset; 1 = Reset)*)
		InstrumentMeasurePowerONReq : BOOL; (*Instrument Measure Power ON Request (0 = Off; 1 = On)*)
		RecirculationValveReq : BOOL; (*Recirculation Valve Request (0 = No Req; 1 = Req)*)
		SequenceRinseReq : BOOL; (*Sequence Rinse Request (0 = No Req; 1 = Req)*)
		SequenceFlushingReq : BOOL; (*Sequence Flushing Request (0 = No Req; 1 = Req)*)
		SequenceDrainReq : BOOL; (*Sequence Drain Request (0 = No Req; 1 = Req)*)
		SequencePrimingReq : BOOL; (*Sequence Priming Request (0 = No Req; 1 = Req)*)
		EnableFlowControlReq : BOOL; (*Enable Flow Control (0 = No Req; 1 = Req)*)
		EnableTempControlReq : BOOL; (*Enable Temperature Control (0 = No Req; 1 = Req)*)
		ForceActiveValvesDisableReq : BOOL; (*Force Active All Valves Disable Request (0 = No Req; 1 = Req)*)
		EndProductionReq : BOOL; (*End Production Request (0 = No Req; 1 = Req)*)
		PurgeVolumeReq : BOOL; (*Purge Volume Request (0 = No Req; 1 = Req)*)
		PurgeTimeReq : BOOL; (*Purge Time Request (0 = No Req; 1 = Req)*)
		FVAirPressureOK : BOOL; (*FV Air Pressure OK (0 = Not OK; 1 = OK)*)
		SafetyOK : BOOL; (*Safety OK (0 = Not OK; 1 = OK)*)
		CenteringCupDownReq : BOOL; (*Centering Cup Down Request (0 = No Req; 1 = Req)*)
		AutoClockCIPReq : BOOL; (*Force Using Auto Clock In CIP With Filler In Rotation (0 = No Req; 1 = Req) *)
		SigmaLevelReq : BOOL; (*Sigma Level Req (0 = No Req; 1 = Req)*)
		AutoLevelCalibrationReq : BOOL; (*Auto Level Calibration Req (0 = No Req; 1 = Req)*)
		spare37 : BOOL; (*Spare signal*)
		FillerReadyCalibrVortex : BOOL; (*Filler Ready Calibration Vortex (0 = Not OK; 1 = OK)*)
		FillerOneStepReceived : BOOL; (*Filler One Step Received (0 = Not Received; 1 = Received)*)
		SequenceRinse2Req : BOOL; (*Sequence Rinse2 Request (0 = No Req; 1 = Req)*)
		SequencePurgeReq : BOOL; (*Sequence Purge Request (0 = No Req; 1 = Req)*)
		DisableBurstContrReq : BOOL; (*Disable Burst Control Req (0 = No Req; 1 = Req)*)
		SpareByte04bit5 : BOOL; (*spare signal*)
		RCPActiveEditOnline : BOOL; (*Recipe Active Edit Online for Zenon 7.0 (0 = Not Active; 1 = Active)*)
		RCPChangeDone : BOOL; (*Recipe Change Done for Zenon 7.0 (0 = Not Done; 1 = Done)*)
		SniftBottleLiftDownReq : BOOL; (*Snif bottle lift down request*)
		CenteringCupNoContReq : BOOL; (*Request centering cup with no contact*)
		SpareByte05bit2 : BOOL; (*spare signal*)
		EarlyClockDataMatrix : BOOL; (*Early clock for data matrix*)
		SpareByte05bit4 : BOOL; (*spare signal*)
		SpareByte05bit5 : BOOL; (*spare signal*)
		VortexCalibrationIinhibition : BOOL; (*Vortex calibration procedure inhibition //V4.A.A.1.6.12h*)
		FBT_ReadyForCalibration : BOOL; (*Filler ready for FBT calibration procedure //V4.A.A.1.6.11*)
		SpareByte06bit0ReservedTCP : BOOL; (*Reserved recipe Zenon 6.21*)
		SpareByte06bit1ReservedTCP : BOOL; (*Reserved recipe Zenon 6.21*)
		SpareByte06bit2ReservedTCP : BOOL; (*Reserved recipe Zenon 6.21*)
		SpareByte06bit3ReservedTCP : BOOL; (*Reserved recipe Zenon 6.21*)
		SpareByte06bit4ReservedTCP : BOOL; (*Reserved recipe Zenon 6.21*)
		SpareByte06bit5ReservedTCP : BOOL; (*Reserved recipe Zenon 6.21*)
		SpareByte06bit6ReservedTCP : BOOL; (*Reserved recipe Zenon 6.21*)
		SpareByte06bit7ReservedTCP : BOOL; (*Reserved recipe Zenon 6.21*)
		SpareByte07bit0ReservedTCP : BOOL; (*Reserved recipe Zenon 6.21*)
		SpareByte07bit1 : BOOL; (*spare recipe*)
		SpareByte07bit2 : BOOL; (*spare recipe*)
		SpareByte07bit3 : BOOL; (*spare recipe*)
		SpareByte07bit4 : BOOL; (*spare recipe*)
		BurstFlowDisableReq : BOOL; (*Recipe Max Burst Flow Control Disable Request*)
		AliveBit : BOOL; (*Alive bit*)
		Spare77 : BOOL; (*Spare recipe*)
		SpareByte08ReservedTCP : USINT; (*Reserved recipe Zenon 6.21*)
		SpareByte09ReservedTCP : USINT; (*Reserved recipe Zenon 6.21*)
		SpareByte10ReservedTCP : USINT; (*Reserved recipe Zenon 6.21*)
		SpareByte11ReservedTCP : USINT; (*Reserved recipe Zenon 6.21*)
		SpareByte12ReservedTCP : USINT; (*Reserved for TCP*)
		SpareByte13ReservedTCP : USINT; (*Reserved for TCP*)
		StepsDelayStartValveSector : USINT; (*Steps Delay Start Valve Sector*)
		ValveOutputsConfig : USINT; (*Valve Outputs Config BYTE: bit0 Fast Fill; bit1 Opening; bit2 Slow Fill; bit3 CenterCupD; bit4 Vacuum or Recirculation; bit5 Flushing; bit6 Snift; bit7 CenterCupU*)
		ValveSector : USINT; (*Number of Valves Executing Valve Outputs Config*)
		ModeReq : USINT; (*Filling Valve Mode Request:  0 = Idle; 1 = Operation;  2 = Cip/Rinse*)
		SPPrimingVolume : UINT; (*Filling Set Point for Priming Volume [ml]*)
		TankProductTemperature : UINT; (*Tank Product Temperature [°C] *)
		SPFlowControl : UINT; (*Set Point Flow Control [ml/s]*)
		SPTemperature : UINT; (*Set Point Temperature [°C]*)
		ActFillerSpeed : INT; (*Actual Filler Speed [bott/min/10]*)
		TankPressure : INT; (*Actual Tank Pressure [bar/100]*)
		BottleSize : UINT; (*Actual Recipe Bottle Size in [ml]*)
		StandStillClockPTValue : UINT; (*When Filler is Stand Still Generate Clock with this PT Value [ms]*)
		SetPointLevelAutoCalibr : INT; (*Set Point Level Auto Calibration [-]*)
		INT36ReservedTCP : INT; (*Reserved for TCP*)
		INT38ReservedTCP : INT; (*Reserved for TCP*)
		PrimingChangeLowtoHigh : UINT; (*Priming Change Velocity Low to High [ml]*)
		PrimingChangeHightoLow : UINT; (*Priming Change Velocity High to Low [ml]*)
		StartWashCenteringCupDly : USINT; (*Steps tang inlet -> start wash centercup*)
		StepsLenghtWashCenteringCup : USINT; (*Steps lenght wash centercup*)
		StepDlyStartRecirc : USINT;
		DynamCentCupUpTime : USINT; (*Dynamic Centering Cup Up Time [ms]*)
		SpareByte48 : USINT;
		SpareByte49 : USINT;
		Clock : BOOL; (*Clock from LOCON or Sensor or Motion System (90° with Clock Master1) (0 = No Signal; 1 = Signal)*)
		SensorValveN1 : BOOL; (*Sensor Valve N1 (0 = No Signal; 1 = Signal)*)
		StartFilling : BOOL; (*Start Filling from PLC Filler (0 = No Bottle; 1 = Bottle)*)
		PreClosingBottle : BOOL; (*Pre-Closing Bottle from PLC Filler (0 = No Preclosing; 1 = Preclosing)*)
		BottlePresence : BOOL; (*Bottle Presence One Step Before Position Tangent. Used With Centering Cup (0 = No Bottle; 1 = Bottle)*)
		Sensor1ExtBurst : BOOL; (*Sensor1 External Bottle Burst (0 = Burst; 1 = No Burst)*)
		Sensor2ExtBurst : BOOL; (*Sensor2 External Bottle Burst (0 = Burst; 1 = No Burst)*)
		WashCenteringCupReq : BOOL; (*Wash Centering Cup (0 = No Req; 1 = Req)*)
		SpareByte51 : USINT;
		SpareByte52 : USINT;
		SpareByte53 : USINT;
		DynFlushingBottleOpen : UINT; (*Flushing Bottle Open [ms] in Phase[0]*)
		SpareByte56 : USINT;
		SpareByte57 : USINT;
		SpareByte58 : USINT;
		SpareByte59 : USINT;
		SetPointFillerSpeedReal : REAL; (*Production recipe filler setpoint [cont/h]*)
		ActualFillerSpeedReal : REAL; (*Actual filler speed [cont/h]*)
		FBT_SpInCalibration : INT; (*Pressure SP for FBT calibration procedure [mbar]/4 //V4.A.A.1.6.11*)
		FBT_FlowMassPVinCalibration : REAL; (*Value of Promass flowrate used in calibration procedure [ml/s] //V4.A.A.1.6.11*)
		FBT_MaxFlowrateInRcp : INT; (*Maximum flowrate following pressure in format recipe [ml/s] V4.A.A.1.7.1*)
		SpareByte76 : USINT;
		SpareByte77 : USINT;
		StartFillingByte : USINT; (*Start Filling To Valve In Position Start Fill (78.0: Start filling Pos 78.7: 7 step before Start Filling Pos) v1.7.4*)
		PreClosingBottleByte : USINT; (*Start Filling To Valve In Position Pre Closing (78.0: Pre Closing Pos 78.7: 7 step before Pre Closing Pos) v1.7.4*)
		BottlePresenceByte : USINT; (*Bottle Presence One Step Before Position Tangent (78.0: Bottle Presence One Step Before Position Tangent 78.7: Bottle Presence 8 Step Before Position Tangent) v1.7.4*)
		FastStopIncoming : BOOL; (*Fast Stop Incoming v1.7.4*)
		SpareByte81bit1 : BOOL; (*spare signal*)
		SpareByte81bit2 : BOOL; (*spare signal*)
		SpareByte81bit3 : BOOL; (*spare signal*)
		SpareByte81bit4 : BOOL; (*spare signal*)
		SpareByte81bit5 : BOOL; (*spare signal*)
		SpareByte81bit6 : BOOL; (*spare signal*)
		SpareByte81bit7 : BOOL; (*spare signal*)
		FastStopDeceleration : UINT; (*[ms] v1.7.4*)
		SpareByte83 : USINT;
		Dba_Sector1DownToCip : BOOL;
		Dba_Sector1DownToProd : BOOL;
		Dba_Sector1OnlyRotToCip : BOOL;
		Dba_Sector1OnlyRotToProd : BOOL;
		Dba_Sector2DownToCip : BOOL;
		Dba_Sector2DownToProd : BOOL;
		Dba_Sector2OnlyRotToCip : BOOL;
		Dba_Sector2OnlyRotToProd : BOOL;
		Dba_Sector1TotNr : USINT;
		Dba_Sector1ManEnableReq : BOOL;
		Dba_Sector1ManDownReq : BOOL;
		Dba_Sector1ManRotToCipReq : BOOL;
		Dba_Sector1ManRotToProdReq : BOOL;
		Dba_Sector2ManEnableReq : BOOL;
		Dba_Sector2ManDownReq : BOOL;
		Dba_Sector2ManRotToCipReq : BOOL;
		Dba_Sector2ManRotToProdReq : BOOL;
		SpareByte87 : USINT;
		SpareByte88 : USINT;
		SpareByte89 : USINT;
		SpareByte90 : USINT;
		SpareByte91 : USINT;
		SpareByte92 : USINT;
		SpareByte93 : USINT;
		SpareByte94 : USINT;
		SpareByte95 : USINT;
		SpareByte96 : USINT;
		SpareByte97 : USINT;
		SpareByte98 : USINT;
		SpareByte99 : USINT;
		UnitModeCurrent : USINT; (*UnitModeCurrent*)
		StateCurrent : USINT; (*StateCurrent*)
		CarouselPressure : INT; (*Carousel Pressure [mbar]*)
		ProdProcessed : UDINT; (*Containers entered*)
		MachineRunningHours : UDINT; (*Power On Hours [h]*)
		MachineProducingHours : UDINT; (*Mode cumulative time [s]*)
		MachineRevolutions : UDINT; (*Filler Laps*)
		CarouselAirPressure : INT;
		CentronicsCommandValue : INT;
		CentronicsReturnValue : INT;
		Cip_Counter : UINT; (*V4.A.A.1.6.12h*)
	END_STRUCT;
END_TYPE

(*Filling Valves Control*)

TYPE
	FMC_ValvesControl_Type : 	STRUCT 
		FillingDisabled : BOOL;
	END_STRUCT;
	FMC_DataTo_Type : 	STRUCT  (*v1.63*)
		DataOut : FMC_DataOut_Type; (*v1.63*)
	END_STRUCT;
	FMC_DataOut_Type : 	STRUCT  (*v1.63*)
		FMC_NotReadyToStart : BOOL; (*V4.A.A.1.7.0*)
		FillingValveOk : BOOL; (*v1.63*)
	END_STRUCT;
END_TYPE
