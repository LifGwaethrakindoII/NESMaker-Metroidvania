;;; Here is an example of how to do a sprite hud.
;;; Arg5, the one that has the value of myVar, must correspond to a user variable you have in your game.
;;; Don't forget, you can only draw 8 sprites per scanline, so a sprite hud can only be 8 sprites wide max.


;DrawSpriteHud #$08, #$08, #$11, #$10, #$10, myVar, #$00
	; arg0 = starting position in pixels, x
	; arg1 = starting position in pixels, y
	; arg2 = sprite to draw, CONTAINER
	; arg3 = MAX	
	; arg4 = sprite to draw, FILLED
	; arg5 = variable.
	; arg6 = attribute
	
DrawSpriteHud #16, #16, #$7f, myLives, #$32, myLives, #%00000000  ;;;; this draws health

;;; Here, we are going to draw a sprite, followed by a little x, followed by numbers representing a quasi-score value.
;;; We are doing this all with sprites so that it can follow our hud more easily.  
;;; To do this, our game object tileset has numbers, 0-9, located at 40-49, and 4A represents the X.
;;; The identifier for the type of thing we're drawing is at 22.

	DrawSprite #16, #26, #$22, #%00000001 ;; draws the "carrot"
	DrawSprite #24, #26, #$4a, #$00 ;; draws the x 8 pixels to the right of it.
	
	LDA myPrizes
	CLC
	ADC #$40
	;; now we have the number 40 + how many prizes we have.
	;; so the resulting graphic will be 0-9.
	STA temp
	DrawSprite #32, #26, temp, #$00
	
	


