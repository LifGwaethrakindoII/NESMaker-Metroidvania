;;; main game loop.

MainGameLoop:
	LDA vBlankTimer
vBlankTimerLoop:
	CMP vBlankTimer
	BEQ vBlankTimerLoop
	

	LDA gameHandler
	AND #%10000000
	BEQ dontSkipNormalGameLoop
		JMP skipNormalGameLoop
	dontSkipNormalGameLoop:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Handles box updates that need to be carried over a frame.		
		LDA queueFlags
		AND #%00000101
		BNE doBoxUpdate
		JMP dontDoBoxUpdate
	doBoxUpdate:
		TXA
		PHA
		TYA
		PHA
		JSR doDrawBox
		PLA
		TAY
		PLA
		TAX
		
	dontDoBoxUpdate
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; handles text updates that need to be carried over a frame.
	LDA textHandler
	BEQ noTextUpdates
		JSR doDrawText
noTextUpdates:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		JSR doHandleInputReads
		LDA #$00
		STA spriteRamPointer
		SwitchBank #$18
			JSR doScreenPreDraw
		ReturnBank
		
		JSR doHandleObjects
		JSR doCamera 
		;;;;;;;;;;;;;;;;;; SET GAME SCREEN
		;;;;;; IN THE EVENT THERE IS NO ATTATCHED CAM SCRIPT TO DO IT

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		SwitchBank #$18
			JSR doScreenPostDraw
			.include SCR_HANDLE_GAME_TIMER
		ReturnBank
		JSR doCleanUpSpriteRam
		;JSR doHandleUpdateCamera
	skipNormalGameLoop:
		JSR doHandleUpdateScreen
		 SwitchBank #$1B
			 JSR doHandleUpdateMusic
			 
			 
		 ReturnBank
	JMP MainGameLoop