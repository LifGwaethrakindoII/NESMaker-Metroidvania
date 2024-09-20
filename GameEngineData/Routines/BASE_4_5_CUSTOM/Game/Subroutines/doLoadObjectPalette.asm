doLoadObjectPalettes:
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

	
		LDY #$00
		loop_LoadSpritePalette: 
			LDA (temp16),y
			STA sprPal,y
			INY
			CPY #$10
			BNE loop_LoadSpritePalette
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