doAddValue:

	TXA
	PHA
	;arg0 = how many places this value has.
	;arg1 = home variable
	;arg2 = amount to add 
	;arg3 = to what place?
	LDX arg0_hold
	--:
		LDA arg1_hold,x ;; the variable that you want to push
		STA value,x
		dex
		BPL --
	LDX arg3_hold ; sets the place to push.  
	LDA arg2_hold
	JSR valueAddLoop ;value_add1 ;; will add what is in accumulator.
	;;; now value nees to be unpacked back into the variable.
	

		LDX arg0_hold
	-:
		LDA value,x ;; the variable that you want to push
		STA arg1_hold,x
		dex
		BPL -
	PLA
	TAX
	RTS
	
	
valueAddLoop:
	;; the accumulator holds how much to add by.
	;; x holds what place is being added to.
	clc
	adc value,x
	cmp #$0A
	bcc skipCarryDecValue
	sec
	sbc #$0A
	sta value,x
	inx
	cpx #$08 ;; how many 'places' the value has
	bcs overflowThisNumber
	lda #$01
	jmp valueAddLoop
skipCarryDecValue:
	sta value,x
overflowThisNumber:
	rts
