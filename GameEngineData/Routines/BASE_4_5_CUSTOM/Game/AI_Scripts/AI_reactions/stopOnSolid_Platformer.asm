;;;; ...this will only work if the current labels are observed.
;;;; This assumes that the label "donePositionUpdate" precedes stop-code at the end of this subroutine.
;;;; Assumes that 
;;;; In a a platform game, there are different things that happen if an object runs into a block from below, above, or the side.

	TXA
	PHA
	STA tempx

	 LDA #$00
	 STA Object_x_lo,x
	 STA Object_h_speed_hi,x
	 STA Object_h_speed_lo,x
	 
	 LDA Object_v_speed_hi,x
	 BMI +isJumpingUpWhenHittingSolid
		JMP +isFallingDownWhenHittingSolid
	+isJumpingUpWhenHittingSolid
		
		;; is jumping up when hitting a solid.
		;; ONLY do this is there is a solid directly over head.
		LDY Object_type,x
		LDA Object_x_hi,x
		CLC
		ADC self_left
		STA temp
		JSR getPointColTable
		
		
		LDA Object_y_hi,x
		CLC
		ADC self_top
		CLC
		ADC Object_v_speed_hi,x
		SEC
		SBC #$01
		STA temp1
		CheckCollisionPoint temp, temp1, #$01, tempA
		BEQ +stopVerticalMovementOnSolidHit
			LDX tempx
			LDY Object_type,x
			LDA Object_x_hi,x
			CLC
			ADC self_right
			STA temp
			JSR getPointColTable
			CheckCollisionPoint temp, temp1, #$01, tempA
			BEQ +stopVerticalMovementOnSolidHit
				;; there is nothing above head.
				LDX tempx
				JMP +isFallingDownWhenHittingSolid
			+stopVerticalMovementOnSolidHit
				LDX tempx
				LDY Object_type,x
				LDA #$00
				STA Object_v_speed_lo,x
				STA Object_v_speed_hi,x
				; LDA tileY
				; AND #%11110000
				; CLC
				; ADC #$0F
				; SEC
				; SBC ObjectBboxTop,y
				; STA Object_y_hi,x
				; STA yHold_hi

	+isFallingDownWhenHittingSolid:
	 

	PLA
	TAX

	JMP donePositionUpdate
	