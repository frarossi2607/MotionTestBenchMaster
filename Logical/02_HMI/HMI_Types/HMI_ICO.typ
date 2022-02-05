
TYPE
	HMI_ICO_Type : 	STRUCT 
		NextRecipeId : UDINT; (*ID of the next recipe requested from HLI*)
		ActualRecipeId : UDINT; (*ID of the actual recipe*)
		NextRecipeLoadingReq : BOOL; (*Request to download the new recipe*)
		RecipeLoaded : BOOL; (*New recipe downloaded*)
	END_STRUCT;
END_TYPE
