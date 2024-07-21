coordinatesToMetaNametableValue:
	;;; Let's use this as essentially a tile space to nametable translation.
	;; tileX is a value 0-15, tileY is a value 0-15
	LDA tileY
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL 
	STA temp
	LDA tileX
	ASL
	;STA updateNT_tableLeft
	AND #%00011110
	CLC
	ADC temp
	STA temp16
	LDA tileY
	LSR
	LSR
	CLC
	ADC camFocus_tiles
	STA temp16+1
	RTS
	
	
	
	
	
coordinatesToNametableValue:
	;;; Let's use this as essentially a tile space to nametable translation on 8x8 grid.
	;; tileX is a value 0-32, tileY is a value 0-30
	LDA tileY
	LSR
	LSR
	LSR
	STA temp1
	
	LDA tileY 
	ASL
	ASL
	ASL
	ASL
	ASL ;; now this represents 1 row for each value in tileY
	STA temp
	LDA tileX
	clc
	ADC temp
	STA temp16
	LDA camFocus_tiles
	CLC
	ADC temp1
	STA temp16+1
	RTS
	
	
	LDA tileY
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL 
	ASL
	STA temp
	LDA tileX
	ASL
	ASL
	;STA updateNT_tableLeft
	AND #%00011111
	CLC
	ADC temp
	STA temp16
	LDA tileY
	LSR
	LSR
	LSR
	CLC
	ADC camFocus_tiles
	STA temp16+1
	RTS
	
		
	


	
GetTileAtPosition:
	LDA tileY				
	AND #%11110000				
	STA tempz				
	LDA tileX			
	LSR A
	LSR A
	LSR A
	LSR A
	ORA tempz
	TAY							; stores it into Y, which will be important in checking collision.
	RTS
	
	
GetAttributePosition:
	LDA tileY
	LSR
	
	asl
	asl
	asl ;; each y = one full row of offset...8 values.
	STA tempz
	LDA tileX
	LSR
	clc
	adc tempz
	CLC
	ADC #$c0 ;; because attributes start at 23"co"
	;
	RTS
	
	

	
FindFreeObjectSlot:
	LDX #$00
	doFindSlotLoop:
		LDA Object_status,x
		AND #%11000001
		BEQ thisObjectSlotIsFree
		INX
		CPX #TOTAL_MAX_OBJECTS
		BNE doFindSlotLoop
		LDX #$FF
	thisObjectSlotIsFree:
	RTS
	
	
MonsterBankValues: 
	;; by default, there are two.
	.db #$13, #$14
	
StringDataChoice:
	.db #154, #155, #156, #157  ;; day, night, day trig, night trig
	
Mon1SpawnLocation:
	.db #131, #134, #137, #140
Mon2SpawnLocation:
	.db #132, #135, #138, #141
Mon3SpawnLocation:
	.db #133, #136, #139, #142
Mon4SpawnLocation:
	.db #158, #159, #160, #161
MonGroupChoice:
	.db #143, #144, #145, #121 ;; day, night, dayT, nightT
MonPal1Choice:
	.db #146, #147, #148, #123 ;; day, night, dayT, nightT
MonPal2Choice:	
	.db #149, #150, #151, #129
	
GoPal1Choice:
	.db #203, #204, #205, #206
GoPal2Choice:
	.db #183, #184, #185, #186

	
Monster1ID:
	.db #162, #170, #166, #174
Monster2ID:
	.db #163, #171, #167, #175
Monster3ID:
	.db #164, #172, #168, #176
Monster4ID:
	.db #165, #173, #169, #177
	
MonsterPlacementType:
	.db #183,#184, #185, 186
	


	

getPointColTable:
	BCC +stayInSameColTable
		;; check opposite col table
		LDA Object_screen,x
		AND #%00000001
		BNE +stayInLeftTable
			LDA #$01
			sTA tempA
			JMP +gotColTable
		+stayInLeftTable
			LDA #$00
			STA tempA
			JMP +gotColTable
	+stayInSameColTable:
		LDA Object_screen,x
		AND #%00000001
		BEQ +stayInLeftTable
			LDA #$01
			sTA tempA
			JMP +gotColTable
		+stayInLeftTable
			LDA #$00
			STA tempA
			JMP +gotColTable
	+gotColTable
	RTS
	
	
	
	
	
	
	
LoadMonster_1:	
		LDY Mon1SpawnLocation,x
		LDA (collisionPointer),y
		STA temp
		AND #%11110000
		CMP #%11110000
		BNE loadMon1toPosition
			LDA temp
			AND #%00001111
			CMP #%00000011
			BEQ skipLoadingMonster1
			;;; Random / Edge cases here
			
		loadMon1toPosition:
			;;;;;;; Load monster 1.
			LDY Monster1ID,x
			LDA (collisionPointer),y
			STA mon1_type
			LDY Mon1SpawnLocation,x
			LDA (collisionPointer),y
				ASL
				ASL
				ASL
				ASL
				STA tempB ;; x value in tempB
			LDY Mon1SpawnLocation,x
			LDA (collisionPointer),y
				AND #%11110000
				STA tempC ;; y value in tempC
				TXA
				PHA
			CreateObject tempB, tempC, mon1_type, #$00
			LDA #$00
				STA Object_id,x
				PLA
				TAX
		skipLoadingMonster1:
		RTS