doMoveTowardsPoint:
	
GetAngle:
	Atan2:
		LDA arg0_hold
		SBC arg1_hold
		bcs noEor
		eor #$ff
	noEor:
		TAX 
		rol octant

		lda arg2_hold
		SBC arg3_hold
		bcs noEor2
		eor #$ff
	noEor2:
		TAY 
		rol octant

		lda log2_tab,x
		sbc log2_tab,y
		bcc noEor3
		eor #$ff
	noEor3:
		tax	
		lda octant
		rol
		and #%111
		tay
		lda atan_tab,x
		eor octant_adjust,y
		;; now, loaded into a should be a value between 0 and 255
		;; this is the 'angle' towards the player from the object calling it
	
		TAY
		LDA AngleToHVelLo,y
		sec
		sbc #$80
		STA tempA
		LDA AngleToVVelLo,y
		CLC
		ADC #$80
		STA tempB
		


	RTS