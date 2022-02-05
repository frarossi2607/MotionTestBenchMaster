(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: Powertoys
 * File: profiMan.st
 * Author: Administrator
 * Created: July 24, 2014
 ********************************************************************
 * Implementation of library Powertoys
 ********************************************************************) 

(* Profiler archive manager *)

FUNCTION_BLOCK profiMan
	
	IF enable THEN
		
		CASE step OF
		
			(* GETTING THE PROFILER STATUS *)
			0:
				refresh.IN := FALSE;
				IF (getProfStatus.status = ERR_FUB_ENABLE_FALSE) THEN
					step := 1;
				END_IF;	
			
			1:
				getProfStatus.enable := TRUE;

				IF (getProfStatus.status = ERR_OK) THEN
					step := 2;
					profilerStatus := getProfStatus.logstate;
				
				ELSIF (getProfStatus.status <> ERR_OK) AND (getProfStatus.status <> ERR_FUB_BUSY) AND (getProfStatus.status <> ERR_FUB_ENABLE_FALSE) THEN
					
					(* An error occured *)
					step		:= 200;
					errorStep	:= 1;
					error 		:= TRUE;
					errorID		:= getProfStatus.status;
				END_IF;
		
			2:
				profStateInactive	:= FALSE;
				profStateActive		:= FALSE;
				profStateStopped	:= FALSE;
				profStateRunning	:= FALSE;
				profStateReady		:= FALSE;
				profStateR2R		:= FALSE;
				profStateR2Rman		:= FALSE;
			
				CASE profilerStatus OF
				
					profSTATE_INACTIVE:
						(* Profiler inactive. Profiling cannot be carried out (AR profiler disabled in Sysconf). *)
						profStateInactive	:= TRUE;
				
					profSTATE_ACTIVE:
						(* Profiler active. AR profiler is ready. *)
						profStateActive		:= TRUE;
					
					profSTATE_STOPPED:
						(* Data recording stopped. *)
						profStateStopped	:= TRUE;
				
					profSTATE_RUNNING:
						(* Data being recorded. *)
						profStateRunning	:= TRUE;
					
					profSTATE_READY:
						(* Data recording completed. The data module is ready to be evaluated (AS profiler). *)
						profStateReady		:= TRUE;
					
					profSTATE_R2R:
						(* Ready to start. A profiling definition was installed successfully and can be started. *)
						profStateR2R		:= TRUE;
					
					profSTATE_R2R_MAN:
						(* Ready to start (startup install). The profiler definition was installed successfully with the profMODE_NOAUTOSTART mode and can be started. *)
						profStateR2Rman		:= TRUE;
					

				END_CASE;
			
				getProfStatus.enable := FALSE;
			
				IF (getProfStatus.status = ERR_FUB_ENABLE_FALSE) AND (getProfArchInfo.status = ERR_FUB_ENABLE_FALSE) THEN
					step := 3;
				END_IF;
			
		
			
			3:
				(* Checking that the archivwe list address is different than 0 *)
				IF (archiveListADR <> 0) AND (refreshTime <> 0) THEN
	 
					(* There is a memory address *)
					step := 4;
					
				ELSE
					
					(* Address invalid *)
					errorStep	:= 3;
					step 		:= 200;
					error		:= TRUE;
					busy		:= FALSE;
					valid		:= FALSE;
					errorID		:= ERR_NOTIMPLEMENTED;
					
				END_IF;
				
		4:		(* List te number of profiler archives *)
				getProfArchInfo.enable		:= TRUE;
				getProfArchInfo.pInfo		:= archiveListADR;
				getProfArchInfo.maxEntries	:= maxArchive;
				
				IF (getProfArchInfo.status = ERR_FUB_BUSY) THEN
					step := 5;
				ELSIF (getProfArchInfo.status <> ERR_OK) AND (getProfArchInfo.status <> ERR_FUB_BUSY) AND (getProfArchInfo.status <> ERR_FUB_ENABLE_FALSE) THEN
					step 		:= 200;
					errorStep	:= 4;
					error 		:= TRUE;
					errorID 	:= getProfArchInfo.status;
					busy 		:= FALSE;
					valid		:= FALSE;
					
					
				END_IF;
				
			5:
				IF (getProfArchInfo.status = ERR_OK) THEN
					step := 6;
					archiveFound := getProfArchInfo.entries;
					
				ELSIF (getProfArchInfo.status <> ERR_OK) AND (getProfArchInfo.status <> ERR_FUB_BUSY) AND (getProfArchInfo.status <> ERR_FUB_ENABLE_FALSE) THEN
					step 		:= 200;
					errorStep	:= 5;
					error 		:= TRUE;
					errorID 	:= getProfArchInfo.status;
					busy 		:= FALSE;
					valid		:= FALSE;
				END_IF;
			
			6:
				
				getProfArchInfo.enable	:= FALSE;
				
				
				(* Checking if I have to delete some old profiler archive *)
				refresh.IN := TRUE;
				refresh.PT := refreshTime;
			
				IF (refresh.Q = TRUE) THEN
					step := 0;
				
				END_IF;

			200:
				getProfStatus.enable 	:= FALSE;
				refresh.IN 				:= FALSE;
				getProfArchInfo.enable	:= FALSE;
			
		END_CASE;
		
	ELSE
		
		busy			:= FALSE;
		error			:= TRUE;
		errorID			:= ERR_FUB_ENABLE_FALSE;
		valid			:= FALSE;
		profilerStatus	:= 254;
		
		step 			:= 0;
		errorStep		:= 0;
		archiveFound	:= 0;
		
		profStateInactive	:= FALSE;
		profStateActive		:= FALSE;
		profStateStopped	:= FALSE;
		profStateRunning	:= FALSE;
		profStateReady		:= FALSE;
		profStateR2R		:= FALSE;
		profStateR2Rman		:= FALSE;
		
		(* Disabling alla the used FUNCTION blocks *)
		refresh.IN				:= FALSE;
		getProfStatus.enable	:= FALSE;
		
		getProfArchInfo.enable	:= FALSE;
		
		
	END_IF;

	
	
	getProfStatus();
	refresh();
	getProfArchInfo();
	
END_FUNCTION_BLOCK