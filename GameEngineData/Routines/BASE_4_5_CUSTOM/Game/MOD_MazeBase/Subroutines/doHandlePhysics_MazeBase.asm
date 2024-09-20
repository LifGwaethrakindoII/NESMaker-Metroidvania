;; do handle physics.
    
	LDA Object_x_lo,x
    STA xHold_lo
    LDA Object_x_hi,x
    STA xHold_hi
    STA xPrev

    
    LDA Object_y_lo,x
    STA yHold_lo
    LDA Object_y_hi,x
    STA yHold_hi
    STA yPrev
;;;;;;;;;;;;;;;;;;;;;;;;;;; FOR ADVENTURE PHYSICS
;;;;;;;;;;;;;;;;;;;;;;;;;;; DON'T UPDATE POSITIONING IF ATTACKING	
	CPX player1_object
	BNE +notPlayer
		;; it was the player.
		;; if this object is in attack action, currently set to 2,
		;; he should not move, and should skip physics check
		TXA
		STA temp
		GetActionStep temp
		CMP #$02
		BNE +notPlayer ;; skip, because was not 2.
			JMP skipPhysics
	
	+notPlayer
	
	
	;;;;;;;;;;;; CUSTOMIZATION: IGNORE PHYSICS IF NOT ON MAIN GAME MODE
		LDA gameState
		BEQ +doHandlePhysics
			JMP skipPhysics
		+doHandlePhysics
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Reset the vars we will use for movement.
	LDA #$00
	STA tempA
	STA tempB
	STA tempC
	STA tempD
	
    
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
		LDY Object_type,x
		
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
    ;;; jump out to bank 1C to load in physics values.
    ;SwitchBank #$1C
	;;;; THESE CONSTANTS WILL DETERMINE THE SPEED OF RECOIL
	;;;; THE HURT STATE DURATION
	RECOIL_SPEED_HI = #$4
	RECOIL_SPEED_LO = #$00
	HURT_DURATION = #$40
	
	
		TXA
		STA temp
		GetActionStep temp
		CMP #$07
		BNE +notHurt
			;;; this object is hurt.
			;;; so it's speed will be determined by the recoil speed above.
			;;; any caveats to that, put here.  For instance, if there is a monster bit
			;;; that prevents recoil.
			LDA #$00
			STA Object_v_speed_hi,x
			STA Object_v_speed_lo,x
			STA Object_h_speed_hi,x
			STA Object_h_speed_lo,x
			JMP gotHandVspeeds

			
			
		+notHurt
   
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
    
    
     


        

    
;   ReturnBank
    ;;;; deal with acceleration / deceleration

    
    LDA Object_direction,x
    AND #%10000000
    BNE doHvel
    JMP doHdec
    doHvel:
    
        ;; we have activated horizontal inertia for this object
        LDA Object_h_speed_lo,x
        CLC
        ADC myAcc
        STA Object_h_speed_lo,x
        STA temp
        LDA Object_h_speed_hi,x
        ADC myAcc+1
        STA Object_h_speed_hi,x
        STA temp1
        
        ;;; now, evaluate against max speed.
        Compare16 temp1, temp, myMaxSpeed+1,myMaxSpeed
        +
        ;;;; we have reached the max speed.
        LDA myMaxSpeed
        STA Object_h_speed_lo,x
        LDA myMaxSpeed+1
        STA Object_h_speed_hi,x
        
        JMP doneWithAccFetch
        ++
        LDA temp
        STA Object_h_speed_lo,x
        LDA temp1
        STA Object_h_speed_hi,x
        
        doneWithAccFetch:
        JMP skipDoHdec
doHdec:
    LDA Object_h_speed_hi,x
    CLC
    ADC Object_h_speed_lo,x
    BEQ skipDoHdec
    
    LDA Object_h_speed_lo,x
    SEC
    SBC myAcc
    STA temp
    
    LDA Object_h_speed_hi,x
    SBC myAcc+1
    STA temp1
    BCC zeroHdec ;; if the result of the 16 bit compare is 
                    ;; less than zero, clamp the acc to zero.
                    ;; Otherwise, make it the stored values.
    
    LDA temp1
    STA Object_h_speed_hi,x
    LDA temp
    STA Object_h_speed_lo,x
    JMP skipDoHdec
    
zeroHdec:
    LDA #$00
    STA Object_h_speed_hi,x
    STA Object_h_speed_lo,x
    

skipDoHdec:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; do vertical check.
    LDA Object_direction,x
    AND #%00100000
    BNE doVvel
    JMP doVdec
    doVvel:
    
        ;; we have activated horizontal inertia for this object
        LDA Object_v_speed_lo,x
        CLC
        ADC myAcc
        STA Object_v_speed_lo,x
        STA temp
        LDA Object_v_speed_hi,x
        ADC myAcc+1
        STA Object_v_speed_hi,x
        STA temp1
        
        ;;; now, evaluate against max speed.
        Compare16 temp1, temp, myMaxSpeed+1,myMaxSpeed
        +
        ;;;; we have reached the max speed.
        LDA myMaxSpeed
        STA Object_v_speed_lo,x
        LDA myMaxSpeed+1
        STA Object_v_speed_hi,x
        
        JMP doneWithAccFetchV
        ++
        LDA temp
        STA Object_v_speed_lo,x
        LDA temp1
        STA Object_v_speed_hi,x
        
        doneWithAccFetchV:
        JMP skipDoVdec
doVdec:
    LDA Object_v_speed_hi,x
    CLC
    ADC Object_v_speed_lo,x
    BEQ skipDoVdec
    
    LDA Object_v_speed_lo,x
    SEC
    SBC myAcc
    STA temp
    
    LDA Object_v_speed_hi,x
    SBC myAcc+1
    STA temp1
    BCC zeroVdec ;; if the result of the 16 bit compare is 
                    ;; less than zero, clamp the acc to zero.
                    ;; Otherwise, make it the stored values.
    
    LDA temp1
    STA Object_v_speed_hi,x
    LDA temp
    STA Object_v_speed_lo,x
    JMP skipDoVdec
    
zeroVdec:
    LDA #$00
    STA Object_v_speed_lo,x
    STA Object_v_speed_hi,x

skipDoVdec:

gotHandVspeeds:

    LDA directionByte
    AND #%00001111
    STA directionByte

    LDA Object_h_speed_lo,x
    STA tempA
    LDA Object_h_speed_hi,x
    STA tempB
    

    LDA Object_direction,x
    AND #%01000000
    BNE isMovingRight
    ;isMovingLeft
    
    
    ;;; set to check points 0 and 3 (top left and bottom left.)
    LDA collisionsToCheck
    ORA #%00001001
    STA collisionsToCheck 
    
        LDA tempA
        CLC
        ADC tempB
        BNE hSpeedIsNotZero
            ;; h speed is zero, which means no h direction
            LDA directionByte
            AND #%01111111
            STA directionByte
            JMP gotHmoveDirection
        hSpeedIsNotZero:

            LDA directionByte
            ORA #%10000000
            AND #%10111111 ;; "left"
            STA directionByte
    JMP gotHmoveDirection
isMovingRight:
    
        ;;; set to check points 1 and 2 (top right and bottom right.)
    LDA collisionsToCheck
    ORA #%00000110
    STA collisionsToCheck 
        LDA tempA
        clc
        ADC tempB
        BNE hSpeedIsNotZero2
            ;; h speed is zero, which means no h direction
            LDA directionByte
            AND #%01111111
            STA directionByte
            JMP gotHmoveDirection
        hSpeedIsNotZero2:
            LDA directionByte
            ORA #%11000000 ;; "right"
            STA directionByte
gotHmoveDirection:



    LDA Object_v_speed_lo,x
    STA tempC
    LDA Object_v_speed_hi,x
    STA tempD
    

    LDA Object_direction,x
    AND #%00010000
    BNE isMovingDown
    ;isMovingUp

    ;;; set to check points 0 and 1 (top left and top right.)
    LDA collisionsToCheck
    ORA #%00000011
    STA collisionsToCheck 
    
        LDA tempC
        CLC
        ADC tempD
        BNE vSpeedIsNotZero
            ;; h speed is zero, which means no h direction
            LDA directionByte
            AND #%11011111
            STA directionByte
            JMP gotVmoveDirection
        vSpeedIsNotZero:
            LDA directionByte
            ORA #%00100000
            AND #%11101111 ;; "up"
            STA directionByte
    
    JMP gotVmoveDirection
isMovingDown:

    ;;; set to check points 2 and 3 (bottom left and bottom right.)
    LDA collisionsToCheck
    ORA #%00001100
    STA collisionsToCheck 
        LDA tempC
        CLC
        ADC tempD
        BNE vSpeedIsNotZero2
            ;; h speed is zero, which means no h direction
            LDA directionByte
            AND #%11011111
            STA directionByte
            JMP gotVmoveDirection
        vSpeedIsNotZero2:
            LDA directionByte
            ORA #%00110000 ;; "right"
            STA directionByte
    
    
gotVmoveDirection:
    
    LDA directionByte
    AND #%01000000
    BNE doMoveRight
;;doMoveLeft:
    LDA Object_x_lo,x
    SEC
    SBC tempA
    STA xHold_lo
    LDA Object_x_hi,x
    SBC tempB
    STA xHold_hi
	LDA currentNametable
   ; LDA Object_screen,x
   ; SBC #$00
    STA xHold_screen
    
    LDA #BOUNDS_LEFT
    BNE doNonZeroBoundsLeftCheck
        LDA Object_x_lo,x
        SEC
        SBC tempA
        LDA Object_x_hi,x
        SBC tempB
        BEQ doLeftBounds
        BCC doLeftBounds
            JMP doneWithH
    
    doNonZeroBoundsLeftCheck:
        LDA Object_x_lo,x
        SEC
        SBC tempA
        LDA Object_x_hi,x
        SBC tempB
    ;;;;;;;;;;;;;;;;; check xHold_hi against left bounds.
    CMP #BOUNDS_LEFT
    BEQ doLeftBounds
    BCC doLeftBounds
        JMP doneWithH
    doLeftBounds
        
			TXA
			STA temp
			GetActionStep temp
			CMP #$07
			BNE +notHurt
				JMP stopMovingDueToHurtState
			+notHurt
		
		
            LDA #$03
            STA screenUpdateByte
            JSR doHandleBounds
            JMP skipPhysics
doMoveRight:
    ;; update x position.
    
    LDA Object_x_lo,x
    clc
    adc tempA
    STA xHold_lo
    LDA Object_x_hi,x
    adc tempB
    STA xHold_hi
   ; LDA Object_screen,x
  ; ADC #$00
	LDA currentNametable
    STA xHold_screen
    

        LDA Object_x_hi,x
        clc
        ADC Object_h_speed_hi,x
        ADC self_right

    ;   
        BCS doRightBounds
            JMP doneWithH
        doRightBounds:
		
      
			TXA
			STA temp
			GetActionStep temp
			CMP #$07
			BNE +notHurt
				JMP stopMovingDueToHurtState
			+notHurt
            LDA #$01
            STA screenUpdateByte
	
            JSR doHandleBounds
            JMP skipPhysics
doneWithH:

;;; SKIP EDGE CHECK IF SCROLLING IS ENABLED
    ;;; CAN HANDLE ON BIT BASIS, SET UP IN INIT SCRIPTS
    ;;; BY USING THE HIGH BITS.

    

    
    LDA directionByte
    AND #%00010000
    BNE doMoveDown
;;doMoveUp:
    LDA #BOUNDS_TOP
    BNE doNonZeroBoundsTopCheck
        LDA Object_y_lo,x
        SEC
        SBC tempC
        STA yHold_lo
        LDA Object_y_hi,x
        SBC tempD
        STA yHold_hi
        BEQ doTopBounds
        BCC doTopBounds
            JMP doneWithV
    doNonZeroBoundsTopCheck:

    LDA Object_y_lo,x
    SEC
    SBC tempC
    STA yHold_lo
    LDA Object_y_hi,x
    SBC tempD
    STA yHold_hi
    ;;;;;;;;;;;;;;;;; check xHold_hi against left bounds.

    CMP #BOUNDS_TOP
    BEQ doTopBounds
    BCC doTopBounds
        JMP doneWithV
    doTopBounds
       
			TXA
			STA temp
			GetActionStep temp
			CMP #$07
			BNE +notHurt
				JMP stopMovingDueToHurtState
			+notHurt
            LDA #$02
            STA screenUpdateByte
	
            JSR doHandleBounds
            JMP skipPhysics
doMoveDown:
    ;; update x position.
    
    LDA Object_y_lo,x
    clc
    adc tempC
    STA yHold_lo
    LDA Object_y_hi,x
    adc tempD
    STA yHold_hi
    CLC
    ADC self_bottom
    CMP #BOUNDS_BOTTOM ;#240
;   BEQ doBottomBounds
    BCS doBottomBounds
        JMP doneWithV
    doBottomBounds:
       
			TXA
			STA temp
			GetActionStep temp
			CMP #$07
			BNE +notHurt
				JMP stopMovingDueToHurtState
			+notHurt
            LDA #$00
            STA screenUpdateByte
            JSR doHandleBounds
            JMP skipPhysics
doneWithV
	JMP skipPhysics
	
stopMovingDueToHurtState:
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
	


skipPhysics: