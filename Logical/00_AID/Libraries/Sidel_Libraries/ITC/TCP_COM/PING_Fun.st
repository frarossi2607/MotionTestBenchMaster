FUNCTION_BLOCK PING_Fun		
	IF NOT enable THEN
		PING_OK 			:= FALSE;
		ERR_NO_RESPONSE 	:= FALSE;
		ERR_INTERNAL	 	:= FALSE;
		ERROR 				:= FALSE;
		Status 				:= NO_EXECUTION;
		RETURN;
	END_IF;
	Fb_IcmpPing.pHost	:= ADR(IP_Address);
	Fb_IcmpPing.timeout := 50;
	CASE Status OF
		NO_EXECUTION:
			Fb_IcmpPing.enable  := FALSE;
			readResponse 	:= FALSE;
			PachetSent		:= 0;
			PachetRecived	:= 0;
			PachetLoss		:= 0;
			IF enable THEN
				Status := EXECUTION;
			END_IF;
		
		EXECUTION:
			Fb_IcmpPing.enable  := TRUE;
			IF Fb_IcmpPing.status = ERR_FUB_BUSY THEN
				readResponse := TRUE;
			END_IF
			IF readResponse THEN
				CASE Fb_IcmpPing.status OF 
					ERR_OK:
						PachetSent 		:= PachetSent +1;
						PachetRecived 	:= PachetRecived +1;
					
					icmpERR_NO_RESPONSE:
						PachetSent 		:= PachetSent +1;
						PachetLoss 		:= PachetLoss +1;
						
					ERR_FUB_BUSY,
					ERR_FUB_ENABLE_FALSE:
				
					icmpERR_PARAMETER,
					icmpERR_SOCKET_CREATE,
					icmpERR_SYSTEM:
						Status := ERROR_INTERNAL;
				END_CASE;
			END_IF
			IF PachetSent >= 4 THEN
				IF PachetLoss >= 1 THEN
					Status := NO_RESPONSE;
				ELSE
					Status := SUCCESSFUL;
				END_IF
			END_IF
		
		SUCCESSFUL, NO_RESPONSE, ERROR_INTERNAL:
			Fb_IcmpPing.enable  := FALSE;

	END_CASE;
	Fb_IcmpPing();
	
	PING_OK 			:= Status = SUCCESSFUL;
	ERR_NO_RESPONSE 	:= Status = NO_RESPONSE;
	ERR_INTERNAL	 	:= Status = ERROR_INTERNAL;
	ERROR 				:= ERR_NO_RESPONSE OR ERR_INTERNAL;
END_FUNCTION_BLOCK
