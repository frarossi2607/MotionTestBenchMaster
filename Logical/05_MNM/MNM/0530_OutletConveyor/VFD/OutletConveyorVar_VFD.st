ACTION OutletConveyorVar_VFD: 
	VAR_MNM_ConveyorProduction	:= NOT SFT.DataOut.OutletConveyorEmpty OR NOT SFT.DataOut.MachineEmpty OR OPS.DataOut.FlrModeSelectorJog;
	VAR_MNM_ConveyorClean		:= COP.DataOut.RcpActive;
END_ACTION
