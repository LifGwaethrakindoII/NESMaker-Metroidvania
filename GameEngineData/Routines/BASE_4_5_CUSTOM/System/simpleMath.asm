
	

	
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


valueSubLoop:
	;; temp holds the value to subtract.
	lda value,x
	sec 
	sbc temp
	cmp #$00
	bpl skipCarryDecValue2
	clc
	adc #$0A
	sta value,x
	inx
	cpx #$08 ;; how many 'places' the value has
	bcs underflowThisNumber
	lda #$01
	STA temp
	jmp valueSubLoop
skipCarryDecValue2:
	sta value,x
underflowThisNumber:
	rts