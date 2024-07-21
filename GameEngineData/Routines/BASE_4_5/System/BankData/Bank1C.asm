;;; ALL THE DATA FIRST
.include "ScreenData\ObjectInfo.dat"
.include "ScreenData\ObjectPointers.pnt"
.include "ScreenData\ObjectData\ObjectLutTable.dat"

;=========================================================
.include ROOT\Game\Subroutines\TimerEndScripts.asm
.include ROOT\Game\Subroutines\doObjectAction.asm
;========================================================

.include SCR_COMPARE_BBOX

;; do draw sprites
doDrawSprites:
	.include SCR_HANDLE_DRAWING_SPRITES
	rts

doUpdateSpriteTimer:
	.include SCR_UPDATE_SPRITE_TIMER
	RTS
	
doUpdateActionTimer:
	.include SCR_UPDATE_ACTION_TIMER
	RTS
doObjectCollisions_bank1C:
	.include SCR_OBJECT_COLLISION_STATE
	.include SCR_HANDLE_OBJECT_COLLISIONS
	RTS
	

;; Game specific, common
doHandleHurtPlayer:
	.include SCR_HANDLE_PLAYER_HURT
	RTS
doHandleHurtMonster:
	.include SCR_HANDLE_MONSTER_HURT
	RTS
	
	
ObjectLoSpriteAddressLo:
	.db #<GameItem0_Lo, #<GameItem1_Lo, #<GameItem2_Lo, #<GameItem3_Lo, #<GameItem4_Lo, #<GameItem5_Lo, #<GameItem6_Lo, #<GameItem7_Lo
	.db #<GameItem8_Lo, #<GameItem9_Lo,#<GameItem10_Lo,#<GameItem11_Lo,#<GameItem12_Lo,#<GameItem13_Lo,#<GameItem14_Lo,#<GameItem15_Lo
	
	.db #<Object0_Lo,#<Object1_Lo,#<Object2_Lo,#<Object3_Lo,#<Object4_Lo,#<Object5_Lo,#<Object6_Lo,#<Object7_Lo
	.db #<Object8_Lo,#<Object9_Lo,#<Object10_Lo,#<Object11_Lo,#<Object12_Lo,#<Object13_Lo,#<Object14_Lo,#<Object15_Lo
	.db #<Object16_Lo,#<Object17_Lo,#<Object18_Lo,#<Object19_Lo,#<Object20_Lo,#<Object21_Lo,#<Object22_Lo,#<Object23_Lo
	.db #<Object24_Lo,#<Object25_Lo,#<Object26_Lo,#<Object27_Lo,#<Object28_Lo,#<Object29_Lo,#<Object30_Lo,#<Object31_Lo
	.db #<Object32_Lo,#<Object33_Lo,#<Object34_Lo,#<Object35_Lo,#<Object36_Lo,#<Object37_Lo,#<Object38_Lo,#<Object39_Lo
	.db #<Object40_Lo,#<Object41_Lo,#<Object42_Lo,#<Object43_Lo,#<Object44_Lo,#<Object45_Lo,#<Object46_Lo,#<Object47_Lo
	.db #<Object48_Lo,#<Object49_Lo,#<Object50_Lo,#<Object51_Lo,#<Object52_Lo,#<Object53_Lo,#<Object54_Lo,#<Object55_Lo
	.db #<Object56_Lo,#<Object57_Lo,#<Object58_Lo,#<Object59_Lo,#<Object60_Lo,#<Object61_Lo,#<Object62_Lo,#<Object63_Lo
	
ObjectLoSpriteAddressHi:
	.db #>GameItem0_Lo, #>GameItem1_Lo, #>GameItem2_Lo, #>GameItem3_Lo, #>GameItem4_Lo, #>GameItem5_Lo, #>GameItem6_Lo, #>GameItem7_Lo
	.db #>GameItem8_Lo, #>GameItem9_Lo,#>GameItem10_Lo,#>GameItem11_Lo,#>GameItem12_Lo,#>GameItem13_Lo,#>GameItem14_Lo,#>GameItem15_Lo
	
	.db #>Object0_Lo,#>Object1_Lo,#>Object2_Lo,#>Object3_Lo,#>Object4_Lo,#>Object5_Lo,#>Object6_Lo,#>Object7_Lo
	.db #>Object8_Lo,#>Object9_Lo,#>Object10_Lo,#>Object11_Lo,#>Object12_Lo,#>Object13_Lo,#>Object14_Lo,#>Object15_Lo
	.db #>Object16_Lo,#>Object17_Lo,#>Object18_Lo,#>Object19_Lo,#>Object20_Lo,#>Object21_Lo,#>Object22_Lo,#>Object23_Lo
	.db #>Object24_Lo,#>Object25_Lo,#>Object26_Lo,#>Object27_Lo,#>Object28_Lo,#>Object29_Lo,#>Object30_Lo,#>Object31_Lo
	.db #>Object32_Lo,#>Object33_Lo,#>Object34_Lo,#>Object35_Lo,#>Object36_Lo,#>Object37_Lo,#>Object38_Lo,#>Object39_Lo
	.db #>Object40_Lo,#>Object41_Lo,#>Object42_Lo,#>Object43_Lo,#>Object44_Lo,#>Object45_Lo,#>Object46_Lo,#>Object47_Lo
	.db #>Object48_Lo,#>Object49_Lo,#>Object50_Lo,#>Object51_Lo,#>Object52_Lo,#>Object53_Lo,#>Object54_Lo,#>Object55_Lo
	.db #>Object56_Lo,#>Object57_Lo,#>Object58_Lo,#>Object59_Lo,#>Object60_Lo,#>Object61_Lo,#>Object62_Lo,#>Object63_Lo


ObjectHiSpriteAddressLo:
		.db #<GameItem0_Hi, #<GameItem1_Hi, #<GameItem2_Hi, #<GameItem3_Hi, #<GameItem4_Hi, #<GameItem5_Hi, #<GameItem6_Hi, #<GameItem7_Hi
	.db #<GameItem8_Hi, #<GameItem9_Hi,#<GameItem10_Hi,#<GameItem11_Hi,#<GameItem12_Hi,#<GameItem13_Hi,#<GameItem14_Hi,#<GameItem15_Hi
	
	.db #<Object0_Hi,#<Object1_Hi,#<Object2_Hi,#<Object3_Hi,#<Object4_Hi,#<Object5_Hi,#<Object6_Hi,#<Object7_Hi
	.db #<Object8_Hi,#<Object9_Hi,#<Object10_Hi,#<Object11_Hi,#<Object12_Hi,#<Object13_Hi,#<Object14_Hi,#<Object15_Hi
	.db #<Object16_Hi,#<Object17_Hi,#<Object18_Hi,#<Object19_Hi,#<Object20_Hi,#<Object21_Hi,#<Object22_Hi,#<Object23_Hi
	.db #<Object24_Hi,#<Object25_Hi,#<Object26_Hi,#<Object27_Hi,#<Object28_Hi,#<Object29_Hi,#<Object30_Hi,#<Object31_Hi
	.db #<Object32_Hi,#<Object33_Hi,#<Object34_Hi,#<Object35_Hi,#<Object36_Hi,#<Object37_Hi,#<Object38_Hi,#<Object39_Hi
	.db #<Object40_Hi,#<Object41_Hi,#<Object42_Hi,#<Object43_Hi,#<Object44_Hi,#<Object45_Hi,#<Object46_Hi,#<Object47_Hi
	.db #<Object48_Hi,#<Object49_Hi,#<Object50_Hi,#<Object51_Hi,#<Object52_Hi,#<Object53_Hi,#<Object54_Hi,#<Object55_Hi
	.db #<Object56_Hi,#<Object57_Hi,#<Object58_Hi,#<Object59_Hi,#<Object60_Hi,#<Object61_Hi,#<Object62_Hi,#<Object63_Hi
	
ObjectHiSpriteAddressHi:
	.db #>GameItem0_Hi, #>GameItem1_Hi, #>GameItem2_Hi, #>GameItem3_Hi, #>GameItem4_Hi, #>GameItem5_Hi, #>GameItem6_Hi, #>GameItem7_Hi
	.db #>GameItem8_Hi, #>GameItem9_Hi,#>GameItem10_Hi,#>GameItem11_Hi,#>GameItem12_Hi,#>GameItem13_Hi,#>GameItem14_Hi,#>GameItem15_Hi
	
	.db #>Object0_Hi,#>Object1_Hi,#>Object2_Hi,#>Object3_Hi,#>Object4_Hi,#>Object5_Hi,#>Object6_Hi,#>Object7_Hi
	.db #>Object8_Hi,#>Object9_Hi,#>Object10_Hi,#>Object11_Hi,#>Object12_Hi,#>Object13_Hi,#>Object14_Hi,#>Object15_Hi
	.db #>Object16_Hi,#>Object17_Hi,#>Object18_Hi,#>Object19_Hi,#>Object20_Hi,#>Object21_Hi,#>Object22_Hi,#>Object23_Hi
	.db #>Object24_Hi,#>Object25_Hi,#>Object26_Hi,#>Object27_Hi,#>Object28_Hi,#>Object29_Hi,#>Object30_Hi,#>Object31_Hi
	.db #>Object32_Hi,#>Object33_Hi,#>Object34_Hi,#>Object35_Hi,#>Object36_Hi,#>Object37_Hi,#>Object38_Hi,#>Object39_Hi
	.db #>Object40_Hi,#>Object41_Hi,#>Object42_Hi,#>Object43_Hi,#>Object44_Hi,#>Object45_Hi,#>Object46_Hi,#>Object47_Hi
	.db #>Object48_Hi,#>Object49_Hi,#>Object50_Hi,#>Object51_Hi,#>Object52_Hi,#>Object53_Hi,#>Object54_Hi,#>Object55_Hi
	.db #>Object56_Hi,#>Object57_Hi,#>Object58_Hi,#>Object59_Hi,#>Object60_Hi,#>Object61_Hi,#>Object62_Hi,#>Object63_Hi
	