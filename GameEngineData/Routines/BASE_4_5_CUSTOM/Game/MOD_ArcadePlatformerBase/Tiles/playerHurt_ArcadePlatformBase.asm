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
		
		LDA continueScreen
		STA currentNametable
		AND #%00001111
		STA camX_hi
		
		LDX player1_object
		STA Object_screen,x
		
		LDA #$02 ;; this is continue type warp.
		STA screenTransitionType ;; is of warp type

		
		LDA #$00
		STA camX
		
		LDA gameHandler
		ORA #%10000000
		STA gameHandler ;; this will set the next game loop to update the screen.
	dontDoTileReset: