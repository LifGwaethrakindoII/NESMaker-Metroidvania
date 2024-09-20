;;; sets a new player continue checkpoint.

	LDA updateScreenData
	AND #%00000100
	BEQ +doScript
		;; wait until tile update is finished.
		RTS
	+doScript
	
	CPX player1_object
	BEQ +doCheckpoint
		JMP +skip
	+doCheckpoint
	LDA Object_screen,x
	STA continueScreen
	LDA Object_x_hi,x
	STA continueX
	LDA Object_y_hi,x
	STA continueY
	
	LDA #$00
	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x
	
	
	
	
	
	ChangeTileAtCollision #$00, #$00 ;; change to tile zero (make disappear), collision type 0
	
+skip
	
	