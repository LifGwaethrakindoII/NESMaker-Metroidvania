MACRO SwitchBank arg0
	;; arg0 = what bank to switch to
	TYA
	PHA
	LDA currentBank
	STA prevBank
	LDY arg0
	JSR doBankswitchY
	PLA
	TAY
	ENDM