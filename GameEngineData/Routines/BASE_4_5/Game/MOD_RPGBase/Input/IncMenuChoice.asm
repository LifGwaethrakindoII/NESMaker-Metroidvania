;;; add menu item up
	LDA gameSubState
	BEQ +skipMenu
	CMP #$01
	BNE +notInCommandMenu
		;;; in command menu
		INC currentCommandChoice
		LDA currentCommandChoice
		CMP #COMMAND_BOX_CHOICES
		BNE +notAtMaxChoice
			;; was at max choice so make choice zero.
			LDA #$00
			STA currentCommandChoice
		+notAtMaxChoice
			JMP +skipMenu
	+notInCommandMenu
+skipMenu
	RTS