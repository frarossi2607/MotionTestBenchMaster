ACTION DOS_Alarm:
	//PULP DOSER HEMA ALARM
	ALR[3021].Active	:= VAR_DOS_AVJ_ValveFault; 
	ALR[3001].Active	:= LTJ[203].OUT_Alarm; 
	ALR[3002].Active	:= TTJ[203].OUT_Alarm; 
	ALR[3003].Active	:= MMJ[201].OUT_OverloadFault;
	ALR[3005].Active	:= MMJ[201].OUT_DriveFault;
	ALR[3006].Active	:= MMJ[201].OUT_IsolatedFault;
	ALR[3008].Active;//FAN SHAKER MOTOR
	ALR[3009].Active;//FAN SHAKER MOTOR
	ALR[3013].Active	:= VAR_DOS_NoBotNoFillPressureFault;
	ALR[3014].Active	:= VAR_DOS_NoBotNoFillPressureLow; 
	ALR[3017].Active	:= VAR_DOS_WaterTemperatureTooLow;
	ALR[3018].Active	:= VAR_DOS_WaterTemperatureTooHigh;
	ALR[3019].Active	:= VAR_DOS_StepProdLowLevel;
	//ALR[3020].Active	:= VAR_DOS_TankTooFull;
	ALR[3024].Active; //ZERO POSITION NOT FOUND
	ALR[3025].Active := MMF[205].OUT_OverloadFault;
	ALR[3027].Active := _205MEF.OUT_Alarm;
	ALR[3028].Active := MMF[205].OUT_DriveFault;
	ALR[3029].Active := MMF[206].OUT_OverloadFault;
	ALR[3031].Active := FALSE; // leo _206MEF.OUT_Alarm;
	ALR[3032].Active := MMF[206].OUT_DriveFault;
	ALR[3041].Active := PPJ[202].OUT_OverloadFault;
	ALR[3043].Active := PPJ[202].OUT_DriveFault;
	ALR[3044].Active := PPJ[202].OUT_IsolatedFault;
	ALR[3048].Active := VAR_DOS_CleanArmCopPosFault; 
	ALR[3051].Active := (VAR_DOS_ModeProduction OR VAR_DOS_ModeCip OR VAR_DOS_ModeDrain OR VAR_DOS_ModeRinse) AND VAR_DOS_CleanArmCopPos;//Quick stop se viene alzata richiesta con Arm cleaning inserito
	ALR[3010].Active := VAR_DOS_StepCamPosInProgress; //OR (VAR_DOS_BypassRequest; //Bypass Request -> Machine empty + Normal Stop
	ALR[3015].Active := GNS.DataOut.DosByPassAlarm; //Error bypass -> Critical Stop
	ALR[3016].Active := VAR_DOS_StepMotorization; //Motorization Check
	ALR[3011].Active := HMI_DOS_SS3P[SS3P_DOS_FillingValveOpen].Visibility AND NOT HMI_DOS_SS3P[SS3P_DOS_FillingValveOpen].Auto;
	ALR[3057].Active := VAR_DOS_EndProdStopContainer;
	ALR[3058].Active := VAR_DOS_SEQ.Mem.ContainersStop AND VAR_DOS_ModeProduction;
	
	ALR[3022].Active := LSJ[202].OUT;
	
	TON_DosRunFbk[0].IN := MMF[205].OUT_InOperation AND NOT TON_DosRunFbk[0].Q;
	TON_DosRunFbk[0].PT := t#3s;
	TON_DosRunFbk[0]();
	
	TON_DosRunFbk[1].IN := MMF[206].OUT_InOperation AND NOT TON_DosRunFbk[1].Q;
	TON_DosRunFbk[1].PT := t#3s;
	TON_DosRunFbk[1]();
	
	//MMF205
	IF EDGEPOS(TON_DosRunFbk[0].IN) THEN
		VAR_MMF205PositionSave := _205MEF.OUT_ActValue;
		VAR_MMF205Down 			:=	MMF[205].IN_Reverse;
	ELSIF EDGEPOS(TON_DosRunFbk[0].Q) THEN	
		IF VAR_MMF205Down AND (_205MEF.OUT_ActValue >= VAR_MMF205PositionSave) THEN
			VAR_DOS_LiftMMF205SeqMem.LiftMotor.RunFbkAlr := TRUE;
		ELSIF NOT VAR_MMF205Down AND (_205MEF.OUT_ActValue <= (VAR_MMF205PositionSave)) THEN
			VAR_DOS_LiftMMF205SeqMem.LiftMotor.RunFbkAlr := TRUE;
		END_IF
	END_IF
	IF AID.DataOut.Reset THEN
		VAR_DOS_LiftMMF205SeqMem.LiftMotor.RunFbkAlr := FALSE;
	END_IF
	ALR[939].Active 	:= VAR_DOS_LiftMMF205SeqMem.LiftMotor.RunFbkAlr; // New alarm to check the movement

	//MMF206
	IF EDGEPOS(TON_DosRunFbk[1].IN) THEN
		VAR_MMF206PositionSave := _206MEF.OUT_ActValue;
		VAR_MMF206Down 			:= MMF[206].IN_Reverse;
	ELSIF EDGEPOS(TON_DosRunFbk[1].Q) THEN	
		IF VAR_MMF206Down AND (_206MEF.OUT_ActValue >= VAR_MMF206PositionSave) THEN
			VAR_DOS_LiftMMF206SeqMem.LiftMotor.RunFbkAlr := TRUE;
		ELSIF NOT VAR_MMF206Down AND (_206MEF.OUT_ActValue <= (VAR_MMF206PositionSave)) THEN
			VAR_DOS_LiftMMF206SeqMem.LiftMotor.RunFbkAlr := TRUE;
		END_IF
	END_IF
	IF AID.DataOut.Reset THEN
		VAR_DOS_LiftMMF206SeqMem.LiftMotor.RunFbkAlr := FALSE;
	END_IF
	ALR[941].Active 	:= VAR_DOS_LiftMMF206SeqMem.LiftMotor.RunFbkAlr; // New alarm to check the movement
	
	//*******************************************************	
	TON_DosPositionCheck[0].IN := MMF[205].OUT_InOperation;
	TON_DosPositionCheck[0].PT := t#3s;
	TON_DosPositionCheck[0]();
	
	TON_DosPositionCheck[1].IN := MMF[206].OUT_InOperation;
	TON_DosPositionCheck[1].PT := t#3s;
	TON_DosPositionCheck[1]();
	
	//MMF205
	IF EDGEPOS(TON_DosPositionCheck[0].IN) THEN
		VAR_OldMMF205Position := _205MEF.OUT_ActValue;
		VAR_MMF205DirectionReverse := MMF[205].IN_Reverse;
	END_IF
	
	IF TON_DosPositionCheck[0].Q THEN
		IF VAR_MMF205DirectionReverse THEN
			IF _205MEF.OUT_ActValue > VAR_OldMMF205Position THEN
				VAR_DOS_LiftMMF205SeqMem.LiftMotor.DirectionAlr := TRUE;
			END_IF
		ELSIF _205MEF.OUT_ActValue < VAR_OldMMF205Position THEN
			VAR_DOS_LiftMMF205SeqMem.LiftMotor.DirectionAlr := TRUE;
		END_IF
		TON_DosPositionCheck[0](IN := FALSE);
		VAR_OldMMF205Position := _205MEF.OUT_ActValue;
	ELSIF AID.DataOut.Reset THEN
		VAR_DOS_LiftMMF205SeqMem.LiftMotor.DirectionAlr := FALSE;
	END_IF
	
	IF EDGEPOS(TON_DosPositionCheck[1].IN) THEN
		VAR_OldMMF206Position := _206MEF.OUT_ActValue;
		VAR_MMF206DirectionReverse := MMF[206].IN_Reverse;
	END_IF
	ALR[940].Active 	:= VAR_DOS_LiftMMF205SeqMem.LiftMotor.DirectionAlr;

	//MMF206
	IF TON_DosPositionCheck[1].Q THEN
		IF VAR_MMF206DirectionReverse THEN
			IF _206MEF.OUT_ActValue > VAR_OldMMF206Position THEN
				VAR_DOS_LiftMMF206SeqMem.LiftMotor.DirectionAlr := TRUE;
			END_IF
		ELSIF _206MEF.OUT_ActValue < VAR_OldMMF206Position THEN
			VAR_DOS_LiftMMF206SeqMem.LiftMotor.DirectionAlr := TRUE;
		END_IF
		TON_DosPositionCheck[1](IN := FALSE);
		VAR_OldMMF206Position := _206MEF.OUT_ActValue;
	ELSIF AID.DataOut.Reset THEN
		VAR_DOS_LiftMMF206SeqMem.LiftMotor.DirectionAlr := FALSE;
	END_IF
	ALR[942].Active 	:= VAR_DOS_LiftMMF206SeqMem.LiftMotor.DirectionAlr;
END_ACTION
