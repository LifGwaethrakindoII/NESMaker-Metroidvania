;;; aim towards player.
	TYA
	PHA
	TXA
	PHA
	STA tempx
	
		LDA Object_x_hi,x
		STA tempA
		LDA Object_y_hi,x
		STA tempB
		LDX player1_object
		LDA Object_x_hi,x
		STA tempC
		LDA Object_y_hi,x
		STA tempD
		
		LDX tempx
		
	MoveTowardsPoint tempA, tempC, tempB, tempD
	LDA Object_direction,x
	AND #%00000111
	ORA #%00001000
	STA Object_direction,x
	
	PLA
	TAX
	PLA
	TAY