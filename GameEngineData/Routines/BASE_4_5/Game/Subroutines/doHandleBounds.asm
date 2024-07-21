doHandleBounds:
	SwitchBank #$18
	JSR doHandleBounds_bank18
	ReturnBank
	
	RTS