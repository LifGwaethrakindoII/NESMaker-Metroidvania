;;; sprite pre draw
LDA gameSubState
CMP #$01
BNE +notGameSubState1
	;;; in the command menu.
	LDY currentCommandChoice
	LDA commandMenuChoiceX,y
	STA tempA
	LDA commandMenuChoiceY,y
	STA tempB
	LDA #COMMAND_BOX_CURSOR
	STA tempC
	DrawSprite tempA, tempB, tempC, #$00
	JMP +doneWithMenuCursor
+notGameSubState1
	CMP #$02
	BNE +notGameSubState2
	;;; in the STATUS submenu.
	;;; no cursors in the status menu.
	JMP +doneWithMenuCursor
+notGameSubState2
	CMP #$03 ;; is it the spell submenu?
	BNE +notGameSubState3
		LDY currentSubmenuChoice
		LDA spellMenuChoiceX,y
		STA tempA
		LDA spellMenuChoiceY,y
		STA tempB
		LDA #SPELL_BOX_CURSOR
		STA tempC
		DrawSprite tempA, tempB, tempC, #$00
		JMP +doneWithMenuCursor
+notGameSubState3

+doneWithMenuCursor