(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: Powertoys
 * File: Powertoys.fun
 * Author: gibertinim
 * Created: March 27, 2014
 ********************************************************************
 * Functions and function blocks of library Powertoys
 ********************************************************************)

FUNCTION_BLOCK CustomLogEntry (*Write a custom entry into the specified logger*)
	VAR_INPUT
		enable : BOOL; (*Enable the function block*)
		adrCustomEntry : UDINT; (*Address of the custom entry*)
	END_VAR
	VAR_OUTPUT
		busy : BOOL; (*True when the function block is busy*)
		error : BOOL; (*True when the function block is in error*)
		errorID : DINT; (*Current error ID*)
		done : BOOL; (*True when the entry is succesfully written*)
	END_VAR
	VAR
		LogCreate : ArEventLogCreate;
		LogInfo : ArEventLogGetIdent; (*Get the information from the specified logger*)
		LogWrite : ArEventLogWrite; (*Write the entry into the logger*)
		eventID : DINT;
		errorStep : UINT; (*Internal error step*)
		pEntry : REFERENCE TO pwr_log_custom_entry; (*Pointer to the custom entry*)
		step : USINT; (*Internal fub step*)
		LogIdent : ArEventLogIdentType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK SearchIO (*Function Block to show hardware list component*)
	VAR_INPUT
		enable : BOOL; (*Enable the function block*)
		adrSearchIO : UDINT; (*Address of the search io data structure*)
		wholeList : BOOL; (*True to create the hw list, false for a single entries*)
		stationIndex : UDINT; (*Station index number (used only if wholeList = FALSE)*)
		mode : UDINT; (*Operating mode*)
	END_VAR
	VAR_OUTPUT
		busy : BOOL; (*True when the function block is busy*)
		done : BOOL; (*True when the data are ready*)
		error : BOOL; (*True when the function block is in error*)
		errorID : UINT; (*Current error ID*)
		nrEntries : UDINT; (*Number of entries found*)
	END_VAR
	VAR
		counter : UDINT; (*Internal counter*)
		ident : UDINT; (*Identifier*)
		FB_DiagGetStrInfo : DiagGetStrInfo; (*Get the string information of the module*)
		FB_DiagCreateInfo : DiagCreateInfo; (*Collect the information of the specified module*)
		FB_DiagGetNumInfo : DiagGetNumInfo; (*Get the numeric information from the specified module*)
		step : USINT; (*Internal fub step*)
		errorStep : USINT; (*Internal error step*)
		pData : REFERENCE TO searchIO_info_typ; (*Pointer to the data structure*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK PlkList (*Powerlink list*)
	VAR_INPUT
		enable : BOOL; (*Enable the function block*)
		adrPlkInfo : UDINT; (*Address of the powerlink information list*)
		mode : USINT; (*Fub operating mode (0 high memory usage, 1 low memory usage)*)
		nrEntry : UDINT; (*Number of powerlink elements to write on the list*)
		plkInterface : STRING[80]; (*String initialize a lenght of powerlink path*)
	END_VAR
	VAR_OUTPUT
		done : BOOL; (*Powerlink list complete*)
		busy : BOOL; (*Function block busy*)
		error : BOOL; (*Function block in error*)
		errorID : UINT; (*Function block error ID*)
		entryFound : USINT; (*Number of powerlink node in the configuration*)
	END_VAR
	VAR
		errorStep : USINT; (*Internal error step*)
		step : USINT; (*Internal step*)
		pData : REFERENCE TO pwlInfo_typ; (*Pointer to the powerlink list*)
		searchIO_0 : SearchIO; (*Search IO informations*)
		searchIoData : ARRAY[0..253] OF searchIO_info_typ; (*Search IO informations strusture*)
		arrayIndexPwl : ARRAY[0..253] OF USINT; (*Array to save index of hardware list complete*)
		arrayIndexPwl2 : ARRAY[0..253] OF USINT; (*Array to save index when dot is not finding*)
		ArrayStringTemp : ARRAY[0..253] OF STRING[80]; (*Array temp for saving name of powerlink node longer than plkinterface*)
		ArrayStringTemp2 : ARRAY[0..253] OF STRING[80]; (*Array to save path name when dot is not finding*)
		indexInfo : USINT; (*Index of number entries of harware list complete*)
		tmpPlkInterface : STRING[80]; (*Internal powerlink interface name*)
		indexPwl : USINT; (*Index of array for saving name of powerlink node longer than plkinterface*)
		oldIndexPwl : USINT; (*savind old index powerlink*)
		indexPwl2 : USINT; (*Index of array when dot is not finding*)
		dotFound : BOOL; (*Finding dot inside an array*)
		nrIO : UDINT; (*Number of IO found with the SEARCH IO fub*)
		tmpCnt : USINT; (*Temporary counter*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK profiMan (*Profiler archive manager*)
	VAR_INPUT
		enable : BOOL; (*Enable the function block*)
		refreshTime : TIME; (*Automatic refresh time*)
		maxArchive : USINT; (*Maximum number of profiler acrhive stored*)
		archiveListADR : UDINT; (*Address of the archive list*)
	END_VAR
	VAR_OUTPUT
		errorID : UINT; (*Current error ID*)
		valid : BOOL; (*True when the output data are valid*)
		error : BOOL; (*True when the function block is in error*)
		profilerStatus : USINT; (*Profiler status*)
		archiveFound : UDINT; (*Number of profiler archive found*)
		busy : BOOL; (*True when the function block is busy*)
		profStateActive : BOOL; (*Profiler active. AR profiler is ready.*)
		profStateStopped : BOOL; (*Data recording stopped.*)
		profStateRunning : BOOL; (*Data being recorded.*)
		profStateReady : BOOL; (*Data recording completed. The data module is ready to be evaluated (AS profiler).*)
		profStateR2R : BOOL; (*Ready to start. A profiling definition was installed successfully and can be started.*)
		profStateInactive : BOOL; (*Profiler inactive. Profiling cannot be carried out (AR profiler disabled in Sysconf).*)
		profStateR2Rman : BOOL; (*Ready to start (startup install). The profiler definition was installed successfully with the profMODE_NOAUTOSTART mode and can be started.*)
	END_VAR
	VAR
		pArchiveList : REFERENCE TO PROFILER_MODINFO; (*Pointer to the archive list*)
		step : USINT; (*Internal state machine step*)
		getProfStatus : LogStateGet; (*Get the status of the profiler*)
		errorStep : USINT; (*Internal error step*)
		getProfArchInfo : LogArchInfo; (*Gets profiler's archive informations*)
		refresh : TON; (*Refresh timer*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK sdmMAN (*Sdm configuration manager*)
	VAR_INPUT
		enable : BOOL; (*Enable the function block*)
		mode : USINT; (*Function block operating mode: 0 - SDM on, 1 - SDM off, 2 SDM status manual*)
		reqSDMstatus : UDINT; (*Requested SDM status*)
		pDumpDevice : UDINT; (*Pointer to the file device of the system dump*)
	END_VAR
	VAR_OUTPUT
		sdmStatus : UDINT; (*Actual SDM status*)
		busy : BOOL; (*True when the function block is working*)
		ready : BOOL; (*True when the function block is waiting for a change of reqSDMstatus*)
		error : BOOL; (*True when the function block is in error*)
		errorID : UINT; (*Actual error ID*)
		internalError : BOOL; (*Internal error*)
		errorStep : USINT; (*Actual error step*)
	END_VAR
	VAR
		old_mode : USINT; (*Old mode*)
		setSDMstatus : CfgSetSdmStatus; (*Set the sdm status*)
		getSDMstatus : CfgGetSdmStatus; (*Get the sdm status*)
		oldSdmStatus : UDINT; (*Old SDM status*)
		step : USINT; (*Internal function block step*)
		writeLogFlag : BOOL; (*Write an entry into the logger*)
		errorStepString : STRING[80]; (*Error step as string*)
		errorString : STRING[80]; (*Error string*)
		errorEntry : pwr_log_custom_entry; (*Log entry*)
		sDump : SdmSystemDump; (*Makes the system dump*)
		writeError : CustomLogEntry; (*Write the error into the user logger*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK CleanMgr (*Clean old files from a folder*)
	VAR_INPUT
		enable : BOOL; (*Enable the function block*)
		refreshTime : TIME; (*Folder refresh time*)
		adrPath : UDINT; (*Address of the path to clean*)
		nrElements : UDINT; (*Number of elements to keep into the folder*)
	END_VAR
	VAR_OUTPUT
		busy : BOOL; (*True when then the function block is busy*)
		ready : BOOL; (*True when the function block is ready*)
		error : BOOL; (*True when the function block is in error*)
		errorID : UINT; (*Function block error ID*)
	END_VAR
	VAR
		cnt : UDINT; (*Internal counter*)
		oldestFile : fiDIR_READ_DATA; (*Oldest filename*)
		fileFound : UDINT; (*Number of file found*)
		dirInfoData : fiDIR_READ_DATA; (*Information red*)
		step : USINT; (*Internal step*)
		errorStep : USINT; (*Internal error step*)
		tRefresh : TON; (*Refresh timer*)
		getLastFileName : DirRead; (*Get the last filename*)
		deleteFile : FileDelete; (*Delete one file*)
		getDirInfo : DirInfo; (*Get the directory informations*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK saveNCT (*Save the network comand trace into one file*)
	VAR_INPUT
		enable : BOOL; (*Enable the function block*)
		fName : STRING[32]; (*Output filename*)
		mode : USINT; (*0 - Filename only, 1 - Filename with timestamp*)
		deviceName : STRING[32]; (*Device name*)
	END_VAR
	VAR_OUTPUT
		busy : BOOL; (*True when the function block is busy*)
		done : BOOL; (*True when the function block has finished to work*)
		error : BOOL; (*True when the function block is in error*)
		traceError : MC_ERRORRECORD_REF; (*Trace recorded error*)
		errorStep : USINT; (*Error Step*)
		errorID : UINT; (*Actual error ID*)
	END_VAR
	VAR
		NetTraceConfig : MC_NETTRACECONFIG_REF; (*Network command trace upload config*)
		NetTraceStatusConfig : MC_NETTRACECONFIG_REF; (*Network command trace status configuration*)
		MC_BR_ReadNetTraceStatus_0 : MC_BR_ReadNetTraceStatus; (*Network command trace status*)
		MC_BR_NetTrace_0 : MC_BR_NetTrace; (*Network command trace management fub*)
		step : USINT; (*Internal step*)
	END_VAR
END_FUNCTION_BLOCK
