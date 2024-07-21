;;; Simple Reset
	;; check to see if object colliding is a player.
	;; if not, do not reset.

	CPX player1_object
	BEQ +doHurtRecoil
		JMP +dontHurtRecoil
	+doHurtRecoil
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
			LDA xPrev
			STA Object_x_hi,x
			LDA yPrev
			STA Object_y_hi,x
	+notAlreadyInHurtState
	
+skipHurt
	
+dontHurtRecoil:
