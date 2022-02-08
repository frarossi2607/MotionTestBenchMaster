ACTION RNS_ValvesFB:
//AVB224 RINSER DISCHARGE
	AVB[224](
	IN_ConfigPresent 	:= AVB[224].IN_ConfigPresent, 
	IN_Enable 			:= AVB[224].IN_Enable, 
	IN_AutoCnd 			:= AVB[224].IN_AutoCnd, 
	IN_EnableCnd 		:= AVB[224].IN_EnableCnd, 
	IN_Cnd 				:= AVB[224].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVB[224].IN_ManEn, 
	IN_MaskEn 			:= AVB[224].IN_MaskEn, 
	IO 					:= IO_AVB[224], 
	HMI 				:= HMI_AVB[224]
	);
	
	//AVB228 H2O EXTERNAL RINSING VALVE 
	AVB[228](
	IN_ConfigPresent 	:= AVB[228].IN_ConfigPresent, 
	IN_Enable 			:= AVB[228].IN_Enable, 
	IN_AutoCnd 			:= AVB[228].IN_AutoCnd, 
	IN_EnableCnd 		:= AVB[228].IN_EnableCnd, 
	IN_Cnd 				:= AVB[228].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVB[228].IN_ManEn, 
	IN_MaskEn 			:= AVB[228].IN_MaskEn, 
	IO 					:= IO_AVB[228], 
	HMI 				:= HMI_AVB[228]
	);
	
	//AVB234 TWIST COOLING DRAIN        
	AVB[234](//VRMA
	IN_ConfigPresent          := AVB[234].IN_ConfigPresent, 
	IN_Enable                 := AVB[234].IN_Enable, 
	IN_AutoCnd                := AVB[234].IN_AutoCnd, 
	IN_EnableCnd              := AVB[234].IN_EnableCnd, 
	IN_Cnd                    := AVB[234].IN_Cnd, 
	IN_FlipEnable             := FALSE, 
	IN_FlipRequest            := FALSE, 
	IN_FlipTime               := T#500ms, 
	IN_Reset                  := VAR_RNS_PBResetEp,
	IN_HMIAutoForce           := NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn                  := AVB[234].IN_ManEn, 
	IN_MaskEn                 := AVB[234].IN_MaskEn, 
	IO                        := IO_AVB[234], 
	HMI                       := HMI_AVB[234]);
	
	//AVB261 H2O RINSING VALVE
	AVB[261](
	IN_ConfigPresent 	:= AVB[261].IN_ConfigPresent, 
	IN_Enable 			:= AVB[261].IN_Enable, 
	IN_AutoCnd 			:= AVB[261].IN_AutoCnd, 
	IN_EnableCnd 		:= AVB[261].IN_EnableCnd, 
	IN_Cnd 				:= AVB[261].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVB[261].IN_ManEn, 
	IN_MaskEn 			:= AVB[261].IN_MaskEn, 
	IO 					:= IO_AVB[261], 
	HMI 				:= HMI_AVB[261]
	);
	
	//AVB264 RINSING CIP VALVE //V4.A.A.1.7.0
	AVB[264](
	IN_ConfigPresent 	:= AVB[264].IN_ConfigPresent, 
	IN_Enable 			:= AVB[264].IN_Enable, 
	IN_AutoCnd 			:= AVB[264].IN_AutoCnd, 
	IN_EnableCnd 		:= AVB[264].IN_EnableCnd, 
	IN_Cnd 				:= AVB[264].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVB[264].IN_ManEn, 
	IN_MaskEn 			:= AVB[264].IN_MaskEn, 
	IO 					:= IO_AVB[264], 
	HMI 				:= HMI_AVB[264]
	);
	
	//AVB265 RINSING CIP VALVE //V4.A.A.1.7.0
	AVB[265](
	IN_ConfigPresent 	:= AVB[265].IN_ConfigPresent, 
	IN_Enable 			:= AVB[265].IN_Enable, 
	IN_AutoCnd 			:= AVB[265].IN_AutoCnd, 
	IN_EnableCnd 		:= AVB[265].IN_EnableCnd, 
	IN_Cnd 				:= AVB[265].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVB[265].IN_ManEn, 
	IN_MaskEn 			:= AVB[265].IN_MaskEn, 
	IO 					:= IO_AVB[265], 
	HMI 				:= HMI_AVB[265]
	);
	
	//AVB266 RINSING CIP VALVE //V4.A.A.1.7.0
	AVB[266](
	IN_ConfigPresent 	:= AVB[266].IN_ConfigPresent, 
	IN_Enable 			:= AVB[266].IN_Enable, 
	IN_AutoCnd 			:= AVB[266].IN_AutoCnd, 
	IN_EnableCnd 		:= AVB[266].IN_EnableCnd, 
	IN_Cnd 				:= AVB[266].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVB[266].IN_ManEn, 
	IN_MaskEn 			:= AVB[266].IN_MaskEn, 
	IO 					:= IO_AVB[266], 
	HMI 				:= HMI_AVB[266]
	);
	
	//AVB267 CIP To DRAIN v1.4
	AVB[267](
	IN_ConfigPresent 	:= AVB[267].IN_ConfigPresent, 
	IN_Enable 			:= AVB[267].IN_Enable, 
	IN_AutoCnd 			:= AVB[267].IN_AutoCnd, 
	IN_EnableCnd 		:= AVB[267].IN_EnableCnd, 
	IN_Cnd 				:= AVB[267].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVB[267].IN_ManEn, 
	IN_MaskEn 			:= AVB[267].IN_MaskEn, 
	IO 					:= IO_AVB[267], 
	HMI 				:= HMI_AVB[267]
	);
	
	//AVB268 CIP/COP To DRAIN v1.4	
	AVB[268](
	IN_ConfigPresent 	:= AVB[268].IN_ConfigPresent, 
	IN_Enable 			:= AVB[268].IN_Enable, 
	IN_AutoCnd 			:= AVB[268].IN_AutoCnd, 
	IN_EnableCnd 		:= AVB[268].IN_EnableCnd, 
	IN_Cnd 				:= AVB[268].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVB[268].IN_ManEn, 
	IN_MaskEn 			:= AVB[268].IN_MaskEn, 
	IO 					:= IO_AVB[268], 
	HMI 				:= HMI_AVB[268]
	);		
	
	//AVB273 AIR RINSING VALVE	V4.A.A.1.7.0
	AVB[273](
	IN_ConfigPresent 	:= AVB[273].IN_ConfigPresent, 
	IN_Enable 			:= AVB[273].IN_Enable, 
	IN_AutoCnd 			:= AVB[273].IN_AutoCnd, 
	IN_EnableCnd 		:= AVB[273].IN_EnableCnd, 
	IN_Cnd 				:= AVB[273].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVB[273].IN_ManEn, 
	IN_MaskEn 			:= AVB[273].IN_MaskEn, 
	IO 					:= IO_AVB[273], 
	HMI 				:= HMI_AVB[273]
	);
	
	//AVB294 vrma
	AVB[294](
	IN_ConfigPresent 	:= AVB[294].IN_ConfigPresent, 
	IN_Enable 			:= AVB[294].IN_Enable, 
	IN_AutoCnd 			:= AVB[294].IN_AutoCnd, 
	IN_EnableCnd 		:= AVB[294].IN_EnableCnd, 
	IN_Cnd 				:= AVB[294].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_RNS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVB[294].IN_ManEn, 
	IN_MaskEn 			:= AVB[294].IN_MaskEn, 
	IO 					:= IO_AVB[294], 
	HMI 				:= HMI_AVB[294]
	);
	
	//VALVES STATUS CONTROL
	VAR_RNS_InletOpen				:= (AVB[261].IN_ConfigPresent AND AVB[261].OUT_OpenedFiltered) AND (AVB[261].OUT_OpenedFiltered OR NOT AVB[261].IN_ConfigPresent);
		
	VAR_RNS_InletProductIncoming 	:= (AVB[264].OUT_OpenedFiltered OR NOT AVB[264].IN_ConfigPresent) AND VAR_RNS_InletOpen;
	
	//VALVE FAULT
	VAR_RNS_AVB_ValveFault	:= FALSE;
	
	FOR VAR_RNS_ForIndex:= MIN_CFG_AVx TO MAX_CFG_AVx DO
		IF AVB[VAR_RNS_ForIndex].IN_ConfigPresent AND AVB[VAR_RNS_ForIndex].OUT_Alarm THEN
			VAR_RNS_AVB_ValveFault	:= TRUE;
		END_IF
	END_FOR
		
	//INLET CLOSE DUE TO A FAULT
	TMR_TON_InletSafetyDelay.IN := ALR[1512].Active;
	TMR_TON_InletSafetyDelay.PT := T#2s;
	TMR_TON_InletSafetyDelay();
	
	VAR_RNS_ProductInletSafety		:= TMR_TON_InletSafetyDelay.IN;
	VAR_RNS_ProductInletSafetyDelay	:= TMR_TON_InletSafetyDelay.Q AND AVB[223].OUT_ClosedFiltered;
	
		
	//Batteria 203PUB
	IO_203PUB_1.0 := IO_AVB[228].DO_Opened; //DO-02
	IO_203PUB_1.1 := IO_AVB[224].DO_Opened; //DO-01
	IO_203PUB_1.2 := IO_AVB[261].DO_Opened;	//DO-04  
	IO_203PUB_1.3 := IO_AVB[234].DO_Opened; //DO-03  
	IO_203PUB_1.4 := IO_AVB[268].DO_Opened;	//DO-06
	IO_203PUB_1.5 := IO_AVB[267].DO_Opened;	//DO-05  
	IO_203PUB_1.6 := IO_AVB[264].DO_Opened;	//DO-08
	IO_203PUB_1.7 := IO_AVB[294].DO_Opened;	//DO-07
	
	IO_203PUB_2.0 := FALSE;					//DO-10
	IO_203PUB_2.1 := FALSE;					//DO-09
	IO_203PUB_2.2 := FALSE;					//DO-12
	IO_203PUB_2.3 := FALSE;					//DO-11
	IO_203PUB_2.4 := FALSE;					//DO-14
	IO_203PUB_2.5 := FALSE;					//DO-13
	IO_203PUB_2.6 := FALSE;					//DO-16
	IO_203PUB_2.7 := FALSE;					//DO-15
	
END_ACTION
