;;; This routine will spread over two frames.
;; The offset for where in the column is being drawn will be held in scrollOffsetCounter.
;; It will load 32 (#$20) tiles per frame, but not quite, because the screen is only 
;; 240 px high.  So there are 3 reads per tile, 12 per metatile...12x15 rows = 180.

	LDY scrollOffsetCounter
	LDX #$10
loop_LoadScrollColumn:
	LDA scrollUpdateRam,y
	STA $2006
	STA $07FE
	INY
	
	LDA scrollUpdateRam,y
	STA $2006
	STA $07FF
	INY
	
	LDA scrollUpdateRam,y
	STA $2007
	INY 
	TYA
	STA scrollOffsetCounter
	CMP maxScrollOffsetCounter ;; this should probably be variable.
	BEQ doneUpdatingColumn
	
	DEX
	BNE loop_LoadScrollColumn
	JMP notDoneUpdatingColumn
doneUpdatingColumn:
	LDA updateScreenData
	AND #%11111011
	STA updateScreenData
	LDA scrollByte
	AND #%11111110
	STA scrollByte
	LDA #$00
	STA scrollOffsetCounter
notDoneUpdatingColumn:

	