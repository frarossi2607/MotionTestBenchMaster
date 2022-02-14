ACTION RNS_DataOut: 
	RNS.DataOut.ByPassRequest 					:= VAR_RNS_BypassCommand;
	RNS.DataOut.InsercionRequest				:= NOT VAR_RNS_BypassCommand;
	RNS.DataOut.ByPassed						:= GNS.DataOut.RnsByPassed AND MNM.DataOut.RinserAxisDisabled;//V4.A.A.1.7.0
	RNS.DataOut.AxisDisableRequest 				:= VAR_RNS_BypassCommand;
	RNS.DataOut.InsrtcionDeviceRequest			:= VAR_RNS_SEQ.Mem.InsercionDevice AND VAR_RNS_ControlInsercionRequest;
	RNS.DataOut.ControlInsercionRequestWater 	:= VAR_RNS_SEQ.Mem.ControlInsercion AND VAR_RNS_SEQ.Mem.WaterTreatmentControl;
	RNS.DataOut.ControlInsercionRequestAir	 	:= VAR_RNS_SEQ.Mem.ControlInsercion AND VAR_RNS_SEQ.Mem.AirTreatmentControl;
	RNS.DataOut.ControlContinousRequestWater	:= VAR_RNS_SEQ.Mem.ControlContinous AND VAR_RNS_SEQ.Mem.WaterTreatmentControl;
	RNS.DataOut.ControlContinousRequestAir		:= VAR_RNS_SEQ.Mem.ControlContinous AND VAR_RNS_SEQ.Mem.AirTreatmentControl;
	RNS.DataOut.InsrtcionControlActive 			:= VAR_RNS_FMDControl AND GNS.DataOut.RnsCtrlDevInserted AND MNM.DataOut.RnsSpeedReqReached AND SFT.DataOut.MachineEmpty;
	RNS.DataOut.ContinousControlActive			:= VAR_RNS_FMDControl AND MNM.DataOut.RnsSpeedReqReached AND SFT.DataOut.MachineEmpty;
	RNS.DataOut.ProdMode 						:= VAR_RNS_SEQ.ITC.WTT_ProductionRunning;
	RNS.DataOut.ProductRequest 					:= VAR_RNS_SEQ.ITC.WTT_ProductRequest OR AVB[228].IN_AutoCnd OR AVB[266].IN_AutoCnd;//V4.A.A.1.7.0
	RNS.DataOut.CopMode							:= VAR_RNS_SEQ.Mem.CopAfterCipRequest;//V4.A.A.1.7.0
	RNS.DataOut.StepCounterRequest				:= RNS.DataOut.ContinousControlActive OR RNS.DataOut.InsrtcionControlActive OR VAR_RNS_SeqPermanent.SeqActualStep = 14;
	RNS.DataOut.FixSpeedRequest					:= VAR_RNS_SEQ.Mem.SpeedReductionControl OR (HMI_RNS_SS2P[SS2P_SelAutoMan].ON AND HMI_RNS_SS2P[SS2P_RNS_ContControl].ON AND VAR_RNS_MemPBStart);
	RNS.DataOut.MachineStart					:= RNS.DataOut.FixSpeedRequest; 
	RNS.DataOut.MachineStop						:= NOT RNS.DataOut.FixSpeedRequest; 
	RNS.DataOut.CipMode							:= VAR_RNS_FMDCip;
	RNS.DataOut.NoBottleNoSprayInsercion		:= VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion;//vrma test
	RNS.DataOut.ContainerStop					:= VAR_RNS_SEQ.Mem.ContainersStop;
	RNS.DataOut.CipDrainEnd						:= VAR_RNS_StepCipEnded;
	
	RNS.DataOut.RunOnlyRinserAxisRequest		:= VAR_RNS_SeqPermanent.SeqMode1.7 AND NOT DOS.DataOut.CipMode;
	RNS.DataOut.RunWithHemaReq		            := VAR_RNS_SeqPermanent.SeqMode1.7 AND DOS.DataOut.CipMode;	

	IF VAR_RNS_SEQ.Mem.InsercionDevice OR VAR_RNS_ModeCip THEN
		RNS.DataOut.FixSpeedValue					:= HMI_PAM_1._014;
	ELSE
		RNS.DataOut.FixSpeedValue					:= HMI_PAM_1._015;
	END_IF	
	
END_ACTION
