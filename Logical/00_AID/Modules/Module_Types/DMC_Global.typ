
TYPE
	DMC_SequencerType : 
		(
		DMC_Wait := 0,
		DMC_WaitMachineEmptyAndSlowDown := 1,
		DMC_LftCenteringCupUp := 2,
		DMC_DummyContInstalling := 4,
		DMC_DummyContInstalledControl := 5,
		DMC_DummyContInsMachineStop := 6,
		DMC_DummyContInsCsrPositioning := 7,
		DMC_DummyContInsLftCenterCupDown := 8,
		DMC_DummyContInsFmcCipMode := 9,
		DMC_DummyContInstalled := 10,
		DMC_DummyContDisMachineStop := 11,
		DMC_DummyContDisFmcCenterCupUp := 12,
		DMC_DummyContDisLftCenterCupUp := 13,
		DMC_DummyContDisCsrPositioning := 14,
		DMC_DummyContDisMachineStart := 15,
		DMC_DummyContDisinsection := 16,
		DMC_DummyContDinsControl := 17,
		DMC_DummyContRemovedDone := 18
		);
END_TYPE
