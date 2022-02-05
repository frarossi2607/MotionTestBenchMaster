(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: SidelLog
 * File: SidelLog.typ
 * Author: Administrator
 * Created: July 15, 2014
 ********************************************************************
 * Data types of library SidelLog
 ********************************************************************)
(********************************                                    UPS LOG                                    **************************************************************)

TYPE
	Sidel_UpsIo_typ : 	STRUCT 
		batteryAlarm : BOOL; (*True when the battery is failed*)
		batteryLow : BOOL; (*True when the battery is low*)
		shutdownReq : BOOL; (*Shutdown request*)
		noPowerSupply : BOOL; (*True when there is power supply*)
		shutdownAlarm : BOOL; (*True when the shutdown time exceed limits*)
		powerOffTime : UINT; (*Power off time*)
	END_STRUCT;
END_TYPE

(********************************                             SOFTWARE OBJECT LOG                **************************************************************)

TYPE
	MO_List_Light_typ : 	STRUCT 
		name : ARRAY[0..13]OF SINT;
		grp : USINT;
		type : USINT;
		state : USINT;
		reserve : USINT;
		memtype : UDINT;
	END_STRUCT;
	SW_Obj_List : 	STRUCT 
		version : MoVerStruc_typ; (*Version*)
		module : MO_List_Light_typ; (*Module details*)
	END_STRUCT;
END_TYPE
