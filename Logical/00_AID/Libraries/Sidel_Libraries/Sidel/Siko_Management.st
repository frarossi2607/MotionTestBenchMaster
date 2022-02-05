(********************************************************************
 * COPYRIGHT -- Sidel
 ********************************************************************
 * Library: SIDEL
 * File: Siko_Management.st
 * Author: 100383
 * Created: November 23, 2015
 ********************************************************************
 * Implementation of library SIDEL
 ********************************************************************) 

FUNCTION_BLOCK Siko_Management
	
	IF IN_SikoData.AbortPositioning AND NOT IN_SikoData.PositioningInProgress THEN
		IN_SikoData.AbortPositioning := FALSE;
	END_IF
	
	IN_SikoData.Enable := IN_HMI_MotEnable;
	
	IN_SikoData.StartWrite	:= IN_HMI_StartWrite;
	IN_SikoData.Calibrate	:= IN_HMI_Calibrate;
	IN_SikoData.StartRead	:= IN_HMI_StartRead;
	
	StepTimer();
	
	CASE IN_Mode OF
		0:
			IN_SikoData.TargetPos	:= IN_SikoData.CurrentPos;
		
		1:
			IN_SikoData.TargetPos	:= IN_PosProduction;
			
		2:
			IN_SikoData.TargetPos	:= IN_PosCleaning;
			
		ELSE
			IN_Mode := 0;
			Status	:= 0;
			
	END_CASE
	
	CASE Status OF
		0:		//Ready IDLE
			OUT_Running			:= FALSE;
			OUT_Done			:= FALSE;			
			OUT_PositionError	:= FALSE;
			
			IN_SikoData.StartPositioning := FALSE;
		
			IN_SikoData.JogBackward    := IN_HMI_JogBackward AND NOT IN_HMI_MoveAt AND IN_HMI_ManualEnable;  
			IN_SikoData.JogForward     := IN_HMI_JogForward  AND NOT IN_HMI_MoveAt AND IN_HMI_ManualEnable;
			
			StepTimer.IN := FALSE;
			StepTimer.PT := t#0s;
			
			IF IN_Mode = 1  AND NOT IN_HMI_ManualEnable THEN
				Status := 100;
			END_IF
			
			IF IN_Mode = 2 AND NOT IN_HMI_ManualEnable THEN
				Status := 200;
			END_IF
		
			IF IN_Mode = 0 AND EDGENEG(IN_HMI_MoveAt) AND NOT IN_HMI_JogForward AND NOT IN_HMI_JogBackward AND IN_HMI_ManualEnable THEN
				IN_SikoData.TargetPos := IN_PosManualSP;
				Status	:= 10;				
			END_IF
			
		10:		//Manual positioning
			OUT_Running			:= FALSE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			StepTimer.IN	:= TRUE;
			StepTimer.PT	:= t#240s;
			
			IN_SikoData.StartPositioning	:=	IN_SikoData.CalibrationDone			AND NOT IN_SikoData.OnError					AND NOT
												IN_SikoData.CommunicationFault		AND NOT IN_SikoData.MotorDisabled			AND IN_SikoData.EmergencyOkFbk	AND NOT
												IN_SikoData.TargetOutsideSwLimit	AND NOT IN_SikoData.DeviceOutsideSwLimit;
			
			IN_SikoData.TargetPos			:= IN_PosManualSP;
			
			//Motor in position
			IF IN_SikoData.InPosition THEN
				IN_SikoData.StartPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status := 0;
			END_IF
			
			//Timeout positioning or change modality
			IF StepTimer.Q OR EDGEPOS(IN_HMI_MoveAt) OR NOT IN_HMI_ManualEnable OR IN_Mode <> 0 THEN
				IN_SikoData.StartPositioning := FALSE;
				IN_SikoData.AbortPositioning := TRUE;
				StepTimer.IN := FALSE;
				Status := 20;
			END_IF
		
		20:		//Abort command. Wait 0.5s motor stop before changing mode or make a new operation
			OUT_Running			:= FALSE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			StepTimer.IN	:= TRUE;
			StepTimer.PT	:= t#0.5s;
			
			IN_SikoData.StartPositioning := FALSE;
			
			IF StepTimer.Q AND NOT IN_HMI_MoveAt THEN
				IN_SikoData.AbortPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status := 0;
			END_IF
			
		100:	//Production
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			OUT_PositionError := FALSE;
			
			IN_SikoData.StartPositioning := FALSE;
			
			IF IN_Mode <> 1 THEN
				StepTimer.IN := FALSE;
				Status := 0;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				StepTimer.IN := FALSE;
				Status := 150;
			END_IF
			
			IF IN_SikoData.InPosition THEN
				OUT_Done := TRUE;
				StepTimer.IN := FALSE;
				Status := 120;
			ELSE
				IF NOT IN_SikoData.PositioningInProgress AND IN_EnableToRun THEN //v049
					StepTimer.IN := FALSE;
					Status := 110;
				END_IF
			END_IF
			
		110:	//Production - Wait for positioning
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			StepTimer.PT	:= t#240s;
			
			OUT_PositionError := FALSE;
			
			IN_SikoData.StartPositioning := IN_SikoData.CalibrationDone			AND NOT IN_SikoData.OnError					AND NOT
											IN_SikoData.CommunicationFault		AND NOT IN_SikoData.MotorDisabled			AND IN_SikoData.EmergencyOkFbk	AND NOT
											IN_SikoData.TargetOutsideSwLimit	AND NOT IN_SikoData.DeviceOutsideSwLimit;
			
			StepTimer.IN := IN_SikoData.StartPositioning;
			
			//Motor in position
			IF IN_SikoData.InPosition THEN
				StepTimer.IN := FALSE;
				Status := 120;
			END_IF
			
			IF IN_SikoData.OnError OR StepTimer.Q OR IN_SikoData.CommunicationFault OR IN_SikoData.TargetOutsideSwLimit THEN
				IN_SikoData.AbortPositioning := TRUE;
				IN_SikoData.StartPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status := 130;
			END_IF
			
			IF NOT IN_SikoData.EmergencyOkFbk THEN
				IN_SikoData.StartPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status := 140;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				StepTimer.IN := FALSE;
				Status := 150;
			END_IF
			
			IF IN_Mode <> 1 THEN
				StepTimer.IN := FALSE;
				Status := 190;
			END_IF
			
		120:	//Motor in position
			OUT_Running			:= TRUE;
			OUT_Done			:= TRUE;
			OUT_PositionError	:= FALSE;
			
			IN_SikoData.StartPositioning := FALSE;
			StepTimer.IN	:= FALSE;
			
			IF NOT IN_SikoData.InPosition THEN
				Status := 160;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				Status := 150;
			END_IF
			
			IF IN_Mode <> 1 THEN
				Status := 0;
			END_IF
			
		130:	//Error during positioning phase. Aknoledge required
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= TRUE;
			
			IN_SikoData.StartPositioning := FALSE;
			StepTimer.IN	:= FALSE;
							
			IF IN_Reset THEN
				IN_SikoData.AbortPositioning := FALSE;
				OUT_PositionError := FALSE;
				Status := 100;
			END_IF
			
			IF IN_HMI_MoveAt THEN
				IN_SikoData.AbortPositioning := FALSE;
				OUT_PositionError := FALSE;
				Status := 131;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				IN_SikoData.AbortPositioning := FALSE;
				OUT_PositionError := FALSE;
				Status := 150;
			END_IF
			
			IF IN_Mode <> 1 THEN
				IN_SikoData.AbortPositioning :=FALSE;
				StepTimer.PT :=FALSE;
				Status :=0;
			END_IF
			
		131: 	//Error during positioning phase. Manual positioning
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			IN_SikoData.StartPositioning := FALSE;
			StepTimer.IN	:= TRUE;
			StepTimer.PT	:= t#240s;
			
			IN_SikoData.StartPositioning := IN_SikoData.CalibrationDone			AND NOT IN_SikoData.OnError					AND NOT
											IN_SikoData.CommunicationFault		AND NOT IN_SikoData.MotorDisabled			AND IN_SikoData.EmergencyOkFbk	AND NOT
											IN_SikoData.TargetOutsideSwLimit	AND NOT IN_SikoData.DeviceOutsideSwLimit;
            
			//Motor in position
			IF IN_SikoData.InPosition AND NOT IN_HMI_MoveAt THEN
				IN_SikoData.StartPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status := 120;
			END_IF
			
			//Timeout positioning
			IF StepTimer.Q THEN
				IN_SikoData.StartPositioning := FALSE;
				IN_SikoData.AbortPositioning := TRUE;
				StepTimer.IN := FALSE;
				Status := 130;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				IN_SikoData.AbortPositioning := TRUE;
				OUT_PositionError := FALSE;
				Status := 150;
			END_IF
			
			IF IN_Mode <> 1 THEN
				IN_SikoData.StartPositioning := FALSE;
				IN_SikoData.AbortPositioning := TRUE;
				StepTimer.IN := FALSE;
				Status := 132;
			END_IF
		
		132:		//Abort command. Wait 0.5s before changing mode or make a new operation
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			StepTimer.IN	:= TRUE;
			StepTimer.PT	:= t#0.5s;
			
			IN_SikoData.StartPositioning := FALSE;
			
			IF StepTimer.Q AND NOT IN_HMI_MoveAt THEN
				IN_SikoData.AbortPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status := 0;
			END_IF

		140:	//Emergency
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			IN_SikoData.StartPositioning := FALSE;
			
			IF IN_SikoData.EmergencyOkFbk THEN
				StepTimer.IN := FALSE;
				Status := 100;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				Status := 150;
			END_IF
			
			IF IN_Mode <> 1 THEN
				Status := 0;
			END_IF
			
		150:	//Motor disabled
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			IN_SikoData.StartPositioning := FALSE;
			IN_SikoData.AbortPositioning := FALSE;
			
			IF NOT IN_SikoData.MotorDisabled THEN
				StepTimer.IN := FALSE;
				Status := 130;
			END_IF
			
			IF IN_Mode <> 1 THEN
				Status := 0;
			END_IF

		160:	//Positioning lost
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			IF IN_SikoData.MotorDisabled OR IN_Reset THEN
				StepTimer.IN := FALSE;
				Status := 100;
			END_IF
			
			IF IN_Mode <> 1 THEN
				Status := 0;
			END_IF
			
		190: //Exit step
			OUT_Running			:= FALSE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
		
			StepTimer.IN := TRUE;
			StepTimer.PT := t#2s;
			
			IN_SikoData.AbortPositioning := TRUE;
			IN_SikoData.StartPositioning := FALSE;
			
			IF StepTimer.Q AND NOT IN_HMI_MoveAt THEN
				IN_SikoData.AbortPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status	:= 0;
			END_IF
			
		200:	//Cleaning
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			IN_SikoData.StartPositioning := FALSE;
			
			IF IN_Mode <> 2 THEN
				StepTimer.IN := FALSE;
				Status := 0;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				StepTimer.IN := FALSE;
				Status := 250;
			END_IF
			
			IF IN_SikoData.InPosition THEN
				OUT_Done := TRUE;
				StepTimer.IN := FALSE;
				Status := 220;
			ELSE
				IF NOT IN_SikoData.PositioningInProgress AND IN_EnableToRun THEN //v049
					StepTimer.IN := FALSE;
					Status := 210;
				END_IF
			END_IF
			
		210:	//Cleaning - Wait for position
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			StepTimer.PT := t#240s;
			
			IN_SikoData.StartPositioning := IN_SikoData.CalibrationDone			AND NOT IN_SikoData.OnError					AND NOT
											IN_SikoData.CommunicationFault		AND NOT IN_SikoData.MotorDisabled			AND IN_SikoData.EmergencyOkFbk	AND NOT
											IN_SikoData.TargetOutsideSwLimit	AND NOT IN_SikoData.DeviceOutsideSwLimit;
			
			StepTimer.IN := IN_SikoData.StartPositioning;
			
			IF IN_SikoData.InPosition THEN
				StepTimer.IN := FALSE;
				Status := 220;
			END_IF
			
			IF IN_SikoData.OnError OR StepTimer.Q OR IN_SikoData.CommunicationFault OR IN_SikoData.TargetOutsideSwLimit THEN
				IN_SikoData.AbortPositioning := TRUE;
				IN_SikoData.StartPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status := 230;
			END_IF
			
			IF NOT IN_SikoData.EmergencyOkFbk THEN
				IN_SikoData.StartPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status := 240;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				StepTimer.IN := FALSE;
				Status := 250;
			END_IF
			
			IF IN_Mode <> 2 THEN
				StepTimer.IN := FALSE;
				Status := 290;
			END_IF 
			
		220: 	//Motor in position
			OUT_Running			:= TRUE;
			OUT_Done			:= TRUE;
			OUT_PositionError	:= FALSE;
			
			IN_SikoData.StartPositioning := FALSE;
			StepTimer.IN := FALSE;
			
			IF NOT IN_SikoData.InPosition THEN
				Status := 260;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				Status := 250;
			END_IF
			
			IF IN_Mode <> 2 THEN
				Status := 0;
			END_IF
			
		230:
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= TRUE;
			
			IN_SikoData.StartPositioning := FALSE;
			StepTimer.IN	:= FALSE;
							
			IF IN_Reset THEN
				IN_SikoData.AbortPositioning := FALSE;
				OUT_PositionError := FALSE;
				Status := 200;
			END_IF
			
			IF IN_HMI_MoveAt THEN
				IN_SikoData.AbortPositioning := FALSE;
				OUT_PositionError := FALSE;
				Status := 231;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				IN_SikoData.AbortPositioning := FALSE;
				OUT_PositionError := FALSE;
				Status := 250;
			END_IF
			
			IF IN_Mode <> 2 THEN
				IN_SikoData.AbortPositioning :=FALSE;
				StepTimer.PT :=FALSE;
				Status :=0;
			END_IF
			
		231: 	//Error during positioning phase. Manual positioning
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			IN_SikoData.StartPositioning := FALSE;
			StepTimer.IN	:= TRUE;
			StepTimer.PT	:= t#240s;
			
			IN_SikoData.StartPositioning := IN_SikoData.CalibrationDone			AND NOT IN_SikoData.OnError					AND NOT
											IN_SikoData.CommunicationFault		AND NOT IN_SikoData.MotorDisabled			AND IN_SikoData.EmergencyOkFbk	AND NOT
											IN_SikoData.TargetOutsideSwLimit	AND NOT IN_SikoData.DeviceOutsideSwLimit;
            
			//Motor in position
			IF IN_SikoData.InPosition AND NOT IN_HMI_MoveAt THEN
				IN_SikoData.StartPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status := 220;
			END_IF
			
			//Timeout positioning
			IF StepTimer.Q THEN
				IN_SikoData.StartPositioning := FALSE;
				IN_SikoData.AbortPositioning := TRUE;
				StepTimer.IN := FALSE;
				Status := 230;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				IN_SikoData.AbortPositioning := TRUE;
				OUT_PositionError := FALSE;
				Status := 250;
			END_IF
			
			IF IN_Mode <> 1 THEN
				IN_SikoData.StartPositioning := FALSE;
				IN_SikoData.AbortPositioning := TRUE;
				StepTimer.IN := FALSE;
				Status := 232;
			END_IF
		
		232:		//Abort command. Wait 0.5s before changing mode or make a new operation
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			StepTimer.IN	:= TRUE;
			StepTimer.PT	:= t#0.5s;
			
			IN_SikoData.StartPositioning := FALSE;
			
			IF StepTimer.Q AND NOT IN_HMI_MoveAt THEN
				IN_SikoData.AbortPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status := 0;
			END_IF
			
		240: 	//Emergency
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			IN_SikoData.StartPositioning := FALSE;
			
			IF IN_SikoData.EmergencyOkFbk THEN
				StepTimer.IN := FALSE;
				Status := 200;
			END_IF
			
			IF IN_SikoData.MotorDisabled THEN
				Status := 250;
			END_IF
			
			IF IN_Mode <> 2 THEN
				Status := 0;
			END_IF
	
		250:	//Motor disabled
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
				
			IN_SikoData.StartPositioning := FALSE;
			IN_SikoData.AbortPositioning := FALSE;
			
			IF NOT IN_SikoData.MotorDisabled THEN
				StepTimer.IN := FALSE;
				Status := 230;
			END_IF
				
			IF IN_Mode <> 2 THEN
				Status := 0;
			END_IF
		
		260:	//Positioning lost
			OUT_Running			:= TRUE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
			
			IF IN_SikoData.MotorDisabled OR IN_Reset THEN
				StepTimer.IN := FALSE;
				Status := 200;
			END_IF
			
			IF IN_Mode <> 2 THEN
				Status := 0;
			END_IF
			
		290: //Exit step.
			OUT_Running			:= FALSE;
			OUT_Done			:= FALSE;
			OUT_PositionError	:= FALSE;
		
			StepTimer.IN := TRUE;
			StepTimer.PT := t#2s;
			
			IN_SikoData.AbortPositioning := TRUE;
			IN_SikoData.StartPositioning := FALSE;
			
			IF StepTimer.Q AND NOT IN_HMI_MoveAt THEN
				IN_SikoData.AbortPositioning := FALSE;
				StepTimer.IN := FALSE;
				Status	:= 0;
			END_IF
			
		ELSE
			Status := 0;
	END_CASE			
END_FUNCTION_BLOCK