;;solid tile
LDA Object_v_speed_hi,x
BMI +skipMakingSolid
	LDA ObjectUpdateByte
	ORA #%00000001
	STA ObjectUpdateByte ;; makes solid
+skipMakingSolid
rts