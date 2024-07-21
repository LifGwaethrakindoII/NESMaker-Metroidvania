;;; ladder script.
;;; if up is engaged, check for a collision with a ladder.
;;; check the pixel just below feet, and the pixel just below top of bounding box.

LDX player1_object
    LDA Object_x_hi,x
    CLC
    adc #$08 ;; MIDDLE OF PLAYER
    STA temp
        JSR getPointColTable

    LDA Object_y_hi,x
    CLC
    ADC #$0f ;; height of player plus arbitrary number to check. (if player is #$10 pixels tall, maybe put #$12 here to check just below his feet).
                ;; reccommended, use the ladder speed that you set below.
    STA temp1
    ;;; CHECK FOR SOLID TILE, which is tile type 1 in this module.
    CheckCollisionPoint temp, temp1, #$0A, tempA ;; is it a solid?
    BNE +notLadder

    ;; there is a ladder at my feet.
    LDA Object_y_hi,x
    sec
    sbc #$01 ;; ladder speed
    STA Object_y_hi,x
    
    GetActionStep player1_object
    CMP #$03 ;; in this module, the player's action step 3 is for climbing
    BEQ +alreadyOnLadder
        LDA gamepad
        AND #%11000000
        BNE +alreadyOnLadder ;; will turn off ladder if right or left is pressed.
        ChangeActionStep player1_object, #$03
        LDA Object_direction,x
        AND #%00001111
        STA Object_direction,x
    +alreadyOnLadder
     RTS
+notLadder
   GetActionStep player1_object
   CMP #$03
   BNE +notClimbing
   ChangeActionStep player1_object, #$00
+notClimbing
    RTS