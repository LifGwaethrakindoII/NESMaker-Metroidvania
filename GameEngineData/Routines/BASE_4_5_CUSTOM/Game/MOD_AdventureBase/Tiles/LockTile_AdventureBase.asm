;;;;;;; THIS PRESUMES YOU HAVE A VARIABLE CALLED myKeys
;;;;;;; PRESUMES THAT VARIABLE FOR KEYS IS DRAWN IN ELEMENT 5


;;lock tile
;; THIS PART DOES SOLID BEHAVIOR

	LDA ObjectUpdateByte
	ORA #%00000001
	STA ObjectUpdateByte ;; makes solid
	
	
	LDA myKeys
	BNE +doUnlockDoor
		RTS ;; no keys, so can not unlock door.
+doUnlockDoor
	DEC myKeys
	UpdateHudElement #$05 ;; change #$05 if keys are drawn in a different hud element.
;;; this part will check the lock:
	LDY temp1
	LDA temp2
	BEQ +isEvenCt
		;; is an odd ct, so looking in collisionTable2
		LDA #$00
		STA collisionTable2,y
		JMP +doneWithTileUpdate
	+isEvenCt
		LDA #$00
		STA collisionTable,y
		
	+doneWithTileUpdate

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;; This part will actually update the tile with tile 0 in the tile set.
;;; ys is carried over from above.

;;; GET THE HIGH BYTE OF THE TILE TO CHANGE
	LDA temp2
	BEQ +isEvenNt
		;; is odd nt
		LDA #$24
		JMP +gotNt
	+isEvenNt
		;; is even nt
		LDA #$20
	+gotNt
		STA temp1
;;; GET THE LOW BYTE OF THE TILE TO CHANGE
		TYA
		STA temp
		LSR
		LSR
		LSR
		LSR
		LSR
		LSR
		clc
		ADC temp1
		STA temp2 ;;;temp16+1
		TYA
		AND #%11110000
		ASL
		ASL
		STA tempz
		TYA
		AND #%00001111
		ASL
		ORA tempz
		STA temp3 ;temp16
		
;;; SET THE TILE NUMBER TO CHANGE TO.	
	LDA #$00 ;; the tile to change.
			;;; this is in tiles, so if you wanted the second "metatile",
			;;; use 2, not 1.  If you wanted the tile in the next row, 
			;;; use #$20, not #$10.  Etc.
	STA tempA
	CLC
	ADC #$01
	STA tempB
	CLC
	ADC #$0F
	STA tempC
	CLC
	ADC #$01
	STA tempD
	
	
	LDY #$00
		LDA temp2
		STA scrollUpdateRam,y
		INY
		LDA temp3
		STA scrollUpdateRam,y
		INY
		LDA tempA
		STA scrollUpdateRam,y
		INY
		
		LDA temp2
		STA scrollUpdateRam,y
		INY
		LDA temp3
		CLC
		ADC #$01
		STA scrollUpdateRam,y
		INY
		LDA tempB
		STA scrollUpdateRam,y
		INY
		
			LDA temp3
			CLC
			ADC #$20
			STA temp3
			LDA temp2
			ADC #$00
			STA temp2
		
		LDA temp2
		STA scrollUpdateRam,y
		INY
		LDA temp3
		STA scrollUpdateRam,y
		INY
		LDA tempC
		STA scrollUpdateRam,y
		INY
		
		LDA temp2
		STA scrollUpdateRam,y
		INY
		LDA temp3
		CLC
		ADC #$01
		STA scrollUpdateRam,y
		INY
		LDA tempD
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
	TriggerScreen screenType
rts