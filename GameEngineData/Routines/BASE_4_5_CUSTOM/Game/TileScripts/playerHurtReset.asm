;;; Simple Reset
	;; check to see if object colliding is a player.
	;; if not, do not reset.
	CPX player1_object
	BNE dontDoTileReset
	JMP RESET
dontDoTileReset: