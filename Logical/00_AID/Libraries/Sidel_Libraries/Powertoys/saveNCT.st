(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: Powertoys
 * File: saveNCT.st
 * Author: Massimo Gibertini - B&R
 * Created: January 20, 2015
 ********************************************************************
 * Implementation of library Powertoys
 ********************************************************************) 

(* Save the network comand trace into one file *)
FUNCTION_BLOCK saveNCT
	
	IF enable THEN
		CASE step OF
			0:
				error 		:= FALSE;
				busy		:= TRUE;
				done		:= FALSE;
				errorID 	:= ERR_FUB_BUSY;
				
				IF (strlen(ADR(fName)) <> 0) AND (strlen(ADR(deviceName)) <> 0) THEN
					NetTraceStatusConfig.NetTrace.Type			:= mcNET_TRACE_GLOBAL;
					NetTraceConfig.NetTrace.Type				:= mcNET_TRACE_GLOBAL;
					NetTraceConfig.DatObj.Name					:= fName;
					
					CASE mode OF
						0:
							NetTraceConfig.DatObj.Type					:= mcFILE;
							
						1:
							NetTraceConfig.DatObj.Type					:= mcFILE + mcADD_DATE_TIME;

					END_CASE;
					
					NetTraceConfig.DatObj.Format				:= 0;
					NetTraceConfig.DatObj.Device				:= deviceName;
					MC_BR_NetTrace_0.Configuration				:= NetTraceConfig;
					MC_BR_NetTrace_0.Command					:= mcSAVE;
					MC_BR_ReadNetTraceStatus_0.Configuration	:= NetTraceStatusConfig;
					MC_BR_ReadNetTraceStatus_0.Enable			:= TRUE;
					
					IF MC_BR_ReadNetTraceStatus_0.Busy THEN
						step := 1;
					END_IF;
				ELSE
					error 		:= TRUE;
					errorID		:= ERR_BUR_ILLPAR;
					errorStep	:= 0;
					step		:= 200;
				END_IF;
				
			
			1:
				IF (MC_BR_ReadNetTraceStatus_0.Valid AND MC_BR_ReadNetTraceStatus_0.TraceState = mcOFF) THEN
					(* Data not written to the network command trace *)
					step := 10;
				ELSIF (MC_BR_ReadNetTraceStatus_0.Valid AND MC_BR_ReadNetTraceStatus_0.TraceState = mcON) THEN
					(* Data written to the network command trace *)
					step := 20;
				ELSIF (MC_BR_ReadNetTraceStatus_0.Error) THEN
					error		:= TRUE;
					errorStep	:= 1;
					errorID		:= MC_BR_ReadNetTraceStatus_0.ErrorID;
					step 		:= 200;
				END_IF;
			
			10:
				(* Network command trace data not available *)
				MC_BR_ReadNetTraceStatus_0.Enable	:= FALSE;
				error 		:= TRUE;
				busy		:= FALSE;
				done		:= TRUE;
				errorID 	:= ERR_OK;
			
			20:
				(* Network command trace data available *)
				MC_BR_ReadNetTraceStatus_0.Enable	:= FALSE;
				MC_BR_NetTrace_0.Execute 			:= TRUE;
				IF MC_BR_NetTrace_0.Busy THEN
					step := 21;
				END_IF;
			
			21:
				IF MC_BR_NetTrace_0.Done THEN
					step := 30;
				ELSIF MC_BR_NetTrace_0.Error THEN
					traceError 	:= MC_BR_NetTrace_0.ErrorRecord;
					errorID 	:= MC_BR_NetTrace_0.ErrorID;
					error 		:= TRUE;
					errorStep 	:= 21;
					step 		:= 200;
				END_IF;
			30:
				(* NCT Saved *)
				MC_BR_NetTrace_0.Execute			:= FALSE;
				
				error 		:= FALSE;
				busy		:= FALSE;
				done		:= TRUE;
				errorID 	:= ERR_OK;
			
			200: 
				(* ERROR *)
				MC_BR_NetTrace_0.Execute			:= FALSE;
				MC_BR_ReadNetTraceStatus_0.Enable	:= FALSE;
				
		END_CASE;
		
	ELSE
		
		MC_BR_NetTrace_0.Execute			:= FALSE;
		MC_BR_ReadNetTraceStatus_0.Enable	:= FALSE;
		step 		:= 0;
		
		error 		:= TRUE;
		busy		:= FALSE;
		done		:= FALSE;
		errorStep	:= 0;
		errorID 	:= ERR_FUB_ENABLE_FALSE;
		
		
		
	END_IF;
	

	MC_BR_NetTrace_0();
	MC_BR_ReadNetTraceStatus_0();
	
END_FUNCTION_BLOCK