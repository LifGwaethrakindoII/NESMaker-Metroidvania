;;;; bounce direction - this doesn't mean that this will cause the object
;;;; to bounce like a ball, but rather if moving diagonally, it won't
;;;; directly reverse the way it was moving, but instead, react like
;;;; a bounce off of a solid.
	LDA Object_direction,x
	AND #%00000001
	BEQ +next
	;;; was a diag
	LDA Object_direction,x
	AND #%00000111
	CLC
	ADC #$02
	AND #%00000111
	JMP +next2
+next:
	LDA Object_direction,x
	AND #%00000111
	CLC
	ADC #$04
	AND #%00000111
+next2:
	TAY ;; this is the "direction", where
		;; 0 = down, counterclockwise, 7=down-left
	LDA DirectionTableOrdered,y
	ORA FacingTableOrdered,y
	STA Object_direction,x
	