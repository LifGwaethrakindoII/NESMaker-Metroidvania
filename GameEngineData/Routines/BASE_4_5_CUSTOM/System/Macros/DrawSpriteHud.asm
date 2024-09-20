MACRO DrawSpriteHud arg0, arg1, arg2, arg3, arg4, arg5, arg6
	; arg0 = starting position in pixels, x
	; arg1 = starting position in pixels, y
	; arg2 = sprite to draw, CONTAINER
	; arg3 = MAX	
	; arg4 = sprite to draw, FILLED
	; arg5 = variable.
	; arg6 = attribute
	
	tya
	PHA
	TXA
	PHA
	
	LDA arg5
	BEQ doneWithSpriteDrawElement ;; if the variable was zero, don't draw anything.
	
	LDA arg4
	STA temp ;; full
	LDA arg0
	STA temp2
	
	LDX #$00
	doDrawSpriteHudElementFullLoop:
		LDY spriteRamPointer
		LDA arg1
		STA SpriteRam,y
		INY
		LDA temp
		STA SpriteRam,y
		INY
		LDA arg6
		STA SpriteRam,y
		INY
		LDA temp2
		STA SpriteRam,y
		INY
	
		LDA spriteRamPointer
		CLC
		ADC #$04
		STA spriteRamPointer
		LDA temp2
		CLC
		ADC #$08
		STA temp2
		
		INX
		CPX arg3 ;; is it to the max?
		BEQ doneWithSpriteDrawElement
			CPX arg5 ;; has it reached the fill point?
			BEQ changeToContainerSprite
				JMP doDrawSpriteHudElementFullLoop
			changeToContainerSprite:
			
					;; not done with sprite draw element, but now need to change to container
					LDA arg2
					STA temp
					JMP doDrawSpriteHudElementFullLoop
			doneWithSpriteDrawElement:
		
		
		
		
	PLA
	TAX
	PLA
	TAY
	ENDM