MACRO DrawNumber arg0, arg1, arg2, arg3
	;; arg0 =x
	;; arg1 =y
	;; arg2 =root variable
	;; arg3 = places
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	LDA #<arg2
	STA pointer
	LDA #>arg2
	STA pointer+1
	LDA arg3
	STA arg3_hold
	
	LDA hudUpdates
	BNE drawNumbersHappeningDuringScreenRender
	
		JSR doDrawNumbers
		JMP doneDrawNumbers
	drawNumbersHappeningDuringScreenRender
		JSR doDrawNumbers_update
	doneDrawNumbers:

	ENDM