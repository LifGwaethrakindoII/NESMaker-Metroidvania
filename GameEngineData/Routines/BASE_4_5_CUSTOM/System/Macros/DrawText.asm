MACRO DrawText arg0, arg1, arg2, arg3, arg4, arg5
	;; arg0 bank.
	;; arg1 label
	;; x 
	;; y
	;; width (columns) in tiles
	;; height (rows) intiles
	LDA arg0
	STA arg0_hold
		STA textBank ;; allows for it to flow over frames.
	LDA arg1
	STA arg1_hold
	LDA arg2
	STA arg2_hold
	LDA arg3
	STA arg3_hold
	LDA arg4
	STA arg4_hold
	LDA arg5
	STA arg5_hold
	
	;;
	SwitchBank arg0
		LDA textQueued
		AND #%00000001
		BNE skipSettingNewPointer ;; if there is "more text" in queue, we will skip resetting the pointer.
			LDA #<arg1
			STA textPointer
			LDA #>arg1
			STA textPointer+1
		skipSettingNewPointer:
	ReturnBank
	
	JSR doDrawText

	ENDM