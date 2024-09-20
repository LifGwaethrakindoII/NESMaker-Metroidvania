MACRO DrawSprite arg0, arg1, arg2, arg3
	;arg0 = x
	;arg1 = y
	;arg2 = chr table value
	;arg3 = attribute data
	TYA
	PHA
	
	LDY spriteRamPointer
	
	LDA arg1
	STA SpriteRam,y
	INY
	LDA arg2
	STA SpriteRam,y
	INY
	LDA arg3
	STA SpriteRam,y
	INY
	LDA arg0
	STA SpriteRam,y
	INY

	LDA spriteRamPointer
	CLC
	ADC #$04
	STA spriteRamPointer
	PLA
	TAY
	ENDM