
	;;;;;;;;;;;;;;;;;; Presumes there is a variable called myLives defined in user variables.
	;;;;;;;;;;;;;;;;;; You could also create your own variable for this.

	LDA gameHandler
	AND #%10000000
	BEQ +canHurtPlayer
		JMP +skipHurt
+canHurtPlayer:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;; is the monster below our feet?
	;;;;;;;;;; and are we moving downward?
	
	LDA Object_v_speed_hi,x
	BEQ +doHurtPlayer ;; equal to zero
	BMI +doHurtPlayer ;; or negative
	 ;; here we are moving downward.
	TXA
	PHA
		LDX otherObject
		DestroyObject
		
		CountObjects #%00001000
			BNE +notZeroCount
				LDA scrollByte
				ORA #%00000010
				STA scrollByte
				;;; if there are no more monsters left, we want to disable
				;;; the edge check for scrolling.
				LDA ScreenFlags00
				AND #%11101111
				STA ScreenFlags00
			+notZeroCount
	PLA
	TAX

	 ;; Do a hop
	 LDA #$FC
	 STA Object_v_speed_hi,x
	 

	 JMP +skipHurt

	
+doHurtPlayer	

	Dec myLives
	LDA myLives
	BNE myLivesNotZero
		JMP RESET ;; game over.
		;;;; also could warp to game over screen here instead.
myLivesNotZero:

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
+skipHurt