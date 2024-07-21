;;; this tile will instantly activate text upon player collision with it
;;; and then will change it's collision type to walkable, so that the collision
;;; only happens one time per screen load.

	;; from the jump, right now the tile offset should be loaded in temp1 and temp2 should determine what collision table we should look in.
	;;;;;;;;; First, let's turn the underlying tile into a normal walkable tile.
	LDY temp1
	LDA temp2
	BEQ +isEvenCt
		;; is an odd ct, so looking in collisionTable2
		LDA #$00
		STA collisionTable2,y
		JMP +doneWithTileUpdate
	+isEvenCt
		LDA #$00
		STA collisionTable,y
		
	+doneWithTileUpdate
	
	LDA npcTrigger
    ORA #%00000001
	STA npcTrigger
	

	DrawBox #BOX_1_ORIGIN_X, #BOX_1_ORIGIN_Y, #BOX_1_WIDTH , #BOX_1_HEIGHT, #TEXT_NPC, screenText

    ;;; x
    ;;; y
    ;;; width
    ;;; height
    ;;; text mode
        ;#TEXT_NPC pulls from the index in the following argument.
        ;#TEXT_FREE allows you to just write a label definition in the following argument
        ; and as long as you're in the right bank, will draw it.
    ;;; string or index.

   RTS
