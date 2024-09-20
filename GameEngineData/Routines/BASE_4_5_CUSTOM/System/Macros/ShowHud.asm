MACRO ShowHud
	LDA gameHandler
	AND #%11011111
	STA gameHandler
	ENDM