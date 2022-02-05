PROGRAM _INIT
	stMasterModule ACCESS ADR(VAR_Machine.stMasterModule);
	stMasterModule.iq_stStatus.q_xAlarmXCoreEnabled	:= FALSE;

	IF VAR_AxPowerSupply01.nc_obj_inf.node_nr > 0 THEN
		xPowerSupply01	:= TRUE;
	END_IF

	IF VAR_AxPowerSupply02.nc_obj_inf.node_nr > 0 THEN
		xPowerSupply02	:= TRUE;
	END_IF
END_PROGRAM