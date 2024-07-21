;;; add menu item up
	LDA gameSubState
	BEQ +skipMenu
	CMP #$01
	BNE +notInCommandMenu
		;;; in command menu
		DEC currentCommandChoice
		LDA currentCommandChoice
		BPL +notAtMinChoice
			;; was at max choice so make choice zero.
			LDA #COMMAND_BOX_CHOICES
			SEC
			SBC #$01
			STA currentCommandChoice
		+notAtMinChoice
			JMP +skipMenu
	+notInCommandMenu
+skipMenu
	RTS