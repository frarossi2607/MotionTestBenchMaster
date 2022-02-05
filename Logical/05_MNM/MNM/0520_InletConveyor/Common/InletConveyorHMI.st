ACTION InletConveyorHMI:
	IF TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp THEN
		HMI_ContainerFallInlet1	:= (InletSafetyLow1.OUT AND NOT InletSafetyHigh1.OUT) OR (NOT InletSafetyLow1.OUT AND InletSafetyHigh1.OUT);
		HMI_ContainerFallInlet2	:= (InletSafetyLow2.OUT AND NOT InletSafetyHigh2.OUT) OR (NOT InletSafetyLow2.OUT AND InletSafetyHigh2.OUT);
		HMI_NoContainerInlet1	:= (NOT InletSafetyLow1.OUT AND NOT InletSafetyHigh1.OUT);
		HMI_NoContainerInlet2	:= (NOT InletSafetyLow2.OUT AND NOT InletSafetyHigh2.OUT);
	ELSE
		HMI_ContainerFallInlet1	:= FALSE;
		HMI_ContainerFallInlet2	:= FALSE;
		HMI_NoContainerInlet1	:= FALSE;
		HMI_NoContainerInlet1	:= FALSE;
	END_IF
END_ACTION
