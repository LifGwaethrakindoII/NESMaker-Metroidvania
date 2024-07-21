MACRO DestroyObject
	LDA Object_status,x
	;ORA #%00000001
	AND #%00111111
	STA Object_status,x
ENDM