doUpdateHudVarTiles:
	;;; prevent this from happening if there are any other updates that should have priority.
	;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; tempA holds max container number.
	;; tempB hold "full" containers.
	;; tempC holds blank image value
	;; tempD holds full image value
	
		LDA tempy
			ASL
			ASL
			ASL
			ASL
			ASL
			CLC 
			ADC tempx
			STA temp2

			
		LDA temp1
			LSR
			LSR
			LSR
			CLC
			ADC camFocus_tiles
		STA temp3
	
	LDA #$00
	STA scrollOffsetCounter
	STA temp1
	TAY
	
	
	doLoadUpdateHudVarQueueLoop:
			LDA temp1 ;; offset
			CMP tempB ;; full value
			BCC drawFullValue
				;; draw container value
				LDA tempC
				JMP gotDrawValue
			drawFullValue
				LDA tempD
			gotDrawValue
				STA tempz
			LDA temp3
			STA scrollUpdateRam,y
			INY
			LDA temp2
			CLC
			ADC temp1
			STA scrollUpdateRam,y
			INY
			LDA tempz
			STA scrollUpdateRam,y
			INY
			INC temp1
			LDA temp1
			CMP tempA
			BNE doLoadUpdateHudVarQueueLoop
			
	
			
		
		TYA
		STA maxScrollOffsetCounter
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Turn on update screen on next frame.
			LDA updateScreenData
			ORA #%0000100
			STA updateScreenData
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
	
	RTS