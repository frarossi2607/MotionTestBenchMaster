ACTION OutletConveyorHMI:
	IF TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp THEN
		HMI_OutletFull	:= CvoFlr.OutletConveyorLowSpeed OR NOT CvoFlr.OutletContainersLoadEnabled;
	ELSE
		HMI_OutletFull	:= FALSE;
	END_IF
END_ACTION
