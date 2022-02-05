(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: Powertoys
 * File: swChg.st
 * Author: Massimo Gibertini
 * Created: August 07, 2014
 ********************************************************************
 * Implementation of library Powertoys
 ********************************************************************) 

(* Monitor and write into the user logger the canges of the software objects *)
FUNCTION_BLOCK SwChg
	
	IF (enable = TRUE) THEN
		customEntry.logLevel 		:= logLevel;
		waitWrite.PT				:= T#10m;
		
		CASE step OF
			
			0:
				(* Getting the software list *)
				busy			:= TRUE;
				searching		:= FALSE;
				writingLog		:= FALSE;
				waiting			:= FALSE;
				scan			:= TRUE;
				error			:= FALSE;
				errorID			:= ERR_FUB_BUSY;
				
				CASE substep OF
				
					0:
						memset(ADR(tempModule),0,SIZEOF(tempModule));
						memset(ADR(iActList),0,SIZEOF(iActList));
						memset(ADR(iOldList),0,SIZEOF(iOldList));
						
						(* Checking if the swList temporary data object exist in the userRam or not*)
						datObjInfo_0.pName 	:= ADR(swListTempDataObjName);
						datObjInfo_0.enable	:= TRUE;
						substep 			:= 1;
					
						
					1:
						datObjInfo_0();
						IF (datObjInfo_0.status = doERR_MODULNOTFOUND) THEN
							(* Temporary data object not found *)
							swListTempID	:= 0;
							substep			:= 5;
						ELSIF (datObjInfo_0.status = ERR_OK) THEN
							(* Data object found *)
							swListTempID	:= datObjInfo_0.ident;
							//substep			:= 2;
							substep			:= 5;
						ELSIF (datObjInfo_0.status <> ERR_OK) AND (datObjInfo_0.status <> doERR_MODULNOTFOUND) AND (datObjInfo_0.status <> ERR_FUB_BUSY) THEN
							errorID			:= datObjInfo_0.status;
							errorStep		:= step;
							errorSubStep	:= substep;
							step 			:= 200;
							substep			:= 0;
						END_IF;
					
					
					2:
						datObjInfo_0.enable	:= FALSE;
						datObjInfo_0();
						IF (datObjInfo_0.status = ERR_FUB_ENABLE_FALSE) THEN
							substep			:= 3;
						END_IF;
					
					3:
						(* Delete the temporary data object *)
						datObjDelete_0.ident	:= swListTempID;
						datObjDelete_0.enable	:= TRUE;
						substep					:= 4;

						
						
					4:
						datObjDelete_0();
						IF (datObjDelete_0.status = ERR_OK) THEN
							substep			:= 5;
							swListTempID	:= 0;
						ELSIF (datObjDelete_0.status <> ERR_OK) AND (datObjDelete_0.status <> ERR_FUB_BUSY) THEN
							errorID			:= datObjDelete_0.status;
							errorStep		:= step;
							errorSubStep	:= substep;
							step 			:= 200;
							substep			:= 0;
						END_IF;
					
					5:
						(* Disable fub *)
						datObjDelete_0.enable	:= FALSE;
						datObjDelete_0();
						datObjInfo_0.enable	:= FALSE;
						datObjInfo_0();
						IF (datObjDelete_0.status = ERR_FUB_ENABLE_FALSE) AND (datObjInfo_0.status = ERR_FUB_ENABLE_FALSE) THEN
							substep				:= 6;
						END_IF;
					
					6:
						(* temporary data object not present or deleted *)
						(* Checking if the swList data object exist or not *)
						datObjInfo_0.pName 	:= ADR(swListDatObjName);
						datObjInfo_0.enable	:= TRUE;
						datObjInfo_0();
						IF (datObjInfo_0.status <> ERR_FUB_BUSY) AND (datObjInfo_0.status <> ERR_FUB_ENABLE_FALSE) THEN
							substep := 7;
						END_IF;
						
						
					7:
						datObjInfo_0();
						IF (datObjInfo_0.status = doERR_MODULNOTFOUND) THEN
							(* Data object not found *)
							swListID		:= 0;
							substep			:= 100;
						ELSIF (datObjInfo_0.status = doERR_CHECKSUM_WARNING) THEN
							swListID		:= datObjInfo_0.ident;
							substep			:= 10;
						ELSIF (datObjInfo_0.status = ERR_OK) THEN
							(* Data object found *)
							swListID		:= datObjInfo_0.ident;
							IF (swListTempID = 0) THEN
								substep			:= 50;
							ELSE
								substep 		:= 150;
							END_IF;
							
						ELSIF (datObjInfo_0.status <> ERR_OK) AND (datObjInfo_0.status <> doERR_CHECKSUM_WARNING) AND (datObjInfo_0.status <> doERR_MODULNOTFOUND) AND (datObjInfo_0.status <> ERR_FUB_BUSY) THEN
							errorID			:= datObjInfo_0.status;
							errorStep		:= step;
							errorSubStep	:= substep;
							step 			:= 200;
							substep			:= 0;
						END_IF;
					
					(* Data object damaged, deleting *)
					10:
						datObjInfo_0.enable	:= FALSE;
						datObjInfo_0();
						IF (datObjInfo_0.status = ERR_FUB_ENABLE_FALSE) THEN
							substep			:= 11;
						END_IF;
					
					11:
						datObjDelete_0.ident	:= swListID;
						datObjDelete_0.enable	:= TRUE;
						datObjDelete_0();
						IF (datObjDelete_0.status <> ERR_FUB_BUSY) AND (datObjDelete_0.status <> ERR_FUB_ENABLE_FALSE) THEN
							substep 				:= 12;
						END_IF;
						
					
					12:
						datObjDelete_0();
						IF (datObjDelete_0.status = ERR_OK) THEN
							substep				:= 13;
						ELSIF (datObjDelete_0.status <> ERR_OK) AND (datObjDelete_0.status <> ERR_FUB_BUSY) THEN
							errorID				:= datObjDelete_0.status;
							errorStep			:= step;
							errorSubStep		:= substep;
							step 				:= 200;
							substep				:= 0;
						END_IF;
				
					13:
						datObjDelete_0.enable	:= FALSE;
						datObjDelete_0();
						IF (datObjDelete_0.status = ERR_FUB_ENABLE_FALSE) THEN
							(* No existing data object *)
							substep 			:= 100;
							swListID 			:= 0;
						END_IF;
				
					50:
						(* swList data object present, copy to DRam *)
						datObjInfo_0.enable			:= FALSE;
						datObjCopy_0.ident 			:= swListID;
						datObjCopy_0.pNameTarget 	:= ADR(swListTempDataObjName);
						datObjCopy_0.MemTypeTarget	:= doTEMP;
						datObjCopy_0.enable			:= TRUE;
						datObjCopy_0();
						substep := 51;
					
					51:
						datObjCopy_0();
						IF (datObjCopy_0.status = ERR_OK) THEN
							substep 				:= 52;
							swListTempID			:= datObjCopy_0.identNew;
						ELSIF (datObjCopy_0.status <> ERR_OK) AND (datObjCopy_0.status <> ERR_FUB_BUSY) THEN
							errorID					:= datObjCopy_0.status;
							errorStep				:= step;
							errorSubStep			:= substep;
							step 					:= 200;
							substep					:= 0;
						END_IF;
					
					52:
						datObjCopy_0.enable			:= FALSE;
						datObjCopy_0();
						IF (datObjCopy_0.status = ERR_FUB_ENABLE_FALSE) THEN
							(* Temporary Data object recovered succesfully *)
							substep					:= 150;
						
						END_IF;
				 
					100: 
						(* Creating the temporary data object*)
						IF (swListTempID = 0) THEN
							datObjInfo_0.enable		:= FALSE;
							datObjCreate_0.grp		:= 0;
							datObjCreate_0.pName	:= ADR(swListTempDataObjName);
							datObjCreate_0.len		:= SIZEOF(iActList);
							datObjCreate_0.MemType	:= doTEMP;
							datObjCreate_0.Option	:= doNO_CS;
							datObjCreate_0.pCpyData	:= ADR(iActList);
							datObjCreate_0.enable	:= TRUE;
							datObjCreate_0();
							substep					:= 101;
						ELSE
							substep					:= 110;
						END_IF;
						
					
					
					101:
						datObjCreate_0();
						IF (datObjCreate_0.status = ERR_OK) THEN
							substep				:= 102;
							swListTempID		:= datObjCreate_0.ident;
							newSwListT			:= TRUE;
						ELSIF (datObjCreate_0.status <> ERR_OK) AND (datObjCreate_0.status <> ERR_FUB_BUSY) THEN
							errorID				:= datObjCreate_0.status;
							errorStep			:= step;
							errorSubStep		:= substep;
							step 				:= 200;
							substep				:= 0;
						END_IF;
						
					102:
						datObjCreate_0.enable	:= FALSE;
						datObjCreate_0();
						IF (datObjCreate_0.status = ERR_FUB_ENABLE_FALSE) THEN
							substep				:= 110;
							
						END_IF;
						
					
					110:
						(* Creating the cf data object*)
						datObjCreate_0.grp		:= 0;
						datObjCreate_0.pName	:= ADR(swListDatObjName);
						datObjCreate_0.len		:= SIZEOF(iOldList);
						datObjCreate_0.MemType	:= doUSRROM;
						datObjCreate_0.Option	:= 0;
						datObjCreate_0.pCpyData	:= ADR(iOldList);
						datObjCreate_0.enable	:= TRUE;
						substep					:= 112;
						
						
					
					112:
						datObjCreate_0();
						IF (datObjCreate_0.status = ERR_OK) THEN
							substep					:= 113;
							swListID				:= datObjCreate_0.ident;
							datObjCreate_0.enable	:= FALSE;
						ELSIF (datObjCreate_0.status <> ERR_OK) AND (datObjCreate_0.status <> ERR_FUB_BUSY) THEN
							errorID					:= datObjCreate_0.status;
							errorStep				:= step;
							errorSubStep			:= substep;
							step 					:= 200;
							substep					:= 0;
						END_IF;
					
					113:
						datObjCreate_0.enable		:= FALSE;
						datObjCreate_0();
						IF (datObjCreate_0.status = ERR_FUB_ENABLE_FALSE) AND newSwListT THEN
							substep					:= 200;
							oldListElements			:= 0;
						ELSIF (datObjCreate_0.status = ERR_FUB_ENABLE_FALSE) AND NOT (newSwListT) THEN
							substep					:= 150;
							oldListElements			:= 0;
						END_IF;
						
					
					
					150:
						(* Loading the existing temporary data object *)
						datObjRead_0.ident			:= swListTempID;
						datObjRead_0.Offset			:= 0;
						datObjRead_0.pDestination	:= ADR(iOldList);
						datObjRead_0.len			:= SIZEOF(iOldList);
						datObjRead_0.enable			:= TRUE;
						datObjRead_0();
						substep						:= 151;
						
						
					151:
						
						datObjRead_0();
						IF (datObjRead_0.status = ERR_OK) THEN
							substep					:= 152;
						ELSIF (datObjRead_0.status <> ERR_OK) AND (datObjRead_0.status <> ERR_FUB_BUSY)	THEN
							errorID					:= datObjRead_0.status;
							errorStep				:= step;
							errorSubStep			:= substep;
							step 					:= 200;
							substep					:= 0;
						END_IF;
						
					
					152:
						datObjRead_0.enable			:= FALSE;
						datObjRead_0();
						IF (datObjRead_0.status = ERR_FUB_ENABLE_FALSE) THEN
							oldListElements 		:= 0;
							substep 				:= 153;
						END_IF;
						
				
					153:
						(* Listing the number of entries in the old list *)
						memset(ADR(tempString),0,SIZEOF(tempString));
						memcpy(ADR(tempString),ADR(iOldList[oldListElements].module.name[0]),SIZEOF(iOldList[oldListElements].module.name));
						IF (tempString <> '') THEN
							oldListElements := oldListElements + 1;
						ELSE
							substep 		:= 200;
						END_IF;
					
					200:
						(* Cleaning the memory of the actual list *)
						(* Listing all the software objects *)
						memset(ADR(iActList),0,SIZEOF(iActList));
						mo_prev_index 	:= 16#FFFF;
						mo_index 		:= 0;
						nrChanges 		:= 0;
						substep			:= 201;
		
								
					201:
						(* Listing all the software objects element *)
						memset(ADR(tempModule), 0, SIZEOF(tempModule));
						MO_list(mo_prev_index, ADR(mo_index),ADR(tempModule));
									
						IF (tempModule.type <> 0) AND ((tempModule.type = CST_configOBJ)	OR 
							(tempModule.type = CST_cycOBJ)		OR
							(tempModule.type = CST_fwOBJ)		OR
							(tempModule.type = CST_hwOBJ)		OR
							(tempModule.type = CST_ncOBJ)		OR
							(tempModule.type = CST_sysOBJ))		THEN
 
							(* Valid system object *)
							MO_ver(ADR(tempModule.name),0,ADR(iActList[nrChanges].version));
							memcpy(ADR(iActList[nrChanges].module.name[0]),ADR(tempModule.name[0]), SIZEOF(tempModule.name));
							
							iActList[nrChanges].module.grp		:= tempModule.grp;
							iActList[nrChanges].module.memtype	:= tempModule.memtype;
							iActList[nrChanges].module.reserve 	:= tempModule.reserve;
							iActList[nrChanges].module.state	:= tempModule.state;
							iActList[nrChanges].module.type		:= tempModule.type;
							
							nrChanges							:= nrChanges + 1;
							substep 							:= 202;
						ELSE
							substep 							:= 202;
						END_IF;
								
					202:
						(* Checking if I have finished to scan *)
					
						IF (mo_prev_index = mo_index) OR (nrChanges = iMaxEntries) THEN
							substep 		:= 203;
						ELSE
							mo_prev_index	:= mo_index;
							substep 		:= 201;
						END_IF;
		
					203:
						(* Software list complete *)
						actListElements 	:= nrChanges;
						step 				:= 1;
						substep 			:= 0;
		
				END_CASE;
					
							
			1:
				(* Searching for modified software objects *)
				busy			:= TRUE;
				searching		:= TRUE;
				writingLog		:= FALSE;
				waiting			:= FALSE;
				scan			:= FALSE;
				error			:= FALSE;
				errorID			:= ERR_FUB_BUSY;
				
				CASE substep OF
					0:
						(* Software list complete, comparing memory area *)
						IF (memcmp(ADR(iActList), ADR(iOldList), SIZEOF(iActList)) = 0) THEN
	 
							(* No software changes *)
							substep	:= 0;
							step	:= 20;
							
						ELSE
							
							(* There are some changes *)
							substep		:= 1;
							cnt			:= 0;
							nrChanges	:= 0;
							oldSubStep	:= 0;
						END_IF;
					
					1:
						(* Trying to find the module in the same position of the old array *)
						(* First speed up improvement *)
						IF ((memcmp(ADR(iActList[nrChanges].module.name[0]), ADR(iOldList[nrChanges].module.name[0]), SIZEOF(iOldList[nrChanges].module.name)) = 0) 
							AND (cnt < oldListElements) AND (nrChanges < actListElements)) THEN
	 
							(* Module found *)
							IF (memcmp(ADR(iActList[nrChanges]),ADR(iOldList[nrChanges]),SIZEOF(iOldList[nrChanges])) = 0) THEN
								
								(* The module are the same *)
								nrChanges	:= nrChanges + 1;
								cnt			:= 0;
							ELSE
								
								(* The module is modified *)
								substep 	:= 10;
								step		:= 10;
								
							END_IF;
							
						ELSE
							(* Module not found *)
							substep 	:= 10;
							
						END_IF;
						
					10:
						(* Comparing the all elements of the iActList with all the elements of iOldList to find if the element exist or not *)
						IF (memcmp(ADR(iActList[nrChanges].module.name[0]), ADR(iOldList[cnt].module.name[0]), SIZEOF(iOldList[cnt].module.name)) <> 0) AND (nrChanges < actListElements) THEN
							IF (cnt < oldListElements)  THEN
								(* Module not found *)
								cnt 		:= cnt + 1;
							
							ELSIF (cnt >= oldListElements)  THEN
								
								(* New software module *)
								substep		:= 20;
								step		:= 10;
							END_IF;
													
						ELSIF ((memcmp(ADR(iActList[nrChanges].module.name[0]), ADR(iOldList[cnt].module.name[0]), SIZEOF(iOldList[cnt].module.name)) = 0) 
								AND (cnt < oldListElements) AND (nrChanges < actListElements)) THEN
							
							(* Module found *)
							IF (memcmp(ADR(iActList[nrChanges]),ADR(iOldList[cnt]),SIZEOF(iOldList[cnt])) = 0) THEN
								
								(* The module are the same *)
								nrChanges	:= nrChanges + 1;
								cnt			:= 0;
								substep 	:= 1;
							ELSE
								
								(* The module is modified *)
								substep 	:= 10;
								step		:= 10;
							END_IF;
													
						ELSIF (nrChanges >= actListElements) THEN
							
							(* Search finished, checking the removed objects *)
							substep			:= 2;
							cnt 			:= 0;
							nrChanges 		:= 0;
						END_IF;
					
					2:
						(* Trying to find the module in the same position of the old array *)
						(* Second speed up improvement *)
						IF ((memcmp(ADR(iActList[cnt].module.name[0]), ADR(iOldList[cnt].module.name[0]), SIZEOF(iOldList[cnt].module.name)) = 0) 
							AND (cnt < oldListElements) AND (nrChanges < actListElements)) THEN
							
							(* Module found *)
							cnt				:= cnt + 1;
							nrChanges		:= 0;
							
							
						ELSE
							(* Module not found *)
							nrChanges		:= 0;
							substep 	:= 20;
						END_IF
						
										
					20:
						(* Checking if there are any removed software object *)
						IF (memcmp(ADR(iActList[nrChanges].module.name[0]), ADR(iOldList[cnt].module.name[0]), SIZEOF(iOldList[cnt].module.name)) <> 0) AND (oldListElements <> 0) AND (cnt < oldListElements) THEN
							
							IF  (nrChanges < actListElements) THEN
								
								(* Module not found *)
								nrChanges	:= nrChanges + 1;
							
							ELSIF (nrChanges >= actListElements) THEN
								
								(* SW module removed *)
								substep 	:= 0;
								step		:= 10;
							END_IF;
							
						ELSIF ((memcmp(ADR(iActList[nrChanges].module.name[0]), ADR(iOldList[cnt].module.name[0]), SIZEOF(iOldList[cnt].module.name)) = 0) 
							AND (cnt < oldListElements) AND (nrChanges < actListElements)) THEN
							
							(* Module found *)
							cnt				:= cnt + 1;
							substep 		:= 2;
							nrChanges		:= 0;
							
						ELSIF (cnt >= oldListElements) THEN
							
							(* Search finished *)
							step			:= 10;
							substep 		:= 30;
							cnt				:= 0;
							nrChanges		:= 0;
						END_IF;
					
					
					
					
				END_CASE;
			
					
			10:
				(* Writing informations into the logger and data object *)
				busy 			:= TRUE;
				searching 		:= FALSE;
				writingLog		:= TRUE;
				waiting 		:= FALSE;
				scan			:= FALSE;
				error			:= FALSE;
				errorID			:= ERR_FUB_BUSY;
				
				CASE substep OF
					
					0:
						(* Removed software module *)
						memset(ADR(tempString),0,SIZEOF(tempString));
						tempString	:= 'REMOVED SW MODULE: ';
						memcpy(ADR(tempString)+LEN(tempString),ADR(iOldList[cnt].module.name[0]), SIZEOF(iOldList[cnt].module.name));
						substep		:= 1;
					
					1:
						(* Writing into the logger *)
						customEntry.adr_string 		:= ADR(tempString);
						customEntry.errorNum 		:= LOG_SW_OBJ_CHG;
						writeDiff.adrCustomEntry 	:= ADR(customEntry);
						writeDiff.enable 			:= TRUE;
						substep 					:= 2;
						
					2:
					
						IF (writeDiff.done = TRUE) THEN
							substep			:= 3;
						ELSIF (writeDiff.error) THEN
							errorID			:= writeDiff.errorID;
							errorStep		:= step;
							errorSubStep	:= substep;
							step 			:= 200;
							substep			:= 0;
						END_IF;
					
					
					3:
						writeDiff.enable	:= FALSE;
						IF (writeDiff.errorID = ERR_FUB_ENABLE_FALSE) THEN
							cnt				:= cnt + 1;
							nrChanges		:= 0;
							step			:= 1;
							substep			:= 2;
						END_IF;
					
					
					
					10:
						(* Modified software module *)
						memset(ADR(tempString),0,SIZEOF(tempString));
						tempString	:= 'MODIFIED SW MODULE: ';
						memcpy(ADR(tempString)+LEN(tempString),ADR(iActList[nrChanges].module.name[0]), SIZEOF(iActList[nrChanges].module.name));
						substep		:= 11;
					
					11:
						(* Writing into the logger *)
						customEntry.adr_string 		:= ADR(tempString);
						customEntry.errorNum 		:= LOG_SW_OBJ_CHG;
						writeDiff.adrCustomEntry 	:= ADR(customEntry);
						writeDiff.enable 			:= TRUE;
						substep 					:= 12;
						
					12:
					
						IF (writeDiff.done = TRUE) THEN
							substep			:= 13;
						ELSIF (writeDiff.error) THEN
							errorID			:= writeDiff.errorID;
							errorStep		:= step;
							errorSubStep	:= substep;
							step 			:= 200;
							substep			:= 0;
						END_IF;
					
					13:
						writeDiff.enable	:= FALSE;
						IF (writeDiff.errorID = ERR_FUB_ENABLE_FALSE) THEN
							cnt				:= 0;
							nrChanges		:= nrChanges + 1;
							substep			:= 1;
							step			:= 1;
						END_IF;
					
					20:
						(* New software module *)
						memset(ADR(tempString),0,SIZEOF(tempString));
						tempString	:= 'NEW SW MODULE: ';
						memcpy(ADR(tempString)+LEN(tempString),ADR(iActList[nrChanges].module.name[0]), SIZEOF(iActList[nrChanges].module.name));
						substep		:= 21;
						
					21:
						(* Writing into the logger *)
						customEntry.adr_string 		:= ADR(tempString);
						customEntry.errorNum 		:= LOG_SW_OBJ_NEW;
						writeDiff.adrCustomEntry 	:= ADR(customEntry);
						writeDiff.enable 			:= TRUE;
						substep						:= 22;
						
					
					22:
						IF (writeDiff.done = TRUE) THEN
							substep			:= 23;
						ELSIF (writeDiff.error) THEN
							errorID			:= writeDiff.errorID;
							errorStep		:= step;
							errorSubStep	:= substep;
							step 			:= 200;
							substep			:= 0;
						END_IF;
					
					23:
						writeDiff.enable	:= FALSE;
						IF (writeDiff.errorID = ERR_FUB_ENABLE_FALSE) THEN
							cnt				:= 0;
							nrChanges		:= nrChanges + 1;
							substep			:= 1;
							step			:= 1;
						END_IF;
					
					30:
						(* Writing temporary data object *)
						datObjWrite_0.ident		:= swListTempID;
						datObjWrite_0.len		:= SIZEOF(iActList);
						datObjWrite_0.Offset	:= 0;
						datObjWrite_0.pSource	:= ADR(iActList);
						datObjWrite_0.enable	:= TRUE;
						datObjWrite_0();
						substep					:= 31;
											
					31:
						datObjWrite_0();
						IF (datObjWrite_0.status = ERR_OK) THEN
							substep 				:= 50;
							waitWrite.IN 			:= TRUE;
							datObjWrite_0.enable 	:= FALSE;
						ELSIF (datObjWrite_0.status <> ERR_OK) AND (datObjWrite_0.status <> ERR_FUB_BUSY) THEN
							errorID					:= datObjWrite_0.status;
							errorStep				:= step;
							errorSubStep			:= substep;
							step 					:= 200;
							substep					:= 0;
						END_IF;
					
					40:					
						(* Writing cf data object *)
						datObjWrite_0.ident			:= swListID;
						datObjWrite_0.len			:= SIZEOF(iActList);
						datObjWrite_0.Offset		:= 0;
						datObjWrite_0.pSource		:= ADR(iActList);
						datObjWrite_0.enable		:= TRUE;
						datObjWrite_0();
						substep						:= 41;					
					41:
						datObjWrite_0();
						IF (datObjWrite_0.status = ERR_OK) THEN
							substep 				:= 50;
							waitWrite.IN 			:= FALSE;
							datObjWrite_0.enable 	:= FALSE;
						ELSIF (datObjWrite_0.status <> ERR_OK) AND (datObjWrite_0.status <> ERR_FUB_BUSY) THEN
							errorID					:= datObjWrite_0.status;
							errorStep				:= step;
							errorSubStep			:= substep;
							step 					:= 200;
							substep					:= 0;
						END_IF;
					
					
					50:
						(* Copy the actual list into the old list *)
						memcpy(ADR(iOldList), ADR(iActList), SIZEOF(iActList));
						memset(ADR(tempString),0,SIZEOF(tempString));
						substep := 0;
						step 	:= 20;
				END_CASE;
			
			
			20:
				(* Waiting step *)
				busy 			:= TRUE;
				searching 		:= FALSE;
				writingLog		:= FALSE;
				waiting 		:= TRUE;
				scan			:= FALSE;
				error			:= FALSE;
				errorID			:= ERR_FUB_BUSY;
				
				CASE substep OF
					0:
						(* No software changes *)
						refresh.PT := refreshTime;
						refresh.IN := TRUE;
						
			
						IF refresh.Q THEN
							substep := 1;
						END_IF;
						
					1:
						(* Refresh time elapsed *)
						IF (waitWrite.Q) THEN
							step 	:= 10;
							substep := 40;
						ELSE
							refresh.IN := FALSE;
							step 	:= 0;
							substep := 152;
						END_IF;
						
				END_CASE;
					
						
						
						
				
					
			200:
				(* Error state resetting all the used function block *)
				writeDiff.enable		:= FALSE;
				refresh.IN 				:= FALSE;
				waitWrite.IN			:= FALSE;
				datObjWrite_0.enable	:= FALSE;
				datObjInfo_0.enable		:= FALSE;
				datObjDelete_0.enable	:= FALSE;
				datObjRead_0.enable		:= FALSE;
				datObjCreate_0.enable	:= FALSE;
				datObjCopy_0.enable		:= FALSE;
						
				
				(* Updating the status *)
				busy			:= FALSE;
				searching		:= FALSE;
				writingLog		:= FALSE;
				waiting			:= FALSE;
				scan			:= FALSE;
				error			:= TRUE;
		END_CASE;
				
		

		
	ELSE
		
		
		
		mo_prev_index 	:= 16#FFFF;
		mo_index 		:= 0;
		cnt 			:= 0;
		nrChanges 		:= 0;
		substep			:= 0;
		step			:= 0;
		errorSubStep	:= 0;
		errorStep		:= 0;
		oldSubStep		:= 0;
		
		oldListElements := 0;
		actListElements	:= 0;
		
		error			:= TRUE;
		errorID			:= ERR_FUB_ENABLE_FALSE;
		busy			:= FALSE;
		searching		:= FALSE;
		writingLog		:= FALSE;
		waiting			:= FALSE;
		scan			:= FALSE;
		newSwListT		:= FALSE;
		(* Resetting all the used function block *)
		writeDiff.enable		:= FALSE;
		refresh.IN 				:= FALSE;
		waitWrite.IN			:= FALSE;
		datObjWrite_0.enable	:= FALSE;
		datObjInfo_0.enable		:= FALSE;
		datObjDelete_0.enable	:= FALSE;
		datObjRead_0.enable		:= FALSE;
		datObjCreate_0.enable	:= FALSE;
		datObjCopy_0.enable		:= FALSE;
	END_IF;
	
	

	writeDiff();
	refresh();
	waitWrite();
	
	
	
	
	
	
	
END_FUNCTION_BLOCK