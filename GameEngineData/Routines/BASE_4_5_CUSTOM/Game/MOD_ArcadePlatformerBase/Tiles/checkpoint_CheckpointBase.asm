;;; sets a new player continue checkpoint.
	CPX player1_object
	BEQ +doCheckpoint
		JMP +skip
	+doCheckpoint
	LDA currentNametable
	STA continueScreen
	LDA Object_x_hi,x
	STA continueX
	LDA Object_y_hi,x
	STA continueY
	
	ChangeTileAtCollision #$00, #$00 ;; change to tile zero (make disappear), collision type 0
	
+skip
	
	