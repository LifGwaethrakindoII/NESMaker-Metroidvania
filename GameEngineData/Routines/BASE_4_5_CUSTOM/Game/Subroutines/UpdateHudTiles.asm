MACRO UpdateHudTiles arg0, arg1, arg2, arg3, arg4
	;; this macro is similar to the DrawTilesDirect macro, however
	;; it draws when the screen is turned on.
	;; bank
	;; label
	;; x
	;; y 
	;; offset
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	LDA arg2
	STA arg2_hold
	LDA arg3
	STA arg3_hold
	LDA arg4
	STA arg4_hold
	
	JSR doUpdateHudTiles
	
	
	ENDM