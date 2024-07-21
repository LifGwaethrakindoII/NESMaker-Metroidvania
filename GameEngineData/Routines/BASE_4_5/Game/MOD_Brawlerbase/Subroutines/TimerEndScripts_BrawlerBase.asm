;;; 00 = Loop
end_loop_action:

	RTS
;;; 01 = Advance
advance_action:
		LDA Object_frame,x
		LSR
		LSR
		LSR
		AND #%00000111
		CLC
		ADC #$01
		AND #%00000111
		STA tempB
		;STA tempD ;; the action frame that was assigned during create macro.
		;;;; object behavior tables are with the lut table.
		;;;; the lut table is in bank 1C.
		; SwitchBank #$1C
			; ;;; Then, get the behavior for that object on that frame number.
			; LDY Object_type,x
			; LDA ObjectBehaviorTableLo,y
			; STA pointer
			; LDA ObjectBehaviorTableHi,y
			; STA pointer+1
			; LDY tempD
			; LDA (pointer),y
			; AND #%00001111
			; STA tempB
		; ReturnBank
		LDA tempB
		ASL
		ASL
		ASL
		STA tempC
		LDA Object_frame,x
		AND #%11000111
		ORA tempC
		STA Object_frame,x


		TXA 
		STA tempA
		
		DoObjectAction tempA, tempB
	;	;arg0 = what object?
		;arg1 = what step behavior?
	RTS
;;; 02 = Repeat
repeat_action:
	LDA Object_frame,x
		LSR
		LSR
		LSR
		AND #%00000111
		STA tempB
	
		TXA 
		STA tempA
		
		LDA Object_frame,x
		AND #%00000111
		STA tempz
		LDA Object_animation_timer,x
		STA tempy

		DoObjectAction tempA, tempB
		STA tempz
		LDA Object_frame,x
		AND #%11111000
		ORA tempz
		STA Object_frame,x
		LDA tempy
		STA Object_animation_timer,x
	;	;arg0 = what object?
		;arg1 = what step behavior?
	RTS
;;; 03 = Go To First
goToFirst_action:
			LDA #$00
			STA tempB
		;;;; HURT END
		LDA Object_frame,x
		AND #%00111000
		CMP #%00111000
		BNE +notHurtFrame
			LDA #$00
			STA Object_h_speed_hi,x
			STA Object_h_speed_lo,x
			STA Object_v_speed_hi,x
			STA Object_v_speed_lo,x
			LDA Object_direction,x
			AND #%00001111
			STA Object_direction,x
		;;;;;;;;;;;;;;;;;;;;
		+notHurtFrame
		
		LDA Object_frame,x
		AND #%11000111
		STA Object_frame,x
		
	
		TXA 
		STA tempA
		
		DoObjectAction tempA, tempB
	;	;arg0 = what object?
		;arg1 = what step behavior?
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		 ;; turn off move towards point if current action is 7.
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RTS
;;; 04 = Go To Last
goToLast_action:
			LDA #$07
			STA tempB
	
		
		LDA Object_frame,x
		ora #%00111000
		STA Object_frame,x
		
		TXA 
		STA tempA
		
		DoObjectAction tempA, tempB
	;	;arg0 = what object?
		;arg1 = what step behavior?
	RTS
;;; 05 = Go To Previous
goToPrev_action:
		LDA Object_frame,x
	LDA Object_frame,x
		LSR
		LSR
		LSR
		AND #%00000111
		SEC
		SBC #$01
		AND #%00000111
		STA tempB ;; the action frame that was assigned during create macro.
		;;;; object behavior tables are with the lut table.
		;;;; the lut table is in bank 1C.
		ASL
		ASL
		ASL
		STA tempC
		LDA Object_frame,x
		AND #%11000111
		ORA tempC
		STA Object_frame,x
		
		TXA 
		STA tempA
		
		DoObjectAction tempA, tempB
	;	;arg0 = what object?
		;arg1 = what step behavior?
	RTS
;;; 06 = Destroy Me
destroyMe_action:
	DestroyObject
	RTS
;;; 07 = Go To Warp
goToWarp_action:
	
	RTS
;;; 08 = Show Message (1)
show_message_action

	RTS
;;; 09 = Go To Continue
goToContinue_action:

	RTS
;;; 10 = Restart Screen
restartScreen_action:

	RTS
;;; 11 = Restart Game
restartGame_action:
	JMP RESET
	RTS
;;; 12 = User 0
userEnd0_action:

	RTS
;;; 13 = User 1
userEnd1_action:

	RTS

	
EndAnimAndActions_Lo:
	.db #<end_loop_action, #<advance_action, #<repeat_action, #<goToFirst_action, #<goToLast_action, #<goToPrev_action, #<destroyMe_action, #<goToWarp_action
	.db #<show_message_action, #<goToContinue_action, #<restartScreen_action, #<restartGame_action, #<userEnd0_action, #<userEnd1_action
	
EndAnimAndActions_Hi:
	.db #>end_loop_action, #>advance_action, #>repeat_action, #>goToFirst_action, #>goToLast_action, #>goToPrev_action, #>destroyMe_action, #>goToWarp_action
	.db #>show_message_action, #>goToContinue_action, #>restartScreen_action, #>restartGame_action, #>userEnd0_action, #>userEnd1_action
	

