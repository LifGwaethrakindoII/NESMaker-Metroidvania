MACRO Compare16 arg0, arg1, arg2, arg3
	; arg0 = high byte of first value
	; arg1 = low byte of first value
	; arg2 = high byte of second value
	; arg3 = low byte of second value

	;; if value first < value second, jump to ++
	;; otherwise, jump to +
	LDA arg0
	CMP arg2
	BNE +noEqu
		LDA arg1
		CMP arg3
		BNE +noEqu
			
			JMP +++
	+noEqu
	
	LDA arg0
	CMP arg2
	BCC ++
	BNE +
	LDA arg1
	CMP arg3
	BCC ++
	;;; otherwise, flow to label 1
	JMP +
+++
	;;; if it flows right out of the compare, it is =.
	ENDM