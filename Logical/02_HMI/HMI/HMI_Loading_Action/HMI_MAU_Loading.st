ACTION HMI_MAU_Loading:
	HMI_MAU_PB;
	HMI_MAU_SS2P;(*master nuovo*)
	HMI_GrLb_Loading;
	HMI_WhRoom_Loading;
	HMI_MAU_Safety_Loading;
	HMI_LbCon_Loading;(*master nuovo*)
	HMI_LftCon_Loading;
	HMI_UPS_Loading;
	HMI_MAU_Plc;
	HMI_Exhauster_Loading; //v1.7.4
END_ACTION

ACTION HMI_GrLb_Loading:
	HMI_201GPE;
	HMI_GrLb_PB;
	HMI_GrLb_Data;
	HMI_GrLb_Data2;		//V4.A.A.1.6.11
END_ACTION

ACTION HMI_LbCon_Loading:(*master nuovo*)
	HMI_LbCon_PB;(*master nuovo*)
	HMI_MAU_ChlRns;(*master nuovo*)
END_ACTION
ACTION HMI_Tray_Loading:
	//v1.4
	HMI_227CPB;
	HMI_209DSF;
END_ACTION

ACTION HMI_LftCon_Loading:
	HMI_LftCon_SS2P;
	HMI_203RVF;
END_ACTION

ACTION HMI_WhRoom_Loading:
	HMI_WhRoom_SS2P;
	HMI_FanBase;
	HMI_FanFiller;
	HMI_FanRinser;
	HMI_FanTransfer;
	HMI_204PTE;
	HMI_205PTE;
	HMI_206PTE;
	HMI_207PTE;//1.7.6
END_ACTION

ACTION HMI_UPS_Loading:
	HMI_UPS_ShutdownRequest;
END_ACTION

ACTION HMI_MAU_Safety_Loading:
	HMI_SL_Info;
	HMI_SL_PB;
END_ACTION

ACTION HMI_MAU_Plc:
	HMI_TimeZoneOffset;
	HMI_SDM_RequestInit;//1.7.2b
 	HMI_SDM_PLCAvailable;//1.7.2b
	HMI_SDM_MachineStopped;//1.7.2b
END_ACTION

ACTION HMI_Exhauster_Loading: //v1.7.4
HMI_AFE;
HMI_VFD_AFE;
END_ACTION