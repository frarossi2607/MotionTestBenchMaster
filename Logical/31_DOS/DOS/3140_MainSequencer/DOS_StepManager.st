ACTION DOS_StepManager:
	//PROD
	VAR_DOS_SeqProdStopAlarm := NOT OPS.DataOut.EmergencyOk OR NOT OPS.DataOut.DoorsOk OR VAR_DOS_AVJ_ValveFault OR VAR_DOS_NoBotNoFillPressureLow OR NOT PstFlr.ProductionMode;
	
	IF VAR_DOS_SeqProdStopAlarm THEN
		VAR_DOS_SeqProdStopRequest	:= VAR_DOS_ModeProduction OR VAR_DOS_FMDProductionFillerOnly;
	END_IF
	IF VAR_DOS_StepProdStopped THEN
		VAR_DOS_SeqProdStopRequest	:= FALSE;
	END_IF
	
	IF VAR_DOS_MemPBAbort THEN
		VAR_DOS_SeqProdAbortRequest	:= VAR_DOS_ModeProduction OR VAR_DOS_FMDProductionFillerOnly;
	END_IF
	IF VAR_DOS_StepProdAborted THEN
		VAR_DOS_SeqProdAbortRequest	:= FALSE;
	END_IF	
	
//	//CIP
//	VAR_DOS_SeqCipStopAlarm := NOT OPS.DataOut.EmergencyOk OR NOT OPS.DataOut.DoorsOk OR VAR_DOS_AVJ_ValveFault OR PPJ[202].OUT_DriveFault OR LTJ[203].OUT_Alarm OR TTJ[203].OUT_Alarm OR VAR_DOS_NoBotNoFillPressureLow OR
//	PPJ[202].OUT_OverloadFault; // leo OR PstFlr.CipAlarm OR (NOT PstFlr.CipProductSending AND VAR_DOS_StepCipCleaning); //CAPIRE SE CI VOGLIONO ANCHE i PstFlr
		
	IF  VAR_DOS_SeqCipStopAlarm OR VAR_DOS_MemPBStop THEN
		VAR_DOS_SeqCipStopRequest	:= VAR_DOS_ModeCip;
	END_IF
	IF VAR_DOS_StepCipStopped THEN
		VAR_DOS_SeqCipStopRequest	:= FALSE;
	END_IF
	
	IF  VAR_DOS_MemPBAbort OR PstFlr.CipRecipeAborted THEN 
		VAR_DOS_SeqCipAbortRequest	:= VAR_DOS_ModeCip;
	END_IF
	IF VAR_DOS_StepCipAborted THEN
		VAR_DOS_SeqCipAbortRequest	:= FALSE;	
	END_IF	
	
	//RINSE
	VAR_DOS_SeqRinseStopAlarm :=  NOT OPS.DataOut.EmergencyOk OR NOT OPS.DataOut.DoorsOk OR VAR_DOS_AVJ_ValveFault OR PPJ203.OUT_Alarm;
	
	IF VAR_DOS_MemPBStop OR VAR_DOS_SeqRinseStopAlarm THEN
		VAR_DOS_SeqRinseStopRequest	:= VAR_DOS_ModeRinse;
	END_IF
	IF VAR_DOS_StepRinseStopped THEN
		VAR_DOS_SeqRinseStopRequest	:= FALSE;
	END_IF
	
	IF VAR_DOS_MemPBAbort THEN
		VAR_DOS_SeqRinseAbortRequest := VAR_DOS_ModeRinse;
	END_IF
	IF VAR_DOS_StepRinseAborted THEN
		VAR_DOS_SeqRinseAbortRequest := FALSE;
	END_IF	
	
	//DRAIN
	VAR_DOS_SeqDrainStopAlarm := NOT OPS.DataOut.EmergencyOk OR NOT OPS.DataOut.DoorsOk OR VAR_DOS_AVJ_ValveFault;
		
	IF VAR_DOS_SeqDrainStopAlarm OR VAR_DOS_MemPBStop THEN
		VAR_DOS_SeqDrainStopRequest	:= VAR_DOS_ModeDrain;
	END_IF
	IF VAR_DOS_StepDrainStopped THEN
		VAR_DOS_SeqDrainStopRequest	:= FALSE;
	END_IF
	
	IF VAR_DOS_MemPBAbort THEN //SEQUENCE ABORT IS MANAGED BY STOP PB
		VAR_DOS_SeqDrainAbortRequest := VAR_DOS_ModeDrain;
	END_IF
	IF VAR_DOS_StepDrainAborted THEN
		VAR_DOS_SeqDrainAbortRequest := FALSE;	
	END_IF	

	//POSITION CONTROL FILIPPO
	VAR_DOS_SeqPositionRequest	:= VAR_DOS_SEQ.Mem.PositioningRequest;
	//VAR_DOS_SeqPositionReached; //DEFINITO NEL "LIFTING" DEL DOS FILIPPO
	
	//BYPASS
	VAR_DOS_SeqBypassStopAlarm := NOT OPS.DataOut.EmergencyOk OR NOT OPS.DataOut.DoorsOk OR GNS.DataOut.DosByPassAlarm;

	IF VAR_DOS_MemPBAbort THEN //SEQUENCE ABORT IS MANAGED BY STOP PB
		VAR_DOS_SeqBypassAbortRequest := VAR_DOS_StepCamPositioning;
	END_IF
	IF VAR_DOS_StepBypassAborted THEN
		VAR_DOS_SeqBypassAbortRequest := FALSE;	
	END_IF	
END_ACTION
