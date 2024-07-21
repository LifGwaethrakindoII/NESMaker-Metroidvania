oChangeFacingDirection:
	LDX arg0_hold
	LDA Object_direction,x
	AND #%11111000
	ORA arg1_hold
	STA Object_direction,x
	RTS