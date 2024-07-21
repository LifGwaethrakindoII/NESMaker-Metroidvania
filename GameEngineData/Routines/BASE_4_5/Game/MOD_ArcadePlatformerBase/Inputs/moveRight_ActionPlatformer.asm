;;;; 
    TXA
    STA temp ;; assumes the object we want to move is in x.
  GetActionStep temp
    CMP #$07
    BNE +notHurt
        RTS
    +notHurt
      GetActionStep temp
    CMP #$03 ;; is it climbing?
    BNE +notClimbing
        ChangeActionStep temp, #$00
    +notClimbing
        StartMoving temp, #RIGHT
        TXA
        STA temp ;; assumes the object we want to move is in x.
        ChangeFacingDirection temp, #FACE_RIGHT
        
    RTS