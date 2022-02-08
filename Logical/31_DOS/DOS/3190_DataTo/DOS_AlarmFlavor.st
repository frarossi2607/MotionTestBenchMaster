ACTION DOS_AlarmFlavor:
	//FLAVOR DOSER ALARM
	ALR[3100].ActionEn := TRUE;
	IF (NOT DosFlr.Fault) 
		OR (DosFlr.OutOfService AND FlrDos.AromePodReq AND TNK.DataOut.ProdMode) 
		OR (NOT DosFlr.OutOfService AND NOT FlrDos.AromePodReq AND TNK.DataOut.ProdMode)  THEN
		ALR[3100].Active := TRUE;
	ELSE
		ALR[3100].Active := FALSE;
	END_IF
	
	ALR[3101].Active	:= NOT DosFlr.ContainerBlock OR NOT DosFlr.ProdReady;
	ALR[3102].ActionEn 	:= TNK.DataOut.ProdMode OR TNK.DataOut.CipMode;
	ALR[3102].Active	:= NOT IO_DOS_OverloadOk.DI_Input;

	//V4.A.A.1.6.13	
	ALR[3103].Active	:= DosFlr.CipReady AND NOT DosFlr.CipRunning;
	ALR[3104].Active 	:= DosFlr.PrimingCycleProgress;
	ALR[3105].Active	:= DosFlr.SampleCycleInProgress;
	ALR[3106].Active 	:= DosFlr.SettingCycleInProgress;
	ALR[3107].Active 	:= DosFlr.Positioning (*AND NOT FlrDos.PositioningDone*);

END_ACTION
