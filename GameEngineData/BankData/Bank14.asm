.include "Routines\DrawSSplayerSprites.asm"
.include "Routines\DoMenuStuff.asm"

	.include "Routines\HandleMonProjPositionUpdate.asm"
	.include "Routines\MonsterActionRoutines.asm"	
	
	.include "Routines\TileTypeBehaviors.asm"
	
	
	.include "Routines\HandleBackgroundCollisions.asm"
	.include "Routines\HandleGroundType.asm"
	
	.include "Routines\HandleHud.asm"
	
	.include "Routines\DeactivateCurrentObject.asm"
	
	.include "Routines\LeaveBehind.asm"
	.include "Routines\InitLoads.asm"
	.include "Routines\Division.asm"
	
	.include "Routines\SwapTiles.asm"
	.include "Routines\doNMIstuff.asm"
	.include "Routines\drawAnimatedPlinths.asm"
	.include "Routines\loadMyMonsters.asm"
			
	.include "Routines\drawMyNPCsprite.asm"
	
	.include "Routines\drawMyCharge.asm"
	
	.include "Routines\doObjectCollisionsInBank14.asm"
	
		.include "Routines\doMovementStuff.asm"
		.include "Routines\KeepScore.asm"
		
		.include "Routines\FigureWhichItemsToShow.asm"
			
projBehaviorTableLo:
	.db #<Proj_AI_0, #<Proj_AI_1, #<Proj_AI_2, #<Proj_AI_3, #<Proj_AI_4, #<Proj_AI_5, #<Proj_AI_6, #<Proj_AI_7
projBehaviorTableHi:
	.db #>Proj_AI_0, #>Proj_AI_1, #>Proj_AI_2, #>Proj_AI_3, #>Proj_AI_4, #>Proj_AI_5, #>Proj_AI_6, #>Proj_AI_7
		
		
tileTypeBehaviorLo:
	.db #<TileType00Collision, #<TileType01Collision, #<TileType02Collision, #<TileType03Collision
	.db #<TileType04Collision, #<TileType05Collision, #<TileType06Collision, #<TileType07Collision
	.db #<TileType08Collision, #<TileType09Collision, #<TileType10Collision, #<TileType11Collision
	.db #<TileType12Collision, #<TileType13Collision, #<TileType14Collision, #<TileType15Collision
	.db #<TileType16Collision, #<TileType17Collision, #<TileType18Collision, #<TileType19Collision
	.db #<TileType20Collision, #<TileType21Collision, #<TileType22Collision, #<TileType23Collision
	.db #<TileType24Collision, #<TileType25Collision, #<TileType26Collision, #<TileType27Collision
	.db #<TileType28Collision, #<TileType29Collision, #<TileType30Collision, #<TileType31Collision
	
tileTypeBehaviorHi:	
	.db #>TileType00Collision, #>TileType01Collision, #>TileType02Collision, #>TileType03Collision
	.db #>TileType04Collision, #>TileType05Collision, #>TileType06Collision, #>TileType07Collision
	.db #>TileType08Collision, #>TileType09Collision, #>TileType10Collision, #>TileType11Collision
	.db #>TileType12Collision, #>TileType13Collision, #>TileType14Collision, #>TileType15Collision
	.db #>TileType16Collision, #>TileType17Collision, #>TileType18Collision, #>TileType19Collision
	.db #>TileType20Collision, #>TileType21Collision, #>TileType22Collision, #>TileType23Collision
	.db #>TileType24Collision, #>TileType25Collision, #>TileType26Collision, #>TileType27Collision
	.db #>TileType28Collision, #>TileType29Collision, #>TileType30Collision, #>TileType31Collision
		
		
		
edgeActionNull:

	RTS
		
stopObjectFromMoving:
	LDA #$00
	STA ObjectHSpeedLo,x
	STA ObjectHSpeedHi,x
	STA ObjectVSpeedLo,x
	STA ObjectVSpeedHi,x
	RTS
	
	
destroyObjectWhenHitSolid:
	JSR ActivatePoof
	RTS
	
destroyOtherWhenHitSolid:
	RTS
	
reverseWhenHitSolid:
	LDA ObjectMovementByte,x
	AND #%00001111
	STA temp
	LDA ObjectDirection,x
	JSR ReverseDirection
	STA ObjectDirection,x
	LDA #$00
	STA ObjectHSpeedLo,x
	STA ObjectHSpeedHi,x
	STA ObjectVSpeedLo,x
	STA ObjectVSpeedHi,x
	LDY ObjectDirection,x
	LDA AIDirectionTable,y
	AND #%11110000
	ora temp
	STA ObjectMovementByte,x
	RTS

	
unspawnAction:
	RTS
	
oppositeWhenHitSolid:
	LDA ObjectMovementByte,x
	AND #%00001111
	STA temp
	LDA ObjectDirection,x
	JSR OppositeDirection
	STA ObjectDirection,x
	LDA #$00
	STA ObjectHSpeedLo,x
	STA ObjectHSpeedHi,x
	STA ObjectVSpeedLo,x
	STA ObjectVSpeedHi,x
	LDY ObjectDirection,x
	LDA AIDirectionTable,y
	AND #%11110000
	ora temp
	STA ObjectMovementByte,x
	RTS

jumpWhenHitSolid:
	RTS
	
	
	
solidBehaviorLo:
	.db #<edgeActionNull, #<stopObjectFromMoving, #<destroyObjectWhenHitSolid, #<destroyOtherWhenHitSolid, #<reverseWhenHitSolid, #<unspawnAction, #<oppositeWhenHitSolid, #<jumpWhenHitSolid
solidBehaviorHi:
	.db #>edgeActionNull, #>stopObjectFromMoving, #>destroyObjectWhenHitSolid, #>destroyOtherWhenHitSolid, #>reverseWhenHitSolid, #>unspawnAction, #>oppositeWhenHitSolid, #>jumpWhenHitSolid



song00Pattern:
	.db #CON_up, #CON_up, #CON_down, #CON_down, #CON_left, #CON_right, #CON_left, #CON_right
	
	
song01Pattern:
	.db #CON_b,#CON_b,#CON_b,#CON_b,#CON_b,#CON_b,#CON_b,#CON_b

songEffectsLo:
	.db #<Song00Effect, #<Song01Effect
songEffectsHi:
	.db #>Song00Effect, #>Song01Effect

Song00Effect:
	LDX #$01
	LDA #$06
	STA ObjectHealth,x
	
	LDA #SFX_SECRET
	sta sound_param_byte_0
	lda #soundeffect_one
    sta sound_param_byte_1
	JSR PlaySoundEffect
	
	RTS
	
	
Song01Effect:
	JMP RESET
	RTS


songPatternsTableLo:
	.db #<song00Pattern, #<song01Pattern
songPatternsTableHi:	
	.db #>song00Pattern, #>song01Pattern


checkAllSongPatterns:
	
	LDX #$00
	LDY #$00
songPatternLoop:
	LDA songPatternsTableLo,x
	STA temp16
	LDA songPatternsTableHi,x
	STA temp16+1
	

	LDA songPattern,y
	CMP (temp16),y
	BNE songIsNoGood
	;; keep checking
	INY
	CPY #$08
	BNE songPatternLoop
	;; if it is equal to 8 then all have been correct!
	;;do the thing!
	LDA songEffectsLo,x
	STA temp16
	LDA songEffectsHi,x
	STA temp16+1
	JSR pastSongThingTrampoline
	JMP songTrampolineDone
pastSongThingTrampoline:
	JMP (temp16)
songTrampolineDone:	
	JMP songWasGood
	
songIsNoGood:

	
	LDY #$00
	INX
	CPX #$02 ;; max number of songs
	BNE songPatternLoop
	LDA #SFX_NOPE
	sta sound_param_byte_0
	lda #soundeffect_one
    sta sound_param_byte_1
	JSR PlaySoundEffect
	jmp songNonsenseDone
	
songWasGood:	
	
	
songNonsenseDone:
	;; play bad tone
	;; rts out of it
	RTS


itemBehaviorLo:
	.db #<doItem00,#<doItem01,#<doItem02,#<doItem03,#<doItem04,#<doItem05,#<doItem06,#<doItem07
	.db #<doItem08,#<doItem09,#<doItem0A,#<doItem0B,#<doItem0C,#<doItem0D,#<doItem0E,#<doItem0F
itemBehaviorHi:
	.db #>doItem00,#>doItem01,#>doItem02,#>doItem03,#>doItem04,#>doItem05,#>doItem06,#>doItem07
	.db #>doItem08,#>doItem09,#>doItem0A,#>doItem0B,#>doItem0C,#>doItem0D,#>doItem0E,#>doItem0F
	
	
	
	
doItem00:
	LDX #$01
	LDA #$06
	STA ObjectHealth,x
	
	LDA #SFX_GET_ITEM
	sta sound_param_byte_0
	
	
	RTS
doItem01:
	;; restores health
	LDX #$01
	LDA #$06
	STA ObjectHealth,x
	STA playerHealth+1
	LDA #$00
	STA playerHealth
	LDA #SFX_GET_ITEM
	sta sound_param_byte_0
	
	
	RTS
doItem02:
	; heals all negative status
	LDA #$00
	STA playerStatus

	LDA playerStatusColor
	CMP #$02 ;; is it zombified?
	BNE notZombifiedDontRestoreStrengthDefense
	
	LDX #$01
	LDA tempStats
	ASL 
	ASL 
	ASL 
	ASL
	ORA tempStats+1
	STA ObjectStrengthDefense,x
	

	LDA tempStats+2
	STA playerMagicPower
notZombifiedDontRestoreStrengthDefense:	
	
	LDA #$00
	STA playerStatusColor
	RTS
doItem03:
	;; restores health and magic to full
	JSR doItem01 ;; restores health to full
	LDA #$06
	STA playerMagic
	
	
	RTS
doItem04:
	;; this heals POISON (slow and stunted jump)
	LDA playerStatus
	AND #%11110110
	STA playerStatus

	RTS
doItem05:
	;; this heals UNDEAD (stunted jump, weakened no magic, no music, no screen affect)
	LDA playerStatus
	AND #%00100011
	STA playerStatus

	
	RTS
doItem06:
	;; new lute strings?  Allows you to play music again when the ability has been taken away.
	LDA playerStatus
	AND #%11101111
	STA playerStatus

	RTS
doItem07:
	;;; add a pack of notes
	LDA #$08
	JSR music_add1 ;; already in bank 14
	RTS
doItem08:

	RTS
doItem09:

	RTS
doItem0A:

	RTS
doItem0B:

	RTS
doItem0C:

	RTS
doItem0D:

	RTS
doItem0E:

	RTS
doItem0F:

	RTS



	
	
DoNPCMode:
	
	RTS



	
	
	
doFindFreeEdge:
	
	
	
	
	
	JSR GetRandomNumber
	AND #%00000001
	BNE vertEdgeSpawn
;; now horiz edge spawn.
	JSR GetRandomNumber
	AND #%00000111
	clc
	adc #$04
	ASL
	ASL
	ASL
	ASL
	STA tileY

	JSR GetRandomNumber
	AND #%00000001
	BNE spawnOnRightEdge
	;; spawn on left edge
	LDA #$02
	STA tileX
	JMP gotSpawnValue
spawnOnRightEdge:
	LDY tempy
	LDA #BOUNDS_RIGHT
	SEC
	SBC ObjectWidth,y
	SEC
	SBC #$06
	STA tileX
	
	JMP gotSpawnValue
	
vertEdgeSpawn:
	JSR GetRandomNumber
	AND #%00000111
	clc
	adc #$04
	ASL
	ASL
	ASL
	ASL
	STA tileX

	JSR GetRandomNumber
	AND #%00000001
	BNE spawnOnBottomEdge
	;; spawn on left edge
	LDA #BOUNDS_TOP
	CLC
	ADC #$01
	STA tileY
	JMP gotSpawnValue
spawnOnBottomEdge:
	LDA #BOUNDS_BOTTOM
	SEC
	SBC ObjectHeight,y
	SEC
	SBC #$0C
	STA tileY
	
gotSpawnValue:	
	
	LDA tileY					; loads temp y
	AND #%11110000				; divides then mults by 16 to get tile row
	STA tempz				; stores it into the temp variable
	
	
	LDA tileX					; same sort of thing with X
	LSR A
	LSR A
	LSR A
	LSR A
	ORA tempz
	TAY
	LDA collisionTable,y
	
	AND #%11000000
	Beq isFreeEdge

	JMP doFindFreeEdge
isFreeEdge:
	LDA collisionTable,y
	AND #%00111111
	CMP #TILE_Hole
	BNE isFreeEdge2
	JMP doFindFreeEdge
	
isFreeEdge2:
	
	
	
	RTS
	
	
	
DoDyingMode:


	LDA #<grayPals
	STA playerPalGroup
	LDA #>grayPals
	STA playerPalGroup+1
	;; hide all objects
	JSR DrawAllSpritesOffScreen
	LDY #$01
	LDA ObjectYhi,y
	CLC
	ADC ObjectHeight,y
	SEC
	SBC ObjectDepth,y
	STA $0200
	LDA #$00
	STA $0201
	LDA #%00000000
	STA $0202
	LDA ObjectXhi,y
	STA $0203
	
	
	LDA ObjectYhi,y
	CLC
	ADC ObjectHeight,y
	SEC
	SBC ObjectDepth,y
	STA $0204
	LDA #$00
	STA $0205
	LDA #%01000000
	STA $0206
	LDA ObjectXhi,y
	CLC
	ADC #$08
	STA $0207
	
	
	LDA ObjectYhi,y
	CLC
	ADC ObjectHeight,y
	SEC
	SBC ObjectDepth,y
	CLC
	ADC #$08
	STA $0208
	LDA #$08
	STA $0209
	LDA #%00000000
	STA $020a
	LDA ObjectXhi,y
	STA $020b
	
	
	LDA ObjectYhi,y
	CLC
	ADC ObjectHeight,y
	SEC
	SBC ObjectDepth,y
	CLC
	ADC #$08
	STA $020c
	LDA #$08
	STA $020d
	LDA #%01000000
	STA $020e
	LDA ObjectXhi,y
	CLC
	ADC #$08
	STA $020f
	
	
	
	LDA ObjectYhi,y
	CLC
	ADC ObjectHeight,y
	SEC
	SBC ObjectDepth,y
	CLC
	ADC #$10
	STA $0210
	LDA #$10
	STA $0211
	LDA #%00000000
	STA $0212
	LDA ObjectXhi,y
	STA $0213
	
	
	LDA ObjectYhi,y
	CLC
	ADC ObjectHeight,y
	SEC
	SBC ObjectDepth,y
	CLC
	ADC #$10
	STA $0214
	LDA #$10
	STA $0215
	LDA #%01000000
	STA $0216
	LDA ObjectXhi,y
	CLC
	ADC #$08
	STA $0217
	
	
	
	DEC deathTimer
	BNE keepFadingToDeath
	JMP RESET
keepFadingToDeath:
	
	;LDA #$1e
	;STA screenBank
	;LDA #$04		;; load the new screen that is to be loaded
	;STA newScreen			;; store it to temp
	LDA #GAME_Dying			;; what type of screen will the target be?
	STA newGameState		;; store it to temp2
	LDA #$10		;; set up fade speed.
						;; higher number, the longer the fade takes
	STA fadeSpeed
	LDA #FADE_OutAndStop	;; set up type of fade
						;;#FADE_OutAndIn = fades out, loads data, then fades back in
								;; normal type of fade
						;; #FADE_OutAndStop = fades to last in group and doesn't load data.
								;; also, no fade back in.
								;; designed for day/night transitions especially
	;ORA #%00000001
	STA fadeByte		;; these constants also set bit 7 to 1, which starts the fade.

	
	
	
	
	RTS
	
	
	
	
	
	
	
	
	
	
	
	
	
tileTableDayDangerLo:
	.db <nullChangeTile, <plankToHole, <groundToSpikes, <spikesToGround, <triggerToOff, <changeToWarpup, <rockBreak, <bushSlash
	.db <spikesToGroundLoop, <groundToSpikesLoop, <groundToBush
tileTableDayDangerHi:	
     .db >nullChangeTile, >plankToHole, >groundToSpikes, >spikesToGround, >triggerToOff, >changeToWarpup, >rockBreak, >bushSlash
	 .db >spikesToGroundLoop, >groundToSpikesLoop, >groundToBush
	 
	 
	 
	 ;; change tiles to what values...four bytes unnecessary?
	;; to use current change routine in NMI, yes.
	
	;; change tile x2 (top), skip line
	;; change tile x2 (bottom), end / close screen draw new tile
	;; collision to change to, attribute to change to, new change tile value (ff is none?)
	
nullChangeTile:
	.db #$FF, #$ff, #$fe
	.db #$ff, #$ff, #$ff
	.db #$00, #$00, #$00
	 
rockBreak:
	.db #$4a, #$4b, #$fe
	.db #$5a, #$5b, #$ff
		.db #$00, #$00, #$00 
	
bushSlash:
	.db #$24, #$25, #$fe
	.db #$34, #$35, #$ff
	.db #$00, #$00, #$00
	 
	
plankToHole:
	.db #$a0, #$a0, #$fe
	.db #$a0, #$a0, #$ff
	.db #$00, #$00, #$00
	

	
groundToSpikes:
	.db #$44, #$45, #$fe
	.db #$54, #$55, #$ff
	.db #TILE_HurtIfNotJump, #$00, #$03
	
spikesToGround:
	.db #$46, #$47, #$fe
	.db #$56, #$57, #$ff
	.db #$00, #$00, #$02
	
triggerToOff:
	.db #$24,#$25, #$fe
	.db #$34, #$35,#$ff
	.db #$00, #$00, #$00
	
changeToWarpup:
	.db #$60, #$61, #$FE
	.db #$70, #$71, #$ff
	.db #$00, #$00, #$00
	
spikesToGroundLoop:
	.db #$46, #$47, #$fe
	.db #$56, #$57, #$ff
	.db #$00, #$00, #$09	;; no collision
groundToSpikesLoop:
	.db #$44, #$45, #$fe
	.db #$54, #$55, #$ff
	.db #$08, #$00, #$08 ;; hurt if not jump
	

	
groundToBush:
	.db #$06, #$07, #$fe
	.db #$16, #$17, #$ff
	.db #$00, #$00, #$00 
	
	
	
	
doButtonSongMode:	
	LDX #$01
	LDA #$02
	STA ObjectCurrentFrame,x
	
	
	
	
	
	
	LDA songByte
	AND #%10000000
	BEQ noSelectPressedA2
	;; select button is pressed
	LDA noteChoice+1
	STA noteTemp
	JSR playMusicNote
	Jmp gotNoteValueA
noSelectPressedA2:
	LDA noteChoice
	STA noteTemp
	JSR playMusicNote
	
gotNoteValueA:
	LDA songByte
	AND #%10000000
	BEQ noSelectPressedA
	;;select is pressed
	LDA temp2
	BNE playLiveANote
	LDA noteIfDead+1
	STA myNoteToPlay
	JMP playAnote
playLiveANote:
	LDA noteIfLive+1
	STA myNoteToPlay
	JMP playAnote
noSelectPressedA:
	LDA temp2
	BNE playLiveAnote2
	LDA noteIfDead
	STA myNoteToPlay
	JMP playAnote
playLiveAnote2:
	LDA noteIfLive
	STA myNoteToPlay
	
	
playAnote:
	
	RTS
	
	
	