(********************************************************************
 * COPYRIGHT --  Sidel S.p.a.
 ********************************************************************
 * Program: ETHIP_COM
 * File: ETHIP_COM_Error.st
 * Author: Andrea.Cortesi
 * Created: August 26, 2015
 ********************************************************************
 * Implementation of program ETHIP_COM
 ********************************************************************) 

ACTION ETHIP_COM_Error:
	
	CASE Status OF
	
		0    : Msg_Error := 'No Error';
		55100: Msg_Error := 'Error Enable Library File_CSV Not Coerent';
		55101: Msg_Error := 'Error File CSV Actual is Empty (size zero)';
		55102: Msg_Error := 'Error File CSV Old is Empty (size zero)';
		55103: Msg_Error := 'Force Exit from Sequencer Library FILE_CSV';
		55104: Msg_Error := 'File CSV Saved - No Error';
		55105: Msg_Error := 'File CSV Loaded - No Error';
		55106: Msg_Error := 'Error Step Sequencer in Library FILE_CSV';
		55150: Msg_Error := 'Reset Error Communication Library';
		9999 : Msg_Error := 'FUNCTION NOT implemented'; 
		20700: Msg_Error := 'Invalid path; check the path specification (AND length OF path)'; 
		20701: Msg_Error := 'The specified data length is too small'; 
		20702: Msg_Error := 'No more file handles available'; 
		20703: Msg_Error := 'Code error (system error)'; 
		20704: Msg_Error := 'Invalid TYPE'; 
		20705: Msg_Error := 'File already exists'; 
		20706: Msg_Error := 'ACCESS NOT possible using the desired mode'; 
		20707: Msg_Error := 'FiERR_MODE  Illegal mode'; 
		20708: Msg_Error := 'File does NOT exist'; 
		20709: Msg_Error := 'Illegal file device (e.g. not initialized "CPU -> Properties -> File Devices")'; 
		20710: Msg_Error := 'NOT enough memory FOR file with new write data'; 
		20711: Msg_Error := 'Invalid file offset'; 
		20712: Msg_Error := 'File NOT allowed';
		20713: Msg_Error := 'NOT enough memory (DRAM) available TO copy file';  
		20714: Msg_Error := 'General error in FileOpen'; 
		20715: Msg_Error := 'General error in FileClose'; 
		20716: Msg_Error := 'General error in FileRead'; 
		20717: Msg_Error := 'General error in FileWrite'; 
		20718: Msg_Error := 'General error in Ioctl'; 
		20719: Msg_Error := 'The specified POINTER is invalid (NULL)';
		20720: Msg_Error := 'Error in the FileIO manager'; 
		20721: Msg_Error := 'File NOT open'; 
		20722: Msg_Error := 'Invalid directory'; 
		20723: Msg_Error := 'Directory does NOT exist'; 
		20724: Msg_Error := 'Directory NOT empty'; 
		20725: Msg_Error := 'Directory already exists'; 
		20726: Msg_Error := 'Error retrieving memory information'; 
		20727: Msg_Error := 'NOT enough memory available on the target device (FileCopy)'; 
		20728: Msg_Error := 'Idents directory no longer available. Close open directories (or free up memory)'; 
		20729: Msg_Error := 'Invalid parameter output'; 
		20730: Msg_Error := 'Directory already exists'; 
		20731: Msg_Error := 'The specified handle is invalid'; 
		20732: Msg_Error := 'Another IP address has already been defined FOR a host name'; 
		20796: Msg_Error := 'Could NOT initialize library'; 
		20797: Msg_Error := 'Error in device driver'; 
		20798: Msg_Error := 'Error in device manager'; 
		20799: Msg_Error := 'System error.General system fault'; 
		32051: Msg_Error := 'Out of memory. The library cannot be executed';
		32052: Msg_Error := 'Configuration data object error';
		32053: Msg_Error := 'Illegal input parameters connected to the Function block';
		32054: Msg_Error := 'Ethernet interface not exist or in error.Check #OWNINTERFACE data object';
		32750: Msg_Error := 'No response sent by station within the specified timeout';
		32751: Msg_Error := 'The specified IP address (SG4: name also) could not be resolved';
		32752: Msg_Error := 'Resource problem in system. Could not create new sockets';
		32799: Msg_Error := 'System error';
		65534: Msg_Error := 'Function block was called with enable at FALSE'; 
		65535: Msg_Error := 'Function block continue calling'; 

	ELSE
	
			   Msg_Error := 'Error not management';	
			
	END_CASE	
	
	
	// Buffer Status for Diagnostic
	IF ((Status <> Status_Old) OR ((strcmp(ADR(Step_Msg_Active),ADR(Step_Msg_Active_Old))) <> 0)) AND (Buffer_Status_Index < Buffer_Status_MaxLimit) THEN
		itoa(UINT_TO_DINT(Status),ADR(Status_String));
		Status_String                      := CONCAT(Status_String,': ');
		Status_String                      := CONCAT(Status_String,Step_Msg_Active);
		Status_String                      := CONCAT(Status_String,': ');
		Buffer_Status[Buffer_Status_Index] := CONCAT(Status_String,Msg_Error);
		Buffer_Status_Index                := (Buffer_Status_Index + 1);	
				
		// Update Status Old if Change
		IF (Status <> Status_Old) THEN
			Status_Old := Status;
		END_IF
		// Update Step Msg active Old if Changed
		IF ((strcmp(ADR(Step_Msg_Active),ADR(Step_Msg_Active_Old))) <> 0) THEN
		    Step_Msg_Active_Old := Step_Msg_Active;
		END_IF
		// Reset Buffer Status if is Fu
		IF (Buffer_Status_Index = Buffer_Status_MaxLimit) THEN
		    // Reset Buffer and Status
		    Buffer_Status_Index      := 0;
			Status_Old               := 0;
			Step_Msg_Active_Old      := '';
		    memset(ADR(Buffer_Status),0,SIZEOF(Buffer_Status));
		END_IF
		
	END_IF	
	
		
END_ACTION