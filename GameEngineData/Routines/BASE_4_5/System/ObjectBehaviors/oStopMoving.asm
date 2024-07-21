oStopMoving:
	LDX arg0_hold
	LDA arg1_hold
	CMP #$FF ;; we;; use ff to stop in both horizontal and vertical directions.
	BNE notStopAllInertia
		LDA gamepad
		AND #%11000000
		BEQ stopAllInertia
			RTS
		stopAllInertia:
		LDA Object_direction,x
		AND #%01011111
		STA Object_direction,x
		RTS
	notStopAllInertia
		STA temp
		AND #%01011111
		STA temp2 ;; holds the values we want to maintain.
				;; like facing direction and inertial direction.
		LDA temp
		EOR #$FF ;; flips the inertia bit
		AND #%10100000 ;; but we only care about the "active" bits, h and v
		AND temp ;; and only the one defined by flipped bits in "direction"
		ORA temp2 ;; then put back the bit status of the rest of the byte.
		STA Object_direction,x
		
		
	RTS