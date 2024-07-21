;;;; ...this will only work if the current labels are observed.
;;;; This assumes that the label "dontUpdateObjectPosition" precedes stop-code at the end of this subroutine.
	
	LDA #$00
	STA Object_x_lo,x
	STA Object_y_lo,x
	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x
	STA xHold_lo
	STA yHold_lo
	LDA xPrev
	STA Object_x_hi,x
	STA xHold_hi
	LDA yPrev
	STA Object_y_hi,x
	STA yHold_hi
	

	;JMP dontUpdateObjectPosition