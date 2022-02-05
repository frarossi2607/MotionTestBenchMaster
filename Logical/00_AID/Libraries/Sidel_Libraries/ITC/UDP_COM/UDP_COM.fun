(********************************************************************
 * COPYRIGHT -- Sidel
 ********************************************************************
 * Library: UDP_COM
 * File: UDP_COM.fun
 * Author: Andrea.Cortesi
 * Created: May 28, 2013
 ********************************************************************
 * Functions and function blocks of library UDP_COM
 ********************************************************************)

FUNCTION_BLOCK UDP_COM (*UDP Communication Function*)
	VAR_INPUT
		Enable_Com : BOOL; (*Enable Communication*)
		IP_Address : STRING[40]; (*Partner IP address. (e.g. '10.1.92.20') (as a string)*)
		Local_Port : UINT; (*Local port number.*)
		Remote_Port : UINT; (*Remote port number.*)
		Recv_Buffer : UDINT; (*Received data buffer address (string given as a pointer)*)
		Recv_Length : UDINT; (*Reiceved data maximum length (in bytes)*)
		Send_Buffer : UDINT; (*Data to send buffer address (string given as a pointer)*)
		Send_Length : UDINT; (*Sent data length (in bytes)*)
		Rcv_Time_Out : TIME; (*Reception time out setpoint (in ms) (typical value: 1000ms)*)
		Send_Time_Act : TIME; (*Data send time cadence (in ms) (typical value: 100ms)*)
	END_VAR
	VAR_OUTPUT
		Connection_OK : BOOL; (*True = both PLCs are connected*)
		Recv_Data_Length : UDINT; (*Length of the bytes received.*)
		Send_Data_Length : UDINT; (*Length of the bytes send*)
		Status : USINT; (*Communication status. Status = 0, means communication is OK*)
		Status_Message : STRING[25]; (*Communication status string*)
	END_VAR
	VAR
		Socket_ID : UDINT; (*Identifier sent by the UdpOpen block *)
		UDP_Com_UdpOpen : UdpOpen; (*Communication opening function block*)
		UDP_Com_UdpClose : UdpClose; (*Communication closing function block*)
		UDP_Com_UdpSend : UdpSend; (*Data sending function block*)
		UDP_Com_UdpRecv : UdpRecv; (*Data receiving function block*)
		UDP_Step : USINT; (*Implemented communication block status*)
		Open_Status : UINT; (*Communication opening function block status*)
		Send_Status : UINT; (*Data sending function block status*)
		Recv_Status : UINT; (*Data receiving function block status*)
		Close_Status : UINT; (*communication closing function block status*)
		Send_Timer : TON; (*Sending timer*)
		Rcv_Timer : TON; (*Receiveing timer*)
		ConnectTimeOut_Timer : TON; (*Connection Time Out*)
	END_VAR
END_FUNCTION_BLOCK
