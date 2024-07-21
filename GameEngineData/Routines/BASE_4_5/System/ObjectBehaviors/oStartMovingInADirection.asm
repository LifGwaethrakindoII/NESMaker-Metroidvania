oStartMovingInADirection:
	LDA arg0_hold
	TAX

	;;;;;;;;;;;;;;;;;;;;;;
		LDA Object_direction,x
		AND #%00001111 ; these bits need to be preserved
		STA temp1
		
		LDA arg1_hold
		AND #%10000000
		BEQ notChangingDirectionH
			;; is changing direction H
			LDA #%00011111
			JMP gotChangDirectionBlankout
		notChangingDirectionH:
			;; is changing direction V
			LDA #%01001111
		gotChangDirectionBlankout:
			STA temp ;; temp now blanks out the direction that the object is moving, either h or v
					;; and turns off acceleration in the opposite, while preserving the "direction"
					;; of inertia, so that it may still deccelerate in that direction.
					;; This is important for anything that isn't an abrupt direction change, but rather
					;; has acceleration / decceleration
			
		LDA Object_direction,x
		AND temp
		ORA arg1_hold
		ORA temp1
		STA Object_direction,x
		
		
		
		
	;;; right now, speed argument is unused,
	;;; as in default physics, max speed is maintained
	;;; in LUTs, and acceleration to that value
	;;; determines the speed.
	RTS





