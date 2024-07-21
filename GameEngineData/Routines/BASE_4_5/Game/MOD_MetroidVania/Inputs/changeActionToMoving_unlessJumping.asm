    TXA
    STA temp ;; assumes the object we want to move is in x.
 GetActionStep temp
    CMP #$07
    BNE +notHurt
        RTS
    +notHurt
	CMP #$02 ;; the state of your jump animation
	BNE +notJumping
		RTS
	+notJumping
        ChangeActionStep temp, #$01 ;; assumes that "walk" is in action 1
            ;arg0 = what object?
            ;arg1 = what behavior?

    RTS