;;; this behavior will wait until there is proximity between the object and the player in the x position,
;;; and then jump to the next behavior when the condition is true.
	
	TXA
	PHA
		LDX player1_object
		LDA Object_x_hi,x
		STA tempA
		LDA Object_screen,x
		STA tempB

	PLA
	TAX
	
	LDA tempB
	CMP Object_screen,x
	BNE +skip
	
	LDA tempA
	SEC
	SBC Object_x_hi,x
	BCS +distIsPos
		;; dist is neg
		EOR #$FF
		ADC #$01
	+distIsPos
		CMP #$80
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
	+skip