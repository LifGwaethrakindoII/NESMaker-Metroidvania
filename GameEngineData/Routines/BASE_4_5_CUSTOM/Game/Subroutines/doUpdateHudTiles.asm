doUpdateHudTiles:
	;;; prevent this from happening if there are any other updates that should have priority.
	;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
		LDA tempy
		STA temp1
		ASL
		ASL
		ASL
		ASL
		ASL
		CLC 
		ADC tempx
		STA temp3 ;; low byte

		
		LDA temp1
			LSR
			LSR
			LSR
		CLC
		ADC camFocus_tiles
		STA temp2 ;; high byte
	
	LDA #$00
	STA scrollOffsetCounter
	TAY
	doLoadUpdateHudQueueLoop:
			LDA temp2
			STA scrollUpdateRam,y
			INY
			LDA temp3
			STA scrollUpdateRam,y
			INY
			LDA #$E0
			STA scrollUpdateRam,y
			INY
			
		TYA
		STA maxScrollOffsetCounter
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Turn on update screen on next frame.
			LDA updateScreenData
			ORA #%0000100
			STA updateScreenData
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
	
	RTS