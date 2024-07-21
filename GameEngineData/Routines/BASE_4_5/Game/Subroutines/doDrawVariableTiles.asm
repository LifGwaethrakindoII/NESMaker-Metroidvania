doDrawVariableTiles:
	LDA arg0_hold
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
			
		
	LDX #$00;arg2_hold ; this is the FULL length of the tile thing.
	
	LDA arg5_hold ;; the tile to draw
	STA temp
	
	loop_doDrawVar
		LDA arg4_hold
		BEQ changeToEmpty ;; if it's zero, change to empty.
		CPX arg4_hold
		BCC dontChangeToEmpty
		changeToEmpty
			LDA arg3_hold
			STA temp
		dontChangeToEmpty
		
		LDA temp2
		STA $2006
		LDA temp3
		STA $2006
		LDA temp
			CLC
			ADC #HUD_OFFSET
		STA $2007
		INC temp3
		INX
		CPX arg2_hold
		BEQ done_loop_doDrawVar
		
		JMP loop_doDrawVar
	done_loop_doDrawVar:
	
	RTS
	
	
doDrawVariableTiles_update:
	LDA arg0_hold
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
			
		
	LDX #$00;arg2_hold ; this is the FULL length of the tile thing.
	LDY #$00
	LDA arg5_hold ;; the tile to draw
	STA temp
	
	LDA #$00
	STA scrollOffsetCounter
	
	loop_doDrawVar_update:
		LDA arg4_hold
		BEQ changeToEmpty_update ;; if it's zero, change to empty.
		CPX arg4_hold
		BCC dontChangeToEmpty_update
		changeToEmpty_update
			LDA arg3_hold
			STA temp
		dontChangeToEmpty_update
		
		LDA temp2
		STA scrollUpdateRam,y
		INy
		LDA temp3
		STA scrollUpdateRam,y
		INy
		LDA temp
			CLC
			ADC #HUD_OFFSET
		STA scrollUpdateRam,y
		INY
		INC temp3
		INX
		CPX arg2_hold
		BEQ done_loop_doDrawVar_update
		
		JMP loop_doDrawVar_update
	done_loop_doDrawVar_update:
		TYA
		STA maxScrollOffsetCounter
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Turn on update screen on next frame.
			LDA updateScreenData
			ORA #%0000100
			STA updateScreenData
	RTS