;1. iNES header
	.include SCR_HEADER
;2. Constants and variables
	.include SCR_SYSTEM_CONSTANTS
	.include "GameData\macroList.asm"
	.include SCR_MEMORY_MAP
;3. Include sound handling scripts needed
	.include "Sound\ggsound.inc"
;3. Handle bank assignments
	.include SCR_ASSIGN_BANKS
;4 The Reset
	.include SCR_RESET
;5 Initialization of things.
	.include SCR_INITIALIZE
	JMP StartMainGameLoop
;6 NMI
	.include SCR_NMI
;7. main game loop
StartMainGameLoop:
	.include SCR_MAIN_LOOP	
;8. subroutines
	.include "GameData\ScriptTables.asm"
	.include SCR_MATH_FUNCTIONS
	.include SCR_LOAD_SUBROUTINES
;9. Vectors
	.include SCR_VECTORS
	
