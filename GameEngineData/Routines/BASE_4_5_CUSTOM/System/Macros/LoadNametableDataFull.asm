MACRO LoadNametableDataFull arg0, arg1, arg2, arg3
	;arg0 = bank
	;arg1 = screen
	;arg2 = map
	; arg 3, either 20 or 24...left or right nametable

	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	LDA arg2
	STA arg2_hold
	LDA arg3
	STA arg3_hold
	
	
	SwitchBank #$16
	
		LDY arg1 
	
		 LDA arg2
		AND #%00000001
		 BEQ loadFromMap1table_full
			;;;load from map 2 table
			LDA NameTablePointers_Map2_lo,y
			STA temp16
			LDA NameTablePointers_Map2_hi,y
			STA temp16+1
				LDA arg0_hold
				CLC
				ADC #$08
				STA arg0_hold
			JMP GotNametableLoadPointer_full
		loadFromMap1table_full:
			LDA NameTablePointers_Map1_lo,y
			STA temp16
			LDA NameTablePointers_Map1_hi,y
			STA temp16+1
		GotNametableLoadPointer_full:
			;;now (temp16) holds the address of the nametable to be loaded.
	ReturnBank
	
	
	JSR doLoadNametableDataFull

	ENDM