ACTION DOS_ModeSelection: 
	//WAIT MODE
	IF EDGEPOS(VAR_DOS_SeqPermanent.SeqActualStep = 0) THEN
		FOR VAR_DOS_ForIndex:=0 TO 4 DO //ALL OTHER SELECTIONS RESET
			HMI_DOS_SS2P[VAR_DOS_ForIndex].ON := FALSE;
		END_FOR;
	END_IF
	
	//SS2P PRODUCTION MODE SELECTION
	VAR_DOS_FMDProduction := HMI_DOS_SS2P[SS2P_DOS_ModeProdFast].ON AND REAL_TO_BOOL(HMI_PAR_1._216); //DOSER INCLUDED 
	VAR_DOS_FMDProductionFillerOnly	:= (TNK.DataOut.ProdMode OR TNK.DataOut.StartUp) AND NOT REAL_TO_BOOL(HMI_PAR_1._216) AND (MC_InputOutput.Network.Machine.Status.AutoModalityActive OR MC_InputOutput.Network.Machine.Status.AutoCombiModalityActive); //DOSER EXCLUDED RMH017 

	IF EDGEPOS(VAR_DOS_FMDProduction) THEN //ALL OTHER SELECTIONS RESET
		FOR VAR_DOS_ForIndex:=0 TO 5 DO
			IF VAR_DOS_ForIndex<>SS2P_DOS_ModeProdFast THEN	 
				HMI_DOS_SS2P[VAR_DOS_ForIndex].ON := FALSE;
			END_IF
		END_FOR;
	END_IF
	
	//SS2P DRAIN MODE SELECTION
	VAR_DOS_FMDDrain := HMI_DOS_SS2P[SS2P_DOS_ModeDrain].ON;
	
	IF EDGEPOS(VAR_DOS_FMDDrain) THEN //ALL OTHER SELECTIONS RESET
		FOR VAR_DOS_ForIndex:=0 TO 5 DO
			IF VAR_DOS_ForIndex<>SS2P_DOS_ModeDrain THEN	 
				HMI_DOS_SS2P[VAR_DOS_ForIndex].ON := FALSE;
			END_IF
		END_FOR;
	END_IF
	
	//SS2P CLEANING MODE SELECTION	
	VAR_DOS_FMDCip := HMI_DOS_SS2P[SS2P_DOS_ModeCip].ON;

	IF EDGEPOS(VAR_DOS_FMDCip) THEN //ALL OTHER SELECTIONS RESET
		FOR VAR_DOS_ForIndex:=0 TO 5 DO
			IF VAR_DOS_ForIndex<>SS2P_DOS_ModeCip THEN	 
				HMI_DOS_SS2P[VAR_DOS_ForIndex].ON := FALSE;
			END_IF
		END_FOR;
	END_IF
	
	//SS2P CLEANING RINSE MODE SELECTION	
	VAR_DOS_FMDRinse := HMI_DOS_SS2P[SS2P_DOS_ModeRinse].ON;

	IF EDGEPOS(VAR_DOS_FMDRinse) THEN //ALL OTHER SELECTIONS RESET
		FOR VAR_DOS_ForIndex:=0 TO 5 DO
			IF VAR_DOS_ForIndex<>SS2P_DOS_ModeRinse THEN	 
				HMI_DOS_SS2P[VAR_DOS_ForIndex].ON := FALSE;
			END_IF
		END_FOR;
	END_IF

	//SS2P CLEANING MODE SELECTION	
	VAR_DOS_FMDCop := (COP.DataOut.RcpActive AND COP.DataOut.DoserPositioningReq); //FILIPPO 
	
	//BYPASS REQUEST
	VAR_DOS_BypassRequest := NOT (REAL_TO_BOOL(HMI_PAR_1._216)) AND NOT MC_InputOutput.Network.Machine.Status.MultiModalityActive AND SFT.DataOut.MachineEmpty AND VAR_DOS_ModeWait;
	VAR_DOS_FMDByPass := (VAR_DOS_BypassRequest AND GNS.DataOut.DosIncluded) OR (NOT VAR_DOS_BypassRequest AND GNS.DataOut.DosByPassed);		
	
	//POSITION CONTROL
	VAR_DOS_FMDPositionRequest := VAR_DOS_SEQ.Mem.PositioningRequest;
	//VAR_DOS_FMDPositioning := faccio per CIP PROD RiNSE ecc..?? FILIPPO
	
	//SELECTION LOST - CHIEDI GALLUCCIO
	VAR_DOS_SelectionLost := NOT HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON AND
							(VAR_DOS_ModeProduction AND NOT VAR_DOS_FMDProduction) OR
							(VAR_DOS_ModeCip AND NOT VAR_DOS_FMDCip) OR
							(VAR_DOS_ModeRinse AND NOT VAR_DOS_FMDRinse) OR
							(VAR_DOS_ModeDrain AND NOT VAR_DOS_FMDDrain) OR
							(VAR_DOS_ModeCop AND NOT VAR_DOS_FMDCop);
	
	//PB START
	VAR_DOS_MemPBStart := EDGEPOS(HMI_DOS_PB[PB_CmdDosStart].ON);	
	
	//PB STOP
	VAR_DOS_MemPBStop	:= EDGEPOS(HMI_DOS_PB[PB_CmdDosStop].ON);
	
	//PB ABORT
	VAR_DOS_MemPBAbort	:= EDGEPOS(HMI_DOS_PB[PB_CmdDosAbort].ON);
	
	//PB SKIP FORWARD
	VAR_DOS_MemPBSkipForward	:= EDGEPOS(HMI_DOS_PB[PB_CmdDosSkip].ON);
	
	//PB PAUSE
	IF EDGEPOS(HMI_DOS_PB[PB_CmdDosPause].ON) THEN
		IF VAR_DOS_MemSSPause THEN 
			HMI_DOS_PB[PB_CmdDosPause].LampON	:= FALSE;
		ELSE
			HMI_DOS_PB[PB_CmdDosPause].LampON	:= TRUE;
		END_IF
	END_IF 	
	
	VAR_DOS_MemSSPause:= HMI_DOS_PB[PB_CmdDosPause].LampON;
END_ACTION
