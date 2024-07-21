MACRO UpdatePosition arg0, arg1, arg2
	;arg0 = object
	;arg1 = new x
	;arg2 = new y
	TXA
	PHA
	
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	LDA arg2
	STA arg2_hold
	
	JSR oUpdatePosition
	
	PLA
	TAX
	
	ENDM