;;; Create a Projectile.
;;; Assumes that the projectile you want to create is in GameObject Slot 01.
;;; Assumes variable called myAmmo exists.
;;; assumes myAmmo is in hud element 8.
    LDA myAmmo
    BNE +canShootMega
		LDA #$01 ;; assumes normal projectile is in 1
		STA tempz ;; we will use tempz to hold which type of projectile.
					;;; if I had no special ammo, i'll just use normal projectile
        JMP +shootThing
    +canShootMega:
		;;; but if i DID have ammo, I'll shoot mega shot!
		LDA #$02 ;; assumes mega projectile is in 2.
		STA tempz
    ;; there is ammo here.
    DEC myAmmo
  ;  UpdateHudElement #$03 ;; change this to which element shows myAmmo.
	+shootThing
    TXA
    PHA
    TYA
    PHA
        LDX player1_object
        LDA Object_x_hi,x
            CLC
        ADC #$04
        STA tempA
        LDA Object_screen,x
        ADC #$00
        STA tempD
        LDA Object_y_hi,x
            CLC
        ADC #$04
        STA tempB
        LDA Object_direction,x
        AND #%00000111
        STA tempC
        CreateObjectOnScreen tempA, tempB, tempz, #$00, tempD
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
+canNotShoot:
    RTS