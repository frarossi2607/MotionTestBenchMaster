
ACTION DOS_ManualLifting: 
	ComboBoxString(
	IN_ElementsStructure	:= VAR_LiftPositionType.Elements,
	OUT_ComboString			:= ADR(HMI_DOS_LiftPositionTypeCFG)
	);

	HMI_DOS_LiftPosition.Enable := NOT HMI_DOS_SS2P[SS2P_DOS_SelLiftMan].ON AND SFT.DataOut.MachineEmpty AND VAR_DOS_MotorEnable AND NOT MNM.DataOut.MachineRunning AND NOT (VAR_DOS_LiftMoveStep = DSR_Fault); // AND VAR_DOS_ModeWait; 
	
	VAR_LiftPositionType.Elements[0].Name 		:= '@DOS_Not_Selected';
	VAR_LiftPositionType.Elements[0].Present	:= TRUE;
//	VAR_LiftPositionType.Data[0].PhaseType		:= VAR_DOS_MoveInProductionPosition;

	VAR_LiftPositionType.Elements[1].Name 		:= '@DOS_Production_Position';
	VAR_LiftPositionType.Elements[1].Present	:= TRUE;
//	VAR_LiftPositionType.Data[1].PhaseType		:= VAR_DOS_MoveInProductionPosition;
	
	VAR_LiftPositionType.Elements[2].Name 		:= '@DOS_COP_Position';
	VAR_LiftPositionType.Elements[2].Present	:= TRUE;
//	VAR_LiftPositionType.Data[2].PhaseType		:= VAR_DOS_MoveInCOPPosition;

	VAR_LiftPositionType.Elements[3].Name 		:= '@DOS_CIP_Position';
	VAR_LiftPositionType.Elements[3].Present	:= TRUE;
//	VAR_LiftPositionType.Data[3].PhaseType		:= VAR_DOS_MoveInCIPPosition;

END_ACTION
