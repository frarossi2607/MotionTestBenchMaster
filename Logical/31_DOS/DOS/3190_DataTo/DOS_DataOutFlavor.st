ACTION DOS_DataOutFlavor:
	//FLAVOR DOSER
	DOS.DataOut.ProdMode 	:= REAL_TO_BOOL(HMI_PAR_1._005) AND TNK.DataOut.ProdMode;
	DOS.DataOut.CipMode 	:= DosFlr.CipReady OR DosFlr.CipRunning;
	DOS.DataOut.AromePodReq := REAL_TO_BOOL(HMI_PAR_1._005) AND TNK.DataOut.ProdMode; 
	DOS.DataOut.MachineStart := DosFlr.RotationRequest;
	
	IF DOS.DataOut.AromePodReq AND NOT ALR[3100].Active AND DosFlr.PrimingCycleProgress THEN
		DOS.DataOut.FixSpeedRequest 		:= TRUE;
		DOS.DataOut.FixSpeedValue 			:= CFG_MC.Movements.MachineMaxSpeed;
	ELSIF DosFlr.RotationRequest AND NOT ALR[3100].Active AND DOS.DataOut.CipMode THEN
		DOS.DataOut.FixSpeedRequest 		:= TRUE;
		DOS.DataOut.FixSpeedValue 			:= MIN(20000, CFG_MC.Movements.MachineMaxSpeed *0.7);
	ELSIF DosFlr.SampleCycleInProgress THEN
		DOS.DataOut.FixSpeedRequest		 	:= TRUE;
		DOS.DataOut.FixSpeedValue 			:= MIN(10000, CFG_MC.Movements.MachineMaxSpeed *0.5);
	ELSE
		DOS.DataOut.FixSpeedRequest		 	:= FALSE;
		DOS.DataOut.FixSpeedValue 			:= 0;
	END_IF
END_ACTION
