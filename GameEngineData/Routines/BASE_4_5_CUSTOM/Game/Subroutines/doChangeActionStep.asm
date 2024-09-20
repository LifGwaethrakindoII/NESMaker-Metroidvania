doChangeActionStep:
	TXA
	PHA
	LDX arg0_hold
	LDA arg1_hold
	ASL
	ASL
	ASL
	STA temp
	LDA Object_frame,x
	AND #%11000111
	ORA temp
	STA Object_frame,x
	
	DoObjectAction arg0_hold, arg1_hold
	
	PLA
	TAX
	RTS