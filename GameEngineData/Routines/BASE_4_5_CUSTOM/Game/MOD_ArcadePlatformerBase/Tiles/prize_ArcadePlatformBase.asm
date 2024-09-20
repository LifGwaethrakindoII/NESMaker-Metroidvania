;;; prize tile

CPX player1_object
BEQ +isPlayer
	JMP +notPlayer
	+isPlayer
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; BELOW WILL CHANGE TILE AT COLLISION.
	
	ChangeTileAtCollision #$00, #$00
	
	;MACRO AddValue arg0, arg1, arg2, arg3
	;arg0 = how many places this value has.
	;arg1 = home variable
	;arg2 = amount to add
	;arg3 = what place value is receiving the addition?
		;;; 0 = ones place, 1 = tens place, 2 = hundreds place, etc.
	
	AddValue #$08, myScore, #$1, #$02
	UpdateHudElement #$03
	
	+notPlayer