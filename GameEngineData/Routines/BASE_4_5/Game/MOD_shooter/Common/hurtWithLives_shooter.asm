
	;;;;;;;;;;;;;;;;;; Presumes there is a variable called myLives defined in user variables.
	;;;;;;;;;;;;;;;;;; You could also create your own variable for this.

	LDA gameHandler
	AND #%10000000
	BEQ +canHurtPlayer
		JMP +skipHurt
+canHurtPlayer:

	Dec myLives
	LDA myLives
	BNE myLivesNotZero
		JMP RESET ;; game over.
		;;;; also could warp to game over screen here instead.
myLivesNotZero:

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
	sta camX_lo
	
	
	
	
	LDA updateScreenData
	AND #%11111011
	STA updateScreenData
	LDA scrollByte
	AND #%00111110
	ORA #%00000010
	STA scrollByte
	LDA #$00
	STA scrollOffsetCounter
	
	LDA gameHandler
	ORA #%10000000
	STA gameHandler ;; this will set the next game loop to update the screen.
	
	LDA #$05 
	STA bossHealth ;; resets boss health for this level.

+skipHurt