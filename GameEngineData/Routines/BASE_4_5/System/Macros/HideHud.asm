MACRO HideHud
	LDA gameHandler
	ORA #%00100000
	STA gameHandler
	ENDM