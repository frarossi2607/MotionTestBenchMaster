ACTION MachineInput_Profibus:
	
	//Machine: Reference
	MC_InputOutput.Network.Machine.Parameters.AxisSelectedOnHmi				:= IO_MCRaw.Input.MachineReference[1]	+ (IO_MCRaw.Input.MachineReference[0]	* 16#100);
	MC_InputOutput.Network.Machine.Parameters.OffsetPositioning				:= INT_TO_REAL(IO_MCRaw.Input.MachineReference[3]	+ (IO_MCRaw.Input.MachineReference[2]	* 16#100)) / 10.0;	//v1.2
	MC_InputOutput.Network.Machine.Parameters.OffsetHoming					:= INT_TO_REAL(IO_MCRaw.Input.MachineReference[5]	+ (IO_MCRaw.Input.MachineReference[4]	* 16#100));	//v1.2
	MC_InputOutput.Network.Machine.Parameters.AxisSelectedForEndless		:= IO_MCRaw.Input.MachineReference[7]	+ (IO_MCRaw.Input.MachineReference[6]	* 16#100);
	MC_InputOutput.Network.Machine.Parameters.SpeedForAxisSelectedEndless	:= IO_MCRaw.Input.MachineReference[9]	+ (IO_MCRaw.Input.MachineReference[8]	* 16#100);
	MC_InputOutput.Network.Machine.Parameters.StepNumber					:= IO_MCRaw.Input.MachineReference[11]	+ (IO_MCRaw.Input.MachineReference[10]	* 16#100);
	iTempInt	:= IO_MCRaw.Input.MachineReference[13]	+ (IO_MCRaw.Input.MachineReference[12]	* 16#100);	//v1.2
	memcpy(ADR(iTempInt2), ADR(iTempInt), SIZEOF(iTempInt2));	//v1.2
	MC_InputOutput.Network.Machine.Parameters.InMotionTimerValue			:= INT_TO_REAL(iTempInt2) / 10.0;	//v1.2
	IO_MCRaw.Input.MachineReference[14];
	IO_MCRaw.Input.MachineReference[15];
	IO_MCRaw.Input.MachineReference[16];
	IO_MCRaw.Input.MachineReference[17]; 
	IO_MCRaw.Input.MachineReference[18];
	IO_MCRaw.Input.MachineReference[19];
	MC_InputOutput.Network.Machine.Parameters.JogSpeed						:= INT_TO_REAL(IO_MCRaw.Input.MachineReference[21]	+ (IO_MCRaw.Input.MachineReference[20]	* 16#100)) * 10.0;	//v1.2
	MC_InputOutput.Network.Machine.Parameters.AutoSpeed						:= INT_TO_REAL(IO_MCRaw.Input.MachineReference[23]	+ (IO_MCRaw.Input.MachineReference[22]	* 16#100)) * 10.0;	//v1.2
	MC_InputOutput.Network.Machine.Parameters.AutoAccelerationTime			:= INT_TO_REAL(IO_MCRaw.Input.MachineReference[25]	+ (IO_MCRaw.Input.MachineReference[24]	* 16#100));	//v1.2
	MC_InputOutput.Network.Machine.Parameters.AutoDecelerationTime			:= INT_TO_REAL(IO_MCRaw.Input.MachineReference[27]	+ (IO_MCRaw.Input.MachineReference[26]	* 16#100));	//v1.2
	MC_InputOutput.Network.Machine.Parameters.StopPosition					:= INT_TO_REAL(IO_MCRaw.Input.MachineReference[29]	+ (IO_MCRaw.Input.MachineReference[28]	* 16#100)) / 10.0;	//v1.2
	IO_MCRaw.Input.MachineReference[30];
	IO_MCRaw.Input.MachineReference[31];
	
	//Machine: Command
	MC_InputOutput.Network.Machine.Commands.KochModuleReady					:= IO_KochModuleOk.DI_Input;
	MC_InputOutput.Network.Machine.Commands.HandShakeIn						:= IO_MCRaw.Input.MachineCommand[0].0;
	MC_InputOutput.Network.Machine.Commands.MachineStart					:= IO_MCRaw.Input.MachineCommand[0].1;
	MC_InputOutput.Network.Machine.Commands.AlarmReset						:= IO_MCRaw.Input.MachineCommand[0].2;
	IO_MCRaw.Input.MachineCommand[0].3;
	MC_InputOutput.Network.Machine.Commands.MachineQuickStop				:= IO_MCRaw.Input.MachineCommand[0].4;
	MC_InputOutput.Network.Machine.Commands.JogPushButton					:= IO_MCRaw.Input.MachineCommand[0].5;
	IO_MCRaw.Input.MachineCommand[0].6;
	IO_MCRaw.Input.MachineCommand[0].7;

	IO_MCRaw.Input.MachineCommand[1];
	IO_MCRaw.Input.MachineCommand[2];
	IO_MCRaw.Input.MachineCommand[3];
	
	MC_InputOutput.Network.Machine.Commands.SelectiveHomeModalityRequest	:= IO_MCRaw.Input.MachineCommand[4].0;
	MC_InputOutput.Network.Machine.Commands.MultiModalityRequest			:= IO_MCRaw.Input.MachineCommand[4].1;
	MC_InputOutput.Network.Machine.Commands.PositioningModalityRequest		:= IO_MCRaw.Input.MachineCommand[4].2;
	MC_InputOutput.Network.Machine.Commands.AutoModalityRequest				:= IO_MCRaw.Input.MachineCommand[4].3;
	MC_InputOutput.Network.Machine.Commands.AutoCombiModalityRequest		:= IO_MCRaw.Input.MachineCommand[4].4;
	MC_InputOutput.Network.Machine.Commands.JogMachineModalityRequest		:= IO_MCRaw.Input.MachineCommand[4].5;
	MC_InputOutput.Network.Machine.Commands.BrakeReleaseModalityRequest		:= IO_MCRaw.Input.MachineCommand[4].6;
	MC_InputOutput.Network.Machine.Commands.StepByStepModalityRequest		:= IO_MCRaw.Input.MachineCommand[4].7;

	MC_InputOutput.Network.Machine.Commands.EndlessModalityRequest			:= IO_MCRaw.Input.MachineCommand[5].0;
	IO_MCRaw.Input.MachineCommand[5].1;
	MC_InputOutput.Network.Machine.Commands.ThirdPartMotStatSetupModReq		:= IO_MCRaw.Input.MachineCommand[5].2;
	MC_InputOutput.Network.Machine.Commands.ThirdPartMotDynSetupModReq		:= IO_MCRaw.Input.MachineCommand[5].3;
	MC_InputOutput.Network.Machine.Commands.InMotionTimerModReq				:= IO_MCRaw.Input.MachineCommand[5].4;
	MC_InputOutput.Network.Machine.Commands.VelocityModalityRequest			:= IO_MCRaw.Input.MachineCommand[5].5;
	IO_MCRaw.Input.MachineCommand[5].6;
	IO_MCRaw.Input.MachineCommand[5].7;

	MC_InputOutput.Network.Machine.Commands.CombiSynchroStop				:= IO_MCRaw.Input.MachineCommand[6].0;
	MC_InputOutput.Network.Machine.Commands.OkToDisengage					:= IO_MCRaw.Input.MachineCommand[6].1;
	IO_MCRaw.Input.MachineCommand[6].2;
	IO_MCRaw.Input.MachineCommand[6].3;
	IO_MCRaw.Input.MachineCommand[6].4;
	IO_MCRaw.Input.MachineCommand[6].5;
	IO_MCRaw.Input.MachineCommand[6].6;
	IO_MCRaw.Input.MachineCommand[6].7;
	
	IO_MCRaw.Input.MachineCommand[7];
END_ACTION

ACTION FillerInput_Profibus:
	//Filler Commands & Referance
	MC_InputOutput.Network.Filler.Commands.AutoFillerModule					:= IO_MCRaw.Input.FillerCommandReference[0].0;
	MC_InputOutput.Network.Filler.Commands.JogFillerModule					:= IO_MCRaw.Input.FillerCommandReference[0].1;
	IO_MCRaw.Input.FillerCommandReference[0].2;
	MC_InputOutput.Network.Filler.Commands.QuickStopFillerModule			:= IO_MCRaw.Input.FillerCommandReference[0].3;
	IO_MCRaw.Input.FillerCommandReference[0].4;
	IO_MCRaw.Input.FillerCommandReference[0].5;
	IO_MCRaw.Input.FillerCommandReference[0].6;
	MC_InputOutput.Network.Filler.Commands.FillerAbsolutePositionSensor		:= IO_MCRaw.Input.FillerCommandReference[0].7;

	IO_MCRaw.Input.FillerCommandReference[1].0;
	MC_InputOutput.Network.Filler.Commands.StartFillerModule				:= IO_MCRaw.Input.FillerCommandReference[1].1;
	MC_InputOutput.Network.Filler.Commands.JogPushButtonFillerModule		:= IO_MCRaw.Input.FillerCommandReference[1].2;
	IO_MCRaw.Input.FillerCommandReference[1].3;
	IO_MCRaw.Input.FillerCommandReference[1].4;
	IO_MCRaw.Input.FillerCommandReference[1].5;
	IO_MCRaw.Input.FillerCommandReference[1].6;
	IO_MCRaw.Input.FillerCommandReference[1].7;

	MC_InputOutput.Network.Filler.Parameters.AutoSpeedFillerModule			:= INT_TO_REAL(IO_MCRaw.Input.FillerCommandReference[3]	+ (IO_MCRaw.Input.FillerCommandReference[2] * 16#100)) * 10.0;	//v1.2
	MC_InputOutput.Network.Filler.Parameters.FillerStepsNumber				:= IO_MCRaw.Input.FillerCommandReference[5]	+ (IO_MCRaw.Input.FillerCommandReference[4] * 16#100);
	MC_InputOutput.Network.Filler.Parameters.FillerAbsolutePositionOffset	:= IO_MCRaw.Input.FillerCommandReference[7]	+ (IO_MCRaw.Input.FillerCommandReference[6] * 16#100);
	IO_MCRaw.Input.FillerCommandReference[8];
	IO_MCRaw.Input.FillerCommandReference[9];
	MC_InputOutput.Network.Filler.Parameters.InletConveyorKs					:= INT_TO_REAL(IO_MCRaw.Input.FillerCommandReference[11]	+ (IO_MCRaw.Input.FillerCommandReference[10] * 16#100));	//v1.2
END_ACTION

//ACTION OutletInput_Profibus:
//	//Outlet Commands & Referance
//	MC_InputOutput.Network.Outlet.Commands.AutoOutletModule					:= IO_MCRaw.OutletCommandReference[0].0;
//	MC_InputOutput.Network.Outlet.Commands.JogOutletModule					:= IO_MCRaw.OutletCommandReference[0].1;
//	IO_MCRaw.OutletCommandReference[0].2;
//	MC_InputOutput.Network.Outlet.Commands.QuickStopOutletModule			:= IO_MCRaw.OutletCommandReference[0].3;
//	IO_MCRaw.OutletCommandReference[0].4;
//	IO_MCRaw.OutletCommandReference[0].5;
//	IO_MCRaw.OutletCommandReference[0].6;
//	MC_InputOutput.Network.Outlet.Commands.AbsolutePositionSensor			:= IO_MCRaw.OutletCommandReference[0].7;
//
//	IO_MCRaw.OutletCommandReference[1].0;
//	MC_InputOutput.Network.Outlet.Commands.StartOutletModule				:= IO_MCRaw.OutletCommandReference[1].1;
//	MC_InputOutput.Network.Outlet.Commands.JogPushButtonOutletModule		:= IO_MCRaw.OutletCommandReference[1].2;
//	MC_InputOutput.Network.Outlet.Commands.SlowMotionForward				:= IO_MCRaw.OutletCommandReference[1].3;
//	MC_InputOutput.Network.Outlet.Commands.SlowMotionBackward				:= IO_MCRaw.OutletCommandReference[1].4;
//	IO_MCRaw.OutletCommandReference[1].5;
//	IO_MCRaw.OutletCommandReference[1].6;
//	IO_MCRaw.OutletCommandReference[1].7;
//
//	MC_InputOutput.Network.Outlet.Parameters.AutoSpeedOutletModule			:= (IO_MCRaw.OutletCommandReference[3]	+ (IO_MCRaw.OutletCommandReference[2] * 16#100)) * 10.0;
//	MC_InputOutput.Network.Outlet.Parameters.WheelValvesNumber				:= IO_MCRaw.OutletCommandReference[5]	+ (IO_MCRaw.OutletCommandReference[4] * 16#100);
//	MC_InputOutput.Network.Outlet.Parameters.AbsolutePositionValveOffset	:= IO_MCRaw.OutletCommandReference[7]	+ (IO_MCRaw.OutletCommandReference[6] * 16#100);
//	IO_MCRaw.OutletCommandReference[8];
//	IO_MCRaw.OutletCommandReference[9];
//	MC_InputOutput.Network.Outlet.Parameters.ConveyorKs						:= IO_MCRaw.OutletCommandReference[11]	+ (IO_MCRaw.OutletCommandReference[10] * 16#100);
//END_ACTION

ACTION MachineOutput_Profibus:
	//Machine Exceptions
	IO_MCRaw.Output.MachineAlarm[0].0		:= MC_InputOutput.Network.Machine.Exceptions.Fault;
	IO_MCRaw.Output.MachineAlarm[0].1;
	IO_MCRaw.Output.MachineAlarm[0].2		:= MC_InputOutput.Network.Machine.Exceptions.TrackErrorDataException;
	IO_MCRaw.Output.MachineAlarm[0].3		:= MC_InputOutput.Network.Machine.Exceptions.HmiChecksumException;
	IO_MCRaw.Output.MachineAlarm[0].4		:= MC_InputOutput.Network.Machine.Exceptions.DcBusLowMachineException;
	IO_MCRaw.Output.MachineAlarm[0].5;
	IO_MCRaw.Output.MachineAlarm[0].6;
	IO_MCRaw.Output.MachineAlarm[0].7		:= MC_InputOutput.Network.Machine.Exceptions.ExcessiveVelocityException;

	IO_MCRaw.Output.MachineAlarm[1].0		:= MC_InputOutput.Network.Machine.Exceptions.ExcessiveAccException;
	IO_MCRaw.Output.MachineAlarm[1].1		:= MC_InputOutput.Network.Machine.Exceptions.NoAxisEnabledException;
	IO_MCRaw.Output.MachineAlarm[1].2		:= MC_InputOutput.Network.Machine.Exceptions.HomingException;
	IO_MCRaw.Output.MachineAlarm[1].3		:= MC_InputOutput.Network.Machine.Exceptions.BleederException;
	IO_MCRaw.Output.MachineAlarm[1].4;
	IO_MCRaw.Output.MachineAlarm[1].5		:= MC_InputOutput.Network.Machine.Exceptions.KochModuleNotReady;
	IO_MCRaw.Output.MachineAlarm[1].6		:= MC_InputOutput.Network.Machine.Exceptions.FanSeamearFault;
	IO_MCRaw.Output.MachineAlarm[1].7		:= (IO_CPU.BatteryStatus = 0);

	IO_MCRaw.Output.MachineAlarm[2].0		:= (NOT VAR_SafeLogicStatus.RunSafe AND NOT VAR_SafeLogicStatus.RunDebug) OR VAR_SafeLogicStatus.FailSafe;
	IO_MCRaw.Output.MachineAlarm[2].1		:= VAR_SafeLogicStatus.FirmwareAcknowledge OR VAR_SafeLogicStatus.SafeKeyExchange OR (VAR_SafeLogicStatus.ModuleExchange <> 0);
		
	IO_MCRaw.Output.MachineAlarm[3];
	IO_MCRaw.Output.MachineAlarm[4];
	IO_MCRaw.Output.MachineAlarm[5];
	
	IO_MCRaw.Output.MachineAlarm[6].0		:= MC_InputOutput.Network.Machine.Exceptions.NegativeSpeedBlowerException;
	IO_MCRaw.Output.MachineAlarm[6].1;
	IO_MCRaw.Output.MachineAlarm[6].2;
	IO_MCRaw.Output.MachineAlarm[6].3;
	IO_MCRaw.Output.MachineAlarm[6].4		:= MC_InputOutput.Network.Machine.Exceptions.CombiException;
	IO_MCRaw.Output.MachineAlarm[6].5;
	IO_MCRaw.Output.MachineAlarm[6].6;
	IO_MCRaw.Output.MachineAlarm[6].7;

	IO_MCRaw.Output.MachineAlarm[7].0		:= MC_InputOutput.Network.Machine.Exceptions.InitEncoderException;
	IO_MCRaw.Output.MachineAlarm[7].1		:= MC_InputOutput.Network.Machine.Exceptions.StopBlowerException;
	IO_MCRaw.Output.MachineAlarm[7].2;
	IO_MCRaw.Output.MachineAlarm[7].3;
	IO_MCRaw.Output.MachineAlarm[7].4;
	IO_MCRaw.Output.MachineAlarm[7].5;
	IO_MCRaw.Output.MachineAlarm[7].6;
	IO_MCRaw.Output.MachineAlarm[7].7;

	//Machine Status
	IO_MCRaw.Output.MachineStatus[0].0		:= MC_InputOutput.Network.Machine.Status.MachineHomed;
	IO_MCRaw.Output.MachineStatus[0].1		:= MC_InputOutput.Network.Machine.Status.MachineInPosition;
	IO_MCRaw.Output.MachineStatus[0].2		:= MC_InputOutput.Network.Machine.Status.MachineRunning;
	IO_MCRaw.Output.MachineStatus[0].3		:= MC_InputOutput.Network.Machine.Status.MachineSynchro;
	IO_MCRaw.Output.MachineStatus[0].4;
	IO_MCRaw.Output.MachineStatus[0].5;
	IO_MCRaw.Output.MachineStatus[0].6;
	IO_MCRaw.Output.MachineStatus[0].7		:= MC_InputOutput.Network.Machine.Status.AxisNoOp;

	IO_MCRaw.Output.MachineStatus[1].0		:= AID.DataOut.Blink1Hz;
	IO_MCRaw.Output.MachineStatus[1].1;
	IO_MCRaw.Output.MachineStatus[1].2;
	IO_MCRaw.Output.MachineStatus[1].3;
	IO_MCRaw.Output.MachineStatus[1].4;
	IO_MCRaw.Output.MachineStatus[1].5;
	IO_MCRaw.Output.MachineStatus[1].6		:= MC_InputOutput.Network.Machine.Status.MachineIE;
	IO_MCRaw.Output.MachineStatus[1].7		:= MC_InputOutput.Network.Machine.Status.MachinePowered;

	IO_MCRaw.Output.MachineStatus[2];
	IO_MCRaw.Output.MachineStatus[3];
	
	IO_MCRaw.Output.MachineStatus[4].0;
	IO_MCRaw.Output.MachineStatus[4].1		:= MC_InputOutput.Network.Machine.Status.EnableInMotionTimer;
	IO_MCRaw.Output.MachineStatus[4].2		:= MC_InputOutput.Network.Machine.Status.ThirdPartMotStatSetupButton;
	IO_MCRaw.Output.MachineStatus[4].3		:= MC_InputOutput.Network.Machine.Status.ThirdPartMotDynSetupButton;
	IO_MCRaw.Output.MachineStatus[4].4		:= MC_InputOutput.Network.Machine.Status.EnableSlowMotion;
	IO_MCRaw.Output.MachineStatus[4].5		:= MC_InputOutput.Network.Machine.Status.EnableStepByStep;
	IO_MCRaw.Output.MachineStatus[4].6		:= MC_InputOutput.Network.Machine.Status.EnableStart;
	IO_MCRaw.Output.MachineStatus[4].7		:= MC_InputOutput.Network.Machine.Status.EnableEndless;
	IO_MCRaw.Output.MachineStatus[5].0		:= MC_InputOutput.Network.Machine.Status.EnableBrakeRelease;
	IO_MCRaw.Output.MachineStatus[5].1		:= MC_InputOutput.Network.Machine.Status.EnablePositioning;
	IO_MCRaw.Output.MachineStatus[5].2		:= MC_InputOutput.Network.Machine.Status.EnableHoming;
	IO_MCRaw.Output.MachineStatus[5].3		:= MC_InputOutput.Network.Machine.Status.EnableCombi;
	IO_MCRaw.Output.MachineStatus[5].4		:= MC_InputOutput.Network.Machine.Status.EnableAuto;
	IO_MCRaw.Output.MachineStatus[5].5		:= MC_InputOutput.Network.Machine.Status.EnableMulti;
	IO_MCRaw.Output.MachineStatus[5].6		:= MC_InputOutput.Network.Machine.Status.EnableJog;
	IO_MCRaw.Output.MachineStatus[5].7		:= MC_InputOutput.Network.Machine.Status.EnableAxisEnable;

	IO_MCRaw.Output.MachineStatus[8].0		:= MC_InputOutput.Network.Machine.Status.NoModalityActive;
	IO_MCRaw.Output.MachineStatus[8].1		:= MC_InputOutput.Network.Machine.Status.SelectiveHomeModalityActive;
	IO_MCRaw.Output.MachineStatus[8].2		:= MC_InputOutput.Network.Machine.Status.VelocityModalityActive;
	IO_MCRaw.Output.MachineStatus[8].3		:= MC_InputOutput.Network.Machine.Status.PositioningModalityActive;
	IO_MCRaw.Output.MachineStatus[8].4		:= MC_InputOutput.Network.Machine.Status.AutoModalityActive;
	IO_MCRaw.Output.MachineStatus[8].5		:= MC_InputOutput.Network.Machine.Status.AutoCombiModalityActive;
	IO_MCRaw.Output.MachineStatus[8].6		:= MC_InputOutput.Network.Machine.Status.JogModalityActive;
	IO_MCRaw.Output.MachineStatus[8].7		:= MC_InputOutput.Network.Machine.Status.BrakeReleaseModalityActive;

	IO_MCRaw.Output.MachineStatus[9].0		:= MC_InputOutput.Network.Machine.Status.StepByStepModalityActive;
	IO_MCRaw.Output.MachineStatus[9].1		:= MC_InputOutput.Network.Machine.Status.EndlessModalityActive;
	IO_MCRaw.Output.MachineStatus[9].2		:= MC_InputOutput.Network.Machine.Status.MultiModalityActive;
	IO_MCRaw.Output.MachineStatus[9].3		:= MC_InputOutput.Network.Machine.Status.ThirdPartMotStatSetupModAct;
	IO_MCRaw.Output.MachineStatus[9].4		:= MC_InputOutput.Network.Machine.Status.ThirdPartMotDynSetupModAct;
	IO_MCRaw.Output.MachineStatus[9].5;
	IO_MCRaw.Output.MachineStatus[9].6;
	IO_MCRaw.Output.MachineStatus[9].7;

	IO_MCRaw.Output.MachineStatus[10].0	:= MC_InputOutput.Network.Machine.Status.CombiSynchroStopDone;
	IO_MCRaw.Output.MachineStatus[10].1	:= MC_InputOutput.Network.Machine.Status.CombiSynchronized;
	IO_MCRaw.Output.MachineStatus[10].2;
	IO_MCRaw.Output.MachineStatus[10].3	:= MC_InputOutput.Network.Machine.Status.CombiSynchroInProgress;
	IO_MCRaw.Output.MachineStatus[10].4	:= MC_InputOutput.Network.Machine.Status.CombiFixedSpeed;
	IO_MCRaw.Output.MachineStatus[10].5;
	IO_MCRaw.Output.MachineStatus[10].6;
	IO_MCRaw.Output.MachineStatus[10].7;

	IO_MCRaw.Output.MachineStatus[11].0	:= MC_InputOutput.Network.Machine.Status.InMotionTimerDone;	
	IO_MCRaw.Output.MachineStatus[11].1;
	IO_MCRaw.Output.MachineStatus[11].2;
	IO_MCRaw.Output.MachineStatus[11].3;
	IO_MCRaw.Output.MachineStatus[11].4;
	IO_MCRaw.Output.MachineStatus[11].5;
	IO_MCRaw.Output.MachineStatus[11].6;
	IO_MCRaw.Output.MachineStatus[11].7;
	
	IO_MCRaw.Output.MachineStatus[12]		:= INT_TO_USINT(SHR(CST_MotionVersion,	8));
	IO_MCRaw.Output.MachineStatus[13]		:= INT_TO_USINT(	CST_MotionVersion 	AND 16#FF);
	IO_MCRaw.Output.MachineStatus[14];
	IO_MCRaw.Output.MachineStatus[15];
	
	IO_MCRaw.Output.MachineStatus[16]		:= INT_TO_USINT(SHR(REAL_TO_INT((MC_InputOutput.Network.Machine.Status.ActualSpeed	/ 10.0)),		8));
	IO_MCRaw.Output.MachineStatus[17]		:= INT_TO_USINT(	REAL_TO_INT((MC_InputOutput.Network.Machine.Status.ActualSpeed	/ 10.0)) 		AND 16#FF);
	IO_MCRaw.Output.MachineStatus[18]		:= INT_TO_USINT(SHR(REAL_TO_INT(MC_InputOutput.Network.Machine.Status.MachinePitch),	8));
	IO_MCRaw.Output.MachineStatus[19]		:= INT_TO_USINT(	REAL_TO_INT(MC_InputOutput.Network.Machine.Status.MachinePitch) 	AND 16#FF);
	IO_MCRaw.Output.MachineStatus[20];
	IO_MCRaw.Output.MachineStatus[21];
	
	IO_MCRaw.Output.MachineStatus[22];
	IO_MCRaw.Output.MachineStatus[23];
	IO_MCRaw.Output.MachineStatus[24];
	IO_MCRaw.Output.MachineStatus[25];
	IO_MCRaw.Output.MachineStatus[26];
	IO_MCRaw.Output.MachineStatus[27];

	IO_MCRaw.Output.MachineStatus[28]		:= INT_TO_USINT(SHR(MC_InputOutput.Network.Machine.Status.AxisSelectedForEndless,		8));
	IO_MCRaw.Output.MachineStatus[29]		:= INT_TO_USINT(	MC_InputOutput.Network.Machine.Status.AxisSelectedForEndless		AND 16#FF);
	IO_MCRaw.Output.MachineStatus[30]		:= INT_TO_USINT(SHR(MC_InputOutput.Network.Machine.Status.SpeedForAxisSelectedEndless,	8));
	IO_MCRaw.Output.MachineStatus[31]		:= INT_TO_USINT(	MC_InputOutput.Network.Machine.Status.SpeedForAxisSelectedEndless	AND 16#FF);
END_ACTION

ACTION FillerOutput_Profibus:
	//Filler Alarms
	IO_MCRaw.Output.FillerStatusAlarm[0].0		:= MC_InputOutput.Network.Filler.Exceptions.Inlet01TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[0].1		:= MC_InputOutput.Network.Filler.Exceptions.Inlet01HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[0].2		:= MC_InputOutput.Network.Filler.Exceptions.Inlet01TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[0].3		:= MC_InputOutput.Network.Filler.Exceptions.Inlet01DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[0].4		:= MC_InputOutput.Network.Filler.Exceptions.Inlet01SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[0].5		:= MC_InputOutput.Network.Filler.Exceptions.Inlet01NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[0].6;
	IO_MCRaw.Output.FillerStatusAlarm[0].7;
	IO_MCRaw.Output.FillerStatusAlarm[1].0		:= MC_InputOutput.Network.Filler.Exceptions.Inlet02TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[1].1		:= MC_InputOutput.Network.Filler.Exceptions.Inlet02HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[1].2		:= MC_InputOutput.Network.Filler.Exceptions.Inlet02TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[1].3		:= MC_InputOutput.Network.Filler.Exceptions.Inlet02DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[1].4		:= MC_InputOutput.Network.Filler.Exceptions.Inlet02SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[1].5		:= MC_InputOutput.Network.Filler.Exceptions.Inlet02NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[1].6;
	IO_MCRaw.Output.FillerStatusAlarm[1].7;
	IO_MCRaw.Output.FillerStatusAlarm[2].0		:= MC_InputOutput.Network.Filler.Exceptions.Inlet03TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[2].1		:= MC_InputOutput.Network.Filler.Exceptions.Inlet03HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[2].2		:= MC_InputOutput.Network.Filler.Exceptions.Inlet03TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[2].3		:= MC_InputOutput.Network.Filler.Exceptions.Inlet03DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[2].4		:= MC_InputOutput.Network.Filler.Exceptions.Inlet03SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[2].5		:= MC_InputOutput.Network.Filler.Exceptions.Inlet03NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[2].6;
	IO_MCRaw.Output.FillerStatusAlarm[2].7;
	IO_MCRaw.Output.FillerStatusAlarm[3].0		:= MC_InputOutput.Network.Filler.Exceptions.Inlet04TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[3].1		:= MC_InputOutput.Network.Filler.Exceptions.Inlet04HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[3].2		:= MC_InputOutput.Network.Filler.Exceptions.Inlet04TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[3].3		:= MC_InputOutput.Network.Filler.Exceptions.Inlet04DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[3].4		:= MC_InputOutput.Network.Filler.Exceptions.Inlet04SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[3].5		:= MC_InputOutput.Network.Filler.Exceptions.Inlet04NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[3].6;
	IO_MCRaw.Output.FillerStatusAlarm[3].7;
	IO_MCRaw.Output.FillerStatusAlarm[4].0		:= MC_InputOutput.Network.Filler.Exceptions.Inlet05TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[4].1		:= MC_InputOutput.Network.Filler.Exceptions.Inlet05HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[4].2		:= MC_InputOutput.Network.Filler.Exceptions.Inlet05TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[4].3		:= MC_InputOutput.Network.Filler.Exceptions.Inlet05DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[4].4		:= MC_InputOutput.Network.Filler.Exceptions.Inlet05SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[4].5		:= MC_InputOutput.Network.Filler.Exceptions.Inlet05NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[4].6;
	IO_MCRaw.Output.FillerStatusAlarm[4].7;
	IO_MCRaw.Output.FillerStatusAlarm[5].0		:= MC_InputOutput.Network.Filler.Exceptions.Inlet06TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[5].1		:= MC_InputOutput.Network.Filler.Exceptions.Inlet06HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[5].2		:= MC_InputOutput.Network.Filler.Exceptions.Inlet06TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[5].3		:= MC_InputOutput.Network.Filler.Exceptions.Inlet06DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[5].4		:= MC_InputOutput.Network.Filler.Exceptions.Inlet06SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[5].5		:= MC_InputOutput.Network.Filler.Exceptions.Inlet06NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[5].6;
	IO_MCRaw.Output.FillerStatusAlarm[5].7;
	IO_MCRaw.Output.FillerStatusAlarm[6].0		:= MC_InputOutput.Network.Filler.Exceptions.Inlet07TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[6].1		:= MC_InputOutput.Network.Filler.Exceptions.Inlet07HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[6].2		:= MC_InputOutput.Network.Filler.Exceptions.Inlet07TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[6].3		:= MC_InputOutput.Network.Filler.Exceptions.Inlet07DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[6].4		:= MC_InputOutput.Network.Filler.Exceptions.Inlet07SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[6].5		:= MC_InputOutput.Network.Filler.Exceptions.Inlet07NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[6].6;	
	IO_MCRaw.Output.FillerStatusAlarm[6].7;	
	IO_MCRaw.Output.FillerStatusAlarm[7].0		:= MC_InputOutput.Network.Filler.Exceptions.Inlet08TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[7].1		:= MC_InputOutput.Network.Filler.Exceptions.Inlet08HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[7].2		:= MC_InputOutput.Network.Filler.Exceptions.Inlet08TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[7].3		:= MC_InputOutput.Network.Filler.Exceptions.Inlet08DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[7].4		:= MC_InputOutput.Network.Filler.Exceptions.Inlet08SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[7].5		:= MC_InputOutput.Network.Filler.Exceptions.Inlet08NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[7].6;	
	IO_MCRaw.Output.FillerStatusAlarm[7].7;	
	IO_MCRaw.Output.FillerStatusAlarm[8].0		:= MC_InputOutput.Network.Filler.Exceptions.Inlet09TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[8].1		:= MC_InputOutput.Network.Filler.Exceptions.Inlet09HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[8].2		:= MC_InputOutput.Network.Filler.Exceptions.Inlet09TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[8].3		:= MC_InputOutput.Network.Filler.Exceptions.Inlet09DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[8].4		:= MC_InputOutput.Network.Filler.Exceptions.Inlet09SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[8].5		:= MC_InputOutput.Network.Filler.Exceptions.Inlet09NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[8].6;	
	IO_MCRaw.Output.FillerStatusAlarm[8].7;	
	IO_MCRaw.Output.FillerStatusAlarm[9].0		:= MC_InputOutput.Network.Filler.Exceptions.Inlet10TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[9].1		:= MC_InputOutput.Network.Filler.Exceptions.Inlet10HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[9].2		:= MC_InputOutput.Network.Filler.Exceptions.Inlet10TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[9].3		:= MC_InputOutput.Network.Filler.Exceptions.Inlet10DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[9].4		:= MC_InputOutput.Network.Filler.Exceptions.Inlet10SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[9].5		:= MC_InputOutput.Network.Filler.Exceptions.Inlet10NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[9].6;	
	IO_MCRaw.Output.FillerStatusAlarm[9].7;	
	IO_MCRaw.Output.FillerStatusAlarm[10].0	:= MC_InputOutput.Network.Filler.Exceptions.CarouselTrackException;
	IO_MCRaw.Output.FillerStatusAlarm[10].1	:= MC_InputOutput.Network.Filler.Exceptions.CarouselHomeException;
	IO_MCRaw.Output.FillerStatusAlarm[10].2	:= MC_InputOutput.Network.Filler.Exceptions.CarouselTorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[10].3	:= MC_InputOutput.Network.Filler.Exceptions.CarouselDriveException;
	IO_MCRaw.Output.FillerStatusAlarm[10].4	:= MC_InputOutput.Network.Filler.Exceptions.CarouselSafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[10].5	:= MC_InputOutput.Network.Filler.Exceptions.CarouselNotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[10].6;	
	IO_MCRaw.Output.FillerStatusAlarm[10].7;	
	IO_MCRaw.Output.FillerStatusAlarm[11].0	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[11].1	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[11].2	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[11].3	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[11].4	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[11].5	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[11].6;	
	IO_MCRaw.Output.FillerStatusAlarm[11].7;	
	IO_MCRaw.Output.FillerStatusAlarm[12].0	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[12].1	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[12].2	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[12].3	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[12].4	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[12].5	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[12].6;
	IO_MCRaw.Output.FillerStatusAlarm[12].7;
	IO_MCRaw.Output.FillerStatusAlarm[13].0	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[13].1	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[13].2	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[13].3	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[13].4	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[13].5	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[13].6;
	IO_MCRaw.Output.FillerStatusAlarm[13].7;
	IO_MCRaw.Output.FillerStatusAlarm[14].0	:= MC_InputOutput.Network.Filler.Exceptions.Outlet04TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[14].1	:= MC_InputOutput.Network.Filler.Exceptions.Outlet04HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[14].2	:= MC_InputOutput.Network.Filler.Exceptions.Outlet04TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[14].3	:= MC_InputOutput.Network.Filler.Exceptions.Outlet04DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[14].4	:= MC_InputOutput.Network.Filler.Exceptions.Outlet04SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[14].5	:= MC_InputOutput.Network.Filler.Exceptions.Outlet04NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[14].6;
	IO_MCRaw.Output.FillerStatusAlarm[14].7;
	IO_MCRaw.Output.FillerStatusAlarm[15].0	:= MC_InputOutput.Network.Filler.Exceptions.Outlet05TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[15].1	:= MC_InputOutput.Network.Filler.Exceptions.Outlet05HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[15].2	:= MC_InputOutput.Network.Filler.Exceptions.Outlet05TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[15].3	:= MC_InputOutput.Network.Filler.Exceptions.Outlet05DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[15].4	:= MC_InputOutput.Network.Filler.Exceptions.Outlet05SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[15].5	:= MC_InputOutput.Network.Filler.Exceptions.Outlet05NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[15].6;
	IO_MCRaw.Output.FillerStatusAlarm[15].7;
	IO_MCRaw.Output.FillerStatusAlarm[16].0	:= MC_InputOutput.Network.Filler.Exceptions.Outlet06TrackException;
	IO_MCRaw.Output.FillerStatusAlarm[16].1	:= MC_InputOutput.Network.Filler.Exceptions.Outlet06HomeException;
	IO_MCRaw.Output.FillerStatusAlarm[16].2	:= MC_InputOutput.Network.Filler.Exceptions.Outlet06TorqueException;
	IO_MCRaw.Output.FillerStatusAlarm[16].3	:= MC_InputOutput.Network.Filler.Exceptions.Outlet06DriveException;
	IO_MCRaw.Output.FillerStatusAlarm[16].4	:= MC_InputOutput.Network.Filler.Exceptions.Outlet06SafetyException;
	IO_MCRaw.Output.FillerStatusAlarm[16].5	:= MC_InputOutput.Network.Filler.Exceptions.Outlet06NotInOpException;
	IO_MCRaw.Output.FillerStatusAlarm[16].6;	
	IO_MCRaw.Output.FillerStatusAlarm[16].7;
	IO_MCRaw.Output.FillerStatusAlarm[17];
	IO_MCRaw.Output.FillerStatusAlarm[18];
	IO_MCRaw.Output.FillerStatusAlarm[19];
	IO_MCRaw.Output.FillerStatusAlarm[20];

	IO_MCRaw.Output.FillerStatusAlarm[21].0	:= MC_InputOutput.Network.Filler.Status.ModuleNotInitialized;
	
	//Filler Status
	IO_MCRaw.Output.FillerStatusAlarm[22]	:= INT_TO_USINT(SHR(REAL_TO_INT((MC_InputOutput.Network.Filler.Status.Velocity	/ 10.0)),		8));
	IO_MCRaw.Output.FillerStatusAlarm[23]	:= INT_TO_USINT(	REAL_TO_INT((MC_InputOutput.Network.Filler.Status.Velocity	/ 10.0))	AND 16#FF);

	IO_MCRaw.Output.FillerStatusAlarm[24].0	:= MC_InputOutput.Network.Filler.Status.ModuleHomed;
	IO_MCRaw.Output.FillerStatusAlarm[24].1	:= MC_InputOutput.Network.Filler.Status.ModuleInPosition;
	IO_MCRaw.Output.FillerStatusAlarm[24].2	:= MC_InputOutput.Network.Filler.Status.ModuleRunning;
	IO_MCRaw.Output.FillerStatusAlarm[24].3	:= MC_InputOutput.Network.Filler.Status.ModulePowered;
	IO_MCRaw.Output.FillerStatusAlarm[24].4;
	IO_MCRaw.Output.FillerStatusAlarm[24].5;
	IO_MCRaw.Output.FillerStatusAlarm[24].6	:= MC_InputOutput.Network.Filler.Status.EnableAutoModality;
	IO_MCRaw.Output.FillerStatusAlarm[24].7	:= MC_InputOutput.Network.Filler.Status.EnableJogModality;
	IO_MCRaw.Output.FillerStatusAlarm[25].0	:= MC_InputOutput.Network.Filler.Status.ModuleJogActive;
	IO_MCRaw.Output.FillerStatusAlarm[25].1	:= MC_InputOutput.Network.Filler.Status.AutoActive;
	IO_MCRaw.Output.FillerStatusAlarm[25].2	:= MC_InputOutput.Network.Filler.Status.SlowMotionActive;
	IO_MCRaw.Output.FillerStatusAlarm[25].3;
	IO_MCRaw.Output.FillerStatusAlarm[25].4;
	IO_MCRaw.Output.FillerStatusAlarm[25].5	:= MC_InputOutput.Network.Filler.Status.JogCmdFeedback;
	IO_MCRaw.Output.FillerStatusAlarm[25].6	:= MC_InputOutput.Network.Filler.Status.AutoCmdFeedback;
	IO_MCRaw.Output.FillerStatusAlarm[25].7	:= MC_InputOutput.Network.Filler.Status.ModuleReal;
	IO_MCRaw.Output.FillerStatusAlarm[26];	
	IO_MCRaw.Output.FillerStatusAlarm[27].0	:= MC_InputOutput.Network.Filler.Status.In01Real;
	IO_MCRaw.Output.FillerStatusAlarm[27].1	:= MC_InputOutput.Network.Filler.Status.In02Real;
	IO_MCRaw.Output.FillerStatusAlarm[27].2	:= MC_InputOutput.Network.Filler.Status.In03Real;
	IO_MCRaw.Output.FillerStatusAlarm[27].3	:= MC_InputOutput.Network.Filler.Status.In04Real;
	IO_MCRaw.Output.FillerStatusAlarm[27].4	:= MC_InputOutput.Network.Filler.Status.In05Real;
	IO_MCRaw.Output.FillerStatusAlarm[27].5	:= MC_InputOutput.Network.Filler.Status.In06Real;
	IO_MCRaw.Output.FillerStatusAlarm[27].6	:= MC_InputOutput.Network.Filler.Status.In07Real;
	IO_MCRaw.Output.FillerStatusAlarm[27].7	:= MC_InputOutput.Network.Filler.Status.In08Real;
	IO_MCRaw.Output.FillerStatusAlarm[28].0	:= MC_InputOutput.Network.Filler.Status.In09Real;
	IO_MCRaw.Output.FillerStatusAlarm[28].1	:= MC_InputOutput.Network.Filler.Status.In10Real;
	IO_MCRaw.Output.FillerStatusAlarm[28].2	:= MC_InputOutput.Network.Filler.Status.CarouselReal;
	IO_MCRaw.Output.FillerStatusAlarm[28].3	:= MC_InputOutput.Network.Filler.Status.Out01Real;
	IO_MCRaw.Output.FillerStatusAlarm[28].4	:= MC_InputOutput.Network.Filler.Status.Out02Real;
	IO_MCRaw.Output.FillerStatusAlarm[28].5	:= MC_InputOutput.Network.Filler.Status.Out03Real;
	IO_MCRaw.Output.FillerStatusAlarm[28].6	:= MC_InputOutput.Network.Filler.Status.Out04Real;
	IO_MCRaw.Output.FillerStatusAlarm[28].7	:= MC_InputOutput.Network.Filler.Status.Out05Real;
	IO_MCRaw.Output.FillerStatusAlarm[29].0	:= MC_InputOutput.Network.Filler.Status.Out06Real;
	IO_MCRaw.Output.FillerStatusAlarm[29].1;
	IO_MCRaw.Output.FillerStatusAlarm[29].2;
	IO_MCRaw.Output.FillerStatusAlarm[29].3;
	IO_MCRaw.Output.FillerStatusAlarm[29].4;
	IO_MCRaw.Output.FillerStatusAlarm[29].5;
	IO_MCRaw.Output.FillerStatusAlarm[29].6;
	IO_MCRaw.Output.FillerStatusAlarm[29].7;
END_ACTION

(*//ACTION OutletOutput_Profibus:
//	//Outlet Alarms
//	IO_MCRaw.OutletStatusAlarm[0];	
//	IO_MCRaw.OutletStatusAlarm[1];	
//	IO_MCRaw.OutletStatusAlarm[2];	
//	IO_MCRaw.OutletStatusAlarm[3];	
//	IO_MCRaw.OutletStatusAlarm[4];	
//	IO_MCRaw.OutletStatusAlarm[5];	
//	IO_MCRaw.OutletStatusAlarm[6];	
//	IO_MCRaw.OutletStatusAlarm[7];	
//	IO_MCRaw.OutletStatusAlarm[8];	
//	IO_MCRaw.OutletStatusAlarm[9];	
//	IO_MCRaw.OutletStatusAlarm[10].0	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisTrackException;
//	IO_MCRaw.OutletStatusAlarm[10].1	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisHomeException;
//	IO_MCRaw.OutletStatusAlarm[10].2	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisTorqueException;
//	IO_MCRaw.OutletStatusAlarm[10].3	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisDriveException;
//	IO_MCRaw.OutletStatusAlarm[10].4	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisSafetyException;		
//	IO_MCRaw.OutletStatusAlarm[10].5	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisNotInOpException;		
//	IO_MCRaw.OutletStatusAlarm[10].6;	
//	IO_MCRaw.OutletStatusAlarm[10].7;	
//	IO_MCRaw.OutletStatusAlarm[11].0	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01TrackException;
//	IO_MCRaw.OutletStatusAlarm[11].1	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01HomeException;
//	IO_MCRaw.OutletStatusAlarm[11].2	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01TorqueException;
//	IO_MCRaw.OutletStatusAlarm[11].3	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01DriveException;
//	IO_MCRaw.OutletStatusAlarm[11].4	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01SafetyException;		
//	IO_MCRaw.OutletStatusAlarm[11].5	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01NotInOpException;		
//	IO_MCRaw.OutletStatusAlarm[11].6;	
//	IO_MCRaw.OutletStatusAlarm[11].7;	
//	IO_MCRaw.OutletStatusAlarm[12].0	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet02TrackException;
//	IO_MCRaw.OutletStatusAlarm[12].1	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet02HomeException;
//	IO_MCRaw.OutletStatusAlarm[12].2	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet02TorqueException;
//	IO_MCRaw.OutletStatusAlarm[12].3	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet02DriveException;
//	IO_MCRaw.OutletStatusAlarm[12].4	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet02SafetyException;		
//	IO_MCRaw.OutletStatusAlarm[12].5	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet02NotInOpException;		
//	IO_MCRaw.OutletStatusAlarm[12].6;	
//	IO_MCRaw.OutletStatusAlarm[12].7;	
//	IO_MCRaw.OutletStatusAlarm[13].0	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet03TrackException;
//	IO_MCRaw.OutletStatusAlarm[13].1	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet03HomeException;
//	IO_MCRaw.OutletStatusAlarm[13].2	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet03TorqueException;
//	IO_MCRaw.OutletStatusAlarm[13].3	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet03DriveException;
//	IO_MCRaw.OutletStatusAlarm[13].4	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet03SafetyException;		
//	IO_MCRaw.OutletStatusAlarm[13].5	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet03NotInOpException;		
//	IO_MCRaw.OutletStatusAlarm[13].6;	
//	IO_MCRaw.OutletStatusAlarm[13].7;	
//	IO_MCRaw.OutletStatusAlarm[14].0	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet04TrackException;
//	IO_MCRaw.OutletStatusAlarm[14].1	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet04HomeException;
//	IO_MCRaw.OutletStatusAlarm[14].2	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet04TorqueException;
//	IO_MCRaw.OutletStatusAlarm[14].3	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet04DriveException;
//	IO_MCRaw.OutletStatusAlarm[14].4	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet04SafetyException;		
//	IO_MCRaw.OutletStatusAlarm[14].5	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet04NotInOpException;		
//	IO_MCRaw.OutletStatusAlarm[14].6;	
//	IO_MCRaw.OutletStatusAlarm[14].7;	
//	IO_MCRaw.OutletStatusAlarm[15].0	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet05TrackException;
//	IO_MCRaw.OutletStatusAlarm[15].1	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet05HomeException;
//	IO_MCRaw.OutletStatusAlarm[15].2	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet05TorqueException;
//	IO_MCRaw.OutletStatusAlarm[15].3	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet05DriveException;
//	IO_MCRaw.OutletStatusAlarm[15].4	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet05SafetyException;		
//	IO_MCRaw.OutletStatusAlarm[15].5	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet05NotInOpException;		
//	IO_MCRaw.OutletStatusAlarm[15].6;	
//	IO_MCRaw.OutletStatusAlarm[15].7;	
//	IO_MCRaw.OutletStatusAlarm[16].0	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet06TrackException;
//	IO_MCRaw.OutletStatusAlarm[16].1	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet06HomeException;
//	IO_MCRaw.OutletStatusAlarm[16].2	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet06TorqueException;
//	IO_MCRaw.OutletStatusAlarm[16].3	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet06DriveException;
//	IO_MCRaw.OutletStatusAlarm[16].4	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet06SafetyException;		
//	IO_MCRaw.OutletStatusAlarm[16].5	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet06NotInOpException;		
//	IO_MCRaw.OutletStatusAlarm[16].6;	
//	IO_MCRaw.OutletStatusAlarm[16].7;	
//	IO_MCRaw.OutletStatusAlarm[17];	
//	IO_MCRaw.OutletStatusAlarm[18];	
//	IO_MCRaw.OutletStatusAlarm[19];	
//	IO_MCRaw.OutletStatusAlarm[20];
//
//	IO_MCRaw.OutletStatusAlarm[21].0	:= MC_InputOutput.Network.Outlet.Status.ModuleNotInitialized;
//	
//	//Outlet Status
//	IO_MCRaw.OutletStatusAlarm[22]		:= INT_TO_USINT(SHR(REAL_TO_INT(MC_InputOutput.Network.Outlet.Status.Velocity),		8));
//	IO_MCRaw.OutletStatusAlarm[23]		:= INT_TO_USINT(	REAL_TO_INT(MC_InputOutput.Network.Outlet.Status.Velocity)	AND 16#FF);
//
//	IO_MCRaw.OutletStatusAlarm[24].0	:= MC_InputOutput.Network.Outlet.Status.ModuleHomed;
//	IO_MCRaw.OutletStatusAlarm[24].1	:= MC_InputOutput.Network.Outlet.Status.ModuleInPosition;
//	IO_MCRaw.OutletStatusAlarm[24].2	:= MC_InputOutput.Network.Outlet.Status.ModuleRunning;
//	IO_MCRaw.OutletStatusAlarm[24].3	:= MC_InputOutput.Network.Outlet.Status.ModulePowered;
//	IO_MCRaw.OutletStatusAlarm[24].4;
//	IO_MCRaw.OutletStatusAlarm[24].5; 
//	IO_MCRaw.OutletStatusAlarm[24].6	:= MC_InputOutput.Network.Outlet.Status.EnableAutoModality;
//	IO_MCRaw.OutletStatusAlarm[24].7	:= MC_InputOutput.Network.Outlet.Status.EnableJogModality;
//	IO_MCRaw.OutletStatusAlarm[25].0	:= MC_InputOutput.Network.Outlet.Status.ModuleJogActive;
//	IO_MCRaw.OutletStatusAlarm[25].1	:= MC_InputOutput.Network.Outlet.Status.AutoActive;
//	IO_MCRaw.OutletStatusAlarm[25].2	:= MC_InputOutput.Network.Outlet.Status.SlowMotionActive;
//	IO_MCRaw.OutletStatusAlarm[25].3;
//	IO_MCRaw.OutletStatusAlarm[25].4;
//	IO_MCRaw.OutletStatusAlarm[25].5	:= MC_InputOutput.Network.Outlet.Status.JogCmdFeedback;
//	IO_MCRaw.OutletStatusAlarm[25].6	:= MC_InputOutput.Network.Outlet.Status.AutoCmdFeedback;
//	IO_MCRaw.OutletStatusAlarm[25].7	:= MC_InputOutput.Network.Outlet.Status.ModuleReal;
//
//	IO_MCRaw.OutletStatusAlarm[26];
//	
//	
//	
//	IO_MCRaw.OutletStatusAlarm[27];
//	IO_MCRaw.OutletStatusAlarm[28].0;
//	IO_MCRaw.OutletStatusAlarm[28].1;
//	IO_MCRaw.OutletStatusAlarm[28].2	:= MC_InputOutput.Network.Outlet.Status.MainAxisReal;
//	IO_MCRaw.OutletStatusAlarm[28].3	:= MC_InputOutput.Network.Outlet.Status.Out01Real;
//	IO_MCRaw.OutletStatusAlarm[28].4	:= MC_InputOutput.Network.Outlet.Status.Out02Real;
//	IO_MCRaw.OutletStatusAlarm[28].5	:= MC_InputOutput.Network.Outlet.Status.Out03Real;
//	IO_MCRaw.OutletStatusAlarm[28].6	:= MC_InputOutput.Network.Outlet.Status.Out04Real;
//	IO_MCRaw.OutletStatusAlarm[28].7	:= MC_InputOutput.Network.Outlet.Status.Out05Real;
//	IO_MCRaw.OutletStatusAlarm[29].0	:= MC_InputOutput.Network.Outlet.Status.Out06Real;
//	IO_MCRaw.OutletStatusAlarm[29].1;
//	IO_MCRaw.OutletStatusAlarm[29].2;
//	IO_MCRaw.OutletStatusAlarm[29].3;
//	IO_MCRaw.OutletStatusAlarm[29].4;
//	IO_MCRaw.OutletStatusAlarm[29].5;
//	IO_MCRaw.OutletStatusAlarm[29].6;
//	IO_MCRaw.OutletStatusAlarm[29].7;
//END_ACTION

//ACTION InletInput_Profibus:
//	//Inlet Commands & Referance
//	MC_InputOutput.Network.Inlet.Commands.AutoInletModule				:= IO_MCRaw.InletCommandReference[0].0;
//	MC_InputOutput.Network.Inlet.Commands.JogInletModule				:= IO_MCRaw.InletCommandReference[0].1;
//	IO_MCRaw.InletCommandReference[0].2;
//	MC_InputOutput.Network.Inlet.Commands.QuickStopInletModule			:= IO_MCRaw.InletCommandReference[0].3;
//	IO_MCRaw.InletCommandReference[0].4;
//	IO_MCRaw.InletCommandReference[0].5;
//	IO_MCRaw.InletCommandReference[0].6;
//	MC_InputOutput.Network.Inlet.Commands.AbsolutePositionSensor		:= IO_MCRaw.InletCommandReference[0].7;
//
//	IO_MCRaw.InletCommandReference[1].0;
//	MC_InputOutput.Network.Inlet.Commands.StartInletModule				:= IO_MCRaw.InletCommandReference[1].1;
//	MC_InputOutput.Network.Inlet.Commands.JogPushButtonInletModule		:= IO_MCRaw.InletCommandReference[1].2;
//	MC_InputOutput.Network.Inlet.Commands.SlowMotionForward				:= IO_MCRaw.InletCommandReference[1].3;
//	MC_InputOutput.Network.Inlet.Commands.SlowMotionBackward			:= IO_MCRaw.InletCommandReference[1].4;
//	IO_MCRaw.InletCommandReference[1].5;
//	IO_MCRaw.InletCommandReference[1].6;
//	IO_MCRaw.InletCommandReference[1].7;
//
//	MC_InputOutput.Network.Inlet.Parameters.AutoSpeedInletModule		:= (IO_MCRaw.InletCommandReference[3]	+ (IO_MCRaw.InletCommandReference[2] * 16#100)) * 10.0;
//	MC_InputOutput.Network.Inlet.Parameters.WheelValvesNumber			:= IO_MCRaw.InletCommandReference[5]	+ (IO_MCRaw.InletCommandReference[4] * 16#100);
//	MC_InputOutput.Network.Inlet.Parameters.AbsolutePositionValveOffset	:= IO_MCRaw.InletCommandReference[7]	+ (IO_MCRaw.InletCommandReference[6] * 16#100);
//	IO_MCRaw.InletCommandReference[8];
//	IO_MCRaw.InletCommandReference[9];
//	MC_InputOutput.Network.Inlet.Parameters.ConveyorKs					:= IO_MCRaw.InletCommandReference[11]	+ (IO_MCRaw.InletCommandReference[10] * 16#100);
//END_ACTION

//ACTION InletOutput_Profibus:
//	//Inlet Alarms
//	IO_MCRaw.InletStatusAlarm[0].0		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet01TrackException;
//	IO_MCRaw.InletStatusAlarm[0].1		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet01HomeException;
//	IO_MCRaw.InletStatusAlarm[0].2		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet01TorqueException;
//	IO_MCRaw.InletStatusAlarm[0].3		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet01DriveException;
//	IO_MCRaw.InletStatusAlarm[0].4		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet01SafetyException;
//	IO_MCRaw.InletStatusAlarm[0].5		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet01NotInOpException;
//	IO_MCRaw.InletStatusAlarm[0].6;
//	IO_MCRaw.InletStatusAlarm[0].7;
//	IO_MCRaw.InletStatusAlarm[1].0		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet02TrackException;
//	IO_MCRaw.InletStatusAlarm[1].1		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet02HomeException;
//	IO_MCRaw.InletStatusAlarm[1].2		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet02TorqueException;
//	IO_MCRaw.InletStatusAlarm[1].3		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet02DriveException;
//	IO_MCRaw.InletStatusAlarm[1].4		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet02SafetyException;
//	IO_MCRaw.InletStatusAlarm[1].5		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet02NotInOpException;
//	IO_MCRaw.InletStatusAlarm[1].6;
//	IO_MCRaw.InletStatusAlarm[1].7;
//	IO_MCRaw.InletStatusAlarm[2].0		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet03TrackException;
//	IO_MCRaw.InletStatusAlarm[2].1		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet03HomeException;
//	IO_MCRaw.InletStatusAlarm[2].2		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet03TorqueException;
//	IO_MCRaw.InletStatusAlarm[2].3		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet03DriveException;
//	IO_MCRaw.InletStatusAlarm[2].4		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet03SafetyException;
//	IO_MCRaw.InletStatusAlarm[2].5		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet03NotInOpException;
//	IO_MCRaw.InletStatusAlarm[2].6;
//	IO_MCRaw.InletStatusAlarm[2].7;
//	IO_MCRaw.InletStatusAlarm[3].0		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet04TrackException;
//	IO_MCRaw.InletStatusAlarm[3].1		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet04HomeException;
//	IO_MCRaw.InletStatusAlarm[3].2		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet04TorqueException;
//	IO_MCRaw.InletStatusAlarm[3].3		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet04DriveException;
//	IO_MCRaw.InletStatusAlarm[3].4		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet04SafetyException;
//	IO_MCRaw.InletStatusAlarm[3].5		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet04NotInOpException;
//	IO_MCRaw.InletStatusAlarm[3].6;
//	IO_MCRaw.InletStatusAlarm[3].7;
//	IO_MCRaw.InletStatusAlarm[4].0		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet05TrackException;
//	IO_MCRaw.InletStatusAlarm[4].1		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet05HomeException;
//	IO_MCRaw.InletStatusAlarm[4].2		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet05TorqueException;
//	IO_MCRaw.InletStatusAlarm[4].3		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet05DriveException;
//	IO_MCRaw.InletStatusAlarm[4].4		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet05SafetyException;
//	IO_MCRaw.InletStatusAlarm[4].5		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet05NotInOpException;
//	IO_MCRaw.InletStatusAlarm[4].6;
//	IO_MCRaw.InletStatusAlarm[4].7;
//	IO_MCRaw.InletStatusAlarm[5].0		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet06TrackException;
//	IO_MCRaw.InletStatusAlarm[5].1		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet06HomeException;
//	IO_MCRaw.InletStatusAlarm[5].2		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet06TorqueException;
//	IO_MCRaw.InletStatusAlarm[5].3		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet06DriveException;
//	IO_MCRaw.InletStatusAlarm[5].4		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet06SafetyException;
//	IO_MCRaw.InletStatusAlarm[5].5		:= MC_InputOutput.Network.Inlet.Exceptions.Inlet06NotInOpException;
//	IO_MCRaw.InletStatusAlarm[5].6;
//	IO_MCRaw.InletStatusAlarm[5].7;	
//	IO_MCRaw.InletStatusAlarm[6];	
//	IO_MCRaw.InletStatusAlarm[7];	
//	IO_MCRaw.InletStatusAlarm[8];	
//	IO_MCRaw.InletStatusAlarm[9];	
//	IO_MCRaw.InletStatusAlarm[10].0	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisTrackException;
//	IO_MCRaw.InletStatusAlarm[10].1	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisHomeException;
//	IO_MCRaw.InletStatusAlarm[10].2	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisTorqueException;
//	IO_MCRaw.InletStatusAlarm[10].3	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisDriveException;
//	IO_MCRaw.InletStatusAlarm[10].4	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisSafetyException;		
//	IO_MCRaw.InletStatusAlarm[10].5	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisNotInOpException;		
//	IO_MCRaw.InletStatusAlarm[10].6;	
//	IO_MCRaw.InletStatusAlarm[10].7;	
//	IO_MCRaw.InletStatusAlarm[11];	
//	IO_MCRaw.InletStatusAlarm[12];	
//	IO_MCRaw.InletStatusAlarm[13];	
//	IO_MCRaw.InletStatusAlarm[14];	
//	IO_MCRaw.InletStatusAlarm[15];	
//	IO_MCRaw.InletStatusAlarm[16];	
//	IO_MCRaw.InletStatusAlarm[17];	
//	IO_MCRaw.InletStatusAlarm[18];	
//	IO_MCRaw.InletStatusAlarm[19];	
//	IO_MCRaw.InletStatusAlarm[20];
//
//	IO_MCRaw.InletStatusAlarm[21].0	:= MC_InputOutput.Network.Inlet.Status.ModuleNotInitialized;
//	
//	//Inlet Status
//	IO_MCRaw.InletStatusAlarm[22]	:= INT_TO_USINT(SHR(REAL_TO_INT((MC_InputOutput.Network.Inlet.Status.Velocity	/ 10.0)),		8));
//	IO_MCRaw.InletStatusAlarm[23]	:= INT_TO_USINT(	REAL_TO_INT((MC_InputOutput.Network.Inlet.Status.Velocity	/ 10.0))	AND 16#FF);
//
//	IO_MCRaw.InletStatusAlarm[24].0	:= MC_InputOutput.Network.Inlet.Status.ModuleHomed;
//	IO_MCRaw.InletStatusAlarm[24].1	:= MC_InputOutput.Network.Inlet.Status.ModuleInPosition;
//	IO_MCRaw.InletStatusAlarm[24].2	:= MC_InputOutput.Network.Inlet.Status.ModuleRunning;
//	IO_MCRaw.InletStatusAlarm[24].3	:= MC_InputOutput.Network.Inlet.Status.ModulePowered;
//	IO_MCRaw.InletStatusAlarm[24].4;
//	IO_MCRaw.InletStatusAlarm[24].5; 
//	IO_MCRaw.InletStatusAlarm[24].6	:= MC_InputOutput.Network.Inlet.Status.EnableAutoModality;
//	IO_MCRaw.InletStatusAlarm[24].7	:= MC_InputOutput.Network.Inlet.Status.EnableJogModality;
//	IO_MCRaw.InletStatusAlarm[25].0	:= MC_InputOutput.Network.Inlet.Status.ModuleJogActive;
//	IO_MCRaw.InletStatusAlarm[25].1	:= MC_InputOutput.Network.Inlet.Status.AutoActive;
//	IO_MCRaw.InletStatusAlarm[25].2	:= MC_InputOutput.Network.Inlet.Status.SlowMotionActive;
//	IO_MCRaw.InletStatusAlarm[25].3;
//	IO_MCRaw.InletStatusAlarm[25].4;
//	IO_MCRaw.InletStatusAlarm[25].5	:= MC_InputOutput.Network.Inlet.Status.JogCmdFeedback;
//	IO_MCRaw.InletStatusAlarm[25].6	:= MC_InputOutput.Network.Inlet.Status.AutoCmdFeedback;
//	IO_MCRaw.InletStatusAlarm[25].7	:= MC_InputOutput.Network.Inlet.Status.ModuleReal;
//
//	IO_MCRaw.InletStatusAlarm[26];
//	
//	IO_MCRaw.InletStatusAlarm[27].0	:= MC_InputOutput.Network.Inlet.Status.In01Real;
//	IO_MCRaw.InletStatusAlarm[27].1	:= MC_InputOutput.Network.Inlet.Status.In02Real;
//	IO_MCRaw.InletStatusAlarm[27].2	:= MC_InputOutput.Network.Inlet.Status.In03Real;
//	IO_MCRaw.InletStatusAlarm[27].3	:= MC_InputOutput.Network.Inlet.Status.In04Real;
//	IO_MCRaw.InletStatusAlarm[27].4	:= MC_InputOutput.Network.Inlet.Status.In05Real;
//	IO_MCRaw.InletStatusAlarm[27].5	:= MC_InputOutput.Network.Inlet.Status.In06Real;
//	IO_MCRaw.InletStatusAlarm[27].6;
//	IO_MCRaw.InletStatusAlarm[27].7;
//	IO_MCRaw.InletStatusAlarm[28].0;
//	IO_MCRaw.InletStatusAlarm[28].1;
//	IO_MCRaw.InletStatusAlarm[28].2	:= MC_InputOutput.Network.Inlet.Status.MainAxisReal;
//	IO_MCRaw.InletStatusAlarm[28].3;
//	IO_MCRaw.InletStatusAlarm[28].4;
//	IO_MCRaw.InletStatusAlarm[28].5;
//	IO_MCRaw.InletStatusAlarm[28].6;
//	IO_MCRaw.InletStatusAlarm[28].7;
//	IO_MCRaw.InletStatusAlarm[29];
//END_ACTION*)