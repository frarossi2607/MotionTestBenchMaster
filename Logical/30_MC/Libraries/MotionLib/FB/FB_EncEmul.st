(*********************************************************************************
 * Copyright:  
 * Author:    		EncoderEmulationManagement
 * Created:  		July 4, 2016/2:37 PM 
 * HELP REFERENCE:  ncsoftware/acp10_drivefunctions/acp10_drivefunctions-63-15.html
 *********************************************************************************)

(* Encoder Emulation on 8BAC130.001-1 plug-in module*)
FUNCTION_BLOCK FB_EncEmul
	IF i_pstEncEmulAxis.nc_obj_inf.node_nr > 0 AND i_pstEncEmulAxis.network.phase  <> 90 AND uiStep > 0 THEN
		uiStep := 950;
	ELSIF fbAxisError.Error	THEN
		uiStep := 960;
	ELSIF fbAxisError.Enable AND (fbAxisError.FunctionBlockErrorCount > 0 OR fbAxisError.AxisErrorCount > 0 ) THEN
		uiStep := 970;
	END_IF
	
	CASE uiStep OF
		0:(* DISABLE *)
			q_xError 					:= FALSE;
			q_xActive					:= FALSE;
			fbReadParID.Execute 		:= FALSE;
			fbWriteParID_Text.Execute 	:= FALSE;
			fbWriteParID.Execute 		:= FALSE;
			
			IF NOT i_xErrorReset AND i_pstEncEmulAxis.network.phase  = 90 AND i_pstEncEmulAxis.nc_obj_inf.node_nr > 0 THEN
				fbAxisError.Axis	:= ADR(i_pstEncEmulAxis);
				fbAxisError.Mode	:= mcNO_TEXT + mcACKNOWLEDGE_ALL;
				fbAxisError.Enable	:= TRUE; //V4.A.A.1.6.13
				uiStep				:= 10;
			END_IF
		
		(**************************** CONFIGURE ENCODER EMULATION ****************************)
		10:(* ENCODER TYPE CONFIG *)
			IF NOT fbWriteParID.Execute THEN
				usiTemp						:= ncINC_OUTPUT;
			
				fbWriteParID.Axis			:= ADR(i_pstEncEmulAxis);
				fbWriteParID.DataAddress 	:= ADR(usiTemp);
				fbWriteParID.DataType		:= ncPAR_TYP_USINT;
				fbWriteParID.ParID			:= ACP10PAR_ENCOD_TYPE;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_ENCOD_TYPE THEN
				fbWriteParID.Execute	:= FALSE;
				uiStep					:= 20;
			ELSIF fbWriteParID.Error THEN
				uiStep					:= 900;
			END_IF
		(* ENCODER MODE CONFIG *)
		20:(* INC MODE *)
			IF NOT fbWriteParID.Execute THEN
				uiTemp						:= 4;
			
				fbWriteParID.Axis			:= ADR(i_pstEncEmulAxis);
				fbWriteParID.DataAddress 	:= ADR(uiTemp);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_ENCOD_INC_MODE;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_ENCOD_INC_MODE THEN
				fbWriteParID.Execute	:= FALSE;
				uiStep					:= 30;
			ELSIF fbWriteParID.Error THEN
				uiStep					:= 900;
			END_IF
		
		30:(* SCALE ENC INCREMENT CONFIG *)
			IF NOT fbWriteParID.Execute THEN
				udiTemp						:= UINT_TO_UDINT(i_uiNumberOfPulses) * 64;
				
				fbWriteParID.Axis			:= ADR(i_pstEncEmulAxis);
				fbWriteParID.DataAddress 	:= ADR(udiTemp);
				fbWriteParID.DataType		:= ncPAR_TYP_UDINT;
				fbWriteParID.ParID			:= ACP10PAR_SCALE_ENCOD_INCR;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_SCALE_ENCOD_INCR THEN
				fbWriteParID.Execute	:= FALSE;
				uiStep					:= 40;
			ELSIF fbWriteParID.Error THEN
				uiStep					:= 900;
			END_IF
		
		40:(* SCALE LOAD UNITS CONFIG *)
			IF NOT fbWriteParID.Execute THEN
				udiTemp						:= 36000;
			
				fbWriteParID.Axis			:= ADR(i_pstEncEmulAxis);
				fbWriteParID.DataAddress 	:= ADR(udiTemp);
				fbWriteParID.DataType		:= ncPAR_TYP_UDINT;
				fbWriteParID.ParID			:= ACP10PAR_SCALE_LOAD_UNITS;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_SCALE_LOAD_UNITS THEN
				fbWriteParID.Execute	:= FALSE;
				IF i_pstSrcAxis.nc_obj_inf.node_nr = i_pstEncEmulAxis.nc_obj_inf.node_nr THEN
					uiStep := 200;		//CONFIGURE CROSSLINK
				ELSE
					uiStep := 100;		//CONFIGURE NETWORK COUPLING
				END_IF
			ELSIF fbWriteParID.Error THEN
				uiStep := 900;
			END_IF

		(************************** CONFIGURE NETWORK COUPLING ******************************)
		100:(* Sender config: MA3_CYCLIC_SEND <- PCTRL_S_SET / S_VAX1 *)
			IF NOT fbWriteParID.Execute THEN
				IF i_pstSrcAxis.nc_obj_inf.nc_obj_typ = ncAXIS THEN
					uiTemp		:= ACP10PAR_PCTRL_S_SET; 	//REAL AXIS
				ELSE
					uiTemp		:= ACP10PAR_S_SET_VAX1;		//VIRTUAL AXIS
				END_IF
				
				fbWriteParID.Axis			:= ADR(i_pstSrcAxis);
				fbWriteParID.DataAddress 	:= ADR(uiTemp);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_MA3_CYCLIC_SEND;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_MA3_CYCLIC_SEND THEN
				fbWriteParID.Execute	:= FALSE;
				uiStep					:= 120;
			ELSIF fbWriteParID.Error THEN
				uiStep					:= 900;
			END_IF
				
		120:(* Receiver config : MA5_CYCLIC_POS <- "node_nr [+ 256 for AXIS 2], MA3_CYCLIC_SEND" *)
			IF NOT fbWriteParID_Text.Execute THEN
				uiTemp		:= i_pstSrcAxis.nc_obj_inf.node_nr + 256 * (i_pstSrcAxis.nc_obj_inf.nc_obj_idx);
				itoa(uiTemp, ADR(strTemp));
				uiTemp		:= ACP10PAR_MA3_CYCLIC_SEND;
				itoa(uiTemp, ADR(strTemp2));
				
				strcat(ADR(strTemp), ADR(', '));
				strcat(ADR(strTemp), ADR(strTemp2));
				
				fbWriteParID_Text.Axis			:= ADR(i_pstEncEmulAxis);
				fbWriteParID_Text.DataText	 	:= strTemp;
				fbWriteParID_Text.ParID			:= ACP10PAR_CONFIG_MA5_CYCLIC_POS;
				fbWriteParID_Text.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID_Text.Done AND fbWriteParID_Text.ParID = ACP10PAR_CONFIG_MA5_CYCLIC_POS THEN
				fbWriteParID_Text.Execute	:= FALSE;
				uiStep						:= 140;
			ELSIF fbWriteParID_Text.Error THEN
				uiStep					:= 900;
			END_IF
				
		140:(* Set interpolation mode = LINEAR *)
			IF NOT fbWriteParID.Execute THEN
				usiTemp						:= 1;	//LINEAR MODE
			
				fbWriteParID.Axis			:= ADR(i_pstEncEmulAxis);
				fbWriteParID.DataAddress 	:= ADR(usiTemp);
				fbWriteParID.DataType		:= ncPAR_TYP_USINT;
				fbWriteParID.ParID			:= ACP10PAR_MA5_CYCLIC_IPL_MODE;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_MA5_CYCLIC_IPL_MODE THEN
				fbWriteParID.Execute	:= FALSE;
				uiStep					:= 150;
			ELSIF fbWriteParID.Error THEN
				uiStep					:= 900;
			END_IF
		
		150:(* CHECK COMMUNICATION STATUS *)
			IF NOT fbReadParID.Execute THEN
				fbReadParID.Axis			:= ADR(i_pstEncEmulAxis);
				fbReadParID.DataAddress 	:= ADR(usiErrCode);
				fbReadParID.DataType		:= ncPAR_TYP_USINT;
				fbReadParID.ParID			:= ACP10PAR_MA5_CYCLIC_ERROR_STATUS;
				fbReadParID.Execute			:= TRUE;
			END_IF
			
			IF fbReadParID.Done AND fbReadParID.ParID = ACP10PAR_MA5_CYCLIC_ERROR_STATUS THEN
				fbReadParID.Execute	:= FALSE;
				IF usiErrCode = ERR_OK THEN
					uiEncodOutParID		:= ACP10PAR_MA5_CYCLIC_POS;
					IF i_xEnable THEN
						uiStep	:= 250;
					ELSE
						uiStep	:= 400;
					END_IF
				ELSE  
					uiStep				:= 800;
				END_IF
			ELSIF fbReadParID.Error THEN
				uiStep					:= 900;
			END_IF
	
		(**************************** CONFIGURE CROSSLINK ****************************)
		200:(* CONFIGURE CROSSLINK SOURCE AXIS *)
			IF NOT fbWriteParID.Execute THEN
				uiTemp						:= i_pstSrcAxis.nc_obj_inf.nc_obj_idx + 1;
			
				fbWriteParID.Axis			:= ADR(i_pstEncEmulAxis);
				fbWriteParID.DataAddress 	:= ADR(uiTemp);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_CROSSLINK_AXIS;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CROSSLINK_AXIS THEN
				fbWriteParID.Execute	:= FALSE;
				uiStep					:= 210;
			ELSIF fbWriteParID.Error THEN
				uiStep					:= 900;
			END_IF
	
		210:(* CONFIGURE CROSSLINK PARID <- PCTRL_S_SET / S_SET_VAX1 *)
			IF NOT fbWriteParID.Execute THEN
				IF i_pstSrcAxis.nc_obj_inf.nc_obj_typ = ncAXIS THEN
					uiTemp		:= ACP10PAR_PCTRL_S_SET;	//REAL AXIS
				ELSE
					uiTemp		:= ACP10PAR_S_SET_VAX1;		//VIRTUAL AXIS
				END_IF
			
				fbWriteParID.Axis			:= ADR(i_pstEncEmulAxis);
				fbWriteParID.DataAddress 	:= ADR(uiTemp);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_CROSSLINK_PARID;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_CROSSLINK_PARID THEN
				fbWriteParID.Execute	:= FALSE;
				uiEncodOutParID			:= ACP10PAR_CROSSLINK_PARID;
				IF i_xEnable THEN
					uiStep	:= 250;
				ELSE
					uiStep	:= 400;
				END_IF 
			ELSIF fbWriteParID.Error THEN
				uiStep					:= 900;
			END_IF
		
		250:(* ENABLE ENCODER EMULATOR OUTPUT *)
			IF NOT fbWriteParID.Execute THEN
				fbWriteParID.Axis			:= ADR(i_pstEncEmulAxis);
				fbWriteParID.DataAddress 	:= ADR(uiEncodOutParID);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_ENCOD_OUT_PARID;
				fbWriteParID.Execute		:= TRUE;
			END_IF
			
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_ENCOD_OUT_PARID THEN
				fbWriteParID.Execute	:= FALSE;
				uiStep					:= 300;
			ELSIF fbWriteParID.Error THEN
				uiStep					:= 900;
			END_IF
		
		300:(* READY *)
			fbAxisError.Enable	:= TRUE;
			q_xActive			:= TRUE;

			IF NOT i_xEnable THEN
				uiStep			:= 400;
			END_IF
		
		400:(* DISABLE OUTPUT *)
			//fbAxisError.Enable	:= FALSE; //V4.A.A.1.6.13
			
			IF NOT fbWriteParID.Execute THEN
				uiTemp						:= 0;
	
				fbWriteParID.Axis			:= ADR(i_pstEncEmulAxis);
				fbWriteParID.DataAddress 	:= ADR(uiTemp);
				fbWriteParID.DataType		:= ncPAR_TYP_UINT;
				fbWriteParID.ParID			:= ACP10PAR_ENCOD_OUT_PARID;
				fbWriteParID.Execute		:= TRUE;
			END_IF
	
			IF fbWriteParID.Done AND fbWriteParID.ParID = ACP10PAR_ENCOD_OUT_PARID THEN
				fbWriteParID.Execute	:= FALSE;
				q_xActive 				:= FALSE;
				uiStep	:= 410;
			END_IF	
		
		410: (* OUTPUT DISABLED *)
			IF i_xEnable THEN
				uiStep	:= 250;
			END_IF
	
		(********************************************)
		800:(* CYCLIC COMMUNICATION ERROR *)
			q_xError 		:= TRUE;
			q_uiErrorID		:= usiErrCode;
			IF i_xErrorReset THEN
				q_xError 	:= FALSE;
				q_uiErrorID := 0;
				uiStep		:= 0;
			END_IF
		
		900:(* FUNCTION BLOCKS ERROR *)
			q_xError 		:= TRUE;
			q_uiErrorID 	:= fbWriteParID.ErrorID + fbReadParID.ErrorID + fbWriteParID_Text.ErrorID;
			
			fbWriteParID.Execute 	:= FALSE;
			fbReadParID.Execute 	:= FALSE;
			
			IF i_xErrorReset THEN
				IF fbWriteParID.Error THEN
					fbWriteParID.Execute := FALSE;
				END_IF
				IF fbReadParID.Error THEN
					fbReadParID.Execute := FALSE;
				END_IF
				IF fbWriteParID_Text.Error THEN
					fbReadParID.Execute := FALSE;
				END_IF
			END_IF
		
			IF NOT fbWriteParID.Error AND NOT fbReadParID.Error AND NOT fbWriteParID_Text.Error THEN
				q_xError 		:= FALSE;
				q_uiErrorID 	:= 0;
				uiStep			:= 0;
			END_IF
	
		950:
			fbWriteParID.Execute 	:= FALSE;
			fbReadParID.Execute 	:= FALSE;
			
			q_xError 		:= TRUE;
			q_uiErrorID		:= 60000;
			IF i_pstEncEmulAxis.network.phase  = 90 THEN
				uiStep	:= 0;
			END_IF
	
		960:
			fbWriteParID.Execute 	:= FALSE;
			fbReadParID.Execute 	:= FALSE;
			
			q_xError 	:= TRUE;
			q_uiErrorID	:= 60010;
	
			IF i_xErrorReset THEN
				fbAxisError.Enable	:= FALSE;
			END_IF
			
			IF NOT fbAxisError.Error THEN
				uiStep	:= 0;
			END_IF
		
		
		970:
			q_xError 	:= TRUE;
			q_uiErrorID	:= 60020;
			
			fbWriteParID.Execute 	:= FALSE;
			fbReadParID.Execute 	:= FALSE;

			//fbAxisError.Acknowledge	:= i_xErrorReset; //V4.A.A.1.6.13
			
			IF NOT(fbAxisError.FunctionBlockErrorCount > 0 OR fbAxisError.AxisErrorCount > 0) THEN
				//fbAxisError.Enable	:= FALSE; //V4.A.A.1.6.13
				uiStep	:= 0;
			END_IF
	END_CASE
	
	(* Acknowledge Error *)
	fbAxisError.Acknowledge	:= i_xErrorReset;
	
	fbAxisError();
	fbReadParID();
	fbWriteParID_Text();
	fbWriteParID();	
END_FUNCTION_BLOCK