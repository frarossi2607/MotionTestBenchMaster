(* Fb for mananging alarms *)
FUNCTION_BLOCK FB_ExceptionAlarmX
	IF i_pxInitCoreDone THEN
		IF i_xConditions AND NOT xAlarmActive THEN
			xAlarmActive := TRUE;
			MpAlarmXSet(MpLink := i_pstMpAlarmXLink, Name := i_psAlarmName);
		ELSIF NOT i_xConditions AND xAlarmActive THEN
			IF i_pxAcknowledge OR i_xAutoAck THEN
				xAlarmActive := FALSE;			
				MpAlarmXReset(MpLink := i_pstMpAlarmXLink, Name := i_psAlarmName);
			END_IF
		END_IF
		q_xAlarmActive := xAlarmActive;
	END_IF
END_FUNCTION_BLOCK
