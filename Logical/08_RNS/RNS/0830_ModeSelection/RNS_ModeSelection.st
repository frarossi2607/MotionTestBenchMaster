ACTION RNS_ModeSelection:
	IF NOT HMI_SS2P[SS2P_HMI_SelEnable].ON THEN
		HMI_RNS_SS2P[SS2P_SelAutoMan].ON := FALSE;
	END_IF
	
	//WAIT MODE
	IF EDGEPOS(VAR_RNS_SeqPermanent.SeqActualStep = 0) THEN
		FOR VAR_RNS_ForIndex:=1 TO 6 DO //ALL OTHER SELECTIONS RESET
			HMI_RNS_SS2P[VAR_RNS_ForIndex].ON := FALSE;
		END_FOR;
	END_IF


	//TREATMENT ACTIVE
	VAR_RNS_WaterTreatment := (HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND (HMI_RNS_ManualSelection.Value < 2)) OR (NOT HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND(HMI_PAR_1._170 < 2));
	//CONTROL TYPE REQUEST
	VAR_RNS_ControlInsercionRequest := (HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND HMI_RNS_SS2P[SS2P_RNS_InsControl].ON) OR (NOT HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND VAR_RNS_WaterTreatment);//HMI_PAR_1._171 > 0
	VAR_RNS_ControlContinousRequest	:= (HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND HMI_RNS_SS2P[SS2P_RNS_ContControl].ON) OR (NOT HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND VAR_RNS_AirTreatment);//HMI_PAR_1._171 < 1
	
	//On RMB220 Insercion control is for Water only and Continous control is for Air only
	IF HMI_RNS_SS2P[SS2P_SelAutoMan].ON THEN
		IF HMI_RNS_SS2P[SS2P_RNS_InsControl].ON THEN
			HMI_RNS_ManualSelection.Value := 1;//Water Only
		END_IF	
		IF HMI_RNS_SS2P[SS2P_RNS_ContControl].ON THEN
			HMI_RNS_ManualSelection.Value := 2;//Air Only
		END_IF	
	ELSE
		HMI_RNS_ManualSelection.Value := 0;
	END_IF	
	
	//SS2P PRODUCTION MODE SELECTION
	VAR_RNS_FMDProduction := (HMI_RNS_SS2P[SS2P_SelProduction].ON AND HMI_RNS_SS2P[SS2P_SelAutoMan].ON) OR
								(TNK.DataOut.ProdMode AND NOT HMI_RNS_SS2P[SS2P_SelAutoMan].ON);//vrma
	
	IF EDGEPOS(VAR_RNS_FMDProduction) THEN //ALL OTHER SELECTIONS RESET
		FOR VAR_RNS_ForIndex:=1 TO 6 DO//V4.A.A.1.7.0
			IF VAR_RNS_ForIndex<>SS2P_SelProduction THEN	 
				HMI_RNS_SS2P[VAR_RNS_ForIndex].ON := FALSE;
			END_IF
		END_FOR;
	END_IF
	
	//SS2P CONTROL MODE SELECTION //V4.A.A.1.7.0
	VAR_RNS_TotalContainerEntered := HMI_CounterDataTotal.ContainersCounters.CounterData[ContainersEntered].CounterValue;
	VAR_RNS_ControlRemainder := (VAR_RNS_TotalContainerEntered MOD (REAL_TO_UDINT(HMI_PAM_1._090)) AND CFG_Par.Rinser.PressureNozzleControlInsertion);//vrma
	VAR_RNS_ControlRemainder_Cont := (VAR_RNS_TotalContainerEntered MOD (REAL_TO_UDINT(HMI_PAM_1._091))AND CFG_Par.Rinser.PressureNozzleControlContinous);//vrma
	IF 	NOT VAR_RNS_FMDControl AND 
		((VAR_RNS_ControlRemainder = 0)  AND (HMI_PAM_1._090 <> 0) AND (VAR_RNS_TotalContainerEntered > REAL_TO_UDINT(HMI_PAM_1._090))) OR //CHECK FRA
		((VAR_RNS_ControlRemainder_Cont = 0) AND (HMI_PAM_1._091 <> 0) AND (VAR_RNS_TotalContainerEntered > REAL_TO_UDINT(HMI_PAM_1._091))) THEN //CHECK FRA
		VAR_RNS_ControlModeRequest := TRUE;
	END_IF 
	
	IF VAR_RNS_StepControlDone THEN
		VAR_RNS_ControlModeRequest := FALSE;
	END_IF	
		
	VAR_RNS_FMDControl := 	(HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND (HMI_RNS_SS2P[SS2P_RNS_InsControl].ON OR HMI_RNS_SS2P[SS2P_RNS_ContControl].ON)) OR
							(TNK.DataOut.ProdMode AND NOT HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND VAR_RNS_ControlModeRequest);//vrma
	
	IF EDGEPOS (VAR_RNS_FMDControl) THEN //ALL OTHER SELECTIONS RESET
		FOR VAR_RNS_ForIndex:=1 TO 6 DO
			IF HMI_RNS_SS2P[SS2P_RNS_InsControl].ON THEN
				IF VAR_RNS_ForIndex<>SS2P_RNS_InsControl THEN	 
					HMI_RNS_SS2P[VAR_RNS_ForIndex].ON := FALSE;
				END_IF
			ELSIF HMI_RNS_SS2P[SS2P_RNS_ContControl].ON THEN
				IF VAR_RNS_ForIndex<>SS2P_RNS_ContControl THEN	 
					HMI_RNS_SS2P[VAR_RNS_ForIndex].ON := FALSE;
				END_IF
			END_IF	
		END_FOR;
	END_IF	
	
	//SS2P DRAIN MODE SELECTION
	VAR_RNS_FMDDrain := (HMI_RNS_SS2P[SS2P_SelDrain].ON AND HMI_RNS_SS2P[SS2P_SelAutoMan].ON) OR
						(TNK.DataOut.DrainMode AND NOT HMI_RNS_SS2P[SS2P_SelAutoMan].ON);
	
	IF EDGEPOS(VAR_RNS_FMDDrain) THEN //ALL OTHER SELECTIONS RESET
		FOR VAR_RNS_ForIndex:=1 TO 6 DO
			IF VAR_RNS_ForIndex<>SS2P_SelDrain THEN	 
				HMI_RNS_SS2P[VAR_RNS_ForIndex].ON := FALSE;
			END_IF
		END_FOR;
	END_IF
	
	//SS2P CLEANING MODE SELECTION	
	VAR_RNS_FMDCip := 	(HMI_RNS_SS2P[SS2P_SelCIP].ON AND HMI_RNS_SS2P[SS2P_SelAutoMan].ON) OR TNK.DataOut.CipMode; // leo  AND NOT TNK.DataOut.DisableCipRinser; //mixer
						
	VAR_RNS_CleaningActive := VAR_RNS_FMDCip AND (VAR_RNS_InletOpen);//vrma da controllare

	IF EDGEPOS(VAR_RNS_FMDCip) THEN //ALL OTHER SELECTIONS RESET
		FOR VAR_RNS_ForIndex:=1 TO 6 DO//V4.A.A.1.7.0
			IF VAR_RNS_ForIndex<>SS2P_SelCIP THEN	 
				HMI_RNS_SS2P[VAR_RNS_ForIndex].ON := FALSE;
			END_IF
		END_FOR;
	END_IF
							
	
	//PB START
	IF HMI_RNS_SS2P[SS2P_SelAutoMan].ON THEN
		VAR_RNS_MemPBStart := EDGEPOS(HMI_RNS_PB[PB_CmdStart].ON);	
	ELSE
		VAR_RNS_MemPBStart := EDGEPOS(VAR_RNS_FMDProduction) OR EDGEPOS(VAR_RNS_FMDDrain) OR EDGEPOS(VAR_RNS_FMDCip);
	END_IF
	
	//PB STOP
	VAR_RNS_MemPBStop	:= EDGEPOS(HMI_RNS_PB[PB_CmdStop].ON);
	
	//PB ABORT
	VAR_RNS_MemPBAbort	:= EDGEPOS(HMI_RNS_PB[PB_CmdAbort].ON);
	
	//PB SKIP FORWARD
	VAR_RNS_MemPBSkipForward	:= EDGEPOS(HMI_RNS_PB[PB_CmdSkip].ON);
	
	//PB PAUSE
	IF EDGEPOS(HMI_RNS_PB[PB_CmdPause].ON) THEN
		IF VAR_RNS_MemSSPause THEN 
			HMI_RNS_PB[PB_CmdPause].LampON	:= FALSE;
		ELSE
			HMI_RNS_PB[PB_CmdPause].LampON	:= TRUE;
		END_IF
	END_IF 	
	
	VAR_RNS_MemSSPause:= HMI_RNS_PB[PB_CmdPause].LampON;
END_ACTION
