MACRO GetActionStep arg0
	;; arg0 = player
	LDX arg0
	LDA Object_frame,x
	LSR
	LSR
	LSR
	AND #%00000111
	;;; this is the action step, loaded now into accumulator.
	ENDM