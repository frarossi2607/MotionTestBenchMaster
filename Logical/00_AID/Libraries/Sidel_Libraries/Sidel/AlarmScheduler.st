FUNCTION_BLOCK AlarmScheduler
	//V4.A.A.1.6.13
	memset(ADR(AlarmActionTemp), 0, SIZEOF(AlarmActionTemp));

	FOR x := 0 TO 24 DO//V1.7.2
		IF AlarmAreaCfg[x].From = 0 OR AlarmAreaCfg[x].To = 0 THEN
		ELSE
			FOR i := MAX(0, AlarmAreaCfg[x].From - 1) TO MAX(AlarmAreaCfg[x].To - 1, AlarmAreaCfg[x].From - 1) DO
				
				Alarm ACCESS AdrAlarm + (SIZEOF(Alarm) * i);
				AlarmCFG ACCESS AdrAlarmCFG + (SIZEOF(AlarmCFG) * i);
				AlarmOldStatus ACCESS AdrAlarmOldStatus + (SIZEOF(AlarmOldStatus) * i);
				HMI ACCESS AdrHMI + (SIZEOF(HMI) * i);
				
				IF FirstAlarmActive.OMAC_Index = AlarmCFG.OMAC_Index THEN
					memset(ADR(FirstAlarmActive), 0, SIZEOF(FirstAlarmActive));
				END_IF
                                               
				IF FirstExternalAlarmActive.OMAC_Index = AlarmCFG.OMAC_Index THEN
					memset(ADR(FirstExternalAlarmActive), 0, SIZEOF(FirstExternalAlarmActive));
				END_IF

				IF FirstAlarmActive.OMAC_Index = 0      AND Alarm.Active AND
					(Alarm.ActionEn AND NOT Alarm.ByPass) AND
					(AlarmCFG.Action <> 0) AND (AlarmCFG.Action <> 67) AND
					NOT Alarm.DependentActive THEN
					FirstAlarmActive := AlarmCFG;
				END_IF

				IF FirstExternalAlarmActive.OMAC_Index = 0      AND Alarm.Active AND
					(Alarm.ActionEn AND NOT Alarm.ByPass) AND
					(AlarmCFG.Action <> 0) AND (AlarmCFG.Category = 3) AND
					NOT Alarm.DependentActive THEN
					FirstExternalAlarmActive := AlarmCFG;
				END_IF
				
				IF Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND Alarm.Visibility) AND 
					NOT AlarmOldStatus AND NOT CriticalAcknoledgeRequest AND
					(AlarmCFG.Action > 0 AND AlarmCFG.Action < 32)	AND
					NOT Alarm.DependentActive THEN
					CriticalAcknoledgeRequest := AlarmCFG.Action <> 6; //ALARM SCHEDULER V4_03:ESCLUSIONE DEGLI ALLARMI DI SBLOCCO PORTE
				END_IF

				IF Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND Alarm.Visibility) AND 
					NOT AlarmOldStatus AND NOT AlarmAcknoledgeRequest AND
					(AlarmCFG.Action >= 32 AND AlarmCFG.Action < 64)	AND
					NOT Alarm.DependentActive THEN
					AlarmAcknoledgeRequest := TRUE;
				END_IF
				
				Alarm.ActionDis := NOT Alarm.ActionEn;
				
				HMI.0			:= Alarm.ActionEn;
				HMI.1			:= Alarm.ByPassEn;
				HMI.2;
				HMI.3;
				Alarm.ByPass	:= HMI.4;
				HMI.5			:= Alarm.ActionDis;
				HMI.6			:= Alarm.Active;
				HMI.7			:= Alarm.Visibility;

				CASE AlarmCFG.Action OF
					
					0:
						AlarmActionTemp.Bit.ALR_NULL					:= Alarm.Active AND NOT Alarm.DependentActive OR AlarmActionTemp.Bit.ALR_NULL;
					1:
						AlarmActionTemp.Bit.ALR_MS_QuickStop			:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_MS_QuickStop;
					2:	
						AlarmActionTemp.Bit.ALR_MS_NormalStop			:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_MS_NormalStop;
					3:	
						AlarmActionTemp.Bit.ALR_MS_QuickWithJog			:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_MS_QuickWithJog;
					4:	
						AlarmActionTemp.Bit.ALR_MS_NormalWithJog		:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_MS_NormalWithJog;
					6:	
						AlarmActionTemp.Bit.ALR_MS_NormalWithJogMnt		:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_MS_NormalWithJogMnt;
					10:
						AlarmActionTemp.Bit.ALR_CSR_StopAfterEmptying	:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_CSR_StopAfterEmptying;
					32:	
						AlarmActionTemp.Bit.ALR_CSR						:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_CSR;
					33:
						AlarmActionTemp.Bit.ALR_CSR_AfterSlowdown		:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_CSR_AfterSlowdown;
					64:
						AlarmActionTemp.Bit.ALR_CSA						:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_CSA;
					65:	
						AlarmActionTemp.Bit.ALR_CSA_AfterSlowdown		:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_CSA_AfterSlowdown;
					81:	
						AlarmActionTemp.Bit.ALR_StartModeDisabled		:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_StartModeDisabled;
					86:	
						AlarmActionTemp.Bit.ALR_NoProduction			:= Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive) OR AlarmActionTemp.Bit.ALR_NoProduction;
					
					ELSE
						AlarmActionTemp.Bit.ALR_NULL					:= Alarm.Active AND NOT Alarm.DependentActive OR AlarmActionTemp.Bit.ALR_NULL;
				END_CASE
				
				//EXTRACTION OF FIRST ALARM FOR EACH CATEGORY
				IF FirstCriticalAlarmActive.OMAC_Index = AlarmCFG.OMAC_Index THEN//V4.A.A.1.7.0
					memset(ADR(FirstCriticalAlarmActive), 0, SIZEOF(FirstCriticalAlarmActive));
				END_IF
				
				IF FirstAlertAlarmActive.OMAC_Index = AlarmCFG.OMAC_Index THEN//V4.A.A.1.7.0
					memset(ADR(FirstAlertAlarmActive), 0, SIZEOF(FirstAlertAlarmActive));
				END_IF
				
				IF FirstExtCriticalAlarmActive.OMAC_Index = AlarmCFG.OMAC_Index THEN//V4.A.A.1.7.0
					memset(ADR(FirstExtCriticalAlarmActive), 0, SIZEOF(FirstExtCriticalAlarmActive));
				END_IF
				
				IF FirstExtAlertAlarmActive.OMAC_Index = AlarmCFG.OMAC_Index THEN//V4.A.A.1.7.0
					memset(ADR(FirstExtAlertAlarmActive), 0, SIZEOF(FirstExtAlertAlarmActive));
				END_IF
				IF FirstCsAlarmActive.OMAC_Index = AlarmCFG.OMAC_Index THEN//V4.A.A.1.7.0
					memset(ADR(FirstCsAlarmActive), 0, SIZEOF(FirstCsAlarmActive));
				END_IF
				//V4.A.A.1.7.0
				IF FirstCriticalAlarmActive.OMAC_Index = 0	AND Alarm.Active		AND
					(Alarm.ActionEn					AND NOT Alarm.ByPass)		AND
					(AlarmCFG.Action > 0)			AND (AlarmCFG.Action <= 31)	AND (AlarmCFG.Category <> 3) AND
					NOT Alarm.DependentActive THEN
					FirstCriticalAlarmActive := AlarmCFG;
				END_IF
				//V4.A.A.1.7.0
				IF FirstAlertAlarmActive.OMAC_Index = 0	AND Alarm.Active			AND
					(Alarm.ActionEn					AND NOT Alarm.ByPass)		AND
					(AlarmCFG.Action >= 32)			AND (AlarmCFG.Action <= 63)	AND (AlarmCFG.Category <> 3) AND 
					NOT Alarm.DependentActive THEN
					FirstAlertAlarmActive := AlarmCFG;
				END_IF
				//V4.A.A.1.7.0
				IF FirstExtCriticalAlarmActive.OMAC_Index = 0	AND Alarm.Active			AND
					(Alarm.ActionEn							AND NOT Alarm.ByPass)		AND
					(AlarmCFG.Action > 0)			AND (AlarmCFG.Action <= 31)	AND (AlarmCFG.Category = 3)	AND
					NOT Alarm.DependentActive THEN
					FirstExtCriticalAlarmActive := AlarmCFG;
				END_IF
				//V4.A.A.1.7.0
				IF FirstExtAlertAlarmActive.OMAC_Index = 0	AND Alarm.Active			AND
					(Alarm.ActionEn							AND NOT Alarm.ByPass)		AND
					(AlarmCFG.Action >= 32)			AND (AlarmCFG.Action <= 63)	AND (AlarmCFG.Category = 3)	AND
					NOT Alarm.DependentActive THEN
					FirstExtAlertAlarmActive := AlarmCFG;
				END_IF
				//V4.A.A.1.7.0
				IF FirstCsAlarmActive.OMAC_Index = 0	AND Alarm.Active			AND
					(Alarm.ActionEn							AND NOT Alarm.ByPass)		AND
					(AlarmCFG.Action >= 64)			AND (AlarmCFG.Action <= 65)	AND
					NOT Alarm.DependentActive THEN
					FirstCsAlarmActive := AlarmCFG;
				END_IF
				//END EXTRACTION

				AlarmOldStatus := Alarm.Active AND (Alarm.ActionEn AND NOT Alarm.ByPass AND NOT Alarm.DependentActive);
			END_FOR
		END_IF
	END_FOR
			
	AlarmAction	:= AlarmActionTemp;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FirstAlarmCombiner	
	IF (FirstAlarmActive.OMAC_Index >= SkidAlarmFrom) AND (FirstAlarmActive.OMAC_Index <= SkidAlarmTo) THEN
		memset(ADR(FirstAlarmActive), 0, SIZEOF(FirstAlarmActive));
	END_IF
		
	IF (FirstExternalAlarmActive.OMAC_Index >= SkidAlarmFrom) AND (FirstExternalAlarmActive.OMAC_Index <= SkidAlarmTo) THEN
		memset(ADR(FirstExternalAlarmActive), 0, SIZEOF(FirstExternalAlarmActive));
	END_IF
		
	IF SkidFirstAlarm <> 0 AND FirstAlarmActive.OMAC_Index = 0 THEN
		FirstAlarmActive.OMAC_Index := SkidFirstAlarm;
	END_IF
	
	IF SkidFirstExternalAlarm <> 0 AND FirstExternalAlarmActive.OMAC_Index = 0 THEN
		FirstExternalAlarmActive.OMAC_Index := SkidFirstExternalAlarm;
	END_IF
END_FUNCTION_BLOCK