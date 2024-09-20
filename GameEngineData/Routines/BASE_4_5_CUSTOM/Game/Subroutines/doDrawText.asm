doDrawText:
	TXA
	PHA
	TYA
	PHA

	LDA textHandler
	BNE alreadyDrawingText
		;; setting up text.
		
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
		STA textHandler
		LDA #$00
		STA counter
		
alreadyDrawingText:
	LDA #$00
	STA scrollOffsetCounter
	SwitchBank textBank
		LDY #$00
		LDA textOffset_hi
		STA scrollUpdateRam,y
		INY
		LDA textOffset_lo
		STA scrollUpdateRam,y
		INY
		TYA
		PHA
			LDY #$00
			LDA (textPointer),y
			STA temp
		PLA
		TAY
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HERE, we will check for "end string" values.
;; These are set up by default from the GUI.
;; Mostly, they add a value from HUD_CONSANTS.dat
;; that act as an opcode rather than a string value.
;; Since there are 256 values, there are many at the end that
;; will never be used.  

;; These are the ones that are default:
;_BREAK = $FE
;_END = $FF
;_MORE = $FD
;_ENDWIN = $FA
;_ENDITEM = $FB
;_ENDSHOP = $FC
;_ENDTRIGGER = $F9

;;FOR MANUAL USE:
;; Drawing from a library of values based on a numeric offset can be invoked by using F8.
		LDA temp
		CMP #$F8
		BNE +notDrawingFromLibrary
			TYA
			PHA
			;;; the library can have 256 values.
			;;; conceivably, you could make multiple libraries, and assignem them to different end of text reads.
			;;; So here is what this does.
			;;; 1) Reads an #$F8, so it knows to read from the library.
			;;; 2) Increases position.  Gets the low value of var address to read
			;;; 3) Increases position.  Gets the high value of var address to read.  Puts the result of var into Y.
			;;; 3) Increases position and SAVES that program counter position.
			;;; 4) Reads the y offest of library table.  That position becomes the new textPointer location.
			;;; 5) Writes as normal from that position.
			;;; 6) If it reads #$F7, it turns off library draw (so every library read should end in #$F7.
			;;; 7) Saved program counter position gets restored to textPointer, and draw text continues on
			;;;    as normal.
			LDA textPointer
			CLC
			ADC #$01
			STA textPointer
			LDA textPointer+1
			ADC #$00
			STA textPointer+1
			LDY #$00
			LDA (textPointer),y
			STA pointer
			
			LDA textPointer
			CLC
			ADC #$01
			STA textPointer
			LDA textPointer+1
			ADC #$00
			STA textPointer+1
			LDY #$00
			LDA (textPointer),y
			STA pointer+1
			
			LDY #$00
			LDA (pointer),y
			TAY ;; tempA now represents the offset value from the Library pointer table.
			
			;; store next offset position for a return point.
			LDA textPointer
			CLC
			ADC #$01
			STA textPosHold 
			LDA textPointer+1
			ADC #$00
			STA textPosHold+1
			
			;; get the library table value
			LDA TextLibrary_lo,y
			STA textPointer
			LDA TextLibrary_hi,y
			STA textPointer+1
			PLA
			TAY
			JMP +continueRoutine;doneWithText
			
	
	+notDrawingFromLibrary:
		CMP #$F7
		BNE +notRestoringFromLibrary
			TYA
			PHA
			;; restorying from library.
			LDA textPosHold
			STA textPointer
			LDA textPosHold+1
			STA textPointer+1
			LDY #$00
			LDA (textPointer),y
			STA temp ;; flow into the rest of the text routine.
			PLA 
			TAY
			JMP +continueRoutine
	+notRestoringFromLibrary
		;;; a value of F6 is an opcode that lets the game know to draw the value of a variable in a given position
		;;; within a manual string.
		;;; 1) First, we see it is an F6 opcode.
		;;; 2) The next two bytes are the address of the variable that we want to read.
		;;; 3) It pushes that to y as an offset to NumberBaseTable, and then continues on to the routine.
		CMP #$F6
		BNE +notDrawingVariableNumber
			TYA
			PHA
			LDA textPointer
			CLC
			ADC #$01
			STA textPointer
			LDA textPointer+1
			ADC #$00
			STA textPointer+1
			LDY #$00
			LDA (textPointer),y
			STA pointer
			
			LDA textPointer
			CLC
			ADC #$01
			STA textPointer
			LDA textPointer+1
			ADC #$00
			STA textPointer+1
			LDY #$00
			LDA (textPointer),y
			STA pointer+1
			
			LDY #$00
			LDA (pointer),y
			TAY
	
			LDA #<NumberBaseTable
			STA pointer
			LDA #>NumberBaseTable
			STA pointer+1
			LDA (pointer),y
			STA temp
			PLA
			TAY
			JMP +continueRoutine
		
	+notDrawingVariableNumber
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
+continueRoutine		
		LDA temp
		CMP #$FF
		BNE notEndOfText
		endOfText:
			;; end of text
			LDA #$00
			STA textHandler
			;;;;;;;;; cue turn off.
			LDA textQueued
			ORA #%00000010
			STA textQueued ;; this will push a *turn off* notification.
			
			LDA gameStatusByte
			AND #%11111101
			STA gameStatusByte
				
			JMP doneWithText
		notEndOfText:
		CMP #$FE
		BNE notNewLineOfText
		
			;; new line of text
			;;;;;;;;;;;;;;;;;;;;;;;;;
			;; return to the leftmost side of the text string
			;; by subtracting "counter"
			;; then add #$20 (32), which jumps it to the next line.
			
			LDA textOffset_lo
			SEC
			SBC counter
			CLC
			ADC #$20
			STA textOffset_lo
			LDA textOffset_hi
			ADC #$00
			STA textOffset_hi
			
			;; start 'counter' over again for the length of the current line
			LDA #$00
			STA counter
			
			;; increase the position of the text pointer to get the next offset
			;; value in the string.
			LDA textPointer
			CLC
			ADC #$01
			STA textPointer
			LDA textPointer+1
			ADC #$00
			STA textPointer+1
	
			JMP doneWithText
		notNewLineOfText:	
		CMP #_ENDTRIGGER
		BNE notEndTrigger
			LDA textPointer
			CLC
			ADC #$01
			STA textPointer
			LDA textPointer+1
			ADC #$00
			STA textPointer+1
			;;; NOW, get the modifier 
			TYA
			PHA
				LDY #$00
				LDA (textPointer),y
				;;; accumulators now contains the trigger type
				STA temp
				TriggerScreen temp
			PLA
			TAY
			LDA #$00
			STA textHandler
			JMP endOfText
		notEndTrigger:
		CMP #_MORE
		BNE notMoreText
			;; There is more text.
			;; so first, we need to clear the text field.
			;; We will set up a queue for drawing a new black box and then more text.
			LDA textQueued
			ORA #%00000001
			STA textQueued
			;;; now, increase the text value so that it will read from the very next value
			;;; when a new box is created.
			
			LDA textOffset_lo
			CLC
			ADC #$02
			STA textOffset_lo
			LDA textOffset_hi
			ADC #$00
			STA textOffset_hi
			
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;; Also, add a "MORE" indicator after finished text.
		;;;
			LDA textPointer
			CLC
			ADC #$01
			STA textPointer
			LDA textPointer+1
			ADC #$00
			STA textPointer+1
			LDA #$00
			STA textHandler
			
			LDA #TEXT_MORE_INDICATOR
			STA temp
			
			LDA temp
			CLC
			ADC #HUD_OFFSET
			STA scrollUpdateRam,y
			INY
			TYA 
			STA maxScrollOffsetCounter
			
			inc counter ;; we will use counter for "length" of the current line.
			
			
			LDA gameStatusByte
			AND #%11111101
			STA gameStatusByte
			JMP JustUpdateNewCharacter
			
	
		notMoreText:
		CMP #_ENDITEM
		BNE notEndItem
			;; is end item.
			LDA textPointer
			CLC
			ADC #$01
			STA textPointer
			LDA textPointer+1
			ADC #$00
			STA textPointer+1
			LDY #$00
			LDA (textPointer),y
			;; now A holds the "item to get".
			TAY
			LDA ValToBitTable_inverse,y
			ORA weaponsUnlocked
			STA weaponsUnlocked
			TriggerScreen currentNametable
			JMP endOfText
		notEndItem:
	
		
		
		updateNormalTextCharacter:
		LDA temp
		CLC
		ADC #HUD_OFFSET
		STA scrollUpdateRam,y
		INY
		TYA 
		STA maxScrollOffsetCounter
		
		inc counter ;; we will use counter for "length" of the current line.
		
		LDA textOffset_lo
		CLC
		ADC #$01
		STA textOffset_lo
		LDA textOffset_hi
		ADC #$00
		STA textOffset_hi
		
		LDA textPointer
		CLC
		ADC #$01
		STA textPointer
		LDA textPointer+1
		ADC #$00
		STA textPointer+1
	JustUpdateNewCharacter:
		LDA updateScreenData
		ORA #%00000100
		STA updateScreenData
doneWithText:	
	ReturnBank
	PLA
	TAY
	PLA
	TAX
	RTS