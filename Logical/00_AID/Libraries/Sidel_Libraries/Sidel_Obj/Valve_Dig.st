FUNCTION_BLOCK Valve_Dig
	IF NOT IN_Simulation AND IN_ConfigPositionSensorOpened AND IN_ConfigPositionSensorClosed AND NOT VAR_Mask THEN
		TMR_TOF_FeedBackOpen.IN 	:= IO.DI_Opened;
		VAR_FeedBackOpen			:= TMR_TOF_FeedBackOpen.Q;
		TMR_TOF_FeedBackClose.IN	:= IO.DI_Closed;
		VAR_FeedBackClose			:= TMR_TOF_FeedBackClose.Q;
	ELSIF NOT IN_Simulation AND IN_ConfigPositionSensorOpened AND NOT IN_ConfigPositionSensorClosed AND NOT VAR_Mask THEN
		TMR_TOF_FeedBackOpen.IN 	:= IO.DI_Opened;
		VAR_FeedBackOpen			:= TMR_TOF_FeedBackOpen.Q;
		TMR_TOF_FeedBackClose.IN	:= NOT IO.DI_Opened;
		VAR_FeedBackClose			:= TMR_TOF_FeedBackClose.Q;
	ELSIF NOT IN_Simulation AND NOT IN_ConfigPositionSensorOpened AND IN_ConfigPositionSensorClosed AND NOT VAR_Mask THEN
		TMR_TOF_FeedBackOpen.IN 	:= NOT IO.DI_Closed;
		VAR_FeedBackOpen			:= TMR_TOF_FeedBackOpen.Q;
		TMR_TOF_FeedBackClose.IN	:= IO.DI_Closed;
		VAR_FeedBackClose			:= TMR_TOF_FeedBackClose.Q;
	ELSE
		TMR_TOF_FeedBackOpen.IN 	:= VAR_ValveOpened;
		VAR_FeedBackOpen			:= TMR_TOF_FeedBackOpen.Q;
		TMR_TOF_FeedBackClose.IN	:= NOT VAR_ValveOpened;
		VAR_FeedBackClose			:= TMR_TOF_FeedBackClose.Q;
	END_IF
	
	TMR_TOF_FeedBackOpen.PT		:= t#50ms;
	TMR_TOF_FeedBackOpen();
	TMR_TOF_FeedBackClose.PT	:= t#50ms;
	TMR_TOF_FeedBackClose();
	
	IF NOT IN_Simulation THEN
		VAR_Enable	:= IN_Enable;
		VAR_iFault	:= VAR_Fault; 
		VAR_Mask	:= HMI.Mask AND IN_MaskEn;
	ELSE
		VAR_Enable	:= TRUE;
		VAR_iFault	:= HMI.Mask;
		VAR_Mask	:= FALSE;
	END_IF
	
	(* Local *)
	IF IN_ManEn AND NOT IN_HMIAutoForce THEN
		VAR_ManOn	:= HMI.ManOn;
		VAR_Auto	:= NOT HMI.ManOff AND NOT HMI.ManOn;
	ELSE
		VAR_ManOn	:= FALSE;
		VAR_Auto	:= TRUE;
		HMI.ManOn	:= FALSE;
		HMI.ManOff	:= FALSE;
	END_IF
	
	VAR_ConfigPosition	:= (IN_ConfigPositionSensorOpened OR IN_ConfigPositionSensorClosed) AND IN_MaskEn;
	VAR_AutoCnd := (IN_AutoCnd AND (IN_Cnd OR NOT IN_EnableCnd)) OR (IN_FlipRequest AND NOT OUT_FlipDone AND IN_FlipEnable);
	
	TMR_TON_Flip(	IN  := IN_FlipRequest,
					PT  := MIN(IN_FlipTime, MAX_Flip_Time));
	
	IF IN_FlipEnable THEN
		OUT_FlipDone := TMR_TON_Flip.Q;
	ELSE   
		OUT_FlipDone := IN_FlipRequest;
	END_IF 
	
	IF IN_ConfigPresent THEN
		IF IN_ConfigType THEN
			IF VAR_Enable THEN
				IF VAR_Auto THEN
					VAR_ValveOpened := VAR_AutoCnd;
				ELSIF VAR_ManOn THEN
					VAR_ValveOpened := TRUE;
				ELSE
					VAR_ValveOpened := FALSE;
				END_IF
				VAR_ValveClosed := NOT VAR_ValveOpened;
			ELSE
				VAR_ValveOpened := FALSE;
				VAR_ValveClosed := FALSE;
			END_IF
		ELSE
			IF VAR_Enable THEN
				IF VAR_Auto THEN
					VAR_ValveOpened := VAR_AutoCnd;
				ELSIF VAR_ManOn THEN
					VAR_ValveOpened := TRUE;
				ELSE
					VAR_ValveOpened := FALSE;
				END_IF
			ELSE
				VAR_ValveOpened := FALSE;
			END_IF
			VAR_ValveClosed := NOT VAR_ValveOpened;
		END_IF
	       
		(*********************** Alarm Logic ************************)
		TMR_TON_ControlEnableDelay(	IN := IN_ConfigPositionSensorOpened OR IN_ConfigPositionSensorClosed,
									PT := t#300ms);
	
		IF TMR_TON_ControlEnableDelay.Q THEN
			TMR_TON_Opened  (IN := VAR_ValveOpened, PT := IN_StrokeTime);
			TMR_TON_Closed	(IN := VAR_ValveClosed, PT := IN_StrokeTime);
			IF TMR_TON_Closed.Q AND (VAR_FeedBackOpen OR NOT VAR_FeedBackClose) THEN
				VAR_Fault := TRUE;
			ELSIF TMR_TON_Opened.Q AND (NOT VAR_FeedBackOpen OR VAR_FeedBackClose) THEN 
				VAR_Fault := TRUE;
			ELSIF IN_Reset THEN
				VAR_Fault := FALSE;
			END_IF
		ELSIF IN_Reset THEN
			VAR_Fault := FALSE;
		END_IF   
		
		OUT_Alarm := VAR_iFault;
	      
		TMR_TON_ClosedFilter.IN := VAR_FeedBackClose AND NOT VAR_FeedBackOpen;
		TMR_TON_ClosedFilter.PT := T#500ms;
		TMR_TON_ClosedFilter(); 
		
		OUT_ClosedFiltered := TMR_TON_ClosedFilter.Q;
	
		TMR_TON_OpenedFilter.IN := NOT VAR_FeedBackClose AND VAR_FeedBackOpen;
		TMR_TON_OpenedFilter.PT := T#500ms;
		TMR_TON_OpenedFilter();
		    
		OUT_OpenedFiltered 	:= TMR_TON_OpenedFilter.Q;
	 	OUT					:= VAR_ValveOpened;
	ELSE
		OUT_Alarm				:= FALSE;
		OUT_ClosedFiltered		:= NOT VAR_AutoCnd;
		OUT_OpenedFiltered		:= VAR_AutoCnd;
		OUT						:= VAR_AutoCnd;
		VAR_ValveOpened			:= FALSE;
		VAR_ValveClosed			:= FALSE;
		VAR_iFault				:= FALSE;
	END_IF
	
	(* HMI *)
	HMI.ManEnable		:= IN_ManEn;
	HMI.ConfigPresent	:= IN_ConfigPresent;
	HMI.ConfigPosition	:= VAR_ConfigPosition;
	HMI.MaskEnable		:= IN_MaskEn;
	HMI.Alarm			:= VAR_iFault;

	IF IN_ConfigNormallyOpen THEN //v1.5
		HMI.Opened			:= OUT_ClosedFiltered; //v1.5
		HMI.Closed			:= OUT_OpenedFiltered; //v1.5
	ELSE
		HMI.Opened			:= OUT_OpenedFiltered;
		HMI.Closed			:= OUT_ClosedFiltered;
	END_IF //v1.5
	
	(* IO *)
	IF NOT IN_Simulation THEN
		IO.DO_Opened	:= VAR_ValveOpened;
		IO.DO_Closed	:= VAR_ValveClosed;
		HMI.Out			:= IO.DO_Opened;
	ELSE
		IO.DO_Opened	:= FALSE;
		IO.DO_Closed	:= FALSE;
		HMI.Out			:= VAR_ValveOpened;
	END_IF
END_FUNCTION_BLOCK
