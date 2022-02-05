
TYPE
	HMI_SpeedWidget_Type : 	STRUCT 
		Modality : BOOL; (*0 = Auto / 1 = Jog*)
		Visibility : BOOL; (*0 = Hidden (Combi Mode) / 1 = Visible*)
		ActualSpeed : DINT; (*Actual Machine Speed [cph]*)
		AutoSpeedReq : DINT; (*Automatic Speed Required (Standalone) [cph]*)
		JogSpeedReq : DINT; (*Jog Speed Required (Standalone) [cph]*)
		Status : USINT; (*0: Error
1: Automatic
2: Jog
3: Adjustement
4: Slow motion forward
5: Slow motion backward*)
	END_STRUCT;
END_TYPE
