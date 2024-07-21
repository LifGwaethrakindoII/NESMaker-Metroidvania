MACRO GetCollisionPoint arg0, arg1, arg2
	;; arg0 = x
	;; arg1 = y
	;; arg2 = which collision table, left or right? 0 = left, 1 = right
	;; assumes object calling is in X.
	
	LDA arg0
	STA tileX
	LDA arg1
	STA tileY
	JSR GetTileAtPosition
	;; now the offset is loaded into y
	LDA arg2
	;LDA Object_screen,x
	AND #%00000001
	BNE +checkCollisionScreenRight
		;;; check left collision screen
		LDA collisionTable,y
		JMP +checkedCollisionScreen
	+checkCollisionScreenRight
		LDA collisionTable2,y
	+checkedCollisionScreen:
	;;; now, accumulator will hold collision of point
	
	ENDM