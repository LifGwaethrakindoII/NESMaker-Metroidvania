;    LDA ScreenFlags00
;    AND #%00010000
;    BEQ +doActivateScrollByte
;        LDA scrollByte
;        AND #%00111111
;        STA scrollByte
;        RTS
;+doActivateScrollByte:
    RIGHT_SCROLL_PAD = #$90
    LDX player1_object
    LDA Object_x_hi,x
    SEC
    SBC camX
    CMP #RIGHT_SCROLL_PAD
    BEQ +doActivateScrollByte
    BCS +doActivateScrollByte
        LDA scrollByte
        AND #%00111111
        STA scrollByte
        RTS
+doActivateScrollByte
    LDA scrollByte
    AND #%01000000
    BNE +notChangingCamDirectionForUpdate
    LDA scrollByte
    ORA #%00000010
 +notChangingCamDirectionForUpdate
    AND #%00111111
    ORA #%11000000 
    STA scrollByte
    ;;; just like movement byte of a player.
    ;;; bit 7 indicates horizontal movement of a player
    ;;; bit 6 indicates 0 for left, 1 for right.
    
    RTS