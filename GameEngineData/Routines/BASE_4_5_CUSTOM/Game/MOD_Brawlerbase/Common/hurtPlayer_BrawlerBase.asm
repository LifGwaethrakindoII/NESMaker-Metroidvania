	LDA gameHandler
	AND #%10000000
	BEQ +canHurtPlayer
		JMP +skipHurt
+canHurtPlayer:
	
	
	; TXA
	; STA temp
	; GetActionStep temp
	; CMP #$07
	; BNE +canHurtPlayer
		; JMP +skipHurt
	; +canHurtPlayer
	;;; will presume there is a variable myHealth
	;;; and that player hurt state is action state 7.
	GetActionStep player1_object
	CMP #$07 ;; hurt state.
	BNE +notAlreadyInHurtState
		JMP +skipHurt
	+notAlreadyInHurtState
	
		
		
		 DEC myHealth
		
		 BMI +healthBelowZero
		 BEQ +healthBelowZero
			 JMP +notDeadYet
		 +healthBelowZero
			 JMP +playerHealthIsZero
		 +notDeadYet
;		 UpdateHudElement #$02
		 ChangeActionStep player1_object, #$07
		 JMP +skipHurt
			; ;; recoil
			; LDA #$00
			; STA Object_h_speed_hi,x
			; STA Object_h_speed_lo,x
			; STA Object_v_speed_hi,x
			; STA Object_v_speed_lo,x
			; LDA xPrev
			; STA Object_x_hi,x
			; LDA yPrev
			; STA Object_y_hi,x
	; +notAlreadyInHurtState
		; LDA Object_x_hi,x
		; CLC
		; ADC self_center_x
		; STA tempA
		; LDA Object_y_hi,x
		; CLC
		; ADC self_center_y
		; STA tempB
		; TXA 
		; PHA
			; LDX otherObject
			; LDA Object_x_hi,x
			; CLC
			; ADC other_center_x
			; STA tempC
			; LDA Object_y_hi,x
			; CLC
			; ADC other_center_y
			; STA tempD
		; PLA
		; TAX
	
		; ;;; RECOIL
		; ;;; find the center.
		; LDA tempA
		; SEC
		; SBC tempC
		; bpl +gotAbs ;; if positive, this is abs value
			; EOR #$FF
			; CLC
			; ADC #$01
		; +gotAbs
			; STA temp
			
		; LDA tempB
		; SEC
		; SBC tempD
		; bpl +gotAbs
			; EOR #$FF
			; CLC
			; ADC #$01
		; +gotAbs
			; ;;; now abs of y is in A
			; CMP temp
			; BCC +recoilHor
				; ;; recoil vert
				; LDA tempB
				; CMP tempD
				; BCS +recoilDown
					; LDA Object_direction,x
					; AND #%00001111
					; ORA #%00100000
					; STA Object_direction,x
					; JMP +skipHurt
				; +recoilDown
					; LDA Object_direction,x
					; AND #%00001111
					; ORA #%00110000
					; STA Object_direction,x
					; JMP +skipHurt
			; +recoilHor
				; LDA tempA
				; CMP tempC
				; BCS +recoilRight
					; LDA Object_direction,x
					; AND #%00001111
					; ORA #%10000000
					; STA Object_direction,x
					; JMP +skipHurt

				; +recoilRight
					; LDA Object_direction,x
					; AND #%00001111
					; ORA #%11000000
					; STA Object_direction,x
					; JMP +skipHurt
	
		; JMP +skipHurt
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