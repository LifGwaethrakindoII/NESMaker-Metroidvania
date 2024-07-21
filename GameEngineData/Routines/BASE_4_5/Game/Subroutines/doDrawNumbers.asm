doDrawNumbers:
	LDA arg0_hold
	CLC
	ADC arg3_hold
	SEC
	SBC #$01
	STA temp

	; LDA #BOX_0_ORIGIN_Y ;; the y value, in metatiles, of the box draw.
	; ASL ;; multiplied by two, since metatiles are 16x16, but ppu addresses are 8x8.
	; CLC
	; ADC 
	LDA arg1_hold
	STA temp1
		ASL
		ASL
		ASL
		ASL
		ASL
		CLC 
		ADC temp
		STA temp3 ;; low byte.

		
	LDA temp1
		LSR
		LSR
		LSR
		CLC
		ADC camFocus_tiles
		STA temp2 ;; high byte
		LDY #$00
	doDrawNumbersLoop:
		LDA temp2
		STA $2006
		LDA temp3
		STA $2006
		LDA (pointer),y
		CLC
		ADC #$d0 ;; number start
		STA $2007
		INY 
		DEC temp3
		DEC arg3_hold
		LDA arg3_hold
		BNE doDrawNumbersLoop
	
	RTS
	
	
doDrawNumbers_update:

	LDA #$00
	STA scrollOffsetCounter
	
	LDA arg0_hold
	CLC
	ADC arg3_hold
	SEC
	SBC #$01
	STA temp

	; LDA #BOX_0_ORIGIN_Y ;; the y value, in metatiles, of the box draw.
	; ASL ;; multiplied by two, since metatiles are 16x16, but ppu addresses are 8x8.
	; CLC
	; ADC 
	LDA arg1_hold
	STA temp1
		ASL
		ASL
		ASL
		ASL
		ASL
		CLC 
		ADC temp
		STA temp3 ;; low byte.

		
	LDA temp1
		LSR
		LSR
		LSR
		CLC
		ADC camFocus_tiles
		STA temp2 ;; high byte
		LDX #$00
		LDY #$00
	doDrawNumbersLoop_update:
		LDA temp2
		STA scrollUpdateRam,x
		INX
		LDA temp3
		STA scrollUpdateRam,x
		INX
		LDA (pointer),y
		CLC
		ADC #$d0 ;; number start
		STA scrollUpdateRam,x
		INX
		INY 
		DEC temp3
		DEC arg3_hold
		LDA arg3_hold
		BNE doDrawNumbersLoop_update
		TXA
		STA maxScrollOffsetCounter
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Turn on update screen on next frame.
			LDA updateScreenData
			ORA #%0000100
			STA updateScreenData
	
	RTS
	
	
	
