;;;
doCompareBoundingBoxes:
	;;; more complicated than this
	; LDA self_screen
	; CMP other_screen
	; BNE noBboxCollision


	LDA bounds_right
	CMP other_left
	BCC noBboxCollision ;; no player object collision
;; it is still possible there is a collision here.
	LDA other_right
	CMP bounds_left
	BCC noBboxCollision
 ;; there was a collision here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA other_bottom
	CMP bounds_top
	BCC noBboxCollision
	LDA bounds_bottom
	CMP other_top
	BCC noBboxCollision
	LDA #$01 ;; read that YES, there was a collision here. (could make this the object ID)
	RTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
noBboxCollision;; there is no collision here horizontally.
	LDA #$00 ;; read that NO, there was no collision.
	RTS
	
	
getOtherColBox:
	TYA
	PHA
		LDY Object_type,x
		LDA ObjectBboxLeft,y
		CLC
		ADC Object_x_hi,x
        STA other_left
        CLC
        ADC ObjectWidth,y
        STA other_right
        SEC
        SBC other_left
        LSR
        STA other_center_x
        
        LDA ObjectBboxTop,y
		CLC
		ADC Object_y_hi,x
        STA other_top
        CLC
        ADC ObjectHeight,y
        STA other_bottom
        SEC
        SBC other_top
        LSR
        STA other_center_y ;; self center in the vertical direction.

	
	PLA
	TAY
	RTS