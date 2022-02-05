FUNCTION_BLOCK Fan_Obj
	IF NOT(IN_RoofType) THEN
		IF IN_ConfigPresent THEN
			VAR_ResetHMI := FALSE;
			
			VAR_AbsoluteFilter		:= FALSE;
			VAR_PreFilter			:= FALSE;
			VAR_PressurizedOnAlarm	:= FALSE;
	
			FOR VAR_i := 1 TO IN_FanNumber DO
				HMI.HMI_Pressurizer[VAR_i].ConfigPresent	:= TRUE;
				HMI.HMI_Pressurizer[VAR_i].ManEnable		:= TRUE;
				HMI.HMI_Pressurizer[VAR_i].MaskEnable		:= TRUE;
				
				VAR_Auto[VAR_i]	:= NOT HMI.HMI_Pressurizer[VAR_i].ManOff AND NOT HMI.HMI_Pressurizer[VAR_i].ManOn;
				
				IF NOT IN_Enable THEN
					VAR_OUT := 0;
				ELSIF VAR_Auto[VAR_i] THEN
					VAR_OUT := IN_AutoSpeed;
				ELSIF HMI.HMI_Pressurizer[VAR_i].ManOn THEN
					VAR_OUT := HMI.HMI_Pressurizer[VAR_i].OUT_Man;
				ELSE
					VAR_OUT := 0;
				END_IF
				
				IF IN_HMIAutoForce THEN
					HMI.HMI_Pressurizer[VAR_i].ManOff	:= FALSE;
					HMI.HMI_Pressurizer[VAR_i].ManOn	:= FALSE;
				END_IF
				
				VAR_OUT := LIMIT(0, VAR_OUT, 100);
				
				IO.Pressurizer[VAR_i].AO_Raw	:= REAL_TO_INT(VAR_OUT * 32767 /100);
				// LAMP
				
				IF IN_CgfHmiLampOn THEN
					HMI.HMI_Pressurizer[VAR_i].SS2P_Lamp.Enable := VAR_i = 1;//V4.A.A.1.7.0 to enable the first zone 
					HMI.HMI_Pressurizer[VAR_i].SS2P_Lamp.Visibility := TRUE;
					HMI.HMI_Pressurizer[VAR_i].SS2P_Lamp.LampON := HMI.HMI_Pressurizer[1].SS2P_Lamp.ON;//V4.A.A.1.7.0 fan 1 is managing all the lamp on
					IO.Pressurizer[VAR_i].DO_Lighting := HMI.HMI_Pressurizer[VAR_i].SS2P_Lamp.LampON;
				ELSE
					HMI.HMI_Pressurizer[VAR_i].SS2P_Lamp.Enable := FALSE;
					HMI.HMI_Pressurizer[VAR_i].SS2P_Lamp.Visibility := FALSE;
					HMI.HMI_Pressurizer[VAR_i].SS2P_Lamp.ON	:= FALSE;
					IO.Pressurizer[VAR_i].DO_Lighting := FALSE;
				END_IF	
				
				IF IN_Reset THEN
					ALARM.Pressurizer[VAR_i].AbsoluteFilterAlarm	:= FALSE;
					ALARM.Pressurizer[VAR_i].PrefilterAlarm			:= FALSE;
					ALARM.Pressurizer[VAR_i].PressurizedOnAlarm		:= FALSE;
					OUT_OverloadFault						:= FALSE;
				END_IF
				
				IF NOT IO.Pressurizer[VAR_i].DI_AbsoluteFilterAlarm AND NOT HMI.HMI_Pressurizer[VAR_i].Mask AND IN_Enable THEN
					ALARM.Pressurizer[VAR_i].AbsoluteFilterAlarm	:= TRUE;
				END_IF
				VAR_AbsoluteFilter	:= ALARM.Pressurizer[VAR_i].AbsoluteFilterAlarm OR VAR_AbsoluteFilter;
				
				IF NOT IO.Pressurizer[VAR_i].DI_PrefilterAlarm AND NOT HMI.HMI_Pressurizer[VAR_i].Mask AND IN_Enable THEN
					ALARM.Pressurizer[VAR_i].PrefilterAlarm	:= TRUE;
				END_IF
				VAR_PreFilter	:= ALARM.Pressurizer[VAR_i].PrefilterAlarm OR VAR_PreFilter;
				
				TMR_TON_OnDelay[VAR_i](	IN := VAR_OUT > 0,
										PT := T#10s);   
				TMR_TON_OffDelay[VAR_i](IN := VAR_OUT = 0,
										PT := T#25s);
								
				IF ((TMR_TON_OnDelay[VAR_i].Q AND NOT IO.Pressurizer[VAR_i].DI_PressurizerON) OR
					(TMR_TON_OffDelay[VAR_i].Q AND IO.Pressurizer[VAR_i].DI_PressurizerON)) AND NOT HMI.HMI_Pressurizer[VAR_i].Mask AND IN_Enable THEN
					ALARM.Pressurizer[VAR_i].PressurizedOnAlarm := TRUE;
				END_IF
				VAR_PressurizedOnAlarm	:= ALARM.Pressurizer[VAR_i].PressurizedOnAlarm OR VAR_PressurizedOnAlarm;			
				
				ALARM.PressurizerZone.AbsoluteFilterAlarm	:= VAR_AbsoluteFilter;
				ALARM.PressurizerZone.PrefilterAlarm		:= VAR_PreFilter;
				ALARM.PressurizerZone.PressurizedOnAlarm	:= VAR_PressurizedOnAlarm;
				
				HMI.HMI_Pressurizer[VAR_i].Alarm		:= OUT_OverloadFault OR ALARM.Pressurizer[VAR_i].PressurizedOnAlarm;
				HMI.HMI_Pressurizer[VAR_i].AlarmFilter	:= ALARM.Pressurizer[VAR_i].AbsoluteFilterAlarm OR ALARM.Pressurizer[VAR_i].PrefilterAlarm;
				HMI.HMI_Pressurizer[VAR_i].Out			:= (VAR_OUT > 0.0);
				HMI.HMI_Pressurizer[VAR_i].OUT_CV		:= VAR_OUT;
			END_FOR
			
			IF NOT IO.DI_OverloadOK THEN
				OUT_OverloadFault := TRUE;
			END_IF
			Out_Light	:= HMI.HMI_Pressurizer[1].SS2P_Lamp.LampON;// v4.A.A.1.7.0 
			OUT_Alarm	:= OUT_OverloadFault OR VAR_AbsoluteFilter OR VAR_PreFilter OR VAR_PressurizedOnAlarm;
		ELSE
			IF NOT VAR_ResetHMI THEN
				FOR VAR_i := 1 TO 6 DO
					HMI.HMI_Pressurizer[VAR_i].Alarm			:= FALSE;
					HMI.HMI_Pressurizer[VAR_i].AlarmFilter		:= FALSE;
					HMI.HMI_Pressurizer[VAR_i].ConfigPresent	:= FALSE;
					HMI.HMI_Pressurizer[VAR_i].ManEnable		:= FALSE;
					HMI.HMI_Pressurizer[VAR_i].ManState			:= FALSE;
					HMI.HMI_Pressurizer[VAR_i].MaskEnable		:= FALSE;
					HMI.HMI_Pressurizer[VAR_i].Out				:= FALSE;
					HMI.HMI_Pressurizer[VAR_i].OUT_CV			:= 0.0;
				END_FOR
				VAR_ResetHMI := TRUE;
			END_IF
		Out_Light	:= FALSE;;// v4.A.A.1.7.0 
		END_IF
	ELSE
		//Galvani ROOF
		IF IN_ConfigPresent THEN
			VAR_ResetHMI := FALSE;
	
			HMI.HMI_Galvani.ConfigPresent:= TRUE;
			HMI.HMI_Galvani.ManEnable		:= TRUE;
			HMI.HMI_Galvani.MaskEnable		:= TRUE;
				
			VAR_Auto_Gal	:= NOT HMI.HMI_Galvani.ManOff AND NOT HMI.HMI_Galvani.ManOn;
			
			IF NOT IN_Enable THEN
				VAR_GalvaniOn := FALSE;
			ELSIF VAR_Auto_Gal THEN
				VAR_GalvaniOn := TRUE;
				VAR_GalvaniFlowSet := IN_GalvaniRoofFlowSet;
			ELSIF HMI.HMI_Galvani.ManOn THEN
				VAR_GalvaniOn := TRUE;
				VAR_GalvaniFlowSet := HMI.HMI_Galvani.ManFlowSet;
			ELSE
				VAR_GalvaniOn := FALSE;
			END_IF
				
			IF IN_HMIAutoForce THEN
				HMI.HMI_Galvani.ManOff	:= FALSE;
				HMI.HMI_Galvani.ManOn	:= FALSE;
			END_IF

			// LAMP
			IF IN_CgfHmiLampOn THEN
				HMI.HMI_Galvani.SS2P_Lamp1.Enable := TRUE;
				HMI.HMI_Galvani.SS2P_Lamp1.Visibility := TRUE;
				HMI.HMI_Galvani.SS2P_Lamp1.LampON := HMI.HMI_Galvani.SS2P_Lamp1.ON;
				IO.GalvaniRoof.DO_LightingArea_1 := HMI.HMI_Galvani.SS2P_Lamp1.LampON;
				
				HMI.HMI_Galvani.SS2P_Lamp2.Enable := TRUE;
				HMI.HMI_Galvani.SS2P_Lamp2.Visibility := TRUE;
				HMI.HMI_Galvani.SS2P_Lamp2.LampON := HMI.HMI_Galvani.SS2P_Lamp2.ON;
				IO.GalvaniRoof.DO_LightingArea_2 := HMI.HMI_Galvani.SS2P_Lamp2.LampON;
			ELSE
				HMI.HMI_Galvani.SS2P_Lamp1.Enable := FALSE;
				HMI.HMI_Galvani.SS2P_Lamp1.Visibility := FALSE;
				HMI.HMI_Galvani.SS2P_Lamp1.ON	:= FALSE;
				IO.GalvaniRoof.DO_LightingArea_1 := FALSE;
				
				HMI.HMI_Galvani.SS2P_Lamp2.Enable := FALSE;
				HMI.HMI_Galvani.SS2P_Lamp2.Visibility := FALSE;
				HMI.HMI_Galvani.SS2P_Lamp2.ON	:= FALSE;
				IO.GalvaniRoof.DO_LightingArea_2 := FALSE;
			END_IF		
				
			IF IN_Reset THEN
				ALARM.Galvani.AbsoluteFilterAlarm		:= FALSE;
				ALARM.Galvani.PrefilterExtAlarm			:= FALSE;
				ALARM.Galvani.PrefilterIntAlarm			:= FALSE;
				ALARM.Galvani.RunningAlarm				:= FALSE;
				ALARM.Galvani.CabinetAlarm	            := FALSE;
				OUT_OverloadFault						:= FALSE;
			END_IF
				
			IF NOT IO.GalvaniRoof.DI_AbsoluteFilterAlarm AND NOT HMI.HMI_Galvani.Mask AND IN_Enable THEN
				ALARM.Galvani.AbsoluteFilterAlarm	:= TRUE;
			END_IF
			
			IF NOT IO.GalvaniRoof.DI_PrefilterExtAlarm AND NOT HMI.HMI_Galvani.Mask AND IN_Enable THEN
				ALARM.Galvani.PrefilterExtAlarm	:= TRUE;
			END_IF
				
			IF NOT IO.GalvaniRoof.DI_PrefilterIntAlarm AND NOT HMI.HMI_Galvani.Mask AND IN_Enable THEN
				ALARM.Galvani.PrefilterIntAlarm	:= TRUE;
			END_IF
			
			IF NOT IO.GalvaniRoof.DI_CabinetPoweredOn AND NOT HMI.HMI_Galvani.Mask AND IN_Enable THEN
				ALARM.Galvani.CabinetAlarm	:= TRUE;
			END_IF
			
			TMR_TON_OnDelay_Gal(IN := VAR_GalvaniOn,
								PT := T#10s);   
			
			TMR_TON_OffDelay_Gal(IN := NOT(VAR_GalvaniOn),
								PT := T#25s);
								
			IF ((TMR_TON_OnDelay_Gal.Q AND NOT IO.GalvaniRoof.DI_Running) OR
				(TMR_TON_OffDelay_Gal.Q AND IO.GalvaniRoof.DI_Running)) AND NOT HMI.HMI_Galvani.Mask AND IN_Enable THEN
				ALARM.Galvani.RunningAlarm := TRUE;
			END_IF			
			
			IF NOT IO.DI_OverloadOK THEN
				OUT_OverloadFault := TRUE;
			END_IF
			
			IF NOT(VAR_Auto_Gal) THEN
				ALARM.Galvani.SysManSwitchedOff := NOT(VAR_GalvaniOn);
			END_IF
			
			IF VAR_Auto_Gal THEN
				ALARM.Galvani.SysSwitchedOff := NOT(VAR_GalvaniOn);
			END_IF
			
			HMI.HMI_Galvani.Alarm				:= ALARM.Galvani.RunningAlarm OR ALARM.Galvani.CabinetAlarm;
			HMI.HMI_Galvani.AlarmAbsoluteFilter	:= ALARM.Galvani.AbsoluteFilterAlarm;
			HMI.HMI_Galvani.AlarmPrefilterInt	:= ALARM.Galvani.PrefilterIntAlarm;
			HMI.HMI_Galvani.AlarmPrefilterExt	:= ALARM.Galvani.PrefilterExtAlarm;
			HMI.HMI_Galvani.Overload			:= OUT_OverloadFault;
			HMI.HMI_Galvani.Out					:= VAR_GalvaniOn;
			HMI.HMI_Galvani.FlowSet				:= VAR_GalvaniFlowSet;
			
			IO.GalvaniRoof.DO_Start := VAR_GalvaniOn;
			IO.GalvaniRoof.DO_FlowSet := VAR_GalvaniFlowSet;

			OUT_Alarm := 	ALARM.Galvani.RunningAlarm OR 
							ALARM.Galvani.AbsoluteFilterAlarm OR 
							ALARM.Galvani.PrefilterExtAlarm OR 
							ALARM.Galvani.PrefilterIntAlarm OR
							OUT_OverloadFault OR
							ALARM.Galvani.CabinetAlarm;
		ELSE
			IF NOT VAR_ResetHMI THEN
				HMI.HMI_Galvani.Alarm					:= FALSE;
				HMI.HMI_Galvani.AlarmAbsoluteFilter		:= FALSE;
				HMI.HMI_Galvani.AlarmPrefilterExt		:= FALSE;
				HMI.HMI_Galvani.AlarmPrefilterInt		:= FALSE;
				HMI.HMI_Galvani.Overload				:= FALSE;
				HMI.HMI_Galvani.ConfigPresent			:= FALSE;
				HMI.HMI_Galvani.ManEnable				:= FALSE;
				HMI.HMI_Galvani.ManState				:= FALSE;
				HMI.HMI_Galvani.MaskEnable				:= FALSE;
				HMI.HMI_Galvani.Out						:= FALSE;
				VAR_ResetHMI := TRUE;
			END_IF
		END_IF
	END_IF	
END_FUNCTION_BLOCK
