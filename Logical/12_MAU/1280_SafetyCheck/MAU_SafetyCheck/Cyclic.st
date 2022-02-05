PROGRAM _CYCLIC
	CMD_SafetyRemoteControl.Password := HMI_SL_Info.Password;

	TMR_TON_Read(
	IN := VAR_SafeRemoteControl_Step = SafeLogic_Wait,
	PT := T#5s
	); //Read SAFE PLC info every 5s

	CASE VAR_SafeRemoteControl_Step OF
		SafeLogic_Wait: //Wait
			IF TMR_TON_Read.Q THEN					//SafeLogic_CMD_ReadStatus;
				VAR_SafeRemoteControl_Step := SafeLogic_ReadOsStatus;
			ELSIF HMI_SL_PB.Ack_SK.ON THEN			//SafeKey acknoledge
				VAR_SafeRemoteControl_Step := SafeLogic_Ack_SK;
			ELSIF HMI_SL_PB.Ack1UdId.ON THEN		//1 UDID acknoledge
				VAR_SafeRemoteControl_Step := SafeLogic_Ack1UdId;
			ELSIF HMI_SL_PB.Ack2UdId.ON THEN		//2 UDID acknoledge
				VAR_SafeRemoteControl_Step := SafeLogic_Ack2UdId;
			ELSIF HMI_SL_PB.Ack3UdId.ON THEN		//3 UDID acknoledge
				VAR_SafeRemoteControl_Step := SafeLogic_Ack3UdId;
			ELSIF HMI_SL_PB.Ack4UdId.ON THEN		//4 UDID acknoledge
				VAR_SafeRemoteControl_Step := SafeLogic_Ack4UdId;
			ELSIF HMI_SL_PB.AckMore4UdId.ON THEN	//4+ UDID acknoledge
				VAR_SafeRemoteControl_Step := SafeLogic_AckMore4UdId;
			ELSIF HMI_SL_PB.AckFW.ON THEN			//Firmware acknoledge
				VAR_SafeRemoteControl_Step := SafeLogic_Ack_FW;
			ELSIF HMI_SL_PB.LedTest.ON THEN			//Test LED
				VAR_SafeRemoteControl_Step := SafeLogic_LedTest;
			ELSIF HMI_SL_PB.Scan.ON THEN			//Scan
				VAR_SafeRemoteControl_Step := SafeLogic_Scan;
			END_IF
			
		SafeLogic_ReadOsStatus:
			// Init address device to read
			VAR_SafetyDeviceAdress := 'IF3.ST3';

			// Init index and subindex to read : SafeOSState
			VAR_Index		:= 16#2000;
			VAR_Subindex 	:= 16#11;
	
			// Reading start
			FB_RemoteEplSDORead(
			enable		:= TRUE,
			pDevice		:= ADR(VAR_SafetyDeviceAdress),
			node		:= 3,  //SafeLOGIC EPL Address
			index		:= VAR_Index,
			subindex	:= VAR_Subindex,
			pData		:= ADR(VAR_SafeOSState),
			datalen		:= SIZEOF(VAR_SafeOSState)
			);

			VAR_CPUSafetyNotFound := (FB_RemoteEplSDORead.status = 20925);
		
			IF FB_RemoteEplSDORead.status <> ERR_FUB_BUSY THEN
				VAR_SafeRemoteControl_Step := SafeLogic_CMD_ReadStatus;
			END_IF
		
		SafeLogic_CMD_ReadStatus:	//REQUEST SAFE PLC info
			CMD_SafetyRemoteControl.Command	:= 16#200;
			CMD_SafetyRemoteControl.Number	:= 1;
			CMD_SafetyRemoteControl.Data	:= 0;

			FB_RemoteEplSDOWrite(
			enable		:= TRUE,
			pDevice		:= ADR(VAR_SafetyDeviceAdress),
			node		:= 3,
			index		:= 16#2406,
			subindex	:= 16#1,
			pData		:= ADR(CMD_SafetyRemoteControl),
			datalen		:= 22
			);

			IF FB_RemoteEplSDOWrite.status <> ERR_FUB_BUSY THEN
				VAR_SafeRemoteControl_Step := SafeLogic_ReadCRC;
			END_IF
		
		SafeLogic_ReadCRC: //CRC
			FB_RemoteEplSDORead(
			enable		:= TRUE,
			pDevice		:= ADR(VAR_SafetyDeviceAdress),
			node		:= 3,
			index		:= 16#2000,
			subindex	:= 16#8,
			pData		:= ADR(VAR_SafeCRC),
			datalen		:= SIZEOF(VAR_SafeCRC)
			);

			IF FB_RemoteEplSDORead.status <> ERR_FUB_BUSY THEN
				VAR_SafeRemoteControl_Step := SafeLogic_ReadTime;
			END_IF

		SafeLogic_ReadTime: //Date
			FB_RemoteEplSDORead(
			enable		:= TRUE,
			pDevice		:= ADR(VAR_SafetyDeviceAdress),
			node		:= 3,
			index		:= 16#2000,
			subindex	:= 16#9,
			pData		:= ADR(VAR_SafeTime),
			datalen		:= SIZEOF(VAR_SafeTime)
			);

			IF FB_RemoteEplSDORead.status <> ERR_FUB_BUSY THEN
				VAR_SafeRemoteControl_Step := SafeLogic_ReadAuthor;
			END_IF

		SafeLogic_ReadAuthor: //Author
			FB_RemoteEplSDORead(
			enable		:= TRUE,
			pDevice		:= ADR(VAR_SafetyDeviceAdress),
			node		:= 3,
			index		:= 16#2000,
			subindex	:= 16#D,
			pData		:= ADR(VAR_SafeAuthor),
			datalen		:= SIZEOF(VAR_SafeAuthor)
			);

			IF FB_RemoteEplSDORead.status <> ERR_FUB_BUSY THEN
				VAR_NoUpdateStatus		:= TRUE;
				VAR_SafeRemoteControl_Step	:= SafeLogic_ReadStatus;
			END_IF

		SafeLogic_ReadStatus: //Status
			FB_RemoteEplSDORead(
			enable		:= TRUE,
			pDevice		:= ADR(VAR_SafetyDeviceAdress),
			node		:= 3,
			index		:= 16#2406,
			subindex	:= 16#2,
			pData		:= ADR(VAR_StatusSafetyRemoteControl),
			datalen		:= SIZEOF(VAR_StatusSafetyRemoteControl)
			);

			IF FB_RemoteEplSDORead.status <> ERR_FUB_BUSY THEN
				VAR_StatusSafetyScanning		:= VAR_StatusSafetyRemoteControl.Scanning;
				VAR_StatusSafetySafeKeyChanged	:= VAR_StatusSafetyRemoteControl.SafeKeyChanged;
				VAR_StatusSafetyNbOfUdId		:= VAR_StatusSafetyRemoteControl.NumberOfUdIdMismatches;
				VAR_StatusSafetyNbOfDiffFW		:= VAR_StatusSafetyRemoteControl.NumberOfDiffFirmware;

				IF VAR_NoUpdateStatus THEN
					VAR_NoUpdateStatus						:= FALSE;
					VAR_StatusSafetyRemoteControl.Status	:= 16#FF;
				END_IF

				VAR_SafeRemoteControl_Step	:= SafeLogic_Wait;
			END_IF

		SafeLogic_AckMore4UdId: //Ackowledge more than 4 UDID mismatches
			CMD_SafetyRemoteControl.Command	:= 16#100;
			CMD_SafetyRemoteControl.Number	:= 16#20;
			CMD_SafetyRemoteControl.Data	:= 16#20;

			VAR_SafeRemoteControl_Step		:= SafeLogic_CMD_Write;

		SafeLogic_Ack4UdId: //Ackowledge 4 UDID mismatches
			CMD_SafetyRemoteControl.Command	:= 16#100;
			CMD_SafetyRemoteControl.Number	:= 16#30;
			CMD_SafetyRemoteControl.Data	:= 16#30;

			VAR_SafeRemoteControl_Step		:= SafeLogic_CMD_Write;

		SafeLogic_Ack3UdId: //Ackowledge 3 UDID mismatches
			CMD_SafetyRemoteControl.Command	:= 16#100;
			CMD_SafetyRemoteControl.Number	:= 16#40;
			CMD_SafetyRemoteControl.Data	:= 16#40;

			VAR_SafeRemoteControl_Step		:= SafeLogic_CMD_Write;

		SafeLogic_Ack2UdId: //Ackowledge 2 UDID mismatches
			CMD_SafetyRemoteControl.Command	:= 16#100;
			CMD_SafetyRemoteControl.Number	:= 16#50;
			CMD_SafetyRemoteControl.Data	:= 16#50;

			VAR_SafeRemoteControl_Step		:= SafeLogic_CMD_Write;

		SafeLogic_Ack1UdId: //Ackowledge 1 UDID mismatches
			CMD_SafetyRemoteControl.Command	:= 16#100;
			CMD_SafetyRemoteControl.Number	:= 16#60;
			CMD_SafetyRemoteControl.Data	:= 16#60;

			VAR_SafeRemoteControl_Step		:= SafeLogic_CMD_Write;

		SafeLogic_Ack_FW: //FW-ACKN, acknowledge a new firmware versions
			CMD_SafetyRemoteControl.Command	:= 16#100;
			CMD_SafetyRemoteControl.Number	:= 16#100;
			CMD_SafetyRemoteControl.Data	:= 16#100;

			VAR_SafeRemoteControl_Step		:= SafeLogic_CMD_Write;	

		SafeLogic_Ack_SK: //SK-XCHG, acknowledge a SafeKEY exchange
			CMD_SafetyRemoteControl.Command	:= 16#100;
			CMD_SafetyRemoteControl.Number	:= 16#200;
			CMD_SafetyRemoteControl.Data	:= 16#200;

			VAR_SafeRemoteControl_Step		:= SafeLogic_CMD_Write;

		SafeLogic_LedTest: //TEST, start an LED test (5s)
			CMD_SafetyRemoteControl.Command	:= 16#100;
			CMD_SafetyRemoteControl.Number	:= 16#1000;
			CMD_SafetyRemoteControl.Data	:= 16#1000;

			VAR_SafeRemoteControl_Step		:= SafeLogic_CMD_Write;

		SafeLogic_Scan: //SCAN, start a system scan
			CMD_SafetyRemoteControl.Command	:= 16#100;
			CMD_SafetyRemoteControl.Number	:= 16#2000;
			CMD_SafetyRemoteControl.Data	:= 16#2000;

			VAR_SafeRemoteControl_Step		:= SafeLogic_CMD_Write;

		SafeLogic_CMD_Write: //Send command to Safety CPU
			FB_RemoteEplSDOWrite(
			enable		:= TRUE,
			pDevice		:= ADR(VAR_SafetyDeviceAdress),
			node		:= 3,
			index		:= 16#2406,
			subindex	:= 16#1,
			pData		:= ADR(CMD_SafetyRemoteControl),
			datalen		:= 22
			);

			IF FB_RemoteEplSDOWrite.status <> ERR_FUB_BUSY THEN
				HMI_SL_PB.Ack_SK.ON			:= FALSE; //Acknoledge SafeKey
				HMI_SL_PB.Ack1UdId.ON		:= FALSE; //Acknoledge 1 UDID
				HMI_SL_PB.Ack2UdId.ON		:= FALSE; //Acknoledge 2 UDID
				HMI_SL_PB.Ack3UdId.ON		:= FALSE; //Acknoledge 3 UDID
				HMI_SL_PB.Ack4UdId.ON		:= FALSE; //Acknoledge 4 UDID
				HMI_SL_PB.AckMore4UdId.ON	:= FALSE; //Acknoledge 4+ UDID
				HMI_SL_PB.AckFW.ON			:= FALSE; //Acknoledge Firmware
				HMI_SL_PB.LedTest.ON		:= FALSE; //Test LED
				HMI_SL_PB.Scan.ON			:= FALSE; //Scan
				VAR_SafeRemoteControl_Step	:= SafeLogic_ReadStatus;
			END_IF

	END_CASE
	
	(************************************************************************************************************************)
	(*************************************************  DISPLAY MANAGEMENT  *************************************************)
	(************************************************************************************************************************)
	IF VAR_SafeRemoteControl_Step = SafeLogic_Wait THEN
		//SafeCRC in string
		HMI_SL_Info.CRC := VAR_SafeCRC;

		//SafeTime in string
		DT_TO_DTStructure(VAR_SafeTime, ADR(VAR_SafeTime_DTStruct));
		itoa(VAR_SafeTime_DTStruct.day, ADR(VAR_Temp));
		HMI_SL_Info.Date := VAR_Temp;
		strcat(ADR(HMI_SL_Info.Date), ADR('/'));
		itoa(VAR_SafeTime_DTStruct.month, ADR(VAR_Temp));
		strcat(ADR(HMI_SL_Info.Date), ADR(VAR_Temp));
		strcat(ADR(HMI_SL_Info.Date), ADR('/'));
		itoa(VAR_SafeTime_DTStruct.year, ADR(VAR_Temp));
		VAR_Temp := RIGHT(VAR_Temp,2);
		strcat(ADR(HMI_SL_Info.Date), ADR(VAR_Temp));
		strcat(ADR(HMI_SL_Info.Date), ADR('  '));
		itoa(VAR_SafeTime_DTStruct.hour, ADR(VAR_Temp));
		strcat(ADR(HMI_SL_Info.Date), ADR(VAR_Temp));
		strcat(ADR(HMI_SL_Info.Date), ADR(':'));
		itoa(VAR_SafeTime_DTStruct.minute, ADR(VAR_Temp));
		strcat(ADR(HMI_SL_Info.Date), ADR(VAR_Temp));

		//Safe Author
		HMI_SL_Info.Author				:= VAR_SafeAuthor;

		//Remote Control Status
		HMI_SL_Info.RemoteCtrlStatus	:= VAR_StatusSafetyRemoteControl.Status;

		//Safe Status ID
		HMI_SL_Info.IDMissed := '';
		memset(ADR(VAR_ModuleSafetyMissing), 0, SIZEOF(VAR_ModuleSafetyMissing));
		IF NOT(VAR_SafeOSState = cRUN_SAFE) OR NOT SI_SafeLogicModuleOk THEN
			FOR j := 0 TO ((SIZEOF(VAR_ModuleSafetyMissing) / SIZEOF(VAR_ModuleSafetyMissing[0])) - 1) DO
				VAR_ModuleSafetyMissing[j] := TRUE;
			END_FOR
		END_IF 

		IF VAR_StatusSafetyRemoteControl.NumberOfMissingModules <> 0 THEN //Module missing
			FOR i := 0 TO 15 DO
				FOR j := 0 TO 7 DO
					IF BIT_TST(VAR_StatusSafetyRemoteControl.MissingModules[i], j) THEN
						IF strcmp(ADR(HMI_SL_Info.IDMissed), ADR("")) <> 0 THEN
							strcat(ADR(HMI_SL_Info.IDMissed), ADR('/'));
						END_IF
						itoa(VAR_StatusSafetyRemoteControl.SAddr[i * 8 + j], ADR(VAR_Temp));
						VAR_ModuleSafetyMissing[VAR_StatusSafetyRemoteControl.SAddr[i * 8 + j]] := TRUE;
						strcat(ADR(HMI_SL_Info.IDMissed), ADR(VAR_Temp));
					END_IF
				END_FOR
			END_FOR
		END_IF

		HMI_SL_Info.IDMismatches := '';
		IF VAR_StatusSafetyRemoteControl.NumberOfUdIdMismatches <> 0 THEN //Module mismatches
			FOR i := 0 TO 15 DO
				FOR j := 0 TO 7 DO
					IF BIT_TST(VAR_StatusSafetyRemoteControl.UdIdMismatches[i], j) THEN
						IF strcmp(ADR(HMI_SL_Info.IDMismatches), ADR("")) <> 0 THEN
							strcat(ADR(HMI_SL_Info.IDMismatches), ADR('/'));
						END_IF
						itoa(VAR_StatusSafetyRemoteControl.SAddr[i * 8 + j], ADR(VAR_Temp));
						strcat(ADR(HMI_SL_Info.IDMismatches), ADR(VAR_Temp));
					END_IF
				END_FOR
			END_FOR
		END_IF

		HMI_SL_Info.IDDiffFirmware := '';
		IF VAR_StatusSafetyRemoteControl.NumberOfDiffFirmware <> 0 THEN //Module Update
			FOR i := 0 TO 15 DO
				FOR j := 0 TO 7 DO
					IF BIT_TST(VAR_StatusSafetyRemoteControl.DiffFirmware[i], j) THEN
						IF strcmp(ADR(HMI_SL_Info.IDDiffFirmware), ADR("")) <> 0 THEN
							strcat(ADR(HMI_SL_Info.IDDiffFirmware), ADR('/'));
						END_IF
						itoa(VAR_StatusSafetyRemoteControl.SAddr[i * 8 + j], ADR(VAR_Temp));
						strcat(ADR(HMI_SL_Info.IDDiffFirmware), ADR(VAR_Temp));
					END_IF
				END_FOR
			END_FOR
		END_IF

		// Status Text - FAIL LED
		IF (VAR_StatusSafetyRemoteControl.FailSafe <> cFAIL_SAFE_OK) THEN
			HMI_SL_Info.Led.FAIL := 2;
		ELSIF (VAR_StatusSafetyRemoteControl.OpenSafetyState = 0) THEN
			HMI_SL_Info.Led.FAIL := 0;
		ELSIF (VAR_StatusSafetyRemoteControl.OpenSafetyState = 1) THEN
			HMI_SL_Info.Led.FAIL := 1;
		END_IF

		// Status text - FW-ACKN_LED
		IF (VAR_StatusSafetyRemoteControl.SafeKeyChanged = 0 AND VAR_StatusSafetyRemoteControl.NumberOfDiffFirmware = 0) THEN
			HMI_SL_Info.Led.FW_ACKN := 10;
		ELSIF (VAR_StatusSafetyRemoteControl.SafeKeyChanged = 1) THEN
			HMI_SL_Info.Led.FW_ACKN := 1;
		ELSIF (VAR_StatusSafetyRemoteControl.NumberOfDiffFirmware <> 0) THEN
			HMI_SL_Info.Led.FW_ACKN := 2;
		END_IF

		// Status text - MXCHG_LED
		IF (VAR_StatusSafetyRemoteControl.LedTestActive = 1) THEN
			HMI_SL_Info.Led.MXCHG := 40;
		ELSIF (VAR_StatusSafetyRemoteControl.Scanning = 1) THEN
			HMI_SL_Info.Led.MXCHG := 30;
		ELSIF (VAR_StatusSafetyRemoteControl.NumberOfUdIdMismatches = 1) THEN
			HMI_SL_Info.Led.MXCHG := 1;
		ELSIF (VAR_StatusSafetyRemoteControl.NumberOfUdIdMismatches = 2) THEN
			HMI_SL_Info.Led.MXCHG := 2;
		ELSIF (VAR_StatusSafetyRemoteControl.NumberOfUdIdMismatches = 3) THEN
			HMI_SL_Info.Led.MXCHG := 3;
		ELSIF (VAR_StatusSafetyRemoteControl.NumberOfUdIdMismatches = 4) THEN
			HMI_SL_Info.Led.MXCHG := 4;
		ELSIF (VAR_StatusSafetyRemoteControl.NumberOfUdIdMismatches > 4) THEN
			HMI_SL_Info.Led.MXCHG := 5;
		ELSIF (VAR_StatusSafetyRemoteControl.NumberOfMissingModules <> 0) THEN
			HMI_SL_Info.Led.MXCHG := 20;
		ELSIF (VAR_StatusSafetyRemoteControl.NumberOfUdIdMismatches = 0) THEN
			HMI_SL_Info.Led.MXCHG := 10;
		END_IF

		// Status text - RE_LED
		HMI_SL_Info.Led.RE := VAR_StatusSafetyRemoteControl.SafeOSstate;
	END_IF
	
	VAR_AllowedSafeButton	:= NOT HMI_SL_PB.Ack_SK.LampON			AND NOT HMI_SL_PB.Ack1UdId.LampON	AND NOT HMI_SL_PB.Ack2UdId.LampON		AND
								NOT HMI_SL_PB.Ack3UdId.LampON		AND NOT HMI_SL_PB.Ack4UdId.LampON	AND NOT HMI_SL_PB.AckMore4UdId.LampON	AND
								NOT HMI_SL_PB.AckFW.LampON			AND NOT	HMI_SL_PB.LedTest.LampON	AND NOT HMI_SL_PB.Scan.LampON			AND
								memcmp(ADR(HMI_SL_Info.Password),	ADR(CST_SafePasswordBlank),			SIZEOF(HMI_SL_Info.Password)) <> 0		AND
								memcmp(ADR(HMI_SL_Info.Password),	ADR(CST_SafePasswordNull),			SIZEOF(HMI_SL_Info.Password)) <> 0		AND VAR_StatusSafetyRemoteControl.Status = 255;
	
	HMI_SL_PB.Ack_SK.Enable			:= (VAR_StatusSafetyScanning = 0	OR (VAR_StatusSafetyScanning = 1		AND HMI_SL_Info.Led.FAIL = 2		AND HMI_SL_Info.Led.RE <> 0))		AND VAR_StatusSafetySafeKeyChanged = 1	AND VAR_AllowedSafeButton;
	HMI_SL_PB.Ack1UdId.Enable		:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId = 1	AND VAR_AllowedSafeButton;
	HMI_SL_PB.Ack2UdId.Enable		:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId = 2	AND VAR_AllowedSafeButton;
	HMI_SL_PB.Ack3UdId.Enable		:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId = 3	AND VAR_AllowedSafeButton;
	HMI_SL_PB.Ack4UdId.Enable		:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId = 4	AND VAR_AllowedSafeButton;
	HMI_SL_PB.AckMore4UdId.Enable	:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId > 4	AND VAR_AllowedSafeButton;
	HMI_SL_PB.AckFW.Enable			:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId = 0	AND VAR_StatusSafetyNbOfDiffFW > 0	AND VAR_AllowedSafeButton;
	HMI_SL_PB.LedTest.Enable		:= VAR_StatusSafetyScanning = 0		AND VAR_SafeOSState <> 0				AND NOT(VAR_CPUSafetyNotFound)		AND VAR_AllowedSafeButton;
	HMI_SL_PB.Scan.Enable			:= VAR_StatusSafetyScanning = 0		AND VAR_SafeOSState <> 0				AND NOT(VAR_CPUSafetyNotFound)		AND VAR_AllowedSafeButton;
	
	HMI_SL_PB.Ack_SK.Blink			:= (VAR_StatusSafetyScanning = 0	OR (VAR_StatusSafetyScanning = 1		AND HMI_SL_Info.Led.FAIL = 2		AND HMI_SL_Info.Led.RE <> 0))		AND VAR_StatusSafetySafeKeyChanged = 1	AND VAR_StatusSafetyRemoteControl.Status = 255;
	HMI_SL_PB.Ack1UdId.Blink		:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId = 1	AND VAR_StatusSafetyRemoteControl.Status = 255;
	HMI_SL_PB.Ack2UdId.Blink		:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId = 2	AND VAR_StatusSafetyRemoteControl.Status = 255;
	HMI_SL_PB.Ack3UdId.Blink		:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId = 3	AND VAR_StatusSafetyRemoteControl.Status = 255;
	HMI_SL_PB.Ack4UdId.Blink		:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId = 4	AND VAR_StatusSafetyRemoteControl.Status = 255;
	HMI_SL_PB.AckMore4UdId.Blink	:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId > 4	AND VAR_StatusSafetyRemoteControl.Status = 255;
	HMI_SL_PB.AckFW.Blink			:= VAR_StatusSafetyScanning = 0		AND VAR_StatusSafetySafeKeyChanged = 0	AND VAR_StatusSafetyNbOfUdId = 0	AND VAR_StatusSafetyNbOfDiffFW > 0	AND VAR_StatusSafetyRemoteControl.Status = 255;
	
	HMI_SL_PB.Ack_SK.LampON			:= HMI_SL_PB.Ack_SK.ON;
	HMI_SL_PB.Ack1UdId.LampON		:= HMI_SL_PB.Ack1UdId.ON;
	HMI_SL_PB.Ack2UdId.LampON		:= HMI_SL_PB.Ack2UdId.ON;
	HMI_SL_PB.Ack3UdId.LampON		:= HMI_SL_PB.Ack3UdId.ON;
	HMI_SL_PB.Ack4UdId.LampON		:= HMI_SL_PB.Ack4UdId.ON;
	HMI_SL_PB.AckMore4UdId.LampON	:= HMI_SL_PB.AckMore4UdId.ON;
	HMI_SL_PB.AckFW.LampON			:= HMI_SL_PB.AckFW.ON;
	HMI_SL_PB.LedTest.LampON		:= HMI_SL_PB.LedTest.ON;
	HMI_SL_PB.Scan.LampON			:= HMI_SL_PB.Scan.ON;
	
	VAR_SafeLogicStatus.FailSafe			:= (VAR_StatusSafetyRemoteControl.FailSafe					<> cFAIL_SAFE_OK);
	VAR_SafeLogicStatus.FirmwareAcknowledge	:= (VAR_StatusSafetyRemoteControl.NumberOfDiffFirmware	 	<> 0);
	VAR_SafeLogicStatus.NoExecution			:= (VAR_SafeOSState = cNO_EXECUTION);
	VAR_SafeLogicStatus.RunDebug			:= (VAR_SafeOSState = cRUN_DEBUG);
	VAR_SafeLogicStatus.RunSafe				:= (VAR_SafeOSState = cRUN_SAFE);
	VAR_SafeLogicStatus.SafeKeyExchange		:= (VAR_StatusSafetyRemoteControl.SafeKeyChanged 			<> 0);
	VAR_SafeLogicStatus.Scan				:= (VAR_StatusSafetyRemoteControl.Scanning					<> 0);	
	VAR_SafeLogicStatus.ModuleExchange		:= (VAR_StatusSafetyRemoteControl.NumberOfUdIdMismatches	<> 0);
	VAR_SafeLogicStatus.ModuleMissing		:= (VAR_StatusSafetyRemoteControl.NumberOfMissingModules	<> 0);
	
	HMI_MSG[300]	:= (NOT VAR_SafeLogicStatus.RunSafe AND NOT VAR_SafeLogicStatus.RunDebug) OR VAR_SafeLogicStatus.FailSafe;
	HMI_MSG[301]	:= VAR_SafeLogicStatus.FirmwareAcknowledge OR VAR_SafeLogicStatus.SafeKeyExchange OR (VAR_SafeLogicStatus.ModuleExchange <> 0);
	HMI_MSG[302]	:= VAR_SafeLogicStatus.RunDebug;
END_PROGRAM
