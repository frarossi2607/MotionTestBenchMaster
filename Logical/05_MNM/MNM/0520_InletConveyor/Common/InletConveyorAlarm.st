ACTION InletConveyorAlarm:
	IF InletSafetyLow1.OUT_OffDelayed AND InletSafetyHigh1.OUT_OffDelayed AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp THEN
		ALR[4618].Active	:= TRUE;
	ELSE//MasterBottle
		ALR[4618].Active	:= FALSE; //MasterBottle
	END_IF    
	
	IF InletSafetyLow2.OUT_OffDelayed AND InletSafetyHigh2.OUT_OffDelayed AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp THEN
		ALR[4619].Active	:= TRUE;
	ELSIF AID.DataOut.Reset THEN
		ALR[4619].Active	:= FALSE;
	END_IF
		IF SFT.DataOut.ContainersBlock1 THEN//MasterBottle
	IF TON_ContainerInletSafety1.Q AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp THEN//MasterBottle
		ALR[4620].Active	:= TRUE;//MasterBottle
	ELSIF IO_PB_ResetInlet1.ON THEN//MasterBottle
		ALR[4620].Active	:= FALSE;//MasterBottle
	END_IF  //MasterBottle  
	
	
		ELSE //MasterBottle
			IF ((InletSafetyLow1.OUT AND NOT InletSafetyHigh1.OUT) OR (NOT InletSafetyLow1.OUT AND InletSafetyHigh1.OUT)) AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp THEN//MasterBottle
				ALR[4620].Active	:= TRUE;//MasterBottle
			ELSIF IO_PB_ResetInlet1.ON THEN//MasterBottle
				ALR[4620].Active	:= FALSE;//MasterBottle
			END_IF//MasterBottle
		END_IF//MasterBottle
	TON_ContainerInletSafety1.IN := ((InletSafetyLow1.OUT AND NOT InletSafetyHigh1.OUT) OR (NOT InletSafetyLow1.OUT AND InletSafetyHigh1.OUT));//MasterBottle
	TON_ContainerInletSafety1.PT := REAL_TO_TIME((1/(MC_InputOutput.Network.Machine.Status.ActualSpeed/3600))*1000 );//MasterBottle
	TON_ContainerInletSafety1();//MasterBottle
	
	IO_PB_ResetInlet1.LampON := ALR[4620].Active AND AID.DataOut.Blink1Hz;//MasterBottle
	
	IF ((InletSafetyLow2.OUT AND NOT InletSafetyHigh2.OUT) OR (NOT InletSafetyLow2.OUT AND InletSafetyHigh2.OUT)) AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp THEN//MasterBottle
		ALR[4621].Active	:= TRUE;//MasterBottle
	ELSIF IO_PB_ResetInlet2.ON THEN//MasterBottle
		ALR[4621].Active	:= FALSE;//MasterBottle
	END_IF
	
	MNM.DataOut.LackInlet1 := ALR[4618].Active OR ALR[4620].Active;
	MNM.DataOut.LackInlet2 := ALR[4619].Active OR ALR[4621].Active;
	
	ALR[4600].Active	:= NOT IO_LimitTorqueBlowerTransfer.DI_Input;
	
END_ACTION
