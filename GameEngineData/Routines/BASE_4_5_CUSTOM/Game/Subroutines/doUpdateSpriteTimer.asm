;;Do update object timers.
	;;; Check to see if this object in this state animates.
	;;; If the animation speed is zero, it does not animate.
		;SwitchBank #$1C
		
		
			DEC Object_animation_timer,x
			LDA Object_animation_timer,x
			BEQ endOfAnimTimer
				JMP animationTimerNotFinished
			endOfAnimTimer:	
				;; here, the animation timer has rounded down to zero.
				;; so we will increase the frame
				LDA Object_frame,x
				AND #%00000111
				CLC
				ADC #%00000001
				AND #%00000111
				CMP animationFrameHolder
				BNE notAtMaxAnimFrame
					
					;; is at max anim frame, so set anim to 00.
					;;; Here, we have reached the max anim frame.
					;;; we need to check to see what we should do if the max anim is reached.
						LDY Object_type,x
						LDA EndActionAnimationTableLo,y
						STA pointer
						LDA EndActionAnimationTableHi,y
						STA pointer+1
						LDA Object_frame,x
						LSR
						LSR
						LSR
						AND #%00000111
						TAY		
						LDA (pointer),y
						LSR
						LSR
						LSR
						LSR
						STA tempD
					
						LDA tempD
						TAY
						
						LDA EndAnimAndActions_Lo,y
						STA temp16
						LDA EndAnimAndActions_Hi,y
						STA temp16+1
					
						JSR doEndAnimationTrampoline
							 JMP pastEndAnimationTrampoline
							 doEndAnimationTrampoline:
								 JMP (temp16)
								; ;;; make sure that the behavior ends in an RTS, and then it will 
								; ;;; slide right back to this part of the code.
							 pastEndAnimationTrampoline:
					LDA #$00
				notAtMaxAnimFrame:
				STA temp
				LDA Object_frame,x
				AND #%11111000
				ORA temp
				STA Object_frame,x
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;; here, we will reset the animation timer.
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
				
			;	LDY temp1 ;; the current action number.
				LDA (temp16),y ;; this now points to the proper spot on the anim speed table.
								;; we need to capture that number.
								;; Its high nibble is the "animation type"
				AND #%00001111
				;;				Now we have a value 0-16.
				;; 				This correlates to animation speed, but it probably shouldn't be a one-to-one comparision.
				ASL
				ASL
				
				STA Object_animation_timer,x
	
	
	
animationTimerNotFinished:
	;ReturnBank
