doCreateObject:

	LDA #%01111110
	STA Object_status,x
	
	LDA arg0_hold
	STA Object_x_hi,x
	LDA arg1_hold
	STA Object_y_hi,x
	LDA arg2_hold
	STA Object_type,x
	
	LDA arg3_hold ;; this is the behavior step that is to be called.
	ASL
	ASL
	ASL
	STA temp
	LDA Object_frame,x
	AND #%11000000
	ORA temp
	STA Object_frame,x ;; now we have the 4th argument telling the object
						;; which action frame he should begin with.


	LDA #$00
	STA Object_direction,x
	STA Object_h_speed_lo,x
	STA Object_h_speed_hi,x
	STA Object_v_speed_lo,x
	STA Object_v_speed_hi,x

	RTS