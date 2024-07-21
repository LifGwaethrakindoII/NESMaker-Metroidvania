doLoadChrRam:
	;;; this uses the LoadChrData macro
	SwitchBank tempBank
		bit $2002
		LDA arg1_hold
		STA $2006
		LDA arg2_hold
		STA $2006
	;arg3_hold holds the number of tiles to be drawn.
	LoadTilesOuterLoop
		LDA #$10
		STA temp1 ;; tile counter.
		LDY #$00
		LoadTilesLoop:
			LDX #$10
			LoadChrRamLoop:
				LDA (temp16),y
				STA $2007
				INY
				DEX
				BNE LoadChrRamLoop
				DEC temp1
				BNE keepLoading
				;;; now a full tile has been loaded.
			DEC arg3_hold
			BEQ doneLoadingTiles
				INC temp16+1
				JMP LoadTilesOuterLoop
			keepLoading:
				DEC arg3_hold
				BNE LoadTilesLoop
		doneLoadingTiles:
	ReturnBank
	RTS
	
