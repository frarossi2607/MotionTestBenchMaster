(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: TCP
 * File: TCP.typ
 * Author: Marco.Nicoli
 * Created: October 25, 2016 : Initial version
 *********************************************************************)

FUNCTION_BLOCK TCP_COM (*TCP communication function*)
	VAR_INPUT
		Enable_Com : BOOL; (*Enable Communication*)
		Enable_Server : BOOL; (*Enable the server mode (False = Client mode | True = Serve mode)*)
		ETH_Card : STRING[16] := 'IF2'; (*Optional Parameter 
Work with the following syntax when using IF2 on board: 
IF2
Work with the following syntax when using a POWERLINK card: 
SL<x>.SS<y>.IF<z>.PLKETH or SL<x>.SS<y>.IF<z>.ETH
*)
		IP_Address : STRING[16]; (*Partner IP address. (e.g. '10.1.92.20') (as a string)*)
		Local_Port : UINT; (*Local port number.*)
		Remote_Port : UINT; (*Remote port number.*)
		Recv_Buffer : UDINT; (*Received data buffer address (string given as a pointer)*)
		Recv_Length : UDINT; (*Reiceved data maximum length (in bytes)*)
		Send_Buffer : UDINT; (*Data to send buffer address (string given as a pointer)*)
		Send_Length : UDINT; (*Sent data length (in bytes)*)
		Send_Time_Act : TIME; (*Data send time cadence (in ms) (typical value: 100ms)*)
		Rcv_Time_Out : TIME; (*Reception time out setpoint (in ms) (typical value: 1000ms)*)
	END_VAR
	VAR_OUTPUT
		Connection_OK : BOOL; (*True = both PLCs are connected*)
		PING_OK : BOOL;
		ERROR : BOOL;
		ERR_NO_RESPONSE : BOOL;
		ERR_INTERNAL : BOOL;
	END_VAR
	VAR
		WhoIsConnected : STRING[16]; (*Connected client IP address*)
		IP_AdressLocal : STRING[16];
		TON_SendTime : TON;
		TON_RcvTimeOut : TON;
		TON_TCP_EnDelay : TON;
		TON_ConnectionTimeOut : TON;
		ConnectionAttempt : UINT;
		fb_Ping : PING_Fun;
		fb_TcpOpen : TcpOpen; (*Communication opening function block*)
		fb_TcpServer : TcpServer; (*Server creation function block*)
		fb_TcpClient : TcpClient; (*Client function block*)
		fb_TcpSend : TcpSend; (*Data sending function block*)
		fb_TcpRecv : TcpRecv; (*Data receiving function block*)
		fb_TcpClose : TcpClose; (*Communication closing function block*)
		fb_CfgGetIPAddr : CfgGetIPAddr;
		oldTCP_Status : TCP_Status_Type;
		oldTCP_CommStatus : TCP_SendRec_Type;
		IP_LocalValid : BOOL;
		readResponse : BOOL;
		commResponse : BOOL;
		TCP_Status : TCP_Status_Type; (*Implemented communication block status*)
		TCP_CommStatus : TCP_SendRec_Type; (*Implemented communication block status*)
		TON_Connection_OK : TON;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK PING_Fun (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		enable : BOOL;
		IP_Address : STRING[80];
	END_VAR
	VAR_OUTPUT
		PING_OK : BOOL;
		ERROR : BOOL;
		ERR_NO_RESPONSE : BOOL;
		ERR_INTERNAL : BOOL;
	END_VAR
	VAR
		Status : Ping_Status_Type;
		Fb_IcmpPing : IcmpPing;
		PachetRecived : USINT;
		PachetSent : USINT;
		PachetLoss : USINT;
		readResponse : BOOL;
	END_VAR
END_FUNCTION_BLOCK
