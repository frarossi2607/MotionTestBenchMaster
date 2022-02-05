ACTION MNM_MachineSpeedManagemant: 
	VAR_ModuleSpeed.Machine	:= 0.0;
	VAR_ModuleSpeed.Inlet	:= 0.0;
	VAR_ModuleSpeed.Filler	:= 0.0;
	VAR_ModuleSpeed.Outlet	:= 0.0;
	
	VAR_FixSpeedActive		:= 0;
	VAR_InFixSpeedActive	:= 0;
	VAR_FlrFixSpeedActive	:= 0;
	VAR_OutFixSpeedActive	:= 0;
	
	IF NOT MC_InputOutput.Network.Machine.Status.MultiModalityActive THEN
		FOR iSpeed := 1 TO CST_FixSpeedMax DO
			IF VAR_FixSpeed[iSpeed].Req AND VAR_FixSpeedActive = 0 THEN
				VAR_ModuleSpeed.Machine		:= VAR_FixSpeed[iSpeed].Value;
				VAR_FixSpeedActive			:= iSpeed;
			END_IF
			
			IF VAR_FixSpeedActive <> 0 AND VAR_FixSpeed[iSpeed].Req THEN
				IF VAR_FixSpeed[VAR_FixSpeedActive].Interruptible THEN
					VAR_ModuleSpeed.Machine		:= VAR_FixSpeed[iSpeed].Value;
					VAR_FixSpeedActive			:= iSpeed;	
				END_IF
			END_IF
			
			TON_ReachedDelay[iSpeed](
			IN := FC_SpeedCheck(IN_SpeedReq := VAR_FixSpeed[iSpeed].Value, IN_SpeedAct := MC_InputOutput.Network.Machine.Status.ActualSpeed, IN_Mode := VAR_FixSpeed[iSpeed].CmpMode),
			PT := t#2s
			);
			VAR_FixSpeed[iSpeed].Reached := TON_ReachedDelay[iSpeed].Q AND VAR_FixSpeed[iSpeed].Req;
		END_FOR
	ELSE
		FOR iSpeed := 1 TO CST_FixSpeedMax DO
			IF VAR_FixSpeed[iSpeed].Req AND VAR_FixSpeedActive = 0 THEN//1.7.2
				IF VAR_FixSpeed[iSpeed].Module = 1 THEN
					VAR_ModuleSpeed.Inlet	:= VAR_FixSpeed[iSpeed].Value;
					VAR_InFixSpeedActive	:= iSpeed;
				ELSIF VAR_FixSpeed[iSpeed].Module = 2 THEN
					VAR_ModuleSpeed.Filler	:= VAR_FixSpeed[iSpeed].Value;
					VAR_FlrFixSpeedActive	:= iSpeed;
				ELSIF VAR_FixSpeed[iSpeed].Module = 3 THEN
					VAR_ModuleSpeed.Outlet	:= VAR_FixSpeed[iSpeed].Value;
					VAR_OutFixSpeedActive	:= iSpeed;
				ELSIF VAR_FixSpeed[iSpeed].Module = 9 THEN
					VAR_ModuleSpeed.Inlet	:= VAR_FixSpeed[iSpeed].Value;
					VAR_ModuleSpeed.Filler	:= VAR_FixSpeed[iSpeed].Value;
					VAR_ModuleSpeed.Outlet	:= VAR_FixSpeed[iSpeed].Value;
					VAR_InFixSpeedActive	:= iSpeed;
					VAR_FlrFixSpeedActive	:= iSpeed;
					VAR_OutFixSpeedActive	:= iSpeed;
				END_IF
			END_IF

			IF VAR_InFixSpeedActive <> 0 AND VAR_FixSpeed[iSpeed].Req AND VAR_FixSpeed[iSpeed].Module = 1 THEN
				IF VAR_FixSpeed[VAR_InFixSpeedActive].Interruptible THEN
					VAR_ModuleSpeed.Inlet	:= VAR_FixSpeed[iSpeed].Value;
					VAR_InFixSpeedActive	:= iSpeed;
				END_IF
			END_IF
			
			IF VAR_FlrFixSpeedActive <> 0 AND VAR_FixSpeed[iSpeed].Req AND VAR_FixSpeed[iSpeed].Module = 2 THEN
				IF VAR_FixSpeed[VAR_FlrFixSpeedActive].Interruptible THEN
					VAR_ModuleSpeed.Filler	:= VAR_FixSpeed[iSpeed].Value;
					VAR_FlrFixSpeedActive	:= iSpeed;
				END_IF
			END_IF
			
			IF VAR_OutFixSpeedActive <> 0 AND VAR_FixSpeed[iSpeed].Req AND VAR_FixSpeed[iSpeed].Module = 3 THEN
				IF VAR_FixSpeed[VAR_OutFixSpeedActive].Interruptible THEN
					VAR_ModuleSpeed.Outlet	:= VAR_FixSpeed[iSpeed].Value;
					VAR_OutFixSpeedActive	:= iSpeed;
				END_IF
			END_IF
			
			IF VAR_FixSpeed[iSpeed].Module = 1 THEN
				TON_ReachedDelay[iSpeed](
				IN := FC_SpeedCheck(IN_SpeedReq := VAR_FixSpeed[iSpeed].Value, IN_SpeedAct := MC_InputOutput.Network.Inlet.Status.Velocity, IN_Mode := VAR_FixSpeed[iSpeed].CmpMode),
				PT := t#2s
				);
			END_IF
			
			IF VAR_FixSpeed[iSpeed].Module = 2 THEN
				TON_ReachedDelay[iSpeed](
				IN := FC_SpeedCheck(IN_SpeedReq := VAR_FixSpeed[iSpeed].Value, IN_SpeedAct := MC_InputOutput.Network.Filler.Status.Velocity, IN_Mode := VAR_FixSpeed[iSpeed].CmpMode),
				PT := t#2s
				);
			END_IF
			
			IF VAR_FixSpeed[iSpeed].Module = 3 THEN
				TON_ReachedDelay[iSpeed](
				IN := FC_SpeedCheck(IN_SpeedReq := VAR_FixSpeed[iSpeed].Value, IN_SpeedAct := MC_InputOutput.Network.Outlet.Status.Velocity, IN_Mode := VAR_FixSpeed[iSpeed].CmpMode),
				PT := t#2s
				);
			END_IF
			
			IF VAR_FixSpeed[iSpeed].Module = 9 THEN
				IF MC_InputOutput.Network.Inlet.Status.ModuleReal THEN
					TON_ReachedDelay[iSpeed].IN	:= FC_SpeedCheck(	IN_SpeedReq := VAR_FixSpeed[iSpeed].Value,
					IN_SpeedAct := MC_InputOutput.Network.Inlet.Status.Velocity,
					IN_Mode := VAR_FixSpeed[iSpeed].CmpMode);
				ELSE
					TON_ReachedDelay[iSpeed].IN := TRUE;
				END_IF
				
				IF MC_InputOutput.Network.Filler.Status.ModuleReal THEN
					TON_ReachedDelay[iSpeed].IN	:= FC_SpeedCheck(	IN_SpeedReq := VAR_FixSpeed[iSpeed].Value,
					IN_SpeedAct := MC_InputOutput.Network.Filler.Status.Velocity,
					IN_Mode := VAR_FixSpeed[iSpeed].CmpMode) AND TON_ReachedDelay[iSpeed].IN;
				ELSE
					TON_ReachedDelay[iSpeed].IN := TON_ReachedDelay[iSpeed].IN;
				END_IF
				
				IF MC_InputOutput.Network.Outlet.Status.ModuleReal THEN
					TON_ReachedDelay[iSpeed].IN	:= FC_SpeedCheck(	IN_SpeedReq := VAR_FixSpeed[iSpeed].Value,
					IN_SpeedAct := MC_InputOutput.Network.Outlet.Status.Velocity,
					IN_Mode := VAR_FixSpeed[iSpeed].CmpMode) AND TON_ReachedDelay[iSpeed].IN;
				ELSE
					TON_ReachedDelay[iSpeed].IN := TON_ReachedDelay[iSpeed].IN;
				END_IF
				
				TON_ReachedDelay[iSpeed](
				PT := t#2s
				);
			END_IF
			VAR_FixSpeed[iSpeed].Reached := TON_ReachedDelay[iSpeed].Q AND VAR_FixSpeed[iSpeed].Req;
		END_FOR
	END_IF
	
	IF VAR_FixSpeedActive = 0 THEN
		VAR_ModuleSpeed.Machine	:= DINT_TO_REAL(HMI_MNM_FlrSpeedWidget.AutoSpeedReq);
	END_IF
	
	IF VAR_InFixSpeedActive = 0 THEN
		VAR_ModuleSpeed.Inlet;
	END_IF
		
	IF VAR_FlrFixSpeedActive = 0 THEN
		VAR_ModuleSpeed.Filler	:= DINT_TO_REAL(HMI_MNM_FlrSpeedWidget.AutoSpeedReq);
	END_IF	
		
	IF VAR_OutFixSpeedActive = 0 THEN
		VAR_ModuleSpeed.Outlet	:= DINT_TO_REAL(HMI_MNM_SmrSpeedWidget.AutoSpeedReq);
	END_IF
	
	IF VAR_FixSpeedActive <> 0 OR VAR_InFixSpeedActive <> 0 OR VAR_FlrFixSpeedActive <> 0 OR VAR_OutFixSpeedActive <> 0 THEN
		VAR_MNM_FixSpeedReq := TRUE;
	ELSE
		VAR_MNM_FixSpeedReq := FALSE;
	END_IF	
		
END_ACTION
