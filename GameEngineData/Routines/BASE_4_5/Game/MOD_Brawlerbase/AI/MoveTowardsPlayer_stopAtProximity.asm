;;; aim towards player, but change to next action state on proximity.


	TXA
	PHA
		LDX player1_object
		LDA Object_x_hi,x
		STA tempA

	PLA
	TAX
	
	LDA tempA
	SEC
	SBC Object_x_hi,x
	BCS +distIsPos
		;; dist is neg
		EOR #$FF
		ADC #$01
	+distIsPos
		CMP #$10
		BCC +updateActionStep
		JMP +skip
	+updateActionStep:
		;; jump to next action state.
		
		TXA
		STA temp
		GetActionStep temp
		CLC
		ADC #$01
		AND #%00000111
		STA temp1
		ChangeActionStep temp, temp1
	
		JMP +dontMoveTowards
	+skip





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
	
+dontMoveTowards