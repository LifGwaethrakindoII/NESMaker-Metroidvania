;;; Simple Reset
	;; check to see if object colliding is a player.
	;; if not, do not reset.
	CPX player1_object
	BEQ +doHurtRecoil
		JMP +dontHurtRecoil
	+doHurtRecoil
		
		DEC myHealth
		
		BMI +healthBelowZero
		BEQ +healthBelowZero
			JMP +notDeadYet
		+healthBelowZero
			JMP +playerHealthIsZero
		+notDeadYet
		UpdateHudElement #$02
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
			LDA Object_direction,x
			AND #%00000111
			CLC
			ADC #$04
			AND #%00000111
			TAY
			LDA DirectionTableOrdered,y
			STA temp
			LDA Object_direction,x
			AND #%00001111
			ORA temp
			STA Object_direction,x
			JMP +skipHurt

	+playerHealthIsZero:

	LDA continueMap
	STA warpMap
	
	LDA continueScreen
	STA currentNametable
	
	LDX player1_object
	STA Object_screen,x
	
	LDA #$02 ;; this is continue type warp.
	STA screenTransitionType ;; is of warp type

	
	LDA gameHandler
	ORA #%10000000
	STA gameHandler ;; this will set the next game loop to update the screen.
	LDA myMaxHealth
	STA myHealth
+skipHurt
	
+dontHurtRecoil: