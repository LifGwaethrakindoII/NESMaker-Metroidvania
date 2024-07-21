
	;;;;;;;;;;;;;;;;;; Presumes there is a variable called myLives defined in user variables.
	;;;;;;;;;;;;;;;;;; You could also create your own variable for this.

	LDA gameHandler
	AND #%10000000
	BEQ +canHurtPlayer
		JMP +skipHurt
+canHurtPlayer:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;; is the monster below our feet?
	;;;;;;;;;; and are we moving downward?

+doHurtPlayer	
	TXA
	STA temp
	GetActionStep temp
	CMP #$07
	BNE +canHurtPlayer
		JMP +skipHurt
	+canHurtPlayer
	;;; will presume there is a variable myHealth
	;;; and that player hurt state is action state 7.
	GetActionStep player1_object
	CMP #$07 ;; hurt state.
	BEQ +notAlreadyInHurtState
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
	+notAlreadyInHurtState
		LDA Object_x_hi,x
		CLC
		ADC self_center_x
		STA tempA
		LDA Object_y_hi,x
		CLC
		ADC self_center_y
		STA tempB
		TXA 
		PHA
			LDX otherObject
			LDA Object_x_hi,x
			CLC
			ADC other_center_x
			STA tempC
			LDA Object_y_hi,x
			CLC
			ADC other_center_y
			STA tempD
		PLA
		TAX
	
		;;; RECOIL L/R
			;+recoilHor
				LDA tempA
				CMP tempC
				BCS +recoilRight
					LDA Object_direction,x
					AND #%00001111
					ORA #%10000000
					STA Object_direction,x
					JMP +skipHurt

				+recoilRight
					LDA Object_direction,x
					AND #%00001111
					ORA #%11000000
					STA Object_direction,x
					JMP +skipHurt
	
+playerHealthIsZero:

	LDA continueMap
	STA warpMap
	
	LDA continueX
	STA newX
	LDA continueY
	STA newY
	
	LDA continueScreen
	STA warpToScreen
	STA camScreen
	

	LDA myMaxHealth
	STA myHealth
	
	
	
	WarpToScreen warpToMap, warpToScreen, #$02
		;; arg0 = warp to map.  0= map1.  1= map2.
		;; arg1 = screen to warp to.
		;; arg2 = screen transition type - most likely use 1 here.
			;; 1 = warp, where it observes the warp in position for the player.

	
+skipHurt