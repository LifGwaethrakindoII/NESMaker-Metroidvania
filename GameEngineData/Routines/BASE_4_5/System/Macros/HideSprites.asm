MACRO HideSprites
	LDA gameHandler
	ORA #%01000000
	STA gameHandler
	ENDM