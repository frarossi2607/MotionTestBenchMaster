PROGRAM _INIT
	(**********************************)
	(*  Mp Link Hierarchy management  *)
	(**********************************)
	fbMpComLinkToParent_Spare		(ParentLink := mpCOM_MAIN, MpLink := ADR(VAR_SpareLink));
	
	(**********************************)
	(* The machine is the higher Link *)
	(**********************************)
	fbMpComLinkToParent_Machine		(ParentLink := mpCOM_MAIN, MpLink := ADR(VAR_MachineLink));
	fbMpComLinkToParent_Master		(ParentLink := fbMpComLinkToParent_Machine.LinkOut,	MpLink := ADR(VAR_MasterModuleLink));
	fbMpComLinkToParent_Filler		(ParentLink := fbMpComLinkToParent_Machine.LinkOut,	MpLink := ADR(VAR_FillerModuleLink));

	IF VAR_AxOutletMain.nc_obj_inf.node_nr > 0 THEN	//At least the main axis in the outlet module
		fbMpComLinkToParent_Outlet	(ParentLink := fbMpComLinkToParent_Machine.LinkOut,	MpLink := ADR(VAR_OutletModuleLink));
	ELSE
		fbMpComLinkToParent_Outlet	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(VAR_OutletModuleLink));
	END_IF
	
	IF VAR_AxInletMain.nc_obj_inf.node_nr > 0 THEN	//At least the main axis in the inlet module
		fbMpComLinkToParent_Inlet	(ParentLink := fbMpComLinkToParent_Machine.LinkOut,	MpLink := ADR(VAR_InletModuleLink));
	ELSE
		fbMpComLinkToParent_Inlet	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(VAR_InletModuleLink));
	END_IF
	
	fbMpComLinkToParentAlarmMain	(ParentLink := fbMpComLinkToParent_Machine.LinkOut,	MpLink := ADR(gMainAlarmXCoreLink));
	
	(**********************************)
	(* Init of Link on Master Module  *)
	(**********************************)
	fbMpComLinkToParent_AlarmXMaster(ParentLink := fbMpComLinkToParent_Master.LinkOut,	MpLink := ADR(gMasterAlarmXCoreLink));
	fbMpComLinkToParent_MasterAxis 	(ParentLink := fbMpComLinkToParent_Master.LinkOut,	MpLink := ADR(gMasterLink));
	
	IF VAR_AxPowerSupply01.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_Pwr01 		(ParentLink := fbMpComLinkToParent_Master.LinkOut,	MpLink := ADR(gMasterPwr01Link));
	ELSE
		fbMpComLinkToParent_Pwr01		(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gMasterPwr01Link));
	END_IF
	
	IF VAR_AxPowerSupply02.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_Pwr02 		(ParentLink := fbMpComLinkToParent_Master.LinkOut,	MpLink := ADR(gMasterPwr02Link));
	ELSE
		fbMpComLinkToParent_Pwr02 		(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gMasterPwr02Link));
	END_IF
	
	(**********************************)
	(* Init of Link on Filler Module  *)
	(**********************************)
	fbMpComLinkToParent_AlarmXFiller(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFillerAlarmXCoreLink));
	fbMpComLinkToParent_FillerMas 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFillerModuleMasterLink));
	fbMpComLinkToParent_Carousel 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFillerMainLink));

	IF VAR_AxFillerIn01.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrInlet01 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrIn01Link));
	ELSE
		fbMpComLinkToParent_FlrInlet01 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrIn01Link));
	END_IF
	
	IF VAR_AxFillerIn02.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrInlet02 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrIn02Link));
	ELSE
		fbMpComLinkToParent_FlrInlet02 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrIn02Link));
	END_IF
	
	IF VAR_AxFillerIn03.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrInlet03 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrIn03Link));
	ELSE
		fbMpComLinkToParent_FlrInlet03 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrIn03Link));
	END_IF
	
	IF VAR_AxFillerIn04.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrInlet04 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrIn04Link));
	ELSE
		fbMpComLinkToParent_FlrInlet04 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrIn04Link));
	END_IF
	
	IF VAR_AxFillerIn05.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrInlet05 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrIn05Link));
	ELSE
		fbMpComLinkToParent_FlrInlet05 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrIn05Link));
	END_IF		
	
	IF VAR_AxFillerIn06.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrInlet06 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrIn06Link));
	ELSE
		fbMpComLinkToParent_FlrInlet06 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrIn06Link));
	END_IF
		
	IF VAR_AxFillerIn07.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrInlet07 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrIn07Link));
	ELSE
		fbMpComLinkToParent_FlrInlet07 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrIn07Link));
	END_IF
	
	IF VAR_AxFillerIn08.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrInlet08 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrIn08Link));
	ELSE
		fbMpComLinkToParent_FlrInlet08 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrIn08Link));
	END_IF
		
	IF VAR_AxFillerIn09.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrInlet09 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrIn09Link));
	ELSE
		fbMpComLinkToParent_FlrInlet09 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrIn09Link));
	END_IF
	
	IF VAR_AxFillerIn10.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrInlet10 	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrIn10Link));
	ELSE
		fbMpComLinkToParent_FlrInlet10 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrIn10Link));
	END_IF
	
	IF VAR_AxFillerOut01.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrOutlet01	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrOut01Link));
	ELSE
		fbMpComLinkToParent_FlrOutlet01 (ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrOut01Link));
	END_IF
		
	IF VAR_AxFillerOut02.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrOutlet02	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrOut02Link));
	ELSE
		fbMpComLinkToParent_FlrOutlet02 (ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrOut02Link));
	END_IF
	
	IF VAR_AxFillerOut03.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrOutlet03	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrOut03Link));
	ELSE
		fbMpComLinkToParent_FlrOutlet03 (ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrOut03Link));
	END_IF
	
	IF VAR_AxFillerOut04.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrOutlet04	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrOut04Link));
	ELSE
		fbMpComLinkToParent_FlrOutlet04 (ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrOut04Link));
	END_IF
	
	IF VAR_AxFillerOut05.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrOutlet05	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrOut05Link));
	ELSE
		fbMpComLinkToParent_FlrOutlet05 (ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrOut05Link));
	END_IF
	
			
	IF VAR_AxFillerOut06.nc_obj_inf.node_nr > 0 THEN
		fbMpComLinkToParent_FlrOutlet06	(ParentLink := fbMpComLinkToParent_Filler.LinkOut,	MpLink := ADR(gFlrOut06Link));
	ELSE
		fbMpComLinkToParent_FlrOutlet06 (ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gFlrOut06Link));
	END_IF
	
	(**********************************)
	(* Init of Link on Inlet  Module  *)
	(**********************************)
	IF VAR_AxInletMain.nc_obj_inf.node_nr <> 0  THEN
		fbMpComLinkToParent_AlarmXInlet	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInletAlarmXCoreLink));
		fbMpComLinkToParent_InletMas 	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInletModuleMasterLink));
		fbMpComLinkToParent_InletMain	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInletMainLink));
	ELSE
		fbMpComLinkToParent_AlarmXInlet	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInletAlarmXCoreLink));
		fbMpComLinkToParent_InletMas 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInletModuleMasterLink));
		fbMpComLinkToParent_InletMain	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInletMainLink));
	END_IF
	 
	(*  INLET 01 *)
	IF VAR_AxInletIn01.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_InInlet01	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInInlet01Link));
	ELSE
		fbMpComLinkToParent_InInlet01 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInInlet01Link));
	END_IF
	
	(*  INLET 02 *)
	IF VAR_AxInletIn02.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_InInlet02	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInInlet02Link));
	ELSE
		fbMpComLinkToParent_InInlet02 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInInlet02Link));
	END_IF
	
	(* INLET 03 *)
	IF VAR_AxInletIn03.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_InInlet03	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInInlet03Link));
	ELSE
		fbMpComLinkToParent_InInlet03 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInInlet03Link));
	END_IF
	
	(* INLET 04*)
	IF VAR_AxInletIn04.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_InInlet04	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInInlet04Link));
	ELSE
		fbMpComLinkToParent_InInlet04 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInInlet04Link));
	END_IF
	
	(*  OUTLET 01 *)
	IF VAR_AxInletOut01.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_InOutlet01	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInOutlet01Link));
	ELSE
		fbMpComLinkToParent_InOutlet01 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInOutlet01Link));
	END_IF
	
	(*  OUTLET 02 *)
	IF VAR_AxInletOut02.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_InOutlet02	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInOutlet02Link));
	ELSE
		fbMpComLinkToParent_InOutlet02 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInOutlet02Link));
	END_IF
	
	(* OUTLET 03 *)
	IF VAR_AxInletOut03.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_InOutlet03	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInOutlet03Link));
	ELSE
		fbMpComLinkToParent_InOutlet03 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInOutlet03Link));
	END_IF
	
	(* OUTLET 04*)
	IF VAR_AxOutletOut04.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_InOutlet04	(ParentLink := fbMpComLinkToParent_Inlet.LinkOut,	MpLink := ADR(gInOutlet04Link));
	ELSE
		fbMpComLinkToParent_InOutlet04 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gInOutlet04Link));
	END_IF
		
	(**********************************)
	(* Init of Link on Outlet Module  *)
	(**********************************)	
	IF VAR_AxOutletMain.nc_obj_inf.node_nr <> 0  THEN
		fbMpComLinkToParent_AlarmXOutlet(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutletAlarmXCoreLink));
		fbMpComLinkToParent_OutletMas 	(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutletModuleMasterLink));
		fbMpComLinkToParent_OutletMain	(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutletMainLink));
	ELSE
		fbMpComLinkToParent_AlarmXOutlet(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutletAlarmXCoreLink));
		fbMpComLinkToParent_OutletMas 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutletModuleMasterLink));
		fbMpComLinkToParent_OutletMain	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutletMainLink));
	END_IF
	
	(*  INLET 01 *)
	IF VAR_AxOutletIn01.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_OutInlet01	(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutInlet01Link));
	ELSE
		fbMpComLinkToParent_OutInlet01 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutInlet01Link));
	END_IF
	
	(*  INLET 02 *)
	IF VAR_AxOutletIn02.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_OutInlet02	(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutInlet02Link));
	ELSE
		fbMpComLinkToParent_OutInlet02 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutInlet02Link));
	END_IF
	
	(* INLET 03 *)
	IF VAR_AxOutletIn03.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_OutInlet03	(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutInlet03Link));
	ELSE
		fbMpComLinkToParent_OutInlet03 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutInlet03Link));
	END_IF
	
	(* INLET 04*)
	IF VAR_AxOutletIn04.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_OutInlet04	(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutInlet04Link));
	ELSE
		fbMpComLinkToParent_OutInlet04 	(ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutInlet04Link));
	END_IF
	
	(*  OUTLET 01 *)
	IF VAR_AxOutletOut01.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_OutOutlet01	(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutOutlet01Link));
	ELSE
		fbMpComLinkToParent_OutOutlet01 (ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutOutlet01Link));
	END_IF
	
	(*  OUTLET 02 *)
	IF VAR_AxOutletOut02.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_OutOutlet02	(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutOutlet02Link));
	ELSE
		fbMpComLinkToParent_OutOutlet02 (ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutOutlet02Link));
	END_IF
	
	(* OUTLET 03 *)
	IF VAR_AxOutletOut03.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_OutOutlet03	(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutOutlet03Link));
	ELSE
		fbMpComLinkToParent_OutOutlet03 (ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutOutlet03Link));
	END_IF
	
	(* OUTLET 04*)
	IF VAR_AxOutletOut04.nc_obj_inf.node_nr <> 0 THEN
		fbMpComLinkToParent_OutOutlet04	(ParentLink := fbMpComLinkToParent_Outlet.LinkOut,	MpLink := ADR(gOutOutlet04Link));
	ELSE
		fbMpComLinkToParent_OutOutlet04 (ParentLink := fbMpComLinkToParent_Spare.LinkOut,	MpLink := ADR(gOutOutlet04Link));
	END_IF
END_PROGRAM	
	
PROGRAM _CYCLIC
	ST_tmp_suspend(0);
END_PROGRAM