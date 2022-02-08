ACTION DOS_ValvesFlip: 
	//CONFIGURATION FILIPPO
//	VAR_BTC_Flip_RTInfo(enable:=TRUE);	
//	VAR_BTC_Flip_CycleTime :=UDINT_TO_REAL(VAR_BTC_Flip_RTInfo.cycle_time)/1000000; //TASK CYCLE TIME EXPRESS IN µsec . VAR_Cycle IS CONVERTED IN s

	//SET VALVE TO USE IN THE SEQUENCE
	VAR_DOS_FlipSeqValve[0].Config  	:= FALSE;
	VAR_DOS_FlipSeqValve[1].Config 		:= AVJ[217].IN_ConfigPresent;
	VAR_DOS_FlipSeqValve[2].Config 		:= FALSE;
	VAR_DOS_FlipSeqValve[3].Config 		:= FALSE;
	VAR_DOS_FlipSeqValve[4].Config 		:= FALSE;
	VAR_DOS_FlipSeqValve[5].Config 		:= FALSE;
	VAR_DOS_FlipSeqValve[6].Config 		:= FALSE;
	VAR_DOS_FlipSeqValve[7].Config 		:= FALSE;
	
	//SET VALVE EXECUTION DONE
	VAR_DOS_FlipSeqValve[0].Executed 	:= FALSE;
	VAR_DOS_FlipSeqValve[1].Executed 	:= AVJ[217].OUT_FlipDone;
	VAR_DOS_FlipSeqValve[2].Executed 	:= FALSE;
	VAR_DOS_FlipSeqValve[3].Executed 	:= FALSE;
	VAR_DOS_FlipSeqValve[4].Executed 	:= FALSE;
	VAR_DOS_FlipSeqValve[5].Executed 	:= FALSE;
	VAR_DOS_FlipSeqValve[6].Executed 	:= FALSE;
	VAR_DOS_FlipSeqValve[7].Executed 	:= FALSE;
	
	//SET DELAY BEFORE TO EXECUTE NEXT PHASE	
	VAR_DOS_FlipSeqValve[0].TimeDelay_SP 	:= 240.0; //DELAY IN s TO NEXT SEQUENCE
	VAR_DOS_FlipSeqValve[1].TimeDelay_SP 	:= 2.0; //DELAY IN s TO NEXT SEQUENCE
	VAR_DOS_FlipSeqValve[2].TimeDelay_SP 	:= 2.0; //DELAY IN s TO NEXT SEQUENCE
	VAR_DOS_FlipSeqValve[3].TimeDelay_SP 	:= 2.0; //DELAY IN s TO NEXT SEQUENCE
	VAR_DOS_FlipSeqValve[4].TimeDelay_SP 	:= 2.0; //DELAY IN s TO NEXT SEQUENCE
	VAR_DOS_FlipSeqValve[5].TimeDelay_SP 	:= 2.0; //DELAY IN s TO NEXT SEQUENCE
	VAR_DOS_FlipSeqValve[6].TimeDelay_SP 	:= 2.0; //DELAY IN s TO NEXT SEQUENCE
	VAR_DOS_FlipSeqValve[7].TimeDelay_SP 	:= 2.0; //DELAY IN s TO NEXT SEQUENCE
	
	VAR_DOS_FlipSeqStart 	:= FALSE;
	VAR_DOS_FlipSeqEnable 	:= FALSE;
	VAR_DOS_FlipSeqEnd 		:= FALSE;
	VAR_DOS_FlipSeqReset	:= FALSE;
	
	//SCROLL MANAGEMENT
	IF VAR_DOS_FlipSeqStart AND NOT VAR_DOS_FlipSeqEnd THEN
		IF VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].Config AND NOT VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].SequenceDone THEN
			IF VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].Done THEN	//OPENING EXECUTED
				VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].TimeDelay_PV := VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].TimeDelay_PV + VAR_DOS_Flip_CycleTime; 	//DELAY TIME COUNTING			
			ELSE
				VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].Request:= VAR_DOS_FlipSeqEnable AND NOT VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].Executed; 		//REQUEST TO VALVE
				VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].Done	:= VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].Executed;			//EXECUTION REGISTERED
			END_IF
		
			IF VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].TimeDelay_PV > VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].TimeDelay_SP THEN	//DELAY PV > DELAY SP -> SEQUENCE DONE
				VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].SequenceDone := TRUE;													//VALVE Seq DONE
				VAR_DOS_FlipIndex := MIN(VAR_DOS_FlipIndex+1,VAR_DOS_FlipSeqMax);
			END_IF
		ELSE	
			VAR_DOS_FlipSeqValve[VAR_DOS_FlipIndex].SequenceDone := TRUE;		//SEQUENCE CLOSED	
			VAR_DOS_FlipIndex := MIN(VAR_DOS_FlipIndex+1,VAR_DOS_FlipSeqMax);	//INDEX INCREASE
		END_IF
	END_IF
	//END OF ONE SEQUENCE
	IF EDGEPOS(VAR_DOS_FlipSeqValve[VAR_DOS_FlipSeqMax].SequenceDone) THEN
		VAR_DOS_FlipSequenceRepetition	:= VAR_DOS_FlipSequenceRepetition+1;
		VAR_DOS_FlipIndex				:= 0;
		memset(ADR(VAR_DOS_FlipSeqValve),0,SIZEOF(VAR_DOS_FlipSeqValve));
	END_IF
	//CLEAN ALL
	IF EDGEPOS(VAR_DOS_FlipSeqReset)THEN	//SCROLL RESET																									//STRUCTURE CLEAN
		memset(ADR(VAR_DOS_FlipSeqValve),0,SIZEOF(VAR_DOS_FlipSeqValve));
		VAR_DOS_FlipIndex				:= 0;
		VAR_DOS_FlipSequenceRepetition	:= 0;
	END_IF
END_ACTION
