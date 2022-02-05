(********************************************************************
 * COPYRIGHT -- Sidel S.p.A.
 ********************************************************************
 * Program: PC
 * File: Balayage_Flow_Contr.st
 * Author: Marco.Nicoli
 * Created: December 10, 2012
 ********************************************************************
 * Implementation of program PC
 ********************************************************************) 

(*  *)
FUNCTION_BLOCK LevelVariation
	VAR_RTInfo(enable:=TRUE);	
	VAR_Cycle:=	UDINT_TO_REAL(VAR_RTInfo.cycle_time)/1000000; //TASK CYCLE TIME EXPRESS IN µsec . VAR_Cycle IS CONVERTED IN s
	
	IF IN_Enable THEN
		IF Timer > IN_ControlTime THEN							
			DeltaVolume := (IN_TankVolumePV - OldVolume);						//LEVEL VARIATION CONTROL
			IF DeltaVolume < -1.0 THEN
				AbsoluteError := AbsoluteError + ABS (DeltaVolume);				//WHEN VARIATION IS NEGATIVE THE ERROR INCREASE 
				RestoreTime	  := 0.0;											//WHEN VARIATION IS NEGATIVE RESTORE TIME IS RESET
				RestoreError  := 0.0;											//WHEN VARIATION IS NEGATIVE RESTORE ERROR IS RESET 
			ELSIF OUT_High THEN
				RestoreTime	:= LIMIT (0.0,RestoreTime + 1.0,RestoreTimeLimit);	//WHEN VARIATION IS POSITIVE RESTORE TIME INCREASE
				RestoreError:= 0.0;												//WHEN VARIATION IS NEGATIVE RESTORE ERROR IS RESET
			ELSE
				RestoreError := LIMIT (0.0,RestoreError + 1.0,RestoreErrorLimit); //WHEN NO ACTION BEFORE INCREASE ERROR
			END_IF
					
			IF RestoreTime >= RestoreTimeLimit THEN								//WHEN RESTORE TIME LIMIT REACHED VARIATION IS STEADY
				AbsoluteError	:= 0.0;											//RestoreTimeLimit = 50.0 -> Timer x 50 -> 200ms x 50 = 10s
				RestoreTime 	:= 0.0;
			END_IF
			
			IF RestoreError >= RestoreErrorLimit THEN 							//WHEN RESTORE ERROR IS REACHED ERROR IS RESET                                     
				AbsoluteError   := 0.0;               							//RestoreErrorLimit = 50.0 -> Timer x 50 -> 200ms x 50 = 10s                                                                   
				RestoreError    := 0.0;
			END_IF

			OldVolume	:= IN_TankVolumePV;										//ACTUAL VOLUME UPDATE
			Timer		:= 0.0;													//CYCLE TIME RESTART
		ELSE
			Timer := Timer + VAR_Cycle ;										//CYCLE TIME UPDATE
		END_IF	
	ELSE 
		Timer 			:= 0.0;
		AbsoluteError 	:= 0.0;
		RestoreTime 	:= 0.0;
		RestoreError    := 0.0;
		OldVolume 		:= IN_TankVolumePV;					
	END_IF	
 
	OUT_High	:= AbsoluteError > 3.0;											//HIGH FLOW REQUEST DUE TO PERSISTENT NEGATIVE VARIATION
	OUT_Low 	:= NOT OUT_High;												//LOW FLOW REQUEST DUE TO VARIATION IN TOLERANCE
	
END_FUNCTION_BLOCK