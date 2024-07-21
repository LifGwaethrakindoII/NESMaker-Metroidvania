	CPX player1_object
	BNE +notPlayer1
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
	JMP +done
	+notPlayer1
	
	LDA Object_flags,x
	AND #%00000100 ;; is it a player weapon?
	BEQ +notPlayerWeapon ;; player weapon was not ticked.
		;; it WAS a player weapon.
		DestroyObject
		DEC bossHealth
		LDA bossHealth
		BNE +notPlayerWeapon
				
			;; there is no more boss health.
			;; we need to do two things.
			;; One, destroy the boss the way we would destroy a lock block.
			;; Two, make the screen start scrolling again.
			;;;; STEP ONE: look for boss blocks.
			;;;; This presumes boss blocks are tile type #$04
				LDA #$01
				STA bossByte
				LDA #$05
				STA bossHealth ;; reset this for the next boss we run into.
			

+notPlayerWeapon
	
	
+done