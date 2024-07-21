;;; Simple Reset
	;; check to see if object colliding is a player.
	;; if not, do not reset.
	CPX player1_object
	BNE dontDoTileReset
		LDA Object_direction,x
		AND #%00001111
		STA Object_direction,x
	
		Dec myLives
		LDA myLives
		BNE +myLivesNotZero
			JMP RESET ;; game over.
			;;;; also could warp to game over screen here instead.
	+myLivesNotZero:

		LDA continueMap
	STA warpMap
	
	LDA continueX
	STA newX
	LDA continueY
	STA newY
	
	LDA continueScreen
	STA warpToScreen
	STA camScreen
	


	
	
	
	WarpToScreen warpToMap, warpToScreen, #$02
	dontDoTileReset: