;;; sets a new player continue checkpoint.
	CPX player1_object
	BNE +skip
	LDA currentNametable
	STA continueScreen
	LDA Object_x_hi,x
	STA continueX
	LDA Object_y_hi,x
	STA continueY
	
+skip
	
	