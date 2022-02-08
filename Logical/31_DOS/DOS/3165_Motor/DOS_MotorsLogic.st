ACTION DOS_MotorsLogic:
	VAR_DOS_AlarmActive := ALR[939].Active OR ALR[940].Active OR ALR[941].Active OR ALR[942].Active ;
	VAR_DOS_MotorEnable := OPS.DataOut.EmergencyOk AND OPS.DataOut.EnableDrive AND NOT VAR_DOS_AlarmActive; 

	//MMJ201
	MMJ[201].IN_Enable 		:= VAR_DOS_MotorEnable AND REAL_TO_BOOL(HMI_PAR_1._217);
	MMJ[201].IN_AutoCnd 	:= MMJ[201].IN_Enable AND VAR_DOS_SEQ.Device.MMJ201_PID.PID_Mode;	
	MMJ[201].IN_AutoSpeed	:= HMI_PAR_1._218;
	MMJ[201].IN_ManEn	 	:= TRUE; 
	MMJ[201].IN_MaskEn	 	:= TRUE;
	
	//MMF205  FILIPPO
	MMF[205].IN_Enable 		:= VAR_DOS_MotorEnable AND (VAR_DOS_SEQ.Mem.PositioningRequest OR HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON OR HMI_DOS_LiftPosition.Value <> 0 OR HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON) ;
	MMF[205].IN_ManEn	 	:= TRUE; 
	MMF[205].IN_MaskEn	 	:= TRUE;
	
	//MMF206
	MMF[206].IN_Enable 		:= VAR_DOS_MotorEnable AND (VAR_DOS_SEQ.Mem.PositioningRequest OR HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON OR HMI_DOS_LiftPosition.Value <> 0 OR HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON);
	MMF[206].IN_ManEn	 	:= TRUE;
	MMF[206].IN_MaskEn	 	:= TRUE;
END_ACTION
