FUNCTION FC_SpeedCheck
	CASE IN_Mode OF
		CST_EQ:	(* Actual speed equal to requested *)
			FC_SpeedCheck := (IN_SpeedAct >= (IN_SpeedReq * 0.9)) AND (IN_SpeedAct <= (IN_SpeedReq / 0.9));
		
		CST_GE:	(* Actual speed greater then requested *)
			FC_SpeedCheck := IN_SpeedAct >= IN_SpeedReq * 0.9;
		
		CST_LE:	(* Actual speed lower then requested *)
			FC_SpeedCheck := IN_SpeedAct <= IN_SpeedReq / 0.9;
		
		CST_GT:	(* Actual speed greater then requested *)
			FC_SpeedCheck := IN_SpeedAct > IN_SpeedReq * 0.9;
		
		CST_LT:	(* Actual speed lower then requested *)
			FC_SpeedCheck := IN_SpeedAct < IN_SpeedReq / 0.9;			
			
		ELSE
			FC_SpeedCheck := FALSE;
	END_CASE
END_FUNCTION
