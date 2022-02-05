FUNCTION_BLOCK PID_Cont
	VAR_RTInfo(enable:=TRUE);	
	VAR_CycleCounter	:= MAX(1, VAR_CycleCounter + 1);
	
	TON_Cycle(	IN := TRUE,
				PT := IN_CycleTime - UDINT_TO_TIME(VAR_RTInfo.cycle_time / 1000));
	
	IF NOT TON_Cycle.Q THEN
		RETURN;
	END_IF
	
	VAR_CycleTime	:= (UDINT_TO_REAL(VAR_RTInfo.cycle_time) * VAR_CycleCounter) / 1000000.0;
	VAR_CycleCounter 	:= 0.0;
	memset(ADR(TON_Cycle), 0, SIZEOF(TON_Cycle));
	
	(*****************************************************************)
	(*************************SP MANAGE*******************************)
	(*****************************************************************)
	IF NOT VAR_FirstCycle THEN
		VAR_FirstCycle	:= TRUE;
		HMI.SPLocal		:= FALSE;
		OUT		:= 0.0;
		OUT_P	:= 0.0;
		OUT_I	:= 0.0;
		OUT_D	:= 0.0;
	END_IF

	IF EDGE(HMI.SPLocal) OR EDGEPOS(IN_Auto) THEN
		VAR_SlewInit	:= TRUE;
	END_IF
	
	IF VAR_SlewInit AND HMI.SPLocal THEN
		HMI.PV		:= IN_PV;
		LCRRamp.x	:= MIN(IN_PV, HMI.SP_Local);
		LCRRamp.set	:= TRUE;
	ELSIF VAR_SlewInit AND IN_Auto THEN
		HMI.PV		:= IN_PV;
		LCRRamp.x	:= MIN(IN_PV, IN_AutoSP);
		LCRRamp.set	:= TRUE;		
	ELSIF HMI.SPLocal THEN
		HMI.PV		:= IN_PV;
		LCRRamp.x	:= HMI.SP_Local;
		LCRRamp.set	:= NOT HMI.ConfigSlewPresent;
	ELSIF IN_Auto THEN
		HMI.PV		:= IN_PV;
		LCRRamp.x	:= IN_AutoSP;
		LCRRamp.set := NOT HMI.ConfigSlewPresent;
	ELSE
		HMI.PV		:= 0.0;
		LCRRamp.x	:= 0.0;
		LCRRamp.set	:= TRUE;
	END_IF
		
	IF VAR_SlewInit AND LCRRamp.x_reached THEN
		VAR_SlewInit := FALSE;
	END_IF
	
	LCRRamp(
		enable	:= TRUE,
		dy_up	:= MAX(0.01, IN_SPSlew),
		dy_down := MAX(0.01, IN_SPSlew),
		y_min	:= 0.0,
		y_max	:= IN_MaxScale,
		y_set	:= LCRRamp.x 
		);
    
	VAR_SPRamped := LCRRamp.y;
	
	(*****************************************************************)
	(***********************PID CONTROL*******************************)
	(*****************************************************************)
	IF IN_ConfigEngValue THEN
		LCRLimScal_PV(
			x	:= IN_PV,
			x1	:= 0.0,
			y1	:= 0.0,
			x2	:= IN_MaxScale,
			y2	:= 100.0
			);
		VAR_PV	:= LCRLimScal_PV.y;
			
		LCRLimScal_SP(
			x	:= VAR_SPRamped,
			x1	:= 0.0,
			y1	:= 0.0,
			x2	:= IN_MaxScale,
			y2	:= 100.0
			);
		VAR_SP	:= LCRLimScal_SP.y;
	ELSE
		VAR_SP	:= VAR_SPRamped;
		VAR_PV	:= IN_PV;
	END_IF
	
	IF IN_Reverse THEN
		OUT_Error := (VAR_PV - VAR_SP);
	ELSE
		OUT_Error := (VAR_SP - VAR_PV);
	END_IF
	
	(*****************************************************************)
	(********************PROPORTIONAL FACTOR**************************)
	(*****************************************************************)
	IF IN_Gain = 0 THEN
		VAR_GainError := OUT_Error;
	ELSE
		VAR_GainError := OUT_Error * IN_Gain;
	END_IF

	IF (IN_Auto OR HMI.SPLocal) THEN
		VAR_Proportional := VAR_GainError;
	ELSE
		VAR_Proportional := 0.0;
	END_IF

	OUT_P := VAR_Proportional;

	(*****************************************************************)
	(***********************INTEGRAL FACTOR***************************)
	(*****************************************************************)
	VAR_IntegralSaturation := (((OUT_P + OUT_I + OUT_D + IN_Disv) > IN_OutMax) AND OUT_Error > 0) OR (((OUT_P + OUT_I + OUT_D + IN_Disv) < IN_OutMin) AND OUT_Error < 0); 
	VAR_IntegralBlock := IN_IntHold OR NOT (IN_Auto OR HMI.SPLocal) OR VAR_IntegralSaturation;  // integral block if saturated (anti wind up)

	VAR_Integral.IN_IntCycle := VAR_CycleTime;
	 
	IF (IN_Auto OR HMI.SPLocal) AND IN_TI > 0 AND NOT IN_TIInit THEN
		IF EDGEPOS(IN_Auto OR HMI.SPLocal)THEN
			IF OUT > 0 THEN
				VAR_IntegralOut := OUT - OUT_P - IN_Disv;    (* Bumpless - Inizilize the Integral Component when the PID is setted in auto again *)
				VAR_Integral.IN_NewValue := VAR_IntegralOut;
				VAR_Integral(OUT_Integral := VAR_IntegralOut);
			END_IF
		ELSIF NOT VAR_IntegralBlock THEN
			VAR_Integral.IN_NewValue := VAR_GainError / IN_TI;
			//	VAR_IntegralOut := VAR_IntegralOut;
			IF VAR_Integral.IN_IntCycle > 0 THEN
				VAR_Integral(OUT_Integral := VAR_IntegralOut);
			END_IF
		END_IF   		
	ELSE
		IF IN_TIInit THEN
			VAR_IntegralOut := IN_TIInitValue;
		ELSE
			VAR_IntegralOut := 0.0;
		END_IF
	END_IF
	
	OUT_I := LIMIT((IN_OutMax * -1.0), VAR_IntegralOut, IN_OutMax);
	
	(*****************************************************************)
	(**********************DERIVATIVE FACTOR**************************)
	(*****************************************************************)
	IF (IN_Auto OR HMI.SPLocal) AND IN_TD >0 AND VAR_CycleTime > 0 THEN
		VAR_Derivative := ( VAR_GainError - VAR_OldError ) * IN_TD / VAR_CycleTime;
	ELSE
		VAR_Derivative := 0.0;
	END_IF
	VAR_OldError := VAR_GainError;
	
	OUT_D := VAR_Derivative;

	(*****************************************************************)
	(************************OUT CALCOLATION**************************)
	(*****************************************************************)
	IF HMI.Enable AND IN_ConfigPresent THEN
		OUT:= LIMIT(IN_OutMin, OUT_P + OUT_I + OUT_D + IN_Disv, IN_OutMax);
	ELSIF IN_FixOut THEN
		OUT:= LIMIT(IN_OutMin, IN_FixOutValue, IN_OutMax);
	ELSE
		OUT:= 0.0;
	END_IF
	
	(*****************************************************************)
	(*******************************HMI*******************************)
	(*****************************************************************)
	HMI.Enable			:= IN_Auto OR HMI.SPLocal;
	HMI.Mode			:= NOT HMI.SPLocal;
	HMI.SP_SlewRunning	:= LCRRamp.enable AND NOT LCRRamp.x_reached;

	HMI.ConfigPresent		:= IN_ConfigPresent;
	HMI.ConfigSlewPresent	:= IN_Slew;
    
	OUT_ActSP			:= VAR_SPRamped;
	HMI.SP_Actual		:= OUT_ActSP;
	HMI.SP_Target		:= IN_AutoSP;
	HMI.SP_Obtained		:= (IN_PV < (IN_AutoSP + IN_MaxDev)) AND (IN_PV > (IN_AutoSP - IN_MinDev));
	HMI.FF_OUT			:= IN_Disv;
	HMI.OUT				:= OUT;
END_FUNCTION_BLOCK

FUNCTION_BLOCK Integral
	OUT_Integral := OUT_Integral + ( VAR_OldValue + (IN_NewValue -  VAR_OldValue ) * 0.5 ) * IN_IntCycle;
	VAR_OldValue := IN_NewValue;
END_FUNCTION_BLOCK