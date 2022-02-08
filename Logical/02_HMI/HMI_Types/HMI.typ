
TYPE
	Step_Type : 	STRUCT 
		Config_Visualization : BOOL;
		Preset : REAL; (*Preset Step Time*)
		Actual : REAL; (*Actual Step Time*)
		StepIndex : UINT; (*Actual Sequencer Step Number*)
		StepIndexText : UINT; (*Request Step Text to HMI*)
	END_STRUCT;
	Signals_Type : 	STRUCT 
		DigitalIn : ARRAY[1..5]OF HMI_DigitalITC_Type;
		AnalogIn : ARRAY[1..2]OF HMI_AnalogITC_Type;
		DigitalOut : ARRAY[1..5]OF HMI_DigitalITC_Type;
		AnalogOut : ARRAY[1..2]OF HMI_AnalogITC_Type;
	END_STRUCT;
	Seq_Type : 	STRUCT 
		TextBar : ARRAY[0..4]OF SeqTextBar_Type;(*master nuovo*)
		InfoBox : ARRAY[0..5]OF SeqInfo_Type; (*Preset Step Time*)
	END_STRUCT;
	SeqTextBar_Type : 	STRUCT 
		Visibility : BOOL;
		IndexNr : UINT; (*Actual Sequencer Step Number*)
		IndexText : UINT; (*Request Step Text to HMI*)
	END_STRUCT;
	SeqInfo_Type : 	STRUCT 
		Visibility : BOOL;
		IndexText : STRING[20]; (*Request Step Text to HMI*)
		Unit : UINT;
		ProgressVisibility : BOOL; (*Step Progress Visibility*)
		Progress : REAL; (*Step Progress Time*)
		Preset : REAL; (*Preset Step Time*)
		Actual : REAL; (*Actual Step Time*)
	END_STRUCT;
	Info_Type : 	STRUCT  (*v1.4*)
		Visibility : BOOL;
		Preset : REAL; (*Preset Value*)
		Actual : REAL; (*Actual value*)
	END_STRUCT;
	Data_Type : 	STRUCT  (*v1.7.4a*)
		Visibility : BOOL;
		StringLineNameVisibility : BOOL; (*0=Fix text displayed-1= String displayed*)
		DataValueVisibility : BOOL; (*0=String displayed-1= Numeric value displayed*)
		LineName : STRING[100]; (*Line Name*)
		DataText : STRING[100]; (*Data Text in Case of String*)
		DataValue : REAL; (*Data Value in Case of Numeric*)
	END_STRUCT;
	HMI_CounterHome_Type : 	STRUCT  (*V4.A.A.1.6.8*)
		SS2P : SS2P_Type;
		CounterValue : ARRAY[0..1]OF UDINT;
	END_STRUCT;
END_TYPE
