(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: FiltLib
 * File: FiltLib.fun
 * Author: passaglial
 * Created: July 16, 2010
 ********************************************************************
 * Functions and function blocks of library FiltLib
 ********************************************************************)

FUNCTION_BLOCK PT2_DINT (*PT2 Filter for DINT source data*)
	VAR_INPUT
		Enable : BOOL; (*Enables FB*)
		T1 : LREAL; (*1st Time constant for the filter [Sec]*)
		T2 : LREAL; (*2nd Time constant for the filter [Sec]*)
		U : DINT; (*Source value*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*FB is working*)
		Valid : BOOL; (*Filtered value is valid*)
		X : DINT; (*Filtered value *)
		Error : BOOL; (*Error is found*)
		ErrorID : UINT; (*Code for the error*)
	END_VAR
	VAR
		U_old : DINT; (*Previous U*)
		Ts : LREAL; (*Sampling Time (task class time) [Sec]*)
		b0 : LREAL; (*Filter parameter*)
		b1 : LREAL; (*Filter parameter*)
		b2 : LREAL; (*Filter parameter*)
		a1 : LREAL; (*Filter parameter*)
		a2 : LREAL; (*Filter parameter*)
		u0 : LREAL; (*Filter u0*)
		u1 : LREAL; (*Filter u1*)
		u2 : LREAL; (*Filter u2*)
		x0 : LREAL; (*Filter x0*)
		x1 : LREAL; (*Filter x1*)
		x2 : LREAL; (*Filter x2*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK PT1_DINT (*PT1 Filter for DINT source data*)
	VAR_INPUT
		Enable : BOOL; (*Enables FB*)
		T1 : LREAL; (*Time constant for the filter [Sec]*)
		U : DINT; (*Source value*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*FB is working*)
		Valid : BOOL; (*Filtered value is valid*)
		X : DINT; (*Filtered value *)
		Error : BOOL; (*Error is found*)
		ErrorID : UINT; (*Code for the error*)
	END_VAR
	VAR
		U_old : DINT; (*Previous U*)
		Ts : LREAL; (*Sampling Time (task class time) [Sec]*)
		b0 : LREAL; (*Filter parameter*)
		b1 : LREAL; (*Filter parameter*)
		a1 : LREAL; (*Filter parameter*)
		u0 : LREAL; (*Filter u0*)
		u1 : LREAL; (*Filter u1*)
		x0 : LREAL; (*Filter x0*)
		x1 : LREAL; (*Filter x1*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FDT_DINT (*Generic Transfer function*)
	VAR_INPUT
		Enable : BOOL; (*Enables FB*)
		U : DINT; (*Source value*)
		b0 : LREAL; (*Filter parameter*)
		b1 : LREAL; (*Filter parameter*)
		b2 : LREAL; (*Filter parameter*)
		a1 : LREAL; (*Filter parameter*)
		a2 : LREAL; (*Filter parameter*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*FB is working*)
		Valid : BOOL; (*Filtered value is valid*)
		X : DINT; (*Filtered value *)
		Error : BOOL; (*Error is found*)
		ErrorID : UINT; (*Code for the error*)
	END_VAR
	VAR
		U_old : DINT; (*Previous U*)
		u0 : LREAL; (*Filter u0*)
		u1 : LREAL; (*Filter u1*)
		u2 : LREAL; (*Filter u2*)
		x0 : LREAL; (*Filter x0*)
		x1 : LREAL; (*Filter x1*)
		x2 : LREAL; (*Filter x2*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK EXT_DINT (*Extrapolator filter*)
	VAR_INPUT
		Enable : BOOL; (*Enables FB*)
		U : DINT; (*Source value*)
		T_ext : LREAL; (*Extrapolation Time [sec]*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*FB is working*)
		Valid : BOOL; (*Filtered value is valid*)
		X : DINT; (*Filtered value *)
		Error : BOOL; (*Error is found*)
		ErrorID : UINT; (*Code for the error*)
	END_VAR
	VAR
		Ts : LREAL; (*Sampling Time (task class time) [Sec]*)
		b0 : LREAL; (*Filter parameter*)
		b1 : LREAL; (*Filter parameter*)
		b2 : LREAL; (*Filter parameter*)
		a1 : LREAL; (*Filter parameter*)
		a2 : LREAL; (*Filter parameter*)
		U_old : DINT; (*Previous U*)
		u0 : LREAL; (*Filter u0*)
		u1 : LREAL; (*Filter u1*)
		u2 : LREAL; (*Filter u2*)
		x0 : LREAL; (*Filter x0*)
		x1 : LREAL; (*Filter x1*)
		x2 : LREAL; (*Filter x2*)
	END_VAR
END_FUNCTION_BLOCK
