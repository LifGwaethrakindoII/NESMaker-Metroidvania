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

		DoObjectAction tempA, tempB
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
	WarpToScreen warpToMap, warpToScreen, #$01
	RTS
;;; 08 = Show Message (1)
show_message_action

	RTS
;;; 09 = Go To Continue
goToContinue_action:
	LDA continueMap
	STA warpMap
	
	LDA continueScreen
	STA currentNametable
	
	LDX player1_object
	STA Object_screen,x
	
	LDA #$02 ;; this is continue type warp.
	STA screenTransitionType ;; is of warp type

	
	LDA gameHandler
	ORA #%10000000
	STA gameHandler ;; this will set the next game loop to update the screen.
	ChangeActionStep player1_object, #$00
	LDX player1_object
	LDA #$00000000
	STA Object_direction,x
	RTS
;;; 10 = Restart Screen
restartScreen_action:
	LDA #$02
	STA screenTransitionType
	LDA gameHandler
	ORA #%10000000
	STA gameHandler ;; this will set the next game loop to update the screen.
	ChangeActionStep player1_object, #$00
	LDX player1_object
	LDA #$00000000
	STA Object_direction,x
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
	

