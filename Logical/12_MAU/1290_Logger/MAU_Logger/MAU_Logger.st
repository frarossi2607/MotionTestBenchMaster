PROGRAM _CYCLIC
	(* Software object logging *)
	swChg_0.refreshTime 		:= T#1m;
	swChg_0.logLevel			:= arEVENTLOG_SEVERITY_INFO;
	swChg_0.enable				:= TRUE;
	swChg_0();
END_PROGRAM