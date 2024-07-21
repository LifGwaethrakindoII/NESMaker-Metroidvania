doLoadScreen2:
		LDA currentNametable
		AND #%00000001
		BEQ secondNametableIsIn24
			LDA #$20
			STA tempx
			LDA #$23
			STA tempy
			JMP gotSecondNtStart
		secondNametableIsIn24
		
			LDA #$24
			STA tempx
			LDA #$27
			STA tempy
		gotSecondNtStart:


		LDA currentNametable
		LSR
		LSR
		LSR
		LSR
		LSR
		STA temp ;; this is the screen bank.
		
		LDA currentNametable
		CLC
		ADC #$01
		STA temp1
		LSR
		LSR
		LSR
		LSR
		LSR
		STA temp ;; this is the screen bank.
	LDA warpMap
			;;; and other screen bytes needed - warp map is either 0 or 1
			STA temp2
			
		LoadNametableData temp, temp1, temp2, #$08, #$0F, tempx, #$00, #$00
			JSR doWaitFrame
		LDA currentNametable
		LSR
		LSR
		LSR
		LSR
		LSR
		STA temp ;; this is the screen bank.
			LDA warpMap
			;;; and other screen bytes needed - warp map is either 0 or 1
			STA temp2
			
		LoadAttributeData temp, temp1, temp2, #$04, #$08, tempy, #$C0, #$00
			JSR doWaitFrame



		LDA currentNametable
		sec
		sbc #$01
		STA temp1
		LSR
		LSR
		LSR
		LSR
		LSR
		STA temp ;; this is the screen bank.
			LDA warpMap
			;;; and other screen bytes needed - warp map is either 0 or 1
			STA temp2
			
		LoadNametableData temp, temp1, temp2, #$08, #$0F, tempx, #$10, #$08
			JSR doWaitFrame
		LDA currentNametable
		sec
		sbc #$01
		STA temp1
		LSR
		LSR
		LSR
		LSR
		LSR
		STA temp ;; this is the screen bank.
			LDA warpMap
			;;; and other screen bytes needed - warp map is either 0 or 1
			STA temp2
			
		LoadAttributeData temp, temp1, temp2, #$04, #$08, tempy, #$C4, #$04
			JSR doWaitFrame
	
		LDA currentNametable
		 CLC
		 ADC #$01
		 STA temp1
		 LSR
		 LSR
		 LSR
		 LSR
		 LSR
		 STA temp ;; this is the screen bank.
			LDA warpMap
			;;; and other screen bytes needed - warp map is either 0 or 1
			STA temp2
					 
		LoadCollisionData temp, temp1, temp2, #$08, #$0F, #$00, #$00, #$01
			 JSR doWaitFrame
	
		LDA currentNametable
		 sec
		 sbc #$01
		 STA temp1
		 LSR
		 LSR
		 LSR
		 LSR
		 LSR
		 STA temp ;; this is the screen bank.
			LDA warpMap
			;;; and other screen bytes needed - warp map is either 0 or 1
			STA temp2
					 
		LoadCollisionData temp, temp1, temp2, #$08, #$0F, #$00, #$08, #$01
			 JSR doWaitFrame
	
		
	
	RTS
	
	
monsterPositionOffsetTable: ;; normal state monster.
	.db #131, #132, #133, #158