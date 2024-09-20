MACRO DrawTilesDirect arg0, arg1, arg2, arg3, arg4
	;;; draw text direct is used when rendering is already turned off.
	;; arg0 bank.
	;; arg1 label
	;; x 
	;; y
	;; tileset offset- usually used for hud, otherwise zero.

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
	
	;;
	SwitchBank arg0
			LDA #<arg1
			STA textPointer
			LDA #>arg1
			STA textPointer+1

	ReturnBank
	
	JSR doDrawTilesDirect

	ENDM