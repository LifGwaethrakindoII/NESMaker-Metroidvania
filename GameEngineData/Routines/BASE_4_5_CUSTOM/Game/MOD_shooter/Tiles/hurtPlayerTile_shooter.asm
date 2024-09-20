
	;;;;;;;;;;;;;;;;;; Presumes there is a variable called myLives defined in user variables.
	;;;;;;;;;;;;;;;;;; You could also create your own variable for this.

	LDA gameHandler
	AND #%10000000
	BEQ +canHurtPlayer
		JMP +skipHurt
+canHurtPlayer:
	CPX player1_object
	BEQ +doPlayer
		LDA Object_flags,x
		AND #%00000100
		BNE +notWeapon
			DestroyObject
		+notWeapon
		JMP +done
	+doPlayer
	DEC myLives
	LDA myLives
	BNE +notGameOver
		;; is game over.
		JMP RESET
	+notGameOver
	
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
		;; arg0 = warp to map.  0= map1.  1= map2.
		;; arg1 = screen to warp to.
		;; arg2 = screen transition type - most likely use 1 here.
			;; 1 = warp, where it observes the warp in position for the player.

+done