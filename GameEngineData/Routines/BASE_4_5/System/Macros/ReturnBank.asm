MACRO ReturnBank
	TYA
	PHA
	LDY prevBank
	JSR doBankswitchY
	PLA
	TAY
	ENDM