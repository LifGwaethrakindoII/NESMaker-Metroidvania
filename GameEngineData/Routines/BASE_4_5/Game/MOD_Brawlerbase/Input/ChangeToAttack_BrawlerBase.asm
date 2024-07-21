    ;; if you would like unlockable weapons, 
    ;; that will be created with the b button
    ;; use this code.
  
 
    
 
    TXA
    STA temp ;; assumes the object that we want is in x.

    GetActionStep temp
    CMP #$02 ;; is it already attacking?
    BNE +canAttack
        ;; wait until we're back to idle to attack again. 
        RTS
    +canAttack
    ChangeActionStep temp, #$02 ;; assumes that "attack" is in action 2
    ;arg0 = what object?
    ;arg1 = what behavior?
    StopMoving temp, #$FF, #$00
    
    

        WEAPON_POSITION_RIGHT_X = #$10
        WEAPON_POSITION_RIGHT_Y = #$08
  
        WEAPON_POSITION_LEFT_X = #$F8
        WEAPON_POSITION_LEFT_Y = #$08
        WEAPON_OBJECT = #$01
        WEAPON_RIGHT_STATE = #$00
        WEAPON_LEFT_STATE = #$00

        
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;; Now, we have to create the object.
        ;; We will need to determine the direction
        ;; of the player.
        LDX player1_object
        TXA
        STA temp
        GetObjectDirection temp ;; temp still observed from above.
            ;;; this object's direction is now loaded into the 
            ;;; accumulator for comparison after the macro.
            ;; 0 = down
            ;; 1 = downright
            ;; 2 = right
            ;; 3 = upright
            ;; 4 = up
            ;; 5 = upleft
            ;; 6 = left
            ;; 7 = downleft
          
                CMP #$02
                BNE +notRight
                ;;; CREATE RIGHT WEAPON
                LDX player1_object
                LDA Object_x_hi,x
                CLC
                ADC #WEAPON_POSITION_RIGHT_X
                STA tempA
                 LDA Object_screen,x
                ADC #$00
                STA tempD
                
                LDA Object_y_hi,x
                CLC
                ADC #WEAPON_POSITION_RIGHT_Y
                STA tempB
               
                LDA #WEAPON_OBJECT
                STA tempC
                
              
               ;; use this is you want to always create a single object, based on
                   ;; the constant above.
                   ; CreateObject tempA, tempB, #WEAPON_OBJECT, #WEAPON_RIGHT_STATE, currentNametable
                 
                   ;;; use this if you want to create a variable object based on 
                   ;;; the weaponChoice varaible.
                   CreateObjectOnScreen tempA, tempB, tempC, #WEAPON_RIGHT_STATE, tempD
                   LDA #%11000000
                   STA Object_direction,x
                   JMP +doneWithCreatingWeapon
            +notRight
            
                ;;; CREATE LEFT WEAPON
                LDX player1_object
                LDA Object_x_hi,x
                CLC
                ADC #WEAPON_POSITION_LEFT_X
                STA tempA
                LDA Object_screen,x
                SBC #$00
                STA tempD
                LDA Object_y_hi,x
                CLC
                ADC #WEAPON_POSITION_LEFT_Y
                STA tempB
                
                LDA #WEAPON_OBJECT
                STA tempC
               ;; use this is you want to always create a single object, based on
                   ;; the constant above.
                   ; CreateObject tempA, tempB, #WEAPON_OBJECT, #WEAPON_DOWN_STATE, currentNametable
                 
                   ;;; use this if you want to create a variable object based on 
                   ;;; the weaponChoice varaible.
                   CreateObjectOnScreen tempA, tempB, tempC, #WEAPON_LEFT_STATE, tempD
                 LDA #%10000000
                 STA Object_direction,x
                 JMP +doneWithCreatingWeapon
            +notLeft
            
        +doneWithCreatingWeapon  
        
    RTS


