
FUNCTION_BLOCK TankMultiScale
	IF IN_ProbeLength_mm = 0.0 OR IN_TNK_Diameter_mm = 0.0 THEN
		RETURN;
	END_IF

	//Index [0]: level in percentage
	//Index [1]: volume in liters
	//Index [2]: height in mm
	//Index [3]: HMI_PAR_2._309
	
	pi 			:= 3.14; 
	diameter_cm	:= IN_TNK_Diameter_mm / 10.0; 	// [cm]
	r_cm  		:= diameter_cm / 2.0;			// [cm]
	
	heightTot_cm		:= IN_ProbeLength_mm / 10.0; 	// [cm]
	volumeTot_cm3 		:= (pi * r_cm * r_cm) * heightTot_cm;	// [cm3]
	volumeTot_liters 	:= volumeTot_cm3 / 1000;			// [dm3]/[l]
	
	heightAck_cm		:= IN_ProbeLength_mm / 10.0 * IN_TNK_PV / 100.0;	// [cm]
	volumeAck_cm3 		:= (pi * r_cm * r_cm) * heightAck_cm;	// [cm3]
	volumeAck_liters 	:= volumeAck_cm3 / 1000;			// [dm3]/[l]
	
	LowLimitAbs_cm		:= IN_ProbeLength_mm / 10.0 * IN_TNK_LowLimitAbs / 100.0;	// [cm]
	LowLimitAbs_cm3		:= (pi * r_cm * r_cm) * LowLimitAbs_cm;	// [cm3]
	LowLimitAbs_liters 	:= LowLimitAbs_cm3 / 1000;			// [dm3]/[l]
	
	OUT_Scale[0].ActValue	:=	LIMIT(IN_Scale[0].ScaleLOW, IN_TNK_PV, IN_Scale[0].ScaleHIGH);
	IF IN_TNK_PV > 1.0 THEN
		OUT_Scale[1].ActValue := volumeAck_liters + IN_TNK_Bottom_liters;
	ELSE
		OUT_Scale[1].ActValue := 0.0;
	END_IF
		
	OUT_Scale[2].ActValue 	:= (OUT_Scale[0].ActValue * IN_ProbeLength_mm / 100.0)(* + IN_FromFloor_ToZeroProbe_mm*); 
	
	OUT_Scale[3].ActValue := LowLimitAbs_liters + IN_TNK_Bottom_liters;
	
	CASE IN_Sp_Type OF
		0:
			HMI.SP[0] 		:= IN_Scale[0].ActualSP;
			HMI.SP[1]		:= IN_Scale[1].ActualSP;
			HMI.SP[2]		:= IN_Scale[2].ActualSP;
			HMI.SP[3]		:= IN_Scale[3].ActualSP;
			HMI.Wait[0] 	:= FALSE;
			HMI.Wait[1]		:= FALSE;
			HMI.Wait[2]		:= FALSE;
			HMI.Wait[3]		:= FALSE;
		
		1:	// Wait percentage SP
			HMI.SP[0] 		:= IN_Scale[0].ActualSP;
			HMI.SP[1]		:= (IN_Scale[0].ActualSP * volumeTot_liters) / 100.0;
			HMI.SP[2]		:= (IN_Scale[0].ActualSP * IN_ProbeLength_mm / 100.0) + IN_FromFloor_ToZeroProbe_mm;
			HMI.SP[3]		:= IN_Scale[3].ActualSP;
			HMI.Wait[0] 	:= IN_Wait;
			HMI.Wait[1]		:= FALSE;
			HMI.Wait[2]		:= FALSE;
			HMI.Wait[3]		:= FALSE;
		
		2:	// Wait Volume SP 
			HMI.SP[0]		:= ((IN_Scale[1].ActualSP - IN_TNK_Bottom_liters) / volumeTot_liters) *100.0;
			HMI.SP[1]		:= IN_Scale[1].ActualSP;
			HMI.SP[2]		:= (((IN_Scale[1].ActualSP / volumeTot_liters) *100.0) * IN_ProbeLength_mm /100.0) + IN_FromFloor_ToZeroProbe_mm;
			HMI.SP[3]		:= IN_Scale[3].ActualSP;
			HMI.Wait[0] 	:= FALSE;
			HMI.Wait[1]		:= IN_Wait;
			HMI.Wait[2]		:= FALSE;
			HMI.Wait[3]		:= FALSE;
		
		3:	// Wait level Height
			HMI.SP[0] 		:= (IN_Scale[2].ActualSP - IN_FromFloor_ToZeroProbe_mm) / IN_ProbeLength_mm  *100.0;
			HMI.SP[1]		:= (HMI.SP[0] * volumeTot_liters) / 100.0 + IN_TNK_Bottom_liters;
			HMI.SP[2]		:= IN_Scale[2].ActualSP;
			HMI.SP[3]		:= IN_Scale[3].ActualSP;
			HMI.Wait[0] 	:= FALSE;
			HMI.Wait[1]		:= FALSE;
			HMI.Wait[2]		:= IN_Wait;
			HMI.Wait[3]		:= FALSE;
	END_CASE
	
	HMI.ConfigPresent	:= IN_ConfigPresent;
	HMI.PV[0] 			:= OUT_Scale[0].ActValue;
	HMI.PV[1] 			:= OUT_Scale[1].ActValue;
	HMI.PV[2] 			:= OUT_Scale[2].ActValue;
	HMI.PV[3] 			:= OUT_Scale[3].ActValue;
	
END_FUNCTION_BLOCK