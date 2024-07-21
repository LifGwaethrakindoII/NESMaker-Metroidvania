MACRO LoadObjectSubPalettes arg0, arg1
	;; arg0 = index of palette in bank 16
	;; arg1 = starting point of sub palette, 0,4,8,12
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	JSR doLoadObjectSubPalettes
	ENDM