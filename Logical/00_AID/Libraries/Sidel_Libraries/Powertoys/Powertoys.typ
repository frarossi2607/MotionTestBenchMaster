(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: Powertoys
 * File: Powertoys.typ
 * Author: gibertinim
 * Created: March 27, 2014
 ********************************************************************
 * Data types of library Powertoys
 ********************************************************************)
(********************************                    CUSTOM LOGGER ENTRY                   ***********************************************************)

TYPE
	pwr_log_custom_entry : 	STRUCT  (*Custom logger entry string*)
		adr_string : UDINT; (*Address of the ascii string*)
		len : UDINT; (*Length of the binary memory data*)
		adr_mem : UDINT; (*Address to the binary memory data*)
		errorNum : UINT; (*Error number to write*)
		logLevel : USINT; (*Information level*)
	END_STRUCT;
END_TYPE

(*********************************                            HARDWARE LIST                          **************************************************************)

TYPE
	searchIO_info_typ : 	STRUCT  (*Hardware information list*)
		Path : STRING[80]; (*Station path*)
		ModelNumber : STRING[80]; (*Model number*)
		Name : STRING[80]; (*Hw name*)
		Serial : UDINT; (*Serial number*)
	END_STRUCT;
END_TYPE

(********************************                              AXIS INFORMATIONS                **************************************************************)

TYPE
	pwlInfo_typ : 	STRUCT  (*Powerlink node properties datatype*)
		number : USINT; (*Number of Powerlink Module*)
		path : STRING[80]; (*Path of Powerlink Module*)
		description : STRING[80]; (*Description of Powerlink Module*)
		name : STRING[80]; (*Name of Powerlink Module*)
		modelNumber : STRING[80]; (*Module number of powerlink *)
		present : BOOL; (*Enable blinking*)
	END_STRUCT;
END_TYPE
