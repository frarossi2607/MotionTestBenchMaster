(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: Powertoys
 * File: CleanMgr.st
 * Author: Administrator
 * Created: January 09, 2015
 ********************************************************************
 * Implementation of library Powertoys
 ********************************************************************) 

(* Clean old files from a folder *)
FUNCTION_BLOCK CleanMgr
	
	IF enable THEN
		(* Function block enabled *)
		CASE step OF
			
			0:
				busy 		:= TRUE;
				ready		:= FALSE;
				error 		:= FALSE;
				errorID 	:= ERR_FUB_BUSY;
				
				(* Getting the input parameters *)
				memset(ADR(dirInfoData), 0, SIZEOF(dirInfoData));
				memset(ADR(oldestFile), 0, SIZEOF(oldestFile));
				tRefresh.PT 		:= refreshTime;
				getDirInfo.pDevice	:= adrPath;
				getDirInfo.pPath	:= ADR('//');
				getLastFileName.pDevice := adrPath;
				getLastFileName.pPath := ADR('//');
				getLastFileName.option := fiFILE;
				getLastFileName.data_len := SIZEOF(dirInfoData);
				deleteFile.pDevice := adrPath;
				step := 1;
				
				IF (refreshTime <= T#10ms) OR (adrPath = 0) OR (nrElements = 0) THEN
					
					(* Refresh time too low, or path address = 0, or numer of elements invalid *)
					step 		:= 200;
					errorStep 	:= 0;
					error 		:= TRUE;
					errorID 	:= ERR_BUR_ILLPAR;
				
					
				END_IF;
				
			1:
				(* Waiting the refresh timer *)
				tRefresh.IN := TRUE;
				
				IF (adrPath <> getDirInfo.pDevice) THEN
					(* Incorrect path address *)
					step 		:= 200;
					errorStep 	:= 1;
					error 		:= TRUE;
					errorID 	:= ERR_BUR_ILLPAR;
				
				ELSIF tRefresh.Q THEN
					
					
					getDirInfo.enable := TRUE;
					IF (getDirInfo.status = ERR_FUB_BUSY) THEN
	 					step := 10;
					END_IF;
					
				END_IF;
			
			10:
				tRefresh.IN := FALSE;
			
				IF (adrPath <> getDirInfo.pDevice) THEN
					(* Incorrect path address *)
					step 		:= 200;
					errorStep 	:= 1;
					error 		:= TRUE;
					errorID 	:= ERR_BUR_ILLPAR;
				
				ELSIF (getDirInfo.status = ERR_OK) THEN
					fileFound := getDirInfo.filenum;
					step := 11;
				
				ELSIF (getDirInfo.status <> ERR_OK) AND (getDirInfo.status <> ERR_FUB_BUSY) THEN
					
					(* Error *)
					step 		:= 200;
					errorStep 	:= 10;
					error 		:= TRUE;
					errorID 	:= getDirInfo.status;
				END_IF;
			
			11:
				IF (getDirInfo.filenum > nrElements) THEN
					
					(* Proceeding with cleanup *)
					step := 20;
				ELSE
					step := 0;
				END_IF;
				getDirInfo.enable	:= FALSE;
			
			20:
				(* Clean up, finding the oldest file *)
				memset(ADR(dirInfoData), 0, SIZEOF(dirInfoData));
				memset(ADR(oldestFile), 0, SIZEOF(oldestFile));
				cnt := 0;
				getLastFileName.entry := cnt;
				getLastFileName.pData := ADR(oldestFile);
				IF (adrPath <> getLastFileName.pDevice) THEN
					(* Incorrect path address *)
					step 		:= 200;
					errorStep 	:= 20;
					error 		:= TRUE;
					errorID 	:= ERR_BUR_ILLPAR;
				ELSE
					getLastFileName.enable := TRUE;
					step := 21;
				END_IF
			
			21:
				IF (adrPath <> getLastFileName.pDevice) THEN
					(* Incorrect path address *)
					step 		:= 200;
					errorStep 	:= 21;
					error 		:= TRUE;
					errorID 	:= ERR_BUR_ILLPAR;
					
				ELSIF (getLastFileName.status = ERR_OK) THEN
					memset(ADR(dirInfoData), 0, SIZEOF(dirInfoData));
					getLastFileName.enable := FALSE;
					step := 22;
					
				ELSIF ((getLastFileName.status <> ERR_OK) AND (getLastFileName.status <> ERR_FUB_BUSY)) THEN
					(* Error *)
					step 		:= 200;
					errorStep 	:= 20;
					error 		:= TRUE;
					errorID 	:= getLastFileName.status;
				END_IF;
			
			22:
				
				getLastFileName.pData := ADR(dirInfoData);
				cnt := cnt + 1;
				getLastFileName.entry := cnt;
				
				IF (cnt < fileFound) THEN
					
					step := 23;
					
				ELSE
					(* search finished *)
					step := 30;
				END_IF;
				
			
			23:
				getLastFileName.enable := TRUE;
				IF (adrPath <> getLastFileName.pDevice) THEN
					(* Incorrect path address *)
					step 		:= 200;
					errorStep 	:= 23;
					error 		:= TRUE;
					errorID 	:= ERR_BUR_ILLPAR;
					
				
				ELSIF (getLastFileName.status = ERR_OK) THEN
					getLastFileName.enable := FALSE;
					step := 24;
					
				ELSIF ((getLastFileName.status <> ERR_OK) AND (getLastFileName.status <> ERR_FUB_BUSY) AND (getLastFileName.status <> ERR_FUB_ENABLE_FALSE)) THEN
					(* Error *)
					step 		:= 200;
					errorStep 	:= 22;
					error 		:= TRUE;
					errorID 	:= getLastFileName.status;
				END_IF;
			
			24:
				(* Checking the file timestamp *)
				IF (dirInfoData.Date < oldestFile.Date) THEN
					memcpy(ADR(oldestFile), ADR(dirInfoData), SIZEOF (oldestFile));
					
				END_IF;
			
				memset(ADR(dirInfoData),0,SIZEOF (dirInfoData));
				step := 22;
			
			
			30:
				(* Search finished, deleting the oldest file *)
				deleteFile.pName := ADR(oldestFile.Filename[0]);
				deleteFile.enable := TRUE;
				IF (adrPath <> deleteFile.pDevice) THEN
					(* Incorrect path address *)
					step 		:= 200;
					errorStep 	:= 30;
					error 		:= TRUE;
					errorID 	:= ERR_BUR_ILLPAR;
				ELSIF (deleteFile.status = ERR_OK) THEN
					deleteFile.enable := FALSE;
					IF (fileFound - 1 > nrElements) THEN
						getDirInfo.enable := TRUE;
						step := 10;
					ELSE
						step := 0;
					END_IF;
					
				ELSIF (deleteFile.status <> ERR_OK) AND (deleteFile.status <> ERR_FUB_ENABLE_FALSE) AND (deleteFile.status <> ERR_FUB_BUSY) THEN
					(* Error *)
					step 		:= 200;
					errorStep 	:= 30;
					error 		:= TRUE;
					errorID 	:= deleteFile.status;
				END_IF;
			
			
			200:
				(* Error state, resetting all the internal function block *)
				tRefresh.IN				:= FALSE;
				getDirInfo.enable		:= FALSE;
				getLastFileName.enable	:= FALSE;
				deleteFile.enable		:= FALSE;
				
		END_CASE;
		
	ELSE
	
		(* Function block disabled, resetting all the internal fubs *)
		busy 		:= FALSE;
		ready		:= FALSE;
		error 		:= TRUE;
		errorID 	:= ERR_FUB_ENABLE_FALSE;
		
		step 		:= 0;
		errorStep 	:= 0;
		cnt 		:= 0;
		tRefresh.IN				:= FALSE;
		getDirInfo.enable		:= FALSE;
		getLastFileName.enable	:= FALSE;
		deleteFile.enable		:= FALSE;
	END_IF;
	
	tRefresh();
	getDirInfo();
	getLastFileName();
	deleteFile();
END_FUNCTION_BLOCK