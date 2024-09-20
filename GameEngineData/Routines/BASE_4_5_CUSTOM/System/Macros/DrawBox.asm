MACRO DrawBox arg0, arg1, arg2, arg3, arg4, arg5
	TXA
	PHA
	TYA
	PHA
	; arg0 = X value, in metatiles
	; arg1 = y value, in metatiles
	; arg2 = width, in metatiles
	; arg3 = height, in metatiles
	; arg4 = trigger
		;; 00 = nothing, just draw the black box.
		;; 01 = draw loaded text once black box is finished.
		;; 02 = erase box.  We would want to draw text with an erase box 
			;; end action so that we can hide all the text
			;; and restore attributes before returning to game.
		;; 03 = hud box
		;; 04 = draw loaded "NPC" text, based on look up table.
	;; this will push values into queue, and then turn on screen update.
	;; arg5 = will set the after-text to a label.

	LDA arg0

	STA Box_x_origin;arg0_hold
	STA temp_boxX
	
	LDA arg1

	STA Box_y_origin;arg1_hold
	STA Box_y_hold
	STA temp_boxY
	
	LDA arg2
	STA Box_width; arg2_hold
	STA temp_boxWidth
	
	LDA arg3
	STA Box_height
	STA Box_height_hold
	STA temp_boxHeight
	;arg3_hold
	LDA arg4
	;STA ;arg4_hold
	STA endDrawBoxAction ;; also serves a text mode.
	CMP #TEXT_FREE
	BNE notTextFree
	
	
			LDA textQueued
			AND #%00000001
			BNE skipSettingNewPointer3
				LDA #<arg5
				STA textPointer
				LDA #>arg5
				STA textPointer+1
			skipSettingNewPointer3:
			JMP activateTextNow
	notTextFree:
		;;; check if it is NPC text, if there are any other types.
		LDA arg5
		STA textToWrite
activateTextNow:

	LDA Box_x_origin
	STA temp_boxX

	LDA Box_y_origin
	STA Box_y_hold
	STA temp_boxY
	
	LDA Box_width
	STA temp_boxWidth
	
	LDA Box_height
	STA Box_height_hold
	STA temp_boxHeight

	
	LDA queueFlags
	ORA #%10000000
	STA queueFlags

	JSR doDrawBox
	
	PLA
	TAY
	PLA
	TAX
	
	ENDM