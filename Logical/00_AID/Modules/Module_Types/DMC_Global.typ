
TYPE
	DMC_Mode_Type : 	STRUCT 
		AutomaticMode : DMC_Status_Type;
		ManualMode : DMC_Status_Type;
	END_STRUCT;
	DMC_Status_Type : 	STRUCT 
		CycleActive : BOOL;
		CycleAborted : BOOL;
		SecondHalfPositionDone : BOOL;
		SecondHalfRotToProdDone : BOOL;
		SecondHalfRotToCipDone : BOOL;
		FirstHalfRotToProdDone : BOOL;
		FirstHalfRotToCipDone : BOOL;
		SecondHalfPistonUpDone : BOOL;
		SecondHalfPistonDownDone : BOOL;
		FirstHalfPistonUpDone : BOOL;
		FirstHalfPistonDownDone : BOOL;
		SecondHalfCheckToProdDone : BOOL;
		FirstHalfCheckToProdDone : BOOL;
		SecondHalfCheckToCipDone : BOOL;
		FirstHalfCheckToCipDone : BOOL;
		FirstHalfPositionDone : BOOL;
		FirstHalfDmcRemoved : BOOL;
		FirstHalfDmcInserted : BOOL;
		SecondHalfDmcRemoved : BOOL;
		SecondHalfDmcInserted : BOOL;
	END_STRUCT;
	DMC_ModeManualSequencerType : 
		(
		DMC_ManWait := 0,
		DMC_ManFillerFirstHalfPosReq := 1, (*v999*)
		DMC_ManDummyFirstHalfWaitPosDone := 2,
		DMC_ManDiscargeAirForDownMov := 3, (*v999*)
		DMC_ManFirstSecCommandSelection := 4,
		DMC_ManFirstSectorRotToCip := 5,
		DMC_ManFirstSectorRotToProd := 6,
		DMC_ManCommandDummyBottleUp := 7,
		DMC_ManDummyContWaitComCheckSec1 := 8,
		DMC_ManDummyContDinsControl := 9,
		DMC_ManDmcFirstHalfInsErrFilStop := 10,
		DMC_ManReturnToFirstHalfPosition := 11,
		DMC_ManReturnToFirstWaitPosDone := 12,
		DMC_ManFirstHalfCheck := 13,
		DMC_ManFirstHalfCheckConfToRest := 14,
		DMC_ManFirstHalfDisWaitPressOk := 15,
		DMC_ManDmcFirstHalfInstFillStop := 16,
		DMC_ManFillerSecondHalfPosReq := 17,
		DMC_ManDmcSecondHalfWaitPosDone := 18,
		DMC_ManDiscargeAirForDownMovSec2 := 19,
		DMC_ManSecondSecCommandSelection := 20,
		DMC_ManSecondSectorRotToCip := 21,
		DMC_ManSecondSectorRotToProd := 22,
		DMC_ManCommandDummyBottleUpSec2 := 23,
		DMC_ManDummyContWaitComCheckSec2 := 24,
		DMC_ManDummyContDinsControlSec2 := 25,
		DMC_ManDmcHalfInsErrFilStopSec2 := 26,
		DMC_ManReturnToSecondHalfPos := 27,
		DMC_ManReturnToSecondWaitPosDone := 28,
		DMC_ManSecondHalfCheck := 29,
		DMC_ManSecondHalfCheckConfToRest := 30,
		DMC_ManSecondHalfDisWaitPressOk := 31,
		DMC_ManDmcSecondHalfInstFillStop := 32,
		DMC_MauFaultPistonDownSec1 := 33,
		DMC_MauFaultPistonDownSec2 := 34,
		DMC_ManFaultRotToCipSec1 := 35,
		DMC_ManFaultRotToCipSec2 := 36,
		DMC_ManFaultRotToProdSec1 := 37,
		DMC_ManFaultRotToProdSec2 := 38,
		DMC_ManFault := 99
		);
	DMC_SequencerType : 
		(
		DMC_Wait := 0,
		DMC_WaitMachineEmptyAndSlowDown := 1,
		DMC_LftCenteringCupUp := 2,
		DMC_DummyContInstalling := 4,
		DMC_DummyContInstalledControl := 5,
		DMC_DummyContInsMachineStop := 6,
		DMC_DummyContInsCsrPositioning := 7,
		DMC_DummyContInsLftCenterCupDown := 8,
		DMC_DummyContInsFmcCipMode := 9,
		DMC_DummyContInstalled := 10,
		DMC_DummyContDisMachineStop := 11,
		DMC_DummyContDisFmcCenterCupUp := 12,
		DMC_DummyContDisLftCenterCupUp := 13,
		DMC_DummyContDisCsrPositioning := 14,
		DMC_DummyContDisMachineStart := 15,
		DMC_DummyContDisinsection := 16,
		DMC_DummyContDinsControl := 17,
		DMC_DummyContRemovedDone := 18,
		DMC_TankAndCammaHeigthControl := 19, (*v999*)
		DMC_FillerHeightPositionReq := 20, (*v999*)
		DMC_FillerFirstHalfPosReq := 21, (*v999*)
		DMC_CommandDummyBottleDown := 22, (*v999*)
		DMC_WaitMachineStopped := 23, (*v999*)
		DMC_DiscargeAirForDownMovement := 24, (*v999*)
		DMC_CommandDummyBottleUp := 25, (*v999*)
		DMC_FillerSecondHalfPosReq := 26, (*v999*)
		DMC_DiscargeSecHalfAirForDownMov := 27, (*v999*)
		DMC_SecondHalfComDummyBottleDown := 28, (*v999*)
		DMC_SecondHalfDummyContInstCont := 29, (*v999*)
		DMC_FillerFirstHalfPosReqForDis := 30, (*v999*)
		DMC_DiscargeAirForDownMovForDis := 31, (*v999*)
		DMC_CommandDummyBottleDownForDis := 32, (*v999*)
		DMC_CommandDummyBottleUpForDis := 33, (*v999*)
		DMC_FillerSecondHalfPosReqForDis := 34, (*v999*)
		DMC_SecHalfComDumBotDownForDis := 35, (*v999*)
		DMC_CommandDummyBotUpSecondHalf := 36, (*v999*)
		DMC_SecondHalfDmcInstCont := 37, (*v999*)
		DMC_FillerSecondHalfPosReqforDis := 38, (*v999*)
		DMC_DiscargeAirSecHalfForDownMov := 39,
		DMC_SecHalfComDummyBottleDownDis := 40,
		DMC_CommandDummyBottleUpDis := 41,
		DMC_SecondHalfDummyContDisCont := 42,
		DMC_DMCFirstHalfInstMachineStop := 43,
		DMC_FisrtHalfWaitFillerStop := 44,
		DMC_ReturnToFirstHalfPosition := 46,
		DMC_DMCFirstHalfInsErrFilStop := 45,
		DMC_FirstHalfCheck := 47,
		DMC_DMCSecondHalfInstMachineStop := 48,
		DMC_DummyContSecondHalfInstCont := 49,
		DMC_DMCSecondHalfInsErrFilStop := 50,
		DMC_ReturnToSecondHalfPosition := 51,
		DMC_SecondHalfCheck := 52,
		DMC_FirstHalfDisReverseForCheck := 53,
		DMC_FirstHalDisWaitCheckDone := 54,
		DMC_SecondHalfDisReverseForCheck := 55,
		DMC_SecondHalDisWaitCheckDone := 56,
		DMC_DummyGenericErrorDownToCip := 57,
		DMC_FirstHalfDisWaitPressureOk := 58,
		DMC_SecondHalfDisWaitPressureOk := 59,
		DMC_FirstHalfInsWaitPressureOk := 60,
		DMC_FirstHalfCheckConfToRestart := 61,
		DMC_SecondHalfCheckConfToRestart := 62,
		DMC_DMCFirstHalfDisMachineStop := 64,
		DMC_SecondHalfInsWaitPressureOk := 63,
		DMC_FirstHalfDisCheckToRestart := 65,
		DMC_SecondHalfDisCheck := 66,
		DMC_SecondHalfDisCheckToRestart := 67,
		DMC_DummyErrorDownToCipSec2 := 68,
		DMC_DummyErrorDownToProdSec1 := 69,
		DMC_DummyErrorDownToProdSec2 := 70,
		DMC_DummyFirstHalfWaitPosDone := 71,
		DMC_DummySecondHalfWaitPosDone := 72,
		DMC_DummySecHalfDisWaitPosDone := 73,
		DMC_FillerSecHalfDisWaitFillStop := 75,
		DMC_DummyFirstHalfDisWaitPosDone := 74,
		DMC_ReturnToFirstWaitPosDone := 76,
		DMC_ReturnToSecondHalfPosDone := 77,
		DMC_FirstHalfDisRevPosDone := 78,
		DMC_SecondHalfDisRevPosDone := 79,
		DMC_CycleAbortedChooseStep := 81,
		DMC_CycleAbortedCheckContidion := 80,
		DMC_WaitConditionForAborting := 82,
		DMC_ReturnToProdHeight := 83,
		DMC_Fault := 99
		);
END_TYPE
