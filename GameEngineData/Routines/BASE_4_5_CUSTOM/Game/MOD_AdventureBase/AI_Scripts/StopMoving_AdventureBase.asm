;;; stop moving.
	LDA Object_direction,x
	AND #%00001111
	STA Object_direction,x

