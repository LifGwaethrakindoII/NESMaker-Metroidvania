doLoadNametableDataFull:
	TXA
	PHA
	TYA
	PHA

	SwitchBank arg0_hold
	
	LDA arg3_hold
	STA $2006
	LDA #$00
	STA $2006

	LDX #$04
	LDY #$00
LoadNametableLoop:

	LDA (temp16),y
	STA $2007
	INY
	BNE LoadNametableLoop
	INC temp16+1
	DEX
	BNE LoadNametableLoop	
	
	PLA
	TAY
	PLA
	TAX
	
	ReturnBank

	RTS