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
	TXA
	STA temp
	GetActionStep temp
	CMP #$07 ;; hurt state.
	BNE +notAlreadyInHurtState
		JMP +skipHurt
	+notAlreadyInHurtState
	
		ChangeActionStep temp, #$07
		
		 LDA Object_health,x
		 SEC
		 SBC #$01
		 BEQ +healthBelowZero
		 BMI +healthBelowZero
			STA Object_health,x
			JMP +skipHurt
		+healthBelowZero
			DestroyObject
			;;;; if this is set to a right edge
			;;;; flip the bit so that scrolling can continue
			;;;; if all bad guys are gone.
			CountObjects #%00001000
			BNE +notZeroCount
				LDA scrollByte
				ORA #%00000010
				STA scrollByte
				;;; if there are no more monsters left, we want to disable
				;;; the edge check for scrolling.
				LDA ScreenFlags00
				AND #%11101111
				STA ScreenFlags00

			
		+notZeroCount:
+skipHurt