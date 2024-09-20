    TXA
    STA temp ;; assumes the object we want to move is in x.
 GetActionStep temp
    CMP #$07
    BNE +notHurt
        RTS
    +notHurt
	CMP #$02
	BEQ +skip ;; don't change to walk if we are punching.
	CMP #$01
	BEQ +alreadyInWalkState
        ChangeActionStep temp, #$01 ;; assumes that "walk" is in action 1
            ;arg0 = what object?
            ;arg1 = what behavior?
	+alreadyInWalkState
	+skip
    RTS