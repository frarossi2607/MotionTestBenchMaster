
TYPE
	HMI_MNT_Type : 	STRUCT 
		Macao : HMI_Macao_Type;
		Tpm : ARRAY[0..12]OF HMI_Tpm_Type; (*//v1.5*)
		_201QTB : HMI_Tpm_Type; (*V1.7.4*)
		_202QTB : HMI_Tpm_Type; (*V1.7.4*)
	END_STRUCT;
	HMI_Macao_Type : 	STRUCT 
		Counter : ARRAY[0..15]OF UDINT;
		Event : ARRAY[0..7]OF BOOL;
	END_STRUCT;
	HMI_Tpm_Type : 	STRUCT  (*//v1.5*)
		Config : BOOL;
		AnalogNomValueVisible : BOOL;
		AnalogAlarmValueVisible : BOOL; (*V1.7.4*)
		InstrumentFault : BOOL; (*V1.7.4*)
		HmiID : UINT;
		AnalogActValue : REAL;
		AnalogMaxValue : REAL;
		AnalogMinValue : REAL;
		AnalogNomValue : REAL;
		AnalogAlarmValue : REAL; (*V1.7.4*)
	END_STRUCT;
END_TYPE
