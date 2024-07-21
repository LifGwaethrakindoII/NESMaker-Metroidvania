doLoadNametableData:
	;;; currently, arg0_hold has the bank data
	;;; arg1_hold has the screen index, if it is needed.
	;;; arg2_hold has screen bits.
		;;; bit 0 = overworld (0) underworld (1)
		;;; bit 1 = metaTable (0) 8x8 table (1)
		;arg0 = screen bank
	;arg3_hold = columns to load
	;arg4_hold = rows to load
	;arg5_hold = start position hi
	;arg6_hold = start position lo
	;arg7_hold = start column	
	
	;;; decreasing arg3_holder / arg4_holder will track if there are more columns/rows to load.  If zero, that part is done.
	LDA arg6_hold
	STA pointer
	LDA arg5_hold
	STA pointer+1
	
	LDA arg3_hold
	STA tempB ; we will use tempB to hold the number of columns
			; so when we start a new row, we can return to the proper number of columns.
	;;; now we can use the (pointer) to know the PPU address to write the nametable.
	;;; whilte (temp16) denotes where the nametable data is being pulled from.

	SwitchBank arg0_hold;temp

		LDY arg7_hold ;;; in what column should the nametable begin?
		loop_LoadNametableMeta:
			LDA pointer+1
			STA $2006
			LDA pointer
			STA $2006
			LDA (temp16),y
			STA temp
				;;; now we have to do an evaluation, to compare this to potential "blank" values and paths.
			JSR doGetSingleMetaTileValues
			JSR doDrawSingleMetatile
		doneDrawingThisMetatile:
			INY
			DEC tempB ;; is a surrogate for columns
			LDA tempB
			BEQ doneWithMetaTileColumn
				LDA pointer
				CLC
				ADC #$02
				STA pointer
				JMP loop_LoadNametableMeta	
			doneWithMetaTileColumn:
				DEC arg4_hold
				LDA arg4_hold
				BEQ noMoreMetaTilesToLoad	
					CMP #$08
					BNE +dontWaitFrame
						JSR doWaitFrame
					+dontWaitFrame
					LDA arg3_hold
					STA tempB ;; resets the amount of columns.
					;;;;; calculate based on the number of columns drawn
					;;;;; where the "beginning of the column" should be,
					;;;;; and skip down to the next free line.
					ASL
					STA tempC ;
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					LDA pointer
					CLC
					ADC #$02
					SEC
					SBC tempC
					clc
					adc #$40
					STA pointer
					LDA pointer+1
					ADC #$00
					STA pointer+1
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;;; now, calculate where y should read from
					;;; based on the number of columns being drawn.
					TYA
					CLC
					ADC #$10
					SEC
					SBC arg3_hold
					TAY
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					JMP loop_LoadNametableMeta
									
					
		noMoreMetaTilesToLoad:
	
	ReturnBank
	RTS
	
	
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

doGetSingleMetaTileValues:
	STA temp
	
	LDA screenLoadTemps
	AND #%10000000
	BNE notPath
	LDA temp
;	CMP #BLANK_TILE ;; solid BLACK translate.
	CMP #$f5
	BEQ isBlankTile
	CMP #$FD
	BEQ isBlankTile ;isFDtile ;; solid "RED" translate
	CMP #$FE
	BEQ isBlankTile ;isFEtile ;; solid "GREEN" translate
	CMP #$FF
	BEQ isBlankTile ;isFFtile ;; solid "BLACK" translate
	JMP notBlankTile
isBlankTile:
	;;; it was a blank tile.  They are all now blank tiles
	STA updateTile_00
	STA updateTile_01
	STA updateTile_02
	STA updateTile_03
	RTS
	
notBlankTile:

	;;;; check for screen modes.
	LDA tileLayout
	CMP #%01000000
	BEQ checkForPathUpdates
	CMP #%01100000
	BEQ checkForPathUpdates1
	;;;; THIS DOES NOT USE PATHS!!!
	;;;; so just restore the temp value and proceed with metaTiles as if it wasn't a path value.
	LDA temp
	JMP notPath
	RTS
	
checkForPathUpdates1:
;;;;; THIS MODE USES ONLY THE FIRST TWO "paths" AS PATHS.
	LDA temp
	CMP #$A0
	BEQ doPathUpdate
	CMP #$B0
	BEQ doPathUpdate
	JMP notPath
	
checkForPathUpdates:
;;;;;; THIS MODE USES ALL FOUR "paths" AS PATHS.
	
	LDA temp
	CMP #$80
	BEQ doPathUpdate 
	CMP #$90
	BEQ doPathUpdate
	CMP #$A0
	BEQ doPathUpdate
	CMP #$B0
	BEQ doPathUpdate
	JMP notPath
	
doPathUpdate:
	
	;; now we have to do evaluations of other tiles around us to know
	;; exactly what to draw here.
	JSR handlePath
	RTS
notPath:
	
	STA updateTile_00
	INC temp
	LDA temp
	STA updateTile_01
	;;; now, what we need is a row down from our current position...updateNT_pointer
	;;; and temp, increased to its next row.
	CLC
	ADC #$0f
	STA temp
	STA updateTile_02
	INC temp
	LDA temp
	STA updateTile_03
	RTS
	
doDrawSingleMetatile:
	LDA pointer+1
	STA $2006
	LDA pointer
	STA $2006

	LDA updateTile_00
	STA $2007  ;write 1
	LDA updateTile_01
	STA $2007 ;; write 2

	;;; now, what we need is a row down from our current position...pointer
	;;; and temp, increased to its next row.
	LDA pointer+1
	STA $2006
	
	LDA pointer
	CLC
	ADC #$20 ;; dont store it into pointer
			;; because then it will be easy to just add 2 to
			;; for the next place to write.
	STA $2006

	;; now get the tile
	LDA updateTile_02
	STA $2007 ; write 3
	LDA updateTile_03
	STA $2007 ; write 4
	RTS
	
	
	
	
	
	
	
	
	
	
	
	
	
	
handlePath:
	TXA
	PHA
	TYA
	PHA

	.include SCR_HANDLE_PATHS

	
	PLA
	TAY
	PLA
	TAX
	
	RTS
	