
	TXA
	PHA
	LDA gameHandler
	AND #%10000000
	BEQ +canHurtPlayer
		JMP +skipHurt
+canHurtPlayer:
	TXA
	STA temp
	GetActionStep temp
	CMP #$07
	BNE +canHurtPlayer
		JMP +skipHurt
	+canHurtPlayer
	
	DEC myLives
	
	UpdateHudElement #$01
	LDA myLives
	BNE +notZeroLives
		;;;zero lives
		JMP RESET
	+notZeroLives
		ChangeActionStep player1_object, #$07
			;; recoil
			LDA #$00
			STA Object_h_speed_hi,x
			STA Object_h_speed_lo,x
			STA Object_v_speed_hi,x
			STA Object_v_speed_lo,x
			; LDA xPrev
			; STA Object_x_hi,x
			; LDA yPrev
			; STA Object_y_hi,x
	
	
+skipHurt
	PLA
	TAX