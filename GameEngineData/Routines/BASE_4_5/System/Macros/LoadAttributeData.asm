MACRO LoadAttributeData arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7
	;arg0 = screen bank
	;arg1 = screen index
	;arg2 = load screen bits
		;;; bit 0 = overworld (0) underworld (1)
		;;; bit 1 = metaTable (0) 8x8 table (1)
	;arg3 = columns to load
	;arg4 = rows to load
	;arg5 = start position hi
	;arg6 = start position lo
	;arg7 = start column
	
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
		BEQ loadAttFromMap1table
			;;;load from map 2 table
			LDA AttributeTables_Map2_Lo,y
			STA temp16
			LDA AttributeTables_Map2_Hi,y
			STA temp16+1
				LDA arg0_hold
				CLC
				ADC #$08
				STA arg0_hold
			JMP GotAttLoadPointer
		loadAttFromMap1table:
			LDA AttributeTables_Map1_Lo,y
			STA temp16
			LDA AttributeTables_Map1_Hi,y
			STA temp16+1
		GotAttLoadPointer:
			;;now (temp16) holds the address of the nametable to be loaded.
	ReturnBank
	
	
	JSR doLoadAttributeData
	

	ENDM