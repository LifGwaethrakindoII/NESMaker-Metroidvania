doDrawTilesDirect:
	; ;;; draw hud box
	; LDA #BOX_0_WIDTH
	; ASL
	; STA tempA
	; LDA #BOX_0_HEIGHT
	; ASL
	; STA tempB
	; LDA #BOX_0_ORIGIN_X ;; the x value, in metatiles, of the box draw.
	; ASL ;; multiplied by two, since metatiles are 16x16, but PPU addresses are 8x8.
	; CLC
	;ADC arg2_hold
	LDA arg2_hold
	STA temp
	; LDA #BOX_0_ORIGIN_Y ;; the y value, in metatiles, of the box draw.
	; ASL ;; multiplied by two, since metatiles are 16x16, but ppu addresses are 8x8.
	; CLC
	; ADC 
	LDA arg3_hold
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
	;;; draw text direct does not need to wait for frame updates.
	;;; it happens when the scren is turned off.
	SwitchBank textBank
		LDA #$00
		STA tempA ;; used for width.
		loop_drawTextDirect:
			LDY #$00
			LDA temp2
			STA $2006
			LDA temp3
			STA $2006
			LDA (textPointer),y
			CMP #$FF
			BEQ doneWithThisString
			CMP #$FE
			BEQ newLineForDrawTextDirect
			CLC
			ADC arg4_hold
			STA $2007
			
			LDA temp3
			CLC
			ADC #$01
			STA temp3
			LDA temp2
			ADC #$00
			STA temp2
			INC tempA
			LDA textPointer
			CLC
			ADC #$01
			STA textPointer
			LDA textPointer+1
			ADC #$00
			STA textPointer+1
			JMP loop_drawTextDirect
		newLineForDrawTextDirect:
			LDA temp3
			SEC
			SBC tempA
			CLC
			ADC #$20
			STA temp3
			LDA temp2
			ADC #$00
			STA temp2
			LDA #$00
			STA tempA
			LDA textPointer
			CLC
			ADC #$01
			STA textPointer
			LDA textPointer+1
			ADC #$00
			STA textPointer+1
			
			JMP loop_drawTextDirect
		doneWithThisString:	
	ReturnBank
	
	RTS