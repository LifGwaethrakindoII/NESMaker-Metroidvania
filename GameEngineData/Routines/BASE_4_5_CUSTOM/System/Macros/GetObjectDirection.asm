MACRO GetObjectDirection arg0
	; arg0 = object
	LDX arg0
	LDA Object_direction,x
	AND #%00000111
	;;; direction for arg0 object is now in the accumulator
	
	ENDM