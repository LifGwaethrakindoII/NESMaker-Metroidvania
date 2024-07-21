SelectedWeaponSpriteToDraw:
	.db #WEAPON_SPRITE_0, #WEAPON_SPRITE_1, #WEAPON_SPRITE_2, #WEAPON_SPRITE_3, #WEAPON_SPRITE_4
	.db #WEAPON_SPRITE_5, #WEAPON_SPRITE_6, #WEAPON_SPRITE_7
	
DropTable:
	.db #DROPABLE_00, #DROPABLE_01, #DROPABLE_02, #DROPABLE_03
	.db #DROPABLE_04, #DROPABLE_05, #DROPABLE_06, #DROPABLE_07
	
	
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; here, we load in <label and >label for each library value we might want.
TextLibrary_lo:
	.db #$00
TextLibrary_hi:
	.db #$00
