
doEjectLeft:

	LDA Object_x_hi,x
	CLC
	ADC #$10; self_right
	AND #%11110000
	SEC
	SBC #$10
	STA Object_x_hi,x
	LDA #$00
	STA Object_x_lo,x
	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	rts
doEjectRight:
	
	LDA Object_x_hi,x
	clc
	adc self_left
	AND #%11110000
	CLC
	ADC #$10
	clc
	adc self_left
	STA Object_x_hi,x
	LDA #$00
	STA Object_x_lo,x
	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	RTS


doEjectUp:
	
	LDA Object_y_hi,x
	CLC
	ADC self_bottom
	AND #%11110000
	SEC
	SBC #$10
	
	STA Object_y_hi,x
	LDA #$00
	STA Object_y_lo,x
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x
	RTS
	
doEjectDown:
	
	LDA Object_y_hi,x
	clc
	adc self_top
	AND #%11110000
	CLC
	ADC #$10
	clc
	adc self_top
	STA Object_y_hi,x
	LDA #$00
	STA Object_y_lo,x
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x
	Rts
	
