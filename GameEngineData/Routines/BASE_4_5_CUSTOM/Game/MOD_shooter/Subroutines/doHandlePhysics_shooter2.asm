;; do handle physics.


	LDA Object_x_lo,x
	STA xHold_lo
	LDA Object_x_hi,x
	STA xHold_hi
	STA xPrev

	LDA Object_screen,x
	STA xHold_screen
	sta screenPrev
	
	LDA Object_y_lo,x
	STA yHold_lo
	LDA Object_y_hi,x
	STA yHold_hi
	STA yPrev
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Set up speeds and collision variables
		LDY Object_type,x
		LDA ObjectMaxSpeed,y
		ASL
		ASL
		ASL
		ASL
		;AND #%00001111
		STA myMaxSpeed
		LDA ObjectMaxSpeed,y
		LSR
		LSR
		LSR
		LSR
		STA myMaxSpeed+1
		;;; now high max speed byte is the actual high byte of speed
		;;; low max speed byte is the low byte of speed
		LDA #$00
        STA myAcc+1
        LDA ObjectAccAmount,y
        STA myAcc
    
	
		LDA ObjectBboxLeft,y
		STA self_left
		CLC
		ADC ObjectWidth,y
		STA self_right
		SEC
		SBC self_left
		LSR
		STA self_center_x
		
		LDA ObjectBboxTop,y
		STA self_top
		CLC
		ADC ObjectHeight,y
		STA self_bottom
		SEC
		SBC self_top
		LSR
		STA self_center_y ;; self center in the vertical direction.
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
	
	LDA Object_status,x
	AND #%00000100
	BNE doHandlePhysics
	JMP skipPhysics
doHandlePhysics:
 LDA #$00
    STA collisionsToCheck ;; blank out collisions to check.
    
    ;;; check to see if we are using aiming physics.
    ;;; if we are using aim physics, Object_direction will have it's 3rd bit flipped. xxxxXxxx
    LDA Object_direction,x
    AND #%00001000
    BNE +useAimedPhysics
		JMP useNormalDirectionalPhysics
	+useAimedPhysics
		
		LDA #%00001111
		STA collisionsToCheck
		LDY Object_type,x
        LDA ObjectMaxSpeed,y
        LSR
        LSR
        LSR
        LSR
        STA tempA ;; high byte of "speed" will determine how many times we should update move towards speed.
        ;; use aimed physics.
        ;; Aimed physics doesn't need to update speed.
        LDA Object_x_lo,x
		STA xHold_lo
		LDA Object_x_hi,x
		STA xHold_hi
		
		LDA Object_y_lo,x
		STA yHold_lo
		LDA Object_y_hi,x
		STA yHold_hi
		
        LDA Object_h_speed_lo,x
        BPL AddHspeedToAimedX
            ;; subtract h speed to aimed x
            LDA Object_h_speed_lo,x
            EOR #$FF
            STA temp
			LDY tempA
			doAimLoop1:
				LDA xHold_lo
				sec
				sbc temp
				STA xHold_lo
				LDA xHold_hi
				sbc Object_h_speed_hi,x
				STA xHold_hi
				DEY
				BPL doAimLoop1
				
				
			
            JMP figureAimedVspeed
        AddHspeedToAimedX:
			LDY tempA
			doAimLoop2:
            LDA xHold_lo
            CLC
            ADC Object_h_speed_lo,x
            STA xHold_lo
            LDA xHold_hi
            ADC Object_h_speed_hi,x
            STA xHold_hi
			DEY
			BPL doAimLoop2
        
        figureAimedVspeed:

        LDA Object_v_speed_lo,x
        BPL AddVSpeedToAimedY
            ;; subtract v speed to aimed y
            LDA Object_v_speed_lo,x
            EOR #$FF
            STA temp
			LDY tempA
			doAimLoop3:
            LDA yHold_lo
            clc
            adc temp
            STA yHold_lo
            LDA yHold_hi
            adc Object_v_speed_hi,x
            STA yHold_hi
			DEY
			BPL doAimLoop3
			
            JMP doneWithAimedV
        AddVSpeedToAimedY:
			LDY tempA
			doAimLoop4:
            LDA yHold_lo
            sec
            sbc Object_v_speed_lo,x
            STA yHold_lo
            LDA yHold_hi
            sbc Object_v_speed_hi,x
            STA yHold_hi
			DEY
			BPL doAimLoop4
        doneWithAimedV:
        
		;;;;;;;;;;;;; check xHold_hi and yHold_hi against bounds.
		
			LDA yHold_hi
			CMP #BOUNDS_TOP
			BEQ +doTopBounds
			BCC +doTopBounds
				JMP +doneWithTop
			+doTopBounds
				
					LDA #$02
					STA screenUpdateByte
			
					JSR doHandleBounds
					JMP skipPhysics
					
			+doneWithTop
		
			STA yHold_hi
			CLC
			ADC self_bottom
			CMP #BOUNDS_BOTTOM ;#240
		;   BEQ doBottomBounds
			BCS +doBottomBounds
				JMP +doneWithBottom
			+doBottomBounds:
					STA screenUpdateByte
					JSR doHandleBounds
					JMP skipPhysics
					
			+doneWithBottom
        
		
		
			    LDA xHold_hi
				clc
				ADC self_right 
				BCS +doRightBounds
					JMP +doneWithRight
				+doRightBounds:
				
					LDA #$01
					STA screenUpdateByte
					JSR doHandleBounds
					JMP skipPhysics
					
				+doneWithRight
				LDA xHold_hi
				CMP #BOUNDS_LEFT
				BEQ +doLeftBounds
				BCC +doLeftBounds
					JMP +doneWithLeft
				+doLeftBounds	
						
						LDA #$03
						STA screenUpdateByte
						JSR doHandleBounds
						JMP skipPhysics
				+doneWithLeft
        JMP skipPhysics ;; skips all the acc/dec stuff and goes right to movement based on speed
                            ;; which was figured out in the directional macro.
                            
    useNormalDirectionalPhysics:
	 
	LDA #$00
	STA collisionsToCheck ;; blank out collisions to check.
	
	LDA Object_direction,x
	AND #%10000000
	BNE +isHorMovement
		JMP +noHorMovement
	+isHorMovement
		;; there is vertical movement
		LDA Object_direction,x
		AND #%01000000
		BNE +isNotLeftMovement
			JMP +isLeftMovement
		+isNotLeftMovement
			;; is right movement
			LDA Object_x_lo,x
			CLC
			ADC myMaxSpeed;Object_v_speed_lo,x
			STA xHold_lo
			LDA Object_x_hi,x
			ADC myMaxSpeed+1;Object_v_speed_hi,x
			STA xHold_hi
			LDA Object_screen,x
			ADC #$00
			STA xHold_screen
			
			LDA xHold_hi
			clc
			adc #$10
			STA temp2
			
			LDA Object_screen,x
			ADC #$00
			AND #%00001111
			STA temp
			
			LDA camX
			CLC
			ADC #$FE
			STA tempA
			LDA camX_hi
			ADC #$00
			STA temp1
			
			
			
			Compare16 temp1, tempA, temp, temp2
				+
				JMP +noHorMovement
				++
				CPX player1_object
				BEQ +isPlayer
					DestroyObject
					JMP skipPhysics
				+isPlayer
					LDA #$00
					STA Object_h_speed_lo,x
					STA Object_h_speed_hi,x
					STA xHold_lo
					LDA xPrev
					STA xHold_hi
					LDA screenPrev
					STA xHold_screen
					JMP skipPhysics
			JMP +noHorMovement
		+isLeftMovement
			
			LDA Object_x_lo,x
			SEC
			SBC myMaxSpeed;Object_v_speed_lo,x
			STA xHold_lo
			LDA Object_x_hi,x
			SBC myMaxSpeed+1;Object_v_speed_hi,x
			STA xHold_hi
			LDA Object_screen,x
			SBC #$00
			STA xHold_screen
			
	
			LDA xHold_screen
			AND #%00001111
			STA temp
			
			Compare16 camX_hi, camX, temp, xHold_hi

				+
				CPX player1_object
				BEQ +isPlayer
					DestroyObject
					JMP skipPhysics
				+isPlayer
					LDA #$00
					STA xHold_lo
					LDA xPrev
					STA xHold_hi
					LDA Object_screen,x
					STA xHold_screen
					JMP skipPhysics
				DestroyObject
				++
			
	+noHorMovement
	
	LDA Object_direction,x
	AND #%00100000
	BEQ +noVertMovement
		;; there is vertical movement
		LDA Object_direction,x
		AND #%00010000
		BEQ +isUpMovement
			;; is down movement
			LDA Object_y_lo,x
			CLC
			ADC myMaxSpeed;Object_v_speed_lo,x
			STA yHold_lo
			LDA Object_y_hi,x
			ADC myMaxSpeed+1;Object_v_speed_hi,x
			STA yHold_hi
				CLC
				ADC self_bottom
				CMP #BOUNDS_BOTTOM ;#240
			
				BCS doBottomBounds
					JMP +noVertMovement
				doBottomBounds:
					CPX player1_object
					BEQ +isPlayer
						DestroyObject
						JMP skipPhysics
					+isPlayer
						LDA yPrev
						STA yHold_hi
						STA Object_y_hi,x
						; LDA #$00
						; STA Object_v_speed_hi,x
						; STA Object_v_speed_lo,x
						; LDA #$00
						; STA screenUpdateByte
						; JSR doHandleBounds
						JMP skipPhysics
		+isUpMovement
			LDA Object_y_lo,x
			SEC
			SBC myMaxSpeed;Object_v_speed_lo,x
			STA yHold_lo
			LDA Object_y_hi,x
			SBC myMaxSpeed+1;Object_v_speed_hi,x
			BCC +doTopBounds ;; helps if top bounds is zero. 
			STA yHold_hi
			CMP #BOUNDS_TOP
				BEQ +doTopBounds
				BCC +doTopBounds
					JMP +noVertMovement
				+doTopBounds
					CPX player1_object
					BEQ +isPlayer
						DestroyObject
						JMP skipPhysics
					+isPlayer
						
						LDA yPrev
						STA yHold_hi
						STA Object_y_hi,x
						; LDA #$00
						; STA Object_v_speed_hi,x
						; STA Object_v_speed_lo,x
						; LDA #$02
						; STA screenUpdateByte
						; JSR doHandleBounds
						JMP skipPhysics
	+noVertMovement
	

skipPhysics:

	LDA ScreenFlags00
	AND #%00010000
	BNE +skipCamMovement
		LDA Object_vulnerability,x
		AND #%00000001 ;; set this to "static object"
		BNE +skipCamMovement
		LDA xHold_lo
		CLC
		ADC #$00
		STA xHold_lo
		LDA xHold_hi
		ADC #$01;; this becomes the "SCROLL SPEED" - it is the offset at which the player moves.
				;; in conjunction with camera speed update, this could make it scroll faster.
		STA xHold_hi
		LDA xHold_screen
		ADC #$00
		STA xHold_screen


	+skipCamMovement