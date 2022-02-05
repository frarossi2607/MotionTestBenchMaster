ACTION HMI_SFT_Loading:
	HMI_SFT_PB;
	HMI_SFT_SS2P;
	HMI_SFT_SS3P;
	
	//VALVES
	HMI_207CPB; //V4.A.A.1.6.11
	HMI_214CPB;
	HMI_205EVB;
	
	//COUNTERS
	HMI_StepAcquisition;
	HMI_CounterPartialCfgPageDB		ACCESS	(ADR(HMI_CounterCfgPartial.MachineCounters));
	HMI_CounterPartialDataPageDB	ACCESS	(ADR(HMI_CounterDataPartial.MachineCounters));
	HMI_CounterTotalCfgPageDB		ACCESS	(ADR(HMI_CounterCfgTotal.MachineCounters));
	HMI_CounterTotalDataPageDB		ACCESS	(ADR(HMI_CounterDataTotal.MachineCounters));
	HMI_TotalBottleProduced;
	
	//PHOTOCELLS
	HMI_201DSC;
	HMI_202DSF;
	HMI_203DSF;
	HMI_204DSF;
	HMI_207DSF;
	HMI_208DSF;
	
	HMI_201CPB;
	
	//Bottle Burst
	HMI_SFT_BurstData;
	
	// Sampling Mold //V1.61
	HMI_SFT_SamplingMold;
	//Pyrometer //V1.61
	HMI_TTBottomBottleDetection;//V1.61
	
	HMI_298DSB;//V4.A.A.1.7.0
	HMI_299DSB;//V4.A.A.1.7.0
END_ACTION
