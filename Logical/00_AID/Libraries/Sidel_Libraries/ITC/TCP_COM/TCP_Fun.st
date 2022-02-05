(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: TCP
 * File: TCP.st
 * Author: Marco.Nicolì
 * Created: October 25, 2016 : Initial version
 * Modified: November 15, 2016 : Something
 ********************************************************************)

FUNCTION_BLOCK TCP_COM
	CASE TCP_Status OF
		DISABLED:
			ConnectionAttempt 	:= 0;
			PING_OK 			:= FALSE;
			ERR_INTERNAL		:= FALSE;
			ERR_NO_RESPONSE		:= FALSE;
			TON_TCP_EnDelay.IN 	:= Enable_Com;
			TON_TCP_EnDelay.PT 	:= t#2s;
			TON_TCP_EnDelay();
			IF TON_TCP_EnDelay.Q THEN
				TON_TCP_EnDelay(IN := FALSE);
				TCP_Status := INITIALIZE_FB;
			END_IF
		
		INITIALIZE_FB:
			fb_Ping.enable 		:= FALSE;
			fb_TcpOpen.enable	:= FALSE; 
			fb_TcpServer.enable	:= FALSE;
			fb_TcpClient.enable	:= FALSE;
			fb_TcpSend.enable	:= FALSE;
			fb_TcpRecv.enable	:= FALSE;
			fb_TcpClose.enable	:= FALSE;
			fb_CfgGetIPAddr.enable := FALSE;
			fb_Ping();
			fb_TcpOpen();
			fb_TcpServer();
			fb_TcpClient();
			fb_TcpSend();
			fb_TcpRecv();
			fb_TcpClose();
			fb_CfgGetIPAddr();
			
			TON_TCP_EnDelay.IN 	:= TRUE;
			TON_TCP_EnDelay.PT 	:= t#100ms;
			TON_TCP_EnDelay();
			IF TON_TCP_EnDelay.Q THEN
				TON_TCP_EnDelay(IN := FALSE);
				TCP_Status := INITIAL_PING;
			END_IF
		
		INITIAL_PING:
			fb_Ping.enable 		:= TRUE; 
			fb_Ping.IP_Address 	:= IP_Address; 
			fb_Ping();
			IF NOT Enable_Com THEN
				TCP_Status 	:= DISABLED;
			ELSIF fb_Ping.PING_OK THEN
				PING_OK 	:= TRUE;
				IF ETH_Card = '' THEN
					TCP_Status 	:= OPEN_TCP;
				ELSE
					TCP_Status 	:= READ_LOCAL_IP;
				END_IF
			ELSIF fb_Ping.ERROR THEN
				ERR_NO_RESPONSE := fb_Ping.ERR_NO_RESPONSE;
				ERR_INTERNAL	:= fb_Ping.ERR_INTERNAL;
				TCP_Status 		:= RECONNECTION;
			END_IF
		
		READ_LOCAL_IP:
			fb_CfgGetIPAddr.enable 	:= TRUE;
			fb_CfgGetIPAddr.pDevice := ADR(ETH_Card);
			fb_CfgGetIPAddr.pIPAddr := ADR(IP_AdressLocal);
			fb_CfgGetIPAddr.Len 	:= SIZEOF(IP_AdressLocal);
			fb_CfgGetIPAddr();
			IF fb_CfgGetIPAddr.status = ERR_FUB_BUSY THEN
				readResponse := TRUE;
			END_IF
			IF readResponse THEN
				IF fb_CfgGetIPAddr.status = ERR_OK AND NOT (IP_AdressLocal = 'ERROR') THEN
					IP_LocalValid := TRUE;
					TCP_Status 		:= OPEN_TCP;
				ELSIF fb_CfgGetIPAddr.status <> ERR_FUB_BUSY OR (IP_AdressLocal = 'ERROR') THEN
					IP_LocalValid := FALSE;
					TCP_Status 		:= OPEN_TCP;
				END_IF
			END_IF	
		
		OPEN_TCP:
			fb_TcpOpen.enable	:= TRUE;  
			IF IP_LocalValid THEN
				fb_TcpOpen.pIfAddr 	:= ADR(IP_AdressLocal);
			ELSE
				fb_TcpOpen.pIfAddr 	:= 0;
			END_IF
			fb_TcpOpen.port 	:= Local_Port;
			fb_TcpOpen.options 	:= tcpOPT_REUSEADDR;
			fb_TcpOpen();
			IF fb_TcpOpen.status = ERR_FUB_BUSY THEN
				readResponse := TRUE;
			END_IF
			IF readResponse THEN
				IF fb_TcpOpen.status = ERR_OK THEN
					IF Enable_Server THEN
						TCP_Status := CFG_SERVER;
					ELSE
						TCP_Status := CFG_CLIENT;
					END_IF
				ELSIF fb_TcpOpen.status = tcpERR_SOCKET_BIND THEN
					ERR_NO_RESPONSE	:= FALSE;
					TCP_Status 		:= CLOSE2;
				END_IF
			END_IF
			IF NOT Enable_Com THEN
				TCP_Status 	:= CLOSE2;
			END_IF

		CFG_SERVER:
			fb_TcpServer.enable 	:= TRUE;             
			fb_TcpServer.ident 		:= fb_TcpOpen.ident;
			fb_TcpServer.backlog 	:= 1;
			fb_TcpServer.pIpAddr 	:= ADR(WhoIsConnected);
			fb_TcpServer();
			TON_ConnectionTimeOut.IN := fb_TcpServer.status = ERR_FUB_BUSY;
			TON_ConnectionTimeOut.PT := t#20s;
			TON_ConnectionTimeOut();
			IF fb_TcpServer.status = ERR_FUB_BUSY THEN
				readResponse := TRUE;
			END_IF
			IF readResponse THEN
				IF fb_TcpServer.status = ERR_OK THEN
					TCP_Status 	:= ESTABLISHED_CONNECTION_AS_SERVER;
				ELSIF (fb_TcpServer.status <> ERR_FUB_BUSY) AND (fb_TcpServer.status <> ERR_OK) THEN
					TCP_Status 		:= CLOSE1;
					ERR_INTERNAL	:= TRUE;
				END_IF
			END_IF
//			IF NOT Enable_Com OR TON_ConnectionTimeOut.Q THEN
//				TCP_Status 	:= CLOSE2;
//			END_IF
		
		CFG_CLIENT:
			fb_TcpClient.enable 	:= TRUE;                
			fb_TcpClient.ident 		:= fb_TcpOpen.ident;
			fb_TcpClient.portserv 	:= Remote_Port;
			fb_TcpClient.pServer 	:= ADR(IP_Address);
			fb_TcpClient();
			IF fb_TcpClient.status = ERR_FUB_BUSY THEN
				readResponse := TRUE;
			END_IF
			IF readResponse THEN
				IF fb_TcpClient.status = ERR_OK THEN
					TCP_Status 	:= ESTABLISHED_CONNECTION_AS_CLIENT;
				ELSIF (fb_TcpClient.status <> ERR_FUB_BUSY) AND (fb_TcpClient.status <> ERR_OK) THEN
					ERR_INTERNAL	:= TRUE;
					TCP_Status 		:= CLOSE1;
				END_IF
			END_IF
			IF NOT Enable_Com THEN
				TCP_Status 	:= CLOSE1;
			END_IF
		
		ESTABLISHED_CONNECTION_AS_SERVER:
			TON_SendTime.IN := (TCP_CommStatus = RECEIVE_DATA);
			TON_SendTime.PT := Send_Time_Act;
			TON_SendTime();
			
			CASE TCP_CommStatus OF
				COMM_IDLE:
					TCP_CommStatus	:= SEND_DATA;
				
				SEND_DATA:
					fb_TcpSend.enable 	:= TRUE;
					fb_TcpSend.ident 	:= fb_TcpServer.identclnt;
					fb_TcpSend.pData 	:= Send_Buffer;
					fb_TcpSend.datalen 	:= Send_Length;
					fb_TcpSend();
				
					IF fb_TcpSend.status = ERR_FUB_BUSY THEN
						commResponse := TRUE;
					END_IF
					
					IF commResponse THEN
						IF fb_TcpSend.status	= ERR_OK THEN
							TCP_CommStatus	:= RECEIVE_DATA;
						ELSIF fb_TcpSend.status	= tcpERR_NOT_CONNECTED OR fb_TcpSend.status	= tcpERR_SYSTEM THEN
							TON_RcvTimeOut.IN := TRUE;
						END_IF
					END_IF
				
					IF TON_RcvTimeOut.Q THEN
						TON_RcvTimeOut.IN	:= FALSE;
						TCP_CommStatus		:= COMM_PING;
					END_IF
				
				RECEIVE_DATA:
					fb_TcpRecv.enable 	:= TRUE;
					fb_TcpRecv.ident 	:= fb_TcpServer.identclnt;
					fb_TcpRecv.pData 	:= Recv_Buffer;
					fb_TcpRecv.datamax 	:= Recv_Length; 
					fb_TcpRecv();
										
					IF commResponse THEN
						IF TON_SendTime.Q AND (fb_TcpRecv.status = ERR_OK OR fb_TcpRecv.status = tcpERR_NO_DATA) THEN
							TCP_CommStatus	:= SEND_DATA;
						ELSIF fb_TcpRecv.status	= tcpERR_NOT_CONNECTED OR fb_TcpRecv.status	= tcpERR_NO_DATA OR fb_TcpSend.status = tcpERR_SYSTEM THEN
							TON_RcvTimeOut.IN := TRUE;
						ELSIF NOT fb_TcpRecv.status = ERR_FUB_BUSY OR fb_TcpRecv.status = ERR_OK THEN
							TON_RcvTimeOut.IN := FALSE;
						END_IF
					END_IF
					
					IF fb_TcpRecv.status = ERR_FUB_BUSY THEN
						commResponse := TRUE;
					END_IF
					
					IF TON_RcvTimeOut.Q THEN
						TON_RcvTimeOut.IN	:= FALSE;
						TCP_CommStatus		:= COMM_PING;
					END_IF
				
				COMM_PING:
					fb_Ping.enable 		:= TRUE; 
					fb_Ping.IP_Address 	:= IP_Address; 
					fb_Ping();
					IF fb_Ping.PING_OK THEN
						PING_OK 		:=	TRUE;
						TCP_CommStatus	:= RECEIVE_DATA;
					ELSIF fb_Ping.ERROR THEN
						ERR_NO_RESPONSE := fb_Ping.ERR_NO_RESPONSE;
						ERR_INTERNAL	:= fb_Ping.ERR_INTERNAL;
						TCP_Status 		:= CLOSE1;
					END_IF
				
			END_CASE
			
			TON_RcvTimeOut.PT := Rcv_Time_Out;
			TON_RcvTimeOut();
			
			IF TON_RcvTimeOut.Q OR NOT Enable_Com THEN
				TCP_Status 		:= CLOSE1;
				ERR_NO_RESPONSE := TRUE;
			END_IF
			
		ESTABLISHED_CONNECTION_AS_CLIENT:	
			TON_SendTime.IN := (TCP_CommStatus = RECEIVE_DATA);
			TON_SendTime.PT := Send_Time_Act;
			TON_SendTime();
			
			CASE TCP_CommStatus OF
				COMM_IDLE:
					TCP_CommStatus	:= SEND_DATA;
				
				SEND_DATA:
					fb_TcpSend.enable 	:= TRUE;
					fb_TcpSend.ident 	:= fb_TcpOpen.ident;
					fb_TcpSend.pData 	:= Send_Buffer;
					fb_TcpSend.datalen 	:= Send_Length;
					fb_TcpSend();
				
					IF fb_TcpSend.status = ERR_FUB_BUSY THEN
						commResponse := TRUE;
					END_IF
					
					IF commResponse THEN
						IF fb_TcpSend.status = ERR_OK THEN
							TCP_CommStatus	:= RECEIVE_DATA;
						ELSIF fb_TcpSend.status	= tcpERR_NOT_CONNECTED OR fb_TcpSend.status	= tcpERR_SYSTEM THEN
							TON_RcvTimeOut.IN := TRUE;
						END_IF
					END_IF
				
					IF TON_RcvTimeOut.Q THEN
						TON_RcvTimeOut.IN	:= FALSE;
						TCP_CommStatus		:= COMM_PING;
					END_IF
				
				RECEIVE_DATA:
					fb_TcpRecv.enable 	:= TRUE;
					fb_TcpRecv.ident 	:= fb_TcpOpen.ident;
					fb_TcpRecv.pData 	:= Recv_Buffer;
					fb_TcpRecv.datamax 	:= Recv_Length; 
					fb_TcpRecv();
										
					IF commResponse THEN
						IF TON_SendTime.Q AND (fb_TcpRecv.status = ERR_OK OR fb_TcpRecv.status = tcpERR_NO_DATA) THEN
							TCP_CommStatus	:= SEND_DATA;
						ELSIF fb_TcpRecv.status	= tcpERR_NOT_CONNECTED OR fb_TcpRecv.status	= tcpERR_NO_DATA OR fb_TcpSend.status = tcpERR_SYSTEM THEN
							TON_RcvTimeOut.IN := TRUE;
						ELSIF NOT fb_TcpRecv.status = ERR_FUB_BUSY OR fb_TcpRecv.status = ERR_OK THEN
							TON_RcvTimeOut.IN := FALSE;
						END_IF
					END_IF
					
					IF fb_TcpRecv.status = ERR_FUB_BUSY THEN
						commResponse := TRUE;
					END_IF
					
					IF TON_RcvTimeOut.Q THEN
						TON_RcvTimeOut.IN	:= FALSE;
						TCP_CommStatus		:= COMM_PING;
					END_IF
				
				COMM_PING:
					fb_Ping.enable 		:= TRUE; 
					fb_Ping.IP_Address 	:= IP_Address; 
					fb_Ping();
					IF fb_Ping.PING_OK THEN
						PING_OK 		:=	TRUE;
						TCP_CommStatus	:= RECEIVE_DATA;
					ELSIF fb_Ping.ERROR THEN
						ERR_NO_RESPONSE := fb_Ping.ERR_NO_RESPONSE;
						ERR_INTERNAL	:= fb_Ping.ERR_INTERNAL;
						TCP_Status 		:= CLOSE1;
					END_IF
				
			END_CASE
						
			TON_RcvTimeOut.PT := Rcv_Time_Out;
			TON_RcvTimeOut();
			
			IF TON_RcvTimeOut.Q OR NOT Enable_Com THEN
				TCP_Status 		:= CLOSE1;
				ERR_NO_RESPONSE := TRUE;
			END_IF
		
		CLOSE1:
			IF Enable_Server THEN
				PING_OK := FALSE;
				fb_TcpClose.enable 	:= TRUE;
				fb_TcpClose.ident 	:= fb_TcpServer.identclnt;
				fb_TcpClose();
				IF fb_TcpClose.status = ERR_FUB_BUSY THEN
					readResponse := TRUE;
				END_IF
				IF readResponse THEN
					IF fb_TcpClose.status = ERR_OK OR fb_TcpClose.status = tcpERR_INVALID_IDENT THEN
						TCP_Status 	:= CLOSE2;
					END_IF
				END_IF
			ELSE
				TCP_Status 	:= CLOSE2;
			END_IF
				
		CLOSE2:
			PING_OK := FALSE;
			fb_TcpClose.enable 	:= TRUE;
			fb_TcpClose.ident 	:= fb_TcpOpen.ident;
			fb_TcpClose();
			IF fb_TcpClose.status = ERR_FUB_BUSY THEN
				readResponse := TRUE;
			END_IF
			IF readResponse THEN
				IF fb_TcpClose.status = ERR_OK OR fb_TcpClose.status = tcpERR_INVALID_IDENT THEN
					IF NOT Enable_Com THEN
						TCP_Status 	:= DISABLED;
					ELSE
						TCP_Status 	:= RECONNECTION;
					END_IF
				END_IF
			END_IF
		
		RECONNECTION:
			PING_OK := FALSE;
			TON_TCP_EnDelay.IN := TRUE;
			IF ConnectionAttempt = 0 THEN
				TON_TCP_EnDelay.PT := t#100ms;
			ELSIF ConnectionAttempt < 5 THEN
				TON_TCP_EnDelay.PT := t#5s;
			ELSIF ConnectionAttempt < 11 THEN
				TON_TCP_EnDelay.PT := t#30s;
			ELSIF ConnectionAttempt < 20 THEN
				TON_TCP_EnDelay.PT := t#5m;
			END_IF
			TON_TCP_EnDelay();
			IF TON_TCP_EnDelay.Q THEN
				TON_TCP_EnDelay(IN := FALSE);
				ConnectionAttempt := ConnectionAttempt + 1;
				TCP_Status := INITIALIZE_FB;
			ELSIF NOT Enable_Com THEN
				TCP_Status 	:= DISABLED;
			END_IF
	END_CASE
	
	IF TCP_Status <> oldTCP_Status THEN
		oldTCP_Status := TCP_Status;
		TON_ConnectionTimeOut(IN := FALSE);
		readResponse := FALSE;
	END_IF
	
	IF TCP_CommStatus <> oldTCP_CommStatus THEN
		oldTCP_CommStatus := TCP_CommStatus;
		commResponse := FALSE;
	END_IF
	
	TON_Connection_OK.IN := (TCP_Status = ESTABLISHED_CONNECTION_AS_SERVER) OR (TCP_Status = ESTABLISHED_CONNECTION_AS_CLIENT);
	TON_Connection_OK.PT := t#3s;
	TON_Connection_OK();
	Connection_OK := TON_Connection_OK.Q;
	
	IF Connection_OK THEN
		ConnectionAttempt 	:= 0;
		ERR_INTERNAL		:= FALSE;
		ERR_NO_RESPONSE		:= FALSE;
	END_IF
	
	ERROR := ERR_INTERNAL OR ERR_NO_RESPONSE;
END_FUNCTION_BLOCK