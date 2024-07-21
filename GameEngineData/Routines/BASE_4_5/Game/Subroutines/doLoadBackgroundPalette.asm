doLoadBackgroundPalettes:
	;; This is tied to the macro LoadBackgroundPalettes.
	;; It uses bank and 16 bit label.
	TXA
	PHA
	TYA
	PHA
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Get Palette Label based on INDEX
	SwitchBank #$16
		LDY arg0_hold
		LDA GameBckPalLo,y
		STA temp16
		LDA GameBckPalHi,y
		STA temp16+1

	
		LDY #$00
		loop_LoadBackgroundPalette: 
			LDA (temp16),y
			STA bckPal,y
			INY
			CPY #$10
			BNE loop_LoadBackgroundPalette
		;;;; end of loop.
		LDA updateScreenData
		ORA #%00000001 ;; palette
		STA updateScreenData
	
	
	ReturnBank
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	PLA
	TAY
	PLA
	TAX
	RTS