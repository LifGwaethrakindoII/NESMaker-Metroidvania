doUpdateHudNumber:
	;;; prevent this from happening if there are any other updates that should have priority.
	;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 
	;; 
	;; 
	;; 
	
		LDA tempy
			ASL
			ASL
			ASL
			ASL
			ASL
			CLC 
			ADC tempx
			CLC
			ADC tempA ;; the width
						;;; so that as it draws places backwards
						;;; it ends at the proper x,y
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
	
	
	doLoadUpdateHudNumberQueueLoop:
			;LDA temp1 ;; offset
			LDA temp3
			STA scrollUpdateRam,y
			INY
			LDA temp2
			CLC
			ADC tempA
			STA scrollUpdateRam,y
			INY
			TYA
			PHA
				LDY temp1
				LDA (pointer),y
				CLC
				ADC #HUD_OFFSET
				CLC
				ADC #$10 ;; numbers
				STA temp
			PLA
			TAY
			LDA temp
			STA scrollUpdateRam,y
			INY
			INC temp1
			DEC tempA
			BNE doLoadUpdateHudNumberQueueLoop
			
	
			
		
		TYA
		STA maxScrollOffsetCounter
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Turn on update screen on next frame.
			LDA updateScreenData
			ORA #%0000100
			STA updateScreenData
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
	
	RTS