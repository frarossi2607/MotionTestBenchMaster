(********************************************************************
 * COPYRIGHT - Sidel SpA
 ********************************************************************
 * Library: SIDEL
 * File: SIKO_FB.st
 * Author: 100383
 * Created: November 16, 2015
 ********************************************************************
 * Implementation of library SIDEL_CNTR
 ********************************************************************) 


FUNCTION_BLOCK Siko_FB

	memset(ADR(Com),0,SIZEOF(Com));
	
	DeviceData.EmergencyOkFbk := IN_EmergencyOK;
	
	IF NOT IN_CommunicationOK THEN
		DeviceData.PositioningInProgress := FALSE;
		DeviceData.InPosition := FALSE;
		CounterRead := 0;
		CounterWrite := 0;
		DeviceData.CalibrationInProgress := FALSE;
		DeviceData.CommunicationFault := TRUE;
		RETURN;
	ELSE
		DeviceData.CommunicationFault := FALSE;
	END_IF
	
	IF CounterRead <> 0 OR CounterWrite <> 0 OR (DeviceData.CalibrationInProgress AND NOT DeviceData.Calibrate) THEN
		DeviceData.ReadOrWriteInProgress := TRUE;
	ELSE
		DeviceData.ReadOrWriteInProgress := FALSE;
	END_IF
	
	TReadAndWrite(IN:= DeviceData.ReadOrWriteInProgress, PT:= t#30s);
	DeviceData.ReadOrWriteError := TReadAndWrite.Q;
	
	IF DeviceData.ReadOrWriteError OR IN_Reset THEN
		CounterRead := 0;
		CounterWrite := 0;
		DeviceData.CalibrationInProgress := FALSE;
	END_IF
	
	Com.SIKO_FLR	:= IO.SIKO_FLR;
	Temp_HIW		:= IO.SIKO_FLR.HIW_L + (IO.SIKO_FLR.HIW_H * 16#10000);
	Temp_IN_PWE		:= IO.SIKO_FLR.PWE_L + (IO.SIKO_FLR.PWE_H * 16#10000);
	
	IF DeviceData.Data.SpindlePitch = 0 THEN
		KFactorReal := 1.0;
	ELSE
		KFactorReal := 100.0;
	END_IF
	
	DeviceData.CurrentPos := UDINT_TO_REAL(Temp_HIW) / KFactorReal;

	DeviceData.TargetOutsideSwLimit := (DeviceData.TargetPos > DeviceData.Data.UpperLimit) OR (DeviceData.TargetPos < DeviceData.Data.LowerLimit);
	
	IF EDGEPOS(DeviceData.StartPositioning AND IN_EmergencyOK AND NOT DeviceData.MotorDisabled AND NOT DeviceData.TargetOutsideSwLimit) THEN
		DeviceData.PositioningInProgress := TRUE;
	END_IF
	
	DeviceData.InPosition := ABS(DeviceData.TargetPos - DeviceData.CurrentPos) <= DeviceData.Data.PosWindows;
	
	SwitchOn := DeviceData.JogBackward OR DeviceData.JogForward OR DeviceData.PositioningInProgress;
	
	TPowerOn(IN:= SwitchOn, PT:= t#20s);
	
	Com.FLR_SIKO.STW.0 := IN_EmergencyOK AND TPowerOn.Q AND DeviceData.Enable AND NOT DeviceData.OnError;
	Com.FLR_SIKO.STW.1 := IN_EmergencyOK AND TPowerOn.Q AND DeviceData.Enable AND NOT DeviceData.OnError;
	
	Com.FLR_SIKO.STW.7 := IN_Reset;
	
	Com.FLR_SIKO.STW.5 := Com.SIKO_FLR.ZSW.2 AND NOT DeviceData.AbortPositioning;
	Com.FLR_SIKO.STW.4 := Com.SIKO_FLR.ZSW.2 AND NOT DeviceData.AbortPositioning;
	
	Com.FLR_SIKO.STW.3 := Com.SIKO_FLR.ZSW.4;
	
	IF DeviceData.Enable THEN
		DeviceData.MotorDisabled := FALSE;
	ELSIF NOT DeviceData.Enable AND NOT Com.SIKO_FLR.ZSW.4 THEN
		DeviceData.MotorDisabled := TRUE;
	END_IF
	
	DeviceData.OnError := Com.SIKO_FLR.ZSW.3;
	
	DeviceData.Warning := Com.SIKO_FLR.ZSW.8 AND Com.SIKO_FLR.ZSW.7;
	
	DeviceData.DeviceOutsideSwLimit := Com.SIKO_FLR.ZSW.14 OR (DeviceData.CurrentPos > DeviceData.Data.UpperLimit) OR (DeviceData.CurrentPos < DeviceData.Data.LowerLimit);
	
	Com.FLR_SIKO.STW.9 := Com.SIKO_FLR.ZSW.2 AND NOT DeviceData.OnError AND NOT DeviceData.PositioningInProgress AND	(DeviceData.JogForward XOR DeviceData.JogBackward);
	
	Com.FLR_SIKO.STW.15 := Com.FLR_SIKO.STW.9 AND DeviceData.JogBackward;
	
	Com.FLR_SIKO.STW.6 := DeviceData.PositioningInProgress AND NOT DeviceData.OnError AND Com.SIKO_FLR.ZSW.15 AND Com.SIKO_FLR.ZSW.13;
	
	IF Com.FLR_SIKO.STW.6 THEN
		Temp_HSW := REAL_TO_UDINT(DeviceData.TargetPos * KFactorReal);
	END_IF
	
	PositionFinished := ABS(DeviceData.TargetPos - DeviceData.CurrentPos) <= DeviceData.Data.PosWindows;
	
	IF DeviceData.TargetOutsideSwLimit OR DeviceData.OnError OR NOT IN_EmergencyOK OR DeviceData.MotorDisabled OR
	(DeviceData.InPosition AND Com.SIKO_FLR.ZSW.13) OR
	(PositionFinished AND Com.SIKO_FLR.ZSW.13) OR
	EDGEPOS(DeviceData.AbortPositioning) THEN
		DeviceData.PositioningInProgress := FALSE;
	END_IF
	
	RisingFrontRead := EDGEPOS((DeviceData.StartRead AND NOT DeviceData.ReadOrWriteInProgress) OR ReloadData);
	
	Com.FLR_SIKO.PKE := 0;
	
	IF NOT DeviceData.ReadOrWriteError THEN
		IF RisingFrontRead THEN
			CounterRead := 1;
			ReloadData := FALSE;
		END_IF
		
		CASE CounterRead OF
			1:	// Operative Mode
				Com.FLR_SIKO.PKE := 16#13A2;
			
				IF Com.SIKO_FLR.PKE = 16#13A2 THEN
					DeviceData.Data.OperationMode := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := CounterRead  + 1;
				END_IF
			
			2:	// Error Buffer [0]
				Com.FLR_SIKO.IND := 0;
				Com.FLR_SIKO.PKE := 16#63B1;
			
				IF Com.SIKO_FLR.PKE = 16#43B1 THEN
					IF Com.SIKO_FLR.IND = 0 THEN
						DeviceData.Data.FaultBuffer0 := UDINT_TO_INT(Temp_IN_PWE);
						CounterRead := CounterRead  + 1;
					END_IF
				END_IF
			
			3:	// Error Buffer [1]
				Com.FLR_SIKO.IND := 1;
				Com.FLR_SIKO.PKE := 16#63B1;
			
				IF Com.SIKO_FLR.PKE = 16#43B1 THEN
					IF Com.SIKO_FLR.IND = 1 THEN
						DeviceData.Data.FaultBuffer1 := UDINT_TO_INT(Temp_IN_PWE);
						CounterRead := CounterRead  + 1;
					END_IF
				END_IF
			
			4:	// Error Buffer [2]
				Com.FLR_SIKO.IND := 2;
				Com.FLR_SIKO.PKE := 16#63B1;
			
				IF Com.SIKO_FLR.PKE = 16#43B1 THEN
					IF Com.SIKO_FLR.IND = 2 THEN
						DeviceData.Data.FaultBuffer2 := UDINT_TO_INT(Temp_IN_PWE);
						CounterRead := CounterRead  + 1;
					END_IF
				END_IF
			
			5:	// Error Buffer [3]
				Com.FLR_SIKO.IND := 3;
				Com.FLR_SIKO.PKE := 16#63B1;
			
				IF Com.SIKO_FLR.PKE = 16#43B1 THEN
					IF Com.SIKO_FLR.IND = 3 THEN
						DeviceData.Data.FaultBuffer3 := UDINT_TO_INT(Temp_IN_PWE);
						CounterRead := CounterRead  + 1;
					END_IF
				END_IF
			
			6:	// Error Buffer [4]
				Com.FLR_SIKO.IND := 4;
				Com.FLR_SIKO.PKE := 16#63B1;
			
				IF Com.SIKO_FLR.PKE = 16#43B1 THEN
					IF Com.SIKO_FLR.IND = 4 THEN
						DeviceData.Data.FaultBuffer4 := UDINT_TO_INT(Temp_IN_PWE);
						CounterRead := CounterRead  + 1;
					END_IF
				END_IF
			
			7:	// Error Buffer [5]
				Com.FLR_SIKO.IND := 5;
				Com.FLR_SIKO.PKE := 16#63B1;
			
				IF Com.SIKO_FLR.PKE = 16#43B1 THEN
					IF Com.SIKO_FLR.IND = 5 THEN
						DeviceData.Data.FaultBuffer5 := UDINT_TO_INT(Temp_IN_PWE);
						CounterRead := CounterRead  + 1;
					END_IF
				END_IF
			
			8:	// Error Buffer [6]
				Com.FLR_SIKO.IND := 6;
				Com.FLR_SIKO.PKE := 16#63B1;
			
				IF Com.SIKO_FLR.PKE = 16#43B1 THEN
					IF Com.SIKO_FLR.IND = 6 THEN
						DeviceData.Data.FaultBuffer6 := UDINT_TO_INT(Temp_IN_PWE);
						CounterRead := CounterRead  + 1;
					END_IF
				END_IF
			
			9:	// Error Buffer [7]
				Com.FLR_SIKO.IND := 7;
				Com.FLR_SIKO.PKE := 16#63B1;
			
				IF Com.SIKO_FLR.PKE = 16#43B1 THEN
					IF Com.SIKO_FLR.IND = 7 THEN
						DeviceData.Data.FaultBuffer7 := UDINT_TO_INT(Temp_IN_PWE);
						CounterRead := CounterRead  + 1;
					END_IF
				END_IF
			
			10:	// Error Buffer [8]
				Com.FLR_SIKO.IND := 8;
				Com.FLR_SIKO.PKE := 16#63B1;
			
				IF Com.SIKO_FLR.PKE = 16#43B1 THEN
					IF Com.SIKO_FLR.IND = 8 THEN
						DeviceData.Data.FaultBuffer8 := UDINT_TO_INT(Temp_IN_PWE);
						CounterRead := CounterRead  + 1;
					END_IF
				END_IF
			
			11:	// Error Buffer [9]
				Com.FLR_SIKO.IND := 9;
				Com.FLR_SIKO.PKE := 16#63B1;
			
				IF Com.SIKO_FLR.PKE = 16#43B1 THEN
					IF Com.SIKO_FLR.IND = 9 THEN
						DeviceData.Data.FaultBuffer9 := UDINT_TO_INT(Temp_IN_PWE);
						CounterRead := CounterRead  + 1;
					END_IF
				END_IF
			
			12:	// P Gain
				Com.FLR_SIKO.PKE := 16#13E8;
			
				IF Com.SIKO_FLR.PKE = 16#13E8 THEN
					DeviceData.Data.PGain := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := CounterRead  + 1;
				END_IF
			
			13:	// I Gain
				Com.FLR_SIKO.PKE := 16#13E9;
			
				IF Com.SIKO_FLR.PKE = 16#13E9 THEN
					DeviceData.Data.IGain := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := CounterRead  + 1;
				END_IF
			
			14:	// D Gain
				Com.FLR_SIKO.PKE := 16#13EA;
			
				IF Com.SIKO_FLR.PKE = 16#13EA THEN
					DeviceData.Data.DGain := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := CounterRead  + 1;
				END_IF
			
			15:	// A Pos
				Com.FLR_SIKO.PKE := 16#13EB;
			
				IF Com.SIKO_FLR.PKE = 16#13EB THEN
					DeviceData.Data.APos := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := CounterRead  + 1;
				END_IF
			
			16:	// V Pos
				Com.FLR_SIKO.PKE := 16#13EC;
			
				IF Com.SIKO_FLR.PKE = 16#13EC THEN
					DeviceData.Data.VPos := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := CounterRead  + 1;
				END_IF
			
			17:	// V Jog
				Com.FLR_SIKO.PKE := 16#13F0;
			
				IF Com.SIKO_FLR.PKE = 16#13F0 THEN
					DeviceData.Data.VJog := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := CounterRead  + 1;
				END_IF
			
			18:	// SpindlePitch
				Com.FLR_SIKO.PKE := 16#13F4;
			
				IF Com.SIKO_FLR.PKE = 16#13F4 THEN
					DeviceData.Data.SpindlePitch := UDINT_TO_INT(Temp_IN_PWE) / 100;
					CounterRead := CounterRead  + 1;
				END_IF
			
			19:	// GearIn
				Com.FLR_SIKO.PKE := 16#13F2;
			
				IF Com.SIKO_FLR.PKE = 16#13F2 THEN
					DeviceData.Data.GearIn := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := CounterRead  + 1;
				END_IF
			
			20:	// GearOut
				Com.FLR_SIKO.PKE := 16#13F3;
			
				IF Com.SIKO_FLR.PKE = 16#13F3 THEN
					DeviceData.Data.GearOut := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := CounterRead  + 1;
				END_IF
			
			21:	// Toll Pos
				Com.FLR_SIKO.PKE := 16#13F1;
			
				IF Com.SIKO_FLR.PKE = 16#13F1 THEN
					DeviceData.Data.PosWindows := UDINT_TO_REAL(Temp_IN_PWE) / KFactorReal;
					CounterRead := CounterRead  + 1;
				END_IF
			
			22:	// Rotation
				Com.FLR_SIKO.PKE := 16#13F5;
			
				IF Com.SIKO_FLR.PKE = 16#13F5 THEN
					DeviceData.Data.SenseOfRotation := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := CounterRead  + 1;
				END_IF
			
			23:	// Upper limit
				Com.FLR_SIKO.PKE := 16#13F8;
			
				IF Com.SIKO_FLR.PKE = 16#13F8 OR Com.SIKO_FLR.PKE = 16#23F8 THEN
					DeviceData.Data.UpperLimit := UDINT_TO_REAL(Temp_IN_PWE) / KFactorReal;
					CounterRead := CounterRead  + 1;
				END_IF
			
			24:	// Lower limit
				Com.FLR_SIKO.PKE := 16#13F9;
			
				IF Com.SIKO_FLR.PKE = 16#13F9 OR Com.SIKO_FLR.PKE = 16#23F9 THEN
					DeviceData.Data.LowerLimit := UDINT_TO_REAL(Temp_IN_PWE) / KFactorReal;
					CounterRead := CounterRead  + 1;
				END_IF
			
			25:	// Calibration value
				Com.FLR_SIKO.PKE := 16#13FA;
			
				IF Com.SIKO_FLR.PKE = 16#13FA OR Com.SIKO_FLR.PKE = 16#23FA THEN
					DeviceData.Data.CalibrationValue := UDINT_TO_REAL(Temp_IN_PWE) / KFactorReal;
					CounterRead := CounterRead  + 1;
				END_IF
			
			26:	// Status word
				Com.FLR_SIKO.PKE := 16#13FC;
			
				IF Com.SIKO_FLR.PKE = 16#13FC THEN
					DeviceData.Data.SystemStatusWord := UDINT_TO_INT(Temp_IN_PWE);
					CounterRead := 0;
				END_IF

		END_CASE
	END_IF
	
	DeviceData.WriteEnabled := (DeviceData.MotorDisabled OR NOT DeviceData.PositioningInProgress) AND NOT DeviceData.ReadOrWriteInProgress AND NOT DeviceData.ReadOrWriteError AND NOT DeviceData.IllegalOperation;
	
	RisingFrontWrite := EDGEPOS(DeviceData.StartWrite);
	
	IF RisingFrontWrite AND DeviceData.WriteEnabled AND NOT DeviceData.ReadOrWriteError THEN
		DeviceData.Data.TimeoutPositioning	:= IN_TimeOutPositioning;
		DeviceData.Data.PosWindows			:= IN_PosWindows;
		DeviceData.Data.UpperLimit			:= IN_UpperLimit;
		DeviceData.Data.LowerLimit			:= IN_LowerLimit;
		DeviceData.Data.CalibrationValue	:= IN_CalibrationValue;
		
		DeviceData.Data.PGain			:= REAL_TO_INT(IN_PGain);
		DeviceData.Data.IGain			:= REAL_TO_INT(IN_IGain);
		DeviceData.Data.DGain			:= REAL_TO_INT(IN_DGain);
		DeviceData.Data.VPos			:= REAL_TO_INT(IN_VPos);
		DeviceData.Data.APos			:= REAL_TO_INT(IN_APos);
		DeviceData.Data.VJog			:= REAL_TO_INT(IN_VJog);
		DeviceData.Data.GearIn			:= REAL_TO_INT(IN_GearIn);
		DeviceData.Data.GearOut			:= REAL_TO_INT(IN_GearOut);
		DeviceData.Data.SpindlePitch	:= REAL_TO_INT(IN_SpindlePitch);
		DeviceData.Data.SenseOfRotation	:= REAL_TO_INT(IN_SenseOfRotation);
	END_IF
		
	IF NOT DeviceData.ReadOrWriteError THEN
		IF RisingFrontWrite THEN
			CounterWrite := 1;
		END_IF
		
		CASE CounterWrite OF
			1:	// Op Mode
				Com.FLR_SIKO.PKE := 16#23A2;
				Temp_OUT_PWE := 2;
			
				IF Com.SIKO_FLR.PKE = 16#13A2 THEN
					CounterWrite := CounterWrite + 1;
				END_IF
			
			2:	// Proportional Gain
				Com.FLR_SIKO.PKE := 16#23E8;
				Temp_OUT_PWE := DeviceData.Data.PGain;
			
				IF Com.SIKO_FLR.PKE = 16#13E8 THEN
					CounterWrite := CounterWrite + 1;
				END_IF	
		
			3:	// Integral Gain
				Com.FLR_SIKO.PKE := 16#23E9;
				Temp_OUT_PWE := DeviceData.Data.IGain;
			
				IF Com.SIKO_FLR.PKE = 16#13E9 THEN
					CounterWrite := CounterWrite + 1;
				END_IF
			
			4:	// Derivative Gain
				Com.FLR_SIKO.PKE := 16#23EA;
				Temp_OUT_PWE := DeviceData.Data.DGain;
			
				IF Com.SIKO_FLR.PKE = 16#13EA THEN
					CounterWrite := CounterWrite + 1;
				END_IF
			
			5:	// Acc Positioning
				Com.FLR_SIKO.PKE := 16#23EB;
				Temp_OUT_PWE := DeviceData.Data.APos;
			
				IF Com.SIKO_FLR.PKE = 16#13EB THEN
					CounterWrite := CounterWrite + 1;
				END_IF	
			
			6:	// Speed Positioning
				Com.FLR_SIKO.PKE := 16#23EC;
				Temp_OUT_PWE := DeviceData.Data.VPos;
			
				IF Com.SIKO_FLR.PKE = 16#13EC THEN
					CounterWrite := CounterWrite + 1;
				END_IF
			
			7:	// Speed Jog
				Com.FLR_SIKO.PKE := 16#23F0;
				Temp_OUT_PWE := DeviceData.Data.VJog;
			
				IF Com.SIKO_FLR.PKE = 16#13F0 THEN
					CounterWrite := CounterWrite + 1;
				END_IF
			
			8:	// GearIn
				Com.FLR_SIKO.PKE := 16#23F2;
				Temp_OUT_PWE := DeviceData.Data.GearIn;
			
				IF Com.SIKO_FLR.PKE = 16#13F2 THEN
					CounterWrite := CounterWrite + 1;
				END_IF
			
			9:	// GearOut
				Com.FLR_SIKO.PKE := 16#23F3;
				Temp_OUT_PWE := DeviceData.Data.GearOut;
			
				IF Com.SIKO_FLR.PKE = 16#13F3 THEN
					CounterWrite := CounterWrite + 1;
				END_IF
			
			10:	// SpinlePitch
				Com.FLR_SIKO.PKE := 16#23F4;
				Temp_OUT_PWE := DeviceData.Data.SpindlePitch * 100 ;
			
				IF Com.SIKO_FLR.PKE = 16#13F4 THEN
					CounterWrite := CounterWrite + 1;
				END_IF
			
			11:	// Position Windows
				Com.FLR_SIKO.PKE := 16#23F1;
				Temp_OUT_PWE := REAL_TO_INT(DeviceData.Data.PosWindows * KFactorReal);
			
				IF Com.SIKO_FLR.PKE = 16#13F1 THEN
					CounterWrite := CounterWrite + 1;
				END_IF
			
			12:	// Rotatation
				Com.FLR_SIKO.PKE := 16#23F5;
				Temp_OUT_PWE := DeviceData.Data.SenseOfRotation;
			
				IF Com.SIKO_FLR.PKE = 16#13F5 THEN
					CounterWrite := CounterWrite + 1;
				END_IF
			
			13:	// Upper Limit
				Com.FLR_SIKO.PKE := 16#33F8;
				Temp_OUT_PWE := REAL_TO_UDINT(DeviceData.Data.UpperLimit * KFactorReal);
			
				IF Com.SIKO_FLR.PKE = 16#23F8 THEN
					CounterWrite := CounterWrite + 1;
				ELSIF Com.SIKO_FLR.PKE = 16#73F8 THEN
					CounterWrite := CounterWrite + 2;
				END_IF
			
			14:	// Lower Limit
				Com.FLR_SIKO.PKE := 16#33F9;
				Temp_OUT_PWE := REAL_TO_UDINT(DeviceData.Data.LowerLimit * KFactorReal);
			
				IF Com.SIKO_FLR.PKE = 16#23F9 THEN
					CounterWrite := 50;
				END_IF
				
			15:	//Upper Limit error - Write Lower Limit
				Com.FLR_SIKO.PKE := 16#33F9;
				Temp_OUT_PWE := REAL_TO_UDINT(DeviceData.Data.LowerLimit * KFactorReal);
				
				IF Com.SIKO_FLR.PKE = 16#23F9 THEN
					CounterWrite := CounterWrite + 1;
				END_IF
				
			16: //Upper Limit error - Reweite Upper limit
				Com.FLR_SIKO.PKE := 16#33F8;
				Temp_OUT_PWE := REAL_TO_UDINT(DeviceData.Data.UpperLimit * KFactorReal);
			
				IF Com.SIKO_FLR.PKE = 16#23F8 THEN
					CounterWrite	:= 50;
				END_IF

			50: //Reset PWE
				Temp_OUT_PWE	:= 0;
				CounterWrite	:= 0;
				ReloadData := TRUE;
		END_CASE
	END_IF	
	
	IF EDGEPOS(DeviceData.Calibrate AND DeviceData.WriteEnabled) THEN
		CounterCalibration := 1;	
	END_IF
	
	CASE CounterCalibration OF
		1:
			DeviceData.Data.CalibrationValue := IN_CalibrationValue;
			DeviceData.CalibrationDone := FALSE;
			CounterCalibration := CounterCalibration + 1;	
		
		2://Write Calibration Data
			Com.FLR_SIKO.PKE := 16#33FA;
			Temp_OUT_PWE := REAL_TO_UDINT(DeviceData.Data.CalibrationValue * KFactorReal);	
			DeviceData.CalibrationInProgress := TRUE;

			IF Com.SIKO_FLR.PKE = 16#23FA THEN
				CounterCalibration := CounterCalibration + 1;
			END_IF
	
		3://Check Calibration Data
			IF ABS(Temp_IN_PWE - Temp_HIW) < 5 THEN
				DeviceData.CalibrationDone := TRUE;
				DeviceData.CalibrationInProgress := FALSE;
				CounterCalibration := 0;
			END_IF
	END_CASE
	
	IF ((DeviceData.Calibrate AND NOT DeviceData.CalibrationInProgress) OR RisingFrontWrite) AND NOT DeviceData.WriteEnabled THEN
		DeviceData.IllegalOperation := TRUE;
	ELSIF DeviceData.IllegalOperation AND IN_Reset THEN
		DeviceData.IllegalOperation := FALSE;
	END_IF

	IO.FLR_SIKO := Com.FLR_SIKO;
	IO.FLR_SIKO.PWE_H := UDINT_TO_UINT(SHR(Temp_OUT_PWE, 16));
	IO.FLR_SIKO.PWE_L := UDINT_TO_UINT(Temp_OUT_PWE AND 16#FFFF);
	IO.FLR_SIKO.HSW_H := UDINT_TO_UINT(SHR(Temp_HSW, 16));
	IO.FLR_SIKO.HSW_L := UDINT_TO_UINT(Temp_HSW AND 16#FFFF) ;
	
END_FUNCTION_BLOCK