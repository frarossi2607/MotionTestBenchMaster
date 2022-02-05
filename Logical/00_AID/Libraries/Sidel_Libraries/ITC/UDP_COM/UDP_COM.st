(********************************************************************
 * COPYRIGHT -- Sidel
 ********************************************************************
 * Library: UDP_COM
 * File: UDP_COM.st
 * Author: Andrea.Cortesi
 * Created: Jun 26, 2013
 ********************************************************************
 * Implementation of library UDP_COM
 ********************************************************************) 

(* UDP COMMUNICATION FUNCTION BLOC IMPLEMENTATION *)
FUNCTION_BLOCK UDP_COM
	
	Send_Timer.PT := Send_Time_Act;
	Send_Timer();

	Rcv_Timer.PT := Rcv_Time_Out;
	Rcv_Timer();
		
	ConnectTimeOut_Timer.PT := T#2000ms;
	ConnectTimeOut_Timer();
	
	
	IF Rcv_Timer.Q THEN
		(* Close Communication UDP *)
		UDP_Step := 60;
	END_IF
	
	
	CASE UDP_Step OF
		
		0:	(* Open UDP Connection *)
			
			Rcv_Timer.IN := FALSE;	
						
			IF Enable_Com THEN
				Status := UDP_Connection_Waiting;
			ELSE
				Status := UDP_Not_Enabled;
			END_IF
			
			UDP_Com_UdpOpen.enable	 := Enable_Com;   
			UDP_Com_UdpOpen.pIfAddr  := 0;           (* Listen on all UDP Interfaces*)
			UDP_Com_UdpOpen.port 	 := Local_Port;  (* Port to listen*)
			UDP_Com_UdpOpen.options  := udpOPT_REUSEADDR;

			UDP_Com_UdpOpen();    (* Call the Function*)
			
			Socket_ID 	             := UDP_Com_UdpOpen.ident;
			Open_Status              := UDP_Com_UdpOpen.status;
			
			
			IF Open_Status = 0 THEN  (* UdpOpen successful*)
				(* Initialization Send and Receive Ident *)
				UDP_Step := 40;	
			END_IF
			
			Connection_OK := FALSE;
		
			
		40: (* Initialization Send and Receive Ident *)
		    
			Rcv_Timer.IN := TRUE;		
					
			(* Data send block parameters *)
			UDP_Com_UdpSend.enable  := TRUE;             
			UDP_Com_UdpSend.ident   := Socket_ID;	                    (* Client Ident from UDP_Open *)
			UDP_Com_UdpSend.pHost   := ADR(IP_Address);	                (* IP Address of remote partner *)
			UDP_Com_UdpSend.port    := Remote_Port;		                (* Port number of remote partner *)
			UDP_Com_UdpSend.pData   := Send_Buffer;	                    (* Which data to send *)
			UDP_Com_UdpSend.datalen := Send_Length;	                    (* Lenght of data to send *)
			UDP_Com_UdpSend.flags   := 0;
			
			(* Data receive block parameters *)
			UDP_Com_UdpRecv.enable  := TRUE;
			UDP_Com_UdpRecv.ident   := Socket_ID;	                    (* Client Ident from UDP_Open *)
			UDP_Com_UdpRecv.pIpAddr := ADR(IP_Address);	                (* IP Address of remote partner *)
			UDP_Com_UdpRecv.pData   := Recv_Buffer;	                    (* Where to store the incoming data *)
			UDP_Com_UdpRecv.datamax := Recv_Length;                     (* Lenght of data buffer *)
			UDP_Com_UdpRecv.flags   := 0;
			
			
			UDP_Step := 50;
	
			IF NOT(Enable_Com) THEN
				UDP_Step := 0;
			END_IF

			Connection_OK := FALSE;
			
		50: (* Send and Receive Data *)

			Send_Timer.IN := NOT(Send_Timer.Q);			
			
			UDP_Com_UdpRecv();  (* Call the "Data Recv" function block *)	
			
			Recv_Status        := UDP_Com_UdpRecv.status;
			Recv_Data_Length   := UDP_Com_UdpRecv.recvlen;
			
			IF Send_Timer.Q THEN
				UDP_Com_UdpSend.enable := TRUE;
			END_IF
		
			
			UDP_Com_UdpSend();	(* Call the "Data Sent" function block *)						
		
			Send_Status        := UDP_Com_UdpSend.status;
			Send_Data_Length   := UDP_Com_UdpSend.sentlen;
			Status 	 	       := UDP_Connected_OK;
			
			IF UDP_Com_UdpSend.enable THEN

				IF (Send_Status <> 65535) AND (Send_Status <> 0) THEN
					UDP_Step := 60; 
					Status   := UDP_Error_Sending;
				END_IF
		
				IF (Send_Status = 0) THEN
					Send_Timer.IN := FALSE;	
				ELSE
					Send_Timer.IN := TRUE;	
				END_IF

		
			END_IF
			
			IF (Recv_Status <> 65535) AND (Recv_Status <> 0) AND (Recv_Status <> udpERR_NO_DATA) THEN
				UDP_Step := 60; 
				Status   := UDP_Error_Receiving;
			END_IF
	
			IF (Recv_Status = 0) THEN
				Rcv_Timer.IN := FALSE;	
			ELSE
				Rcv_Timer.IN := TRUE;	
			END_IF
		

			IF NOT(Enable_Com) THEN
				UDP_Step := 60;
			END_IF

			Connection_OK := TRUE;	
			
			
		60: (* Close Communication UDP *)

			Rcv_Timer.IN := FALSE;	
		
			
			UDP_Com_UdpClose.enable := TRUE;
			UDP_Com_UdpClose.ident  := Socket_ID;
			UDP_Com_UdpClose();

			Close_Status := UDP_Com_UdpClose.status;	
			Status 	 	 := UDP_Connection_Close;
			
			IF (Close_Status = 0) THEN 
				UDP_Step := 70;
			END_IF			
		
			Connection_OK := FALSE;
		
		70: (* Wait Open New Connection *)	
			
			Rcv_Timer.IN            := FALSE;
			ConnectTimeOut_Timer.IN := TRUE;		
						
			IF ConnectTimeOut_Timer.Q THEN
				UDP_Step                := 0;
				ConnectTimeOut_Timer.IN := FALSE;	
			END_IF	
			
			Status 	 	  := UDP_Connection_Waiting;
			Connection_OK := FALSE;
			
		ELSE
		
			UDP_Step := 60;	
			
	END_CASE		
	
	
	CASE Status OF
	
		0: Status_Message := 'UDP Connection OK';
		1: Status_Message := 'UDP Not Enabled';
		2: Status_Message := 'UDP Error Sending';
		3: Status_Message := 'UDP Error Receiving';
		4: Status_Message := 'UDP Connection Close';
		5: Status_Message := 'UDP Send Receive Run';
	   10: Status_Message := 'UDP Connection Waiting';
				
	ELSE
		   Status_Message := 'Not Define';		
	END_CASE
	
	
END_FUNCTION_BLOCK