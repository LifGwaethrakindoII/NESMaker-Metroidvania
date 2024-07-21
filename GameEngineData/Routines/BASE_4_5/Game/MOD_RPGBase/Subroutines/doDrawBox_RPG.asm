doDrawBox:

	
	LDA updateScreenData
	AND #%00000101 ;; if queued to push tiles or attributes
	BEQ checkQueueFlags
	
	
	RTS 
checkQueueFlags:
	LDA queueFlags
	AND #%10000000
	BEQ skipSettingUpBox
	
	LDA gameStatusByte
	ORA #%00000001 ;;; this will skip object handling.
	STA gameStatusByte
	
	; LDA arg0_hold
	; STA Box_x_origin
	LDA Box_x_origin
	STA temp_boxX
	
	LDA Box_y_origin
	STA Box_y_hold
	STA temp_boxY
	
	LDA Box_width
	STA temp_boxWidth
	
	LDA Box_height
	STA Box_height_hold
	STA temp_boxHeight
		;;; legacied method:
		; STA temp_boxX
		; LDA arg1_hold
		; STA Box_y_origin
		; STA Box_y_hold
		; STA temp_boxY
		; LDA arg2_hold
		; STA Box_width
		; STA temp_boxWidth
		; LDA arg3_hold
		; STA Box_height
		; STA Box_height_hold
		; STA temp_boxHeight
		;;;;;;;;;;;;;;;;
	LDA queueFlags
	AND #%01111111
	STA queueFlags
	
	
skipSettingUpBox:
	LDA queueFlags
	AND #%00000100
	BEQ notCurrentlyUpdatingQueuedAttributes
	JMP currentlyUpdatingQueuedAttribtues
notCurrentlyUpdatingQueuedAttributes:
	;;; draw box will update one metatile row at a time,
	;;; so at max, it will be updating 16x4 tiles (64) x 3 bytes per tile (192).
	;;; This makes multple frames of updates easy.
	;;; If the queue flag bit 0 is activated, that means that we have moved on to another row, but are not done yet.
	
	LDA queueFlags
	AND #%00000001
	BEQ notCurrentlyUpdatingQueuedTiles
	;; currently updating queued tiles
	
	JMP currentlyUpdatingQueuedTiles
notCurrentlyUpdatingQueuedTiles:
	;;;;; We are JUST starting a box update.
	; arg0_hold = X value, in metatiles
	; arg1_hold = y value, in metatiles
	; arg2_hold = width, in metatiles
	; arg3_hold = height, in metatiles
	
	LDA queueFlags
	ORA #%00000001
	STA queueFlags
	

currentlyUpdatingQueuedTiles:
	
	LDA Box_x_origin ;; the x value, in metatiles, of the box draw.
	ASL ;; multiplied by two, since metatiles are 16x16, but PPU addresses are 8x8.
	STA temp
	LDA Box_y_origin ;; the y value, in metatiles, of the box draw.
	ASL ;; multiplied by two, since metatiles are 16x16, but ppu addresses are 8x8.
	STA temp1
		ASL
		ASL
		ASL
		ASL
		ASL
		CLC 
		ADC temp
		STA temp3

		
	LDA temp1
		LSR
		LSR
		LSR
	CLC
	ADC camFocus_tiles
	STA temp2

	
	
	
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; LOAD THE BYTES INTO SCRATCH RAM:
	;;; High, Low, Tile.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		LDA #$00
		
		STA scrollOffsetCounter
		TAY
		
		doDrawBoxLoop:
			LDA #$00
			STA tempx
			LDX Box_width ;; load the width into x.

			doDrawBoxLoop_inner:
				TYA
				STA tempy
				;;;;;;;;;;;;; What do we draw?
				;;;;;;;;;;;;; If we are creating a box, we just draw a blank tile.
				;;;;;;;;;;;;; If we are erasing a box, we will get the tile data of the
				;;;;;;;;;;;;; current screen, and push the updateTile variables into
				;;;;;;;;;;;;; tempA-tempD.
				LDA queueFlags
				AND #%00000010
				BNE isRestoringBox
					JMP isJustDrawingBox
				isRestoringBox:
					LDA queueFlags
					ORA #%01000000
					STA queueFlags
					SwitchBank #$16
	
						LDY currentNametable 
					
						 LDA warpMap
						 BEQ +loadFromMap1table
							; ;;;load from map 2 table
							 LDA NameTablePointers_Map2_lo,y
							 STA temp16
							 LDA NameTablePointers_Map2_hi,y
							 STA temp16+1
							 JMP +GotNametableLoadPointer
						+loadFromMap1table:
							LDA NameTablePointers_Map1_lo,y
							STA temp16
							LDA NameTablePointers_Map1_hi,y
							STA temp16+1
						+GotNametableLoadPointer:
							;;now (temp16) holds the address of the nametable to be loaded.
					ReturnBank
				
				
					;; is restoring the nametable.
					;; Find nametable value for this position.
					;; First, we have to jump to the proper bank.
					 	LDA currentNametable
						LSR
						LSR
						LSR
						LSR
						LSR
						STA temp
						
						LDA warpMap
						BEQ +dontAdd8toScreenBank
							;; ad 8 to screen bank
							LDA temp
							CLC
							ADC #$08
							STA temp
							JMP +gotScreenBank
						+dontAdd8toScreenBank
							LDA temp
						+gotScreenBank:
					SwitchBank temp
						;;; now we can load from temp16, with y as our offset.
							LDA Box_y_origin
								ASL
								ASL
								ASL
								ASL
								CLC 
								ADC Box_x_origin
								CLC 
								ADC tempx
							TAY
							LDA (temp16),y
							STA temp ;; it is this value that doGetSingleMetaTileValues uses.
						
						
					ReturnBank
						
					LDA temp
					JSR doGetSingleMetaTileValues
					LDA updateTile_00
					STA tempA
					LDA updateTile_01
					STA tempB
					LDA updateTile_02
					STA tempC
					LDA updateTile_03
					STA tempD
					
					
					
					JMP gotBoxFill
				isJustDrawingBox:
				
					LDA #$f5
					STA tempA
					STA tempB
					STA tempC
					STA tempD
				gotBoxFill:
				LDY tempy
			
				LDA temp2
				STA scrollUpdateRam,y
				INY
				LDA temp3
				STA scrollUpdateRam,y
				INY
				LDA tempA
				STA scrollUpdateRam,y
				INY
				
				LDA temp2
				STA scrollUpdateRam,y
				INY
				LDA temp3
				CLC
				ADC #$01
				STA scrollUpdateRam,y
				INY
				LDA tempB
				STA scrollUpdateRam,y
				INY
				
					LDA temp3
					CLC
					ADC #$20
					STA temp3
					LDA temp2
					ADC #$00
					STA temp2
				
				LDA temp2
				STA scrollUpdateRam,y
				INY
				LDA temp3
				STA scrollUpdateRam,y
				INY
				LDA tempC
				STA scrollUpdateRam,y
				INY
				
				LDA temp2
				STA scrollUpdateRam,y
				INY
				LDA temp3
				CLC
				ADC #$01
				STA scrollUpdateRam,y
				INY
				LDA tempD
				STA scrollUpdateRam,y
				INY
				INC tempx ;; temp x is the TILE offset, where as y / scrollOffsetCounter represents
							;;; the ram offset, which consists of high byte, low byte, AND tile.
				DEX
				BEQ doneWithDrawBoxRow
				;;; more box row to draw.
					LDA temp3
					SEC
					SBC #$1E 
					STA temp3
					LDA temp2
					SBC #$00
					STA temp2
					JMP doDrawBoxLoop_inner
				doneWithDrawBoxRow:
						DEC Box_height_hold
						LDA Box_height_hold
						BEQ doneWithBoxDrawOutterLoop

							LDA Box_y_origin
							CLC
							ADC #$01
							STA Box_y_origin
							JMP notDoneWithBoxDrawOutterLoop
				doneWithBoxDrawOutterLoop:
					LDA queueFlags
					AND #%01000000
					BNE +isNotCreatingBoxTiles
						JMP isCreatingBoxTiles
					+isNotCreatingBoxTiles:	
						;; is restoring box tiles
						;;; COMPLETLY DONE WITH BOX.	
						;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
						;;; SUBSTATES:
						;;; When we're finished with a box, we need to check if we've popped to a new substate.
						;;; If the substate is zero, that means we've returned to the normal game.
						;;; But other substates may denote that we've moved into a new submenu.
						;;; In the default module, substate 1 is our command box.
						;;; Substate 2 is the status box.
						;;; Substate 3 is the spell box.
						;;; Substate 4 is the item box
						;;; Substate 5 is the equp box.
						;;; For these different substates, we'll need to open different boxes.
						;;; They can be found in tables in the menu manager, so that we only need
						;;; a single routine to set them up.
						;;; If ever a value of FF is read from one of those tables for one of the values, it knows to
						;;; pop out of this routine (if there is a game sub state that doesn't involve
						;;; using a submenu).  A "pop out" will mean jump to +isZero, which finishes "un-drawing" the box.
						TYA
						PHA
						
						LDY gameSubState
						
							; ;; set up new box
								 LDA SubstateTable_Origin_x,y
								 CMP #$FF
								 BNE +notNull
									;; was a null game state
									;; will behave like "zero" (main game).
									PLA
									TAY
									JMP +isZero
								 +notNull
									 STA Box_x_origin
									 STA temp_boxX
									
								LDA SubstateTable_Origin_y,y
									 STA Box_y_origin
									 STA Box_y_hold
									 STA temp_boxY
									
								LDA SubstateTable_width,y
									 STA Box_width
									 STA temp_boxWidth
									
								LDA SubstateTable_height,y
									 STA Box_height
									 STA Box_height_hold
									 STA temp_boxHeight

									
								LDA SubstateTable_text_lo,y
								STA textPointer
								LDA SubstateTable_text_hi,y
								STA textPointer+1
								
								LDA #TEXT_FREE
								STA endDrawBoxAction
											
												
								LDA  #%00000001
								STA queueFlags
							PLA
							TAY
								; ;;; still finish out the rest of other box.
								JMP notDoneWithBoxDrawOutterLoop
							; +notOne
							
						+isZero
						LDA #$00
						STA gameSubState
						STA queueFlags
						LDA gameStatusByte
							AND #%11111110 ;;; this will skip object handling.
							STA gameStatusByte
							JMP notDoneWithBoxDrawOutterLoop
					isCreatingBoxTiles:
						LDA queueFlags
						ASL
						ASL
						;;; this shifts these bits to the left two places.
						;;; 0001 will become 0100, meaning that we are driving all attributes to box attributes.
						;;; 0011 will become 1100, meaning we are restoring the screen's attributes.
						AND #%00001100 ;; this will scrape off the bits if we have passed attribute queue.
						STA queueFlags
						LDA temp_boxY
						STA Box_y_origin
			notDoneWithBoxDrawOutterLoop:
		

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Push the offset so we know how many tiles to update.
	;;; max would be 85 tiles.
	;;; could make this metatiles to get more out of this.
		TYA
		STA maxScrollOffsetCounter
		
		
				
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Turn on update screen on next frame.
			LDA updateScreenData
			ORA #%0000100
			STA updateScreenData
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
	
	
	RTS
	
	
	
currentlyUpdatingQueuedAttribtues:

	;;; the max amount of attributes to be updated on a screen is 64.
	;;; There are three bytes needed to be pushed into the scrollUpdateRam to update in the next refresh.
	;;; All attributes, then, can be updated within 256 bytes, so there is no reason to go row by row as we do with
	;;; metatiles, which need 4 tile definitions x hi and low bytes for each.

	LDA queueFlags
	AND #%00010000
	BEQ doSetupAttributeQueue
		JMP alreadySetupAttributeQueue
	doSetupAttributeQueue:
			
		
		LDA Box_height
		;; allow for odd starts, if on odd, will need to add 1
		STA Box_height_hold
		
		LDA queueFlags
		ORA #%00010000
		STA queueFlags
	alreadySetupAttributeQueue
		
			
	; LDA queueFlags
	; AND #%00001000
	; BEQ doBlankBoxAttributes
		; JMP doRestoreScreenAttributes
	; doBlankBoxAttributes:	

		
		;; is writing 11 to all attributes that are within "the box".
		LDA Box_x_origin
		LSR
		STA tempA
		LDA Box_y_hold
		LSR
		STA tempB
		
		LDA Box_width
		LSR 
		;; allow for odd starts, if on odd, will need to add 1
		STA tempC
		STA tempz
	
		;; now, tempA*8+tempB gives us the starting position for the box's attributes.
	
		LDA #$00
		STA scrollOffsetCounter
		TAY
		
		doDrawBoxAttributesLoop:	
			TYA
			STA tempy
			
			LDA tempB
			ASL
			ASL
			ASL
			CLC 
			ADC tempA
			sta tempx ;; tempx is our offset for the Attribute table.
			
			
			LDA camFocus_att ;; high byte, have to change based on which nametable we are in.
			STA temp1
			LDA #$C0
			CLC
			ADC tempx
			STA temp2
			
	

			LDA queueFlags
			AND #%00001000
			BNE isRestoringBoxAttributes
				LDA #$FF ;; what attribute do you want to fill the box with?
				STA temp3
				JMP gotBoxAttributeFill
			
			isRestoringBoxAttributes:
				LDA queueFlags
				ORA #%01000000
				STA queueFlags
				SwitchBank #$16
					LDY currentNametable
					LDA warpMap
					BEQ +loadAttFromTable1
						LDA AttributeTables_Map2_Lo,y
						STA temp16
						LDA AttributeTables_Map2_Hi,y
						STA temp16+1
						JMP +gotAttFromTable
					+loadAttFromTable1:
						LDA AttributeTables_Map1_Lo,y
						STA temp16
						LDA AttributeTables_Map1_Hi,y
						STA temp16+1
					+gotAttFromTable
				ReturnBank
				
				LDA currentNametable
				LSR
				LSR
				LSR
				LSR
				LSR
				STA temp
					LDA warpMap
					BEQ +dontAdd8toscreenBankforAtt
						;; add 8 to screen bank
						LDA temp
						CLC
						ADC #$08
						STA temp
						JMP +gotScreenBankForAtt
					+dontAdd8toscreenBankforAtt
						LDA temp
					+gotScreenBankForAtt
				SwitchBank temp
					LDY tempx
					LDA (temp16),y
					STA temp3
				ReturnBank
	
			gotBoxAttributeFill:
					LDY tempy
					LDA temp1
					STA scrollUpdateRam,y
					INY
					LDA temp2
					STA scrollUpdateRam,y
					INY
					LDA temp3
					STA scrollUpdateRam,y
					INY
					INC tempA
					DEC tempz
					LDA tempz
					BEQ doneWithDrawBoxAttributeRow
					JMP doDrawBoxAttributesLoop
				doneWithDrawBoxAttributeRow:
					DEC Box_height_hold
					LDA Box_height_hold
					BEQ doneWithDrawBoxAttributes
							INC Box_y_hold
							JMP moreBoxAttributes
					

			doneWithDrawBoxAttributes:
				LDA queueFlags
				AND #%01000000
				BEQ isCreatingBoxAttributes
					;; is restoring box attributes
					LDA #%10000011
					STA queueFlags
					JMP moreBoxAttributes
				isCreatingBoxAttributes
					LDA #$00
					STA queueFlags
					LDA textQueued
					AND #%00000010
					BEQ notTurningOffTextbox
						
						;; turning off textbox
						LDA textQueued
						AND #%11111101
						STA textQueued
						JMP do02endBoxAction
					notTurningOffTextbox:
					LDA endDrawBoxAction
					BNE notZeroEndBoxAction
						JMP moreBoxAttributes ;; there is no text to draw in this box
					notZeroEndBoxAction:
						CMP #$01
						BEQ do01endBoxAction ;; do erase box
							JMP notDo01endBoxAction
						do01endBoxAction:
							;; this means direct text is queued.
							QueueText #$19, Text2, Box_x_origin, Box_y_origin, Text2
							JMP moreBoxAttributes
						notDo01endBoxAction:
						CMP #$02
						BEQ do02endBoxAction
							
							JMP notDo02endBoxAction
						do02endBoxAction:
							
							EraseBox temp_boxX, temp_boxY, temp_boxWidth, temp_boxHeight
							jmp moreBoxAttributes
						notDo02endBoxAction
						CMP #$03
						BEQ do03endBoxAction
							JMP notDo03endBoxAction
						do03endBoxAction:
							;;; 03 type box means that this was a HUD box
							LDA #$00
							STA updateHud
							JMP moreBoxAttributes
						notDo03endBoxAction
						CMP #$04
						BEQ do04endBoxAction
							JMP notDo04EndBoxAction
						do04endBoxAction:
							;; ok this means that this is an NPC box.
							QueueText #$19, textToWrite, Box_x_origin, Box_y_origin, #$01
						notDo04EndBoxAction:
			moreBoxAttributes:
				TYA
				STA maxScrollOffsetCounter
			justUpdateScreenData:
		
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Turn on update screen on next frame.
			LDA updateScreenData
			ORA #%0000100
			STA updateScreenData
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			RTS
		
	doRestoreScreenAttributes:
	
	
	RTS 
	

