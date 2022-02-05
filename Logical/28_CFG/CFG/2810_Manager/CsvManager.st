ACTION CsvManager:
	VAR_FmCmd.FolderCreate		:= FALSE;
	VAR_FmCmd.Load				:= FALSE;
	VAR_FmCmd.Save				:= FALSE;
	VAR_FileName				:= '';
	
	CFG.DataOut.CapSaved		:= FALSE;
	CFG.DataOut.Busy			:= VAR_CsvMngState <> 800;
	
	CASE VAR_CsvMngState OF
		0:		//Create Folder
			VAR_FmCmd.FolderCreate := NOT VAR_FmAck.CommandError;
		
			IF VAR_FmAck.CommandDone THEN
				VAR_CsvMngState := 99;
			END_IF
		
		99:		//Wait idle
			IF StFmState = 0 AND NOT VAR_FmAck.CommandDone THEN
				VAR_CsvMngState	:= 100;
			END_IF
		
		100:	//Load machine configuration
			VAR_FmCmd.Load	:= TRUE;
			VAR_FileName	:= 'CFG_PAO.csv';
		
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryConfig);
		
			IF VAR_FmAck.CommandError THEN
				VAR_CsvMngState			:= 110;
			ELSIF VAR_FmAck.CommandDone AND FB_MpRecipeCsv.Info.LastLoadedRecipe = VAR_FileName THEN
				VAR_CfgPaoName			:= VAR_Header.Name;
				CFG.DataOut.CfgDefault	:= (VAR_Header.Name = 'Default Value');
				VAR_CsvMngState			:= 199;
			END_IF
		
		110:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 THEN
				VAR_CsvMngState	:= 115;
			END_IF
		
		115:	//Save default machine configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'CFG_PAO.csv';
			FB_MpRecipeCsv.Header	:= ADR(CST_DefaultHeader);
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryConfig);
		
			IF VAR_FmAck.CommandError THEN
				CFG.DataOut.ErrorSavingCfg	:= TRUE;
				VAR_CsvMngState				:= 116;
			ELSIF VAR_FmAck.CommandDone THEN
				CFG.DataOut.CfgDefault		:= TRUE;
				VAR_CsvMngState				:= 199;
			END_IF
		
		116:	//Wait error reset
			IF NOT VAR_FmAck.CommandError THEN
				VAR_CsvMngState	:= 199;
			END_IF
		
		199:	//Wait idle
			IF StFmState = 0 AND NOT VAR_FmAck.CommandDone THEN
				IF (AID.DataOut.ProjectType = CST_AID_ProjectMachine) THEN
					VAR_CsvMngState	:= 200;
				ELSE
					VAR_CsvMngState	:= 300;
				END_IF
			END_IF
		
		200:	//Load Hmi configuration
			VAR_FmCmd.Load	:= TRUE;
			VAR_FileName	:= 'HMI_PAO.csv';
		
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryHmi);
		
			IF VAR_FmAck.CommandError THEN
				VAR_CsvMngState			:= 210;
			ELSIF VAR_FmAck.CommandDone AND FB_MpRecipeCsv.Info.LastLoadedRecipe = VAR_FileName THEN
				VAR_HmiPaoName			:= VAR_Header.Name;
				CFG.DataOut.PaoDefault	:= (VAR_Header.Name = 'Default Value');
				VAR_CsvMngState			:= 299;
			END_IF
		
		210:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 THEN
				VAR_CsvMngState	:= 215;
			END_IF
		
		215:	//Save default Hmi configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'HMI_PAO.csv';
			FB_MpRecipeCsv.Header	:= ADR(CST_DefaultHeader);
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryHmi);
		
			IF VAR_FmAck.CommandError THEN
				CFG.DataOut.ErrorSavingPao	:= TRUE;
				VAR_CsvMngState				:= 216;
			ELSIF VAR_FmAck.CommandDone THEN
				CFG.DataOut.PaoDefault		:= TRUE;
				VAR_CsvMngState				:= 299;
			END_IF
		
		216:	//Wait error reset
			IF NOT VAR_FmAck.CommandError THEN
				VAR_CsvMngState	:= 299;
			END_IF
		
		299:	//Wait idle
			IF StFmState = 0 AND NOT VAR_FmAck.CommandDone THEN
				VAR_CsvMngState	:= 300;
			END_IF
		
		300:	//Load Itc configuration
			VAR_FmCmd.Load	:= TRUE;
			VAR_FileName	:= 'CFG_ITC.csv';
		
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryItc);
		
			IF VAR_FmAck.CommandError THEN
				VAR_CsvMngState			:= 310;
			ELSIF VAR_FmAck.CommandDone AND FB_MpRecipeCsv.Info.LastLoadedRecipe = VAR_FileName THEN
				VAR_CfgItcName			:= VAR_Header.Name;
				CFG.DataOut.ItcDefault	:= (VAR_Header.Name = 'Default Value');
				VAR_CsvMngState			:= 399;
			END_IF
		
		310:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 THEN
				VAR_CsvMngState	:= 315;
			END_IF
		
		315:	//Save default Itc configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'CFG_ITC.csv';
			FB_MpRecipeCsv.Header	:= ADR(CST_DefaultHeader);
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryItc);
		
			IF VAR_FmAck.CommandError THEN
				CFG.DataOut.ErrorSavingItc	:= TRUE;
				VAR_CsvMngState				:= 316;
			ELSIF VAR_FmAck.CommandDone THEN
				CFG.DataOut.ItcDefault		:= TRUE;
				VAR_CsvMngState				:= 399;
			END_IF
		
		316:	//Wait error reset
			IF NOT VAR_FmAck.CommandError THEN
				VAR_CsvMngState	:= 399;
			END_IF
		
		399:	//Wait idle
			IF StFmState = 0 AND NOT VAR_FmAck.CommandDone THEN
				IF (AID.DataOut.ProjectType = CST_AID_ProjectMachine) THEN
					IF CFG_Par.Machine.Type.SRMA THEN
						VAR_CsvMngState	:= 500;					
					ELSIF CFG_Par.Machine.Type.SRMB OR CFG_Par.Machine.Type.SRMC OR CFG_Par.Machine.Type.SRMH OR CFG_Par.Machine.Type.SRMO THEN
						VAR_CsvMngState	:= 400;
					ELSIF CFG_Par.Machine.Type.SRME THEN
						VAR_CsvMngState	:= 500;
					END_IF
				ELSE
					VAR_CsvMngState	:= 700;
				END_IF
			END_IF
		
		400:	//Load Cap configuration
			VAR_FmCmd.Load	:= TRUE;
			VAR_FileName	:= 'CFG_CAP.csv';
		
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryCfgCap);
		
			IF VAR_FmAck.CommandError THEN
				VAR_CsvMngState				:= 410;
			ELSIF VAR_FmAck.CommandDone AND FB_MpRecipeCsv.Info.LastLoadedRecipe = VAR_FileName THEN
				VAR_CfgCapName				:= VAR_Header.Name;
				CFG.DataOut.CfgCapDefault	:= (VAR_Header.Name = 'Default Value');
				VAR_CsvMngState				:= 499;
			END_IF
		
		410:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 THEN
				VAR_CsvMngState	:= 415;
			END_IF
		
		415:	//Save default Cap configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'CFG_CAP.csv';
			FB_MpRecipeCsv.Header	:= ADR(CST_DefaultHeader);
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryCfgCap);
		
			IF VAR_FmAck.CommandError THEN
				CFG.DataOut.ErrorSavingCfgCap	:= TRUE;
				VAR_CsvMngState					:= 416;
			ELSIF VAR_FmAck.CommandDone THEN
				CFG.DataOut.CfgCapDefault		:= TRUE;
				VAR_CsvMngState					:= 499;
			END_IF
		
		416:	//Wait error reset
			IF NOT VAR_FmAck.CommandError THEN
				VAR_CsvMngState	:= 499;
			END_IF
		
		499:	//Wait idle
			IF StFmState = 0 AND NOT VAR_FmAck.CommandDone THEN
				VAR_CsvMngState	:= 500;
			END_IF
		
		500:	//Load Motion configuration
			VAR_FmCmd.Load	:= TRUE;
			VAR_FileName	:= 'CFG_MC.csv';
			
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryMotion);
		
			IF VAR_FmAck.CommandError THEN
				VAR_CsvMngState			:= 510;
			ELSIF VAR_FmAck.CommandDone AND FB_MpRecipeCsv.Info.LastLoadedRecipe = VAR_FileName THEN
				VAR_CfgMotionName			:= VAR_Header.Name;
				CFG.DataOut.MotionDefault	:= (VAR_Header.Name = 'Default Value');
				VAR_CsvMngState				:= 599;
			END_IF
		
		510:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 THEN
				VAR_CsvMngState	:= 515;
			END_IF
		
		515:	//Save default Motion configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'CFG_MC.csv';
			FB_MpRecipeCsv.Header	:= ADR(CST_DefaultHeader);
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryMotion);
		
			IF VAR_FmAck.CommandError THEN
				CFG.DataOut.ErrorSavingMotion	:= TRUE;
				VAR_CsvMngState					:= 516;
			ELSIF VAR_FmAck.CommandDone THEN
				CFG.DataOut.MotionDefault	:= TRUE;
				VAR_CsvMngState				:= 599;
			END_IF
		
		516:	//Wait error reset
			IF NOT VAR_FmAck.CommandError THEN
				VAR_CsvMngState	:= 599;
			END_IF
		
		599:	//Wait idle
			IF StFmState = 0 AND NOT VAR_FmAck.CommandDone THEN
				IF CFG_Par.Machine.Type.SRMA THEN
					VAR_CsvMngState	:= 600;
				ELSIF CFG_Par.Machine.Type.SRMB OR CFG_Par.Machine.Type.SRMC OR CFG_Par.Machine.Type.SRMH OR CFG_Par.Machine.Type.SRMO THEN
					VAR_CsvMngState	:= 600;
				ELSIF CFG_Par.Machine.Type.SRME THEN
					VAR_CsvMngState	:= 700;
				END_IF
			END_IF
		
		600:	//Load Ops configuration
			VAR_FmCmd.Load	:= TRUE;
			VAR_FileName	:= 'CFG_OPS.csv';
			
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryCfgDoor);
		
			IF VAR_FmAck.CommandError THEN
				VAR_CsvMngState			:= 610;
			ELSIF VAR_FmAck.CommandDone AND FB_MpRecipeCsv.Info.LastLoadedRecipe = VAR_FileName THEN
				VAR_CfgDoorName			:= VAR_Header.Name;
				CFG.DataOut.OPSDefault	:= (VAR_Header.Name = 'Default Value');
				VAR_CsvMngState				:= 699;
			END_IF
		
		610:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 THEN
				VAR_CsvMngState	:= 615;
			END_IF
		
		615:	//Save default OPS configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'CFG_OPS.csv';
			FB_MpRecipeCsv.Header	:= ADR(CST_DefaultHeader);
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryCfgDoor);
		
			IF VAR_FmAck.CommandError THEN
				CFG.DataOut.ErrorSavingOPS	:= TRUE;
				VAR_CsvMngState					:= 616;
			ELSIF VAR_FmAck.CommandDone THEN
				CFG.DataOut.OPSDefault	:= TRUE;
				VAR_CsvMngState				:= 699;
			END_IF
		
		616:	//Wait error reset
			IF NOT VAR_FmAck.CommandError THEN
				VAR_CsvMngState	:= 699;
			END_IF
		
		699:	//Wait idle
			IF StFmState = 0 AND NOT VAR_FmAck.CommandDone THEN
				VAR_CsvMngState	:= 700;
			END_IF
	
		700:	//Check for error
			IF CFG.DataOut.ErrorSavingCfg OR CFG.DataOut.ErrorSavingItc OR ((CFG.DataOut.ErrorSavingPao OR CFG.DataOut.ErrorSavingCfgCap OR CFG.DataOut.ErrorSavingMotion OR CFG.DataOut.OPSDefault) AND AID.DataOut.ProjectType = CST_AID_ProjectMachine) THEN
				VAR_CsvMngState		:= 9998;
			ELSIF CFG.DataOut.CfgDefault OR CFG.DataOut.ItcDefault OR ((CFG.DataOut.PaoDefault OR CFG.DataOut.CfgCapDefault OR CFG.DataOut.MotionDefault OR CFG.DataOut.OPSDefault) AND AID.DataOut.ProjectType = CST_AID_ProjectMachine) THEN
				VAR_CsvMngState		:= 9999;
			ELSE
				IF (VAR_CfgPaoName = VAR_CfgItcName) AND (((VAR_CfgPaoName = VAR_HmiPaoName) AND (VAR_CfgPaoName = VAR_CfgMotionName) AND 
					((VAR_CfgPaoName = VAR_CfgDoorName) OR CFG_Par.Machine.Type.SRME)) OR AID.DataOut.ProjectType = CST_AID_ProjectSkid) THEN
					HMI_MachineId	:= VAR_CfgPaoName;
				ELSE
					HMI_MachineId	:= 'Error Name';
				END_IF
				VAR_CsvMngState		:= 800;
			END_IF
		
		800:	//Initial Configuration done - Waiting for request
			CFG.DataOut.ConfigLoaded := TRUE;
			
			IF HMI_PB[PB_CFG_LoadPao].ON THEN
				VAR_CsvMngState		:= 1000;
			ELSIF HMI_PB[PB_CFG_SavePao].ON THEN
				VAR_CsvMngState		:= 1050;
			ELSIF HMI_PB[PB_CFG_LoadCfg].ON THEN
				IF VAR_InitialVariableName = 'CFG_ITC' THEN
					VAR_CsvMngState	:= 1100;
				ELSIF VAR_InitialVariableName = 'CFG_Cap_Par' THEN
					VAR_CsvMngState	:= 1200;
				ELSIF VAR_InitialVariableName = 'CFG_Par' THEN
					VAR_CsvMngState	:= 1300;
				END_IF
			ELSIF HMI_PB[PB_CFG_SaveCfg].ON THEN
				IF VAR_InitialVariableName = 'CFG_ITC' THEN
					VAR_CsvMngState	:= 1150;
				ELSIF VAR_InitialVariableName = 'CFG_Cap_Par' THEN
					VAR_CsvMngState	:= 1250;
				ELSIF VAR_InitialVariableName = 'CFG_Par' THEN
					VAR_CsvMngState	:= 1350;
				END_IF
			ELSIF CAP.DataOut.ConfigSaveReq THEN
				VAR_CsvMngState	:= 1250;
			ELSIF OPS.DataOut.ConfigSaveReq THEN
				VAR_CsvMngState	:= 1450;
			END_IF
		
		1000:	//Manual - Load Hmi configuration
			VAR_FmCmd.Load	:= TRUE;
			VAR_FileName	:= 'HMI_PAO.csv';
		
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryHmi);
		
			IF VAR_FmAck.CommandError OR VAR_FmAck.CommandDone THEN
				VAR_CsvMngState := 1010;
			END_IF
		
		1010:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 AND NOT HMI_PB[PB_CFG_LoadPao].ON THEN
				VAR_CsvMngState	:= 800;
			END_IF
		
		1050:	//Manual - Save Hmi configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'HMI_PAO.csv';
			VAR_Header.Name			:= HMI_MachineId;
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryHmi);
		
			IF VAR_FmAck.CommandError OR VAR_FmAck.CommandDone THEN
				VAR_CsvMngState	:= 1060;
			END_IF
		
		1060:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 AND NOT HMI_PB[PB_CFG_SavePao].ON THEN
				VAR_CsvMngState	:= 800;
			END_IF
		
		1100:	//Manual - Load ITC configuration
			VAR_FmCmd.Load	:= TRUE;
			VAR_FileName	:= 'CFG_ITC.csv';
		
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryItc);
		
			IF VAR_FmAck.CommandError OR VAR_FmAck.CommandDone THEN
				VAR_CsvMngState := 1110;
			END_IF
		
		1110:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 AND NOT HMI_PB[PB_CFG_LoadCfg].ON THEN
				VAR_CsvMngState	:= 800;
			END_IF
		
		1150:	//Manual - Save ITC configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'CFG_ITC.csv';
			VAR_Header.Name			:= HMI_MachineId;
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryItc);
		
			IF VAR_FmAck.CommandError OR VAR_FmAck.CommandDone THEN
				VAR_CsvMngState	:= 1160;
			END_IF
		
		1160:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 AND NOT HMI_PB[PB_CFG_SaveCfg].ON THEN
				VAR_CsvMngState	:= 800;
			END_IF
		
		1200:	//Manual - Load Hmi configuration
			VAR_FmCmd.Load	:= TRUE;
			VAR_FileName	:= 'CFG_CAP.csv';
		
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryCfgCap);
		
			IF VAR_FmAck.CommandError OR VAR_FmAck.CommandDone THEN
				VAR_CsvMngState := 1210;
			END_IF
		
		1210:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 AND NOT HMI_PB[PB_CFG_LoadCfg].ON THEN
				VAR_CsvMngState	:= 800;
			END_IF
		
		1250:	//Manual - Save Hmi configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'CFG_CAP.csv';
			VAR_Header.Name			:= HMI_MachineId;
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryCfgCap);
		
			IF VAR_FmAck.CommandError OR VAR_FmAck.CommandDone THEN
				VAR_CsvMngState	:= 1260;
			END_IF
		
		1260:	//Wait errore reset and idle
			CFG.DataOut.CapSaved	:= TRUE;
			
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 AND NOT HMI_PB[PB_CFG_SaveCfg].ON AND NOT CAP.DataOut.ConfigSaveReq THEN
				VAR_CsvMngState	:= 800;
			END_IF
		
		1300:	//Manual - Load Hmi configuration
			VAR_FmCmd.Load	:= TRUE;
			VAR_FileName	:= 'CFG_PAO.csv';
		
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryConfig);
		
			IF VAR_FmAck.CommandError OR VAR_FmAck.CommandDone THEN
				VAR_CsvMngState := 1310;
			END_IF
		
		1310:	//Wait errore reset and idle
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 AND NOT HMI_PB[PB_CFG_LoadCfg].ON THEN
				VAR_CsvMngState	:= 800;
			END_IF
		
		1350:	//Manual - Save Hmi configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'CFG_PAO.csv';
			VAR_Header.Name			:= HMI_MachineId;
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryConfig);
		
			IF VAR_FmAck.CommandError OR VAR_FmAck.CommandDone THEN
				VAR_CsvMngState	:= 1360;
			END_IF
		
		1360:	//Wait errore reset and idle		
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 AND NOT HMI_PB[PB_CFG_SaveCfg].ON THEN
				VAR_CsvMngState	:= 800;
			END_IF
		
		1450:	//Manual - Save Hmi configuration
			VAR_FmCmd.Save			:= TRUE;
			VAR_FileName			:= 'CFG_OPS.csv';
			VAR_Header.Name			:= HMI_MachineId;
			FB_MpRecipeCsv.Category	:= ADR(VAR_CategoryCfgDoor);
		
			IF VAR_FmAck.CommandError OR VAR_FmAck.CommandDone THEN
				VAR_CsvMngState	:= 1460;
			END_IF
		
		1460:	//Wait errore reset and idle
			CFG.DataOut.OpsSaved	:= TRUE;
			
			IF NOT VAR_FmAck.CommandError AND StFmState = 0 AND NOT CAP.DataOut.ConfigSaveReq THEN
				VAR_CsvMngState	:= 800;
			END_IF
	
		9998:	// Error saving file
		
		9999:	// Default configuration loaded
	END_CASE
END_ACTION
