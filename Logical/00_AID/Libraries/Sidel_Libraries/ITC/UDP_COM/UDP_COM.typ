(********************************************************************
 * COPYRIGHT - Sidel Spa
 ********************************************************************
 * Library: UDP_COM
 * File: UDP_COM.typ
 * Author: Andrea.Cortesi
 * Created: May 28, 2013
 ********************************************************************
 * Data types of library UDP_COM
 ********************************************************************)

TYPE
	UDP_DataType : 	STRUCT 
		Connection_OK : BOOL;
		Com_Status : UINT; (*(0=Connect OK;1=Not Enabled;2=Error Sending;3=Error Receiving;10=Connection Waiting)*)
	END_STRUCT;
END_TYPE
