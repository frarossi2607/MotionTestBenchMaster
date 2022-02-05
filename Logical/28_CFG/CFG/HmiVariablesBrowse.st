ACTION HmiVariablesBrowse: 
	CASE VAR_Level OF
		0:
			memset(ADR(HMI_CFG_Display), 0, SIZEOF(HMI_CFG_Display));
			VAR_Level := 5;
	
		5:	
			VAR_VariableName := VAR_InitialVariableName;
		
			IF VAR_VariableName <> '' THEN
				VAR_Level := 6;
			ELSE
				IF (AID.DataOut.ProjectType = CST_AID_ProjectMachine) THEN
					HMI_CFG_Display[1].Name := 'CFG_Cap_Par';
					HMI_CFG_Display[1].Visibility := TRUE;
				END_IF
			
				HMI_CFG_Display[2].Name := 'CFG_ITC';
				HMI_CFG_Display[2].Visibility := TRUE;
			
				HMI_CFG_Display[10].Name := 'CFG_Par';
				HMI_CFG_Display[10].Visibility := TRUE;
			END_IF
	
			IF HMI_CFG_Selection <> 0 THEN
				VAR_InitialVariableName := HMI_CFG_Display[HMI_CFG_Selection].Name;
			END_IF
	
		6:
			VAR_Page := 0;
			VAR_LastElementOld := 0;
			VAR_LastElement := 0;
			VAR_Level := 7;
	
		7:
			memset(ADR(HMI_CFG_Display), 0, SIZEOF(HMI_CFG_Display));
		
			IF VAR_InitialVariableName = 'CFG_Par' THEN
				VAR_Level := 8;
			ELSE
				VAR_Level := 9;
			END_IF
	
		8:
			HMI_CFG_Display[1].Visibility := TRUE;
			HMI_CFG_Display[1].Name := 'CFG_Par';
	
			VAR_Level := 100;
	
		9:
			VAR_PV_NinfoState := PV_ninfo(ADR(VAR_VariableName), ADR(VAR_DType), ADR(VAR_Len), ADR(VAR_Dim));

			IF VAR_Dim <= 20 THEN
				FOR var_i := 1 TO VAR_Dim DO
					PV_item(ADR(VAR_VariableName), UDINT_TO_UINT(var_i - 1), ADR(VAR_ItemName));
					strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_VariableName));
					strcat(ADR(HMI_CFG_Display[var_i].Name), ADR('.'));
					strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_ItemName));
					HMI_CFG_Display[var_i].Visibility := TRUE;
				END_FOR
			ELSE
				FOR var_i := 1 TO 20 DO
					IF var_i = 1 AND VAR_Page <> 0 THEN
						HMI_CFG_Display[1].Name := 'Previous elements';
						HMI_CFG_Display[1].Visibility := TRUE;
					ELSIF var_i = 20 AND VAR_Dim > INT_TO_UINT(VAR_LastElement) THEN
						HMI_CFG_Display[20].Name := 'Next elements';
						HMI_CFG_Display[20].Visibility := TRUE;
					ELSIF (var_i + (VAR_Page * VAR_LastElementOld)) <= VAR_Dim THEN
						PV_item(ADR(VAR_VariableName), UDINT_TO_UINT((var_i + (VAR_Page * VAR_LastElementOld)) - 1), ADR(VAR_ItemName));
						strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_VariableName));
						strcat(ADR(HMI_CFG_Display[var_i].Name), ADR('.'));
						strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_ItemName));
						HMI_CFG_Display[var_i].Visibility := TRUE;
						VAR_LastElement := UDINT_TO_INT(var_i) + (VAR_Page * VAR_LastElementOld);
					END_IF
				END_FOR
			END_IF
			VAR_LastElementOld := VAR_LastElement;
		
			VAR_Level := 10;
		
		10:
			IF HMI_CFG_Selection <> 0 AND
				(NOT HMI_CFG_Display[HMI_CFG_Selection].PresentB	AND NOT HMI_CFG_Display[HMI_CFG_Selection].PresentI		AND 
				NOT HMI_CFG_Display[HMI_CFG_Selection].PresentR		AND NOT HMI_CFG_Display[HMI_CFG_Selection].PresentSt)	THEN
				IF VAR_Dim <= 20 THEN
					VAR_Level := 15;
				ELSIF HMI_CFG_Selection = 1 AND VAR_Page <> 0 THEN
					VAR_Level := 7;
				ELSIF HMI_CFG_Selection = 20 AND VAR_Dim > INT_TO_UINT(VAR_LastElement) THEN
					VAR_Level := 7;
				ELSE
					VAR_Level := 15;
				END_IF
			END_IF
	
		15:
			VAR_Page := 0;
			VAR_LastElementOld := 0;
			VAR_LastElement := 0;		
			VAR_Level := 16;
	
		16:
			memset(ADR(HMI_CFG_Display), 0, SIZEOF(HMI_CFG_Display));		
			VAR_Level := 20;
		
		20:
			VAR_PV_NinfoState := PV_ninfo(ADR(VAR_VariableName), ADR(VAR_DType), ADR(VAR_Len), ADR(VAR_Dim));

			IF VAR_DType = 0 THEN
				IF VAR_Dim <= 20 THEN
					FOR var_i := 1 TO VAR_Dim DO
						PV_item(ADR(VAR_VariableName), UDINT_TO_UINT(var_i - 1), ADR(VAR_ItemName));
						strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_VariableName));
						strcat(ADR(HMI_CFG_Display[var_i].Name), ADR('.'));
						strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_ItemName));
						HMI_CFG_Display[var_i].Visibility := TRUE;
						VAR_PV_NinfoState := PV_ninfo(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_DType2), ADR(VAR_Len2), ADR(VAR_Dim2));
						IF VAR_DType2 = 1 THEN
							PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
							memcpy(ADR(HMI_CFG_Display[var_i].ValueB), VAR_address, VAR_Len2);
							HMI_CFG_Display[var_i].PresentB := TRUE;					
						ELSIF (VAR_DType2 >= 2 AND VAR_DType2 <= 7) OR VAR_DType2 = 12 THEN
							PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
							memcpy(ADR(HMI_CFG_Display[var_i].ValueI), VAR_address, VAR_Len2);
							HMI_CFG_Display[var_i].PresentI := TRUE;
						ELSIF VAR_DType2 = 8 THEN
							PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
							memcpy(ADR(HMI_CFG_Display[var_i].ValueR), VAR_address, VAR_Len2);
							HMI_CFG_Display[var_i].PresentR := TRUE;
						ELSIF VAR_DType2 = 9 THEN
							PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
							strcpy(ADR(HMI_CFG_Display[var_i].ValueSt), VAR_address);
							HMI_CFG_Display[var_i].PresentSt := TRUE;
						END_IF
					END_FOR
				ELSE
					FOR var_i := 1 TO 20 DO
						IF var_i = 1 AND VAR_Page <> 0 THEN
							HMI_CFG_Display[1].Name := 'Previous elements';
							HMI_CFG_Display[1].Visibility := TRUE;
						ELSIF var_i = 20 AND VAR_Dim > INT_TO_UINT(VAR_LastElement) THEN
							HMI_CFG_Display[20].Name := 'Next elements';
							HMI_CFG_Display[20].Visibility := TRUE;
						ELSIF (var_i + (VAR_Page * VAR_LastElementOld)) <= VAR_Dim THEN
							PV_item(ADR(VAR_VariableName), UDINT_TO_UINT((var_i + (VAR_Page * VAR_LastElementOld)) - 1), ADR(VAR_ItemName));
							strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_VariableName));
							strcat(ADR(HMI_CFG_Display[var_i].Name), ADR('.'));
							strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_ItemName));
							HMI_CFG_Display[var_i].Visibility := TRUE;
							VAR_PV_NinfoState := PV_ninfo(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_DType2), ADR(VAR_Len2), ADR(VAR_Dim2));
							IF VAR_DType2 = 1 THEN
								PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
								memcpy(ADR(HMI_CFG_Display[var_i].ValueB), VAR_address, VAR_Len2);
								HMI_CFG_Display[var_i].PresentB := TRUE;					
							ELSIF VAR_DType2 >= 2 AND VAR_DType2 <= 7 OR VAR_DType2 = 12 THEN
								PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
								memcpy(ADR(HMI_CFG_Display[var_i].ValueI), VAR_address, VAR_Len2);
								HMI_CFG_Display[var_i].PresentI := TRUE;
							ELSIF VAR_DType2 = 8 THEN
								PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
								memcpy(ADR(HMI_CFG_Display[var_i].ValueR), VAR_address, VAR_Len2);
								HMI_CFG_Display[var_i].PresentR := TRUE;
							ELSIF VAR_DType2 = 9 THEN
								PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
								strcpy(ADR(HMI_CFG_Display[var_i].ValueSt), VAR_address);
								HMI_CFG_Display[var_i].PresentSt := TRUE;
							END_IF
							VAR_LastElement := UDINT_TO_INT(var_i) + (VAR_Page * VAR_LastElementOld);
						END_IF
					END_FOR
				END_IF
			ELSIF VAR_DType = 15 THEN
				FOR var_i := 1 TO VAR_Dim DO
					strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_VariableName));
					strcat(ADR(HMI_CFG_Display[var_i].Name), ADR('['));
					itoa((var_i - 1), ADR(VAR_array));
					strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_array));
					strcat(ADR(HMI_CFG_Display[var_i].Name), ADR(']'));
					HMI_CFG_Display[var_i].Visibility := TRUE;
				END_FOR
			END_IF
			VAR_LastElementOld := VAR_LastElement;

			VAR_Level := 30;
	
		30:
			IF HMI_CFG_Selection <> 0 AND 
				(NOT HMI_CFG_Display[HMI_CFG_Selection].PresentB	AND NOT HMI_CFG_Display[HMI_CFG_Selection].PresentI		AND 
				NOT HMI_CFG_Display[HMI_CFG_Selection].PresentR		AND NOT HMI_CFG_Display[HMI_CFG_Selection].PresentSt)	THEN
				IF VAR_Dim <= 20 THEN
					VAR_Level := 15;
				ELSIF HMI_CFG_Selection = 1 AND VAR_Page <> 0 THEN
					VAR_Level := 16;
				ELSIF HMI_CFG_Selection = 20 AND VAR_Dim > INT_TO_UINT(VAR_LastElement) THEN
					VAR_Level := 16;
				ELSE
					VAR_Level := 15;
				END_IF
			END_IF	
	
			FOR var_i := 1 TO 20 DO
				IF HMI_CFG_Display[var_i].PresentB THEN
					PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
					memcpy(VAR_address, ADR(HMI_CFG_Display[var_i].ValueB), VAR_Len2);
				ELSIF HMI_CFG_Display[var_i].PresentI THEN
					PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
					memcpy(VAR_address, ADR(HMI_CFG_Display[var_i].ValueI), VAR_Len2);
				ELSIF HMI_CFG_Display[var_i].PresentR THEN
					PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
					memcpy(VAR_address, ADR(HMI_CFG_Display[var_i].ValueR), VAR_Len2);
				ELSIF HMI_CFG_Display[var_i].PresentSt THEN
					PV_xgetadr(ADR(HMI_CFG_Display[var_i].Name), ADR(VAR_address), ADR(VAR_Len2));
					strcpy(VAR_address, ADR(HMI_CFG_Display[var_i].ValueSt));
				ELSE
					EXIT;
				END_IF
			END_FOR
	END_CASE

	IF EDGENEG(HMI_CFG_Reset) THEN
		IF VAR_Level = 10 OR VAR_Level = 100 THEN
			VAR_InitialVariableName := '';
		END_IF
		VAR_Level := 0;
	END_IF

	IF HMI_CFG_Selection <> 0 THEN 
		IF (NOT HMI_CFG_Display[HMI_CFG_Selection].PresentB	AND NOT HMI_CFG_Display[HMI_CFG_Selection].PresentI		AND 
			NOT HMI_CFG_Display[HMI_CFG_Selection].PresentR		AND NOT HMI_CFG_Display[HMI_CFG_Selection].PresentSt)	THEN
			IF VAR_Dim <= 20 THEN
				VAR_VariableName := HMI_CFG_Display[HMI_CFG_Selection].Name;
			ELSIF HMI_CFG_Selection = 1 AND VAR_Page <> 0 THEN
				VAR_Page := VAR_Page - 1;
			ELSIF HMI_CFG_Selection = 20 AND VAR_Dim > INT_TO_UINT(VAR_LastElement) THEN
				VAR_Page := VAR_Page + 1;
			ELSE
				VAR_VariableName := HMI_CFG_Display[HMI_CFG_Selection].Name;
			END_IF
	
			HMI_CFG_Selection := 0;
		END_IF
	END_IF
END_ACTION
