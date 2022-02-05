FUNCTION_BLOCK FB_DigitalCam
	IF i_rOnCam > 360.0 OR i_rOnCam < 0.0 OR i_rOffCam > 360.0 OR i_rOffCam < 0.0 THEN
		uiMngStep	:= 9999;
	END_IF
	
	IF ((i_rOnCam = i_rOffCam) AND (i_usiPulses <= 1)) OR (i_usiPulses = 0) THEN
		uiMngStep := 0;
	END_IF
	
	IF i_pstAxis.move.mode <> ncPAR_LIST_MOVE AND uiMngStep = 100 AND fbCamSwitch.Enable THEN
		uiMngStep := 10;
	END_IF
		
	CASE uiMngStep OF
		0: 	(* Idle - Check parameters consistation *)
			fbCamSwitch.InitTrackOptions	:= FALSE;
			fbCamSwitch.Enable				:= FALSE;
			
			IF (i_rOnCam <> i_rOffCam) OR (i_usiPulses > 1) THEN
				uiMngStep := 100;
				stMasterSwitch.Master	:= ADR(i_pstAxis);
				stMasterSwitch.Period 	:= 360.0;
			END_IF
		
		10: 
			fbCamSwitch.InitTrackOptions	:= FALSE;
			fbCamSwitch.Enable				:= FALSE;
			
			IF i_pstAxis.move.mode = ncPAR_LIST_MOVE THEN
				uiMngStep := 100;
				fbCamSwitch.Enable	:= TRUE;
			END_IF
			
		100:
			IF EDGEPOS(i_xRefreshClock) THEN
				IF usiMultiPulse <> i_usiPulses THEN
					uiMngStep := 600;
				ELSIF usiMultiPulse = 1 THEN
					IF stMasterSwitch.MasterStartPosition = 0.0 THEN
						IF (i_rOnCam <> stMasterSwitch.Switches[0].FirstOnPosition[0]) OR
							(i_rOffCam <> stMasterSwitch.Switches[0].LastOnPosition[0]) THEN
							stMasterSwitch.Switches[0].FirstOnPosition[0]	:= i_rOnCam;
							stMasterSwitch.Switches[0].LastOnPosition[0]	:= i_rOffCam;
							uiMngStep := 500;
						END_IF
					ELSE
						IF (i_rOnCam <> stMasterSwitch.MasterStartPosition) OR
							(i_rOffCam <> (stMasterSwitch.Switches[0].LastOnPosition[0] - (360.0 - stMasterSwitch.MasterStartPosition))) THEN
							stMasterSwitch.Switches[0].FirstOnPosition[0]	:= i_rOnCam;
							stMasterSwitch.Switches[0].LastOnPosition[0]	:= i_rOffCam;
							uiMngStep := 500;
						END_IF
					END_IF
				ELSIF i_rAdvTime <> (stTrackOption.OnCompensation * 1000.0) THEN
					uiMngStep := 400;
				END_IF
			END_IF
	
		400:
			stTrackOption.OnCompensation	:= i_rAdvTime / 1000.0;
			stTrackOption.OffCompensation	:= i_rAdvTime / 1000.0;
			fbCamSwitch.InitTrackOptions	:= TRUE;
			uiMngStep := 410;
		
		410:
			IF fbCamSwitch.TrackOptionsInitialized THEN
				fbCamSwitch.InitTrackOptions	:= FALSE;
				uiMngStep := 100;
			END_IF
			
		500:	(* Check parameters consistation *)
			IF stMasterSwitch.Switches[0].FirstOnPosition[0] < stMasterSwitch.Switches[0].LastOnPosition[0] THEN
				uiMngStep := 700;
			ELSE
				uiMngStep := 800;
			END_IF
		
		600:
			FOR usiTemp := 0 TO MAX(usiMultiPulse, i_usiPulses) - 1 DO
				IF usiTemp <= i_usiPulses - 1 THEN
					IF usiTemp = 0 THEN
						stMasterSwitch.Switches[0].FirstOnPosition[usiTemp]	:= 0.0;
						stMasterSwitch.Switches[0].LastOnPosition[usiTemp]	:= 180.0 / USINT_TO_REAL(i_usiPulses);
					ELSE
						stMasterSwitch.Switches[0].FirstOnPosition[usiTemp]	:= stMasterSwitch.Switches[0].LastOnPosition[0] * USINT_TO_REAL(usiTemp * 2);
						stMasterSwitch.Switches[0].LastOnPosition[usiTemp]	:= stMasterSwitch.Switches[0].LastOnPosition[0] * (USINT_TO_REAL(usiTemp * 2) + 1.0);	
					END_IF
				ELSE
					stMasterSwitch.Switches[0].FirstOnPosition[usiTemp]	:= 0.0;
					stMasterSwitch.Switches[0].LastOnPosition[usiTemp]	:= 0.0;
				END_IF
			END_FOR
			
			usiMultiPulse := i_usiPulses;
			stMasterSwitch.MasterStartPosition	:= 0.0;
			stTrackOption.OnCompensation		:= i_rAdvTime / 1000.0;
			stTrackOption.OffCompensation		:= i_rAdvTime / 1000.0;
			uiMngStep := 2000;
			
		700:	(* Init switch 4 *)
			stMasterSwitch.MasterStartPosition	:= 0.0;
			stTrackOption.OnCompensation		:= i_rAdvTime / 1000.0;
			stTrackOption.OffCompensation		:= i_rAdvTime / 1000.0;
			uiMngStep := 2000;

		800:
			stMasterSwitch.MasterStartPosition				:= stMasterSwitch.Switches[0].FirstOnPosition[0];
			stMasterSwitch.Switches[0].LastOnPosition[0]	:= stMasterSwitch.Switches[0].LastOnPosition[0] + (360.0 - stMasterSwitch.Switches[0].FirstOnPosition[0]);
			stMasterSwitch.Switches[0].FirstOnPosition[0]	:= 0.0;
			stTrackOption.OnCompensation					:= i_rAdvTime / 1000.0;
			stTrackOption.OffCompensation					:= i_rAdvTime / 1000.0;
			uiMngStep := 2000;
		
		2000:
			IF EDGENEG(fbCamSwitch.Value) OR NOT fbCamSwitch.Enable THEN
				fbCamSwitch.Enable	:= FALSE;
				uiMngStep		:= 2010;
			END_IF
		
		2010:
			IF NOT fbCamSwitch.InOperation THEN
				fbCamSwitch.Enable	:= TRUE;
				uiMngStep		:= 2020;
			END_IF
				
		2020:
			IF NOT fbCamSwitch.Error AND fbCamSwitch.InOperation THEN
				uiMngStep := 100;
				xCamInitialized := TRUE;
			END_IF
			
		9999:
			IF NOT(i_rOnCam > 360.0 OR i_rOnCam > 0.0 OR i_rOffCam > 360.0 OR i_rOffCam > 0.0) THEN
				uiMngStep	:= 0;
			END_IF
	END_CASE
	
	fbCamSwitch(
	Switches		:= stMasterSwitch,
	OutputOptions	:= stOutputOption,
	TrackOptions	:= stTrackOption,
	EnableValue		:= TRUE,
	);
	
	q_xOutPulse := fbCamSwitch.Value;
END_FUNCTION_BLOCK
