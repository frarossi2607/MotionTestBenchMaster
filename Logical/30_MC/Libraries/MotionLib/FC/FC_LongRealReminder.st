FUNCTION FC_LongRealReminder
	lrReminder_a	:= (i_lrDividend - (DINT_TO_LREAL(TRUNC(i_lrDividend / i_lrDivisor)) * i_lrDivisor));
	lrReminder_b	:= (lrReminder_a + i_lrDivisor - (DINT_TO_LREAL(TRUNC((lrReminder_a + i_lrDivisor) / i_lrDivisor)) * i_lrDivisor));

	FC_LongRealReminder	:= (lrReminder_b + i_lrStart - (DINT_TO_LREAL(TRUNC((lrReminder_b + i_lrStart) / i_lrDivisor)) * i_lrDivisor));
END_FUNCTION