	TXA
	STA temp
	GetActionStep temp
	CMP #$07 ;; we will use action step 7 for hurt.
	BEQ +doSkipHurtingThisObject ;; if he is hurt, he can't be hurt again.
		ChangeActionStep temp, #$07
		LDA #$80
		STA Object_action_timer,x
		DEC Object_health,x
		LDA Object_health,x
		BNE +doSkipHurtingThisObject
			DestroyObject
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
			+notZeroCount
	+doSkipHurtingThisObject

