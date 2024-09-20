doLoadScrollRow:

	LDA scrollByte
	AND #%10000000
	BEQ notFactoringVScroll
	RTS
notFactoringVScroll:
	LDA updateScreenData
	AND #%00000100 
	BEQ checkIfColumnIsUpdating
	;;; this column is in the middle of being updated
	;; so skip the update.
	RTS
checkIfColumnIsUpdating:
	LDA scrollByte
	AND #%01000000
	BEQ doUpdateRow
		;; column was updating.
		RTS 



doUpdateRow:
	
	LDA scrollByte
	ORA #%10100000
	;;      + vertical scrolling is happening.
	;;			reset at the end up tile load update.
	STA scrollByte
	;;; what nametable are we starting in, left or right?
	LDA camX_hi
	AND #%00000001
	BNE camInSecondNt
	;; cam in second nt
		LDA #$20
		STA updateNametable
		LDA #$23
		STA updateAttributeTable
		JMP gotStartingCamNT
	camInSecondNt:
		LDA #$24
		STA updateNametable
		LDA #$27
		STA updateAttributeTable
	gotStartingCamNT

;;; get screen to update based on scroll direction.
	LDA scrollByte
	AND #%00000010
	BNE getDownNametableForRowLoad
		;; get up nametable for row load.
		LDA camY_hi
		JMP gotNametableForRowLoad
	getDownNametableForRowLoad:
		LDA camY_hi
		CLC
		ADC #$01
	gotNametableForRowLoad
		STA temp ;; this is now the nametable for the row load.
	;;;; we will load column by column at the seam
	;;;; but when updating a row, we will load an entire row.
	;;;; to both nametables / attribute tables.  This is slower
	;;;; but will make four way scrolling work the most logically.
	;;;; It won't matter which nametable we are in or what column we
	;;;; are scrolled to.  We'll just blast the whole two screen row.
	
	;; so to make this work, we must:
;;;;;1) Find out the left and right nametable values:
	SwitchBank #$16
	
		LDA temp
		
		ASL
		ASL
		ASL
		ASL
		STA temp ;; what row of screens is the screen on?
		LDA camX_hi
		AND #%00001111 ;; what column of screen is the screen in
		CLC
		ADC temp
		STA tempA
		;;;;;;;;; This is now the number of the screen, if we want it for any other purpose.
	
		TAY
		JSR getScrollValueFromNametable
		
		LDA tempA
		CLC
		ADC #$01
		STA temp
	
		TAY
		JSR getScrollValueFromNametable2
	
		LDA tempA
		SEC
		SBC #$01
		STa temp

		TAY
		JSR getScrollValueFromNametable3
			;; now nametable is loaded into temp16
			
			
		LDA tempA
		clc
		adc #$02
		STa temp
		TAY
		JSR getScrollValueFromNametable4
			;; now nametable is loaded into temp16
			;; attribute table is loaded into pointer
			;; "right" nametable is loaded into pointer2
			;; "right" attribute table is loaded into pointer3.
			;; "left" nametable is loaded into pointer4
			;; "left" attribute table is loaded into pointer5
				
			
		ReturnBank
		
		
		
		
		LDA tempA ; nametable
		LSR
		LSR
		LSR
		LSR
		LSR
		STA temp ; bank
		
		SwitchBank temp
		
		
JSR doNonsense
;;;;; 2) Now we blast values into 192 consecutive bytes.
			;; 32 tiles across, for two nametables
			;; high byte, low byte, value for each.
			;; 64 x 3 = 192.
			
		LDA camY

		LSR
		LSR
			;LSR
			;LSR
			;LSR
			
			;ASL
			;ASL
			;ASL
		AND #%11111000
		STA tempx ;; attribute positioning

			
		LDA camY ;; how far are we scrolled down?
		LSR
		LSR
		LSR
		LSR
		LSR
		LSR
		CLC
		ADC updateNametable ;; add to current nametable.  updateNametable
		STA tempC  ;; tempC becomes the high address byte to write to.
		;;;;;;;;;;;;;;;;;;;;;;;;;;;
		LDA camY
			;;; Divide it by 8 to know what "row" we should be drawing.
			;LSR
			;LSR
			;LSR
			;;; multiply by 32 for the pixel depth of each row.
			;ASL
			;ASL
			;ASL
			;;;;; three shifts in each direction cancel out...no reason to do them.
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		ASL
		ASL
		AND #%11100000
	
		STA tempD
	

		
		LDA camY ;tempz ;; here, tempz is the row of the camera
		AND #%11110000 ;; divided by 16, it gives the starting row to read from.
		STA temp
		LDA camX
		AND #%00001111
		CLC
		ADC temp
		TAY ;; now pull value is loaded into Y.
		LDX #$00
		
			JSR updateTopRow
			TXA
			STA maxScrollOffsetCounter

		doneWithLoadRowData:

	LDA #$00
	STA scrollOffsetCounter
		
	LDA updateScreenData
	ORA #%0000100
	STA updateScreenData
	ReturnBank
	

	RTS
	
	
	

	

	
	
updateTopRow:
	LDA #$00
	STA nametableUpdateStep
	LDA #$20
	STA tempy ;; tiles to update.  Two nametables worth.
	LDX #$00
	;;;;;;;;;;;;;;;;;;;;;
	;;; SET STEP TO ZERO
	;;; If tile to draw < (camX/16)
	;;;		If in the same nametable
	;;;			draw nt.
	;;;		If in different nametable
	;;;			draw nt+1
	;;;If tile to draw >= (camX/16)
	;;;		If in in different nametable
	;;;			if tile to draw <(camX+80/16)
	;;;				draw nt+1
	;;;			if tile to draw >=)camX+80/16)
	;;;				draw nt-1
	
	LDA camY
			;;; Divide it by 8 to know what "row" we should be drawing.
			;LSR
			;LSR
			;LSR
			;;; multiply by 32 for the pixel depth of each row.
			;ASL
			;ASL
			;ASL
			;;;;; three shifts in each direction cancel out...no reason to do them.
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		ASL
		ASL
		AND #%11100000
		STA tempD
	LDA camY ;tempz ;; here, tempz is the row of the camera
	AND #%11110000 ;; divided by 16, it gives the starting row to read from.
	TAY	
	
	LDA #$00
	STA tempB ;; will keep track of what tile to draw.
	LDA updateNametable
	STA tempz ;; will hold for comparison.
	doDrawTopRowVscrollLoop:
		LDA tempC
		STA scrollUpdateRam,x
		INX
		LDA tempD ;; row
		CLC
		ADC tempB ;; position in that row.
		STA scrollUpdateRam,x
		INX
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;; now, we have to factor which table to pull from.
		;; temp16 = current nametable
		;; pointer2 = nametable + 1
		;; pointer4 = nametable - 1
		
		
		;;; tempB represents which tile is being updated.
		;;; tempB / 2 represets it "in tiles".
		;;; camX / 16 represents the camera position in tiles.
		;;; camX_hi and 00000001 = if we're updating the left or the right nametable.
		;;; tempy is how many tiles are drawn...so if it is less than 10 it is drawing the second page.
		
		LDA camX
		LSR
		LSR
		LSR
		LSR
		STA tempx ;; tempx now holds the position of the camera in tiles.
		
		

			LDA camX 
			CMP #$80
			BCC camIsLessThanHalf
			
				;; cam is more than half
				LDA tempy ;; have we crossed the threshold of pages?
				CMP #$10
				BEQ haveCrossedPage
				BCS haveNotCrossedPage
					haveCrossedPage
					;; we have crossed the page
					JSR readFromNTplus1
					JMP gotLoadedNametable
					
					LDA tempB
					LSR
					CLC
					ADC #$08
					CMP tempx
					BCC drawNT_plus_1
						;; draw NT - 1
						JSR readFromNTminus1
						JMP gotLoadedNametable
					drawNT_plus_1:
						JSR readFromNTplus1
						JMP gotLoadedNametable
				haveNotCrossedPage:
					;; we have not crossed the page.
					LDA tempB
					LSR ;; now we have the current position in tile size
					CLC
					ADC #$08
					CMP tempx
					BCC drawNT_plus_2
						
						;;; draw NT + 1
						JSR readFromCurrentNT
						JMP gotLoadedNametable
					drawNT_plus_2:
						;; draw NT + 2
						JSR readFromNTplus2
						JMP gotLoadedNametable
			camIsLessThanHalf:
				
				;; cam is less than half
				LDA tempy
				CMP #$10
				BEQ haveCrossedPage2
				BCS haveNotCrossedPage2
					haveCrossedPage2:
					;; we have crossed the page.
					LDA tempB
					LSR
					STA temp
					LDA tempx
					CLC
					ADC #$08
					CMP temp
					BCS drawNT_plus_1b
						
						JSR readFromNTminus1
						JMP gotLoadedNametable
					drawNT_plus_1b:
						JSR readFromNTplus1
						JMP gotLoadedNametable
				haveNotCrossedPage2
					;; have not crossed the page.
					;; in this case, all of page 1
					;; will be nt1
					JSR readFromCurrentNT
					JMP gotLoadedNametable
					
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Subroutine reads;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
			readFromCurrentNT:
				TYA
				PHA
					;STA tempz
					LDA (temp16),y
					STA temp
					JSR doGetSingleMetaTileValues
				PLA
				TAY	
				RTS
				
			readFromNTplus1:
				TYA
				PHA
					;STA tempz
					LDA (pointer2),y
					STA temp
					JSR doGetSingleMetaTileValues
				PLA
				TAY	
				RTS
			
			readFromNTminus1:
				TYA
				PHA
					;STA tempz
					LDA (pointer4),y
					STA temp
					JSR doGetSingleMetaTileValues
				PLA
				TAY	
				RTS
				
			
				
			readFromNTplus2:
				TYA
				PHA
					;STA tempz
					LDA (pointer6),y
					STA temp
					JSR doGetSingleMetaTileValues
				PLA
				TAY	
				RTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;END Subroutine reads;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				
			
		
		gotLoadedNametable:
		
		LDA camY ;; the ROW video being opened.
		AND #%00001000
		BNE doUpdateBottomRowTiles
			LDA updateTile_00
			STA temp1
			LDA updateTile_01
			STA temp2
			JMP gotRowTilesToUpdate
		doUpdateBottomRowTiles:
			LDA updateTile_02
			STA temp1
			LDA updateTile_03
			STA temp2
		gotRowTilesToUpdate:
		
		LDA temp1
		STA scrollUpdateRam,x
		INX
		

		;;;;;;;;;;;;;;;;;;;;;
		;; increase tempB but evaluate for position in regards to camera.
		;;;;;;;;;;;;;;;;;;;;
		INC tempB
		LDA tempC
		STA scrollUpdateRam,x
		INX
		LDA tempD
		CLC
		ADC tempB
		STA scrollUpdateRam,x
		INX
		LDA temp2
		STA scrollUpdateRam,x
		INX
		INY
		INC tempB
		DEC tempy
		LDA tempy
		BEQ doneLoadingTopRowScrollV
		CMP #$10
		BEQ doneLoadingFirstNTforTopRowScrollV
			JMP doDrawTopRowVscrollLoop
		doneLoadingFirstNTforTopRowScrollV:
			
			JSR ToggleNametable
			LDA camY ;; how far are we scrolled down?
			LSR
			LSR
			LSR
			LSR
			LSR
			LSR
			CLC
			ADC updateNametable ;; add to current nametable.  updateNametable
			STA tempC  ;; tempC becomes the high address byte to write to.
			LDA camY
			;;; Divide it by 8 to know what "row" we should be drawing.
			;LSR
			;LSR
			;LSR
			;;; multiply by 32 for the pixel depth of each row.
			;ASL
			;ASL
			;ASL
			;;;;; three shifts in each direction cancel out...no reason to do them.
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			ASL
			ASL
			AND #%11100000
			STA tempD
			LDA #$00
			STA tempB
			LDA camY ;tempz ;; here, tempz is the row of the camera
			AND #%11110000 ;; divided by 16, it gives the starting row to read from.
			TAY
			JMP doDrawTopRowVscrollLoop
	doneLoadingTopRowScrollV
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Now load attributes the same way.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA #$10
	STA tempy ;; tiles to update.  Two nametables worth.	
	; LDA camY
	; LSR
	; LSR
	; AND #%11111000
	; STA tempx ;; attribute positioning

	
	LDA camX
	CLC
	ADC #$08
	LSR
	LSR
	LSR
	LSR
	LSR
	STA tempx
	
	LDA #$00
	STA tempB
	
	LDA updateAttributeTable
	STA tempC
	
	LDA camY
	LSR
	LSR
	AND #%11111000
	STA tempD
	TAY
	
	
	
	
	doDrawAttVScrollLoop:
		LDA tempC
		STA scrollUpdateRam,x
		INX
		LDA #$c0
		CLC
		ADC tempD
		STA scrollUpdateRam,x
		INX
		
		
			LDA camX 
			CMP #$80
			BCC camIsLessThanHalf_attributes
				;; cam is more than half
				LDA tempy ;; have we crossed the threshold of pages?
				CMP #$08
				BEQ haveCrossedPage_att
				BCS haveNotCrossedPage_attributes
					haveCrossedPage_att:
					;; we have crossed the page
					JSR readFromAttplus1
					JMP gotLoadedAttTable
			
				haveNotCrossedPage_attributes:
					;; we have not crossed the page.
					LDA tempB
					CLC
					ADC #$04
					CMP tempx
					BCC drawAtt_plus_2
						;;; draw NT + 1
						JSR readFromCurrentAtt
						JMP gotLoadedAttTable
					drawAtt_plus_2:
						;; draw NT + 2
						JSR readFromAttplus2
						JMP gotLoadedAttTable
			camIsLessThanHalf_attributes:
				;; cam is less than half
				LDA tempy
				CMP #$08
				BEQ haveCrossedPage_att2
				BCS haveNotCrossedPage2_attributes
					haveCrossedPage_att2:
					;; we have crossed the page.
					
					LDA tempx
					CLC
					ADC #$04
					CMP tempB
					BCS drawAtt_plus_1b
						
						JSR readFromAttminus1
						JMP gotLoadedAttTable
					drawAtt_plus_1b:
						JSR readFromAttplus1
						JMP gotLoadedAttTable
				haveNotCrossedPage2_attributes
					;; have not crossed the page.
					;; in this case, all of page 1
					;; will be nt1
					JSR readFromCurrentAtt
					JMP gotLoadedAttTable
					
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Subroutine reads;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
			readFromCurrentAtt:
		
					;STA tempz
					LDA (pointer),y
			
				RTS
				
			readFromAttplus1:
			
					;STA tempz
					LDA (pointer3),y
				
				RTS
			
			readFromAttminus1:
				
					;STA tempz
					LDA (pointer5),y
			
				RTS
				
			
				
			readFromAttplus2:
				
					;STA tempz
					LDA (pointer7),y
				
				RTS
				
				
		gotLoadedAttTable:
			STA scrollUpdateRam,x
			INX
			INY
			INC tempD
			INC tempB
			DEC tempy
			LDA tempy
			BEQ doneWithAttributeRow
			CMP #$08
			BEQ swapPageForAttributeRowUpdate
				JMP doDrawAttVScrollLoop
			swapPageForAttributeRowUpdate
				JSR ToggleAttributeTable
				LDA updateAttributeTable
				STA tempC
				LDA camY
				LSR
				LSR
				AND #%11111000
				STA tempD
				TAY
				LDA #$00
				STA tempB
				JMP doDrawAttVScrollLoop
		doneWithAttributeRow:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Now update collision data the same way.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RTS

doNonsense:

	LDA #$20
	STA tempy ;; collision tiles to update.  Two nametables worth.
	
	LDA camX
		LSR
		LSR
		LSR
		LSR
		STA tempx ;; tempx now holds the position of the camera in tiles.
		
	
	
	LDA camY
	AND #%11110000
	TAX ;; use this for the push.
	
	LDA camY
	LSR
	AND #%11111000
	TAY
	
	
	doLoadCollisionRowLoop:
			TYA
			STA tempB
			
			LDA camX 
			CMP #$80
			BCC camIsLessThanHalf_collisions
			
				;; cam is more than half
				LDA tempy ;; have we crossed the threshold of pages?
				CMP #$10
				BEQ haveCrossedPage_collisions
				BCS haveNotCrossedPage_collisions
					haveCrossedPage_collisions
					LDA #$01
					STA tempD ;; used to determine whether to write to 
					;;; collision table 1 or 2.
					;; we have crossed the page
					JSR readFromNTplus1_collisions
					JMP gotLoadedCollisionTable
					
					LDA tempB
					;LSR
					CLC
					ADC #$08
					CMP tempx
					BCC drawNT_plus_1_collisions
						;; draw NT - 1
						JSR readFromNTminus1_collisions
						JMP gotLoadedCollisionTable
					drawNT_plus_1_collisions:
						JSR readFromNTplus1_collisions
						JMP gotLoadedCollisionTable
				haveNotCrossedPage_collisions:
					LDA #$00
					STA tempD
					;; we have not crossed the page.
					LDA tempB
					;LSR ;; now we have the current position in tile size
					CLC
					ADC #$08
					CMP tempx
					BCC drawNT_plus_2_collisions
						
						;;; draw NT + 1
						JSR readFromCurrentNT_collisions
						JMP gotLoadedCollisionTable
					drawNT_plus_2_collisions:
						;; draw NT + 2
						JSR readFromNTplus2_collisions
						JMP gotLoadedCollisionTable
			camIsLessThanHalf_collisions:
				
				;; cam is less than half
				LDA tempy
				CMP #$10
				BEQ haveCrossedPage2_collisions
				BCS haveNotCrossedPage2_collisions
					haveCrossedPage2_collisions:
					;; we have crossed the page.
					LDA tempB
					;LSR
					STA temp
					LDA tempx
					CLC
					ADC #$08
					CMP temp
					BCS drawNT_plus_1b_collisions
						
						JSR readFromNTminus1_collisions
						JMP gotLoadedCollisionTable
					drawNT_plus_1b_collisions:
						JSR readFromNTplus1_collisions
						JMP gotLoadedCollisionTable
				haveNotCrossedPage2_collisions
					;; have not crossed the page.
					;; in this case, all of page 1
					;; will be nt1
					JSR readFromCurrentNT_collisions
					JMP gotLoadedCollisionTable

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Subroutine reads;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
			readFromCurrentNT_collisions:
		
					;STA tempz
					LDA (pointer8),y
			
				RTS
				
			readFromNTplus1_collisions
			
					;STA tempz
					LDA (pointer9),y
				
				RTS
			
			readFromNTminus1_collisions
				
					;STA tempz
					LDA (pointer10),y
			
				RTS
				
			
				
			readFromNTplus2_collisions:
				
					;STA tempz
					LDA (pointer11),y
				
				RTS
				
gotLoadedCollisionTable:

		
	STA temp
	
	LDA tempD
	BNE pushToSecondColTable
	;; push to first col table.
	LDA camX_hi
	AND #%00000001
	BEQ pushToCol1
	JMP pushToCol2
pushToSecondColTable:
	LDA camX_hi
	AND #%00000001
	BEQ pushToCol2
	JMP pushToCol1
	
pushToCol1:
	TYA
	AND #%00000001
	BNE thisColTileIsOdd_row
		LDA temp
		LSR
		LSR
		LSR
		LSR
		STA collisionTable,x
		JMP doneWritingNewColValue
	thisColTileIsOdd_row:
		INY
		LDA temp
		AND #%00001111
		STA collisionTable,x
		JMP doneWritingNewColValue
pushToCol2:
	TYA
	AND #%00000001
	BNE thisColTileIsOdd_roww
		LDA temp
		LSR
		LSR
		LSR
		LSR
		STA collisionTable2,x
		JMP doneWritingNewColValue
	thisColTileIsOdd_roww
		INY
		LDA temp
		AND #%00001111
		STA collisionTable2,x
		JMP doneWritingNewColValue
	
doneWritingNewColValue:
	
	INX
	TXA
	AND #%00001111
	TAX
	Dec tempy
	LDA tempy
	BEQ doneWithUpdatingCollisionRow
	JMP doLoadCollisionRowLoop
doneWithUpdatingCollisionRow:
	RTS
	
	
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		
		
	RTS
	
	
	
updateBottomRow:
		
		
	RTS
	

updateAttributeRow:	

	
	
	RTS

	



	
	
getScrollValueFromNametable
		LDA NameTablePointers_Map1_lo,y
			STA temp16
			LDA NameTablePointers_Map1_hi,y
			STA temp16+1
			
			LDY tempA
			LDA AttributeTables_Map1_Lo,y
			STA pointer
			LDA AttributeTables_Map1_Hi,y
			STA pointer+1
			
			LDA CollisionTables_Map1_Lo,y
			STA pointer8
			LDA CollisionTables_Map1_Hi,y
			STA pointer8+1
			
	RTS
	
getScrollValueFromNametable2
			LDA NameTablePointers_Map1_lo,y
			STA pointer2
			LDA NameTablePointers_Map1_hi,y
			STA pointer2+1
			
			LDY temp
			 LDA AttributeTables_Map1_Lo,y
			 STA pointer3
			 LDA AttributeTables_Map1_Hi,y
			 STA pointer3+1
			 
			 LDA CollisionTables_Map1_Lo,y
			STA pointer9
			LDA CollisionTables_Map1_Hi,y
			STA pointer9+1
			
	RTS
		
getScrollValueFromNametable3:
			LDA NameTablePointers_Map1_lo,y
			STA pointer4
			LDA NameTablePointers_Map1_hi,y
			STA pointer4+1
			
			LDY temp
			LDA AttributeTables_Map1_Lo,y
			STA pointer5
			LDA AttributeTables_Map1_Hi,y
			STA pointer5+1
			
			LDA CollisionTables_Map1_Lo,y
			STA pointer10
			LDA CollisionTables_Map1_Hi,y
			STA pointer11+1
			
	RTS
	
getScrollValueFromNametable4:
			LDA NameTablePointers_Map1_lo,y
			STA pointer6
			LDA NameTablePointers_Map1_hi,y
			STA pointer6+1
			
			LDY temp
			LDA AttributeTables_Map1_Lo,y
			STA pointer7
			LDA AttributeTables_Map1_Hi,y
			STA pointer7+1
			
			LDA CollisionTables_Map1_Lo,y
			STA pointer11
			LDA CollisionTables_Map1_Hi,y
			STA pointer11+1
			
	RTS
	
CheckCamXPositionForScreen:
	;;; if camX normalized is < half way into scroll,
	;;; load both nametables as normal.
	
	;;; otherwise, find how many rows are the difference.
	;;; these should be current nametable + 2 (if moving right).
	
	LDA camX
	LSR
	LSR
	LSR
	LSR ;; now we know what row, 0-15, the camera is scrolled to horizontally.
	CMP #$08
	BCC normalDualNtUpdate
;	JMP RESET
	;; special case dual nametable update.
normalDualNtUpdate

	RTS
	
	
	
GetRowTileIndex:
		LDA camY
			;;; Divide it by 8 to know what "row" we should be drawing.
			;LSR
			;LSR
			;LSR
			;;; multiply by 32 for the pixel depth of each row.
			;ASL
			;ASL
			;ASL
			;;;;; three shifts in each direction cancel out...no reason to do them.
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		ASL
		ASL
		AND #%11100000
		STA temp ;; THE ROW
		LDA camX
		LSR
		LSR
		LSR
		

		CLC
		ADC temp
		STA tempD
	
	RTS
	
IncreaseRowUpdateTile:
	LDA tempD
	AND #%00011111
	CMP #%00011111
	BNE notInLastColumn_forRowUpdateTile
	inc nametableUpdateCounter
	JSR ToggleNametable
	LDA camY ;; how far are we scrolled down?
		LSR
		LSR
		LSR
		LSR
		LSR
		LSR
		CLC
		ADC updateNametable ;; add to current nametable.  updateNametable

		STA tempC  ;; tempC becomes the high address byte to write to.
	
	
	LDA tempD
	SEC
	SBC #%00011111

	STA tempD
	;;;;;;;;;;;;;;;;;;;;;;
		LDA camY ;tempz ;; here, tempz is the row of the camera
		AND #%11110000 ;; divided by 16, it gives the starting row to read from.
		STA temp
		LDA camX
		LSR
		LSR
		LSR
		LSR
		CLC
		ADC temp
		AND #%11110000
		TAY

	RTS
notInLastColumn_forRowUpdateTile:
	inc tempD
	RTS
	
	
IncreaseRowUpdateAttribute
	LDA tempx
	AND #%00000111
	CMP #%00000111
	BNE notInLastColumn_forRowUpdateAttribute
	INC nametableUpdateCounter
	JSR ToggleAttributeTable
		LDA camY

	LSR
	LSR
			;LSR
			;LSR
			;LSR
			
			;ASL
			;ASL
			;ASL
	AND #%11111000
	STA tempx ;; attribute positioning
	TAY

	RTS
	
notInLastColumn_forRowUpdateAttribute:
	INC tempx
	RTS
	
