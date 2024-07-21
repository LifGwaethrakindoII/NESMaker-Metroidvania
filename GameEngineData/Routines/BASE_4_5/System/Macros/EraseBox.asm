MACRO EraseBox arg0, arg1, arg2, arg3
	TXA
	PHA
	TYA
	PHA
	; arg0 = X value, in metatiles
	; arg1 = y value, in metatiles
	; arg2 = width, in metatiles
	; arg3 = height, in metatiles
	;; this will push values into queue, and then turn on screen update.
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	LDA arg2
	STA arg2_hold
	LDA arg3
	STA arg3_hold
	;; This sets up "erase box", restoring a box area
	;;; using the same doDrawBox subroutine.
		LDA queueFlags 
		ORA #%10001100
		STA queueFlags
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		LDA #$00
		STA endDrawBoxAction
	
	JSR doDrawBox

	PLA
	TAY
	PLA
	TAX
	
	ENDM