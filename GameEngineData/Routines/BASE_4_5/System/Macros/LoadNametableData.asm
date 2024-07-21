MACRO LoadNametableData arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7
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
	
	
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	LDA arg2
	STA arg2_hold
	LDA arg3
	STA arg3_hold
	LDA arg4
	STA arg4_hold
	LDA arg5
	STA arg5_hold
	LDA arg6
	STA arg6_hold
	LDA arg7
	STA arg7_hold

	
	SwitchBank #$16
	
		LDY arg1 
	
		 LDA arg2
		AND #%00000001
		 BEQ loadFromMap1table
			;;;load from map 2 table
			LDA NameTablePointers_Map2_lo,y
			STA temp16
			LDA NameTablePointers_Map2_hi,y
			STA temp16+1
			LDA arg0_hold
			CLC
			ADC #$08
			STA arg0_hold
			JMP GotNametableLoadPointer
		loadFromMap1table:
			LDA NameTablePointers_Map1_lo,y
			STA temp16
			LDA NameTablePointers_Map1_hi,y
			STA temp16+1
		GotNametableLoadPointer:
			;;now (temp16) holds the address of the nametable to be loaded.
	ReturnBank
	
	
	JSR doLoadNametableData
	

	ENDM