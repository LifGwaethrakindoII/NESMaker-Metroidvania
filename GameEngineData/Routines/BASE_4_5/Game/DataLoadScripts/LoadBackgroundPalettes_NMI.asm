;;Load background palettes
	
	LDA $2002
	LDA #$3F
	STA $2006
	LDA #$00
	STA $2006
	LDX #$00
LoadBackgroundPal_NMI:
	LDA bckPal,x
	STA $2007
	INX
	CPX #$10
	BNE LoadBackgroundPal_NMI
	
	LDA updateScreenData
	AND #%11111110
	STA updateScreenData
	
	;;; this script runs in-line.