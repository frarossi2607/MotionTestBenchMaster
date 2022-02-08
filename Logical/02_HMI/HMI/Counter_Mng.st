ACTION HMI_CounterInit:
	HMI_CounterCfgPartial.MachineCounters.HmiData[FillerLaps].Description				:= '@CounterDescription_001';
	HMI_CounterCfgPartial.MachineCounters.HmiData[ClosingUnit1Laps].Description			:= '@CounterDescription_002';
	HMI_CounterCfgPartial.MachineCounters.HmiData[ClosingUnit2Laps].Description			:= '@CounterDescription_003';
	HMI_CounterCfgPartial.MachineCounters.HmiData[RinserLaps].Description				:= '@CounterDescription_004';
	HMI_CounterCfgPartial.MachineCounters.HmiData[FlaworDoserLaps].Description			:= '@CounterDescription_005';
	HMI_CounterCfgPartial.MachineCounters.HmiData[PulpDoserLaps].Description			:= '@CounterDescription_006';
	HMI_CounterCfgPartial.MachineCounters.HmiData[PowerOn].Description					:= '@CounterDescription_007';
	HMI_CounterCfgPartial.MachineCounters.HmiData[RotatingTime].Description				:= '@CounterDescription_048'; //V1.7.4
	
	HMI_CounterCfgPartial.ContainersCounters.HmiData[FillingFault].Description			:= '@CounterDescription_008';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[FillingBurst].Description			:= '@CounterDescription_009';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[ClosingUnit1Fault].Description		:= '@CounterDescription_010';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[ClosingUnit2Fault].Description		:= '@CounterDescription_011';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[RinsingFault].Description			:= '@CounterDescription_012';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[PulpDoserFault].Description		:= '@CounterDescription_013';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[FlaworDoserFault].Description		:= '@CounterDescription_014';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[BurstEjected].Description			:= '@CounterDescription_015';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[ManualEjected].Description			:= '@CounterDescription_016';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[LowFillingEjected].Description		:= '@CounterDescription_017';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[NotFilledEjected].Description		:= '@CounterDescription_018';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[ContainersEntered].Description		:= '@CounterDescription_019';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[ContainersProduced].Description	:= '@CounterDescription_020';
	HMI_CounterCfgPartial.ContainersCounters.HmiData[EjectionBySIS].Description			:= '@CounterDescription_045'; //V4.A.A.1.6.8
	HMI_CounterCfgPartial.ContainersCounters.HmiData[BottleProduceToCvo].Description;//			 := '@CounterDescription_046'; //V4.A.A.1.6.8
	HMI_CounterCfgPartial.ContainersCounters.HmiData[Spare].Description;// := '@CounterDescription_047'; //V4.A.A.1.6.8
	
	HMI_CounterCfgPartial.ProcessCounters.HmiData[FillerProduction].Description			:= '@CounterDescription_021';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[ClosingUnit1Production].Description	:= '@CounterDescription_022';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[ClosingUnit2Production].Description	:= '@CounterDescription_023';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[RinserProduction].Description			:= '@CounterDescription_024';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[PulpDoserProduction].Description		:= '@CounterDescription_025';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[FlaworDoserProduction].Description	:= '@CounterDescription_026';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[Cop].Description						:= '@CounterDescription_027';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[FillerCip].Description				:= '@CounterDescription_044';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[ClosingUnit1Cip].Description			:= '@CounterDescription_028';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[ClosingUnit2Cip].Description			:= '@CounterDescription_029';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[RinserCip].Description				:= '@CounterDescription_030';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[PulpDoserCip].Description				:= '@CounterDescription_031';
	HMI_CounterCfgPartial.ProcessCounters.HmiData[FlaworDoserCip].Description			:= '@CounterDescription_032';
	
	HMI_CounterCfgPartial.EcoCounters.HmiData[Power].Description						:= '@CounterDescription_033';
	HMI_CounterCfgPartial.EcoCounters.HmiData[Air].Description							:= '@CounterDescription_034';
	HMI_CounterCfgPartial.EcoCounters.HmiData[GeneralCO2].Description					:= '@CounterDescription_035';
	HMI_CounterCfgPartial.EcoCounters.HmiData[ClosingUnitCO2].Description				:= '@CounterDescription_036';
	HMI_CounterCfgPartial.EcoCounters.HmiData[N2].Description							:= '@CounterDescription_037';
	HMI_CounterCfgPartial.EcoCounters.HmiData[ProcessWater].Description					:= '@CounterDescription_038';
	HMI_CounterCfgPartial.EcoCounters.HmiData[CopWater].Description						:= '@CounterDescription_039';
	HMI_CounterCfgPartial.EcoCounters.HmiData[BottomBottleCoolingWater].Description		:= '@CounterDescription_040';
	HMI_CounterCfgPartial.EcoCounters.HmiData[Product].Description						:= '@CounterDescription_041';
	HMI_CounterCfgPartial.EcoCounters.HmiData[Steam].Description						:= '@CounterDescription_042';
	HMI_CounterCfgPartial.EcoCounters.HmiData[FoodSteam].Description					:= '@CounterDescription_043';
	HMI_CounterCfgPartial.EcoCounters.HmiData[ProductWater].Description					:= '@CounterDescription_049'; //V4.A.A.1.6.14k
	HMI_CounterCfgPartial.EcoCounters.HmiData[Syrup].Description						:= '@CounterDescription_050'; //V4.A.A.1.6.14k
	
	HMI_CounterCfgPartial.EcoCounters.HmiData[Power].Unit								:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[Air].Unit									:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[GeneralCO2].Unit							:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[ClosingUnitCO2].Unit						:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[N2].Unit									:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[ProcessWater].Unit						:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[CopWater].Unit							:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[BottomBottleCoolingWater].Unit			:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[Product].Unit								:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[Steam].Unit								:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[FoodSteam].Unit							:= '';
	HMI_CounterCfgPartial.EcoCounters.HmiData[ProductWater].Unit						:= ''; //V4.A.A.1.6.14k
	HMI_CounterCfgPartial.EcoCounters.HmiData[Syrup].Unit								:= ''; //V4.A.A.1.6.14k
END_ACTION

ACTION HMI_CounterMng:
	CASE HMI_CounterPageCategory OF
		0:
			HMI_CounterPartialCfgPageDB		ACCESS	(ADR(HMI_CounterCfgPartial.MachineCounters));
			HMI_CounterPartialDataPageDB	ACCESS	(ADR(HMI_CounterDataPartial.MachineCounters));
			HMI_CounterTotalCfgPageDB		ACCESS	(ADR(HMI_CounterCfgTotal.MachineCounters));
			HMI_CounterTotalDataPageDB		ACCESS	(ADR(HMI_CounterDataTotal.MachineCounters));
		
		10:
			HMI_CounterPartialCfgPageDB		ACCESS	(ADR(HMI_CounterCfgPartial.ContainersCounters));
			HMI_CounterPartialDataPageDB	ACCESS	(ADR(HMI_CounterDataPartial.ContainersCounters));
			HMI_CounterTotalCfgPageDB		ACCESS	(ADR(HMI_CounterCfgTotal.ContainersCounters));
			HMI_CounterTotalDataPageDB		ACCESS	(ADR(HMI_CounterDataTotal.ContainersCounters));
		
		20:
			HMI_CounterPartialCfgPageDB		ACCESS	(ADR(HMI_CounterCfgPartial.ProcessCounters));
			HMI_CounterPartialDataPageDB	ACCESS	(ADR(HMI_CounterDataPartial.ProcessCounters));
			HMI_CounterTotalCfgPageDB		ACCESS	(ADR(HMI_CounterCfgTotal.ProcessCounters));
			HMI_CounterTotalDataPageDB		ACCESS	(ADR(HMI_CounterDataTotal.ProcessCounters));
		
		30:
			HMI_CounterPartialCfgPageDB		ACCESS	(ADR(HMI_CounterCfgPartial.EcoCounters));
			HMI_CounterPartialDataPageDB	ACCESS	(ADR(HMI_CounterDataPartial.EcoCounters));
			HMI_CounterTotalCfgPageDB		ACCESS	(ADR(HMI_CounterCfgTotal.EcoCounters));
			HMI_CounterTotalDataPageDB		ACCESS	(ADR(HMI_CounterDataTotal.EcoCounters));
	END_CASE
	
	HMI_TotalBottleProduced	:= HMI_CounterDataTotal.ContainersCounters.CounterData[ContainersProduced].CounterValue;
	
	//DATA TO EXCHANGE IN HMI WITH BLOWER //V4.A.A.1.7.0
	HMI_CounterHome.SS2P.Visibility 	:= FALSE;//not used in Glass Machine
	HMI_CounterHome.SS2P.Enable			:= FALSE;//not used in Glass Machine
	HMI_CounterHome.SS2P.LampON 		:= HMI_CounterHome.SS2P.ON;
//	HMI_CounterHome.CounterValue[0] 	:= MAX(0,HMI_CounterDataPartial.ContainersCounters.CounterData[SIS_ContainersProducedToBlower].CounterValue -
//												HMI_CounterDataPartial.ContainersCounters.CounterData[SIS_EjectionToBlower].CounterValue);
//	HMI_CounterHome.CounterValue[1]		:= HMI_CounterDataPartial.ContainersCounters.CounterData[SIS_EjectionToBlower].CounterValue;
	
END_ACTION
