MACRO StartMoving arg0, arg1
	;arg0 = object
	;arg1 = direction

	TXA
	PHA
	
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold

	
	JSR oStartMovingInADirection
	
	PLA
	TAX
	
	
	ENDM