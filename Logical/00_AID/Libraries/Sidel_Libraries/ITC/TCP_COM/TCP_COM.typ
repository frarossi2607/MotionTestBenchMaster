(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: TCP
 * File: TCP.typ
 * Author: Marco.Nicoli
 * Created: October 25, 2016 : Initial version
 *********************************************************************)

TYPE
	TCP_DataType : 	STRUCT 
		Connection_OK : BOOL;
		Com_Status : UINT; (*(0=Connect OK;1=Not Enabled;2=Error Sending;3=Error Receiving;10=Connection Waiting)*)
		Recv_Buffer : ARRAY[0..20]OF USINT;
		Send_Buffer : ARRAY[0..20]OF USINT;
	END_STRUCT;
	TCP_Status_Type : 
		(
		DISABLED,
		INITIALIZE_FB,
		INITIAL_PING,
		READ_LOCAL_IP,
		OPEN_TCP,
		CFG_SERVER,
		CFG_CLIENT,
		ESTABLISHED_CONNECTION_AS_SERVER,
		ESTABLISHED_CONNECTION_AS_CLIENT,
		CLOSE1,
		CLOSE2,
		RECONNECTION
		);
	TCP_SendRec_Type : 
		(
		COMM_IDLE,
		SEND_DATA,
		RECEIVE_DATA,
		COMM_PING
		);
	Ping_Status_Type : 
		(
		NO_EXECUTION,
		EXECUTION,
		SUCCESSFUL,
		NO_RESPONSE,
		ERROR_INTERNAL
		);
END_TYPE
