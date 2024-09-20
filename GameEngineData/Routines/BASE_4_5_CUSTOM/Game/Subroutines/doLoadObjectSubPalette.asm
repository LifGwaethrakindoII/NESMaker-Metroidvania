doLoadObjectSubPalettes:
	;; This is tied to the macro LoadObjectPalettes.
	;; It uses bank and 16 bit label.
	TXA
	PHA
	TYA
	PHA
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Get Palette Label based on INDEX
	SwitchBank #$16
		LDY arg0_hold
		LDA ObjectPaletteDataLo,y
		STA temp16
		LDA ObjectPaletteDataHi,y
		STA temp16+1

		LDX arg1_hold
		LDY #$00
		loop_LoadSpriteSubPalette: 
			LDA (temp16),y
			STA sprPal,x
			INY
			INx
			CPY #$04
			BNE loop_LoadSpriteSubPalette
		;;;; end of loop.
		LDA updateScreenData
		ORA #%00000010 ;; sprite palette
		STA updateScreenData
	
	
	ReturnBank
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	PLA
	TAY
	PLA
	TAX
	RTS