
MACRO GetTrigger
		;; corrupts tempA and tempB
		;; tempB becomes zero or non-0, depending on if a screen was triggered.

	TXA
	PHA
	TYA
	PHA

	lda screenType ;; this is the value of the screen to change.
		AND #%00000111 ;; look at last bits to know what bit to check, 0-7
		TAX
		LDA ValToBitTable_inverse,x
		STA tempA
	lda screenType
		LSR
		LSR
		LSR 
		;;; now we have the right *byte* out of the 32 needed for 256 screen bytes
		TAY
		LDA screenTriggers,y ;; now the rigth bit is loaded into the accum
		AND tempA
		STA tempB
	
	PLA 
	TAY	
	PLA 
	TAX
	LDA tempB
	ENDM