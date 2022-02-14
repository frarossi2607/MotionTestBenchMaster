ACTION MNM_DisableMotorManagement: 
 // in wait riabilito tutto ipotesi uno
	VAR_MNM_DefaultAxisConfig := DOS.DataOut.AllAxisEnableRequest OR (TNK.DataOut.DummyContainersDis AND TNK.DataOut.CipMode);
	
	IF DOS.DataOut.AxisEnableRequest AND VAR_MNM_AxisDisableStep <> 1 AND NOT DOS.DataOut.RunOnlyHemaAxisRequest THEN
		VAR_MNM_AxisDisableStep := 1;
	ELSIF DOS.DataOut.AxisDisableRequest AND VAR_MNM_AxisDisableStep <> 2 THEN
		VAR_MNM_AxisDisableStep := 2;
	ELSIF DOS.DataOut.RunOnlyHemaAxisRequest AND VAR_MNM_AxisDisableStep <> 3 THEN
		VAR_MNM_AxisDisableStep := 3;
	ELSIF DOS.DataOut.RunRinserHemaAxisRequest AND VAR_MNM_AxisDisableStep <> 4 THEN
		VAR_MNM_AxisDisableStep := 4;
	ELSIF RNS.DataOut.RunOnlyRinserAxisRequest AND VAR_MNM_AxisDisableStep <> 5 THEN
		VAR_MNM_AxisDisableStep := 5;	
	ELSIF VAR_MNM_DefaultAxisConfig AND VAR_MNM_AxisDisableStep <> 0 THEN
		VAR_MNM_AxisDisableStep := 0;
	END_IF
	
	IF VAR_MNM_AxisConfigLoadedNumber <> VAR_MNM_AxisDisableStep OR ALR[3015].Active OR ALR[3016].Active  THEN
		VAR_MNM_NormalStop := TRUE;
	ELSIF VAR_MNM_AxisConfigLoadedNumber = VAR_MNM_AxisDisableStep THEN
		VAR_MNM_NormalStop := FALSE;
	END_IF


	
	CASE VAR_MNM_AxisDisableStep OF
	
		0: // Configuration of Motor must be disabled //Default Motor Configuration all axis are Enabled
			IF NOT MNM.DataOut.MachineRunning THEN
				memcpy( ADR(MC_InputOutput.Network.Filler.Commands.MotorDisableIndex),ADR(CFG_MC.MotorDisableConfig[0]), SIZEOF(CFG_MC.MotorDisableConfig[0]));
			END_IF
			MNM.DataOut.ConfigReqLoaded := (memcmp( ADR( MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack), ADR(CFG_MC.MotorDisableConfig[0]) ,SIZEOF(CFG_MC.MotorDisableConfig[0])) = 0);
			
			IF 	MNM.DataOut.ConfigReqLoaded THEN
				MNM.DataOut.ConfigReqLoaded	:= FALSE;
				VAR_MNM_AxisConfigLoadedNumber	:= 0;
			END_IF	
				
		1:// configuration 1 request to MC , wait answer from MC program //DOSER ENABLE
			IF NOT MNM.DataOut.MachineRunning THEN
				memcpy( ADR(MC_InputOutput.Network.Filler.Commands.MotorDisableIndex),ADR(CFG_MC.MotorDisableConfig[1]), SIZEOF(CFG_MC.MotorDisableConfig[1]));
			END_IF
			MNM.DataOut.ConfigReqLoaded := (memcmp( ADR( MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack), ADR(CFG_MC.MotorDisableConfig[1]) ,SIZEOF(CFG_MC.MotorDisableConfig[1])) = 0);
			
			IF 	MNM.DataOut.ConfigReqLoaded AND NOT DOS.DataOut.AxisEnableRequest THEN
				MNM.DataOut.ConfigReqLoaded	:= FALSE;
				VAR_MNM_AxisConfigLoadedNumber	:= 1;
			END_IF	
		2:// configuration 1 request to MC , wait answer from MC program DOSER DISABLE
			IF NOT MNM.DataOut.MachineRunning THEN
				memcpy( ADR(MC_InputOutput.Network.Filler.Commands.MotorDisableIndex),ADR(CFG_MC.MotorDisableConfig[2]), SIZEOF(CFG_MC.MotorDisableConfig[2]));
			 END_IF
			MNM.DataOut.ConfigReqLoaded := (memcmp( ADR( MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack), ADR(CFG_MC.MotorDisableConfig[2]) ,SIZEOF(CFG_MC.MotorDisableConfig[2])) = 0);
			
			IF 	MNM.DataOut.ConfigReqLoaded AND NOT DOS.DataOut.AxisDisableRequest THEN
				MNM.DataOut.ConfigReqLoaded	:= FALSE;
				VAR_MNM_AxisConfigLoadedNumber	:= 2;
			END_IF
		
		3:// configuration 1 request to MC , wait answer from MC program DOSER ONLY
			IF NOT MNM.DataOut.MachineRunning THEN
				memcpy( ADR(MC_InputOutput.Network.Filler.Commands.MotorDisableIndex),ADR(CFG_MC.MotorDisableConfig[3]), SIZEOF(CFG_MC.MotorDisableConfig[3]));
			END_IF
			MNM.DataOut.ConfigReqLoaded := (memcmp( ADR( MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack), ADR(CFG_MC.MotorDisableConfig[3]) ,SIZEOF(CFG_MC.MotorDisableConfig[3])) = 0);
			
			IF MNM.DataOut.ConfigReqLoaded THEN
				VAR_MNM_AxisConfigLoadedNumber	:= 3;
			END_IF
			
			IF 	MNM.DataOut.ConfigReqLoaded AND NOT DOS.DataOut.RunOnlyHemaAxisRequest THEN
				MNM.DataOut.ConfigReqLoaded	:= FALSE;
				VAR_MNM_AxisConfigLoadedNumber	:= 3;
			END_IF
			
		4:// configuration 1 request to MC , wait answer from MC program DOSER + RINSER ONLY
			IF NOT MNM.DataOut.MachineRunning THEN
				memcpy( ADR(MC_InputOutput.Network.Filler.Commands.MotorDisableIndex),ADR(CFG_MC.MotorDisableConfig[4]), SIZEOF(CFG_MC.MotorDisableConfig[4]));
			END_IF
			MNM.DataOut.ConfigReqLoaded := (memcmp( ADR( MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack), ADR(CFG_MC.MotorDisableConfig[4]) ,SIZEOF(CFG_MC.MotorDisableConfig[4])) = 0);
			
			IF MNM.DataOut.ConfigReqLoaded THEN
				VAR_MNM_AxisConfigLoadedNumber	:= 4;
			END_IF
			
			IF 	MNM.DataOut.ConfigReqLoaded AND NOT DOS.DataOut.RunRinserHemaAxisRequest THEN
				MNM.DataOut.ConfigReqLoaded	:= FALSE;
				VAR_MNM_AxisConfigLoadedNumber	:= 4;
			END_IF
		5:// configuration 1 request to MC , wait answer from MC program RINSER ONLY
			IF NOT MNM.DataOut.MachineRunning THEN
				memcpy( ADR(MC_InputOutput.Network.Filler.Commands.MotorDisableIndex),ADR(CFG_MC.MotorDisableConfig[5]), SIZEOF(CFG_MC.MotorDisableConfig[5]));
			END_IF
			MNM.DataOut.ConfigReqLoaded := (memcmp( ADR( MC_InputOutput.Network.Filler.Status.AxisDisabledFeedBack), ADR(CFG_MC.MotorDisableConfig[5]) ,SIZEOF(CFG_MC.MotorDisableConfig[5])) = 0);
			
			IF 	MNM.DataOut.ConfigReqLoaded AND NOT RNS.DataOut.RunOnlyRinserAxisRequest THEN
				MNM.DataOut.ConfigReqLoaded	:= FALSE;
				VAR_MNM_AxisConfigLoadedNumber	:= 5;
			END_IF
	END_CASE	
END_ACTION
