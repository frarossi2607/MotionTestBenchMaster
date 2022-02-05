FUNCTION FC_RealReminder
	rReminder_a	:= (i_rDividend - (DINT_TO_REAL(TRUNC(i_rDividend / i_rDivisor)) * i_rDivisor));
	rReminder_b	:= (rReminder_a + i_rDivisor - (DINT_TO_REAL(TRUNC((rReminder_a + i_rDivisor) / i_rDivisor)) * i_rDivisor));

	FC_RealReminder	:= (rReminder_b + i_rStart - (DINT_TO_REAL(TRUNC((rReminder_b + i_rStart) / i_rDivisor)) * i_rDivisor));
END_FUNCTION
