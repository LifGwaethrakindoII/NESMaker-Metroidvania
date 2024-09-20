;;;; turn direction, counterclockwise.
	LDA Object_direction,x
	AND #%00000111
	CLC
	ADC #$01
	AND #%00000111
	TAY ;; this is the "direction", where
		;; 0 = down, counterclockwise, 7=down-left
	LDA DirectionTableOrdered,y
	ORA FacingTableOrdered,y
	STA Object_direction,x
	