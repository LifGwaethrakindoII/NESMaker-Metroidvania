 
 ;    LDA ScreenFlags00
 ;    AND #%00100000
 ;   BEQ +doActivateScrollByte
 ;       LDA scrollByte
 ;       AND #%00111111
 ;       STA scrollByte
 ;       RTS
 ;+doActivateScrollByte:
    LEFT_SCROLL_PAD = #$60
    LDX player1_object
    LDA Object_x_hi,x
    SEC
    SBC camX
    CMP #LEFT_SCROLL_PAD
    BEQ +doActivateScrollByte
    BCC +doActivateScrollByte
        LDA scrollByte
        AND #%00111111
        STA scrollByte
        RTS
+doActivateScrollByte
    LDA scrollByte
    AND #%01000000
    BEQ +notChangingCamDirectionForUpdate
    LDA scrollByte
    ORA #%00000010
+notChangingCamDirectionForUpdate
    
    AND #%00111111
    ORA #%10000000  ;; bit one forces an update.
    STA scrollByte
    ;;; just like movement byte of a player.
    ;;; bit 7 indicates horizontal movement of a player
    ;;; bit 6 indicates 0 for left, 1 for right.
    
    rts