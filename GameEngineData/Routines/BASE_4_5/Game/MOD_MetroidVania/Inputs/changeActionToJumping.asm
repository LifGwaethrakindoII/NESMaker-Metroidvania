    TXA
    STA temp ;; assumes the object we want to move is in x.
    ChangeActionStep temp, #$02 ;; assumes that "jump" is in action 2
            ;arg0 = what object?
            ;arg1 = what behavior?

    RTS