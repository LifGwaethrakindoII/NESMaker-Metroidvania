MACRO StopMoving arg0, arg1
	;arg0 = object
	;arg1 = stop inertia in what direction, FF = all
	TXA
	PHA
	
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	
	JSR oStopMoving

	PLA
	TAX
	ENDM