ACTION LiftMoveMngt_Doser:
	
	
	VAR_DOS_Lift_State.DevicesGeneralAlarm := MMF[205].OUT_DriveFault OR MMF[205].OUT_OverloadFault OR MMF[206].OUT_DriveFault OR 
												MMF[206].OUT_OverloadFault OR _205MEF.OUT_Alarm OR _206MEF.OUT_Alarm;
	
	VAR_DOS_Lift_State.CmdProductionHeight.Sp	:= HMI_PAR_1._215; //[ml]
	VAR_DOS_Lift_State.CmdCipHeight.Sp			:= 145.0; //[ml]
	
	VAR_DOS_PistonVolume_ml := 145.0; 	(*ml*)  //Max Volume [ml]
	VAR_DOS_PistonVolume_mm := 180.0;	(*mm*)  //Max height of recipe [mm] 
	
	FbLCRLimScal_ml_mm(
	x1 := 0.0, 		(*ml*) 
	y1 := 0.0, 		(*mm*)
	x2 := VAR_DOS_PistonVolume_ml, 	(*ml*)
	y2 := VAR_DOS_PistonVolume_mm,	(*mm*)
	);
	
	FbLCRLimScal_mm_ml(
	x1 := 0.0, 		(*mm*) 
	y1 := 0.0, 		(*ml*)
	x2 := VAR_DOS_PistonVolume_mm, 	(*mm*)
	y2 := VAR_DOS_PistonVolume_ml,	(*ml*)
	);
	
	IF ((VAR_DOS_ModePositionRequest AND (VAR_DOS_ModeProduction OR VAR_DOS_FMDProductionFillerOnly)) OR (HMI_DOS_LiftPosition.Value = 1)) THEN
		VAR_DOS_MMF205.SpActual[ml] := MIN(VAR_DOS_Lift_State.CmdProductionHeight.Sp,VAR_DOS_PistonVolume_ml);
		FbLCRLimScal_ml_mm.x 		:= VAR_DOS_MMF205.SpActual[ml];
		VAR_DOS_MMF205.SpActual[mm]	:= FbLCRLimScal_ml_mm.y;
		VAR_DOS_MMF206.SpActual[mm]	:= 0.0; 
	ELSIF ((VAR_DOS_ModePositionRequest AND (VAR_DOS_ModeCip OR VAR_DOS_ModeRinse)) OR (HMI_DOS_LiftPosition.Value = 3)) THEN
		VAR_DOS_MMF205.SpActual[ml] := MIN(VAR_DOS_Lift_State.CmdCipHeight.Sp,VAR_DOS_PistonVolume_ml);
		FbLCRLimScal_ml_mm.x 		:= VAR_DOS_MMF205.SpActual[ml];
		VAR_DOS_MMF205.SpActual[mm]	:= FbLCRLimScal_ml_mm.y;
		VAR_DOS_MMF206.SpActual[mm]	:= 0.0;
	ELSIF ((VAR_DOS_ModePositionRequest AND VAR_DOS_ModeCop AND COP.DataOut.DoserPositioningReq) OR (HMI_DOS_LiftPosition.Value = 2)) THEN 
		VAR_DOS_MMF205.SpActual[mm] := 322.0; //High sensor height _215DSF  Define in Test
		VAR_DOS_MMF205.SpActual[ml] := 0;
		VAR_DOS_MMF206.SpActual[mm]	:= 323.0;
	ELSIF HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON THEN 
		VAR_DOS_MMF205.SpActual[mm] := 0.0; 
		VAR_DOS_MMF206.SpActual[mm]	:= VAR_DOS_MMF205.SpActual[mm]; //--> Define in Test _205MEF.IN_Delta and _206MEF.IN_Delta
	ELSE 
		VAR_DOS_MMF205.SpActual[mm] := 0.0;
		VAR_DOS_MMF205.SpActual[ml] := 0.0;  
		VAR_DOS_MMF206.SpActual[mm] := 0.0;
	END_IF
		
	memset(ADR(VAR_DOS_LiftMMF205SeqMem), 0, SIZEOF(VAR_DOS_LiftMMF205SeqMem));
	memset(ADR(VAR_DOS_LiftMMF206SeqMem), 0, SIZEOF(VAR_DOS_LiftMMF206SeqMem));
	HMI_DOS_PB[PB_DOS_Up].Enable		:= FALSE;
	HMI_DOS_PB[PB_DOS_Down].Enable		:= FALSE;
	_211CPF.IN_AutoCnd 					:= FALSE;
	IF EDGEPOS(VAR_DOS_Lift_State.DevicesGeneralAlarm) THEN
		VAR_DOS_LiftStepMem := VAR_DOS_LiftMoveStep;
	END_IF
	
	IF EDGENEG(VAR_DOS_ModeWait) OR NOT HMI_DOS_LiftPosition.Enable THEN
		HMI_DOS_LiftPosition.Value := 0;
	END_IF
	
	IF EDGEPOS(VAR_DOS_FMDPositionRequest) THEN
		VAR_DOS_SeqPositionReached := FALSE;
	END_IF

	//*******************************************************************************************************************************************
	CASE VAR_DOS_LiftMoveStep OF
		DSR_LiftSystemOff:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 0;
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 0;
			
			VAR_DOS_LiftMMF205SeqMem.Position.ActualSp	:= VAR_DOS_MMF205.SpActual[ml]; //[ml]
			
			IF HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON THEN
				VAR_DOS_LiftMoveStep := DSR_Manual;
			ELSIF HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON THEN 
				VAR_DOS_LiftMoveStep := DSR_ProbeZeroReq;
			ELSIF ((VAR_DOS_ModeCop AND COP.DataOut.DoserPositioningReq AND NOT VAR_DOS_SeqPositionReached) OR (EDGEPOS(HMI_DOS_PB[PB_CmdLiftMotorStart].ON) AND HMI_DOS_LiftPosition.Value = 2)) THEN 
				VAR_DOS_LiftMoveStep := DSR_PosMMF206ToMMF205;
			ELSIF (((VAR_DOS_ModeProduction OR VAR_DOS_FMDProductionFillerOnly) AND VAR_DOS_ModePositionRequest AND NOT VAR_DOS_SeqPositionReached) OR (EDGEPOS(HMI_DOS_PB[PB_CmdLiftMotorStart].ON) AND HMI_DOS_LiftPosition.Value = 1))THEN
				VAR_DOS_LiftMoveStep := DSR_DosingReq;
			ELSIF (((VAR_DOS_ModeCip OR VAR_DOS_ModeRinse) AND VAR_DOS_ModePositionRequest AND NOT VAR_DOS_SeqPositionReached) OR (EDGEPOS(HMI_DOS_PB[PB_CmdLiftMotorStart].ON) AND HMI_DOS_LiftPosition.Value = 3)) THEN
				VAR_DOS_LiftMoveStep := DSR_DosingReq;
			END_IF
	
		
		DSR_ProbeZeroReq: 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 1; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 1;
			
			VAR_DOS_LiftMoveStep := DSR_ProbeZeroLowPos;
			IF NOT HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON THEN
				VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
			END_IF		
		
		
		DSR_ProbeZeroLowPos:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 2; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 2;
		
			IF NOT VAR_DOS_Lift_State.DevicesGeneralAlarm THEN
				
				IF ((VAR_DOS_MMF205.PosActual[mm] <= VAR_DOS_MMF205.SpActual[mm]) OR VAR_DOS_MMF205.SensorLowPos OR (VAR_DOS_MMF205.PosActual[mm] < VAR_DOS_MMF206.PosActual[mm] - 5.0)) THEN
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn := FALSE;
				ELSIF VAR_DOS_MMF205.SpActual[mm] <= VAR_DOS_MMF205.PosActual[mm] THEN
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn := TRUE;
				END_IF
									 
				IF ((VAR_DOS_MMF206.PosActual[mm] <= VAR_DOS_MMF206.SpActual[mm]) OR VAR_DOS_MMF206.SensorLowPos OR (VAR_DOS_MMF206.PosActual[mm] <= VAR_DOS_MMF205.PosActual[mm] - VAR_DOS_PistonVolume_mm)) THEN
					VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn := FALSE;
				ELSIF ((VAR_DOS_MMF206.PosActual[mm] >= VAR_DOS_MMF205.SpActual[mm]) OR (VAR_DOS_MMF206.PosActual[mm] >= VAR_DOS_MMF206.SpActual[mm] AND VAR_DOS_MMF205.PosReached)) (*mm*)THEN
					VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn := TRUE;
				END_IF

				IF VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn THEN
					IF VAR_DOS_MMF205.SensorMaxVol THEN
						VAR_DOS_LiftMMF205SeqMem.Sensor.SensorMaxVolWaitOff := TRUE;
					ELSIF NOT VAR_DOS_MMF205.SensorLowPos THEN
						VAR_DOS_LiftMMF205SeqMem.Sensor.SensorLowPosWaitOn := TRUE;
					END_IF
				END_IF
				
				IF VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn THEN
					IF NOT VAR_DOS_MMF206.SensorLowPos THEN
						VAR_DOS_LiftMMF206SeqMem.Sensor.SensorLowPosWaitOn := TRUE;
					END_IF
				END_IF

				IF NOT VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn AND NOT VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn THEN
					VAR_DOS_LiftMoveStep := DSR_ProbeZeroDisengSensLow;
				END_IF
				
				IF NOT HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON THEN
					VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
				END_IF		

			END_IF
		
		
		DSR_ProbeZeroDisengSensLow:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 3; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 3;
			
			IF NOT VAR_DOS_Lift_State.DevicesGeneralAlarm THEN
				VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up := VAR_DOS_MMF205.SensorLowPos;
				VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up := VAR_DOS_MMF206.SensorLowPos;

				VAR_DOS_LiftMMF205SeqMem.Sensor.SensorLowPosWaitOff := VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up AND VAR_DOS_MMF205.SensorLowPos;
				VAR_DOS_LiftMMF206SeqMem.Sensor.SensorLowPosWaitOff := VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up AND VAR_DOS_MMF206.SensorLowPos;

				IF NOT VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up AND NOT VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up THEN
					VAR_DOS_LiftMoveStep := DSR_ProbeZeroWaitSensLowPos;
				END_IF
				
				IF NOT HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON THEN
					VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
				END_IF		
			END_IF
			
		DSR_ProbeZeroWaitSensLowPos:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 4; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 4;
			
			IF NOT VAR_DOS_Lift_State.DevicesGeneralAlarm THEN
				VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn := NOT VAR_DOS_MMF205.SensorLowPos;
				VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn := NOT VAR_DOS_MMF206.SensorLowPos;

				VAR_DOS_LiftMMF205SeqMem.Sensor.SensorLowPosWaitOff := VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up AND NOT VAR_DOS_MMF205.SensorLowPos;
				VAR_DOS_LiftMMF206SeqMem.Sensor.SensorLowPosWaitOff := VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up AND NOT VAR_DOS_MMF206.SensorLowPos;

				IF NOT VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn AND NOT VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn THEN
					VAR_DOS_MMF205.PosValid := FALSE;
					VAR_DOS_MMF206.PosValid := FALSE;
					Delta_205MEF			:= 0.0;
					Delta_206MEF			:= 0.0;
					VAR_DOS_LiftMoveStep	:= DSR_ProbeZeroDone;
				END_IF
			END_IF
		
			IF NOT HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON THEN
				VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
			END_IF
		
		DSR_ProbeZeroDone:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 5; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 5;

			IF NOT VAR_DOS_Lift_State.DevicesGeneralAlarm THEN
				IF NOT VAR_DOS_MMF205.PosValid THEN
					Delta_205MEF			:= -(_205MEF.OUT_ActValue + Delta_205MEF) + 0.5;
					VAR_DOS_MMF205.PosValid := TRUE;
				END_IF
				
				IF NOT VAR_DOS_MMF206.PosValid THEN
					Delta_206MEF 		:= -(_206MEF.OUT_ActValue + Delta_206MEF) + 0.5;
					VAR_DOS_MMF206.PosValid := TRUE;
				END_IF
			END_IF
				
			IF VAR_DOS_MMF205.PosValid AND VAR_DOS_MMF206.PosValid THEN
				HMI_DOS_SS2P[SS2P_DOS_ProbeAdjustment].ON := FALSE;
				VAR_DOS_LiftMoveStep					  := DSR_LiftSystemOff;
			END_IF
		
		DSR_PosMMF206ToMMF205: 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 10; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 10;
			VAR_DOS_LiftMMF205SeqMem.Position.ActualSp	:= VAR_DOS_MMF205.SpActual[ml]; //[ml]
			VAR_DOS_SeqPositionReached	:= FALSE;
			
			IF NOT VAR_DOS_Lift_State.DevicesGeneralAlarm THEN
				IF VAR_DOS_ModeCop THEN
					VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up := (VAR_DOS_MMF206.PosActual[mm] < VAR_DOS_MMF205.PosActual[mm]); 
					IF NOT VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up THEN
						VAR_DOS_LiftMoveStep := DSR_UpMMF205andMMF206;
					END_IF
				ELSIF VAR_DOS_MMF205.SpActual[mm] >= VAR_DOS_MMF205.PosActual[mm] THEN
					VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up := VAR_DOS_MMF206.PosActual[mm] < VAR_DOS_MMF205.PosActual[mm];
					IF NOT VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up THEN
						VAR_DOS_LiftMoveStep := DSR_UpMMF205andMMF206;
					END_IF
				END_IF
			ELSE
				VAR_DOS_LiftMoveStep := DSR_Fault;
			END_IF
		
				
		DSR_UpMMF205andMMF206:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 11; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 11;
			
			VAR_DOS_LiftMMF205SeqMem.Position.ActualSp	:= VAR_DOS_MMF205.SpActual[ml]; //[ml]

			IF EDGEPOS(HMI_DOS_PB[PB_CmdLiftMotorStop].ON) THEN
				VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
			END_IF
			
			IF NOT VAR_DOS_Lift_State.DevicesGeneralAlarm THEN
						
				IF ((VAR_DOS_MMF205.PosActual[mm] > VAR_DOS_MMF205.SpActual[mm]) OR VAR_DOS_MMF205.SensorHighPos OR (VAR_DOS_MMF205.PosActual[mm] > VAR_DOS_MMF206.PosActual[mm] + VAR_DOS_PistonVolume_mm)) THEN
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up := FALSE;
				ELSIF VAR_DOS_MMF205.SpActual[mm] >= VAR_DOS_MMF205.PosActual[mm] THEN
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up := TRUE;
				END_IF
									 
				IF ((VAR_DOS_MMF206.PosActual[mm] > VAR_DOS_MMF206.SpActual[mm]) OR VAR_DOS_MMF206.SensorHighPos OR (VAR_DOS_MMF206.PosActual[mm] > VAR_DOS_MMF205.PosActual[mm] + 5.0)) THEN
					VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up := FALSE;
				ELSIF VAR_DOS_MMF206.PosActual[mm] <= VAR_DOS_MMF206.SpActual[mm] THEN //CHECK
					VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up := TRUE;
				END_IF
					
				IF NOT VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up THEN 
					VAR_DOS_MMF205.PosReached := TRUE;
				ELSE
					VAR_DOS_MMF205.PosReached := FALSE;
				END_IF

				IF NOT VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up THEN 
					VAR_DOS_MMF206.PosReached := TRUE;
				ELSE
					VAR_DOS_MMF206.PosReached := FALSE;
				END_IF
				
				IF ((VAR_DOS_ModeCop AND COP.DataOut.DoserPositioningReq) OR (VAR_DOS_ModeWait AND (HMI_DOS_LiftPosition.Value = 2))) THEN
					IF VAR_DOS_MMF206.PosReached AND VAR_DOS_MMF205.PosReached AND VAR_DOS_MMF205.SensorHighPos AND VAR_DOS_MMF206.SensorHighPos THEN
						VAR_DOS_LiftMoveStep := DSR_CopPosReached;
					END_IF	
				ELSE
					VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
				END_IF
			ELSE
				VAR_DOS_LiftMoveStep := DSR_Fault;
			END_IF
					
				
		DSR_DwnMMF205andMMF206:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 12; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 12;
			
			VAR_DOS_LiftMMF205SeqMem.Position.ActualSp	:= VAR_DOS_MMF205.SpActual[ml]; //[ml]
			
			IF EDGEPOS(HMI_DOS_PB[PB_CmdLiftMotorStop].ON) THEN
				VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
			END_IF

			IF NOT VAR_DOS_Lift_State.DevicesGeneralAlarm THEN
						
				IF ((VAR_DOS_MMF205.PosActual[mm] < VAR_DOS_MMF205.SpActual[mm]) OR VAR_DOS_MMF205.SensorLowPos OR (VAR_DOS_MMF205.PosActual[mm] < VAR_DOS_MMF206.PosActual[mm] - 5.0)) THEN
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn := FALSE;
				ELSIF VAR_DOS_MMF205.SpActual[mm] <= VAR_DOS_MMF205.PosActual[mm] THEN
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn := TRUE;
				END_IF
									 
				IF ((VAR_DOS_MMF206.PosActual[mm] < VAR_DOS_MMF206.SpActual[mm]) OR VAR_DOS_MMF206.SensorLowPos OR (VAR_DOS_MMF206.PosActual[mm] <= VAR_DOS_MMF205.PosActual[mm] - VAR_DOS_PistonVolume_mm)) THEN
					VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn := FALSE;
				ELSIF ((VAR_DOS_MMF206.PosActual[mm] >= VAR_DOS_MMF205.SpActual[mm]) OR (VAR_DOS_MMF206.PosActual[mm] >= VAR_DOS_MMF206.SpActual[mm])) (*mm*)THEN
					VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn := TRUE;
					END_IF
				
				IF NOT VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn THEN 
					VAR_DOS_MMF205.PosReached := TRUE;
				ELSE
					VAR_DOS_MMF205.PosReached := FALSE;
				END_IF

				IF NOT VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn THEN 
					VAR_DOS_MMF206.PosReached := TRUE;
				ELSE
					VAR_DOS_MMF206.PosReached := FALSE;
				END_IF
				
				IF (VAR_DOS_ModeCop AND COP.DataOut.DoserPositioningReq) OR (VAR_DOS_ModeWait AND HMI_DOS_LiftPosition.Value = 2) THEN 
					IF VAR_DOS_MMF206.PosReached AND VAR_DOS_MMF206.SensorHighPos AND VAR_DOS_MMF205.SensorHighPos THEN
						VAR_DOS_LiftMoveStep := DSR_CopPosReached;
					END_IF	
				ELSIF (VAR_DOS_ModeProduction OR VAR_DOS_FMDProductionFillerOnly) OR (VAR_DOS_ModeWait AND HMI_DOS_LiftPosition.Value = 1)THEN
					IF VAR_DOS_MMF206.PosReached AND VAR_DOS_MMF206.SensorLowPos THEN
						VAR_DOS_LiftMoveStep := DSR_DosingActive;
					END_IF 
				ELSIF (VAR_DOS_ModeCip OR VAR_DOS_ModeRinse) OR (VAR_DOS_ModeWait AND HMI_DOS_LiftPosition.Value = 3) THEN
					IF VAR_DOS_MMF206.PosReached AND VAR_DOS_MMF206.SensorLowPos THEN
						VAR_DOS_LiftMoveStep := DSR_DosingActive;
					END_IF
				ELSE
					VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
				END_IF
			ELSE
				VAR_DOS_LiftMoveStep := DSR_Fault;
			END_IF
			
		
		DSR_CopPosReached:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 6;
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 6;
			
			VAR_DOS_LiftMMF205SeqMem.Position.ActualSp	:= VAR_DOS_MMF205.SpActual[ml]; //[ml]

			_211CPF.IN_AutoCnd := COP.DataOut.DoserPositioningReq AND VAR_DOS_MMF205.SensorHighPos AND VAR_DOS_MMF206.SensorHighPos;
			
			VAR_DOS_SeqPositionReached := _210DSX.OUT;	
			
			IF NOT COP.DataOut.DoserPositioningReq AND _211DSX.OUT THEN
				VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
			END_IF
		
		
		DSR_DosingReq:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 7;
			IF VAR_DOS_ModeCip THEN
				HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 15;//CIP
			ELSIF VAR_DOS_ModeProduction THEN
				HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 7;//PRODUCTION
			END_IF
			VAR_DOS_LiftMMF205SeqMem.Position.ActualSp	:= VAR_DOS_MMF205.SpActual[ml]; //[ml]
			VAR_DOS_SeqPositionReached	:= FALSE;
			
			IF NOT VAR_DOS_MMF206.SensorLowPos THEN
				VAR_DOS_LiftMoveStep := DSR_DwnMMF205andMMF206;
			ELSE
				VAR_DOS_LiftMoveStep := DSR_DosingActive;
			END_IF

		
		DSR_DosingActive:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 8; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 8;
			
			VAR_DOS_LiftMMF205SeqMem.Position.ActualSp	:= VAR_DOS_MMF205.SpActual[ml]; //[ml]
			
			IF EDGEPOS(HMI_DOS_PB[PB_CmdLiftMotorStop].ON) THEN
				VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
			END_IF
			
			IF NOT VAR_DOS_Lift_State.DevicesGeneralAlarm THEN
						
				IF ((VAR_DOS_MMF205.PosActual[mm] > VAR_DOS_MMF205.SpActual[mm]) OR VAR_DOS_MMF205.SensorHighPos OR VAR_DOS_MMF205.SensorMaxVol OR (VAR_DOS_MMF205.PosActual[mm] > VAR_DOS_MMF206.PosActual[mm] + VAR_DOS_PistonVolume_mm)) THEN
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up := FALSE;
				ELSIF VAR_DOS_MMF205.SpActual[mm] - 0.5 >= VAR_DOS_MMF205.PosActual[mm] THEN
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up := TRUE;
				END_IF
					
				IF ((VAR_DOS_MMF205.PosActual[mm] < VAR_DOS_MMF205.SpActual[mm]) OR VAR_DOS_MMF205.SensorLowPos) THEN
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn := FALSE;
				ELSIF VAR_DOS_MMF205.SpActual[mm] + 0.5 <= VAR_DOS_MMF205.PosActual[mm] THEN
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn := TRUE;
				END_IF

				IF (NOT VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up AND NOT VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn) THEN
					VAR_DOS_MMF205.PosReached := TRUE;
				ELSE
					VAR_DOS_MMF205.PosReached := FALSE;
				END_IF
				
				VAR_DOS_MMF206.PosReached	:= VAR_DOS_MMF206.SensorLowPos;	
				
				VAR_DOS_SeqPositionReached	:= VAR_DOS_MMF205.PosReached AND VAR_DOS_MMF206.PosReached;
				
				IF VAR_DOS_SeqPositionReached THEN
					VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
				END_IF
			ELSE
				VAR_DOS_LiftMoveStep := DSR_Fault;
			END_IF
		
		DSR_Manual:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr		:= 9; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText	:= 9;
			
			VAR_DOS_LiftMMF205SeqMem.Position.ActualSp	:= VAR_DOS_MMF205.SpActual[ml]; //[ml]

			IF NOT VAR_DOS_Lift_State.DevicesGeneralAlarm THEN
				IF HMI_DOS_SS2P[SS2P_DOS_ManualMMF205].LampON AND NOT VAR_DOS_MMF205.SensorHighPos AND VAR_DOS_MMF205.PosActual[mm] <= VAR_DOS_MMF206.PosActual[mm] + VAR_DOS_PistonVolume_mm THEN 
					HMI_DOS_PB[PB_DOS_Up].Enable := TRUE;
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up := HMI_DOS_PB[PB_DOS_Up].LampON;
				ELSIF HMI_DOS_SS2P[SS2P_DOS_ManualMMF206].LampON AND NOT VAR_DOS_MMF206.SensorHighPos AND VAR_DOS_MMF206.PosActual[mm] <= VAR_DOS_MMF205.PosActual[mm] THEN
					HMI_DOS_PB[PB_DOS_Up].Enable := TRUE;
					VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up := HMI_DOS_PB[PB_DOS_Up].LampON;
				END_IF
		
				IF HMI_DOS_SS2P[SS2P_DOS_ManualMMF205].LampON AND NOT VAR_DOS_MMF205.SensorLowPos AND VAR_DOS_MMF205.PosActual[mm] >= VAR_DOS_MMF206.PosActual[mm] - 10.0 THEN 
					HMI_DOS_PB[PB_DOS_Down].Enable := TRUE;
					VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn := HMI_DOS_PB[PB_DOS_Down].LampON;	
				ELSIF HMI_DOS_SS2P[SS2P_DOS_ManualMMF206].LampON AND NOT VAR_DOS_MMF206.SensorLowPos AND VAR_DOS_MMF206.PosActual[mm] >= VAR_DOS_MMF205.PosActual[mm] - VAR_DOS_PistonVolume_mm THEN  
					HMI_DOS_PB[PB_DOS_Down].Enable := TRUE;
					VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn := HMI_DOS_PB[PB_DOS_Down].LampON;	
				END_IF	
			END_IF	
		
			IF NOT HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON THEN
				VAR_DOS_LiftMoveStep := DSR_LiftSystemOff;
			END_IF			
				
		DSR_Fault:
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexNr	:= 13; 
			HMI_DOS_Lift_State.Sequencer.TextBar[0].IndexText 	:= 13;
			
			VAR_DOS_SeqPositionReached	:= FALSE;
			
			VAR_DOS_LiftMMF205SeqMem.Position.ActualSp	:= VAR_DOS_MMF205.SpActual[ml] * BOOL_TO_REAL(VAR_DOS_ModePositionRequest);
			IF NOT VAR_DOS_Lift_State.DevicesGeneralAlarm THEN
				VAR_DOS_LiftMoveStep := VAR_DOS_LiftStepMem;
			END_IF
		
	END_CASE
	//******************************************************************************************************************************************				
		
	MMF[205].IN_AutoCnd		:= (VAR_DOS_LiftMMF205SeqMem.LiftMotor.Up AND NOT VAR_DOS_MMF205.SensorHighPos) OR 
	(VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn AND NOT VAR_DOS_MMF205.SensorLowPos);	
	MMF[205].IN_Reverse		:= VAR_DOS_LiftMMF205SeqMem.LiftMotor.Dwn AND MMF[205].IN_AutoCnd;
		
	MMF[206].IN_AutoCnd		:= (VAR_DOS_LiftMMF206SeqMem.LiftMotor.Up AND NOT VAR_DOS_MMF206.SensorHighPos) OR 
	(VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn AND NOT VAR_DOS_MMF206.SensorLowPos);	
	MMF[206].IN_Reverse		:= VAR_DOS_LiftMMF206SeqMem.LiftMotor.Dwn AND MMF[206].IN_AutoCnd;
				
			
	_215DSF.IN_WaitOn	:= VAR_DOS_LiftMMF205SeqMem.Sensor.SensorHighPosWaitOn;
	_215DSF.IN_WaitOff	:= VAR_DOS_LiftMMF205SeqMem.Sensor.SensorHighPosWaitOff;
	
	_216DSF.IN_WaitOn	:= VAR_DOS_LiftMMF206SeqMem.Sensor.SensorHighPosWaitOn;
	_216DSF.IN_WaitOff	:= VAR_DOS_LiftMMF206SeqMem.Sensor.SensorHighPosWaitOff;
	_217DSF.IN_WaitOn	:= VAR_DOS_LiftMMF206SeqMem.Sensor.SensorLowPosWaitOn;
	_217DSF.IN_WaitOff	:= VAR_DOS_LiftMMF206SeqMem.Sensor.SensorLowPosWaitOff;

	VAR_DOS_MMF205.SensorHighPos := _215DSF.OUT AND NOT _212DSF.OUT AND NOT _213DSF.OUT;
	VAR_DOS_MMF205.SensorMaxVol  := NOT _212DSF.OUT AND _213DSF.OUT;
	VAR_DOS_MMF205.SensorLowPos	 := NOT _213DSF.OUT AND NOT _215DSF.OUT AND _212DSF.OUT;
	VAR_DOS_MMF205.PosActual[mm] := _205MEF.OUT_ActValue;
	FbLCRLimScal_mm_ml.x		 := VAR_DOS_MMF205.PosActual[mm];
	VAR_DOS_MMF205.PosActual[ml] := FbLCRLimScal_mm_ml.y;
		
	VAR_DOS_MMF206.SensorHighPos := _216DSF.OUT AND NOT _217DSF.OUT; 
	VAR_DOS_MMF206.SensorLowPos  := _217DSF.OUT AND NOT _216DSF.OUT;
	VAR_DOS_MMF206.PosActual[mm] := _206MEF.OUT_ActValue;
	
	IF _205MEF.OUT_Alarm AND MMF[205].OUT_InOperation THEN
		VAR_DOS_MMF205.PosValid := FALSE;
	END_IF
	IF _206MEF.OUT_Alarm AND MMF[206].OUT_InOperation THEN
		VAR_DOS_MMF206.PosValid := FALSE;
	END_IF
		
	END_ACTION