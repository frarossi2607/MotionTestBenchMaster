
TYPE
	HMI_MNT_Type : 	STRUCT 
		Macao : HMI_Macao_Type;
		Tpm : ARRAY[0..12]OF HMI_Tpm_Type; (*//v1.5*)
	END_STRUCT;
	HMI_Macao_Type : 	STRUCT 
		Counter : ARRAY[0..15]OF UDINT;
		Event : ARRAY[0..7]OF BOOL;
	END_STRUCT;
	HMI_Tpm_Type : 	STRUCT  (*//v1.5*)
		Config : BOOL;
		AnalogNomValueVisible : BOOL;
		HmiID : UINT;
		AnalogActValue : REAL;
		AnalogMaxValue : REAL;
		AnalogMinValue : REAL;
		AnalogNomValue : REAL;
	END_STRUCT;
END_TYPE
