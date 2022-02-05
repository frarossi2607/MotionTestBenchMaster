FUNCTION_BLOCK Valve_Mod
	IF NOT VAR_FirstCycle THEN
		memset(ADR(HMI),0,SIZEOF(HMI));
		HMI.ManOff		:= FALSE;
		HMI.ManOn		:= FALSE;	
		VAR_FirstCycle	:= TRUE;
	END_IF

	(*IO*)
	IF NOT IN_Simulation AND IN_ConfigPositionSensorOpened AND IN_ConfigPositionSensorClosed THEN
		VAR_DIFeedBackOpen	:= IO.Valve.DI_Opened;
		VAR_DIFeedBackClose	:= IO.Valve.DI_Closed;
	ELSIF NOT IN_Simulation AND IN_ConfigPositionSensorOpened AND NOT IN_ConfigPositionSensorClosed THEN
		VAR_DIFeedBackOpen	:= IO.Valve.DI_Opened;
		VAR_DIFeedBackClose	:= NOT IO.Valve.DI_Opened;
	ELSIF NOT IN_Simulation AND NOT IN_ConfigPositionSensorOpened AND IN_ConfigPositionSensorClosed THEN	
		VAR_DIFeedBackOpen	:= NOT IO.Valve.DI_Closed;
		VAR_DIFeedBackClose	:= IO.Valve.DI_Closed;
	ELSE
		VAR_DIFeedBackOpen	:= VAR_DOValveOn;
		VAR_DIFeedBackClose	:= VAR_DOValveOff;
	END_IF
	
	IF NOT IN_Simulation THEN
		VAR_iFault			:= VAR_Fault;	
		VAR_Mask 			:= HMI.Mask AND IN_MaskEn;		
	ELSE
		VAR_iFault			:= HMI.Mask;
		VAR_Mask 			:= FALSE;
	END_IF	

	(*Local*)
	IF IN_HMIAutoForce OR NOT IN_ManEn THEN
		HMI.ManOn	:= FALSE;
		HMI.ManOff	:= FALSE;
	END_IF
		
	VAR_ManOn 			:= HMI.ManOn;
	VAR_Auto			:= NOT HMI.ManOff AND NOT HMI.ManOn;
	VAR_OutMan			:= HMI.OUT_Man;
	VAR_ConfigPosition	:= IN_ConfigPositionSensorOpened OR IN_ConfigPositionSensorClosed;

	IF IN_ConfigPresent THEN
		IF IN_Enable THEN
			IF VAR_Auto AND IN_AutoCnd THEN
				VAR_iOpen := IN_AutoVal;  
			ELSIF VAR_ManOn THEN		
				VAR_iOpen := VAR_OutMan;
			ELSE
				VAR_iOpen := 0.0;
			END_IF
		ELSE 
			VAR_iOpen := 0.0;
		END_IF

		(*****************************************************************)
		(****************************FAULTS*******************************)
		(*****************************************************************)
		IF IN_ConfigPositionSensorOpened THEN
			IF ((VAR_Open = 0.0) AND (VAR_DIFeedBackOpen) OR (VAR_Open = 100.0) AND (NOT VAR_DIFeedBackOpen)) THEN
				VAR_FaultSensorOn := TRUE;
			ELSE
				VAR_FaultSensorOn := FALSE;
			END_IF
		ELSE
			VAR_FaultSensorOn := FALSE;
		END_IF 
		
		IF IN_ConfigPositionSensorClosed THEN
			IF ((VAR_Open = 0.0) AND (NOT VAR_DIFeedBackClose) OR (VAR_Open = 100.0) AND (VAR_DIFeedBackClose)) THEN
				VAR_FaultSensorOff := TRUE;
			ELSE
				VAR_FaultSensorOff := FALSE;
			END_IF
		ELSE
			VAR_FaultSensorOff := FALSE;	
		END_IF
		
		IF IN_ConfigPositionAnalogFBK THEN
			IF (HMI.FBK > HMI.OUT_CV + (HMI.OUT_CV / 10.0) + 5.0) OR (MAX(HMI.FBK, 5.0) < HMI.OUT_CV - (HMI.OUT_CV / 10.0)) THEN
				VAR_FaultSensorFBK := TRUE;
			ELSE
				VAR_FaultSensorFBK := FALSE;
			END_IF
		ELSE
			VAR_FaultSensorFBK := FALSE;				
		END_IF	

		TMR_TON_PositionFiltered(	IN := VAR_FaultSensorOn OR VAR_FaultSensorOff OR VAR_FaultSensorFBK,
		PT	:= IN_StrokeTime);

		IF (TMR_TON_PositionFiltered.Q OR OUT_FBKFault) AND NOT VAR_Mask THEN
			OUT_Alarm := TRUE;
		ELSIF IN_Reset THEN
			OUT_Alarm := FALSE;
		END_IF	
	
		(*****************************************************************)
		(*****************************RAMP********************************)
		(*****************************************************************)
		IF IN_OpeningRampEn THEN
			VAR_OpeningRamp := IN_OpeningRampValue;
		ELSE
			VAR_OpeningRamp := 100.0;
		END_IF
		
		IF IN_ClosingRampEn THEN
			VAR_ClosingRamp := IN_ClosingRampValue;
		ELSE
			VAR_ClosingRamp := 100.0;
		END_IF
		
		LCRMovingRamp(
		enable	:= TRUE, 
		x		:= LIMIT(IN_OutMin, VAR_iOpen, IN_OutMax), 
		dy_up	:= MAX(0.1, VAR_OpeningRamp),
		dy_down	:= MAX(0.1, VAR_ClosingRamp),
		y_max	:= IN_OutMax, 
		y_min	:= IN_OutMin, 
		y_set	:= LIMIT(IN_OutMin, VAR_iOpen, IN_OutMax), 
		set		:= (NOT IN_ClosingRampEn AND NOT IN_OpeningRampEn) 
		);
				
		VAR_Open := LCRMovingRamp.y;
		OUT_RampDone := LCRMovingRamp.x_reached;
		
		(*****************************************************************)
		(****************************VALUE SCALING************************)
		(*****************************************************************)
		IF IN_ConfigPositionAnalogFBK THEN
			OUT_FBKFault := (IO.AI_Raw < 6000);
		ELSIF IN_Reset THEN
			OUT_FBKFault := FALSE;
		END_IF
		
		IF IN_ConfigNormallyOpen THEN
			LCRLimScal_AO(
			x	:= VAR_Open, 
			x1	:= 0.0, 
			y1	:= 32767.0, 
			x2	:= 100.0, 
			y2	:= 6553.4,
			);
			
			LCRLimScal_AI(
			x	:= INT_TO_REAL(IO.AI_Raw), 
			x1	:= 32767.0, 
			y1	:= 0.0, 
			x2	:= 6553.4, 
			y2	:= 100.0
			);
		ELSE
			LCRLimScal_AO(
			x	:= VAR_Open, 
			x1	:= 0.0, 
			y1	:= 6553.4, 
			x2	:= 100.0, 
			y2	:= 32767.0
			);
					
			LCRLimScal_AI(
			x	:= INT_TO_REAL(IO.AI_Raw), 
			x1	:= 6553.4,
			y1	:= 0.0, 
			x2	:= 32767.0, 
			y2	:= 100.0
			);
		END_IF
		OUT_Cv		:= VAR_Open;
	ELSE
		OUT_Alarm		:= FALSE;
		OUT_RampDone	:= FALSE;
		OUT_Cv			:= 0.0;
	END_IF
	
	TMR_TOF_DOValveOn(	IN := VAR_Open > 0.0,
	PT := t#5s);
						
	VAR_DOValveOn 	:= TMR_TOF_DOValveOn.Q;
	VAR_DOValveOff 	:= NOT VAR_DOValveOn;	
	
	IF IN_ConfigPositionAnalogFBK THEN
		OUT_FBK	:= LCRLimScal_AI.y;
		HMI.FBK := REAL_TO_INT(LCRLimScal_AI.y);
	ELSE
		HMI.FBK := HMI.OUT_CV;
	END_IF
	(*****************************************************************)
	(****************************IO / HMI*****************************)
	(*****************************************************************)
	IO.AO_Raw := REAL_TO_INT(LCRLimScal_AO.y);
	
	IF NOT IN_Simulation THEN
		IF IN_ConfigNormallyOpen THEN
			IO.Valve.DO_Opened	:= IN_Enable;
			IO.Valve.DO_Closed	:= FALSE;
		ELSE
			IO.Valve.DO_Opened	:= VAR_DOValveOn;
			IO.Valve.DO_Closed	:= VAR_DOValveOff;
		END_IF
	ELSE
		IO.Valve.DO_Opened 	:= FALSE;
		IO.Valve.DO_Closed 	:= FALSE;
		IO.AO_Raw	:= 0;
		IO.AI_Raw	:= REAL_TO_INT(LCRLimScal_AO.y);
	END_IF
	
	HMI.ManEnable 		:= IN_ManEn;
	HMI.ConfigPresent 	:= IN_ConfigPresent;
	HMI.ConfigPosition 	:= VAR_ConfigPosition;
	HMI.MaskEnable		:= IN_MaskEn;
	HMI.Alarm  			:= OUT_Alarm;
	HMI.Opened 			:= VAR_DOValveOn;
	HMI.Closed 			:= VAR_DOValveOff;
	HMI.Out 			:= VAR_DOValveOn;
	HMI.OUT_CV			:= OUT_Cv;
END_FUNCTION_BLOCK