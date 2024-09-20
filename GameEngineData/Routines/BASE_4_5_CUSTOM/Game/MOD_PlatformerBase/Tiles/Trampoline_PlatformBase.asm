;;;; trampoline
	CPX player1_object
	BNE +skip
	LDA Object_v_speed_hi,x
	BEQ +skip
	BMI +skip
		LDA #$F8
		STA Object_v_speed_hi,x
	+skip
	rts
	
	
	
