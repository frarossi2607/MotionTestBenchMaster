(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: Powertoys
 * File: Plk_list.st
 * Author: Administrator
 * Created: July 04, 2014
 ********************************************************************
 * Implementation of library Powertoys
 ********************************************************************) 

(* Powerlink list *)
FUNCTION_BLOCK PlkList
	
	IF (enable	=	TRUE) THEN
		
		CASE step OF
			
			0: (* Choosing the operating mode
					0 = standard memory consumption
					1 = low memory consumption - slowest
				*)
				errorID 		:=	ERR_FUB_BUSY;
				busy			:=	TRUE;
				error			:=	FALSE;
				done			:= 	FALSE;
				
				IF (mode = 0) THEN
					step 		:= 1;
				ELSIF (mode = 1) THEN
					step 		:= 10;
				ELSE 
					(* Wrong mode *)
					step		:= 200;
					error 		:= TRUE;
					errorID		:= ERR_NOTIMPLEMENTED;
					errorStep	:= 0;
					busy		:= FALSE;
					done		:= FALSE;
				END_IF;
			
			1:
				(* Getting the whole hardware list *)
				searchIO_0.adrSearchIO 	:= ADR(searchIoData);
				searchIO_0.mode 		:= asdiagALL;
				searchIO_0.wholeList	:= TRUE;
				searchIO_0.enable		:= TRUE;
				
				IF (searchIO_0.errorID = ERR_FUB_BUSY) THEN
					step := 2;
				END_IF;
				
			
			2:
				IF ((searchIO_0.errorID	=	ERR_OK) AND (searchIO_0.done = TRUE)) THEN
       
					(*resetting array and variables*)

					strcpy(ADR(tmpPlkInterface), ADR(plkInterface));
					strcat(ADR(tmpPlkInterface),ADR('.'));
					step		:=	3;
					indexInfo	:=	0;
					indexPwl	:=	0;
					
				ELSIF ((searchIO_0.errorID	<>	ERR_OK)	AND	(searchIO_0.errorID	<>	ERR_FUB_BUSY)) THEN
					
					(* Going to the error state *)
					errorID		:=	searchIO_0.errorID;
					errorStep	:=	1;
					step		:=	200;
					error		:=	TRUE;
				END_IF	
				
			3: (*saving inside an array	(ArrayStringTemp) the path hardware longer than plk inteface*)
			IF (indexInfo	<	searchIO_0.nrEntries)	THEN
							
				(* Ci metto tutto quello dopo SS1.IF1 
					Es:
					ST2
					ST3
					ST5.IF1
				
				*)
				IF 	strlen(ADR(searchIoData[indexInfo].Path))	>=	strlen(ADR(tmpPlkInterface))	THEN
					strcpy(ADR(ArrayStringTemp[indexPwl]),(ADR(searchIoData[indexInfo].Path)+ strlen(ADR(tmpPlkInterface))));
					arrayIndexPwl[indexPwl]	:=	indexInfo;
					indexPwl				:=	indexPwl+1;
				END_IF;
			
				indexInfo	:=	indexInfo+1;
			ELSE
				step		:=	4;
				oldIndexPwl :=	indexPwl;
				
				indexPwl	:=	0;
						
				indexInfo	:=	0;
				indexPwl2	:=	0;
				dotFound	:=	FALSE;
				
				END_IF;		
				
		4:
			(*Finding dot or string null inside elements of temp array*)
			IF (indexPwl	<	strlen(ADR(ArrayStringTemp[indexInfo]))	OR	strlen(ADR(ArrayStringTemp[indexInfo]))	=	0 )	THEN
	 
				IF (memcmp(ADR(ArrayStringTemp[indexInfo])+indexPwl,ADR('.'),1)	=0	)	THEN
					step		:=	5;
					indexPwl	:=	0;
					dotFound 	:= TRUE;
				END_IF;
				
			ELSE
				step		:=	5;
				indexPwl	:=	0;
					
			END_IF;	
			indexPwl	:=	indexPwl+1;
			
		5:
			
			(*if there isn't a dot, the string is our node powerlink*)
			IF (dotFound	=	FALSE) THEN
				
				pData ACCESS (adrPlkInfo + indexPwl2*SIZEOF(pData));
				pData.number	:=	arrayIndexPwl[indexInfo];
			
				IF strlen(ADR(searchIoData[arrayIndexPwl[indexInfo]].ModelNumber))	<>	0 	AND 
					pData.number	<>	0									THEN
					(* Powerlink node present *)
					pData.present	:=	TRUE;
				ELSE
					(* Powerlink node not present *)
					pData.present	:=	FALSE;
				END_IF;
				
				(*Copying information about powerlink node*)
				strcpy(ADR(pData.path),						ADR(ArrayStringTemp[indexInfo]));
				strcpy(ADR(pData.modelNumber),				ADR(searchIoData[arrayIndexPwl[indexInfo]].ModelNumber));
				strcpy(ADR(pData.name),						ADR(searchIoData[arrayIndexPwl[indexInfo]].Name));
				strcpy(ADR(ArrayStringTemp2[indexPwl2]),	ADR(ArrayStringTemp[indexInfo]));				
				arrayIndexPwl2[indexPwl2]					:=	arrayIndexPwl[indexInfo];
				indexPwl2									:=	indexPwl2+1;
				
			END_IF;
			(**)		
			indexInfo	:=	indexInfo+1;
			IF (indexInfo	<	oldIndexPwl) THEN
				
				dotFound	:=	FALSE;
				step	:=	4;
				
			ELSE
				
				step	:=	6;
				
			END_IF;
			
		6:
			busy := FALSE;
			done := TRUE;
			errorID := ERR_OK;	
				
			entryFound := indexPwl2;	
						
			10:
				(* Low memory consumption mode *)
				(* In this mode each entry is processe one by one instead of processing the whole list *)
				(* Getting the whole hardware list *)
				searchIO_0.adrSearchIO 	:= ADR(searchIoData);
				searchIO_0.mode 		:= asdiagALL;
				searchIO_0.wholeList	:= FALSE;
				searchIO_0.enable		:= TRUE;
				indexInfo 				:= 0;
				indexPwl2 				:= 0;
				(* Getting informations from the first hw found *)
				searchIO_0.stationIndex	:= 0;
				
				IF (searchIO_0.errorID = ERR_FUB_BUSY) THEN
					step := 11;
				END_IF;
			
			11:
			
				IF ((searchIO_0.errorID	=	ERR_OK) AND (searchIO_0.done = TRUE)) THEN
       
					(*resetting array and variables*)

					strcpy(ADR(tmpPlkInterface), ADR(plkInterface));
					strcat(ADR(tmpPlkInterface),ADR('.'));
					step		:=	12;
					nrIO 		:= searchIO_0.nrEntries;
					
					
				ELSIF ((searchIO_0.errorID	<>	ERR_OK)	AND	(searchIO_0.errorID	<>	ERR_FUB_BUSY)) THEN
					(* Going to the error state *)
					errorID		:=	searchIO_0.errorID;
					errorStep	:=	10;
					step		:=	200;
					error		:=	TRUE;
				END_IF	
			
			12:
				 (* Se la lunghezza del path trovato dalla search io è maggiore o uguale a quello dell'interfaccia powerlink, allora è un probabile nodo powerlink *)
				(* Copio nella variabile temporanea solo quello che viene dopo i caratteri che compongono l'interfaccia powerlink:
				Es: Ci metto tutto quello dopo SS1.IF1
				
				in powerlink if ci deve finire 'SS1.IF1.'
				
				Se per esempio avremo come entry:
				SS1.IF1
				SS1.IF1.ST2
				SS1.IF1.ST3
				SSI.IF1.ST5.IF8
				
				RIMARRANNO
				
				ST2
				ST3
				ST5.IF8
				
				*)
				IF 	strlen(ADR(searchIoData[0].Path))	>=	strlen(ADR(tmpPlkInterface))	THEN
					
					(* Possible powerlink node *)
					strcpy(ADR(ArrayStringTemp[0]),(ADR(searchIoData[0].Path)+ strlen(ADR(tmpPlkInterface))));
					
					
					arrayIndexPwl[0]	:=	indexInfo;
					
				
					step := 13;
					
				ELSE
					(* Not a powerlink node *)
					step := 100;
				END_IF;
			
			13:
				(* If the remaining temporary string is empty, this is the powerlink inferface, not the powerlink node  *)
				
				IF (strlen(ADR(ArrayStringTemp[0])) <> 0) THEN
					
					(* Possible powerlink node *)
					tmpCnt		:= 0;
					step		:= 14;
				ELSE
					(* Not a powerlink node *)
					step		:= 100;
				END_IF;
			
			14:
				(* I have only something like:
				ST5
				ST41
				ST123
				ST41.IFblablabla
				ST12
				
				
				I can say that if there is not the dot, this is a powerlink node
				
				SEARCHING inside of the string if there is the dot
				*)
				IF (tmpCnt < strlen(ADR(ArrayStringTemp[0]))) THEN
					
					IF (memcmp(ADR(ArrayStringTemp[0])+tmpCnt,ADR('.'),1)	= 0	) THEN
						
						(* Dot found, this is not a powerlink node *)
						step := 100;
						
					ELSE
						tmpCnt := tmpCnt + 1;
					END_IF;
				
				ELSE
					(* This is a powerlink node *)
					step := 15;
				END_IF;
			
			15:
				(* Collecting data of the powerlink node *)
				pData ACCESS (adrPlkInfo + indexPwl2*SIZEOF(pData));
				pData.number	:=	indexInfo;
			
				
				IF strlen(ADR(searchIoData[0].ModelNumber))	<>	0 	AND 
					pData.number	<>	0									THEN
					(* Powerlink node present *)
					pData.present	:=	TRUE;
				ELSE
					(* Powerlink node not present *)
					pData.present	:=	FALSE;
				END_IF;
				
				(*Copying information about powerlink node*)
				strcpy(ADR(pData.path),						ADR(ArrayStringTemp[0]));
				strcpy(ADR(pData.modelNumber),				ADR(searchIoData[0].ModelNumber));
				strcpy(ADR(pData.name),						ADR(searchIoData[0].Name));
				indexPwl2									:=	indexPwl2+1;
				
				step	:=	100;
				
		
			
			
			
			100:
				(* Not a powerlink node, processing a new entry *)
				searchIO_0.enable		:= FALSE;
								
				IF (searchIO_0.errorID = ERR_FUB_ENABLE_FALSE) THEN
					indexInfo := indexInfo + 1;
					step := 101;
				END_IF;
			
			101:
				(* Checking if I have to read an other entry *)
				IF ((indexInfo < nrIO)AND(indexPwl < nrEntry))  THEN
	 
					(* Cleaning temporary variables *)
					memset(ADR(searchIoData),0,SIZEOF(searchIoData));
					
					(* Going to process a new entry *)
					step := 102;
				
				ELSE
				
					(* Sequence finished *)
					step := 120;
					
				END_IF;
			
			102:
				(* Reading a new search IO entry *)
				searchIO_0.adrSearchIO 	:= ADR(searchIoData);
				searchIO_0.mode 		:= asdiagALL;
				searchIO_0.wholeList	:= FALSE;
				searchIO_0.enable		:= TRUE;
				
				(* Getting informations from the first hw found *)
				searchIO_0.stationIndex	:= indexInfo;
				
				IF (searchIO_0.errorID = ERR_FUB_BUSY) THEN
					step := 103;
				END_IF;
			
			103:
			
				IF ((searchIO_0.errorID	=	ERR_OK) AND (searchIO_0.done = TRUE)) THEN
       
					(*resetting array and variables*)

					step		:=	12;
					nrIO 		:= searchIO_0.nrEntries;
					
					
				ELSIF ((searchIO_0.errorID	<>	ERR_OK)	AND	(searchIO_0.errorID	<>	ERR_FUB_BUSY)) THEN
					(* Going to the error state *)
					errorID		:=	searchIO_0.errorID;
					errorStep	:=	102;
					step		:=	200;
					error		:=	TRUE;
				END_IF	
			
			120:
			(* Sequence completed *)
				done 				:= TRUE;
				busy 				:= FALSE;
				error 				:= FALSE;
				errorID				:= ERR_OK;
				searchIO_0.enable	:= FALSE;
				entryFound := indexPwl2;
			
			
			
			
			
			200:
				(* Error state, disabling all the used function block and waiting  for enable = false *)
				searchIO_0.enable 	:= FALSE;
				
		END_CASE;
	
	ELSE
		(* Function block not enabled *) 
		error				:= TRUE;
		errorID				:= ERR_FUB_ENABLE_FALSE;
		
		(* Resetting  the internal variables *)
		errorStep			:= 0;
		step	 			:= 0;
		
		memset(ADR(arrayIndexPwl),		0,	SIZEOF(arrayIndexPwl));
		memset(ADR(ArrayStringTemp),	0,	SIZEOF(ArrayStringTemp));
		memset(ADR(arrayIndexPwl2),		0,	SIZEOF(arrayIndexPwl2));
		memset(ADR(ArrayStringTemp2),	0,	SIZEOF(ArrayStringTemp2));
		memset(ADR(tmpPlkInterface),	0,	SIZEOF(tmpPlkInterface));
			
		step		:=	0;
		indexInfo	:=	0;
		indexPwl	:=	0;
		indexPwl2	:=	0;
		entryFound 	:= 	0;
		nrIO		:=	0;
		done				:= FALSE;
		busy				:= FALSE;
		
		(* Disabling the block *)
		searchIO_0.enable 	:= FALSE;
		

	END_IF;

			
	(*Function Block Call*)
	searchIO_0();
END_FUNCTION_BLOCK