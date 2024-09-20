;;; stop moving.
	LDA Object_direction,x
	AND #%00000111
	STA Object_direction,x

