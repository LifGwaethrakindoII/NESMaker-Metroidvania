;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; This is great for a game that functions like the scrolling platformer, but uses the top and bottom to 
;;; advance to a new screen on the map.

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CPX player1_object
	BEQ +isPlayerForBounds
		RTS
+isPlayerForBounds
	
	LDA screenUpdateByte
	BEQ +doBounds ;; if it is zero, that means it is moving down.
	
	CMP #$02
	BEQ +doBounds ;; if 2, that means it is moving up.

		RTS
+doBounds

;;;; UPDATE SCREEN:
	LDA gameHandler
	ORA #%10000000
	STA gameHandler

	LDA #$00
	STA soft2001	
	JSR doWaitFrame
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;Screen is now off.

	LDX player1_object
	LDA Object_screen,x
	
	STA currentNametable
	
	LDA #$00 
	STA camX
	STA camY
	STA camX_lo
	STA camY_lo
	
	LDA screenUpdateByte
	BNE notHandlingBottomBounds
	;;;; handling bottom bounds.
			LDA #BOUNDS_TOP ;#$02
			CLC
			ADC #$02
			STA newY
			LDA Object_x_hi,x
			STA newX
			LDA currentNametable
			CLC
			ADC #$10
			JMP DoScreenUpdate
notHandlingBottomBounds:
	CMP #$01
	BNE notHandlingRightBounds
	LDA #BOUNDS_LEFT
	CLC
	ADC #$02
	STA newX
	LDA Object_y_hi,x
	STA newY
	LDA currentNametable
	CLC
	ADC #$01

	JMP DoScreenUpdate
notHandlingRightBounds:

	CMP #$02
	BNE notHandlingTopBounds
	
	LDA #BOUNDS_BOTTOM;#$EF
	SEC
	SBC #$02
	SEC
	SBC self_bottom
	STA newY
	LDA Object_x_hi,x
	STA newX
	LDA currentNametable
	SEC
	SBC #$10
	JMP DoScreenUpdate
notHandlingTopBounds:
	CMP #$03
	BNE notHandlingLeftBounds
	
	LDA #BOUNDS_RIGHT;#$FE
	SEC
	SBC #$04
	SEC
	SBC self_right
	STA newX
	LDA Object_y_hi,x
	STA newY

	LDA currentNametable
	SEC
	SBC #$01

	JMP DoScreenUpdate
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; NON NORMAL SCREEN UPDATES
	
notHandlingLeftBounds:
DoScreenUpdate:


	 STA currentNametable
	 STA Object_screen,x
	 
	
