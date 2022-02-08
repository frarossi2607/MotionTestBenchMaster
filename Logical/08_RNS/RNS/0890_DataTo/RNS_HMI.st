ACTION RNS_HMI:
	VAR_RNS_MemPBStart			:= FALSE;
	VAR_RNS_MemPBStop			:= FALSE;
	VAR_RNS_MemPBAbort			:= FALSE;
	VAR_RNS_MemPBSkipForward	:= FALSE;

	//MODE MAN/AUTO
	HMI_RNS_SS2P[SS2P_SelAutoMan].Enable			:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND VAR_RNS_ModeWait;
	HMI_RNS_SS2P[SS2P_SelAutoMan].LampON			:= HMI_RNS_SS2P[SS2P_SelAutoMan].ON;
	
	//SS2P Production
	HMI_RNS_SS2P[SS2P_SelProduction].Enable			:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND VAR_RNS_ModeWait AND NOT TNK.DataOut.CipMode;
	HMI_RNS_SS2P[SS2P_SelProduction].LampON			:= HMI_RNS_SS2P[SS2P_SelProduction].ON;
	
	//SS2P Drain
	HMI_RNS_SS2P[SS2P_SelDrain].Enable				:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND VAR_RNS_ModeWait AND NOT TNK.DataOut.CipMode;
	HMI_RNS_SS2P[SS2P_SelDrain].LampON				:= HMI_RNS_SS2P[SS2P_SelDrain].ON;

	//SS2P Cleaning	
	HMI_RNS_SS2P[SS2P_SelCIP].Enable				:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND VAR_RNS_ModeWait AND TNK.DataOut.Wait;
	HMI_RNS_SS2P[SS2P_SelCIP].LampON				:= HMI_RNS_SS2P[SS2P_SelCIP].ON;
	
	//SS2P Control Insercion	
	HMI_RNS_SS2P[SS2P_RNS_InsControl].Enable		:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND VAR_RNS_ModeWait AND NOT TNK.DataOut.CipMode;
	HMI_RNS_SS2P[SS2P_RNS_InsControl].LampON		:= HMI_RNS_SS2P[SS2P_RNS_InsControl].ON;
	
	//SS2P Control Continous	
	HMI_RNS_SS2P[SS2P_RNS_ContControl].Enable		:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND VAR_RNS_ModeWait AND NOT TNK.DataOut.CipMode;
	HMI_RNS_SS2P[SS2P_RNS_ContControl].LampON		:= HMI_RNS_SS2P[SS2P_RNS_ContControl].ON;
	
	//SS2P Bypass Request Manual V4.A.A.1.7.0
	HMI_RNS_SS2P[SS2P_RNS_Bypass].Visibility		:= FALSE;//vrma	
	HMI_RNS_SS2P[SS2P_RNS_Bypass].Enable			:= HMI_SS2P[SS2P_HMI_SelEnable].ON AND HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND VAR_RNS_ModeWait AND NOT TNK.DataOut.CipMode;
	HMI_RNS_SS2P[SS2P_RNS_Bypass].LampON			:= HMI_RNS_SS2P[SS2P_RNS_Bypass].ON;
	
	//PB Mode Start
	VAR_RNS_PBSelectionEnable := HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND 
	(HMI_RNS_SS2P[SS2P_SelProduction].ON OR 
	((HMI_RNS_SS2P[SS2P_SelDrain].ON OR HMI_RNS_SS2P[SS2P_SelCIP].ON) AND OPS.DataOut.InletGateClosed) OR HMI_RNS_SS2P[SS2P_RNS_ContControl].ON OR HMI_RNS_SS2P[SS2P_RNS_InsControl].ON);
	
	HMI_RNS_PB[PB_CmdStart].Enable					:= VAR_RNS_PBSelectionEnable AND VAR_RNS_ModeWait;
	HMI_RNS_PB[PB_CmdStart].LampON					:= HMI_RNS_PB[PB_CmdStart].ON;
	
	//PB Mode Stop
	HMI_RNS_PB[PB_CmdStop].Enable					:= VAR_RNS_PBSelectionEnable AND NOT VAR_RNS_ModeWait;
	HMI_RNS_PB[PB_CmdStop].LampON					:= HMI_RNS_PB[PB_CmdStop].ON;
	
	//STATUS BAR
	HMI_RNS_State.Sequencer.TextBar[0].Visibility	:= TRUE;
	HMI_RNS_State.Sequencer.TextBar[0].IndexNr		:= FB_RNS_SEQ.IN_Step;
	HMI_RNS_State.Sequencer.TextBar[0].IndexText	:= FB_RNS_SEQ.OUT_HMI_ID;
	
	HMI_RNS_State.Sequencer.TextBar[1].Visibility	:= FALSE;
	HMI_RNS_State.Sequencer.TextBar[1].IndexNr		:= 0;
	HMI_RNS_State.Sequencer.TextBar[1].IndexText	:= 0;
	
	//INFO BOX:STEPS
	HMI_RNS_State.Sequencer.InfoBox[0].Visibility			:= FB_RNS_SEQ.OUT_StepTimePr_T>0 OR FB_RNS_SEQ.OUT_StepTimePr_TON>0;
	HMI_RNS_State.Sequencer.InfoBox[0].IndexText			:= '@Lbl_Step@ time';
	HMI_RNS_State.Sequencer.InfoBox[0].Unit					:= 0;
	HMI_RNS_State.Sequencer.InfoBox[0].ProgressVisibility	:= TRUE;
	HMI_RNS_State.Sequencer.InfoBox[0].Progress				:= UINT_TO_REAL(FB_RNS_SEQ.OUT_StepProgressiveTime);
	HMI_RNS_State.Sequencer.InfoBox[0].Preset				:= UINT_TO_REAL(FB_RNS_SEQ.OUT_StepTimePr_TON);
	HMI_RNS_State.Sequencer.InfoBox[0].Actual				:= UINT_TO_REAL(FB_RNS_SEQ.OUT_StepTimeCV_TON);
	
	HMI_202DSB;
	
	ComboBoxString(
	IN_ElementsStructure	:= HMI_RNS_Treatments,
	OUT_ComboString			:= ADR(HMI_RNS_TypeCFG)
	);
	
	(*RNS Multichoice vrma*)
	IF CFG_Par.Rinser.PressureNozzleControlInsertion OR CFG_Par.Rinser.PressureNozzleControlContinous THEN
		HMI_RNS_MultiChoiceMng := 1;
	ELSE 
		HMI_RNS_MultiChoiceMng := 0;
	END_IF
	
	HMI_RNS_PB[PB_RNS_PageUp].Enable	:= VAR_RNS_ActPageData > 0;
	HMI_RNS_PB[PB_RNS_PageUp].LampON := HMI_RNS_PB[PB_RNS_PageUp].ON;
	
	IF EDGEPOS(HMI_RNS_PB[PB_RNS_PageUp].LampON) THEN
		VAR_RNS_ActPageData := VAR_RNS_ActPageData - 1;
	END_IF	
	
	HMI_RNS_PB[PB_RNS_PageDown].Enable	:= VAR_RNS_ActPageData < VAR_RNS_MaxPageData;
	HMI_RNS_PB[PB_RNS_PageDown].LampON := HMI_RNS_PB[PB_RNS_PageDown].ON;
	
	IF EDGEPOS(HMI_RNS_PB[PB_RNS_PageDown].LampON) THEN
		VAR_RNS_ActPageData := VAR_RNS_ActPageData + 1;
	END_IF
	
	IF VAR_RNS_NozzleInLastPage > 0 THEN
		IF VAR_RNS_ActPageData =  VAR_RNS_MaxPageData THEN
			FOR VAR_RNS_IndexVis := 0 TO 14 DO
				VAR_RNS_RnsNozzleData[VAR_RNS_IndexVis + 1 + (VAR_RNS_MaxPageData *15)].Visibility := 	VAR_RNS_IndexVis < VAR_RNS_NozzleInLastPage;
			END_FOR	
		ELSE
			VAR_RNS_IndexVis := 0;	
		END_IF	
	END_IF	
	
	memcpy(ADR(HMI_RNS_NozzleData[1]),ADR(VAR_RNS_RnsNozzleData[1 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[1]));
	memcpy(ADR(HMI_RNS_NozzleData[2]),ADR(VAR_RNS_RnsNozzleData[2 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[2]));
	memcpy(ADR(HMI_RNS_NozzleData[3]),ADR(VAR_RNS_RnsNozzleData[3 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[3]));
	memcpy(ADR(HMI_RNS_NozzleData[4]),ADR(VAR_RNS_RnsNozzleData[4 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[4]));
	memcpy(ADR(HMI_RNS_NozzleData[5]),ADR(VAR_RNS_RnsNozzleData[5 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[5]));
	memcpy(ADR(HMI_RNS_NozzleData[6]),ADR(VAR_RNS_RnsNozzleData[6 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[6]));
	memcpy(ADR(HMI_RNS_NozzleData[7]),ADR(VAR_RNS_RnsNozzleData[7 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[7]));
	memcpy(ADR(HMI_RNS_NozzleData[8]),ADR(VAR_RNS_RnsNozzleData[8 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[8]));
	memcpy(ADR(HMI_RNS_NozzleData[9]),ADR(VAR_RNS_RnsNozzleData[9 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[9]));
	memcpy(ADR(HMI_RNS_NozzleData[10]),ADR(VAR_RNS_RnsNozzleData[10 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[10]));
	memcpy(ADR(HMI_RNS_NozzleData[11]),ADR(VAR_RNS_RnsNozzleData[11 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[11]));
	memcpy(ADR(HMI_RNS_NozzleData[12]),ADR(VAR_RNS_RnsNozzleData[12 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[12]));
	memcpy(ADR(HMI_RNS_NozzleData[13]),ADR(VAR_RNS_RnsNozzleData[13 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[13]));
	memcpy(ADR(HMI_RNS_NozzleData[14]),ADR(VAR_RNS_RnsNozzleData[14 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[14]));
	memcpy(ADR(HMI_RNS_NozzleData[15]),ADR(VAR_RNS_RnsNozzleData[15 + (VAR_RNS_ActPageData * 15)]),SIZEOF(HMI_RNS_NozzleData[15]));
	
	(*RNS Nozzles Data Reset V4.A.A.1.7.0*)
	HMI_RNS_PB[PB_RNS_CounterReset].Visibility := TRUE;
	HMI_RNS_PB[PB_RNS_CounterReset].Enable	:= NOT RNS.DataOut.ContinousControlActive AND NOT RNS.DataOut.InsrtcionControlActive;
	HMI_RNS_PB[PB_RNS_CounterReset].LampON := HMI_RNS_PB[PB_RNS_CounterReset].ON;
	
	IF HMI_RNS_PB[PB_RNS_CounterReset].LampON THEN
		FOR VAR_RNS_IndexReset := 1 TO 200 DO
			memset(ADR(VAR_RNS_RnsNozzleData[VAR_RNS_IndexReset].ContinousAir),0,SIZEOF(VAR_RNS_RnsNozzleData[VAR_RNS_IndexReset].ContinousAir));
			memset(ADR(VAR_RNS_RnsNozzleData[VAR_RNS_IndexReset].ContinousWater),0,SIZEOF(VAR_RNS_RnsNozzleData[VAR_RNS_IndexReset].ContinousWater));
			memset(ADR(VAR_RNS_RnsNozzleData[VAR_RNS_IndexReset].InsercionAir),0,SIZEOF(VAR_RNS_RnsNozzleData[VAR_RNS_IndexReset].InsercionAir));
			memset(ADR(VAR_RNS_RnsNozzleData[VAR_RNS_IndexReset].InsercionWater),0,SIZEOF(VAR_RNS_RnsNozzleData[VAR_RNS_IndexReset].InsercionWater));
		END_FOR
		VAR_RNS_ContinousAirAlarm	 	:= 0;
		VAR_RNS_ContinousWaterAlarm 	:= 0;
		VAR_RNS_InsercionAirAlarm 		:= 0;
		VAR_RNS_InsercionWaterAlarm		:= 0;
	ELSE
		VAR_RNS_IndexReset := 1;
	END_IF
	(*RNS Nozzles Alarm Detection after control V4.A.A.1.7.0*)
	IF VAR_RNS_SeqActualStep = 81 THEN
		FOR VAR_RNS_IndexAlarm := 1 TO 200 DO
			VAR_RNS_ContinousAirAlarm	 	:= VAR_RNS_ContinousAirAlarm + BOOL_TO_INT(VAR_RNS_RnsNozzleData[VAR_RNS_IndexAlarm].ContinousAir.Alarm);
			VAR_RNS_ContinousWaterAlarm 	:= VAR_RNS_ContinousWaterAlarm + BOOL_TO_INT(VAR_RNS_RnsNozzleData[VAR_RNS_IndexAlarm].ContinousWater.Alarm);
			VAR_RNS_InsercionAirAlarm 		:= VAR_RNS_InsercionAirAlarm + BOOL_TO_INT(VAR_RNS_RnsNozzleData[VAR_RNS_IndexAlarm].InsercionAir.Alarm);
			VAR_RNS_InsercionWaterAlarm		:= VAR_RNS_InsercionWaterAlarm + BOOL_TO_INT(VAR_RNS_RnsNozzleData[VAR_RNS_IndexAlarm].InsercionAir.Alarm);
		END_FOR
	ELSE
		VAR_RNS_IndexAlarm := 1;
	END_IF	
	//Added For HMI Recipe problem REMOVE ONCE SOLVED
//	HMI_PAR_1._164 := 480.0;
//	HMI_PAR_1._165 := 400.0;
//	HMI_PAR_1._166 := 350.0;
//	HMI_PAR_1._167 := 260.0;
//	HMI_PAR_1._168 := 5.0;
//	HMI_PAR_1._169 := 30.0;	

END_ACTION