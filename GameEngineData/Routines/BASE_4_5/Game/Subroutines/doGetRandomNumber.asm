doGetRandomNumber:
	LDA randomSeed1
	ASL A
	ASL A
	CLC
	ADC temp2
	SEC
	SBC tempx
	ADC #$11
	SBC gamepad
	ADC #$36
	ADC tileY
	SBC temp16
	ADC pointer
	ADC tempA
	STA randomSeed1
	ADC #$03
	SBC vBlankTimer
	SBC vBlankTimer
	RTS