ACTION RNS_StepManager: 
	//PROD
	VAR_RNS_SeqProdStopAlarm := VAR_RNS_AVB_ValveFault OR 
								VAR_RNS_WaterFlowTooLow OR VAR_RNS_WaterFlowMissing ;
	
	IF VAR_RNS_SeqProdStopAlarm THEN
		VAR_RNS_SeqProdStopRequest	:= VAR_RNS_ModeProduction;
	END_IF
	
	IF VAR_RNS_StepProdStopped OR VAR_RNS_StepProdLampOnDischarge THEN
		VAR_RNS_SeqProdStopRequest	:= FALSE;
	END_IF
	
	IF VAR_RNS_MemPBStop OR NOT VAR_RNS_FMDProduction THEN //SEQUENCE ABORT IS MANAGED BY STOP PB or finish tank process
		VAR_RNS_SeqProdAbortRequest	:= VAR_RNS_ModeProduction;
	END_IF
	IF VAR_RNS_StepProdAborted THEN
		VAR_RNS_SeqProdAbortRequest	:= FALSE;
	END_IF
	
	//CIP
	VAR_RNS_SeqCipStopAlarm := NOT OPS.DataOut.EmergencyOk OR NOT OPS.DataOut.DoorsOk OR VAR_RNS_AVB_ValveFault;
		
	IF  VAR_RNS_SeqCipStopAlarm THEN
		VAR_RNS_SeqCipStopRequest	:= VAR_RNS_ModeCip;
	END_IF
	IF VAR_RNS_StepCipStopped THEN
		VAR_RNS_SeqCipStopRequest	:= FALSE;
	END_IF
	
	IF  VAR_RNS_MemPBStop OR NOT VAR_RNS_FMDCip THEN //SEQUENCE ABORT IS MANAGED BY STOP PB
		VAR_RNS_SeqCipAbortRequest	:= VAR_RNS_ModeCip;
	END_IF
	IF VAR_RNS_StepCipAborted THEN
		VAR_RNS_SeqCipAbortRequest	:= FALSE;	
	END_IF	

	//DRAIN
	VAR_RNS_SeqDrainStopAlarm := NOT OPS.DataOut.EmergencyOk OR NOT OPS.DataOut.DoorsOk OR VAR_RNS_AVB_ValveFault;
		
	IF VAR_RNS_SeqDrainStopAlarm THEN
		VAR_RNS_SeqDrainStopRequest	:= VAR_RNS_ModeDrain;
	END_IF
	IF VAR_RNS_StepDrainStopped THEN
		VAR_RNS_SeqDrainStopRequest	:= FALSE;
	END_IF
	
	IF VAR_RNS_MemPBStop OR NOT VAR_RNS_FMDDrain THEN //SEQUENCE ABORT IS MANAGED BY STOP PB
		VAR_RNS_SeqDrainAbortRequest := VAR_RNS_ModeDrain;
	END_IF
	IF VAR_RNS_StepDrainAborted THEN
		VAR_RNS_SeqDrainAbortRequest := FALSE;	
	END_IF	
	
	//CONTROL
	VAR_RNS_SeqControlStopAlarm := 	NOT OPS.DataOut.EmergencyOk OR NOT OPS.DataOut.DoorsOk OR VAR_RNS_AVB_ValveFault OR 
									VAR_RNS_WaterFlowTooLow OR VAR_RNS_AirFlowTooLow OR VAR_RNS_WaterFlowMissing;
		
									
	IF VAR_RNS_SeqControlStopAlarm THEN
		VAR_RNS_SeqControlStopRequest	:= VAR_RNS_ModeControl;
	END_IF
	IF VAR_RNS_StepControlStopped THEN
		VAR_RNS_SeqControlStopRequest	:= FALSE;
	END_IF
	
	IF VAR_RNS_MemPBStop THEN //SEQUENCE ABORT IS MANAGED BY STOP PB
		VAR_RNS_SeqControlAbortRequest := VAR_RNS_ModeControl;
	END_IF
	IF VAR_RNS_StepControlAborted THEN
		VAR_RNS_SeqControlAbortRequest := FALSE;	
	END_IF	
	
END_ACTION
