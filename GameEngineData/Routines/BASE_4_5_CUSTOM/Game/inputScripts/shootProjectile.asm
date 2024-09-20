;;; Create a Projectile.
;;; Assumes that the projectile you want to create is in GameObject Slot 01.

    TXA
    PHA
    TYA
    PHA
        LDX player1_object
        LDA Object_screen,x
   
        STA tempD
        LDA Object_x_hi,x
            CLC
        ADC #$04
        STA tempA
        LDA Object_y_hi,x
        CLC
        ADC #$04
        STA tempB
        LDA Object_direction,x
        AND #%00000111
        STA tempC
        CreateObjectOnScreen tempA, tempB, #$01, #$00, tempD
            ;;; x, y, object, starting action.
            ;;; and now with that object, copy the player's
            ;;; direction and start it moving that way.
            LDA tempC
            STA Object_direction,x
            TAY
            LDA DirectionTableOrdered,y
            STA temp1
            TXA
            STA temp
            StartMoving temp, temp1
    PLA
    TAY
    PLA
    TAX
    
    RTS