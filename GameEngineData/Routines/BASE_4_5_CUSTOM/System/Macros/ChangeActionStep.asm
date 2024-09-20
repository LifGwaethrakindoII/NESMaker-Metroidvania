MACRO ChangeActionStep arg0, arg1
	;arg0 = what object?
	;arg1 = what step?

	
	
	TXA
	PHA
	
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	
	
	JSR doChangeActionStep
	
	PLA
	TAX
	
	ENDM