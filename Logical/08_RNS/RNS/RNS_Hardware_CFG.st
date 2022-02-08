ACTION RNS_Hardware_CFG: 
	(*****MACHINE*****)

	(*****DIGITAL*****)
	FSB[201].IN_ConfigPresent 	:= TRUE;
	FSB[201].IN_OnDelay			:= T#5ms;
	FSB[201].IN_OffDelay		:= T#25s;
	
	FSB[220].IN_ConfigPresent 	:= TRUE;
	FSB[220].IN_OnDelay			:= T#1s;
	FSB[220].IN_OffDelay		:= T#5s;

	(*****VALVES*****)	
	AVB[224].IN_ConfigPresent				:= TRUE;
	AVB[224].IN_ConfigType 					:= 0;
	AVB[224].IN_Simulation 					:= FALSE; 
	AVB[224].IN_ConfigPositionSensorOpened 	:= TRUE; 
	AVB[224].IN_ConfigPositionSensorClosed 	:= TRUE; 
	AVB[224].IN_StrokeTime 					:= T#5s;
	
	AVB[228].IN_ConfigPresent				:= TRUE;
	AVB[228].IN_ConfigType 					:= 0;
	AVB[228].IN_Simulation 					:= FALSE; 
	AVB[228].IN_ConfigPositionSensorOpened 	:= TRUE;
	AVB[228].IN_ConfigPositionSensorClosed 	:= TRUE; 
	AVB[228].IN_StrokeTime 					:= T#2s;

	AVB[234].IN_ConfigPresent				:= TRUE;
	AVB[234].IN_ConfigType 					:= 0;
	AVB[234].IN_Simulation 					:= FALSE; 
	AVB[234].IN_ConfigPositionSensorOpened 	:= TRUE;
	AVB[234].IN_ConfigPositionSensorClosed 	:= TRUE; 
	AVB[234].IN_StrokeTime 					:= T#2s;	
		
	AVB[261].IN_ConfigPresent				:= TRUE;
	AVB[261].IN_ConfigType 					:= 0;
	AVB[261].IN_Simulation 					:= FALSE; 
	AVB[261].IN_ConfigPositionSensorOpened 	:= TRUE;
	AVB[261].IN_ConfigPositionSensorClosed 	:= TRUE; 
	AVB[261].IN_StrokeTime 					:= T#2s;
	
	AVB[264].IN_ConfigPresent				:= TRUE;
	AVB[264].IN_ConfigType 					:= 0;
	AVB[264].IN_Simulation 					:= FALSE; 
	AVB[264].IN_ConfigPositionSensorOpened 	:= TRUE; 
	AVB[264].IN_ConfigPositionSensorClosed 	:= TRUE; 
	AVB[264].IN_StrokeTime 					:= T#5s;
	
	AVB[265].IN_ConfigPresent				:= FALSE;
	AVB[265].IN_ConfigType 					:= 0;
	AVB[265].IN_Simulation 					:= FALSE; 
	AVB[265].IN_ConfigPositionSensorOpened 	:= TRUE; 
	AVB[265].IN_ConfigPositionSensorClosed 	:= TRUE; 
	AVB[265].IN_StrokeTime 					:= T#4s;
	
	AVB[266].IN_ConfigPresent				:= FALSE;
	AVB[266].IN_ConfigType 					:= 0;
	AVB[266].IN_Simulation 					:= FALSE; 
	AVB[266].IN_ConfigPositionSensorOpened 	:= TRUE; 
	AVB[266].IN_ConfigPositionSensorClosed 	:= TRUE; 
	AVB[266].IN_StrokeTime 					:= T#2s;
	
	AVB[267].IN_ConfigPresent				:= TRUE;
	AVB[267].IN_ConfigType 					:= 0;
	AVB[267].IN_Simulation 					:= FALSE; 
	AVB[267].IN_ConfigPositionSensorOpened 	:= TRUE; 
	AVB[267].IN_ConfigPositionSensorClosed 	:= TRUE; 
	AVB[267].IN_StrokeTime 					:= T#2s;
	
	AVB[268].IN_ConfigPresent				:= TRUE;
	AVB[268].IN_ConfigType 					:= 0;
	AVB[268].IN_Simulation 					:= FALSE; 
	AVB[268].IN_ConfigPositionSensorOpened 	:= TRUE;
	AVB[268].IN_ConfigPositionSensorClosed 	:= TRUE; 
	AVB[268].IN_StrokeTime 					:= T#2s;
	
	AVB[273].IN_ConfigPresent				:= FALSE;
	AVB[273].IN_ConfigType 					:= 0;
	AVB[273].IN_Simulation 					:= FALSE; 
	AVB[273].IN_ConfigPositionSensorOpened 	:= FALSE; 
	AVB[273].IN_ConfigPositionSensorClosed 	:= FALSE; 
	AVB[273].IN_StrokeTime 					:= T#2s;
	
	AVB[294].IN_ConfigPresent				:= TRUE;//vrma
	AVB[294].IN_ConfigType 					:= 0;
	AVB[294].IN_Simulation 					:= FALSE; 
	AVB[294].IN_ConfigPositionSensorOpened 	:= TRUE; 
	AVB[294].IN_ConfigPositionSensorClosed 	:= TRUE; 
	AVB[294].IN_StrokeTime 					:= T#2s;
	
	(*****PUMPS*****)
	PPB[209].IN_ConfigPresent	:= TRUE;
	PPB[209].IN_Reverse			:= FALSE;
	
	(*****ANALOG*****)
	FTB[201].IN_ConfigPresent 	:= FALSE;
	FTB[201].IN_Simulation 		:= FALSE;
	FTB[201].IN_0_20mA 			:= TRUE;
	FTB[201].IN_ConfigPopup		:= TRUE;
	FTB[201].IN_FaultOutMode 	:= 0;
	FTB[201].IN_EngScale 		:= FALSE;
	FTB[201].IN_ScaleLOW		:= 0.0;
	FTB[201].IN_ScaleHIGH		:= 800.0;
	
	FTB[202].IN_ConfigPresent 	:= TRUE;
	FTB[202].IN_Simulation 		:= FALSE;
	FTB[202].IN_0_20mA 			:= TRUE;
	FTB[202].IN_ConfigPopup		:= TRUE;
	FTB[202].IN_FaultOutMode 	:= 0;
	FTB[202].IN_EngScale 		:= FALSE;
	FTB[202].IN_ScaleLOW		:= 0.0;
	FTB[202].IN_ScaleHIGH		:= 400.0;
	
	PTB[220].IN_ConfigPresent 	:= TRUE;
	PTB[220].IN_Simulation 		:= FALSE;
	PTB[220].IN_0_20mA 			:= TRUE;
	PTB[220].IN_ConfigPopup		:= TRUE;
	PTB[220].IN_FaultOutMode 	:= 0;
	PTB[220].IN_EngScale 		:= FALSE;
	PTB[220].IN_ScaleLOW		:= -1.0;
	PTB[220].IN_ScaleHIGH		:= 10.0;
	
	PTB[270].IN_ConfigPresent 	:= FALSE;
	PTB[270].IN_Simulation 		:= FALSE;
	PTB[270].IN_0_20mA 			:= TRUE;
	PTB[270].IN_ConfigPopup		:= TRUE;
	PTB[270].IN_FaultOutMode 	:= 0;
	PTB[270].IN_EngScale 		:= FALSE;
	PTB[270].IN_ScaleLOW		:= -1.0;
	PTB[270].IN_ScaleHIGH		:= 10.0;
	
	PTB[290].IN_ConfigPresent 	:= TRUE;//vrma
	PTB[290].IN_Simulation 		:= FALSE;
	PTB[290].IN_0_20mA 			:= TRUE;
	PTB[290].IN_ConfigPopup		:= TRUE;
	PTB[290].IN_FaultOutMode 	:= 0;
	PTB[290].IN_EngScale 		:= FALSE;
	PTB[290].IN_ScaleLOW		:= -1.0;
	PTB[290].IN_ScaleHIGH		:= 10.0;

	
	LTB[202].IN_ConfigPresent 	:= TRUE;//vrma
	LTB[202].IN_Simulation 		:= FALSE;
	LTB[202].IN_0_20mA 			:= TRUE;
	LTB[202].IN_ConfigPopup		:= TRUE;
	LTB[202].IN_FaultOutMode 	:= 0;
	LTB[202].IN_EngScale 		:= FALSE;
	LTB[202].IN_ScaleLOW		:= 0.0;
	LTB[202].IN_ScaleHIGH		:= 100.0;
	
END_ACTION
