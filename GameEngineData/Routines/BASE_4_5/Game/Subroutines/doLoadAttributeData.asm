doLoadAttributeData:

;;; attributes have 8 columns per screen and 7 1/2 rows per screen.
;;; 

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
	SwitchBank arg0_hold
		LDY arg7_hold ;;; in what column should the column begin?
		loop_LoadAttTable:
			LDA pointer+1
			STA $2006
			LDA pointer
			STA $2006
			LDA (temp16),y
			STA $2007
			
		doneDrawingThisAttributeTile:
			INY
			DEC tempB ;; is a surrogate for columns
			LDA tempB
			BEQ doneWithAttributeColumn
			
				LDA pointer
				CLC
				ADC #$01
				STA pointer
				JMP loop_LoadAttTable
			doneWithAttributeColumn:
				DEC arg4_hold
				LDA arg4_hold
				BEQ noMoreAttributeTilesToLoad	
				LDA arg3_hold
				STA tempB
				LDA pointer
				SEC
				SBC tempB
				CLC
				ADC #$08 ;; skip down to next attribute row.
				CLC
				ADC #$01
				STA pointer
				
				TYA
				SEC
				SBC tempB
				CLC
				ADC #$08
				TAY
				JMP loop_LoadAttTable
			noMoreAttributeTilesToLoad:
		ReturnBank
	RTS