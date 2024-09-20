MACRO DoObjectAction arg0, arg1
	;arg0 = what object?
	;arg1 = what behavior?

	
	
	TXA
	PHA
	
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	
	SwitchBank #$1C
		JSR doObjectAction
	ReturnBank
	PLA
	TAX
	
	ENDM