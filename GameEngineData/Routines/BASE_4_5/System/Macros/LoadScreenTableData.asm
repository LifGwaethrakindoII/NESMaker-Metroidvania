MACRO LoadScreenTableData arg0, arg1, arg2

	; arg0 = bank
	; arg1 = screen
		;arg2 = load screen bits
		;;; bit 0 = overworld (0) underworld (1)
		;;; bit 1 = metaTable (0) 8x8 table (1)
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	
		SwitchBank #$16
	
		LDY arg1 
		 ;mult by 2 for table
		LDA arg2
		AND #%00000001
		BEQ loadFromMap1table_ScreenData
			;;;load from map 2 table
			LDA CollisionTables_Map2_Lo,y
			STA collisionPointer
			LDA CollisionTables_Map2_Hi,y
			STA collisionPointer+1
				LDA arg0_hold
				CLC
				ADC #$08
				STA arg0_hold
			JMP GotColTablePointer_ScreenData
		loadFromMap1table_ScreenData:
			LDA CollisionTables_Map1_Lo,y
			STA collisionPointer
			LDA CollisionTables_Map1_Hi,y
			STA collisionPointer+1
		GotColTablePointer_ScreenData:
			;;now (collisionPointer) holds the address of the nametable to be loaded.
	ReturnBank
	
	
	JSR doLoadScreenData
	
	ENDM