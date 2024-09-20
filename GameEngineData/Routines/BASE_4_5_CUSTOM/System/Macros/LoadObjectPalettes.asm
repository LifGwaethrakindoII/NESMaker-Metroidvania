MACRO LoadObjectPalettes arg0
	;; arg0 = index of palette in bank 16
	LDA arg0
	STA arg0_hold
	JSR doLoadObjectPalettes
	ENDM