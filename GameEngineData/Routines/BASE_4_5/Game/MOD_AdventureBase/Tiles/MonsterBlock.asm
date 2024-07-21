;;; this block will become walkable after all monsters in a room are destroyed.
;; THIS PART DOES SOLID BEHAVIOR

	LDA ObjectUpdateByte
	ORA #%00000001
	STA ObjectUpdateByte ;; makes solid
	
	