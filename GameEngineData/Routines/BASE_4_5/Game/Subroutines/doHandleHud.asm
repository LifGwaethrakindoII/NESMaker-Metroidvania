;;;; handle hud

	SwitchBank #$18
		JSR doDrawHud_bank18
		;JSR doDrawSpriteHud_bank18
	ReturnBank
			
		
		
	; ;;; DrawTilesDirect macro is good for:
	; ;;; Drawing static text
	; ;;; Drawing an image.
	; ;;; Arguments are:
		; ;; bank, string/label, x compared to box0, y compared to box0, and offset of tiles being drawn (#HUD_OFFSET for hud stuff, 0 otherwise).
	; DrawTilesDirect #$00, HUD_Health, #$02, #$02, #HUD_OFFSET
	
	; ;;; Draw variable tiles is good for drawing a "bar" or "meter"
	; ;; Draws a "max value" with one particular tile id
	; ;; and a variable level with another tile id.
	
	; ;DrawVariableTiles x, y, full length, tile, fill amount, tile.
	; ; changes are the "amount" will be a variable, like my health or my magic or something.
	; DrawVariableTiles #$10, #$02, #$08, #$C0, #$04, #$D0
	
	; ;;; Draw numbers is good for drawing the value of a variable.  For drawing static, should stll use draw tiles direct.
	; ;;; DrawNumbers root variable, number of places.
	; DrawNumbers #$02, #$04, myScore, #$04
	
		
	LDA gameHandler
	AND #%00100000
	BEQ doDrawHudUpdates
		JMP skipHudUpdates
	doDrawHudUpdates
	.include GameData\HUD_INCLUDES.dat
	skipHudUpdates:


		
		
		
		

	