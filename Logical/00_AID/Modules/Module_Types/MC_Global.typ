(*Motion Interface Data Type*)

TYPE
	ST_MotionInterface : 	STRUCT 
		Safety : ST_SafetyInterface;
		Network : ST_NetworkInterface;
	END_STRUCT;
END_TYPE

(*Interfaces*)

TYPE
	ST_SafetyInterface : 	STRUCT  (*Process-Motion safety interface*)
		Filler : ST_FillerSafetyInterface; (*Filler input/output safety interface*)
		Inlet : ST_InletSafetyInterface; (*Inlet input/output safety interface*)
		Outlet : ST_OutletSafetyInterface; (*Outlet input/output safety interface*)
	END_STRUCT;
	ST_NetworkInterface : 	STRUCT  (*Process-Motion network interface*)
		Machine : ST_MachineInterface; (*Machine input output interface*)
		Inlet : ST_InletInterface; (*Inlet input/output interface*)
		Filler : ST_FillerInterface; (*Filler input/output interface*)
		Outlet : ST_OutletInterface; (*Outlet input/output interface*)
	END_STRUCT;
END_TYPE

(*Machine*)

TYPE
	ST_MachineInterface : 	STRUCT  (*Machine input/output interface structure*)
		Commands : ST_MachineCommandsInterface; (*Machine commands structure*)
		Parameters : ST_MachineParametersInterface; (*Machine parameter structure*)
		Status : ST_MachineStatusInterface; (*Machine status structure*)
		Exceptions : ST_MachineExceptionsInterface; (*Machine exception structure*)
	END_STRUCT;
	ST_MachineCommandsInterface : 	STRUCT  (*Machine commands*)
		HandShakeIn : BOOL; (*Not Used on Full B&R Machines.*)
		MachineStart : BOOL; (*Start commands. When this signal falls the machine start a deceleration ramp.*)
		AlarmReset : BOOL; (*Reset motion alarm command.*)
		MachineQuickStop : BOOL; (*Machine quick stop. This signal has to be set to 1 during normal operation. If this signal will fall a quick stop is performed.*)
		SynchroDisengage : BOOL; (*The interfaces between filler machine and other machines. This value is taken in account only if the CFG_MC.Generic.DisengageImmediately is set.*)
		JogPushButton : BOOL; (*Jog Push Button.*)
		DisableRinserAxis : BOOL; (*The selected axis is disabled rotation V4.A.A.1.7.0*)
		DisableSelectedAxis : BOOL; (*The selected axis is disabled. This operation works only in emergency.*)
		BrakeReleaseModalityRequest : BOOL; (*Brake Release modality request on selected axis.*)
		SelectiveHomeModalityRequest : BOOL; (*Home modality request on selected axis / external reference.*)
		AllAxesHomeModalityRequest : BOOL; (*Homing of all axes - Not Implemented yet.*)
		MultiModalityRequest : BOOL; (*Multi modality selected in order to send the command directly to the module.*)
		PositioningModalityRequest : BOOL; (*Positioning Modality Request.*)
		AutoModalityRequest : BOOL; (*Auto (stand alone) Modality Request.*)
		AutoCombiModalityRequest : BOOL; (*Combi modality request. The machine will follow an external reference.*)
		JogMachineModalityRequest : BOOL; (*Jog modality request.*)
		StepByStepSingleAxisRevModReq : BOOL; (*Single Axis Step By Step Reverse modality request V999*)
		StepByStepSingleAxisModReq : BOOL; (*Single Axis Step By Step modality request V4.A.A.1.7.0*)
		StepByStepModalityRequest : BOOL; (*Step By Step modality request.*)
		EndlessModalityRequest : BOOL; (*Endless modality request - not implemented yet.*)
		ThirdPartMotStatSetupModReq : BOOL; (*Third Party Motor Static Modality Request - not implemented yet.*)
		ThirdPartMotDynSetupModReq : BOOL; (*Endless modality request- not implemented yet.*)
		InMotionTimerModReq : BOOL; (*InMotion Timer function request on active axis.*)
		VelocityModalityRequest : BOOL; (*Velocity Modality Request on actis axis.*)
		OkToDisengage : BOOL; (*The interface is free.*)
		CombiSynchroStop : BOOL; (*Combi Synchro Stop. The machine will continue to turn at constant speed.*)
		MasterEncoderPositionValid : BOOL; (*The position of the master encoder is valid. In case of FALSE in combi mode a Quick Stop is performed.*)
		OnePitchShiftCommand : BOOL; (*One Pitch Shift in combi mode for the "One container every two steps" option.*)
		KochModuleReady : BOOL; (*Where present this variable is linked to the Koch module status*)
		FanSeamerFeedback : BOOL;
		FanSeamerOn : BOOL;
		FanSeamerThermalOverload : BOOL;
	END_STRUCT;
	ST_MachineStatusInterface : 	STRUCT  (*Machine status*)
		HandshakeOut : BOOL; (*Not Used on Full B&R Machines.*)
		MachineHomed : BOOL; (*All axis on the machine are homed.*)
		MachineInPosition : BOOL; (*All axis on the machine are in position.*)
		MachineRunning : BOOL; (*At least one axis is running.*)
		MachineSynchro : BOOL; (*The machine is internally synchronized.*)
		MachineStartFbk : BOOL; (*Feedback of the machine start. See timechart for details.*)
		AutoCmdFeedback : BOOL; (*Auto Modality feedback (?)*)
		JogCmdFeedback : BOOL; (*Jog Modality feedback (?)*)
		AxisNoOp : BOOL;
		MachineIE : BOOL; (*Machine Powered.*)
		MachinePowered : BOOL; (*Machine Powered.*)
		ModuleNotInitialized : BOOL; (*Master Module Not Initialized; the master module isn't initialized. PowerOn the module. 1.7.2a*)
		EnableStart : BOOL; (*Enable start . All motion conditions are ready for the rotation.*)
		EnableAuto : BOOL; (*Enable Auto . All motion conditions are verifier in order to enable auto modality.*)
		EnableEndless : BOOL; (*Enable Endless . All condition are verified in order to have the endless modality.*)
		EnableBrakeRelease : BOOL; (*Enable Brake Release . All condition are verified in order to release the brake.*)
		EnablePositioning : BOOL; (*Enable Positioning . All condition are verified in order to make a positioning.*)
		EnableHoming : BOOL; (*Enable Homing . All condition are verified in order to make the homing of an axis.*)
		EnableCombi : BOOL; (*Enable Combi . All condition are verified in order to enable the combi modality.*)
		EnableMulti : BOOL; (*Enable Multi . All condition are verified in order to enable the spliltted modalities.*)
		EnableSlowMotion : BOOL; (*Enable Slow Motion. All condition are verified in order to enable the slow motion.*)
		EnableStepByStep : BOOL; (*Enable StepByStep . All condition are verified in order to enable the step by step modality.*)
		EnableJog : BOOL; (*Enable Jog . All condition are verified in order to enable the jog modality.*)
		EnableInMotionTimer : BOOL; (*Enable InMotion Timer . All condition are verified in order to enable the in motion timer.*)
		EnableAxisEnable : BOOL; (*Enable AxisEnable Button . All condition are verified in order to enable or disable the axis.*)
		EnableVelocity : BOOL; (*Enable Velocity . All condition are verified in order to make a velociy.*)
		ThirdPartMotStatSetupButton : BOOL; (*Enable thirdy party motor setup. All condition are verified in order to enable the third party static motor setup.*)
		ThirdPartMotDynSetupButton : BOOL; (*Enable thirdy party motor setup. All condition are verified in order to enable the third party dinamic motor setup.*)
		InductionMotSetupButton : BOOL; (*Induction motor setup. All condition are verified in order to enable the third party dinamic motor setup.*)
		NoModalityActive : BOOL; (*No modality selected on motion control.*)
		SelectiveHomeModalityActive : BOOL; (*Selective home modality active.*)
		VelocityModalityActive : BOOL; (*Velocity modality active on axis with velocity control.*)
		PositioningModalityActive : BOOL; (*Positioning modality active.*)
		JogModalityActive : BOOL; (*Jog modality active.*)
		BrakeReleaseModalityActive : BOOL; (*Brake release modality active.*)
		StepByStepSingleAxisRevModActive : BOOL; (*Single Axis Step by step Reverse modality active. V999*)
		StepByStepSingleAxisModeActive : BOOL; (*Single Axis Step by step modality active. V4.A.A.1.7.0*)
		StepByStepModalityActive : BOOL; (*Step by step modality active.*)
		EndlessModalityActive : BOOL; (*Endless modality active.*)
		MultiModalityActive : BOOL; (*Multi modality active. All modules are working indipendently.*)
		ThirdPartMotStatSetupModAct : BOOL; (*Third party motor static setup active.*)
		ThirdPartMotDynSetupModAct : BOOL; (*Third party motor dynamic setup active.*)
		InductionMotSetupActive : BOOL; (*Induction motor setup active.*)
		AutoModalityActive : BOOL; (*Auto modality active.*)
		AutoCombiModalityActive : BOOL; (*Auto combi modality active.*)
		CombiSynchroStopDone : BOOL; (*Combi synchro stop done.*)
		CombiSynchronized : BOOL; (*Combi synchron. All axis are syncrhonized with the external reference.*)
		CombiSynchroInProgress : BOOL; (*Combi synchro in progress.*)
		CombiFixedSpeed : BOOL; (*Combi fixed speed. The combi after a request is running in continous motion.*)
		InMotionTimerDone : BOOL; (*The in motion timer movement has beed done.*)
		OnePitchShiftDone : BOOL;
		MachineClockA : BOOL; (*Main machine clock.*)
		MachineClockB : BOOL; (*Main machine clock.*)
		Clock01 : BOOL; (*Clock 1 at disposal.*)
		Clock02 : BOOL; (*Clock 2 at disposal.*)
		Clock03 : BOOL; (*Clock 3 at disposal.*)
		Clock04 : BOOL; (*Clock 4 at disposal.*)
		Clock05 : BOOL; (*Clock 5 at disposal.*)
		Clock06 : BOOL; (*Clock 6 at disposal.*)
		Clock07 : BOOL; (*Clock 7 at disposal.*)
		Clock08 : BOOL; (*Clock 8 at disposal.*)
		Clock09 : BOOL; (*Clock 9 at disposal.*)
		Clock10 : BOOL; (*Clock 10 at disposal.*)
		Clock11 : BOOL; (*Clock 11 at disposal. v999hema*)
		Clock01AdvStep : BOOL; (*Clock 2 at disposal.*)
		Clock02AdvStep : BOOL; (*Clock 2 at disposal.*)
		Clock03AdvStep : BOOL; (*Clock 3 at disposal.*)
		Clock04AdvStep : BOOL; (*Clock 4 at disposal.*)
		Clock05AdvStep : BOOL; (*Clock 5 at disposal.*)
		Clock06AdvStep : BOOL; (*Clock 6 at disposal.*)
		Clock07AdvStep : BOOL; (*Clock 7 at disposal.*)
		Clock08AdvStep : BOOL; (*Clock 8 at disposal.*)
		Clock09AdvStep : BOOL; (*Clock 9 at disposal.*)
		Clock10AdvStep : BOOL; (*Clock 10 at disposal.*)
		Clock11AdvStep : BOOL; (*Clock 11 at disposal. v999hema*)
		AxisSelectedForEndless : INT; (*Axis selected for endlessfeed feedback.*)
		SpeedForAxisSelectedEndless : INT; (*Speed selected for endlessfeed feedback.*)
		ActualSpeed : REAL; (*Machine velocity [bph].*)
		MachineMaxSpeed : REAL; (*Machine Max velocity [bph].*)
		MachinePitch : REAL; (*Machine Pitch [teens of mm].*)
	END_STRUCT;
	ST_MachineParametersInterface : 	STRUCT  (*Machine parameters*)
		AxisSelectedOnHmi : INT; (*Axis Selected On Hmi*)
		StepNumber : INT; (*Number of step for StepByStep movement [n]*)
		ManualVelocity : UINT;
		JogSpeed : REAL; (*Jog velocity [cph]*)
		AutoSpeed : REAL; (*Auto Velocity [cph]*)
		AutoAccelerationTime : REAL; (*Deceleration Time [s]*)
		AutoDecelerationTime : REAL; (*Acceleration Time [s]*)
		OffsetPositioning : REAL; (*Positioning Offset [mm]*)
		OffsetHoming : REAL; (*Homing Offset - not implemented yet*)
		StopPosition : REAL; (*Stop Position [mm]*)
		InMotionTimerValue : REAL; (*In motion timer value [mm]*)
		Cam01OnValue : REAL; (*Cam01 On Value*)
		Cam01OffValue : REAL; (*Cam01 Off Value*)
		Cam01AdvTime : REAL; (*Cam01 Advance Time*)
		Cam01Pulse : USINT; (*Cam01 Pulse number*)
		Cam02OnValue : REAL; (*Cam02 On Value*)
		Cam02OffValue : REAL; (*Cam02 Off Value*)
		Cam02AdvTime : REAL; (*Cam02 Advance Time*)
		Cam02Pulse : USINT; (*Cam02 Pulse number*)
		Cam03OnValue : REAL; (*Cam03 On Value*)
		Cam03OffValue : REAL; (*Cam03 Off Value*)
		Cam03AdvTime : REAL; (*Cam03 Advance Time*)
		Cam03Pulse : USINT; (*Cam03 Pulse number*)
		Cam04OnValue : REAL; (*Cam04 On Value*)
		Cam04OffValue : REAL; (*Cam04 Off Value*)
		Cam04AdvTime : REAL; (*Cam04 Advance Time*)
		Cam04Pulse : USINT; (*Cam04 Pulse number*)
		Cam05OnValue : REAL; (*Cam05 On Value*)
		Cam05OffValue : REAL; (*Cam05 Off Value*)
		Cam05AdvTime : REAL; (*Cam05 Advance Time*)
		Cam05Pulse : USINT; (*Cam05 Pulse number*)
		Cam06OnValue : REAL; (*Cam06 On Value*)
		Cam06OffValue : REAL; (*Cam06 Off Value*)
		Cam06AdvTime : REAL; (*Cam06 Advance Time*)
		Cam06Pulse : USINT; (*Cam06 Pulse number*)
		Cam07OnValue : REAL; (*Cam07 On Value*)
		Cam07OffValue : REAL; (*Cam07 Off Value*)
		Cam07AdvTime : REAL; (*Cam07 Advance Time*)
		Cam07Pulse : USINT; (*Cam07 Pulse number*)
		Cam08OnValue : REAL; (*Cam08 On Value*)
		Cam08OffValue : REAL; (*Cam08 Off Value*)
		Cam08AdvTime : REAL; (*Cam08 Advance Time*)
		Cam08Pulse : USINT; (*Cam08 Pulse number*)
		Cam09OnValue : REAL; (*Cam09 On Value*)
		Cam09OffValue : REAL; (*Cam09 Off Value*)
		Cam09AdvTime : REAL; (*Cam09 Advance Time*)
		Cam09Pulse : USINT; (*Cam09 Pulse number*)
		Cam10OnValue : REAL; (*Cam10 On Value*)
		Cam10OffValue : REAL; (*Cam10 Off Value*)
		Cam10AdvTime : REAL; (*Cam10 Advance Time*)
		Cam10Pulse : USINT; (*Cam10 Pulse number*)
		Cam11OffValue : REAL; (*Cam11 Off Value v999hema*)
		Cam11AdvTime : REAL; (*Cam11 Advance Time*)
		Cam11OnValue : REAL; (*Cam11 On Value*)
		Cam11Pulse : USINT; (*Cam11 Pulse number*)
		AxisSelectedForEndless : INT; (*Axis Selected for EndlessFeed - not implemented yet*)
		SpeedForAxisSelectedEndless : INT; (*Speed For Axis Selected for EndlessFeed - not implemented yet*)
		MachinePitch : REAL; (*Machine Pitch [teens of mm]*)
	END_STRUCT;
	ST_MachineExceptionsInterface : 	STRUCT  (*Machine exceptions*)
		Fault : BOOL; (*Generic motion exception.*)
		TrackErrorDataException : BOOL;
		HmiChecksumException : BOOL; (*Hmi parameter checksum exception. Used in standalone applications.*)
		PowerSupplyLowMachineException : BOOL; (*Power supply voltage too low exception.*)
		DcBusLowMachineException : BOOL; (*DcBus too low exception.*)
		PhaseMonitoringException : BOOL; (*Phase monitoring exception*)
		KochModuleNotReady : BOOL; (*Where is installed the Koch module ins't correctly charged.*)
		FanSeamearFault : BOOL;
		ExcessiveVelocityException : BOOL; (*Excessive velocity exception (not implemented yet).*)
		ExcessiveAccException : BOOL; (*Excessive acceleration exception (not implemented yet).*)
		NoAxisEnabledException : BOOL; (*No axis enable exception (not implemented yet).*)
		HomingException : BOOL; (*Machine not homed exception.*)
		BleederException : BOOL; (*Bleeder exception. A bleeder error has occurred.*)
		NegativeSpeedBlowerException : BOOL; (*The reference has a negative speed.*)
		CombiException : BOOL;
		InitEncoderException : BOOL;
		FaultCamGeneration : BOOL; (*V1.7.2*)
		StopBlowerException : BOOL;
	END_STRUCT;
END_TYPE

(*Inlet module*)

TYPE
	ST_InletInterface : 	STRUCT  (*Inlet module input/output interface structure*)
		Commands : ST_InletCommands; (*Inlet commands structure*)
		Parameters : ST_InletParameters; (*Inlet parameters structure*)
		Status : ST_InletStatus; (*Inlet status structure*)
		Exceptions : ST_InletExceptions; (*Inlet exception structure*)
	END_STRUCT;
	ST_InletCommands : 	STRUCT  (*Inlet module commands*)
		AutoInletModule : BOOL; (*Auto modality request for auto module in multi mode.*)
		JogInletModule : BOOL; (*Jog modality request for auto module in multi mode.*)
		QuickStopInletModule : BOOL; (*Quick stop on Inlet module; quick stop not active signal 1.*)
		StartInletModule : BOOL; (*Start on Inlet module.*)
		JogPushButtonInletModule : BOOL; (*Jog push button for Inlet module.*)
		SlowMotionBackward : BOOL; (*Slow motion backward on Inlet module.*)
		SlowMotionForward : BOOL; (*Slow motion forward on Inlet module.*)
		AbsolutePositionSensor : BOOL;
		VelocityAxisStop : BOOL;
	END_STRUCT;
	ST_InletStatus : 	STRUCT  (*Inlet module parameters*)
		ModuleHomed : BOOL; (*Inlet Module Homed; all axes are homed.*)
		ModuleInPosition : BOOL; (*Inlet Module In Position; all axes are standstill and in position.*)
		ModuleRunning : BOOL; (*Inlet Module Running; at least one axis is not standstill.*)
		ModulePowered : BOOL; (*Inlet Module Powered; Inlet module is enabled from a safety point of view.*)
		EnableAutoModality : BOOL; (*Inlet Module Enable Auto Modality; during machine multi mode all condition are valid for enabling the Auto modality.*)
		EnableJogModality : BOOL; (*Inlet Module Enable Auto Modality; during machine multi mode all condition are valid for enabling the Jog modality.*)
		ModuleJogActive : BOOL; (*Inlet Module Jog Active; the jog modality on the Inlet module is active.*)
		AutoActive : BOOL; (*Inlet Module Auto Active; the auto modality on the Inlet module is active.*)
		SlowMotionActive : BOOL; (*Inlet Module Slow Motion Active; the slow motion on the Inlet module is active.*)
		JogCmdFeedback : BOOL; (*Inlet Module Jog Command Feedback.*)
		AutoCmdFeedback : BOOL; (*Inlet Module Auto Command Feedback.*)
		ModuleNotInitialized : BOOL; (*Inlet Module Not Initialized; the Inlet module isn't initialized. PowerOn the module.*)
		ModuleReal : BOOL; (*Inlet Module Real; at least one axis is real on the Inlet module.*)
		In01Real : BOOL; (*Axis Inlet01 on filler module is real.*)
		In02Real : BOOL; (*Axis Inlet02 on filler module is real.*)
		In03Real : BOOL; (*Axis Inlet03 on filler module is real.*)
		In04Real : BOOL; (*Axis Inlet04 on filler module is real.*)
		In05Real : BOOL; (*Axis Inlet05 on filler module is real.*)
		In06Real : BOOL; (*Axis Inlet06 on filler module is real.*)
		MainAxisReal : BOOL; (*Main axis on filler module is real.*)
		Velocity : REAL; (*Auto speed for Inlet module [bph].*)
		AbsolutePosition : LREAL;
		AbsolutePositionValid : BOOL;
	END_STRUCT;
	ST_InletParameters : 	STRUCT  (*Inlet module exception*)
		AutoSpeedInletModule : REAL; (*Auto speed for inlet module [bph]*)
		AbsolutePositionValveOffset : UINT;
		ConveyorKs : REAL;
		WheelValvesNumber : UINT;
		TorqueError : CFG_InletTorque_Type;
	END_STRUCT;
	ST_InletExceptions : 	STRUCT  (*Inlet module exception*)
		MainAxisTrackException : BOOL; (*Main Axis Inlet module track error exception.*)
		MainAxisHomeException : BOOL; (*Main Axis Inlet module home exception.*)
		MainAxisTorqueException : BOOL; (*Main Axis Inlet module torque exception.*)
		MainAxisDriveException : BOOL; (*Main Axis Inlet module drive exception.*)
		MainAxisTemperatureError : BOOL; (*Main Axis Inlet module temperature exception.*)
		MainAxisSafetyException : BOOL; (*Main Axis Inlet module safety exception.*)
		MainAxisNotInOpException : BOOL; (*Main Axis Inlet module not in operational exception.*)
		Inlet01TrackException : BOOL; (*Inlet01 track error exception.*)
		Inlet01HomeException : BOOL; (*Inlet01 home exception.*)
		Inlet01TorqueException : BOOL; (*Inlet01 torque exception.*)
		Inlet01DriveException : BOOL; (*Inlet01 drive exception.*)
		Inlet01TemperatureError : BOOL; (*Inlet01 temperature exception.*)
		Inlet01SafetyException : BOOL; (*Inlet01 safety exception.*)
		Inlet01NotInOpException : BOOL; (*Inlet01 not in operational exception.*)
		Inlet02TrackException : BOOL; (*Inlet02 track error exception.*)
		Inlet02HomeException : BOOL; (*Inlet02 home exception.*)
		Inlet02TorqueException : BOOL; (*Inlet02 torque exception.*)
		Inlet02DriveException : BOOL; (*Inlet02 drive exception.*)
		Inlet02TemperatureError : BOOL; (*Inlet02 temperature exception.*)
		Inlet02SafetyException : BOOL; (*Inlet02 safety exception.*)
		Inlet02NotInOpException : BOOL; (*Inlet02 not in operational exception.*)
		Inlet03TrackException : BOOL; (*Inlet03 track error exception.*)
		Inlet03HomeException : BOOL; (*Inlet03 home exception.*)
		Inlet03TorqueException : BOOL; (*Inlet03 torque exception.*)
		Inlet03DriveException : BOOL; (*Inlet03 drive exception.*)
		Inlet03TemperatureError : BOOL; (*Inlet03 temperature exception.*)
		Inlet03SafetyException : BOOL; (*Inlet03 safety exception.*)
		Inlet03NotInOpException : BOOL; (*Inlet03 not in operational exception.*)
		Inlet04TrackException : BOOL; (*Inlet04 track error exception.*)
		Inlet04HomeException : BOOL; (*Inlet04 home exception.*)
		Inlet04TorqueException : BOOL; (*Inlet04 torque exception.*)
		Inlet04DriveException : BOOL; (*Inlet04 drive exception.*)
		Inlet04TemperatureError : BOOL; (*Inlet04 temperature exception.*)
		Inlet04SafetyException : BOOL; (*Inlet04 safety exception.*)
		Inlet04NotInOpException : BOOL; (*Inlet04 not in operational exception.*)
		Inlet05TrackException : BOOL; (*Inlet05 track error exception.*)
		Inlet05HomeException : BOOL; (*Inlet05 home exception.*)
		Inlet05TorqueException : BOOL; (*Inlet05 torque exception.*)
		Inlet05DriveException : BOOL; (*Inlet05 drive exception.*)
		Inlet05TemperatureError : BOOL; (*Inlet05 temperature exception.*)
		Inlet05SafetyException : BOOL; (*Inlet05 safety exception.*)
		Inlet05NotInOpException : BOOL; (*Inlet05 not in operational exception.*)
		Inlet06TrackException : BOOL; (*Inlet06 track error exception.*)
		Inlet06HomeException : BOOL; (*Inlet06 home exception.*)
		Inlet06TorqueException : BOOL; (*Inlet06 torque exception.*)
		Inlet06DriveException : BOOL; (*Inlet06 drive exception.*)
		Inlet06TemperatureError : BOOL; (*Inlet06 temperature exception.*)
		Inlet06SafetyException : BOOL; (*Inlet06 safety exception.*)
		Inlet06NotInOpException : BOOL; (*Inlet06 not in operational exception.*)
	END_STRUCT;
END_TYPE

(*Filler module*)

TYPE
	ST_FillerInterface : 	STRUCT  (*Filler module input/output interface structure*)
		Commands : ST_FillerCommands; (*Filler commands structure*)
		Parameters : ST_FillerParameters; (*Filler parameters structure*)
		Status : ST_FillerStatus; (*Filler status structure*)
		Exceptions : ST_FillerExceptions; (*Filler exceptions structure*)
	END_STRUCT;
	ST_FillerCommands : 	STRUCT  (*Filler module commands structure*)
		AutoFillerModule : BOOL; (*Auto modality request for auto module in multi mode.*)
		JogFillerModule : BOOL; (*Jog modality request for auto module in multi mode.*)
		QuickStopFillerModule : BOOL; (*Quick stop on filler module; quick stop not active signal 1.*)
		StartFillerModule : BOOL; (*Start on filler module.*)
		JogPushButtonFillerModule : BOOL; (*Jog push button for filler module.*)
		FillerAbsolutePositionSensor : BOOL;
		MotorDisableIndex : ARRAY[CST_FirstFillerModuleAxis..CST_LastFillerModuleAxis]OF BOOL; (*v999 test*)
		DisableFillerAxis : BOOL; (*v999hema*)
		DisableDoserAxis : BOOL; (*V4.A.A.1.7.0*)
		DisableRinserAxis : BOOL; (*V4.A.A.1.7.0*)
		RinserAbsolutePositionSensor : BOOL;
		CapperAbsolutePositionSensor : BOOL;
		CrownerAbsolutePositionSensor : BOOL;
		DoserAbsolutePositionSensor : BOOL;
		VelocityAxisStop : BOOL;
		StepByStepModalityRequest : BOOL;
	END_STRUCT;
	ST_FillerStatus : 	STRUCT  (*Filler module status structure*)
		ModuleHomed : BOOL; (*Filler Module Homed; all axes are homed.*)
		ModuleInPosition : BOOL; (*Filler Module In Position; all axes are standstill and in position.*)
		ModuleRunning : BOOL; (*Filler Module Running; at least one axis is not standstill.*)
		ModulePowered : BOOL; (*Filler Module Powered; filler module is enabled from a safety point of view.*)
		EnableAutoModality : BOOL; (*Filler Module Enable Auto Modality; during machine multi mode all condition are valid for enabling the Auto modality.*)
		EnableJogModality : BOOL; (*Filler Module Enable Auto Modality; during machine multi mode all condition are valid for enabling the Jog modality.*)
		StepByStepModalityActive : BOOL;
		ModuleJogActive : BOOL; (*Filler Module Jog Active; the jog modality on the filler module is active.*)
		AutoActive : BOOL; (*Filler Module Auto Active; the auto modality on the filler module is active.*)
		SlowMotionActive : BOOL; (*Filler Module Slow Motion Active; the slow motion on the filler module is active.*)
		JogCmdFeedback : BOOL; (*Filler Module Jog Command Feedback.*)
		AutoCmdFeedback : BOOL; (*Filler Module Auto Command Feedback.*)
		ModuleNotInitialized : BOOL; (*Filler Module Not Initialized; the filler module isn't initialized. PowerOn the module.*)
		ModuleReal : BOOL; (*Filler Module Real; at least one axis is real on the filler module.*)
		FillerAbsolutePositionValid : BOOL;
		RinserAbsolutePositionValid : BOOL;
		CapperAbsolutePositionValid : BOOL;
		CrownerAbsolutePositionValid : BOOL;
		DoserAbsolutePositionValid : BOOL;
		AxisDisabledFeedBack : ARRAY[CST_FirstFillerModuleAxis..CST_LastFillerModuleAxis]OF BOOL; (*v999 test*)
		DoserAxisDisabled : BOOL; (*v999hema*)
		FillerAxisDisabled : BOOL; (*v999hema*)
		RinserAxisDisabled : BOOL; (*Rinser axis disable answer V4.A.A.1.7.0*)
		In01Real : BOOL; (*Axis Inlet01 on filler module is real.*)
		In02Real : BOOL; (*Axis Inlet02 on filler module is real.*)
		In03Real : BOOL; (*Axis Inlet03 on filler module is real.*)
		In04Real : BOOL; (*Axis Inlet04 on filler module is real.*)
		In05Real : BOOL; (*Axis Inlet05 on filler module is real.*)
		In06Real : BOOL; (*Axis Inlet06 on filler module is real.*)
		In07Real : BOOL; (*Axis Inlet07 on filler module is real.*)
		In08Real : BOOL; (*Axis Inlet08 on filler module is real.*)
		In09Real : BOOL; (*Axis Inlet09 on filler module is real.*)
		In10Real : BOOL; (*Axis Inlet10 on filler module is real.*)
		CarouselReal : BOOL; (*Axis Carousel on filler module is real.*)
		Out01Real : BOOL; (*Axis Outlet01 on filler module is real.*)
		Out02Real : BOOL; (*Axis Outlet02 on filler module is real.*)
		Out03Real : BOOL; (*Axis Outlet03 on filler module is real.*)
		Out04Real : BOOL; (*Axis Outlet04 on filler module is real.*)
		Out05Real : BOOL; (*Axis Outlet05 on filler module is real.*)
		Out06Real : BOOL; (*Axis Outlet06 on filler module is real.*)
		Velocity : REAL; (*Filler module actual velocity [bph]*)
		FillerAbsolutePosition : LREAL;
		RinserAbsolutePosition : LREAL;
		CapperAbsolutePosition : LREAL;
		CrownerAbsolutePosition : LREAL;
		DoserAbsolutePosition : LREAL;
	END_STRUCT;
	ST_FillerParameters : 	STRUCT  (*Filler module parameters structure*)
		AutoSpeedFillerModule : REAL; (*Auto speed for filler module [bph]*)
		FillerStepsNumber : UINT;
		RinserStepsNumber : UINT;
		CapperStepsNumber : UINT;
		CrownerStepsNumber : UINT;
		DoserStepsNumber : UINT;
		FillerAbsolutePositionOffset : UINT;
		RinserAbsolutePositionOffset : UINT;
		CapperAbsolutePositionOffset : UINT;
		CrownerAbsolutePositionOffset : UINT;
		DoserAbsolutePositionOffset : UINT;
		InletConveyorKs : REAL;
		OutletConveyorKs : REAL;
		StepNumber : INT; (*Number of step for StepByStep movement [n]*)
		TorqueError : CFG_FillerTorque_Type;
	END_STRUCT;
	ST_FillerExceptions : 	STRUCT  (*Filler module exception structure*)
		Inlet01TrackException : BOOL; (*Inlet01 track error exception.*)
		Inlet01HomeException : BOOL; (*Inlet01 home exception.*)
		Inlet01TorqueException : BOOL; (*Inlet01 torque exception.*)
		Inlet01DriveException : BOOL; (*Inlet01 drive exception.*)
		Inlet01TemperatureError : BOOL; (*Inlet01 temperature exception.*)
		Inlet01SafetyException : BOOL; (*Inlet01 safety exception.*)
		Inlet01NotInOpException : BOOL; (*Inlet01 not in operational exception.*)
		Inlet02TrackException : BOOL; (*Inlet02 track error exception.*)
		Inlet02HomeException : BOOL; (*Inlet02 home exception.*)
		Inlet02TorqueException : BOOL; (*Inlet02 torque exception.*)
		Inlet02DriveException : BOOL; (*Inlet02 drive exception.*)
		Inlet02TemperatureError : BOOL; (*Inlet02 temperature exception.*)
		Inlet02SafetyException : BOOL; (*Inlet02 safety exception.*)
		Inlet02NotInOpException : BOOL; (*Inlet02 not in operational exception.*)
		Inlet03TrackException : BOOL; (*Inlet03 track error exception.*)
		Inlet03HomeException : BOOL; (*Inlet03 home exception.*)
		Inlet03TorqueException : BOOL; (*Inlet03 torque exception.*)
		Inlet03DriveException : BOOL; (*Inlet03 drive exception.*)
		Inlet03TemperatureError : BOOL; (*Inlet03 temperature exception.*)
		Inlet03SafetyException : BOOL; (*Inlet03 safety exception.*)
		Inlet03NotInOpException : BOOL; (*Inlet03 not in operational exception.*)
		Inlet04TrackException : BOOL; (*Inlet04 track error exception.*)
		Inlet04HomeException : BOOL; (*Inlet04 home exception.*)
		Inlet04TorqueException : BOOL; (*Inlet04 torque exception.*)
		Inlet04DriveException : BOOL; (*Inlet04 drive exception.*)
		Inlet04TemperatureError : BOOL; (*Inlet04 temperature exception.*)
		Inlet04SafetyException : BOOL; (*Inlet04 safety exception.*)
		Inlet04NotInOpException : BOOL; (*Inlet04 not in operational exception.*)
		Inlet05TrackException : BOOL; (*Inlet05 track error exception.*)
		Inlet05HomeException : BOOL; (*Inlet05 home exception.*)
		Inlet05TorqueException : BOOL; (*Inlet05 torque exception.*)
		Inlet05DriveException : BOOL; (*Inlet05 drive exception.*)
		Inlet05TemperatureError : BOOL; (*Inlet05 temperature exception.*)
		Inlet05SafetyException : BOOL; (*Inlet05 safety exception.*)
		Inlet05NotInOpException : BOOL; (*Inlet05 not in operational exception.*)
		Inlet06TrackException : BOOL; (*Inlet06 track error exception.*)
		Inlet06HomeException : BOOL; (*Inlet06 home exception.*)
		Inlet06TorqueException : BOOL; (*Inlet06 torque exception.*)
		Inlet06DriveException : BOOL; (*Inlet06 drive exception.*)
		Inlet06TemperatureError : BOOL; (*Inlet06 temperature exception.*)
		Inlet06SafetyException : BOOL; (*Inlet06 safety exception.*)
		Inlet06NotInOpException : BOOL; (*Inlet06 not in operational exception.*)
		Inlet07TrackException : BOOL; (*Inlet07 track error exception.*)
		Inlet07HomeException : BOOL; (*Inlet07 home exception.*)
		Inlet07TorqueException : BOOL; (*Inlet07 torque exception.*)
		Inlet07DriveException : BOOL; (*Inlet07 drive exception.*)
		Inlet07TemperatureError : BOOL; (*Inlet07 temperature exception.*)
		Inlet07SafetyException : BOOL; (*Inlet07 safety exception.*)
		Inlet07NotInOpException : BOOL; (*Inlet07 not in operational exception.*)
		Inlet08TrackException : BOOL; (*Inlet08 track error exception.*)
		Inlet08HomeException : BOOL; (*Inlet08 home exception.*)
		Inlet08TorqueException : BOOL; (*Inlet08 torque exception.*)
		Inlet08DriveException : BOOL; (*Inlet08 drive exception.*)
		Inlet08TemperatureError : BOOL; (*Inlet08 temperature exception.*)
		Inlet08SafetyException : BOOL; (*Inlet08 safety exception.*)
		Inlet08NotInOpException : BOOL; (*Inlet08 not in operational exception.*)
		Inlet09TrackException : BOOL; (*Inlet09 track error exception.*)
		Inlet09HomeException : BOOL; (*Inlet09 home exception.*)
		Inlet09TorqueException : BOOL; (*Inlet09 torque exception.*)
		Inlet09DriveException : BOOL; (*Inlet09 drive exception.*)
		Inlet09TemperatureError : BOOL; (*Inlet09 temperature exception.*)
		Inlet09SafetyException : BOOL; (*Inlet09 safety exception.*)
		Inlet09NotInOpException : BOOL; (*Inlet09 not in operational exception.*)
		Inlet10TrackException : BOOL; (*Inlet10 track error exception.*)
		Inlet10HomeException : BOOL; (*Inlet10 home exception.*)
		Inlet10TorqueException : BOOL; (*Inlet10 torque exception.*)
		Inlet10DriveException : BOOL; (*Inlet10 drive exception.*)
		Inlet10TemperatureError : BOOL; (*Inlet10 temperature exception.*)
		Inlet10SafetyException : BOOL; (*Inlet10 safety exception.*)
		Inlet10NotInOpException : BOOL; (*Inlet10 not in operational exception.*)
		CarouselTrackException : BOOL; (*Carousel track error exception.*)
		CarouselHomeException : BOOL; (*Carousel home exception.*)
		CarouselTorqueException : BOOL; (*Carousel torque exception.*)
		CarouselDriveException : BOOL; (*Carousel drive exception.*)
		CarouselTemperatureError : BOOL; (*Carousel temperature exception.*)
		CarouselSafetyException : BOOL; (*Carousel safety exception.*)
		CarouselNotInOpException : BOOL; (*Carousel not in operational exception.*)
		Outlet01TrackException : BOOL; (*Outlet01 track error exception.*)
		Outlet01HomeException : BOOL; (*Outlet01 home exception.*)
		Outlet01TorqueException : BOOL; (*Outlet01 torque exception.*)
		Outlet01DriveException : BOOL; (*Outlet01 drive exception.*)
		Outlet01TemperatureError : BOOL; (*Outlet01 temperature exception.*)
		Outlet01SafetyException : BOOL; (*Outlet01 safety exception.*)
		Outlet01NotInOpException : BOOL; (*Outlet01 not in operational exception.*)
		Outlet02TrackException : BOOL; (*Outlet02 track error exception.*)
		Outlet02HomeException : BOOL; (*Outlet02 home exception.*)
		Outlet02TorqueException : BOOL; (*Outlet02 torque exception.*)
		Outlet02DriveException : BOOL; (*Outlet02 drive exception.*)
		Outlet02TemperatureError : BOOL; (*Outlet02 temperature exception.*)
		Outlet02SafetyException : BOOL; (*Outlet02 safety exception.*)
		Outlet02NotInOpException : BOOL; (*Outlet02 not in operational exception.*)
		Outlet03TrackException : BOOL; (*Outlet03 track error exception.*)
		Outlet03HomeException : BOOL; (*Outlet03 home exception.*)
		Outlet03TorqueException : BOOL; (*Outlet03 torque exception.*)
		Outlet03DriveException : BOOL; (*Outlet03 drive exception.*)
		Outlet03TemperatureError : BOOL; (*Outlet03 temperature exception.*)
		Outlet03SafetyException : BOOL; (*Outlet03 safety exception.*)
		Outlet03NotInOpException : BOOL; (*Outlet03 not in operational exception.*)
		Outlet04TrackException : BOOL; (*Outlet04 track error exception.*)
		Outlet04HomeException : BOOL; (*Outlet04 home exception.*)
		Outlet04TorqueException : BOOL; (*Outlet04 torque exception.*)
		Outlet04DriveException : BOOL; (*Outlet04 drive exception.*)
		Outlet04TemperatureError : BOOL; (*Outlet04 temperature exception.*)
		Outlet04SafetyException : BOOL; (*Outlet04 safety exception.*)
		Outlet04NotInOpException : BOOL; (*Outlet04 not in operational exception.*)
		Outlet05TrackException : BOOL; (*Outlet05 track error exception.*)
		Outlet05HomeException : BOOL; (*Outlet05 home exception.*)
		Outlet05TorqueException : BOOL; (*Outlet05 torque exception.*)
		Outlet05DriveException : BOOL; (*Outlet05 drive exception.*)
		Outlet05TemperatureError : BOOL; (*Outlet05 temperature exception.*)
		Outlet05SafetyException : BOOL; (*Outlet05 safety exception.*)
		Outlet05NotInOpException : BOOL; (*Outlet05 not in operational exception.*)
		Outlet06TrackException : BOOL; (*Outlet06 track error exception.*)
		Outlet06HomeException : BOOL; (*Outlet06 home exception.*)
		Outlet06TorqueException : BOOL; (*Outlet06 torque exception.*)
		Outlet06DriveException : BOOL; (*Outlet06 drive exception.*)
		Outlet06TemperatureError : BOOL; (*Outlet06 temperature exception.*)
		Outlet06SafetyException : BOOL; (*Outlet06 safety exception.*)
		Outlet06NotInOpException : BOOL; (*Outlet06 not in operational exception.*)
	END_STRUCT;
END_TYPE

(*Outlet module*)

TYPE
	ST_OutletInterface : 	STRUCT  (*Outlet module input/output interface structure*)
		Commands : ST_OutletCommands; (*Outlet commands structure*)
		Parameters : ST_OutletParameters; (*Outlet parameters structure*)
		Status : ST_OutletStatus; (*Outlet status structure*)
		Exceptions : ST_OutletExceptions; (*Outlet  exceptions structure*)
	END_STRUCT;
	ST_OutletCommands : 	STRUCT  (*Outlet module commands structure*)
		AutoOutletModule : BOOL; (*Auto modality request for auto module in multi mode.*)
		JogOutletModule : BOOL; (*Jog modality request for auto module in multi mode.*)
		QuickStopOutletModule : BOOL; (*Quick stop on Outlet module; quick stop not active signal 1.*)
		StartOutletModule : BOOL; (*Start on Outlet module.*)
		JogPushButtonOutletModule : BOOL; (*Jog push button for Outlet module.*)
		SlowMotionBackward : BOOL; (*Slow motion backward on Outlet module.*)
		SlowMotionForward : BOOL; (*Slow motion forward on Outlet module.*)
		AbsolutePositionSensor : BOOL;
		VelocityAxisStop : BOOL;
	END_STRUCT;
	ST_OutletStatus : 	STRUCT  (*Outlet module status structure*)
		ModuleHomed : BOOL; (*Outlet Module Homed; all axes are homed.*)
		ModuleInPosition : BOOL; (*Outlet Module In Position; all axes are standstill and in position.*)
		ModuleRunning : BOOL; (*Outlet Module Running; at least one axis is not standstill.*)
		ModulePowered : BOOL; (*Outlet Module Powered; Outlet module is enabled from a safety point of view.*)
		EnableAutoModality : BOOL; (*Outlet Module Enable Auto Modality; during machine multi mode all condition are valid for enabling the Auto modality.*)
		EnableJogModality : BOOL; (*Outlet Module Enable Auto Modality; during machine multi mode all condition are valid for enabling the Jog modality.*)
		ModuleJogActive : BOOL; (*Outlet Module Jog Active; the jog modality on the Outlet module is active.*)
		AutoActive : BOOL; (*Outlet Module Auto Active; the auto modality on the Outlet module is active.*)
		SlowMotionActive : BOOL; (*Outlet Module Slow Motion Active; the slow motion on the Outlet module is active.*)
		JogCmdFeedback : BOOL; (*Outlet Module Jog Command Feedback.*)
		AutoCmdFeedback : BOOL; (*Outlet Module Auto Command Feedback.*)
		ModuleNotInitialized : BOOL; (*Outlet Module Not Initialized; the Outlet module isn't initialized. PowerOn the module.*)
		ModuleReal : BOOL; (*Outlet Module Real; at least one axis is real on the Outlet module.*)
		MainAxisReal : BOOL; (*Main axis on filler module is real.*)
		Out01Real : BOOL; (*Axis Outlet01 on filler module is real.*)
		Out02Real : BOOL; (*Axis Outlet02 on filler module is real.*)
		Out03Real : BOOL; (*Axis Outlet03 on filler module is real.*)
		Out04Real : BOOL; (*Axis Outlet04 on filler module is real.*)
		Out05Real : BOOL; (*Axis Outlet05 on filler module is real.*)
		Out06Real : BOOL; (*Axis Outlet06 on filler module is real.*)
		Velocity : REAL; (*Outlet module actual velocity [bph]*)
		AbsolutePosition : LREAL;
		AbsolutePositionValid : BOOL;
	END_STRUCT;
	ST_OutletParameters : 	STRUCT  (*Outlet module parameters structure*)
		AutoSpeedOutletModule : REAL; (*Auto speed for Outlet module [bph].*)
		AbsolutePositionValveOffset : UINT;
		ConveyorKs : REAL;
		WheelValvesNumber : UINT;
		TorqueError : CFG_FillerTorque_Type;
	END_STRUCT;
	ST_OutletExceptions : 	STRUCT  (*Outlet module exception structure*)
		MainAxisTrackException : BOOL; (*Main Axis Outlet module track error exception.*)
		MainAxisHomeException : BOOL; (*Main Axis Outlet module home exception.*)
		MainAxisTorqueException : BOOL; (*Main Axis Outlet module torque exception.*)
		MainAxisDriveException : BOOL; (*Main Axis Outlet module drive exception.*)
		MainAxisTemperatureError : BOOL; (*Main Axis Outlet module temperature exception.*)
		MainAxisSafetyException : BOOL; (*Main Axis Outlet module safety exception.*)
		MainAxisNotInOpException : BOOL; (*Main Axis Outlet module not in operational exception.*)
		Outlet01TrackException : BOOL; (*Outlet01 track error exception.*)
		Outlet01HomeException : BOOL; (*Outlet01 home exception.*)
		Outlet01TorqueException : BOOL; (*Outlet01 torque exception.*)
		Outlet01DriveException : BOOL; (*Outlet01 drive exception.*)
		Outlet01TemperatureError : BOOL; (*Outlet01 temperature exception.*)
		Outlet01SafetyException : BOOL; (*Outlet01 safety exception.*)
		Outlet01NotInOpException : BOOL; (*Outlet01 not in operational exception.*)
		Outlet02TrackException : BOOL; (*Outlet02 track error exception.*)
		Outlet02HomeException : BOOL; (*Outlet02 home exception.*)
		Outlet02TorqueException : BOOL; (*Outlet02 torque exception.*)
		Outlet02DriveException : BOOL; (*Outlet02 drive exception.*)
		Outlet02TemperatureError : BOOL; (*Outlet02 temperature exception.*)
		Outlet02SafetyException : BOOL; (*Outlet02 safety exception.*)
		Outlet02NotInOpException : BOOL; (*Outlet02 not in operational exception.*)
		Outlet03TrackException : BOOL; (*Outlet03 track error exception.*)
		Outlet03HomeException : BOOL; (*Outlet03 home exception.*)
		Outlet03TorqueException : BOOL; (*Outlet03 torque exception.*)
		Outlet03DriveException : BOOL; (*Outlet03 drive exception.*)
		Outlet03TemperatureError : BOOL; (*Outlet03 temperature exception.*)
		Outlet03SafetyException : BOOL; (*Outlet03 safety exception.*)
		Outlet03NotInOpException : BOOL; (*Outlet03 not in operational exception.*)
		Outlet04TrackException : BOOL; (*Outlet04 track error exception.*)
		Outlet04HomeException : BOOL; (*Outlet04 home exception.*)
		Outlet04TorqueException : BOOL; (*Outlet04 torque exception.*)
		Outlet04DriveException : BOOL; (*Outlet04 drive exception.*)
		Outlet04TemperatureError : BOOL; (*Outlet04 temperature exception.*)
		Outlet04SafetyException : BOOL; (*Outlet04 safety exception.*)
		Outlet04NotInOpException : BOOL; (*Outlet04 not in operational exception.*)
		Outlet05TrackException : BOOL; (*Outlet05 track error exception.*)
		Outlet05HomeException : BOOL; (*Outlet05 home exception.*)
		Outlet05TorqueException : BOOL; (*Outlet05 torque exception.*)
		Outlet05DriveException : BOOL; (*Outlet05 drive exception.*)
		Outlet05TemperatureError : BOOL; (*Outlet05 temperature exception.*)
		Outlet05SafetyException : BOOL; (*Outlet05 safety exception.*)
		Outlet05NotInOpException : BOOL; (*Outlet05 not in operational exception.*)
		Outlet06TrackException : BOOL; (*Outlet06 track error exception.*)
		Outlet06HomeException : BOOL; (*Outlet06 home exception.*)
		Outlet06TorqueException : BOOL; (*Outlet06 torque exception.*)
		Outlet06DriveException : BOOL; (*Outlet06 drive exception.*)
		Outlet06TemperatureError : BOOL; (*Outlet06 temperature exception.*)
		Outlet06SafetyException : BOOL; (*Outlet06 safety exception.*)
		Outlet06NotInOpException : BOOL; (*Outlet06 not in operational exception.*)
	END_STRUCT;
END_TYPE

(*Filler Module Safety Interface*)

TYPE
	ST_FillerSafetyInterface : 	STRUCT  (*Filler module input/output safety interface structure*)
		Commands : ST_FillerSafetyCommands; (*Filler safety commands*)
		Status : ST_FillerSafetyStatus; (*Filler safety status*)
	END_STRUCT;
	ST_FillerSafetyCommands : 	STRUCT  (*Filler safety commands*)
		EnableModule : BOOL; (*Hardware enable of Filler Module*)
		AxesDiag : ARRAY[0..CST_LastFillerModuleAxis]OF ST_AxesDiag; (*Diagnostic datapoints for filler module axes*)
	END_STRUCT;
	ST_FillerSafetyStatus : 	STRUCT  (*Filler safety status*)
		ModulePowered : BOOL; (*Filler Module Powered*)
	END_STRUCT;
END_TYPE

(*Inlet Module Safety Interface*)

TYPE
	ST_InletSafetyInterface : 	STRUCT  (*Inlet module input/output safety interface structure*)
		Commands : ST_InletSafetyCommands; (*Inlet safety commands*)
		Status : ST_InletSafetyStatus; (*Inlet safety status*)
	END_STRUCT;
	ST_InletSafetyCommands : 	STRUCT  (*Inlet safety commands*)
		EnableModule : BOOL; (*Hardware enable of inlet module*)
		AxesDiag : ARRAY[0..CST_LastInletModuleAxis]OF ST_AxesDiag; (*Diagnostic datapoints for filler module axes*)
	END_STRUCT;
	ST_InletSafetyStatus : 	STRUCT  (*Inlet safety status
*)
		ModulePowered : BOOL; (*Inlet Module Powered*)
	END_STRUCT;
END_TYPE

(*Outlet Module Safety Interface*)

TYPE
	ST_OutletSafetyInterface : 	STRUCT  (*Outlet module input/output safety interface structure*)
		Commands : ST_OutletSafetyCommands; (*Outlet safety commands
*)
		Status : ST_OutletSafetyStatus; (*Outlet safety status*)
	END_STRUCT;
	ST_OutletSafetyCommands : 	STRUCT  (*Outlet safety commands
*)
		EnableModule : BOOL; (*Hardware enable of outlet module*)
		AxesDiag : ARRAY[0..CST_LastOutletModuleAxis]OF ST_AxesDiag; (*Diagnostic datapoints for filler module axes*)
	END_STRUCT;
	ST_OutletSafetyStatus : 	STRUCT  (*Outlet safety status*)
		ModulePowered : BOOL; (*Outlet Module Powered*)
	END_STRUCT;
END_TYPE

(*Axes Diag Safety Struct*)

TYPE
	ST_AxesDiag : 	STRUCT  (*Structure to be connected directly to Hardware*)
		DI_SafeModuleOK : BOOL; (*Safe Module OK Digital input*)
		DI_STOActive : BOOL; (*Safe Torque Off functionality is active*)
		DI_STO1Active : BOOL; (*Safe Torque Off 1 Active*)
		DI_SOSActive : BOOL; (*Safe Operating Stop is active*)
		DI_SS1Active : BOOL; (*Safe Stop 1 is active*)
		DI_SS2Active : BOOL; (*Safe Stop 2 is active*)
		DI_SLS1Active : BOOL; (*Safe Limited speed 1*)
		DI_Operational : BOOL; (*Drive in operational state*)
		DI_NotErrENC : BOOL; (*Encoder not in error state*)
		DI_NotErrFUNC : BOOL; (*Drive not in functional error*)
	END_STRUCT;
END_TYPE

(*MOTION*)

TYPE
	MC_Type : 	STRUCT 
		DataOut : MC_DataOut_Type;
	END_STRUCT;
	MC_DataOut_Type : 	STRUCT 
		MachineRunning : BOOL;
		ActualSpeed : REAL;
		MaxSpeed : REAL;
	END_STRUCT;
END_TYPE
