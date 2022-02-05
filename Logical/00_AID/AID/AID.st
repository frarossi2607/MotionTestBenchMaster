PROGRAM _CYCLIC
	FB_GetTime(enable := TRUE);
	FB_GetUtcTime(enable := TRUE);
	
	FB_Blink_05Hz(IN_Freq := 0.5);
	AID.DataOut.Blink05Hz	:= FB_Blink_05Hz.OUT;
	
	FB_Blink_1Hz(IN_Freq := 1.0);
	AID.DataOut.Blink1Hz	:= FB_Blink_1Hz.OUT;
	
	FB_Blink_2Hz(IN_Freq := 2.0);
	AID.DataOut.Blink2Hz	:= FB_Blink_2Hz.OUT;
	
	AID.DataOut.NetBlinkSlow	:= AID.DataOut.Blink1Hz;
	AID.DataOut.NetBlinkFast	:= AID.DataOut.Blink2Hz;
END_PROGRAM