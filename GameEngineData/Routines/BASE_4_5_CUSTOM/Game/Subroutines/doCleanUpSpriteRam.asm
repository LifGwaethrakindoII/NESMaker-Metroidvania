;; do clean up sprite ram
doCleanUpSpriteRam:
	LDY spriteRamPointer
	clearSpriteRamLoop:
		LDA #$FE
		STA SpriteRam,y
		INY
		INY
		INY
		INY
		BNE clearSpriteRamLoop
	RTS