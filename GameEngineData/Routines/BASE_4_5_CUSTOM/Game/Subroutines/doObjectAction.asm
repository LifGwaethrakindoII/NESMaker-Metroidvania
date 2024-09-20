doObjectAction:
	TXA
	PHA
	TYA
	PHA
	;arg0 = what object?
	;arg1 = what step behavior?
		LDX arg0_hold
	;SwitchBank #$1C 


		LDY Object_type,x
		LDA ObjectBehaviorTableLo,y
		STA temp16
		LDA ObjectBehaviorTableHi,y
		STA temp16+1
		LDY arg1_hold
		LDA (temp16),y

			;;; this now holds the action type id and the action timer.
			;;; xxxxxyyy: x=action timer, y=action type, 0-7.
			STA temp
			AND #%00001111
			STA tempA ;; use this to "do" the action.
			
			
			LDA temp
			;;; RIGHT HERE, assing the timer.
			LSR
			LSR
			LSR
			LSR
			BNE notZeroForActionTimer ;;	
				;; set to a random number if zero
				JSR doGetRandomNumber
				AND #%00111111 ; 0-127 for a timer.
				ASL
				JMP gotNewActionTimer
			notZeroForActionTimer:
				ASL
				ASL
				ASL
				ASL
			gotNewActionTimer:
				STA Object_action_timer,x
				
			;;;;;;;;;;;;;;;;;;;;;;; 
			;;; RESET ANIMATION TIMER
			;;;;;;;;;;;;;;;;;;;;;;;;;
			LDY Object_type,x
			LDA ObjectAnimationSpeedTableLo,y
			STA temp16
			LDA ObjectAnimationSpeedTableHi,y
			STA temp16+1
			
			LDA Object_frame,x
			LSR
			LSR
			LSR
			AND #%00000111
			TAY
			
			LDA (temp16),y ;; this now points to the proper spot on the anim speed table.
							;; we need to capture that number.
							;; Its high nibble is the "animation type"
			AND #%00001111
			;;				Now we have a value 0-16.
			;; 				This correlates to animation speed, but it probably shouldn't be a one-to-one comparision.
			ASL
			ASL
			STA Object_animation_timer,x
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
			LDA Object_frame,x
			AND #%11111000
			STA Object_frame,x ;; reset animation frame.
			
		
			LDY tempA
	
			LDA AI_table_lo,y
			STA temp16
			LDA AI_table_hi,y
			STA temp16+1
		
			JSR doObjectActionTrampoline
				 JMP pastObjectActionTrampoline
				 doObjectActionTrampoline:
					JMP (temp16)
					; ;;; make sure that the behavior ends in an RTS, and then it will 
					; ;;; slide right back to this part of the code.
				 pastObjectActionTrampoline:
		;;; Set this step's vulnerabilities.
			LDY Object_type,x
			LDA VulnerabilityTableLo,y
			STA temp16
			LDA VulnerabilityTableHi,y
			STA temp16+1
			LDA Object_frame,x
			LSR
			LSR
			LSR
			AND #%00000111
			TAY
			LDA (temp16),y
			STA Object_vulnerability,x
		 	 
	
	;ReturnBank
	PLA
	TAY
	PLA
	TAX
	RTS