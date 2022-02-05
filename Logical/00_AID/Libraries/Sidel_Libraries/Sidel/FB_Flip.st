FUNCTION_BLOCK FB_Flip
	TON_Blink.IN := NOT TON_Blink.Q;
	TON_Blink.PT := t#1s;
	TON_Blink();

	IF EDGEPOS(TON_Blink.Q) THEN	
		VAR_CyleOn 		:= FALSE;
		VAR_CyleCntOn	:= FALSE;
		VAR_CyleCntOff	:= FALSE;
		VAR_CyleOnTimeReset := FALSE;
		VAR_CyleOffTimeReset:= FALSE;
		VAR_CyleNrReset	:= FALSE;
		VAR_CycleNrDone	:= FALSE;
		CASE Command_State OF
			0:
				IF IN_CycleOn AND NOT IN_CyclePause THEN
					IF IN_CycleStartOffCount THEN
						Command_State := 2;
					ELSIF IN_CycleTimeOn > 0 THEN
						Command_State := 1;
					END_IF
				END_IF
		
			1:	//ON TIME
				VAR_CyleOn 		:= TRUE;
				VAR_CyleCntOn	:= TRUE;
				VAR_CyleOffTimeReset	:= TRUE;
				
				IF NOT IN_CycleOn THEN
					Command_State := 99; // //RESET CNT
				ELSIF IN_CyclePause THEN
					Command_State := 10; // PAUSE CMD
				ELSE
					IF VAR_CycleOnDone THEN
						VAR_CyleOnTimeReset := TRUE;
						IF IN_CycleLoop THEN
							IF IN_CycleTimeOff > 0 THEN
								Command_State := 2; //PAUSE TIME
							END_IF
						ELSE
							VAR_CycleNr 	:= MIN(VAR_CycleNr  +1, IN_CycleNr);
							 IF (IN_CycleNr = VAR_CycleNr) AND NOT IN_CycleLoop THEN
								Command_State := 3; // DONE
							ELSE
								Command_State := 2; //PAUSE TIME
							END_IF
						END_IF
					END_IF
				END_IF
			
			2: //PAUSE TIME
				
				VAR_CyleCntOff	:= NOT IN_CyclePause;
				VAR_CyleOnTimeReset	:= TRUE;
				
				
				IF NOT IN_CycleOn THEN
					Command_State := 99; // //RESET CNT
				ELSIF VAR_CycleOffDone AND NOT IN_CyclePause THEN
					VAR_CyleOffTimeReset := TRUE;
					IF VAR_CycleNrDone THEN
						Command_State := 3; // DONE
					ELSIF IN_CycleTimeOn > 0 THEN
						Command_State := 1; // ON TIME
					END_IF
				END_IF

			3: // DONE
				VAR_CycleNrDone	:= TRUE;
				IF NOT IN_CycleOn OR IN_CycleLoop THEN
					Command_State := 99; // //RESET CNT
				END_IF 
		
			10: // PAUSE 
				
				IF NOT IN_CycleOn THEN
					Command_State := 99; // //RESET CNT
				ELSIF NOT IN_CyclePause THEN
					Command_State := 1; // OFF
				END_IF
			
			99: //RESET CNT
				VAR_CyleOnTimeReset := TRUE;
				VAR_CyleOffTimeReset:= TRUE;
				VAR_CycleNr := 0;
				Command_State := 0; // OFF
		END_CASE

		IF VAR_CyleCntOn THEN
			VAR_CycleTimeOn := MIN(VAR_CycleTimeOn  +1, IN_CycleTimeOn);
			VAR_CycleOnDone := IN_CycleTimeOn = VAR_CycleTimeOn;
		ELSE
			VAR_CycleOnDone := FALSE;
		END_IF
		
		IF VAR_CyleCntOff THEN
			VAR_CycleTimeOff := MIN(VAR_CycleTimeOff +1, IN_CycleTimeOff);
			VAR_CycleOffDone := IN_CycleTimeOff = VAR_CycleTimeOff;
		ELSE
			VAR_CycleOffDone := FALSE;
		END_IF
		
		IF VAR_CyleOffTimeReset THEN
			VAR_CycleTimeOff := 0;
		END_IF
		IF VAR_CyleOnTimeReset THEN
			VAR_CycleTimeOn := 0;
		END_IF
		IF IN_CycleNrReset THEN
			VAR_CycleNr 	:= 0;
		END_IF
	
		Out 			:= VAR_CyleOn;
		OUT_CycleNr		:= VAR_CycleNr;
		OUT_CycleTimeOn	:= VAR_CycleTimeOn;
		OUT_CycleTimeOff:= VAR_CycleTimeOff;
		OUT_CycleDone 	:= VAR_CycleNrDone;
	END_IF
END_FUNCTION_BLOCK
