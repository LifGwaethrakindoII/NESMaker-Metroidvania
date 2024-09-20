doLoadCollisionTable:
	;;; currently, arg0_hold has the bank data
	;;; arg1_hold has the screen index, if it is needed.
	;;; arg2_hold has screen bits.
		;;; bit 0 = overworld (0) underworld (1)
		;;; bit 1 = metaTable (0) 8x8 table (1)
		;arg0 = screen bank
	;arg3_hold = columns to load
	;arg4_hold = rows to load
	;arg5_hold = start row
	;arg6_hold = start column	
	;arg7_hold = which nametable.


	
	LDA arg6_hold
	TAX ;; starting collision table write
	LSR
	TAY ;; starting rom read.
	
	LDA arg3_hold
	STA tempB ; we will use tempB to hold the number of columns
			; so when we start a new row, we can return to the proper number of columns.
	;;; now we can use the (pointer) to know the PPU address to write the nametable.
	;;; whilte (temp16) denotes where the nametable data is being pulled from.
	SwitchBank arg0_hold
		loop_LoadCollisionTable:
			TxA
			AND #%00000001
			loop_LoadColTable_inner:
				BNE thisColTileIsOdd
					;; this col tile is even
						LDA (temp16),y
						LSR
						LSR
						LSR
						LSR
						STA tempC
						LDA arg7_hold
						BNE loadColToSecondCt_a
							LDA currentNametable
							AND #%00000001
							BNE loadColFlip2 ;; flip it
							loadColFlip:
								LDA tempC
								STA collisionTable,x
								JMP checkColColumnCount
						loadColToSecondCt_a:
							LDA currentNametable
							AND #%00000001
							BNE loadColFlip;; flip it
								loadColFlip2:
								LDA tempC
								STA collisionTable2,x
								JMP checkColColumnCount
		
				thisColTileIsOdd:
					;;; this col tile is odd
						LDA (temp16),y
						AND #%00001111
						STA tempC
						LDA arg7_hold
						BNE loadColToSecondCt_b
							LDA currentNametable
							AND #%00000001
							BNE loadColFlip3
							loadColFlip4:
								LDA tempC
								STA collisionTable,x
									INY ;; y is only going to increase after odd is checked
								JMP checkColColumnCount
						loadColToSecondCt_b:
							LDA currentNametable
							AND #%00000001
							BNE loadColFlip4
							loadColFlip3:
								LDA tempC
								STA collisionTable2,x
									INY
								JMP checkColColumnCount
						
							
					checkColColumnCount:
					
						INX
						DEC tempB
						LDA tempB
						BEQ doneWithColColumn
						
						JMP loop_LoadCollisionTable
				doneWithColColumn:
					LDA arg3_hold
					STA tempB ;; reset column counter.
				
					DEC arg4_hold
					LDA arg4_hold
					BEQ doneWithLoadingCOllisions
						;; now, the end of the column is reached.
						;; that means that subtracting the "columns to load"
						;; from x + 16 and columns to load/2 from y +8
						;; gives the new position for the new row.
						TxA
						SEC
						SBC arg3_hold
						CLC
						ADC #$10
						TAX 
						;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; end get x offset one row down.
						LDA arg3_hold
						LSR
						STA temp
						TYA
						SEC
						SBC temp
						CLC
						ADC #$08
						TAY
						;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; end get y offset one row down
						JMP loop_LoadCollisionTable

		doneWithLoadingCOllisions:
	
	ReturnBank
	RTS
	
	
	