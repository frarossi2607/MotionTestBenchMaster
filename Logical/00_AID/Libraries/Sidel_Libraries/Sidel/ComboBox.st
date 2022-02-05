FUNCTION ComboBoxString
	OUT_ComboString := '';
	FOR VAR_ElementsIndex := 0 TO 16 DO
		IF IN_ElementsStructure[VAR_ElementsIndex].Present THEN
			itoa(USINT_TO_DINT(VAR_ElementsIndex), ADR(VAR_StrIndex));
			VAR_StrComma 		:= ',';
			VAR_StrSemicolun 	:= ';';
			strcat(ADR(OUT_ComboString), ADR(VAR_StrIndex));
			strcat(ADR(OUT_ComboString), ADR(VAR_StrComma));
			strcat(ADR(OUT_ComboString), ADR(IN_ElementsStructure[VAR_ElementsIndex].Name));
			strcat(ADR(OUT_ComboString), ADR(VAR_StrSemicolun));
		END_IF
	END_FOR
	ComboBoxString := TRUE;
END_FUNCTION