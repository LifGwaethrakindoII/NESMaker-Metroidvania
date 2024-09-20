MACRO ShowSprites
	LDA gameHandler
	AND #%10111111
	STA gameHandler
	ENDM