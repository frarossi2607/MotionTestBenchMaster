
TYPE
	CFG_Motion_Type : 	STRUCT 
		Generic : CFG_Generic_Type;
		Mechanical : CFG_Mechanical_Type;
		MotorDisableConfig : ARRAY[0..9]OF CFG_MotorDisableConfig_Type;
		Movements : CFG_Movements_Type;
		MaximumGearBoxTorque : CFG_Torque_Type;
		Axes : CFG_Axes_Type;
	END_STRUCT;
	CFG_Generic_Type : 	STRUCT 
		KochModulePresent : BOOL;
		DisengageImmediately : BOOL; (*In combi mode if TRUE disengage immediately the machine, without waiting SynchroDisengage command*)
		AxesMultiplexingOn : BOOL;
		MotionIntegrated : BOOL;
		SyncroPar : CFG_SyncroPar_Type;
		Aseptic : BOOL;
		DoubleInlet : BOOL; (*If TRUE Inlet03 and Inlet06 take Inlet02 as Homing Master*)
		EmulationCardPulses : UINT;
	END_STRUCT;
	CFG_SyncroPar_Type : 	STRUCT 
		ExternalEncoder : BOOL;
		ExternalPositionFormat : BOOL; (*FALSE: LREAL TRUE: DINT //v4.A.A.1.7.0*)
		NumberOfSteps : UINT; (*Master Virtual Position := 1*)
		ExternalSignalPeriod : UDINT; (*Master Virtual Position := 3600000*)
	END_STRUCT;
	CFG_Mechanical_Type : 	STRUCT 
		MachineStep : LREAL; (*Machine Step [mm]*)
		LagErrorThreshold : REAL; (*Lag error threshold [mm]*)
		ReferenceId : CFG_RefId_Type;
	END_STRUCT;
	CFG_RefId_Type : 	STRUCT 
		Capper : USINT;
		Crowner : USINT;
		Doser : USINT;
		Filler : USINT;
		Rinser : USINT;
		Seamer : USINT;
	END_STRUCT;
	CFG_Movements_Type : 	STRUCT 
		Jerk : REAL;
		EmergencyDec : REAL;
		ShutDownDec : REAL;
		MachineMaxSpeed : REAL;
	END_STRUCT;
	CFG_MotorDisableConfig_Type : 	STRUCT 
		MotorIndexNumberDisable : ARRAY[CST_FirstFillerModuleAxis..CST_LastFillerModuleAxis]OF BOOL;
	END_STRUCT;
	CFG_Torque_Type : 	STRUCT 
		Inlet : CFG_InletTorque_Type;
		Filler : CFG_FillerTorque_Type;
		Outlet : CFG_OutletTorque_Type;
	END_STRUCT;
	CFG_InletTorque_Type : 	STRUCT 
		Main : REAL;
		In : ARRAY[1..4]OF REAL;
		Out : ARRAY[1..4]OF REAL;
	END_STRUCT;
	CFG_FillerTorque_Type : 	STRUCT 
		Main : REAL;
		In : ARRAY[1..10]OF REAL;
		Out : ARRAY[1..6]OF REAL;
	END_STRUCT;
	CFG_OutletTorque_Type : 	STRUCT 
		Main : REAL;
		In : ARRAY[1..4]OF REAL;
		Out : ARRAY[1..4]OF REAL;
	END_STRUCT;
	CFG_Axes_Type : 	STRUCT 
		Inlet : CFG_InletAxes_Type;
		Filler : CFG_FillerAxes_Type;
		Outlet : CFG_OutletAxes_Type;
	END_STRUCT;
	CFG_InletAxes_Type : 	STRUCT 
		Main : CFG_Axis_Type;
		In : ARRAY[1..4]OF CFG_Axis_Type;
		Out : ARRAY[1..4]OF CFG_Axis_Type;
	END_STRUCT;
	CFG_FillerAxes_Type : 	STRUCT 
		Main : CFG_Axis_Type;
		In : ARRAY[1..10]OF CFG_Axis_Type;
		Out : ARRAY[1..6]OF CFG_Axis_Type;
	END_STRUCT;
	CFG_OutletAxes_Type : 	STRUCT 
		Main : CFG_Axis_Type;
		In : ARRAY[1..4]OF CFG_Axis_Type;
		Out : ARRAY[1..4]OF CFG_Axis_Type;
	END_STRUCT;
	CFG_Axis_Type : 	STRUCT 
		HmiNameId : USINT;
		ThirdPartyMotor : BOOL;
		VelocityControl : BOOL;
		InductionMotor : BOOL;
		InductionMotorData : CFG_InductionMotorSetup_Type;
	END_STRUCT;
	CFG_InductionMotorSetup_Type : 	STRUCT 
		RatedVoltage : REAL; (*rated voltage [V]*)
		RatedCurrent : REAL; (*rated current [A]*)
		RatedSpeed : REAL; (*rated numbers of revolutions [1/min]*)
		RatedFrequency : REAL; (*rated frequenzy [Hz]*)
		PowerFactor : REAL; (*cos phi*)
		ThermalTrippingTime : REAL; (*tripping time at thermal overload [s]*)
	END_STRUCT;
END_TYPE
