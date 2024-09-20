;;; sprite pre draw


.include SCR_DRAW_SPRITE_HUD

;;; USE THE FOLLOWING TO DRAW YOUR WEAPON CHOICE TO THE SCREEN.
;;; MUST EXIST weaponChoiceTable.
;;;; UNCOMMENT UP TO DrawSprite to use.
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; you can change the hex values here to change what sprite in the gameobjects tileset
;;; correlates to which weapon to be drawn.
WEAPON_SPRITE_0 = #$2C
WEAPON_SPRITE_1 = #$29
WEAPON_SPRITE_2 = #$39
WEAPON_SPRITE_3 = #$74
WEAPON_SPRITE_4 = #$04
WEAPON_SPRITE_5 = #$05
WEAPON_SPRITE_6 = #$06
WEAPON_SPRITE_7 = #$07
WEAPON_SPRITE_BLANK = #$1C

; ;;;; Here we will draw the sprite that is represented by our selected weapon to the screen.
;;; TO USE, UNCOMMENT THE FOLLOWING LINES.

; LDY weaponChoice
; LDA SelectedWeaponSpriteToDraw,y
; STA temp

 ;        LDA weaponChoiceTable,y
 ;        AND weaponsUnlocked
 ;        BNE +drawWeapon
			 ;;;;; We don't have this weapon yet, so draw it blank.
;			 LDA #WEAPON_SPRITE_BLANK;
;			 STA temp
; +drawWeapon

; DrawSprite #$8C, #$0F, temp, #$00
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;