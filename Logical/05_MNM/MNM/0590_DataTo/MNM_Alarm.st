ACTION MNM_Alarm:
	ALR[61].Visibility := FALSE;
	IF NOT (CFG_Par.Machine.Combi.BF OR CFG_Par.Machine.Combi.BFL OR CFG_Par.Machine.Combi.BLF OR CFG_Par.Machine.Combi.BAF) AND //V4.A.A.1.6.13
		TNK.DataOut.ProdMode AND MC_InputOutput.Network.Machine.Status.MachineRunning AND EDGENEG(IO_PB_FlStop.ON) THEN
		ALR[61].Active	:= TRUE;
	ELSIF AID.DataOut.Reset THEN
		ALR[61].Active	:= FALSE;
	END_IF

	ALR[7018].Active		:= (MC_InputOutput.Network.Machine.Status.ActualSpeed > 
								(MC_InputOutput.Network.Machine.Status.MachineMaxSpeed + (MC_InputOutput.Network.Machine.Status.MachineMaxSpeed * 8.0 / 100.0))) AND MC_InputOutput.Network.Machine.Status.AutoCombiModalityActive;

	ALR[7019].Active		:= MC_InputOutput.Network.Machine.Status.ActualSpeed > (HMI_PAR_1._020 + (HMI_PAR_1._020 * 5.0 / 100.0));

	IF CFG_Par.Machine.Combi.BF AND MC_InputOutput.Network.Machine.Status.AutoCombiModalityActive AND CFG_MC.Generic.DisengageImmediately THEN
		ALR[7021].Active	:= BlrFlr.StopRequest;//V1.3
	ELSIF AID.DataOut.Reset THEN
		ALR[7021].Active	:= FALSE;
	END_IF
	
	ALR[7154].Active	:= NOT MC_InputOutput.Network.Machine.Commands.MasterEncoderPositionValid AND (CFG_Par.Machine.Combi.BF OR CFG_Par.Machine.Combi.BFL OR CFG_Par.Machine.Combi.BLF OR CFG_Par.Machine.Combi.BAF); //V4.A.A.1.6.13
	ALR[7155].Active	:= MC_InputOutput.Network.Machine.Exceptions.PowerSupplyLowMachineException; //V4.A.A.1.6.13
	ALR[7156].Active    := NOT IO_MNM_PowerSupply1Overload.DI_Input; //V4.A.A.1.6.13
	ALR[7157].Active	:= NOT IO_MNM_PowerSupply2Overload.DI_Input; //V4.A.A.1.6.13
	
	//V4.A.A.1.6.13
	ALR[7170].Active	:= (HMI_PAM_1._403 = 0) AND (HMI_201CPC.ConfigPresent OR HMI_202CPC.ConfigPresent);
	ALR[7171].Active	:= (HMI_PAM_1._407 = 0) AND CFG_Par.ClosingUnit.Capper.Present;// OR CFG_Par.ClosingUnit.Crowner.Present); //v1.4 //v1.62 //COOLAUDO
	ALR[7172].Active	:= (HMI_PAM_1._411 = 0) AND HMI_214CPB.ConfigPresent;
	ALR[7173].Active	:= (HMI_PAM_1._415 = 0) AND (HMI_PAO_2._176 <> 0);
	ALR[7174].Active 	:= (HMI_PAM_1._419 = 0) AND HMI_201CPB.ConfigPresent;
	ALR[7175].Active	:= (HMI_PAM_1._423 = 0) AND CFG_Par.ClosingUnit.Crowner.Present; //NOT USED AT THE MOMENT //COOLAUDO
	ALR[7176].Active	:= (HMI_PAM_1._427 = 0) AND FALSE; //NOT USED AT THE MOMENT
	
	ALR[7180].Active	:= NOT MC_InputOutput.Network.Filler.Status.FillerAbsolutePositionValid
							OR (NOT MC_InputOutput.Network.Filler.Status.RinserAbsolutePositionValid AND CFG_Par.Rinser.Present);    //V4.A.A.1.7.0
//							OR (NOT MC_InputOutput.Network.Filler.Status.CapperAbsolutePositionValid AND CFG_Par.Lifting.Movements.Capper.UncouplingRequest) to be defined //V4.A.A.1.7.0
//							OR (NOT MC_InputOutput.Network.Filler.Status.CrownerAbsolutePositionValid AND CFG_Par.Lifting.Movements.Crowner.UncouplingRequest);//V4.A.A.1.7.0

	
	IF CFG_Par.Machine.Combi.BLF AND MC_InputOutput.Network.Machine.Status.AutoCombiModalityActive  AND CFG_MC.Generic.DisengageImmediately THEN
		ALR[7025].Active	:= NOT LbrFlr.StopRequest;
	ELSIF AID.DataOut.Reset THEN
		ALR[7025].Active	:= FALSE;
	END_IF
	
	ALR[7159].Active := MC_InputOutput.Network.Machine.Exceptions.FaultCamGeneration;//V.1.7.2

	
	IF CFG_Par.Machine.Combi.BAF AND MC_InputOutput.Network.Machine.Status.AutoCombiModalityActive  AND CFG_MC.Generic.DisengageImmediately THEN//V4.A.A.1.7.0
		ALR[7161].Active	:= ActFlr.StopRequest;
	ELSIF AID.DataOut.Reset THEN
		ALR[7161].Active	:= FALSE;
	END_IF
	
	IF CFG_Par.Machine.Combi.BAF THEN//V4.A.A.1.7.0 DA GUARDARE
		ALR[7163].Active	:= FALSE;//NOT ActFlr.EncoderHomed;
	ELSIF AID.DataOut.Reset THEN
		ALR[7163].Active	:= FALSE;
	END_IF
END_ACTION

ACTION MNM_MotionAlarm:
	ALR[7002].Active	:= MC_InputOutput.Network.Machine.Exceptions.Fault;							//Motion -Motion Fault
	ALR[7004].Active	:= MC_InputOutput.Network.Machine.Exceptions.DcBusLowMachineException;		//Motion -DcBus voltage too low
	ALR[7005].Active	:= MC_InputOutput.Network.Machine.Exceptions.ExcessiveVelocityException;	//Motion -Excessive velocity requested
	ALR[7006].Active	:= MC_InputOutput.Network.Machine.Exceptions.ExcessiveAccException;			//Motion -Excessive acceleration requested
	ALR[7007].Active	:= MC_InputOutput.Network.Machine.Exceptions.NoAxisEnabledException;		//Motion -No Axis Enabled		
	ALR[7008].Active	:= MC_InputOutput.Network.Machine.Exceptions.HomingException;				//Motion -Machine not in home
	ALR[7009].Active	:= MC_InputOutput.Network.Machine.Exceptions.BleederException;				//Motion -Bleeder error
	ALR[7013].Active	:= MC_InputOutput.Network.Machine.Exceptions.HmiChecksumException;			//Motion -HMI Checksum Error
	ALR[7014].Active	:= MC_InputOutput.Network.Machine.Exceptions.KochModuleNotReady;			//Motion -Koch Module Not ready

	IF (FillerFanIn1.OUT_Alarm		OR FillerFanIn2.OUT_Alarm		OR FillerFanIn3.OUT_Alarm		OR
		FillerFanIn4.OUT_Alarm		OR FillerFanIn5.OUT_Alarm		OR FillerFanIn6.OUT_Alarm		OR
		FillerFanIn7.OUT_Alarm		OR FillerFanIn8.OUT_Alarm		OR FillerFanIn9.OUT_Alarm		OR
		FillerFanIn10.OUT_Alarm		OR FillerFanMain.OUT_Alarm		OR FillerFanOut1.OUT_Alarm		OR
		FillerFanOut2.OUT_Alarm		OR FillerFanOut3.OUT_Alarm		OR FillerFanOut4.OUT_Alarm		OR
		FillerFanOut5.OUT_Alarm)	OR
		(OutletFanIn1.OUT_Alarm		OR OutletFanIn2.OUT_Alarm		OR OutletFanIn3.OUT_Alarm		OR
		OutletFanIn4.OUT_Alarm		OR OutletFanMain.OUT_Alarm		OR OutletFanOut1.OUT_Alarm		OR
		OutletFanOut2.OUT_Alarm		OR OutletFanOut3.OUT_Alarm		OR OutletFanOut4.OUT_Alarm)		OR
		MC_InputOutput.Network.Machine.Exceptions.FanSeamearFault THEN
		ALR[7015].Active := TRUE;	//Motion -Servoventilation Drive Error
	ELSE
		ALR[7015].Active := FALSE;	//Motion -Servoventilation Drive Error
	END_IF

	IF TMR_TON_TimeoutModality.Q THEN
		ALR[7016].Active	:= TRUE;
	ELSIF AID.DataOut.Reset THEN
		ALR[7016].Active	:= FALSE;
	END_IF

END_ACTION

ACTION MNM_MotionModuleAlarm:
	(*MASTER MODULE *)
	ALR[7470].Active	:= MC_InputOutput.Network.Machine.Status.ModuleNotInitialized;//1.7.2a
	(* FILLER MODULE *)
	ALR[7199].Active	:= MC_InputOutput.Network.Filler.Status.ModuleNotInitialized;			//Motion -Filler module not initialized

	IF NOT MC_InputOutput.Network.Filler.Status.ModuleNotInitialized THEN
		ALR[7200].Active	:= MC_InputOutput.Network.Filler.Exceptions.CarouselTrackException;		//Motion -Filler Carousel: Lag error
		ALR[7201].Active	:= MC_InputOutput.Network.Filler.Exceptions.CarouselHomeException;		//Motion -Filler Carousel: Not homed
		ALR[7202].Active	:= MC_InputOutput.Network.Filler.Exceptions.CarouselTorqueException;	//Motion -Filler Carousel: Torque limit exceeded
		ALR[7203].Active	:= MC_InputOutput.Network.Filler.Exceptions.CarouselDriveException;		//Motion -Filler Carousel: Drive error
		ALR[7204].Active	:= MC_InputOutput.Network.Filler.Exceptions.CarouselSafetyException;	//Motion -Filler Carousel: Safety violation
		ALR[7205].Active	:= MC_InputOutput.Network.Filler.Exceptions.CarouselNotInOpException;	//Motion -Filler Carousel: Not in operation
	
		ALR[7206].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet01TrackException;		//Motion -Filler Inlet: Lag error
		ALR[7207].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet01HomeException;		//Motion -Filler Inlet: Not homed
		ALR[7208].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet01TorqueException;		//Motion -Filler Inlet: Torque limit exceeded
		ALR[7209].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet01DriveException;		//Motion -Filler Inlet: Drive error
		ALR[7210].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet01SafetyException;		//Motion -Filler Inlet: Safety violation
		ALR[7211].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet01NotInOpException;	//Motion -Filler Inlet: Not in operation
	
		ALR[7212].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet02TrackException;		//Motion -Filler Inlet: Lag error
		ALR[7213].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet02HomeException;		//Motion -Filler Inlet: Not homed
		ALR[7214].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet02TorqueException;		//Motion -Filler Inlet: Torque limit exceeded
		ALR[7215].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet02DriveException;		//Motion -Filler Inlet: Drive error
		ALR[7216].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet02SafetyException;		//Motion -Filler Inlet: Safety violation
		ALR[7217].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet02NotInOpException;	//Motion -Filler Inlet: Not in operation
	
		ALR[7218].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet03TrackException;		//Motion -Filler Inlet: Lag error
		ALR[7219].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet03HomeException;		//Motion -Filler Inlet: Not homed
		ALR[7220].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet03TorqueException;		//Motion -Filler Inlet: Torque limit exceeded
		ALR[7221].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet03DriveException;		//Motion -Filler Inlet: Drive error
		ALR[7222].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet03SafetyException;		//Motion -Filler Inlet: Safety violation
		ALR[7223].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet03NotInOpException;	//Motion -Filler Inlet: Not in operation
	
		ALR[7224].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet04TrackException;		//Motion -Filler Inlet: Lag error
		ALR[7225].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet04HomeException;		//Motion -Filler Inlet: Not homed
		ALR[7226].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet04TorqueException;		//Motion -Filler Inlet: Torque limit exceeded
		ALR[7227].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet04DriveException;		//Motion -Filler Inlet: Drive error
		ALR[7228].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet04SafetyException;		//Motion -Filler Inlet: Safety violation
		ALR[7229].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet04NotInOpException;	//Motion -Filler Inlet: Not in operation
	
		ALR[7230].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet05TrackException;		//Motion -Filler Inlet: Lag error
		ALR[7231].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet05HomeException;		//Motion -Filler Inlet: Not homed
		ALR[7232].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet05TorqueException;		//Motion -Filler Inlet: Torque limit exceeded
		ALR[7233].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet05DriveException;		//Motion -Filler Inlet: Drive error
		ALR[7234].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet05SafetyException;		//Motion -Filler Inlet: Safety violation
		ALR[7235].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet05NotInOpException;	//Motion -Filler Inlet: Not in operation
	
		ALR[7236].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet06TrackException;		//Motion -Filler Inlet: Lag error
		ALR[7237].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet06HomeException;		//Motion -Filler Inlet: Not homed
		ALR[7238].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet06TorqueException;		//Motion -Filler Inlet: Torque limit exceeded
		ALR[7239].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet06DriveException;		//Motion -Filler Inlet: Drive error
		ALR[7240].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet06SafetyException;		//Motion -Filler Inlet: Safety violation
		ALR[7241].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet06NotInOpException;	//Motion -Filler Inlet: Not in operation
	
		ALR[7242].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet07TrackException;		//Motion -Filler Inlet: Lag error
		ALR[7243].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet07HomeException;		//Motion -Filler Inlet: Not homed
		ALR[7244].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet07TorqueException;		//Motion -Filler Inlet: Torque limit exceeded
		ALR[7245].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet07DriveException;		//Motion -Filler Inlet: Drive error
		ALR[7246].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet07SafetyException;		//Motion -Filler Inlet: Safety violation
		ALR[7247].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet07NotInOpException;	//Motion -Filler Inlet: Not in operation
	
		ALR[7248].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet08TrackException;		//Motion -Filler Inlet: Lag error
		ALR[7249].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet08HomeException;		//Motion -Filler Inlet: Not homed
		ALR[7250].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet08TorqueException;		//Motion -Filler Inlet: Torque limit exceeded
		ALR[7251].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet08DriveException;		//Motion -Filler Inlet: Drive error
		ALR[7252].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet08SafetyException;		//Motion -Filler Inlet: Safety violation
		ALR[7253].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet08NotInOpException;	//Motion -Filler Inlet: Not in operation
	
		ALR[7254].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet09TrackException;		//Motion -Filler Inlet: Lag error
		ALR[7255].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet09HomeException;		//Motion -Filler Inlet: Not homed
		ALR[7256].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet09TorqueException;		//Motion -Filler Inlet: Torque limit exceeded
		ALR[7257].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet09DriveException;		//Motion -Filler Inlet: Drive error
		ALR[7258].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet09SafetyException;		//Motion -Filler Inlet: Safety violation
		ALR[7259].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet09NotInOpException;	//Motion -Filler Inlet: Not in operation
	
		ALR[7260].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet10TrackException;		//Motion -Filler Inlet: Lag error
		ALR[7261].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet10HomeException;		//Motion -Filler Inlet: Not homed
		ALR[7262].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet10TorqueException;		//Motion -Filler Inlet: Torque limit exceeded
		ALR[7263].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet10DriveException;		//Motion -Filler Inlet: Drive error
		ALR[7264].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet10SafetyException;		//Motion -Filler Inlet: Safety violation
		ALR[7265].Active	:= MC_InputOutput.Network.Filler.Exceptions.Inlet10NotInOpException;	//Motion -Filler Inlet: Not in operation
		
		ALR[7266].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01TrackException;		//Motion -Filler Outlet: Lag error
		ALR[7267].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01HomeException;		//Motion -Filler Outlet: Not homed
		ALR[7268].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01TorqueException;	//Motion -Filler Outlet: Torque limit exceeded
		ALR[7269].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01DriveException;		//Motion -Filler Outlet: Drive error
		ALR[7270].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01SafetyException;	//Motion -Filler Outlet: Safety violation
		ALR[7271].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet01NotInOpException;	//Motion -Filler Outlet: Not in operation

		ALR[7272].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02TrackException;		//Motion -Filler Outlet: Lag error
		ALR[7273].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02HomeException;		//Motion -Filler Outlet: Not homed
		ALR[7274].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02TorqueException;	//Motion -Filler Outlet: Torque limit exceeded
		ALR[7275].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02DriveException;		//Motion -Filler Outlet: Drive error
		ALR[7276].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02SafetyException;	//Motion -Filler Outlet: Safety violation
		ALR[7277].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet02NotInOpException;	//Motion -Filler Outlet: Not in operation

		ALR[7278].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03TrackException;		//Motion -Filler Outlet: Lag error
		ALR[7279].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03HomeException;		//Motion -Filler Outlet: Not homed
		ALR[7280].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03TorqueException;	//Motion -Filler Outlet: Torque limit exceeded
		ALR[7281].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03DriveException;		//Motion -Filler Outlet: Drive error
		ALR[7282].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03SafetyException;	//Motion -Filler Outlet: Safety violation
		ALR[7283].Active	:= MC_InputOutput.Network.Filler.Exceptions.Outlet03NotInOpException;	//Motion -Filler Outlet: Not in operation
	ELSIF EDGEPOS(MC_InputOutput.Network.Filler.Status.ModuleNotInitialized) THEN
		FOR VAR_i := 7200 TO 7283 DO
			ALR[VAR_i].Active := FALSE;
		END_FOR
	END_IF
	
	(* INLET MODULE *)
	ALR[7049].Active	:= MC_InputOutput.Network.Inlet.Status.ModuleNotInitialized;			//Motion -Inlet module not initialized
	
	IF NOT MC_InputOutput.Network.Inlet.Status.ModuleNotInitialized THEN
		ALR[7050].Active	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisTrackException;		//Motion -Inlet Carousel: Lag error
		ALR[7051].Active	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisHomeException;		//Motion -Inlet Carousel: Not homed
		ALR[7052].Active	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisTorqueException;		//Motion -Inlet Carousel: Torque limit exceeded
		ALR[7053].Active	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisDriveException;		//Motion -Inlet Carousel: Drive error
		ALR[7054].Active	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisSafetyException;		//Motion -Inlet Carousel: Safety violation
		ALR[7055].Active	:= MC_InputOutput.Network.Inlet.Exceptions.MainAxisNotInOpException;	//Motion -Inlet Carousel: Not in operation
	ELSIF EDGEPOS(MC_InputOutput.Network.Inlet.Status.ModuleNotInitialized) THEN
		FOR VAR_i := 7050 TO 7055 DO
			ALR[VAR_i].Active := FALSE;
		END_FOR
	END_IF
	
	(* OUTLET MODULE *)
	ALR[7349].Active	:= MC_InputOutput.Network.Outlet.Status.ModuleNotInitialized;			//Motion -Seamer module not initialized
	
	IF NOT MC_InputOutput.Network.Outlet.Status.ModuleNotInitialized THEN
		ALR[7350].Active	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisTrackException;		//Motion -Seamer Carousel: Lag error
		ALR[7351].Active	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisHomeException;		//Motion -Seamer Carousel: Not homed
		ALR[7352].Active	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisTorqueException;	//Motion -Seamer Carousel: Torque limit exceeded
		ALR[7353].Active	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisDriveException;		//Motion -Seamer Carousel: Drive error
		ALR[7354].Active	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisSafetyException;	//Motion -Seamer Carousel: Safety violation
		ALR[7355].Active	:= MC_InputOutput.Network.Outlet.Exceptions.MainAxisNotInOpException;	//Motion -Seamer Carousel: Not in operation
	
		ALR[7416].Active	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01TrackException;		//Motion -Seamer Carousel: Lag error
		ALR[7417].Active	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01HomeException;		//Motion -Seamer Carousel: Not homed
		ALR[7418].Active	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01TorqueException;	//Motion -Seamer Carousel: Torque limit exceeded
		ALR[7419].Active	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01DriveException;		//Motion -Seamer Carousel: Drive error
		ALR[7420].Active	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01SafetyException;	//Motion -Seamer Carousel: Safety violation
		ALR[7421].Active	:= MC_InputOutput.Network.Outlet.Exceptions.Outlet01NotInOpException;	//Motion -Seamer Carousel: Not in operation
	ELSIF EDGEPOS(MC_InputOutput.Network.Outlet.Status.ModuleNotInitialized) THEN
		FOR VAR_i := 7350 TO 7421 DO
			ALR[VAR_i].Active := FALSE;
		END_FOR
	END_IF
END_ACTION
