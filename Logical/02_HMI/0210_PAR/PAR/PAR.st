PROGRAM _INIT
//Call all the option parameters
	HMI_PAO_2;
	
	//Call all the parameters structure for HMI (RCP excluded)
	HMI_PAC_1;
	HMI_PAM_1;
	HMI_PAM_3;
	HMI_PAM_A1;
	HMI_PAM_B1;
	HMI_PAM_C1;
	HMI_PAM_D1;
	HMI_PAT_1;
	
	//Call all the parameters configuration structure for HMI (RCP excluded)
	HMI_CFG_PAC_1;
	HMI_CFG_PAM_1;
	HMI_CFG_PAM_3;
	HMI_CFG_PAM_A1;
	HMI_CFG_PAM_B1;
	HMI_CFG_PAM_C1;
	HMI_CFG_PAM_D1;
	HMI_CFG_PAT_1;
END_PROGRAM

PROGRAM _CYCLIC
	HMI_PB[PB_PAR_Initialization].Visibility	:= TRUE;
	HMI_PB[PB_PAR_Initialization].Enable		:= TRUE;
	
	IF VAR_PAR_Initialization THEN
		HMI_PAC_1_Init;
		HMI_PAM_1_Init;
		HMI_PAM_3_Init;
		HMI_PAM_A1_Init;
		HMI_PAM_B1_Init;
		HMI_PAM_C1_Init;
		HMI_PAM_D1_Init;
		HMI_PAT_1_Init;
		VAR_PAR_Initialization	:= FALSE;
	END_IF
	
	TMR_TON_ParInitialization(IN	:= HMI_PB[PB_PAR_Initialization].ON,
								PT := t#5s);
	
	IF CFG_Par.Process.BlendFill THEN
		FlrCrb.HMI_ParInitialization	:= HMI_PB[PB_PAR_Initialization].ON;
	ELSIF CFG_Par.Process.InternalSkid THEN
		FlrSkd.HMI_ParInitialization	:= HMI_PB[PB_PAR_Initialization].ON;
	END_IF

	IF TMR_TON_ParInitialization.Q THEN
		VAR_PAR_Initialization			:= TRUE;
	END_IF
	
	HMI_PB[PB_PAR_Initialization].Blink		:= HMI_PB[PB_PAR_Initialization].ON AND NOT TMR_TON_ParInitialization.Q;
	HMI_PB[PB_PAR_Initialization].LampON	:= VAR_PAR_Initialization OR TMR_TON_ParInitialization.Q;
END_PROGRAM