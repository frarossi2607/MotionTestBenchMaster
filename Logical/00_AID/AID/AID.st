PROGRAM _INIT
	AID.DataOut.ProjectType	:= CST_AID_ProjectMachine;
END_PROGRAM

PROGRAM _CYCLIC
	TimeAndBlink;
		
	Beacon_SidelStandard;
	
	PbLight;
	
	AID.DataOut.Reset		:= IO_PB_ResetOp.ON;//v4 200.2.0
	IO_SkdReset.DO_Output	:= AID.DataOut.Reset;
	
	IF EDGEPOS(IO_PB_ResetOp.ON) THEN
		AID.DataOut.OperatorPresence	:= TRUE;
	END_IF
END_PROGRAM