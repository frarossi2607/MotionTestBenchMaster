ACTION OutletConveyorInterchange: 
(***************************      Alarms Standard        ****************************************)
	ALR[4626].Active	:= (NOT CvoFlr.InfeedContainersLoadEnabled AND NOT SkdFlr.EndProduction) AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp; //MasterBottle(*Master nuovo*)
	ALR[4629].Active	:= NOT CvoFlr.InfeedConveyorRunning AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp;//MasterBottle(*Master nuovo*)
	ALR[4632].Active	:= NOT CvoFlr.OutletConveyorRunning AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp;
	ALR[4635].Active	:= CvoFlr.RejectTableFull AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp;
	ALR[4636].Active	:= FALSE;//MasterBottle
	//ALR[4636].Active	:= CvoFlr.OutletConveyorLowSpeed AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp;//PET(*Master nuovo*)
	ALR[4637].Active	:= NOT CvoFlr.OutletContainersLoadEnabled AND TNK.DataOut.ProdMode AND NOT TNK.DataOut.StartUp;
END_ACTION
