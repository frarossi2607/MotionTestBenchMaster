FUNCTION_BLOCK Sequencer_v1
	VAR_ChangeInProgress := OUT_JMP_Step <> IN_Step;
	
	IF VAR_ChangeInProgress THEN
		memset(ADR(TON_Time),	0,	SIZEOF(TON_Time));
		memset(ADR(T_Time),		0,	SIZEOF(T_Time));
		memset(ADR(TO_Time),	0,	SIZEOF(TO_Time));
		OUT_JMP_StepPrevious := OUT_JMP_Step ;
	END_IF

	//Volatile Timer
	TON_Time(
	IN := IN_StepConfig.TON_TimeSTART AND NOT VAR_ChangeInProgress AND NOT IN_Pause_Request, 
	PT := UINT_TO_TIME(IN_StepConfig.TON_TimePr * 1000)
	);
	OUT_TON_Time_END := TON_Time.Q;
	
	//Retentive Counter
	T_Time(
	CU 		:= IN_T_TimeClock AND IN_StepConfig.T_TimeSTART AND NOT IN_StepConfig.T_TimeSTOP AND NOT IN_Pause_Request, 
	RESET 	:= IN_StepConfig.T_TimeRESET OR VAR_ChangeInProgress, 
	PV 		:= IN_StepConfig.T_TimePr
	);
	OUT_T_Time_END := T_Time.Q;
	
	//Volatile Timeout
	TO_Time(
	IN := NOT VAR_ChangeInProgress, 
	PT := UINT_TO_TIME(IN_StepConfig.TO_TimePr * 1000)
	);
	OUT_TO_Time_END := TO_Time.Q;
		
	//Reset counter Initialized to wait counter reset from Filler
	IF VAR_ChangeInProgress THEN
		VAR_CounterInitialized := FALSE;
	END_IF
	
	//Eneble Laps Counter Request only if the counter is initialized
	IF NOT VAR_CounterInitialized THEN
		OUT_LapsCounterRequest := FALSE;
	ELSIF IN_StepConfig.Laps_Counter_Enable THEN
		OUT_LapsCounterRequest := TRUE;
	END_IF
	
	//Step Counter is initialized when the value is 0
	IF IN_StepCounter = 0 THEN
		VAR_CounterInitialized := TRUE;
	END_IF
	
	//Laps Progress
	OUT_Laps_Progress := (IN_StepCounter / MAX(1, IN_FillingValveNr));
	
	//Laps Expired
	OUT_Laps_Done := OUT_Laps_Progress >= IN_StepConfig.Laps_Request AND IN_StepCounter > 0 AND IN_StepConfig.Laps_Counter_Enable;

	OUT_JMP_Step 	:= IN_Step;
	OUT_HMI_ID		:= IN_StepConfig.HMI_ID;
	
	//Cycles
	IF CyclesCounter >= IN_StepConfig.Cycle_Pr THEN
		OUT_Cycles_Done := TRUE;
	ELSE
		OUT_Cycles_Done:= FALSE;
	END_IF
	
	//Timers Visualization
	OUT_StepTimePr_TON  := REAL_TO_UINT(TIME_TO_REAL(TON_Time.PT) / 1000.0);
	OUT_StepTimePr_T    := T_Time.PV;
	OUT_StepTimeCV_TON	:= REAL_TO_UINT(TIME_TO_REAL(TON_Time.ET) / 1000.0);
	OUT_StepTimeCV_T    := T_Time.CV;
	
END_FUNCTION_BLOCK

FUNCTION_BLOCK Sequencer_v2
	VAR_ChangeInProgress := OUT_StepActual <> IN_Step; //v2
	
	IF VAR_ChangeInProgress THEN
		memset(ADR(TON_Time),	0,	SIZEOF(TON_Time));
		memset(ADR(T_Time),		0,	SIZEOF(T_Time));
		memset(ADR(TO_Time),	0,	SIZEOF(TO_Time));
		OUT_StepPrevious := OUT_StepActual; //v2
	END_IF

	//Volatile Timer
	TON_Time(
	IN := IN_StepConfig.TON_TimeSTART AND NOT VAR_ChangeInProgress AND NOT IN_Pause_Request, 
	PT := UINT_TO_TIME(IN_StepConfig.TON_TimePr * 1000)
	);
	OUT_TON_Time_END := TON_Time.Q;
	
	//Retentive Counter
	T_Time(
	CU 		:= IN_T_TimeClock AND IN_StepConfig.T_TimeSTART AND NOT IN_StepConfig.T_TimeSTOP AND NOT IN_Pause_Request, 
	RESET 	:= IN_StepConfig.T_TimeRESET OR VAR_ChangeInProgress, 
	PV 		:= IN_StepConfig.T_TimePr
	);
	OUT_T_Time_END := T_Time.Q;
	
	//Volatile Timeout
	TO_Time(
	IN := NOT VAR_ChangeInProgress, 
	PT := UINT_TO_TIME(IN_StepConfig.TO_TimePr * 1000)
	);
	OUT_TO_Time_END := TO_Time.Q;
	
	//Progressive Time v2
	T_StepProgressiveTime( 
	IN := NOT VAR_ChangeInProgress, 
	PT := T#24d,
	);
	
	//Reset counter Initialized to wait counter reset from Filler
	IF VAR_ChangeInProgress THEN
		VAR_CounterInitialized := FALSE;
	END_IF
	
	//Eneble Laps Counter Request only if the counter is initialized
	IF NOT VAR_CounterInitialized THEN
		OUT_LapsCounterRequest := FALSE;
	ELSIF IN_StepConfig.Laps_Counter_Enable THEN
		OUT_LapsCounterRequest := TRUE;
	END_IF
	
	//Step Counter is initialized when the value is 0
	IF IN_StepCounter = 0 THEN
		VAR_CounterInitialized := TRUE;
	END_IF
	
	//Laps Progress
	OUT_Laps_Progress := (IN_StepCounter / MAX(1, IN_FillingValveNr));
	
	//Laps Expired
	OUT_Laps_Done := OUT_Laps_Progress >= IN_StepConfig.Laps_Request AND IN_StepCounter > 0 AND IN_StepConfig.Laps_Counter_Enable;

	OUT_StepActual 	:= IN_Step; //v2
	OUT_HMI_ID		:= IN_StepConfig.HMI_ID;
	
	//Cycles
	IF CyclesCounter >= IN_StepConfig.Cycle_Pr THEN
		OUT_Cycles_Done := TRUE;
	ELSE
		OUT_Cycles_Done:= FALSE;
	END_IF
	
	//Timers Visualization
	OUT_StepTimePr_TON  	:= REAL_TO_UINT(TIME_TO_REAL(TON_Time.PT) / 1000.0);
	OUT_StepTimePr_T    	:= T_Time.PV;
	OUT_StepTimeCV_TON		:= REAL_TO_UINT(TIME_TO_REAL(TON_Time.ET) / 1000.0);
	OUT_StepTimeCV_T    	:= T_Time.CV;
	OUT_StepProgressiveTime	:= REAL_TO_UINT(TIME_TO_REAL(T_StepProgressiveTime.ET) / 1000.0); //v2
	
END_FUNCTION_BLOCK