MACRO ChangeFacingDirection arg0, arg1
	;arg0 = object
	;arg1 = what should be the new facing direction?
	TXA
	PHA
	
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	
	JSR oChangeFacingDirection

	PLA
	TAX
	ENDM