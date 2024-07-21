MACRO QueueText arg0, arg1, arg2, arg3, arg4
	TYA
	PHA
	TXA
	PHA
	;; arg0 bank.
	;; arg1 label
	;; x 
	;; y
	;; width (columns) in tiles
	;; height (rows) intiles
	;; arg 4 is complicated.  If arg 4 is a 0, it uses the label that is written in arg 1.
							;; if arg 4 is a non zero number, it uses a look up table in bank 16.
	LDA arg0
	STA arg0_hold
		LDA endDrawBoxAction ;; also serves as text mode.
		;#TEXT_FREE = 0, = free mode
		;#TEXT_NPC = 4, = pulls from an NPC.
		CMP #TEXT_FREE
		BEQ skipSettingTextBank
			LDA arg0
			STA textBank ;; allows for it to flow over frames.
		skipSettingTextBank:
	LDA arg1
	STA arg1_hold
	LDA arg2
	STA arg2_hold
	LDA arg3
	STA arg3_hold

	LDA endDrawBoxAction ;; also serves as text mode.
		;#TEXT_FREE = 0, = free mode
		;#TEXT_NPC = 4, = pulls from an NPC.
	CMP #TEXT_FREE
	BEQ lookUpStringDirect
		LDA textQueued
		AND #%00000001
		BNE skipSettingNewPointer2 ;; if there is "more text" in queue, we will skip resetting the pointer.
			;LDA arg1
			;STA textToWrite
			;; here, we need to look up string based on bank 16 table reads.
			SwitchBank #$16
				LDY textToWrite
				LDA TextStrings00_Lo,y
				STA textPointer
				LDA TextStrings00_Hi,y
				STA textPointer+1
			ReturnBank
		skipSettingNewPointer2:
		JMP TextIsQueued
	;;	
	lookUpStringDirect:
	SwitchBank arg0
		LDA textQueued
		AND #%00000001
		BNE skipSettingNewPointer ;; if there is "more text" in queue, we will skip resetting the pointer.
			  ;LDA #<arg1
			  ;STA textPointer
			  ;;LDA #>arg1
			  ;STA textPointer+1
		skipSettingNewPointer:
	ReturnBank
TextIsQueued:
	LDA textQueued
	AND #%11111110
	STA textQueued
		LDA arg2_hold ;; the x value, in metatiles, of the box draw.
		ASL ;; multiplied by two, since metatiles are 16x16, but PPU addresses are 8x8.
		STA temp
		LDA arg3_hold ;; the y value, in metatiles, of the box draw.
		ASL ;; multiplied by two, since metatiles are 16x16, but ppu addresses are 8x8.
		STA temp1
			ASL
			ASL
			ASL
			ASL
			ASL
			CLC 
			ADC temp
			STA textOffset_lo

			
		LDA temp1
			LSR
			LSR
			LSR
			CLC
			ADC camFocus_tiles
			STA textOffset_hi
		
		
		LDA #$01
		STA textHandler ;; so that on the next frame, it skips the set up.
		LDA #$00
		STA counter
	PLA
	TAX
	PLA
	TAY

	ENDM