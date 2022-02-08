(********************************************************************)
(* COPYRIGHT Sidel S.p.A.                                           *)
(********************************************************************)
(* Program: RNS                                                     *)
(* File: RNS_StepConfig.st                                          *)
(* Created in 23/giu/2021 from Excel DF File - Version 3.00         *)
(* Author: Sidel                                                    *)
(********************************************************************)
(* Implementation of program RNS                                    *)
(********************************************************************)

ACTION RNS_StepConfig:
               CASE VAR_RNS_SeqActualStep OF
                       0: (* Wait *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 0 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 0 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := TRUE;                                              (* STEP: 0 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 0 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 0 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 0 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 0 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 0 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 0 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 0 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 0 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 0 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 0 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 0 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 0 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 0 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 0 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 0 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 0 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 0 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 0 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 0 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 0 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := TRUE;                                                  (* STEP: 0 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 0 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 0 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 0 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 0 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 0 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 0 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 0 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 0 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 0 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 0 *)

                       1..10: (* Spare Steps *)

                       11: (* START-UP - Waiting for Water Ready *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 11 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 11 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 11 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 11 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 11 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 11 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 11 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 11 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 11 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 11 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE; // leo TRUE;                                              (* STEP: 11 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE; // leo TRUE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 11 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 11 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 11 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 11 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 11 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 11 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 11 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 11 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 11 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 2;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168    * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 11 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 11 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := TRUE;                                      (* STEP: 11 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 80;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 11 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 11 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 11 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 11 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 11 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 11 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 11 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 11 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 11 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 11 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 11 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 11 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 11 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 11 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 11 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 11 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 11 *)

                       12: (* Spare Steps *)

                       13: (* START-UP - Priming Nozzle Check Pressure and Flow *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 13 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 13 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 13 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 13 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 13 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 13 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 13 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 13 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 13 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 13 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE; // leo TRUE;                                              (* STEP: 13 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE; // leo TRUE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 13 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 13 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 13 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 13 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 13 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 13 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := TRUE;                                                  (* STEP: 13 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 13 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 13 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168   * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 13 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := HMI_PAM_1._092     *0.80;
                               VAR_RNS_SEQ.Device.PTB220.SP := HMI_PAM_1._092;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 2;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 13 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 13 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 13 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 13 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 13 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 13 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 13 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 13 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 13 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 13 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 13 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 13 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 13 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := TRUE;                                          (* STEP: 13 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 13 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 13 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := TRUE;                                           (* STEP: 13 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 13 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 13 *)

                       14: (* START-UP - Priming Nozzle *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 14 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 14 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 14 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 14 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 14 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 14 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 14 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 14 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 14 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 14 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE; // leo TRUE;                                              (* STEP: 14 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE; // leo TRUE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 14 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 14 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 14 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 14 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 14 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 14 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := TRUE;                                                  (* STEP: 14 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 14 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 14 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168   * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 14 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := HMI_PAM_1._092    *0.80;
                               VAR_RNS_SEQ.Device.PTB220.SP := HMI_PAM_1._092;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 2;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 14 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 14 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 14 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 14 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 14 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 14 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 14 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 14 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 14 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 14 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 14 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 14 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 14 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                          (* STEP: 14 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 14 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 14 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := TRUE;                                           (* STEP: 14 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 14 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 14 *)

                       15: (* START-UP - Machine stop *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 15 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 15 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 15 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 15 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 15 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 15 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 15 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 15 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 15 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 15 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 15 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 15 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 15 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 15 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 15 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 15 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 15 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 15 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 15 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 15 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 15 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 15 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 15 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 15 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 15 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 15 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 15 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 15 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 15 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 15 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 15 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 15 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 15 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 15 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 15 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 15 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 15 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 15 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 15 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 15 *)

                       16: (* START-UP - Waiting for Containers *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 16 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 16 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 16 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 16 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 16 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 16 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 16 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 16 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 16 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 16 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE; // leo TRUE;                                              (* STEP: 16 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE; // leo TRUE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 16 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 16 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 16 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 16 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 16 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 16 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 16 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 16 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 16 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 16 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 16 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 16 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 16 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 16 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 16 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 16 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 16 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 16 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 16 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 16 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 16 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 16 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 16 *)

                       17..19: (* Spare Steps *)

                       20: (* PRODUCTION - Running Water Only *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 20 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 20 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 20 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 20 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 20 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 20 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 20 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 20 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 20 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 20 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE; // leo TRUE;                                              (* STEP: 20 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := TRUE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE; // leo TRUE;                                       (* STEP: 20 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 30;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 20 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 20 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 20 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 20 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 20 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := TRUE;                                                  (* STEP: 20 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 20 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 20 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168  * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 20 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := HMI_PAM_1._092  *0.80;
                               VAR_RNS_SEQ.Device.PTB220.SP := HMI_PAM_1._092;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 2;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 20 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := TRUE;                                      (* STEP: 20 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 90;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 20;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 2;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 20 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 20 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 20 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 20 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 20 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 20 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 20 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 20 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 20 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 20 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 20 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 20 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 20 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 20 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 20 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 20 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 20 *)


							21: 	(* PRODUCTION - Water Shower Request *)

					
								VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 16 AVB224*)
								VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 16 AVB228*)
								VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 16 AVB234*)
								VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 16 AVB261*)
								VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 16 AVB264*)
								VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 16 AVB265*)
								VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 16 AVB266*)
								VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 16 AVB267*)
								VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE; // leo FALSE;                                             (* STEP: 16 AVB268*)
								VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 16 AVB273*)
								VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE; // leo TRUE;                                              (* STEP: 16 AVB294*)
								VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE; // leo TRUE;
					
								VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 16 PPB209*)
								VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
								VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
								VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;
					
								VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 16 *)
								VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
								VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
								VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;
					
								VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 16 FSB220*)
								VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 16 LSB209*)
								VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 16 LSB210*)
								VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 16 *)
								VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 16 FSB201*)
								VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 FTB201*)
								VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB201.SP := 0;
								VAR_RNS_SEQ.Device.FTB201.CMP := 0;
								VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
								VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 FTB202*)
								VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB202.SP := 0;
								VAR_RNS_SEQ.Device.FTB202.CMP := 0;
								VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
								VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 PTB220*)
								VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB220.SP := 0;
								VAR_RNS_SEQ.Device.PTB220.CMP := 0;
								VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 PTB270*)
								VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB270.SP := 0;
								VAR_RNS_SEQ.Device.PTB270.CMP := 0;
								VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 LTB202*)
								VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.LTB202.SP := 0;
								VAR_RNS_SEQ.Device.LTB202.CMP := 0;
								VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
								VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 PTB290*)
								VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB290.SP := 0;
								VAR_RNS_SEQ.Device.PTB290.CMP := 0;
								VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;
					
								VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 16 PB Abort Sequence Enable*)
								VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 16 PB Stop Sequence Enable*)
								VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 16 PB Start Sequence Enable*)
								VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 16 *)
					
								VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 16 *)
								VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 16 *)
					


							22: 	(* PRODUCTION - Water Pasto Request *)
										
								VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 16 AVB224*)
								VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 16 AVB228*)
								VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 16 AVB234*)
								VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                             (* STEP: 16 AVB261*)
								VAR_RNS_SEQ.Device.AVB261.EnableCnd := TRUE;
								VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                             (* STEP: 16 AVB264*)
								VAR_RNS_SEQ.Device.AVB264.EnableCnd := TRUE;
								VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 16 AVB265*)
								VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 16 AVB266*)
								VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE; // leo FALSE;                                             (* STEP: 16 AVB267*)
								VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE; // leo FALSE;                                             (* STEP: 16 AVB268*)
								VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 16 AVB273*)
								VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE; // leo TRUE;                                              (* STEP: 16 AVB294*)
								VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE; // leo TRUE;
										
								VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := TRUE;                                      (* STEP: 16 PPB209*)
								VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
								VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
								VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 30;
										
								VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 16 *)
								VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
								VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
								VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;
										
								VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                 (* STEP: 16 FSB220*)
								VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;
										
								VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 16 LSB209*)
								VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;
										
								VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 16 LSB210*)
								VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;
										
								VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 16 *)
								VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;
										
								VAR_RNS_SEQ.Device.FSB201.ALR := TRUE;                                                 (* STEP: 16 FSB201*)
								VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;
										
								VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 FTB201*)
								VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB201.SP := 0;
								VAR_RNS_SEQ.Device.FTB201.CMP := 0;
								VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
								VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;
										
								VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 FTB202*)
								VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
								VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAM_1._169;
								VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAM_1._167;
								VAR_RNS_SEQ.Device.FTB202.CMP := 3;
								VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAM_1._168;
								VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAM_1._168 * 2;
										
								VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 PTB220*)
								VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := TRUE;
								VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := HMI_PAM_1._092 * 0.80;
								VAR_RNS_SEQ.Device.PTB220.SP := HMI_PAM_1._092;
								VAR_RNS_SEQ.Device.PTB220.CMP := 2;
								VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;
										
								VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 PTB270*)
								VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB270.SP := 0;
								VAR_RNS_SEQ.Device.PTB270.CMP := 0;
								VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;
										
								VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := TRUE;                                     (* STEP: 16 LTB202*)
								VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 90;
								VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.LTB202.SP := 20;
								VAR_RNS_SEQ.Device.LTB202.CMP := 2;
								VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
								VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;
										
								VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 16 PTB290*)
								VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB290.SP := 0;
								VAR_RNS_SEQ.Device.PTB290.CMP := 0;
								VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;
										
								VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                 (* STEP: 16 PB Abort Sequence Enable*)
								VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                  (* STEP: 16 PB Stop Sequence Enable*)
								VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 16 PB Start Sequence Enable*)
								VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 16 *)
								VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 16 *)
										
								VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                            (* STEP: 16 *)
								VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                         (* STEP: 16 *)
										
							23: (* PRODUCTION - Running: Recovery Skid Too Low level Water Only *)
					
								VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 23 AVB224*)
								VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 23 AVB228*)
								VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 23 AVB234*)
								VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 23 AVB261*)
								VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 23 AVB264*)
								VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 23 AVB265*)
								VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 23 AVB266*)
								VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 23 AVB267*)
								VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 23 AVB268*)
								VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 23 AVB273*)
								VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 23 AVB294*)
								VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;
					
								VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := TRUE;                                       (* STEP: 23 PPB209*)
								VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
								VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
								VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := HMI_PAM_1._016;
					
								VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 23 *)
								VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
								VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
								VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;
					
								VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 23 FSB220*)
								VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;
					
								VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 23 LSB209*)
								VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 23 LSB210*)
								VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 23 *)
								VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 23 FSB201*)
								VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 23 FTB201*)
								VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB201.SP := 0;
								VAR_RNS_SEQ.Device.FTB201.CMP := 0;
								VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
								VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 23 FTB202*)
								VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
								VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
								VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
								VAR_RNS_SEQ.Device.FTB202.CMP := 3;
								VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
								VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168 * 2;
					
								VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 23 PTB220*)
								VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB220.SP := 0;
								VAR_RNS_SEQ.Device.PTB220.CMP := 0;
								VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 23 PTB270*)
								VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB270.SP := 0;
								VAR_RNS_SEQ.Device.PTB270.CMP := 0;
								VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 23 LTB202*)
								VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.LTB202.SP := 0;
								VAR_RNS_SEQ.Device.LTB202.CMP := 0;
								VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
								VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 23 PTB290*)
								VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB290.SP := 0;
								VAR_RNS_SEQ.Device.PTB290.CMP := 0;
								VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;
					
								VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 23 *)
								VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 23 *)
								VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 23 *)
								VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 23 PB Abort Sequence Enable*)
								VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 23 PB Stop Sequence Enable*)
								VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 23 PB Start Sequence Enable*)
								VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 23 *)
								VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 23 *)
								VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 23 *)
								VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 23 *)
								VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 23 *)
								VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 23 *)
								VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 23 *)
								VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 23 *)
					
								VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 23 *)
								VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 23 *)
					
                       24: (* PRODUCTION - Running: Recovery Skid Low level Water Only *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 24 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 24 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 24 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 24 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 24 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 24 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 24 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 24 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 24 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 24 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 24 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := TRUE;                                       (* STEP: 24 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := HMI_PAM_1._017;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 24 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 24 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 24 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 24 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 24 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 24 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 24 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 24 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168 * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 24 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 24 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 24 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 24 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 24 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 24 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 24 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 24 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 24 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 24 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 24 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 24 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 24 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 24 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 24 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 24 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 24 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 24 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 24 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 24 *)

                       25: (* PRODUCTION - Running: Recovery Skid High level Water Only *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 25 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 25 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 25 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 25 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 25 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 25 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 25 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 25 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 25 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 25 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 25 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := TRUE;                                       (* STEP: 25 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := HMI_PAM_1._018;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 25 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 25 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 25 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 25 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 25 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 25 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 25 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 25 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168 * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 25 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 25 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 25 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 25 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 25 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 25 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 25 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 25 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 25 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 25 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 25 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 25 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 25 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 25 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 25 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 25 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 25 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 25 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 25 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 25 *)

                       26: (* PRODUCTION - Running: Recovery Skid Empty *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 26 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 26 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 26 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 26 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 26 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 26 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 26 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 26 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 26 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 26 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 26 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 26 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 26 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 26 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 26 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 26 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 26 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 26 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 26 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := HMI_PAR_1._166;
                               VAR_RNS_SEQ.Device.FTB201.SP := HMI_PAR_1._164;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := HMI_PAR_1._165;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 2*HMI_PAR_1._165;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 26 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168 * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 26 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 26 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 26 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 26 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 26 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 26 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 26 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 26 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 26 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 26 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 26 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 26 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 26 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 26 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 26 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 26 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 26 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 26 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 26 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 26 *)

                       27: (* PRODUCTION - Running: Recovery Skid Too Low level *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 27 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 27 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 27 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 27 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 27 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 27 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 27 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 27 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 27 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 27 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 27 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := TRUE;                                       (* STEP: 27 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := HMI_PAM_1._016;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 27 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 27 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 27 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 27 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 27 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 27 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 27 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := HMI_PAR_1._166;
                               VAR_RNS_SEQ.Device.FTB201.SP := HMI_PAR_1._164;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := HMI_PAR_1._165;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 2*HMI_PAR_1._165;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 27 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168 * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 27 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 27 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 27 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 27 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 27 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 27 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 27 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 27 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 27 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 27 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 27 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 27 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 27 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 27 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 27 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 27 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 27 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 27 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 27 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 27 *)

                       28: (* PRODUCTION - Running: Recovery Skid Low level *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 28 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 28 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 28 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 28 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 28 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 28 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 28 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 28 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 28 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 28 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 28 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := TRUE;                                       (* STEP: 28 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := HMI_PAM_1._017;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 28 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 28 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 28 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 28 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 28 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 28 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 28 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := HMI_PAR_1._166;
                               VAR_RNS_SEQ.Device.FTB201.SP := HMI_PAR_1._164;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := HMI_PAR_1._165;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 2*HMI_PAR_1._165;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 28 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168 * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 28 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 28 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 28 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 28 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 28 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 28 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 28 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 28 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 28 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 28 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 28 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 28 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 28 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 28 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 28 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 28 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 28 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 28 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 28 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 28 *)

                       29: (* PRODUCTION - Running: Recovery Skid High level *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 29 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 29 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 29 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 29 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 29 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 29 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 29 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 29 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 29 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 29 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 29 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := TRUE;                                       (* STEP: 29 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := HMI_PAM_1._018;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 29 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 29 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 29 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 29 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 29 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := TRUE;                                                  (* STEP: 29 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 29 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := HMI_PAR_1._166;
                               VAR_RNS_SEQ.Device.FTB201.SP := HMI_PAR_1._164;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := HMI_PAR_1._165;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 2*HMI_PAR_1._165;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 29 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168  * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 29 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := HMI_PAM_1._092  *0.80;
                               VAR_RNS_SEQ.Device.PTB220.SP := HMI_PAM_1._092;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 2;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 29 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 29 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 29 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 29 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 29 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 29 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 29 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 29 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 29 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 29 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 29 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 29 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 29 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 29 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 29 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 29 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 29 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 29 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 29 *)

                       30: (* PRODUCTION - Running: Air Only *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 30 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 30 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 30 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 30 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 30 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 30 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 30 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 30 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 30 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 30 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 30 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 30 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 30 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 30 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 30 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 30 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 30 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 30 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 30 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := HMI_PAR_1._166;
                               VAR_RNS_SEQ.Device.FTB201.SP := HMI_PAR_1._164;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := HMI_PAR_1._165;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 2*HMI_PAR_1._165;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 30 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 30 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 30 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 30 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 30 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 30 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 30 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 30 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 30 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 30 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 30 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 30 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 30 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 30 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 30 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 30 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 30 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 30 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 30 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 30 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 30 *)

                       31: (* PRODUCTION - Stopped *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 31 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 31 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 31 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 31 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 31 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 31 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 31 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 31 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 31 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 31 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 31 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 31 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 31 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 31 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 31 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 31 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 31 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 31 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 31 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 31 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 31 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 31 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 31 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 31 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 31 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 31 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 31 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 31 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 31 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 31 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 31 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 31 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 31 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 31 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 31 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 31 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 31 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 31 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 31 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 31 *)

                       32..34: (* Spare Steps *)

						35: (* CIP - Wait Filler Dummy Bottles insertion *) //Condizioni valvole come in wait //RnsDisable
				
								VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 0 AVB224*)
								VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 0 AVB228*)
								VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB234.AutoCnd := TRUE;                                              (* STEP: 0 AVB234*)
								VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 0 AVB261*)
								VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 0 AVB264*)
								VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 0 AVB265*)
								VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 0 AVB266*)
								VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 0 AVB267*)
								VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 0 AVB268*)
								VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 0 AVB273*)
								VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 0 AVB294*)
								VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;
					
								VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 0 PPB209*)
								VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
								VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
								VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;
					
								VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 0 *)
								VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
								VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
								VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;
					
								VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 0 FSB220*)
								VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 0 LSB209*)
								VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 0 LSB210*)
								VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 0 *)
								VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 0 FSB201*)
								VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;
					
								VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 FTB201*)
								VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB201.SP := 0;
								VAR_RNS_SEQ.Device.FTB201.CMP := 0;
								VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
								VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 FTB202*)
								VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB202.SP := 0;
								VAR_RNS_SEQ.Device.FTB202.CMP := 0;
								VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
								VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB220*)
								VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB220.SP := 0;
								VAR_RNS_SEQ.Device.PTB220.CMP := 0;
								VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB270*)
								VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB270.SP := 0;
								VAR_RNS_SEQ.Device.PTB270.CMP := 0;
								VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 LTB202*)
								VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.LTB202.SP := 0;
								VAR_RNS_SEQ.Device.LTB202.CMP := 0;
								VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
								VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;
					
								VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB290*)
								VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB290.SP := 0;
								VAR_RNS_SEQ.Device.PTB290.CMP := 0;
								VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;
					
								VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 0 PB Abort Sequence Enable*)
								VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                  (* STEP: 0 PB Stop Sequence Enable*)
								VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                  (* STEP: 0 PB Start Sequence Enable*)
								VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 0 *)
					
								VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 0 *)
								VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE; 
					                      
			
							36: (*MOTORIZATION - Waiting for Machine Stop - Disabling Axis*) //RnsDisable
									
								VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 0 AVB224*)
								VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 0 AVB228*)
								VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB234.AutoCnd := TRUE;                                              (* STEP: 0 AVB234*)
								VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 0 AVB261*)
								VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 0 AVB264*)
								VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 0 AVB265*)
								VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 0 AVB266*)
								VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 0 AVB267*)
								VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 0 AVB268*)
								VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 0 AVB273*)
								VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
								VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 0 AVB294*)
								VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;
										
								VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 0 PPB209*)
								VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
								VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
								VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;
										
								VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 0 *)
								VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
								VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
								VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;
										
								VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 0 FSB220*)
								VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;
										
								VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 0 LSB209*)
								VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;
										
								VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 0 LSB210*)
								VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;
										
								VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 0 *)
								VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;
										
								VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 0 FSB201*)
								VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
								VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;
										
								VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 FTB201*)
								VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB201.SP := 0;
								VAR_RNS_SEQ.Device.FTB201.CMP := 0;
								VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
								VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;
										
								VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 FTB202*)
								VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.FTB202.SP := 0;
								VAR_RNS_SEQ.Device.FTB202.CMP := 0;
								VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
								VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;
										
								VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB220*)
								VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB220.SP := 0;
								VAR_RNS_SEQ.Device.PTB220.CMP := 0;
								VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;
										
								VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB270*)
								VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB270.SP := 0;
								VAR_RNS_SEQ.Device.PTB270.CMP := 0;
								VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;
										
								VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 LTB202*)
								VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.LTB202.SP := 0;
								VAR_RNS_SEQ.Device.LTB202.CMP := 0;
								VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
								VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;
										
								VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB290*)
								VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
								VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
								VAR_RNS_SEQ.Device.PTB290.SP := 0;
								VAR_RNS_SEQ.Device.PTB290.CMP := 0;
								VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
								VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;
										
								VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 0 PB Abort Sequence Enable*)
								VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                  (* STEP: 0 PB Stop Sequence Enable*)
								VAR_RNS_SEQ.Mem.PBStartEnable := TRUE;                                                  (* STEP: 0 PB Start Sequence Enable*)
								VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 0 *)
								VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 0 *)
										
								VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 0 *)
								VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE; 
										                      
						37..39: (* Spare Steps *)
			
						40: (* CIP - Wait Condition *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 40 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 40 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 40 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                             (* STEP: 40 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 40 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 40 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 40 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 40 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 40 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 40 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 40 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 40 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 40 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._093;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 40 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 40 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 40 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 40 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 40 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 40 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 40 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 40 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 40 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 40 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 40 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 40 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 40 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 40 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 40 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 40 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 40 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 40 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 40 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 40 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 40 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 40 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 40 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 40 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 40 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 40 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 40 *)

                       41: (* CIP - Execution *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 41 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 41 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 41 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 41 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 41 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 41 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 41 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 41 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 41 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 41 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := TRUE;                                              (* STEP: 41 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := TRUE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 41 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 41 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._093;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 41 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 41 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 41 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 41 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 41 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 41 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 41 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 41 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 41 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := TRUE;                                      (* STEP: 41 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 80;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 41 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 41 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 41 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 41 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 41 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 41 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 41 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 41 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 41 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 41 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 41 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := TRUE;                                         (* STEP: 41 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 41 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 41 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 41 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 41 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 41 *)

                       42..45: (* Spare Steps *)

		46: (*MOTORIZATION - Waiting for Machine Stop - Disabling Axis*) //RnsDisable
									
			VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 0 AVB224*)
			VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
			VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 0 AVB228*)
			VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
			VAR_RNS_SEQ.Device.AVB234.AutoCnd := TRUE;                                              (* STEP: 0 AVB234*)
			VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
			VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 0 AVB261*)
			VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
			VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 0 AVB264*)
			VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
			VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 0 AVB265*)
			VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
			VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 0 AVB266*)
			VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
			VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 0 AVB267*)
			VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
			VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 0 AVB268*)
			VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
			VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 0 AVB273*)
			VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
			VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 0 AVB294*)
			VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;
										
			VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 0 PPB209*)
			VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
			VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
			VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;
										
			VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 0 *)
			VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
			VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
			VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;
										
			VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 0 FSB220*)
			VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
			VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;
										
			VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 0 LSB209*)
			VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
			VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;
										
			VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 0 LSB210*)
			VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
			VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;
										
			VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 0 *)
			VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
			VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;
										
			VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 0 FSB201*)
			VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
			VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;
										
			VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 FTB201*)
			VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
			VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
			VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
			VAR_RNS_SEQ.Device.FTB201.SP := 0;
			VAR_RNS_SEQ.Device.FTB201.CMP := 0;
			VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
			VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;
										
			VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 FTB202*)
			VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
			VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
			VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
			VAR_RNS_SEQ.Device.FTB202.SP := 0;
			VAR_RNS_SEQ.Device.FTB202.CMP := 0;
			VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
			VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;
										
			VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB220*)
			VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
			VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
			VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
			VAR_RNS_SEQ.Device.PTB220.SP := 0;
			VAR_RNS_SEQ.Device.PTB220.CMP := 0;
			VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
			VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;
										
			VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB270*)
			VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
			VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
			VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
			VAR_RNS_SEQ.Device.PTB270.SP := 0;
			VAR_RNS_SEQ.Device.PTB270.CMP := 0;
			VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
			VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;
										
			VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 LTB202*)
			VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
			VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
			VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
			VAR_RNS_SEQ.Device.LTB202.SP := 0;
			VAR_RNS_SEQ.Device.LTB202.CMP := 0;
			VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
			VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;
										
			VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 0 PTB290*)
			VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
			VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
			VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
			VAR_RNS_SEQ.Device.PTB290.SP := 0;
			VAR_RNS_SEQ.Device.PTB290.CMP := 0;
			VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
			VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;
										
			VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                (* STEP: 0 *)
			VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 0 *)
			VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 0 *)
			VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 0 PB Abort Sequence Enable*)
			VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                  (* STEP: 0 PB Stop Sequence Enable*)
			VAR_RNS_SEQ.Mem.PBStartEnable := TRUE;                                                  (* STEP: 0 PB Start Sequence Enable*)
			VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 0 *)
			VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 0 *)
			VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 0 *)
			VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 0 *)
			VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 0 *)
			VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 0 *)
			VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 0 *)
			VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 0 *)
										
			VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 0 *)
			VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE; 
                       
		47: (* CIP - Drain *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 47 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 47 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 47 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 47 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 47 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 47 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 47 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 47 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 47 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 47 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 47 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 47 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 47 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 47 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 47 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 47 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 47 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 47 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 47 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 47 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 47 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 47 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 47 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 47 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 47 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 47 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 47 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 47 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 47 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 47 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 47 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 47 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 47 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 47 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 47 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 47 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 47 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 47 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 47 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 47 *)

                       48: (* CIP - Cycle End *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 48 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 48 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 48 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 48 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 48 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 48 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 48 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 48 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 48 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 48 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 48 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 48 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 48 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._093;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 48 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 48 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 48 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 48 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 48 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 48 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 48 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 48 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 48 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 48 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 48 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 48 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 48 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 48 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 48 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 48 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 48 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 48 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 48 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 48 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 48 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 48 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 48 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 48 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 48 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 48 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 48 *)

                       49: (* CIP - Stopped *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 49 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 49 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 49 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 49 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 49 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 49 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 49 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 49 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 49 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 49 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 49 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 49 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 49 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 49 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 49 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 49 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 49 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 49 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 49 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 49 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 49 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 49 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 49 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 49 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 49 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 49 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 49 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 49 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 49 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 49 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 49 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 49 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 49 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 49 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                          (* STEP: 49 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 49 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 49 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 49 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 49 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 49 *)

                       50: (* DRAINING - Tank and circuit emptying *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 50 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 50 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := TRUE;                                              (* STEP: 50 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 50 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 50 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 50 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 50 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 50 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 50 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 50 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 50 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 50 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 50 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 50 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 50 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 50 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 50 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 50 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 50 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 50 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 50 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 50 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 50 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 50 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 50 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 50 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 50 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 50 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 50 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 50 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 50 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 50 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 50 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 50 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 50 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 50 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 50 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 50 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 50 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 50 *)

                       51: (* DRAINING - End drain cycle *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 51 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 51 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := TRUE;                                              (* STEP: 51 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 51 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 51 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 51 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 51 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 51 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 51 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 51 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 51 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 51 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 51 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 51 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 51 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 51 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 51 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 51 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 51 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 51 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 51 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 51 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 51 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 3;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 1;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 51 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 51 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 51 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 51 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 51 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 51 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 51 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 51 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 51 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 51 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 51 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 51 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 51 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 51 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 51 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 51 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 51 *)

                       52..53: (* Spare Steps *)

                       54: (* DRAINING - Stopped *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 54 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 54 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := TRUE;                                              (* STEP: 54 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 54 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 54 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 54 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := TRUE;                                              (* STEP: 54 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := TRUE;                                              (* STEP: 54 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 54 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 54 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 54 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 54 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 54 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 54 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 54 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 54 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 54 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 54 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 54 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 54 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 54 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 54 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 54 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 54 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 54 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 54 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 54 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 54 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 54 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 54 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 54 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 54 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 54 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 54 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 54 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 54 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 54 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 54 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 54 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 54 *)

                       55: (* DRAINING - Circuit emptying during COP *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 55 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 55 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 55 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 55 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 55 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 55 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 55 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 55 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := TRUE;                                              (* STEP: 55 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 55 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 55 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 55 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 55 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 55 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 55 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 55 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 55 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 55 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 55 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 55 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 55 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 55 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 55 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 55 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 55 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 55 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 55 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := FALSE;                                                 (* STEP: 55 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 55 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 55 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 55 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 55 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 55 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 55 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := TRUE;                                          (* STEP: 55 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 55 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := TRUE;                                             (* STEP: 55 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 55 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 55 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 55 *)

                       56..69: (* Spare Steps *)

                       70: (* CONTROL - Check Selection and Speed *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 70 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 70 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 70 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 70 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 70 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 70 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 70 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 70 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 70 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 70 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 70 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 70 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 70 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 70 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 70 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 70 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 70 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 70 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 70 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 70 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 70 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 70 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 70 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 70 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 70 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 70 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 70 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 70 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 70 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 70 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 70 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 70 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 70 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 70 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := TRUE;                                          (* STEP: 70 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 70 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 70 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 70 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 70 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 70 *)

                       71: (* CONTROL - Insercion Device *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 71 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := TRUE;                                              (* STEP: 71 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 71 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 71 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 71 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 71 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 71 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 71 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 71 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 71 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 71 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 71 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 71 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 71 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 71 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 71 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 71 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := TRUE;                                                  (* STEP: 71 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 71 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 71 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 71 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 71 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 71 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 71 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 71 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 71 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 71 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 71 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 71 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 71 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 71 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := TRUE;                                                (* STEP: 71 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 71 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 71 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := TRUE;                                          (* STEP: 71 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 71 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 71 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 71 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 71 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 71 *)

                       72: (* CONTROL - Air Startup I *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 72 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 72 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 72 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 72 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 72 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 72 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 72 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 72 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 72 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 72 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 72 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 72 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 72 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 72 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 72 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 72 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 72 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 72 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 72 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := HMI_PAR_1._166;
                               VAR_RNS_SEQ.Device.FTB201.SP := HMI_PAR_1._164;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := HMI_PAR_1._165;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 2*HMI_PAR_1._165;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 72 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 72 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 72 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 72 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 72 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 72 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 72 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 72 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 72 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 72 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 72 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 72 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := TRUE;                                                (* STEP: 72 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 72 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 72 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := TRUE;                                          (* STEP: 72 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 72 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 72 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 72 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 72 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 72 *)

                       73: (* CONTROL - Insercion Air *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 73 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 73 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 73 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 73 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 73 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 73 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 73 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 73 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 73 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 73 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 73 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 73 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 73 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 73 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 73 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 73 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 73 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 73 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 73 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := HMI_PAR_1._166;
                               VAR_RNS_SEQ.Device.FTB201.SP := HMI_PAR_1._164;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := HMI_PAR_1._165;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 2*HMI_PAR_1._165;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 73 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 73 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 73 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 73 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 73 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 73 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := TRUE;                                               (* STEP: 73 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 73 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 73 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 73 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 73 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 73 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := TRUE;                                                (* STEP: 73 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := TRUE;                                            (* STEP: 73 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 73 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := TRUE;                                          (* STEP: 73 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 73 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 73 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 73 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 73 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 73 *)

                       74: (* CONTROL - Water Startup I *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 74 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 74 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 74 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 74 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 74 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 74 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 74 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 74 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 74 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 74 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 74 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 74 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 74 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 74 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 74 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 74 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 74 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 74 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 74 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 74 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168 * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 74 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := HMI_PAM_1._092     *0.80;
                               VAR_RNS_SEQ.Device.PTB220.SP := HMI_PAM_1._092;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 2;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 74 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 74 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 74 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 74 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 74 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 74 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 74 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 74 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 74 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 74 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := TRUE;                                                (* STEP: 74 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 74 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 74 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := TRUE;                                          (* STEP: 74 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 74 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 74 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := TRUE;                                           (* STEP: 74 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 74 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 74 *)

                       75: (* CONTROL - Insercion Water *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 75 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 75 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 75 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 75 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 75 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 75 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 75 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 75 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 75 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 75 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 75 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 75 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 75 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 75 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 75 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 75 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 75 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 75 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 75 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 75 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168 * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 75 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := HMI_PAM_1._092     *0.80;
                               VAR_RNS_SEQ.Device.PTB220.SP := HMI_PAM_1._092;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 2;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 75 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 75 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 75 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 75 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := TRUE;                                               (* STEP: 75 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 75 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 75 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 75 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 75 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 75 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := TRUE;                                                (* STEP: 75 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 75 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := TRUE;                                          (* STEP: 75 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := TRUE;                                          (* STEP: 75 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 75 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 75 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := TRUE;                                           (* STEP: 75 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 75 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 75 *)

                       76: (* CONTROL - Air Startup C *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 76 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 76 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 76 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 76 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 76 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 76 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 76 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 76 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 76 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 76 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 76 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 76 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 76 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 76 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 76 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 76 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 76 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 76 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 76 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := HMI_PAR_1._166;
                               VAR_RNS_SEQ.Device.FTB201.SP := HMI_PAR_1._164;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := HMI_PAR_1._165;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 2*HMI_PAR_1._165;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 76 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 76 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 76 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 76 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 76 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 76 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 76 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 76 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 76 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 76 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 76 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 76 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 76 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 76 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 76 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 76 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 76 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 76 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 76 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 76 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 76 *)

                       77: (* CONTROL - Continous Air *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := TRUE;                                              (* STEP: 77 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 77 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 77 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 77 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 77 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 77 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 77 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 77 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 77 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 77 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 77 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 77 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 77 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 77 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 77 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 77 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 77 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 77 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 77 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := HMI_PAR_1._166;
                               VAR_RNS_SEQ.Device.FTB201.SP := HMI_PAR_1._164;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := HMI_PAR_1._165;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 2*HMI_PAR_1._165;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 77 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 77 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 77 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 77 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 77 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 77 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 77 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := TRUE;                                               (* STEP: 77 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 77 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 77 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 77 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 77 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 77 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := TRUE;                                            (* STEP: 77 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 77 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 77 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 77 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 77 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 77 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 77 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 77 *)

                       78: (* CONTROL - Water Startup C *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 78 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 78 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 78 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 78 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 78 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 78 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 78 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 78 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 78 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 78 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 78 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 78 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 78 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := TRUE;                                                  (* STEP: 78 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := TRUE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 78 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 78 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 78 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 78 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 78 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 78 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168 * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 78 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 78 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 78 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 78 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 78 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 78 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 78 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 78 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 78 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 78 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 78 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 78 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 78 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 78 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 78 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 78 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 78 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 78 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 78 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 78 *)

                       79: (* CONTROL - Continous Water *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 79 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 79 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 79 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := TRUE;                                              (* STEP: 79 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := TRUE;                                              (* STEP: 79 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := TRUE;                                              (* STEP: 79 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 79 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 79 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 79 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := TRUE;                                              (* STEP: 79 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := TRUE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 79 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 79 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := TRUE;                                       (* STEP: 79 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := HMI_PAM_1._092;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 79 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 79 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 79 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 79 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 79 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 79 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 79 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := TRUE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := HMI_PAR_1._169;
                               VAR_RNS_SEQ.Device.FTB202.SP := HMI_PAR_1._167;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 3;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := HMI_PAR_1._168;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := HMI_PAR_1._168 * 2;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 79 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 79 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 79 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 79 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := FALSE;                                                (* STEP: 79 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 79 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := TRUE;                                               (* STEP: 79 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 79 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 79 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 79 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 79 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 79 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 79 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := TRUE;                                          (* STEP: 79 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 79 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 79 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 79 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 79 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := TRUE;                                             (* STEP: 79 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := TRUE;                                          (* STEP: 79 *)

                       80: (* CONTROL - Stopped *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 80 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 80 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 80 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 80 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 80 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 80 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 80 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 80 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 80 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 80 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 80 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 80 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 80 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 80 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 80 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 80 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 80 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 80 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 80 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 80 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 80 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 80 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 80 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 80 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 80 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 80 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 80 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 80 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 80 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 80 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 80 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 80 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 80 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 80 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := TRUE;                                          (* STEP: 80 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 80 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 80 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 80 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 80 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 80 *)

                       81: (* CONTROL - Done *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 81 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 81 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 81 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 81 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 81 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 81 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 81 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 81 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 81 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 81 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 81 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 81 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 81 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 81 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 81 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 81 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 81 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 81 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 81 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 81 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 81 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 81 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 81 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 81 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 81 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 81 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 81 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 81 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := FALSE;                                                  (* STEP: 81 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 81 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 81 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 81 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 81 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 81 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 81 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 81 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 81 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 81 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 81 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 81 *)

                       82..89: (* Spare Steps *)

                       90: (* BYPASSED - Check Request *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 90 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 90 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 90 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 90 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 90 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 90 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 90 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 90 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 90 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 90 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 90 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 90 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 90 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 90 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 90 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 90 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 90 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 90 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 90 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 90 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 90 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 90 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 90 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 90 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 90 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 90 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 90 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 90 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 90 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 90 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 90 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 90 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 90 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 90 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 90 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 90 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 90 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 90 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 90 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 90 *)

                       91: (* BYPASSED - Rinser Bypassed *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 91 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 91 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 91 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 91 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 91 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 91 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 91 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 91 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 91 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 91 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 91 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 91 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 91 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 91 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 91 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 91 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 91 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 91 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 91 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 91 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 91 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 91 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 91 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 91 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 91 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 91 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 91 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 91 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 91 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 91 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := TRUE;                                                       (* STEP: 91 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 91 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 91 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 91 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 91 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := TRUE;                                                  (* STEP: 91 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 91 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 91 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 91 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 91 *)

                       92: (* BYPASSED - Error *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 92 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 92 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 92 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 92 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 92 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 92 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 92 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 92 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 92 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 92 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 92 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 92 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 92 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 92 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 92 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 92 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 92 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 92 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 92 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 92 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 92 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 92 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 92 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 92 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 92 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 92 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 92 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 92 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 92 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 92 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 92 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 92 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 92 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 92 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 92 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 92 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 92 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 92 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 92 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 92 *)

                       93: (* BYPASSED - Check Request *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 93 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 93 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 93 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 93 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 93 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 93 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 93 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 93 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 93 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 93 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 93 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 93 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 93 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 93 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 93 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 93 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 93 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 93 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 93 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 93 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 93 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 93 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 93 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 93 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 93 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 93 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 93 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 93 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 93 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 93 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := TRUE;                                                       (* STEP: 93 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 93 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 93 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 93 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 93 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := FALSE;                                                 (* STEP: 93 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 93 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 93 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 93 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 93 *)

                       94: (* BYPASSED - Rinser Inserted  *)

                               VAR_RNS_SEQ.Device.AVB224.AutoCnd := FALSE;                                             (* STEP: 94 AVB224*)
                               VAR_RNS_SEQ.Device.AVB224.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB228.AutoCnd := FALSE;                                             (* STEP: 94 AVB228*)
                               VAR_RNS_SEQ.Device.AVB228.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB234.AutoCnd := FALSE;                                             (* STEP: 94 AVB234*)
                               VAR_RNS_SEQ.Device.AVB234.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB261.AutoCnd := FALSE;                                             (* STEP: 94 AVB261*)
                               VAR_RNS_SEQ.Device.AVB261.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB264.AutoCnd := FALSE;                                             (* STEP: 94 AVB264*)
                               VAR_RNS_SEQ.Device.AVB264.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB265.AutoCnd := FALSE;                                             (* STEP: 94 AVB265*)
                               VAR_RNS_SEQ.Device.AVB265.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB266.AutoCnd := FALSE;                                             (* STEP: 94 AVB266*)
                               VAR_RNS_SEQ.Device.AVB266.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB267.AutoCnd := FALSE;                                             (* STEP: 94 AVB267*)
                               VAR_RNS_SEQ.Device.AVB267.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB268.AutoCnd := FALSE;                                             (* STEP: 94 AVB268*)
                               VAR_RNS_SEQ.Device.AVB268.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB273.AutoCnd := FALSE;                                             (* STEP: 94 AVB273*)
                               VAR_RNS_SEQ.Device.AVB273.EnableCnd := FALSE;
                               VAR_RNS_SEQ.Device.AVB294.AutoCnd := FALSE;                                             (* STEP: 94 AVB294*)
                               VAR_RNS_SEQ.Device.AVB294.EnableCnd := FALSE;

                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Enable := FALSE;                                      (* STEP: 94 PPB209*)
                               VAR_RNS_SEQ.Device.PPB209_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.PPB209_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.PPB209_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Enable := FALSE;                                      (* STEP: 94 *)
                               VAR_RNS_SEQ.Device.RVB202_PID.PID_Mode := FALSE;
                               VAR_RNS_SEQ.Device.RVB202_PID.Auto_SP_Value := 0;
                               VAR_RNS_SEQ.Device.RVB202_PID.FIX_Value := 0;

                               VAR_RNS_SEQ.Device.FSB220.ALR := FALSE;                                                 (* STEP: 94 FSB220*)
                               VAR_RNS_SEQ.Device.FSB220.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB220.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB209.ALR := FALSE;                                                 (* STEP: 94 LSB209*)
                               VAR_RNS_SEQ.Device.LSB209.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB209.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB210.ALR := FALSE;                                                 (* STEP: 94 LSB210*)
                               VAR_RNS_SEQ.Device.LSB210.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB210.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.LSB299.ALR := FALSE;                                                 (* STEP: 94 *)
                               VAR_RNS_SEQ.Device.LSB299.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.LSB299.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FSB201.ALR := FALSE;                                                 (* STEP: 94 FSB201*)
                               VAR_RNS_SEQ.Device.FSB201.WAIT_OFF := FALSE;
                               VAR_RNS_SEQ.Device.FSB201.WAIT_ON := FALSE;

                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitEn := FALSE;                                     (* STEP: 94 FTB201*)
                               VAR_RNS_SEQ.Device.FTB201.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB201.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB201.SP := 0;
                               VAR_RNS_SEQ.Device.FTB201.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB201.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB201.MaxDev := 0;

                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 94 FTB202*)
                               VAR_RNS_SEQ.Device.FTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.FTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.FTB202.SP := 0;
                               VAR_RNS_SEQ.Device.FTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.FTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.FTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitEn := FALSE;                                     (* STEP: 94 PTB220*)
                               VAR_RNS_SEQ.Device.PTB220.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB220.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB220.SP := 0;
                               VAR_RNS_SEQ.Device.PTB220.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB220.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB220.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitEn := FALSE;                                     (* STEP: 94 PTB270*)
                               VAR_RNS_SEQ.Device.PTB270.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB270.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB270.SP := 0;
                               VAR_RNS_SEQ.Device.PTB270.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB270.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB270.MaxDev := 0;

                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitEn := FALSE;                                     (* STEP: 94 LTB202*)
                               VAR_RNS_SEQ.Device.LTB202.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.LTB202.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.LTB202.SP := 0;
                               VAR_RNS_SEQ.Device.LTB202.CMP := 0;
                               VAR_RNS_SEQ.Device.LTB202.MinDev := 0;
                               VAR_RNS_SEQ.Device.LTB202.MaxDev := 0;

                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitEn := FALSE;                                     (* STEP: 94 PTB290*)
                               VAR_RNS_SEQ.Device.PTB290.ALR_HighLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitEn := FALSE;
                               VAR_RNS_SEQ.Device.PTB290.ALR_LowLimitSP := 0;
                               VAR_RNS_SEQ.Device.PTB290.SP := 0;
                               VAR_RNS_SEQ.Device.PTB290.CMP := 0;
                               VAR_RNS_SEQ.Device.PTB290.MinDev := 0;
                               VAR_RNS_SEQ.Device.PTB290.MaxDev := 0;

                               VAR_RNS_SEQ.Mem.ContainersStop := TRUE;                                                 (* STEP: 94 *)
                               VAR_RNS_SEQ.Mem.ControlInsercion := FALSE;                                              (* STEP: 94 *)
                               VAR_RNS_SEQ.Mem.ControlContinous := FALSE;                                              (* STEP: 94 *)
                               VAR_RNS_SEQ.Mem.PBAbortEnable := TRUE;                                                  (* STEP: 94 PB Abort Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStopEnable := TRUE;                                                   (* STEP: 94 PB Stop Sequence Enable*)
                               VAR_RNS_SEQ.Mem.PBStartEnable := FALSE;                                                 (* STEP: 94 PB Start Sequence Enable*)
                               VAR_RNS_SEQ.Mem.ByPassed := FALSE;                                                      (* STEP: 94 *)
                               VAR_RNS_SEQ.Mem.InsercionDevice := FALSE;                                               (* STEP: 94 *)
                               VAR_RNS_SEQ.Mem.AirTreatmentControl := FALSE;                                           (* STEP: 94 *)
                               VAR_RNS_SEQ.Mem.WaterTreatmentControl := FALSE;                                         (* STEP: 94 *)
                               VAR_RNS_SEQ.Mem.SpeedReductionControl := FALSE;                                         (* STEP: 94 *)
                               VAR_RNS_SEQ.Mem.ByPassRequest := TRUE;                                                  (* STEP: 94 *)
                               VAR_RNS_SEQ.Mem.CopAfterCipRequest := FALSE;                                            (* STEP: 94 *)
                               VAR_RNS_SEQ.Mem.NoBoNoSprayInsercion := FALSE;                                          (* STEP: 94 *)

                               VAR_RNS_SEQ.ITC.WTT_ProductRequest := FALSE;                                            (* STEP: 94 *)
                               VAR_RNS_SEQ.ITC.WTT_ProductionRunning := FALSE;                                         (* STEP: 94 *)

                       95..100: (* Spare Steps *)

               ELSE
                               RNS_StepStop;
               END_CASE
END_ACTION
