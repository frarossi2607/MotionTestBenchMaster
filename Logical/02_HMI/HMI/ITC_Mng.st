ACTION HMI_ITCMng:
	IF HMI_ITC_Page.PartnerID <> HMI_ITC_PartnerOld OR NOT HMI_ITC_Partner_CFG[HMI_ITC_Page.PartnerID] THEN
		HMI_ITC_Page.PartnerID	:= LIMIT(CST_MinITCPartner, HMI_ITC_Page.PartnerID, CST_MaxITCPartner);
		FOR VAR_ITCindex := HMI_ITC_Page.PartnerID TO CST_MaxITCPartner DO 
			IF HMI_ITC_Partner_CFG[VAR_ITCindex] THEN
				HMI_ITC_Page.PartnerID := VAR_ITCindex;
				EXIT;
			END_IF
		END_FOR
		
		HMI_ITC_Page.PageNum	:= 0;
		HMI_ITC_PartnerOld		:= HMI_ITC_Page.PartnerID;
		HMI_ITC_PageData.PageUp.Enable		:= FALSE;
		HMI_ITC_PageData.PageDown.Enable	:= FALSE;
	END_IF
	
	HMI_ITC_PageData ACCESS (ADR(HMI_ITC_PageDB[CST_MinITCPartner]) + MIN(HMI_ITC_Page.PartnerID - CST_MinITCPartner, CST_MaxITCPartner) * SIZEOF(HMI_ITC_PageDB[CST_MinITCPartner]));
	
	HMI_ITC_PageData.PageUp.LampON		:= HMI_ITC_PageData.PageUp.ON AND HMI_ITC_PageData.PageUp.Enable;
	HMI_ITC_PageData.PageDown.LampON	:= HMI_ITC_PageData.PageDown.ON AND HMI_ITC_PageData.PageDown.Enable;
	
	IF EDGEPOS(HMI_ITC_PageData.PageUp.LampON) THEN
		HMI_ITC_Page.PageNum	:= LIMIT(0, HMI_ITC_Page.PageNum + 1, 20);
		HMI_ITC_PageData.PageUp.Enable		:= FALSE;
		HMI_ITC_PageData.PageDown.Enable	:= FALSE;
	END_IF
	
	IF EDGEPOS(HMI_ITC_PageData.PageDown.LampON) THEN
		HMI_ITC_Page.PageNum	:= LIMIT(0, HMI_ITC_Page.PageNum - 1, 20);
		HMI_ITC_PageData.PageDown.Enable	:= FALSE;
		HMI_ITC_PageData.PageUp.Enable		:= FALSE;
	END_IF
END_ACTION
