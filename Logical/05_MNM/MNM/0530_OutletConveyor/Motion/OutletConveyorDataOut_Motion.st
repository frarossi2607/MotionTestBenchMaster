ACTION OutletConveyorDataOut_Motion:	
	MNM.DataOut.OutletSpeed := ((MC_InputOutput.Network.Machine.Status.ActualSpeed / 60.0) * (1 + MC_InputOutput.Network.Outlet.Parameters.ConveyorKs / 100.0)) * LREAL_TO_REAL(CFG_MC.Mechanical.MachineStep / 1000.0) * 10.0;
END_ACTION
