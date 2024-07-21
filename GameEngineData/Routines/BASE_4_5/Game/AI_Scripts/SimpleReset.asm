;;;; Simple reset, generally used for testing purposes.
	
	LDA #$00
	STA soft2001	
	JSR doWaitFrame
	JMP RESET