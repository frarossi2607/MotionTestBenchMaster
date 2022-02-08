
TYPE
	MNM_AdjustmentStep : 
		( (*V4.A.A.1.7.0*)
		MNM_AdjWaitStart := 100,
		MNM_AdjHornBlow := 110,
		MNM_AdjAxisStopping := 140,
		MNM_AdjFillerFootbarSettingPos := 200,
		MNM_AdjRinserFootbarSettingPos := 210,
		MNM_AdjDoserFootbarSettingPos := 220,
		MNM_AdjCapperSettingPos := 230,
		MNM_AdjCrownerSettingPos := 240,
		MNM_AdjCapGreasingSettingPos := 250, (*V4.A.A.1.7.0*)
		MNM_AdjAxisStart := 300,
		MNM_AdjAxisWaitStop := 310,
		MNM_AdjAxisPosStart := 400,
		MNM_AdjAxisPosWaitStop := 410,
		MNM_AdjAxisStopped := 500,
		MNM_AdjFault := 9999
		);
	MNM_AutoStep : 
		(
		MNM_AutoWaitStart := 100,
		MNM_AutoHornBlow := 110,
		MNM_AutoMachineStart := 120,
		MNM_AutoMachineRunningEmpty := 131,
		MNM_AutoMachineRunningFull := 132,
		MNM_AutoMachineRunning := 133,
		MNM_AutoMachineColceaPashing := 134,
		MNM_AutoMachineStarWheel2Phasing := 137,
		MNM_AutoMachineRinserPashing := 136,
		MNM_AutoMachineStarWheel1Pashing := 135,
		MNM_AutoMachineStopping := 140,
		MNM_AutoSmr1OpHornBlow := 210,
		MNM_AutoSmr1OpMachineStart := 220,
		MNM_AutoSmr1OpMachineStopping := 240,
		MNM_AutoVortexCalibIdle := 300,
		MNM_AutoVortexCalibHornBlow := 310,
		MNM_AutoVortexCalibPosStart := 320,
		MNM_AutoVortexCalibPosWaitStop := 340,
		MNM_AutoStepFmcHornBlow := 410,
		MNM_AutoStepFmcStart := 420,
		MNM_AutoStepFmcWaitStop := 440,
		MNM_AutoStepHornBlow := 510,
		MNM_AutoStepStart := 520,
		MNM_AutoStepWaitStop := 540,
		MNM_AutoFootboardHornBlow := 610,
		MNM_AutoFootboardStart := 620,
		MNM_AutoFootboardWaitStop := 640,
		MNM_AutoCapperPosHornBlow := 710,
		MNM_AutoCapperPosStart := 720,
		MNM_AutoCapperPosWaitStop := 740,
		MNM_AutoCapperPosWaitStopAux := 741, (*V4.A.A.1.6.12h*)
		MNM_AutoCapperFinePosStart := 750,
		MNM_AutoCapperFinePosWaitStop := 760,
		MNM_AutoFillingValvePosHornBlow := 810,
		MNM_AutoFillingValvePosStart := 820,
		MNM_AutoFillingValvePosWaitStop := 830,
		MNM_AutoCheckFillerInletHorn := 1010,
		MNM_AutoCheckFillerInletStart := 1011,
		MNM_AutoCheckFillerInletStop := 1012,
		MNM_AutoCheckFillerTangencyHorn := 1020,
		MNM_AutoCheckFillerTangencyStart := 1021,
		MNM_AutoCheckFillerTangencyStop := 1022,
		MNM_AutoCheckFillerOutletHorn := 1030,
		MNM_AutoCheckFillerOutletStart := 1031,
		MNM_AutoCheckFillerOutletStop := 1032,
		MNM_AutoCheckCapsReleaseHorn := 1040,
		MNM_AutoCheckCapsReleaseStart := 1041,
		MNM_AutoCheckCapsReleaseStop := 1042,
		MNM_AutoFillerHalfPosConfig := 1043, (*v999*)
		MNM_AutoFillerHalfPosHornBlow := 1044, (*v999*)
		MNM_AutoFillerHalfAxisStart := 1045, (*v999*)
		MNM_AutoFillerHalfWaitStop := 1046, (*v999*)
		MNM_AutoFillerHalfStopped := 1047, (*v999*)
		MNM_AutoFillerReversePosConfig := 1048, (*v999*)
		MNM_AutoFillerReversePosHornBlow := 1049, (*v999*)
		MNM_AutoFillerReverseAxisStart := 1050, (*v999*)
		MNM_AutoFillerReverseWaitStop := 1051, (*v999*)
		MNM_AutoFillerReverseStopped := 1052, (*v999*)
		MNM_AutoFillSecondHalfPosConfig := 1053,
		MNM_AutoFillSecondHalfRevPosConf,
		MNM_AutoFault := 9999
		);
	MNM_AutoCombiStep : 
		(
		MNM_AutoCombiInit := 0,
		MNM_AutoCombiBFWaitStart := 100,
		MNM_AutoCombiBLFWaitStart := 101,
		MNM_AutoCombiBAFWaitStart := 102, (*V4.A.A.1.7.0*)
		MNM_AutoCombiHornBlow := 110,
		MNM_AutoCombiSyncroStart := 120,
		MNM_AutoCombiMachineReadyToRun := 121,
		MNM_AutoCombiMachineRunningFull := 131,
		MNM_AutoCombiMachineRunningEmpty := 132,
		MNM_AutoCombiMachineFixEmptying := 135,
		MNM_AutoCombiMachineStopping := 140,
		MNM_AutoCombiFault := 9999
		);
	MNM_JogStep : 
		(
		MNM_JogWaitStart := 400,
		MNM_JogHornBlow := 410,
		MNM_JogMachineStart := 420,
		MNM_JogMachineRunning := 430,
		MNM_JogMachineStopping := 440,
		MNM_JogFault := 9999
		);
	MNM_JogCombiStep : 
		(
		MNM_JogCombiWaitStart := 400,
		MNM_JogCombiHornBlow := 410,
		MNM_JogCombiSyncroStart := 420,
		MNM_JogCombiMachineReadyToRun := 421,
		MNM_JogCombiMachineStart := 422,
		MNM_JogCombiMachineRunning := 430,
		MNM_JogCombiMachineStopping := 440,
		MNM_JogCombiFault := 9999
		);
	MNM_MultiStep : 
		(
		MNM_MultiModeSelection := 0,
		MNM_MultiAutoWaitStart := 100,
		MNM_MultiAutoHornBlow := 110,
		MNM_MultiAutoMachineStart := 120,
		MNM_MultiAutoMachineRunning := 130,
		MNM_MultiAutoMachineStopping := 140,
		MNM_MultiVortexCalibIdle := 300,
		MNM_MultiVortexCalibHornBlow := 310,
		MNM_MultiVortexCalibPosStart := 320,
		MNM_MultiVortexCalibPosWaitStop := 340,
		MNM_MultiStepFmcHornBlow := 410,
		MNM_MultiStepFmcStart := 420,
		MNM_MultiStepFmcWaitStop := 440,
		MNM_MultiStepHornBlow := 510,
		MNM_MultiStepStart := 520,
		MNM_MultiStepWaitStop := 540,
		MNM_MultiFootboardHornBlow := 610,
		MNM_MultiFootboardStart := 620,
		MNM_MultiFootboardWaitStop := 640,
		MNM_MultiCapperPosHornBlow := 710,
		MNM_MultiCapperPosStart := 720,
		MNM_MultiCapperPosWaitStop := 740,
		MNM_MultiCapperFinePosStart := 750,
		MNM_MultiCapperFinePosWaitStop := 760,
		MNM_MultiJogWaitStart := 1400,
		MNM_MultiJogHornBlow := 1410,
		MNM_MultiJogMachineStart := 1420,
		MNM_MultiJogMachineRunning := 1430,
		MNM_MultiJogMachineStopping := 1440,
		MNM_MultiSlowMotionWaitStart := 1500,
		MNM_MultiSlowMotionHornBlow := 1510,
		MNM_MultiSlowMotionStart := 1520,
		MNM_MultiSlowMotionRunning := 1530,
		MNM_MultiSlowMotionStopping := 1540,
		MNM_MultiFault := 9999
		);
	MNM_InletConveyorVFD : 
		( (*1.6(*Master nuovo*)
		MNM_InCvrIdle := 0,
		MNM_InCvrAuto := 100,
		MNM_InCvrAutoOption := 110,
		MNM_InCvrAutoFixSpeed := 210,
		MNM_InCvrAutoRampDown := 300,
		MNM_InCvrCleaning := 400,
		MNM_InCvrFault := 9999
		);
	MNM_OutletConveyorVFD : 
		( (*1.6*)
		MNM_OutCvrIdle := 0,
		MNM_OutCvrAuto := 100,
		MNM_OutCvrAutoOption := 110,
		MNM_OutCvrAutoFixSpeed := 210,
		MNM_OutCvrAutoRampDown := 300,
		MNM_OutCvrCleaning := 400,
		MNM_OutCvrFault := 9999
		);
	VAR_FixSpeed_Type : 	STRUCT 
		Module : USINT; (*0: All Module (Only coupled)
1: Inlet module
2: Filler module
3: Outlet module
9: All module (Uncupled) (Not interruptible)*)
		Interruptible : BOOL;
		Req : BOOL;
		Value : REAL;
		Reached : BOOL;
		CmpMode : USINT;
		Active : BOOL;
	END_STRUCT;
	VAR_ModuleSpeed_Type : 	STRUCT 
		Machine : REAL;
		Inlet : REAL;
		Filler : REAL;
		Outlet : REAL;
	END_STRUCT;
END_TYPE
