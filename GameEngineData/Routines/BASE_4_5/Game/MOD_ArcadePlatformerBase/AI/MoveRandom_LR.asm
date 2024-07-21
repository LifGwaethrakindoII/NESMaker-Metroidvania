;;;; Choose out LR
	TXA	
	STA tempA
	JSR doGetRandomNumber
	AND #%00000001
	BNE +moveRight
		;; move left
		LDA #%00000110
		JMP +gotDir
	+moveRight
		LDA #%00000010
	+gotDir
	TAY
	LDA DirectionTableOrdered,y
	STA tempB
	LDA FacingTableOrdered,y
	STA tempC
	StartMoving tempA, tempB, #$00
	ChangeFacingDirection tempA, tempC

