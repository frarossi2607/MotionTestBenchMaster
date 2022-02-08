ACTION RNS_StepStop:

		VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 101 *)
		VAR_RNS_SEQ.Device.AVB224.EnableCnd := TRUE;
		VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 101 *)
		VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
		VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                              (* STEP: 101 *)
		VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
		VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 101 *)
		VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
		VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 101 *)
		VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
		VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 101 *)
		VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;

	
	VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 101 *)
	VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
	VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
	VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

	VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                (* STEP: 101 *)
	VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
	VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;
		
	VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                (* STEP: 101 *)
	VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
	VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;
		
	VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                (* STEP: 101 *)
	VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
	VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;
	
	VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 101 *)
	VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
	VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;
	
	VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 101 *)
	VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
	VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

	VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 101 *)
	VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
	VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
	VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
	VAR_RNS_SEQ.Device.FTB201.SP := 0;
	VAR_RNS_SEQ.Device.FTB201.CMP := 0;
	VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
	VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;
	
	VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 101 *)
	VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
	VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
	VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
	VAR_RNS_SEQ.Device.FTB202.SP := 0;
	VAR_RNS_SEQ.Device.FTB202.CMP := 0;
	VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
	VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;
	
	VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 101 *)
	VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
	VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
	VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
	VAR_RNS_SEQ.Device.PTB220.SP := 0;
	VAR_RNS_SEQ.Device.PTB220.CMP := 0;
	VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
	VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;
	
	VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 101 *)
	VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
	VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
	VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
	VAR_RNS_SEQ.Device.PTB270.SP := 0;
	VAR_RNS_SEQ.Device.PTB270.CMP := 0;
	VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
	VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

	VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                               	(* STEP: 101 *)
END_ACTION
