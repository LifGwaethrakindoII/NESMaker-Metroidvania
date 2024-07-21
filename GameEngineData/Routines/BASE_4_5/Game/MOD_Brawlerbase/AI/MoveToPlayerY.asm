;; find player's y.
;; if the monster's center is not within the player's top/bottom bbox,
;; set direction to up or down depending on that.

;;; aim towards player.

;;; First, check...are we in the "range" of the player's y value?


	; TYA
	; PHA
	; TXA
	; PHA
	; STA tempx
	
		; LDA Object_x_hi,x
		; STA tempA
		; STA tempC ;; this will keep the *x* in place
					; ;; and only move the y.
		; LDA Object_y_hi,x

		; STA tempB
		; LDX player1_object
		; ;LDA Object_x_hi,x
		; ;STA tempC
		; LDA Object_y_hi,x		
		; CLC
		; ADC #$10
		; STA tempD
		
		; CLC
		; ADC #$10 ;; height of player's bbox.
		; STA temp1
		
		; LDX tempx
		
	; ; LDA Object_y_hi,x
	; ; CMP temp1
	; ; BCC +keepMoving
	; ; JMP RESET
; ; +keepMoving
	
		
		
	; MoveTowardsPoint tempA, tempC, tempB, tempD
	; LDA Object_direction,x
	; AND #%00000111
	; ORA #%00001000
	; STA Object_direction,x
	; LDA #$00
	; STA Object_h_speed_hi,x
	; STA Object_h_speed_lo,x
	; PLA
	; TAX
	; PLA
	; TAY