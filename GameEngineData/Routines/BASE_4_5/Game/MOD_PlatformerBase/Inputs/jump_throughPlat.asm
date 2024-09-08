;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Only can jump if the place below feet is free.
    SwitchBank #$1C
    LDY Object_type,x
    LDA ObjectBboxTop,y
    CLC
    ADC ObjectHeight,y
    sta temp2
    
    LDA Object_x_hi,x
    CLC
    ADC ObjectBboxLeft,y
    STA temp
    JSR getPointColTable
    
    LDA Object_y_hi,x
    CLC
    ADC #$02
    CLC
    ADC temp2
    STA temp1
    CheckCollisionPoint temp, temp1, #$01, tempA ;; check below feet to see if it is solid.
                                        ;;; if it is (equal), can jump.
                                        ;;; if not, skips jumping.
    BNE +checkMore 
        JMP +doJump
    +checkMore
    
    CheckCollisionPoint temp, temp1, #$07, tempA ;; check below feet to see if it is jumpthrough platform.
                                        ;;; if it is (equal), can jump.
                                        ;;; if not, skips jumping.
    BNE +checkMore 
        JMP +doJump
    +checkMore
     CheckCollisionPoint temp, temp1, #$09, tempA ;; check below feet to see if it is prize block .
                                        ;;; if it is (equal), can jump.
                                        ;;; if not, skips jumping.
    BNE +checkMore 
        JMP +doJump
    +checkMore
    CheckCollisionPoint temp, temp1, #$0A, tempA ;; check below feet to see if it is ladder.
                                        ;;; if it is (equal), can jump.
                                        ;;; if not, skips jumping.
     BNE +dontDoJump
          JMP  +doJump
        +dontDoJump
            ;; check second point.
        LDY Object_type,x
        LDA ObjectWidth,y
        CLC
        ADC temp
        STA temp
        JSR getPointColTable
        CheckCollisionPoint temp, temp1, #$01, tempA ;; check below feet to see if it is solid.
                                            ;;; if it is (equal), can jump.
                                            ;;; if not, skips jumping.          
        BEQ +doJump
        
        CheckCollisionPoint temp, temp1, #$07, tempA ;; check below feet to see if it is jumpthrough platform.
                                        ;;; if it is (equal), can jump.
                                        ;;; if not, skips jumping.
        BEQ +doJump
        CheckCollisionPoint temp, temp1, #$09, tempA ;; check below feet to see if it is jumpthrough platform.
                                        ;;; if it is (equal), can jump.
                                        ;;; if not, skips jumping.
        BEQ +doJump
        CheckCollisionPoint temp, temp1, #$0A, tempA ;; check below feet to see if it is ladder.
                                        ;;; if it is (equal), can jump.
                                        ;;; if not, skips jumping.
        BEQ +doJump
            JMP +skipJumping
+doJump:
    TXA
    STA temp ;; assumes the object we want to move is in x.
    ;;PlaySound #sfx_thump COMENTE EL EJECUTAR SONIDO DE SALTO PORQUE BECAUSE IS MISSING.

    LDY Object_type,x
    LDA ObjectJumpSpeedLo,y
    EOR #$FF
    STA Object_v_speed_lo,x
    LDA ObjectJumpSpeedHi,y
    EOR #$FF
    STA Object_v_speed_hi,x
        
    TXA
    STA temp ;; assumes the object we want to move is in x.
 ;  change the object's action so that he is in jump mode.

+skipJumping:
    ReturnBank
    RTS