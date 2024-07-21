	TXA
	STA temp
	GetActionStep temp
	CMP #$07 ;; we will use action step 7 for hurt.
	BEQ +doSkipHurtingThisObject ;; if he is hurt, he can't be hurt again.
		ChangeActionStep temp, #$07
		DEC Object_health,x
		LDA Object_health,x
		BNE +doSkipHurtingThisObject
			DestroyObject
	+doSkipHurtingThisObject

