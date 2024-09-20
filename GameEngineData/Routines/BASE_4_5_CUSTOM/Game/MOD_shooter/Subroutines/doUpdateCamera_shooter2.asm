
doUpdateCamera:	
	
	LDA gameHandler
	AND #%10000000 ;;; this will skip object handling.
	BEQ +dontSkipCamHandling
		RTS
dontSkipCamHandling:

	LDA scrollByte
	ORA #%11000000 
	STA scrollByte
	
	LDA #$00
	STA tempA
	LDA #$01
	STA tempB
	
	LDA camX
	AND #%11110000
	STA tempz

	LDA scrollByte
	AND #%10100010
	BNE +scrollEngaged
		JMP skipScrollUpdate
+scrollEngaged:

	LDA scrollByte
	AND #%10000000
	BNE doHorizontalCameraUpdate
		JMP noHorizontalCameraUpdate
	doHorizontalCameraUpdate:

	LDA scrollByte
	AND #%01000000
	BNE doRightCameraUpdate
		
		; ;; is left camera update
		; LDA camX_lo
		; sec
		; sbc tempA
		; STA camX_lo
		; LDA camX
		; sbc tempB
		; STA temp
			; BCS +skipCheckForScrollScreenEdge
				; LDA ScreenFlags00
				; AND #%00100000
				; BEQ +skipCheckForScrollScreenEdge
					; JMP noHorizontalCameraUpdate
		; +skipCheckForScrollScreenEdge
		; LDA temp
		; STA camX
		
		; LDA camX_hi
		; sbc #$00
		; STA camX_hi
		; JSR getCamSeam
		; JMP noHorizontalCameraUpdate
	doRightCameraUpdate
		LDA ScreenFlags00
		AND #%00010000 
		BEQ +doNormalScreenUpdate	
			JMP +noHorizontalCameraUpdate
		+doNormalScreenUpdate
		LDA camX_lo
		clc
		adc tempA
		;STA camX_lo
		LDA camX
		adc tempB
		;STA temp
	
		BCS +dontSkipCheckForScrollScreenEdge
			JMP +skipCheckForScrollScreenEdge
		+dontSkipCheckForScrollScreenEdge
		
			;; here we have cross the screen boundary
		;;; so if there is anything that needs updating for scrolling
		;;; update it here.
			
					SwitchBank #$16
						LDA camScreen
						CLC
						ADC #$01
						TAY
						LDA CollisionTables_Map1_Lo,y
						STA temp16
						LDA CollisionTables_Map1_Hi,y
						STA temp16+1
					ReturnBank
					LDA camScreen
					CLC
					ADC #$01
					LSR
					LSR
					LSR
					LSR
					LSR
					STA temp ; bank
					SwitchBank temp
						LDY #124
						LDA (temp16),y
						STA ScreenFlags00
						
						ReturnBank
						
						CountObjects #%00001000
						BNE +dontTurnOffMonsterChecker
							
							
							;; turn off monster checker.
							;; because you already killed the monsters
							;; before getting lined up to the screen.
							
							;; unless it is a boss screen
							LDA ScreenFlags00
							AND #%00001000 ;; is it a boss flag?
							BNE +dontTurnOffMonsterChecker
							LDA ScreenFlags00
							AND #%11101111
							STA ScreenFlags00
						+dontTurnOffMonsterChecker
						
					LDA ScreenFlags00
					AND #%00010000
					BNE noHorizontalCameraUpdate
		+skipCheckForScrollScreenEdge
		
		
		; LDA temp
		; STA camX
		; LDA camX_hi
		; adc #$00
		; STA camX_hi
		
		LDA camX_lo
		clc
		adc tempA
		STA camX_lo
		LDA camX
		adc tempB
		STA camX
		LDA camX_hi
		ADC #$00
		STA camX_hi
		JSR getCamSeam
	noHorizontalCameraUpdate:


		
+skipSettingScreenFlag

	
	LDA scrollByte
	AND #%00000001
	BEQ +canUpdateScrollColumn
		JMP skipScrollUpdate
+canUpdateScrollColumn
	LDA scrollByte
	AND #%00000010
	BNE forceScrollColumnUpdate
	LDA camX
	AND #%11110000
	CMP tempz
	BNE +canUpdateScrollColumn2
		JMP skipScrollUpdate
forceScrollColumnUpdate:
	LDA scrollByte
	AND #%11111101
	STA scrollByte
+canUpdateScrollColumn2

		LDA scrollByte
		ORA #%00000101
		STA scrollByte
		;;;;;;;;;; DO SCROLL UPDATE.
		SwitchBank #$16
			LDY scrollUpdateScreen
			LDA NameTablePointers_Map1_lo,y
			STA temp16
			LDA NameTablePointers_Map1_hi,y
			STA temp16+1
			

			LDA AttributeTables_Map1_Lo,y
			STA pointer
			LDA AttributeTables_Map1_Hi,y
			STA pointer+1
			
			
			LDA CollisionTables_Map1_Lo,y
			STA pointer6
			LDA CollisionTables_Map1_Hi,y
			STA pointer6+1
		ReturnBank
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;; now we have pointers for the fetch.
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;; We can read from the pointers to get metatile data.
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;; jump to the bank
		LDA scrollUpdateScreen	
		LSR
		LSR
		LSR
		LSR
		LSR
		STA temp ; bank
		
		SwitchBank temp
			; LDX screenState
			; LDY Mon1SpawnLocation,x
			; LDA (pointer6),y
			; STA scrollUpdateObjectLocation
			
			; LDY Mon2SpawnLocation,x
			; LDA (pointer6),y
			; STA scrollUpdateObjectLocation+1
			
			; LDY Mon3SpawnLocation,x
			; LDA (pointer6),y
			; STA scrollUpdateObjectLocation+2
			
			; LDY Mon4SpawnLocation,x
			; LDA (pointer6),y
			; STA scrollUpdateObjectLocation+3
			
			LDX screenState
			LDY Mon1SpawnLocation,x
			LDA Monster1ID,x
			STA tempD
			JSR checkSeamForMonsterPosition
			
			LDX screenState
			LDY Mon2SpawnLocation,x
			LDA Monster2ID,x
			STA tempD
			JSR checkSeamForMonsterPosition
			
			LDX screenState
			LDY Mon3SpawnLocation,x
			LDA Monster3ID,x
			STA tempD
			JSR checkSeamForMonsterPosition
			
			LDX screenState
			LDY Mon4SpawnLocation,x
			LDA Monster4ID,x
			STA tempD
			JSR checkSeamForMonsterPosition
			
			
		
		
			LDA scrollUpdateScreen
			AND #%00000001
			ASL
			ASL
			ORA #%00100000
			STA temp1 ;; temp 1 now represents the high byte of the address to place 
			
			LDA scrollUpdateColumn
			LSR
			LSR
			LSR
			AND #%00011111
			STA temp2 ;; temp 2 now represents the low byte of the pushes.
			
			LDA scrollUpdateColumn
			LSR
			LSR
			LSR
			LSR
			STA temp3
			
			LDA #$00
			STA scrollOffsetCounter			
					
			LDX #$00 ;; will keep track of scroll update ram.
			LDA #$0F
			STA tempA ;; will keep the track of how many tiles to draw.
					;; #$0f is an entire column.
			loop_LoadNametableMeta_column:
				LDY temp3
				LDA (temp16),y
				STA temp
				JSR doGetSingleMetaTileValues
				
				LDA temp1
				STA scrollUpdateRam,x
				INX
				LDA temp2
				STA scrollUpdateRam,x
				INX
				LDA updateTile_00
				STA scrollUpdateRam,x
				INX 
				
				LDA temp1
				STA scrollUpdateRam,x
				INX
				LDA temp2
				CLC
				ADC #$01
				STA scrollUpdateRam,x
				INX
				LDA updateTile_01
				STA scrollUpdateRam,x
				INX 
				
				LDA temp1
				STA scrollUpdateRam,x
				INX
				LDA temp2
				CLC
				ADC #$20
				STA scrollUpdateRam,x
				INX
				LDA updateTile_02
				STA scrollUpdateRam,x
				INX 
				
				LDA temp1
				STA scrollUpdateRam,x
				INX
				LDA temp2
				CLC
				ADC #$21
				STA scrollUpdateRam,x
				INX
				LDA updateTile_03
				STA scrollUpdateRam,x
				INX 
				
				DEC tempA
				LDA tempA
				BEQ +doneWithNtLoad
					;; not done with NT load.  Need more tiles.
					;;;;;;;;;;;;;;;;;;;;;;;;;;
					;; update the 16 bit position of the new place to push tiles to.
					LDA temp2
					CLC
					ADC #$40
					STA temp2
					LDA temp1
					ADC #$00
					STA temp1
					;; update the tile read location.
					LDA temp3
					CLC
					ADC #$10
					STA temp3
					JMP loop_LoadNametableMeta_column	
			+doneWithNtLoad
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;; add attributes to the update list.
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;; 23 = 00100011
		;;;; 27 = 00100111
		;;;; so the last bit of scrollUpdateScreen and shift it twice to the left
		;;;; then or it with 00100000 to get the high byte of the attribute update table.
				LDA scrollUpdateScreen
				AND #%00000001
				ASL
				ASL
				;ASL
				ORA #%00100011
				STA temp1 ;; this is now the high byte of the attribute table update
				
				LDA scrollUpdateColumn
				LSR
				LSR
				LSR
				LSR
				LSR
	
				STA temp2 ;; temp 2 now represents the low byte of the pushes.
				;; don't need a temp3 to keep track of pull position, because it will be 1 to 1.
				
				LDA #$08
				STA tempA ;; will keep the track of how many tiles to draw.
					;; #$0f is an entire column.
				loop_LoadAttribute_column:
			
					LDY temp2
					LDA (pointer),y
					STA temp
					
					LDA temp1
					STA scrollUpdateRam,x
					INX
					LDA temp2
					CLC
					ADC #$c0
					STA scrollUpdateRam,x
					INX
					LDA temp
					STA scrollUpdateRam,x
					INX 
					DEC tempA
					LDA tempA
					BEQ +doneWithAtLoad
						LDA temp2
						CLC
						ADC #$08
						STA temp2
						JMP loop_LoadAttribute_column
					+doneWithAtLoad
					
					
				TXA
				STA maxScrollOffsetCounter

				LDA updateScreenData
				ORA #%00000100
				STA updateScreenData

		
				LDA scrollUpdateColumn
				LSR
				LSR
				LSR
				LSR 
				STA temp1 ;; keeps track of where to place on the collision table.
				LSR 
				STA temp2 ;; keeps track of the nubble being pulled from.
				LDX #$0F ;; keep track of how many values to load are left.
			
				LDA scrollUpdateScreen
				AND #%00000001
				BNE +doUpdateOddCt
					;; do update even CT
					;; to ct table 1
					doUpdateCtLoop
						LDA temp1
						AND #%00000001
						BNE +oddCol
							LDY temp2
							LDA (pointer6),y
							LSR
							LSR
							LSR
							LSR
							JMP +pushToCol
						+oddCol
							LDY temp2	
							LDA (pointer6),y
							AND #%00001111
						
						+pushToCol:
							LDY temp1
							STA collisionTable,y
							LDA temp1
							CLC
							ADC #$10
							STA temp1
							LDA temp2
							CLC
							ADC #$08
							STA temp2
							DEX
							BNE doUpdateCtLoop
							JMP +doneWithCtLoad
				+doUpdateOddCt
					;; do update odd ct
					;; to ct table 2
					doUpdateCtLoop2
						LDA temp1
						AND #%00000001
						BNE +oddCol
							LDY temp2
							LDA (pointer6),y
							LSR
							LSR
							LSR
							LSR
							JMP +pushToCol
						+oddCol
							LDY temp2	
							LDA (pointer6),y
							AND #%00001111
						
						+pushToCol:
							LDY temp1
							STA collisionTable2,y
							LDA temp1
							CLC
							ADC #$10
							STA temp1
							LDA temp2
							CLC
							ADC #$08
							STA temp2
							DEX
							BNE doUpdateCtLoop2
							JMP +doneWithCtLoad
				+doneWithCtLoad

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		ReturnBank
		

skipScrollUpdate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Make sure we always update camScreen.
	LDA camY_hi
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC camX_hi
	STA camScreen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;JSR checkForMonsterCameraClipping
	
	RTS
	
	
	
getCamSeam:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Since we use camScreen in this subroutine, we'll have to make sure it's properly updated
;;; before get our column and screen.
	LDA camY_hi
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC camX_hi
	STA camScreen
	
	LDA scrollByte
	AND #%01000000
	BNE +getRightScrollUpdate
		;; get left scroll update
		LDA camX
		AND #%11110000
		sec
		sbc #$70
		STA scrollUpdateColumn
		LDA camScreen
		sbc #$00
		STA scrollUpdateScreen

	RTS
	+getRightScrollUpdate

		LDA camX
		AND #%11110000
		CLC
		ADC #$80
		STA scrollUpdateColumn
		LDA camScreen
		ADC #$01
		STA scrollUpdateScreen

	RTS
	
	
	
checkForMonsterCameraClipping:

RTS
;;; use temp16 to check for cam clips
	LDA camX_hi
	AND #%00001111
	BNE notOnZeroScreen
	LDA #$00
	STA temp16
	LDA camX_hi
	STA temp16+1
	JMP +gotIt
notOnZeroScreen:
	;;; For this type of game, anything that reaches the left seam should be destroyed.
	LDA camX
	; SEC
	; SBC #$80
	STA temp16 ;; low left cam clip
	LDA camX_hi
	;AND #%00001111
	; SBC #$00
	AND #%00001111
	STA temp16+1 ;; high left cam clip
+gotIt:	
	LDA camX
	CLC
	ADC #$90
	STA pointer ;; low right cam clip
	LDA camX_hi
	
	ADC #$01
	AND #%00001111
	STA pointer+1 ;; high right cam clip

	LDX #$00
	skipCheckingThisObject_forEraseColumnLoop
		cpx player1_object
		BEQ doEraseNonPlayerObjectsInThisColumnLoop
			LDA Object_status,x
			AND #%10000000
			BEQ doEraseNonPlayerObjectsInThisColumnLoop
			;; check this monster's position
			LDA Object_x_hi,x
			STA temp
			LDA Object_screen,x
			AND #%00001111
			STA temp1
			Compare16 temp16+1, temp16, temp1, temp
			+	
				DestroyObject
				
		
				JMP doEraseNonPlayerObjectsInThisColumnLoop
			++
		;; skip erasing from rightmost column.
		skipCheckingThisObject_forEraseColumnLoop2:
			Compare16 pointer+1, pointer, temp1, temp
			+
				JMP doEraseNonPlayerObjectsInThisColumnLoop
			++
				DestroyObject
		
			doEraseNonPlayerObjectsInThisColumnLoop
				INX
				CPX #TOTAL_MAX_OBJECTS
				BNE skipCheckingThisObject_forEraseColumnLoop

	RTS
	
checkSeamForMonsterPosition:
	;; y is loaded before subroutine.
			LDA (pointer6),y
			STA temp
			ASL
			ASL
			ASL
			ASL
			STA temp2
			LDA scrollUpdateColumn
			AND #%11110000
			CMP temp2
			BNE +noMonsterToLoadInThisColumn
				LDA temp
				AND #%11110000
				STA temp1
				CMP #%11110000
				BEQ +noMonsterToLoadInThisColumn
					LDY tempD
					LDA (pointer6),y
					STA tempD
					CreateObjectOnScreen temp2, temp1, tempD, #$00, scrollUpdateScreen
			+noMonsterToLoadInThisColumn:
	RTS
	