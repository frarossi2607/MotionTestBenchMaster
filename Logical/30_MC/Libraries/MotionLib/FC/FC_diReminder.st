FUNCTION FC_diReminder
	diReminder_a	:= (i_diDividend - (i_diDividend / i_diDivisor) * i_diDivisor);
	diReminder_b	:= (diReminder_a + i_diDivisor - ((diReminder_a + i_diDivisor) / i_diDivisor) * i_diDivisor);

	FC_diReminder	:= (diReminder_b + i_diStart - (((diReminder_b + i_diStart) / i_diDivisor) * i_diDivisor));
END_FUNCTION
