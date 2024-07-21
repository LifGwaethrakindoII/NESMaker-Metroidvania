;;;; 
   
    TXA
    STA temp ;; assumes the object we want to move is in x.
    GetActionStep temp
    CMP #$07
    BNE +notHurt
        RTS
    +notHurt
        StartMoving temp, #DOWN
 

    RTS