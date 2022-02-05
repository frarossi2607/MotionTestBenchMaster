(* Reminder With Minimum Value *)
FUNCTION FC_ReminderShift
	LocalDivisor	:= SEL(Divisor<>0, 1, Divisor);
		
	ReminderA	:= (Dividend - ((Dividend / LocalDivisor) * LocalDivisor));
	ReminderB	:= (ReminderA + Divisor - ((ReminderA + LocalDivisor) / LocalDivisor) * LocalDivisor);
	ReminderC	:= (ReminderB + Start - ((ReminderB + Start) / LocalDivisor) * LocalDivisor);
	
	FC_ReminderShift	:= SEL(ReminderC <> 0, LocalDivisor, ReminderC);
END_FUNCTION
