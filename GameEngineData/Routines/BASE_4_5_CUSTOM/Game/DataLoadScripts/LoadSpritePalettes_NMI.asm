;;Load background palettes
	
	LDA $2002
	LDA #$3F
	STA $2006
	LDA #$10
	STA $2006
	LDX #$00
LoadSpritePal_NMI:
	LDA sprPal,x
	STA $2007
	INX
	CPX #$10
	BNE LoadSpritePal_NMI
	
	LDA updateScreenData
	AND #%11111101
	STA updateScreenData
	
	;;; this script runs in-line.