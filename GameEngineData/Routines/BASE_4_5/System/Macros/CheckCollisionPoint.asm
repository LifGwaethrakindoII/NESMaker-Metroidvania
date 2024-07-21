MACRO CheckCollisionPoint arg0, arg1, arg2, arg3
	;; arg0 = x
	;; arg1 = y
	;; arg2 = collision type to check for.
	;; arg3 = which collision table, left or right? 0 = left, 1 = right
	;; assumes object calling is in X.
	
	LDA arg0
	STA tileX
	LDA arg1
	STA tileY
	JSR GetTileAtPosition
	;; now the offset is loaded into y
	LDA arg3
	;LDA Object_screen,x
	;AND #%00000001
	BNE +checkCollisionScreenRight
		;;; check left collision screen
		LDA collisionTable,y
		CMP arg2
		JMP +checkedCollisionScreen
	+checkCollisionScreenRight
		LDA collisionTable2,y
		CMP arg2
	+checkedCollisionScreen:
	;;; now, accumulator will be zero if they are equal.
	
	ENDM