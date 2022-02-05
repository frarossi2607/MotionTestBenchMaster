
TYPE
	HMI_APCO_Type : 	STRUCT 
		Action : HMI_APCO_Action_Type;
		Recipe : HMI_APCO_Recipe_Type;
	END_STRUCT;
	HMI_APCO_Recipe_Type : 	STRUCT 
		ProductTypeActual : UINT;
		ProductTypeNext : UINT;
	END_STRUCT;
	HMI_APCO_Recipe_Download_Type : 	STRUCT 
		Request : BOOL;
		Ended : BOOL;
	END_STRUCT;
	HMI_APCO_Action_Type : 	STRUCT 
		CheckPoints : ARRAY[0..15]OF HMI_APCO_Action_CheckPoints_Type;
		TypeOfChange : INT; (*V4.A.A.1.6.12*)
		CheckPointActive : INT; (*V4.A.A.1.6.12*)
	END_STRUCT;
	HMI_APCO_Action_CheckPoints_Type : 	STRUCT 
		Visibility : BOOL;
		IndexText : UINT;
		ON : BOOL;
	END_STRUCT;
END_TYPE
