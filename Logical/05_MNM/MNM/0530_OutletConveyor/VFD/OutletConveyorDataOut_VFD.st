ACTION OutletConveyorDataOut_VFD:
	IF _OutCvr.OUT_ActualFrequency > 0 THEN
		MNM.DataOut.OutletSpeed := (((_OutCvr.OUT_ActualFrequency / 100.0) * MC_InputOutput.Network.Machine.Status.ActualSpeed) / 60.0);
	ELSE
		MNM.DataOut.OutletSpeed := 0.0 ;
	END_IF
END_ACTION
