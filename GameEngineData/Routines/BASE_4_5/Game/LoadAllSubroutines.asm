	.include ROOT\Game\Subroutines\doBankswitchY.asm
	.include ROOT\Game\Subroutines\doLoadBackgroundPalette.asm
	.include ROOT\Game\Subroutines\doLoadObjectPalette.asm
	.include ROOT\Game\Subroutines\doLoadObjectSubPalette.asm
	.include ROOT\Game\Subroutines\doLoadChrRam.asm

	.include ROOT\Game\Subroutines\doLoadNametableData.asm
	.include ROOT\Game\Subroutines\doLoadAttributeData.asm
	.include ROOT\Game\Subroutines\doLoadCollisionTable.asm
	.include ROOT\Game\Subroutines\doCleanUpSpriteRam.asm
	.include ROOT\Game\Subroutines\doWaitFrame.asm
	.include ROOT\Game\Subroutines\doHandleBounds.asm
	.include ROOT\Game\Subroutines\doLoadScreen.asm
	.include ROOT\Game\Subroutines\doLoadScreen2.asm

	.include ROOT\Game\Subroutines\ToggleTables.asm
	.include ROOT\Game\Subroutines\ejectionSubroutines.asm
	.include ROOT\Game\Subroutines\doLoadScreenData.asm
	.include ROOT\Game\Subroutines\doLoadNametableDataFull.asm
	.include ROOT\Game\Subroutines\doHandleCreateState.asm
	.include ROOT\Game\Subroutines\doChangeActionStep.asm
	.include ROOT\Game\Subroutines\doGetRandomNumber.asm
	.include ROOT\Game\Subroutines\updateAction.asm
	.include ROOT\Game\Subroutines\doClearAllMonsters.asm
	;.include ROOT\Game\Subroutines\doDrawBox.asm
	.include ROOT\Game\Subroutines\doDrawText.asm
	.include ROOT\Game\Subroutines\doDrawTilesDirect.asm
	.include ROOT\Game\Subroutines\doDrawVariableTiles.asm
	.include ROOT\Game\Subroutines\doDrawNumbers.asm
	.include ROOT\Game\Subroutines\doUpdateHudElement.asm
	.include ROOT\Game\Subroutines\doUpdateHudTiles.asm
	.include ROOT\Game\Subroutines\doUpdateHudVarTiles.asm
	.include ROOT\Game\Subroutines\doUpdateHudNumber.asm



	.include SCR_HANDLE_SCREEN_UPDATE
	.include SCR_DRAW_BOX
	

	

	.include SCR_HANDLE_OBJECTS
	.include ROOT\Game\Subroutines\doHandleInputReads.asm
	.include ROOT\Game\Subroutines\doCreateObject.asm
	.include ROOT\Game\Subroutines\locationFinders.asm
	.include SCR_LOAD_SCROLL_COLUMN
	.include SCR_MENU_MANAGER
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; object subroutines
	.include SCR_UPDATE_POSITION
	.include SCR_START_MOVING
	.include SCR_STOP_MOVING
	.include SCR_CHANGE_FACING_DIRECTION
	;.include SCR_COMPARE_BBOX
	


doCamera:
	.include SCR_HANDLE_CAMERA
	RTS
doDrawHud:
	.include SCR_HANDLE_HUD
	RTS


.include "GameData\DataBank01_Includes.asm"

;; AI routines
AI_0:
	.include SCR_AI_0
	RTS
AI_1:
	.include SCR_AI_1
	RTS
AI_2:
	.include SCR_AI_2
	RTS
AI_3:
	.include SCR_AI_3
	RTS
AI_4:
	.include SCR_AI_4
	RTS
AI_5:
	.include SCR_AI_5
	RTS
AI_6:
	.include SCR_AI_6
	RTS
AI_7:
	.include SCR_AI_7
	RTS
AI_8:
	.include SCR_AI_8
	RTS
AI_9:
	.include SCR_AI_9
	RTS
AI_A:
	.include SCR_AI_A
	RTS
AI_B:
	.include SCR_AI_B
	RTS
AI_C:
	.include SCR_AI_C
	RTS
AI_D:
	.include SCR_AI_D
	RTS
AI_E:
	.include SCR_AI_E
	RTS
AI_F:
	.include SCR_AI_F
	RTS
	
	
AI_table_lo:
	.db #<AI_0, #<AI_1, #<AI_2, #<AI_3, #<AI_4, #<AI_5, #<AI_6, #<AI_7
	.db #<AI_8, #<AI_9, #<AI_A, #<AI_B, #<AI_C, #<AI_D, #<AI_E, #<AI_F
	
AI_table_hi:
	.db #>AI_0, #>AI_1, #>AI_2, #>AI_3, #>AI_4, #>AI_5, #>AI_6, #>AI_7
	.db #>AI_8, #>AI_9, #>AI_A, #>AI_B, #>AI_C, #>AI_D, #>AI_E, #>AI_F
	

DATABANK1 = #$18
