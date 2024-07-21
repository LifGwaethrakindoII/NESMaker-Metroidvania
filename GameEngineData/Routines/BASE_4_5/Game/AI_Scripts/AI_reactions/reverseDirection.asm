;;;; reverse direction.

	TXA
	STA temp
	GetActionStep temp
	CMP #$07 ;; we will use action step 7 for hurt.
	BNE +notHurt
		;; it was hurt, so we need to stop, rather than reset direction.
		LDA #$00
		STA Object_h_speed_hi,x
		STA Object_h_speed_lo,x
		STA Object_v_speed_hi,x
		STA Object_v_speed_lo,x
		JMP dontUpdateObjectPosition
	+notHurt
	TYA
	PHA
	LDA Object_direction,x
	AND #%00000111
	CLC
	ADC #$04
	AND #%00000111
	TAY ;; this is the "direction", where
		;; 0 = down, counterclockwise, 7=down-left
	LDA DirectionTableOrdered,y
	ORA FacingTableOrdered,y
	STA Object_direction,x
	PLA
	TAY