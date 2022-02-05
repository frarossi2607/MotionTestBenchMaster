(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: SidelLog
 * File: SidelLog.fun
 * Author: Administrator
 * Created: July 15, 2014
 ********************************************************************
 * Functions and function blocks of library SidelLog
 ********************************************************************)

FUNCTION_BLOCK LogSupplyEvents (*Write the power supply events in the specified logger*)
	VAR_INPUT
		enable : BOOL; (*Enable the execution of the function block*)
		ADR_UpsIO : UDINT; (*Address of the UPS IO interface*)
	END_VAR
	VAR_OUTPUT
		errorID : DINT; (*Current error ID*)
		error : BOOL; (*True when the function block is in error*)
		upsStatus : UINT; (*Ups output status*)
		busy : BOOL; (*True when the function block is running*)
		errorStep : USINT; (*Error step*)
	END_VAR
	VAR
		step : USINT; (*Internal step*)
		batteryAlarm : BOOL; (*True when the battery is in alarm*)
		batteryLow : BOOL; (*True when the battery is low*)
		shutdownRequested : BOOL; (*Shutdown requested*)
		noSupply : BOOL; (*True wjen the power supply failed*)
		pUpsIO : REFERENCE TO Sidel_UpsIo_typ; (*Pointer to the UPS IO interface*)
		customLogEntry_0 : CustomLogEntry; (*Wrinting and getting information into a specified Logger*)
		tempString2 : STRING[80];
		tempString : STRING[80];
		data : pwr_log_custom_entry; (*Internal data to write*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK SynchLog (*Machine synchronization logger*)
	VAR_INPUT
		enable : BOOL; (*Enable the execution of the function block*)
		RAX1 : USINT;
		AXN : USINT;
		offsetAcquire : BOOL;
		testBit : USINT;
		axisNameHoming : STRING[80];
		axisName : STRING[80];
		positionMm : REAL;
		positionMmHoming : REAL;
	END_VAR
	VAR_OUTPUT
		errorID : DINT; (*Current error ID*)
		error : BOOL; (*True when the function block is in error*)
		testIndex : USINT;
		busy : BOOL; (*True when the function block is running*)
	END_VAR
	VAR
		step : USINT; (*Internal step*)
		errorStep : USINT; (*Error step*)
		indexAxis : USINT;
		phasingString : STRING[80];
		phasingAxisPosition : STRING[80];
		data : pwr_log_custom_entry; (*Wrinting and getting information into a specified Logger*)
		customLogEntry_0 : CustomLogEntry; (*Internal data to write*)
		rTrig_0 : R_TRIG;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK SwChg (*Monitor and write into the user logger the canges of the software objects*)
	VAR_INPUT
		enable : BOOL; (*Enable the function block*)
		logLevel : USINT; (*Level of the log entry*)
		refreshTime : TIME; (*Refresh time*)
	END_VAR
	VAR_OUTPUT
		scan : BOOL; (*True when the module is getting the software object list*)
		searching : BOOL; (*True when the function block is searching for software object changes*)
		writingLog : BOOL; (*True when the funciton block is writing the entry into the logger*)
		waiting : BOOL; (*Waiting to search again*)
		busy : BOOL; (*True when the function block is busy*)
		error : BOOL; (*True when the function block is in error*)
		errorID : DINT; (*Actual error ID*)
	END_VAR
	VAR
		errorSubStep : USINT; (*Internal error SubStep*)
		errorStep : USINT; (*Internal erro Step*)
		step : USINT; (*Internal step*)
		substep : USINT; (*Internal substep*)
		cnt : UDINT; (*Internal counter*)
		mo_prev_index : UINT; (*List previous index*)
		mo_index : UINT; (*Actual index*)
		refresh : TON; (*Refresh timer*)
		waitWrite : TON; (*CF data object write delay*)
		customEntry : pwr_log_custom_entry; (*Custom log entry*)
		tempString : STRING[80]; (*Temporary string*)
		tempModule : MO_List_typ; (*Temporary module informations*)
		nrChanges : UINT; (*Number of changed elements*)
		swListTempID : UDINT; (*Temporary software list ID*)
		swListID : UDINT; (*Software list ID*)
		iOldList : ARRAY[0..iMaxEntries] OF SW_Obj_List; (*Internal Old List*)
		iActList : ARRAY[0..iMaxEntries] OF SW_Obj_List; (*Internal Actual List*)
	END_VAR
	VAR CONSTANT
		CST_fwOBJ : USINT := 132; (*Firmware Object*)
		CST_configOBJ : USINT := 67; (*Configuration Object*)
		CST_hwOBJ : USINT := 43; (*Hrdwa object*)
		CST_ncOBJ : USINT := 70; (*NC Object*)
		CST_cycOBJ : USINT := 17; (*Cyclic Object*)
		CST_sysOBJ : USINT := 18; (*System Object*)
		iMaxEntries : UINT := 999; (*Internal number of entries*)
	END_VAR
	VAR
		writeDiff : CustomLogEntry; (*Writes the custom information into the logger*)
		datObjWrite_0 : DatObjWrite; (*Write into a data Object*)
		datObjRead_0 : DatObjRead; (*Read data from a data Object*)
		datObjInfo_0 : DatObjInfo; (*Get the informations from a data object*)
		datObjCopy_0 : DatObjCopy; (*Copy a data object*)
		datObjCreate_0 : DatObjCreate; (*Create a data object*)
		datObjDelete_0 : DatObjDelete; (*Delete a data object*)
		actListElements : UINT; (*Number of entries in the actual list*)
		oldListElements : UINT; (*Number of entries in the old list*)
		newSwListT : BOOL; (*Software list data object present*)
		oldSubStep : USINT;
	END_VAR
END_FUNCTION_BLOCK
