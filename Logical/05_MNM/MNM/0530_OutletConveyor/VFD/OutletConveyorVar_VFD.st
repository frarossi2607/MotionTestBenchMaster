ACTION OutletConveyorVar_VFD: 
	VAR_MNM_ConveyorProduction	:= MNM.DataOut.MachineRunning AND NOT COP.DataOut.RcpActive OR OPS.DataOut.FlrModeSelectorJog; //Montanarini: a Heuft serve il nastro in movimento quando la macchina gira	---	NOT SFT.DataOut.OutletConveyorEmpty OR NOT SFT.DataOut.MachineEmpty OR OPS.DataOut.FlrModeSelectorJog;
	VAR_MNM_ConveyorClean		:= COP.DataOut.RcpActive;
END_ACTION
