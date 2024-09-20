MACRO CountObjects arg0
	;; arg0 - what flag bits are we talking about (what type of objects are we counting?)
	LDA arg0
	STA tempA
	TXA
	PHA
	TYA
	PHA
		
		LDA #$00
		STA temp
		LDX #$00
		countObjectLoop:
			LDA Object_status,x
			AND #%10000000
			BEQ +skipCountingThisObject
				LDA Object_flags,x
				AND tempA
				BEQ +skipCountingThisObject
					INC temp
			+skipCountingThisObject
				INX
				CPX #TOTAL_MAX_OBJECTS
				BNE countObjectLoop
			
	
	PLA
	TAY
	PLA
	TAX
	LDA temp ;; now the accumulator holds the number of that type of object still activated.
	ENDM