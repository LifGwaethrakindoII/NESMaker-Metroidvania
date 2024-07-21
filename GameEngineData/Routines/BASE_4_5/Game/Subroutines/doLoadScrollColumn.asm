doLoadScrollColumn:
	LDA scrollByte
	AND #%10000000
	BEQ notFactoringScroll
	RTS
notFactoringScroll:
	LDA updateScreenData
	AND #%00000100 
	BEQ checkIfRowIsUpdating
	;;; this column is in the middle of being updated
	;; so skip the update.
	RTS
checkIfRowIsUpdating:
	LDA scrollByte
	AND #%00100000
	BEQ doUpdateColumn
		RTS
doUpdateColumn:
	LDA scrollByte
	ORA #%11000000
	STA scrollByte
	LDA #$00
	STA scrollOffsetCounter
	TXA
	PHA
	;; right now, we need the column +18 
	;; for the seam in the opposite nametable.
	;; And we need to fetch the values into ram and trigger
	;; an NMI update.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; if we are moving right

			SwitchBank #$16
			
		;; make a determination if cam x is in the first 8 rows.
		;; if so, the screen to load should be one less than camX_hi
		LDA camY_hi
		ASL
		ASL
		ASL
		ASL
		CLC
		ADC camX_hi
		
		STA camScreen
		JMP gotCamScreen
		
		LDA camX
		CMP #$80
		BCC doLeftAlignedScroll
		
	
			LDA camY_hi
			ASL
			ASL
			ASL
			ASL
			CLC
			ADC camX_hi
			STA camScreen
			JMP gotCamScreen
		doLeftAlignedScroll:
			LDA scrollByte
			AND #%00000001
			BEQ movingLeftWithScrollForNametableChoice
					LDA camY_hi
					ASL
					ASL
					ASL
					ASL
					CLC
					ADC camX_hi
					STA camScreen
					JMP gotCamScreen
			movingLeftWithScrollForNametableChoice:
				LDA camY_hi
				ASL
				ASL
				ASL
				ASL
				CLC
				ADC camX_hi
				;sec
				;SBC #$01
				clc
				adc #$01
				STA camScreen
		gotCamScreen:
		LDA scrollByte
		AND #%00000001
		BNE updateScrollColumnToTheRight
		;;update scroll column to the left
	updateScrollColumnToTheLeft:
		LDA camX
		sec
		sbc #$78
		
		LDA camScreen
		SBC #$00
		STA tempA		
		;; figure which table to use...skip for now.
		TAY

		JMP loadFromMap1table
updateScrollColumnToTheRight:

		LDA camX
		CLC
		ADC #$78;#$70 ;#$80 ;; or #112 for the other side of the middle column?

		LDA camScreen
		ADC #$01
		STA tempA		
		;; figure which table to use...skip for now.
		TAY
		JMP loadFromMap1table;mult by 2 for table
		;LDA arg2
		;AND #%00000001
		;BEQ loadFromMap1table
			;;;load from map 2 table
			LDA NameTablePointers_Map2_lo,y
			STA temp16
			LDA NameTablePointers_Map2_hi,y
			STA temp16+1
			
			LDY tempA
			LDA AttributeTables_Map2_Lo,y
			STA pointer
			LDA AttributeTables_Map2_Hi,y
			STA pointer+1
			
			
			
			JMP GotNametableLoadPointer_forColumn
			
			
			
			
		loadFromMap1table:
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
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;; LOAD SECOND AND THIRD NAMETABLES
			
			
			LDA tempA
			CLC
			ADC #$10
			;;;;;;;;;;;;;;;;;;;
			;;;; find load bank

			LSR
			LSR
			LSR
			LSR
			LSR;; this is the bank
			STA bankHold
			
			
			LDA tempA
			CLC
			ADC #$10
			;;;;;;;;;;;;;;;;;;;;


			TAY
			LDA NameTablePointers_Map1_lo,y
			STA pointer2
			LDA NameTablePointers_Map1_hi,y
			STA pointer2+1
			
			LDA CollisionTables_Map1_Lo,y
			STA pointer7
			LDA CollisionTables_Map1_Hi,y
			STA pointer7+1


			LDA AttributeTables_Map1_Lo,y
			STA pointer3
			LDA AttributeTables_Map1_Hi,y
			STA pointer3+1
			
			
			
			
			
		GotNametableLoadPointer_forColumn:
			;;now (temp16) holds the address of the nametable to be loaded.
	ReturnBank
		LDA tempA ; nametable
		LSR
		LSR
		LSR
		LSR
		LSR
		STA temp ; bank
		
		SwitchBank temp
		
		LDA scrollByte
		AND #%00000001
		BNE getRightScrollColumnValues

		
		
		LDA camX
		sec
		sbc #$78
		LSR
		LSR
		LSR
		LSR
		STA tempy
		TAY
		ASL
		STA tempD
		
		LDA camY
		;AND #%00111111
		ASL
		ASL
		CLC
		ADC tempD
		STA tempD
		
		
		LDA camX
		sec
		sbc #$78
		LSR
		LSR
		LSR
		LSR
		STA temp
		
		LDA camY
		AND #%11110000
		CLC
		ADC temp
		TAY
		
		
		LDA camX
		SEC
		SBC #$78
		LDA camX_hi
		SBC #$01
		AND #%00000001
		BNE loadScrollColumnInLeftNT
		JMP loadScrollColumnInRightNT
		
	getRightScrollColumnValues:
		LDA camX
		clc
		adc #$70 ;#$80
		LSR
		LSR
		LSR
		LSR
		STA tempy
		TAY
		ASL
		STA tempD
		
		LDA camY
		;AND #%00111111
		ASL
		ASL
		CLC
		ADC tempD
		STA tempD
		
	
		LDA camX
		clc
		adc #$70 ;#$80
		LSR
		LSR
		LSR
		LSR
		STA temp
		
		LDA camY
		AND #%11110000
		CLC
		ADC temp
		TAY
		

		
		LDA camX
		CLC
		ADC #$70; #$80
		LDA camX_hi
		ADC #$00
		AND #%00000001
		BNE loadScrollColumnInLeftNT
		loadScrollColumnInRightNT:
			LDA #$27
			STA tempx ;; used for attributes
			LDA #$24
			JMP gotScrollColumnNT
		loadScrollColumnInLeftNT:
			LDA #$23
			STA tempx ;; used for attributes
			LDA #$20
		gotScrollColumnNT:
		STA updateNametable
		STA tempC
		
		LDA camY
		LSR
		LSR
		LSR
		LSR
		LSR
		LSR
		CLC
		ADC tempC
		STA tempC
		
	
		LDA #$0F
		STA tempA
		LDX #$00
		
		LDA camY
		LSR
		LSR
		LSR
		LSR
		STA tempz
	
		loop_LoadNametableMeta_column:
			TYA
			PHA
			LDA (temp16),y
			STA temp
			JSR doGetSingleMetaTileValues
			PLA
			TAY

				;; now updateTile_00-3 are the four courners of a metatile.
				;; respecting paths and "blank" tiles.
				;; If the current column is even, we want tile00 and 02.
				;; Otherwise, 01 and 03.
			LDA tempC
			STA scrollUpdateRam,x
			inx
			LDA tempD
			STA scrollUpdateRam,x
			inx
			LDA updateTile_00
			STA scrollUpdateRam,x
			inx
			
	
			LDA tempC
			STA scrollUpdateRam,x
			INX
			LDA tempD
			CLC
			ADC #$01
			STA tempD
			STA scrollUpdateRam,x
			LDA tempC
			ADC #$00
			STA tempC
			INX
			LDA updateTile_01
			STA scrollUpdateRam,x
			INX
			
			LDA tempC
			STA scrollUpdateRam,x
			INX
			LDA tempD
			CLC
			ADC #$1F
			STA tempD
			STA scrollUpdateRam,x
			LDA tempC
			ADC #$00
			STA tempC
			INX
			LDA updateTile_02
			STA scrollUpdateRam,x
			INX
			
			LDA tempC
			STA scrollUpdateRam,x
			INX
			LDA tempD
			CLC
			ADC #$01
			STA tempD
			STA scrollUpdateRam,x
			LDA tempC
			ADC #$00
			STA tempC
			INX
			LDA updateTile_03
			STA scrollUpdateRam,x
			INX
			
			
			
			LDA tempD
			CLC
			ADC #$1F
			STA tempD
			
			LDA tempC
			ADC #$00
			STA tempC
			
			TYA
			CLC
			ADC #$10
			TAY

			INC tempz
			LDA tempz
			CMP #$0f
			BNE didNotWrapVforColumnLoad
			
				TYA
				PHA
				LDY bankHold
				JSR doBankswitchY
				PLA
				TAY
				;JMP gotValuesLoaded
					;TYA
					;AND #%00001111
					;TAY
				
					
						LDA pointer2
						STA temp16
						LDA pointer2+1
						STA temp16+1
				
					LDA updateNametable
					STA tempC
						LDA scrollByte
						AND #%00000001
						BEQ doLeftResetScrollColumn
							LDA camX
							clc
							adc #$70
							JMP gotResetScrollColumn
						doLeftResetScrollColumn:
							LDA camX
							SEC
							SBC #$78
						gotResetScrollColumn:
						LSR
						LSR
						LSR
						;LSR
						;STA tempy
						;TAY
						;ASL
						STA tempD
				
					
						TYA
						AND #%00001111
						TAY
					
					LDA #$00
					STA tempz
			
			didNotWrapVforColumnLoad:
	
			DEC tempA
			LDA tempA
			BEQ gotValuesLoaded
			JMP loop_LoadNametableMeta_column
			
			
		gotValuesLoaded:
		
		LDA currentNametable
		LSR
		LSR
		LSR
		LSR
		LSR
		STA temp ; bank
		
		SwitchBank temp
		
			;; tempx should be the value of the attribute table.
			LDA camY
			AND #%11100000
				LSR
				LSR
				
				;LSR
				;LSR
				;LSR
					;ASL
					;ASL
					;ASL
				
				STA temp
		
			LDA camX
				clc
				adc #$78
				LSR
				LSR
				LSR
				LSR
				LSR

			
				CLC
				ADC temp

			STA tempy
		;	LDA #$00
			TAY
			
			LDA camY
			LSR
			LSR
			LSR
			LSR
			LSR
			STA tempz
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Now attributes.
			LDA #$08
			STA tempA ;; to loop through attributes
			doLoadScrollColumnAttributesLoop:
			;;; this will update the entire attribute.
				LDA tempx
				STA scrollUpdateRam,x
				INX
				LDA #$C0 
				CLC
				ADC tempy
				STA scrollUpdateRam,x
				INX
				LDA (pointer),y
			
				STA scrollUpdateRam,x
				INX
				LDA tempy
				clc
				ADC #$08
				STA tempy
				TYA
				CLC
				ADC #$08
				TAY
				
				INC tempz
				LDA tempz
				CMP #$08
				BNE notAtBottomAttributeRow
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;;; at bottom of attribute row.
					LDA #$00
					STA tempz
					LDA pointer3
					STA pointer
					LDA pointer3+1
					STA pointer+1
					LDA camX
					clc
					adc #$78
					LSR
					LSR
					LSR
					LSR
					LSR
					STA tempy
					TAY ;; no factoring y because will start at the top.
					
					
					
						
				notAtBottomAttributeRow:
	
				DEC tempA
				LDA tempA
				BNE doLoadScrollColumnAttributesLoop
			; ;; done with loading attributes	
			DoneLoadingAttributesForColumn:
			LDA #$00
			STA scrollOffsetCounter
			
			;LDA #180
			TXA
			STA maxScrollOffsetCounter
		
			LDA updateScreenData
			ORA #%0000100
			STA updateScreenData
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		; NOW LOAD COLLISION COLUMN.
		
		LDA currentNametable
		LSR
		LSR
		LSR
		LSR
		LSR
		STA temp ; bank
		
		SwitchBank temp
		
		LDA #$0F
		STA tempB ;; how tall is the column in tiles.
		
		LDA scrollByte
		AND #%00000001
		BNE doRightUpdateColCol
		;;; do left update collision column.
			LDA camX
		sec
		sbc #$78; #$80
		LSR
		LSR
		LSR
		LSR
		TAX
		LSR
		TAY
		
		doLoadColColLoopL
			LDA (pointer6),y
			STA tempA
			TXA
			AND #%00000001
			BNE doOddL
				;; do even
				LDA tempA
				LSR
				LSR
				LSR
				LSR
				STA tempA
				JMP gotchaL
			doOddL
				LDA tempA
				AND #%00001111
				STA tempA
			gotchaL:
			LDA updateNametable
			CMP #$20
			BEQ do20L
				LDA tempA
				STA collisionTable2,x
				JMP donethingL
			do20L
				LDA tempA
				STA collisionTable,x
			donethingL:
			TYA
			CLC
			ADC #$08
			TAY
			TXA
			CLC
			ADC #$10
			TAX
			DEC tempB
			LDA tempB
			BNE doLoadColColLoopL
		
		JMP doneWithLoadingCOllisions2
		
		
	doRightUpdateColCol:
			
		LDA camX
		CLC
		ADC #$70; #$80
		LSR
		LSR
		LSR
		LSR
		TAX
		LSR
		TAY
		
		doLoadColColLoop
			LDA (pointer6),y
			STA tempA
			TXA
			AND #%00000001
			BNE doOdd
				;; do even
				LDA tempA
				LSR
				LSR
				LSR
				LSR
				STA tempA
				JMP gotcha
			doOdd
				LDA tempA
				AND #%00001111
				STA tempA
			gotcha:
			LDA updateNametable
			CMP #$20
			BEQ do20
				LDA tempA
				STA collisionTable2,x
				JMP donething
			do20
				LDA tempA
				STA collisionTable,x
			donething:
			TYA
			CLC
			ADC #$08
			TAY
			TXA
			CLC
			ADC #$10
			TAX
			DEC tempB
			LDA tempB
			BNE doLoadColColLoop
			
		
	
		
	
		doneWithLoadingCOllisions2:
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		ReturnBank
		
	;;;;;;;;;;;;;;;;;;
	;; here we can take care of monsters in this column.
	;; First, destroy what might be there in a loop
;;;;;;;;;;;;;;;;;;;;;;	

;;; use temp16 to check for cam clips
	LDA camX
	SEC
	SBC #$80
	STA temp16 ;; low left cam clip
	LDA camX_hi
	AND #%00001111
	SBC #$00
	STA temp16+1 ;; high left cam clip
	
	LDA camX
	CLC
	ADC #$80
	STA pointer ;; low right cam clip
	LDA camX_hi
	AND #%00001111
	ADC #$01
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

	PLA
	TAX
	RTS