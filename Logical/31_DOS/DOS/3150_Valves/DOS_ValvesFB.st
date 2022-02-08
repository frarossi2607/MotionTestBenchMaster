ACTION DOS_ValvesFB:

//AVJ201
	AVJ[201](
	IN_ConfigPresent 	:= AVJ[201].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[201].IN_Enable, 
	IN_AutoCnd 			:= AVJ[201].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[201].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[201].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[201].IN_ManEn, 
	IN_MaskEn 			:= AVJ[201].IN_MaskEn, 
	IO 					:= IO_AVJ[201], 
	HMI 				:= HMI_AVJ[201]
	);

//AVJ210
	AVJ[210](
	IN_ConfigPresent 	:= AVJ[210].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[210].IN_Enable, 
	IN_AutoCnd 			:= AVJ[210].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[210].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[210].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[210].IN_ManEn, 
	IN_MaskEn 			:= AVJ[210].IN_MaskEn, 
	IO 					:= IO_AVJ[210], 
	HMI 				:= HMI_AVJ[210]
	);

//AVJ211
	AVJ[211](
	IN_ConfigPresent 	:= AVJ[211].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[211].IN_Enable, 
	IN_AutoCnd 			:= AVJ[211].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[211].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[211].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[211].IN_ManEn, 
	IN_MaskEn 			:= AVJ[211].IN_MaskEn, 
	IO 					:= IO_AVJ[211], 
	HMI 				:= HMI_AVJ[211]
	);

//AVJ212
	AVJ[212](
	IN_ConfigPresent 	:= AVJ[212].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[212].IN_Enable, 
	IN_AutoCnd 			:= AVJ[212].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[212].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[212].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[212].IN_ManEn, 
	IN_MaskEn 			:= AVJ[212].IN_MaskEn, 
	IO 					:= IO_AVJ[212], 
	HMI 				:= HMI_AVJ[212]
	);

//AVJ215
	AVJ[215](
	IN_ConfigPresent 	:= AVJ[215].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[215].IN_Enable, 
	IN_AutoCnd 			:= AVJ[215].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[215].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[215].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[215].IN_ManEn, 
	IN_MaskEn 			:= AVJ[215].IN_MaskEn, 
	IO 					:= IO_AVJ[215], 
	HMI 				:= HMI_AVJ[215]
	);

//AVJ216
	AVJ[216](
	IN_ConfigPresent 	:= AVJ[216].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[216].IN_Enable, 
	IN_AutoCnd 			:= AVJ[216].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[216].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[216].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[216].IN_ManEn, 
	IN_MaskEn 			:= AVJ[216].IN_MaskEn, 
	IO 					:= IO_AVJ[216], 
	HMI 				:= HMI_AVJ[216]
	);

//AVJ217
	AVJ[217](
	IN_ConfigPresent 	:= AVJ[217].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[217].IN_Enable, 
	IN_AutoCnd 			:= AVJ[217].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[217].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[217].IN_Cnd, 
	IN_FlipEnable 		:= AVJ[217].IN_FlipEnable, 
	IN_FlipRequest		:= AVJ[217].IN_FlipRequest, 
	IN_FlipTime 		:= AVJ[217].IN_FlipTime, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[217].IN_ManEn, 
	IN_MaskEn 			:= AVJ[217].IN_MaskEn, 
	IO 					:= IO_AVJ[217], 
	HMI 				:= HMI_AVJ[217]
	);

//AVJ218
	AVJ[218](
	IN_ConfigPresent 	:= AVJ[218].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[218].IN_Enable, 
	IN_AutoCnd 			:= AVJ[218].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[218].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[218].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[218].IN_ManEn, 
	IN_MaskEn 			:= AVJ[218].IN_MaskEn, 
	IO 					:= IO_AVJ[218], 
	HMI 				:= HMI_AVJ[218]
	);
	
//AVJ221
	AVJ[221](
	IN_ConfigPresent 	:= AVJ[221].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[221].IN_Enable, 
	IN_AutoCnd 			:= AVJ[221].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[221].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[221].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[221].IN_ManEn, 
	IN_MaskEn 			:= AVJ[221].IN_MaskEn, 
	IO 					:= IO_AVJ[221], 
	HMI 				:= HMI_AVJ[221]
	);

//AVJ230
	AVJ[230](
	IN_ConfigPresent 	:= AVJ[230].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[230].IN_Enable, 
	IN_AutoCnd 			:= AVJ[230].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[230].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[230].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[230].IN_ManEn, 
	IN_MaskEn 			:= AVJ[230].IN_MaskEn, 
	IO 					:= IO_AVJ[230], 
	HMI 				:= HMI_AVJ[230]
	);
	
//AVJ231
	AVJ[231](
	IN_ConfigPresent 	:= AVJ[231].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[231].IN_Enable, 
	IN_AutoCnd 			:= AVJ[231].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[231].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[231].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[231].IN_ManEn, 
	IN_MaskEn 			:= AVJ[231].IN_MaskEn, 
	IO 					:= IO_AVJ[231], 
	HMI 				:= HMI_AVJ[231]
	);
	
//AVJ232
	AVJ[232](
	IN_ConfigPresent 	:= AVJ[232].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[232].IN_Enable, 
	IN_AutoCnd 			:= AVJ[232].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[232].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[232].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[232].IN_ManEn, 
	IN_MaskEn 			:= AVJ[232].IN_MaskEn, 
	IO 					:= IO_AVJ[232], 
	HMI 				:= HMI_AVJ[232]
	);
	
//AVJ233
	AVJ[233](
	IN_ConfigPresent 	:= AVJ[233].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[233].IN_Enable, 
	IN_AutoCnd 			:= AVJ[233].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[233].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[233].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[233].IN_ManEn, 
	IN_MaskEn 			:= AVJ[233].IN_MaskEn, 
	IO 					:= IO_AVJ[233], 
	HMI 				:= HMI_AVJ[233]
	);
	
//AVJ234
	AVJ[234](
	IN_ConfigPresent 	:= AVJ[234].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[234].IN_Enable, 
	IN_AutoCnd 			:= AVJ[234].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[234].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[234].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[234].IN_ManEn, 
	IN_MaskEn 			:= AVJ[234].IN_MaskEn, 
	IO 					:= IO_AVJ[234], 
	HMI 				:= HMI_AVJ[234]
	);
	
//AVJ235
	AVJ[235](
	IN_ConfigPresent 	:= AVJ[235].IN_ConfigPresent, 
	IN_Enable 			:= AVJ[235].IN_Enable, 
	IN_AutoCnd 			:= AVJ[235].IN_AutoCnd, 
	IN_EnableCnd 		:= AVJ[235].IN_EnableCnd, 
	IN_Cnd 				:= AVJ[235].IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= AVJ[235].IN_ManEn, 
	IN_MaskEn 			:= AVJ[235].IN_MaskEn, 
	IO 					:= IO_AVJ[235], 
	HMI 				:= HMI_AVJ[235]
	);
	
	//VALVES STATUS CONTROL
	VAR_DOS_InletOpen	:= AVJ[201].IN_ConfigPresent AND AVJ[201].OUT_OpenedFiltered;

	VAR_DOS_LoopOpen 	:= AVJ[221].OUT_ClosedFiltered AND AVJ[221].IN_ConfigPresent; //Normaly open

	VAR_DOS_ReturnOpen	:= AVJ[218].IN_ConfigPresent AND AVJ[218].OUT_OpenedFiltered;
	
	//VALVE FAULT
	VAR_DOS_AVJ_ValveFault	:= FALSE;
	
	FOR VAR_DOS_ForIndex := MIN_CFG_AVx TO MAX_CFG_AVx DO
		IF AVJ[VAR_DOS_ForIndex].IN_ConfigPresent AND AVJ[VAR_DOS_ForIndex].OUT_Alarm THEN
			VAR_DOS_AVJ_ValveFault	:= TRUE;
		END_IF
	END_FOR
	//INLET CLOSE DUE TO A FAULT
	TMR_TON_InletSafetyDelay.IN := VAR_DOS_AVJ_ValveFault;									
	TMR_TON_InletSafetyDelay.PT := T#2s;
	TMR_TON_InletSafetyDelay();
	
//	VAR_DOS_ProductInletSafety		:= TMR_TON_InletSafetyDelay.IN;
//	VAR_DOS_ProductInletSafetyDelay	:= TMR_TON_InletSafetyDelay.Q AND AVB[223].OUT_ClosedFiltered;
	
//RVJ201
		RVJ[201].IN_AutoVal 			:= FB_PID_RVJ201[PID_MODE_PRD].OUT;
	
		RVJ[201](
		IN_ConfigPresent				:= RVJ[201].IN_ConfigPresent, 
		IN_Enable 						:= RVJ[201].IN_Enable, 
		IN_AutoCnd 						:= RVJ[201].IN_AutoCnd, 
		IN_AutoVal 						:= RVJ[201].IN_AutoVal, 
		IN_OpeningRampEn 				:= FALSE, 
		IN_OpeningRampValue 			:= 0.0, 
		IN_ClosingRampEn 				:= OPS.DataOut.EmergencyOk, 
		IN_ClosingRampValue 			:= 10.0, 
		IN_OutMin 						:= 0.0,
		IN_OutMax 						:= 100.0, //FAI PAM
		IN_HMIAutoForce 				:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
		IN_ManEn 						:= TRUE, 
		IN_MaskEn 						:= RVJ[201].IN_MaskEn, 
		IN_Reset 						:= VAR_DOS_PBResetEp, 
		IO 								:= IO_RVJ[201], 
		HMI 							:= HMI_RVJ[201]
	);	
	
//PDO_YV65 FILIPPO
	PDO_YV65(
	IN_ConfigPresent 	:= PDO_YV65.IN_ConfigPresent, 
	IN_Enable 			:= PDO_YV65.IN_Enable, 
	IN_AutoCnd 			:= PDO_YV65.IN_AutoCnd, 
	IN_EnableCnd 		:= PDO_YV65.IN_EnableCnd, 
	IN_Cnd 				:= PDO_YV65.IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= PDO_YV65.IN_ManEn, 
	IN_MaskEn 			:= PDO_YV65.IN_MaskEn, 
	IO 					:= IO_PDO_YV65, 
	HMI 				:= HMI_PDO_YV65
	);

	//PDO_YV5 _211CPF
	_211CPF(
	IN_ConfigPresent 	:= _211CPF.IN_ConfigPresent, 
	IN_Enable 			:= _211CPF.IN_Enable, 
	IN_AutoCnd 			:= _211CPF.IN_AutoCnd, 
	IN_EnableCnd 		:= _211CPF.IN_EnableCnd, 
	IN_Cnd 				:= _211CPF.IN_Cnd, 
	IN_FlipEnable 		:= FALSE, 
	IN_FlipRequest		:= FALSE, 
	IN_FlipTime 		:= T#500ms, 
	IN_Reset 			:= VAR_DOS_PBResetEp,
	IN_HMIAutoForce 	:= NOT HMI_SS2P[SS2P_HMI_DeviceEnable].ON,
	IN_ManEn 			:= VAR_DOS_MMF205.SensorHighPos AND VAR_DOS_MMF206.SensorHighPos, 
	IN_MaskEn 			:= _211CPF.IN_MaskEn, 
	IO 					:= IO_211CPF, 
	HMI 				:= HMI_211CPF	
	);
	
	//Batteria 209PUF
	IO_209PUF_1.0 := IO_211CPF.DO_Closed;	//DO-02
	IO_209PUF_1.1 := IO_211CPF.DO_Opened;	//DO-01
	IO_209PUF_1.2 := FALSE;					//DO-04  
	IO_209PUF_1.3 := FALSE;					//DO-03  
	IO_209PUF_1.4 := IO_AVJ[210].DO_Opened;	//DO-06
	IO_209PUF_1.5 := IO_AVJ[201].DO_Opened; //DO-05  
	IO_209PUF_1.6 := IO_AVJ[217].DO_Opened;	//DO-08
	IO_209PUF_1.7 := IO_AVJ[211].DO_Opened;	//DO-07
	
	IO_209PUF_2.0 := IO_AVJ[235].DO_Opened;	//DO-10
	IO_209PUF_2.1 := IO_AVJ[230].DO_Opened;	//DO-09
	IO_209PUF_2.2 := FALSE;					//DO-12
	IO_209PUF_2.3 := FALSE;					//DO-11
	IO_209PUF_2.4 := FALSE;					//DO-14
	IO_209PUF_2.5 := FALSE;					//DO-13
	IO_209PUF_2.6 := IO_AVJ[216].DO_Opened;	//DO-16
	IO_209PUF_2.7 := IO_AVJ[215].DO_Opened;	//DO-15
	
	IO_209PUF_3.0 := IO_AVJ[232].DO_Opened;	//DO-18
	IO_209PUF_3.1 := IO_AVJ[231].DO_Opened;	//DO-17
	IO_209PUF_3.2 := IO_AVJ[234].DO_Opened; //DO-20
	IO_209PUF_3.3 := IO_AVJ[233].DO_Opened;	//DO-19
	IO_209PUF_3.4 := FALSE;					//DO-22
	IO_209PUF_3.5 := FALSE;					//DO-21
	IO_209PUF_3.6 := FALSE;					//DO-24
	IO_209PUF_3.7 := FALSE;					//DO-23


END_ACTION
