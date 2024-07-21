oUpdatePosition:
	
	LDX arg0_hold
	LDA arg1_hold
	STA Object_x_hi,x
	LDA arg2_hold
	STA Object_y_hi,x
	RTS

