;;; Extra data bank
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TILE TABLES AND DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ObjectReaction:
	.include "ScreenData\ObjectData\SolidEdgeObjectReaction.dat" ;; put this in lut table

; doHandlePickups: ;; moved directly to object collision routine
	; .include SCR_PICKUP_SCRIPTS
	; RTS
	
; doHandlePickups:
	; .include SCR_PICKUP_SCRIPTS
	; RTS
	
doScreenPreDraw:
	.include SCR_SPRITE_PREDRAW
	RTS
doScreenPostDraw:
	.include SCR_SPRITE_POSTDRAW
	RTS
doTileObservationLogic
	LDA Object_status,x
			AND #OBJECT_OBSERVES_TILES
			BNE doesObserveTiles
			
				JMP ObjectDoesNotObserveTiles
			doesObserveTiles:
				;CPX player1_object
				;BNE ObjectDoesNotObserveTiles
				LDA #$00
				STA ObjectUpdateByte ;; reset ObjectUpdateByte
								;; the collision routines will set up 
								;; what should happen on this update.
								;; for instance, by default, bit 0 
								;; lets the update know there was a solic collision
								;; so skip the positioning update.
				;;;;; TILE Collisions
				JSR doHandleTileCollisionState
				JSR doHandleTileCollisions ;; in overflow bank
			
				;;;;;;; here, we will have the collision byte stored in the accumulator
				;;;;;;; if they were all zero, there is no collision to check for.
				BEQ ObjectDoesNotObserveTiles
					
					
			STA temp ;; store the tile value into temp
					;;; now, we do the trampoline based on the tile type that is in the accumulator.
					TYA
					STA temp1 ;; this now holds the y offset of collisionTable representing the tile that saw collision.
					;;; and temp2 is 0 if we were in collisionTable and 1 if we were in collisionTable2
					;;; the combination above will allow us to affect the tile that we just collided with.
					
					LDY temp
					LDA TileTableLo,y
					STA temp16
					LDA TileTableHi,y
					STA temp16+1
					JSR doTileTrampoline
					JMP doneWithTileTrampoline
					doTileTrampoline:
						JMP (temp16) ;;; this now does the action
							;; and when it hits the RTS in that action,
							;; it will jump back to the last JSR it saw,
							;; which was doNewActionTrampoline...which will immediately
							;; jump to pastDoNewActionTrampoline.
						doneWithTileTrampoline:
						

				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			ObjectDoesNotObserveTiles:
	RTS

doHandleTileCollisionState
	.include SCR_TILE_COLLISION_STATE ;; custom tile collision state stuff.
	RTS



doHandleTileCollisions:
	.include SCR_HANDLE_TILE_COLLISIONS
	RTS


TileTableLo:
	.db <Tile_00, <Tile_01, <Tile_02, <Tile_03, <Tile_04, <Tile_05, <Tile_06, <Tile_07
	.db <Tile_08, <Tile_09, <Tile_10, <Tile_11, <Tile_12, <Tile_13, <Tile_14, <Tile_15
	
TileTableHi:
	.db >Tile_00, >Tile_01, >Tile_02, >Tile_03, >Tile_04, >Tile_05, >Tile_06, >Tile_07
	.db >Tile_08, >Tile_09, >Tile_10, >Tile_11, >Tile_12, >Tile_13, >Tile_14, >Tile_15
	

Tile_00:
	.include SCR_TILE_00
	RTS
	
Tile_01:
	.include SCR_TILE_01
	RTS
	
Tile_02:
	.include SCR_TILE_02
	RTS
	
Tile_03:
	.include SCR_TILE_03
	RTS
	
Tile_04:
	.include SCR_TILE_04
	RTS
	
Tile_05:
	.include SCR_TILE_05
	RTS
	
Tile_06:
	.include SCR_TILE_06
	RTS
	
Tile_07:
	.include SCR_TILE_07
	RTS
	
Tile_08:
	.include SCR_TILE_08
	RTS
	
Tile_09:
	.include SCR_TILE_09
	RTS
	
Tile_10:
	.include SCR_TILE_10
	RTS
	
Tile_11:
	.include SCR_TILE_11
	RTS
	
Tile_12:
	.include SCR_TILE_12
	RTS
	
Tile_13:
	.include SCR_TILE_13
	RTS
	
Tile_14:
	.include SCR_TILE_14
	RTS
	
Tile_15:
	.include SCR_TILE_15
	RTS
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Object overflow

doUpdateState:	
	.include SCR_UPDATE_STATE
	RTS

doHandleObjectUpdate:
	.include SCR_HANDLE_OBJECT_UPDATE
	RTS
	
	
doAiReaction1:
	.include SCR_AI_REACTION_1
	RTS
doAiReaction2:
	.include SCR_AI_REACTION_2
	RTS
doAiReaction3:
	.include SCR_AI_REACTION_3
	RTS
doAiReaction4:
	.include SCR_AI_REACTION_4
	RTS
doAiReaction5:
	.include SCR_AI_REACTION_5
	RTS
doAiReaction6:
	.include SCR_AI_REACTION_6
	RTS
doAiReaction7:
	.include SCR_AI_REACTION_7
	RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; DO UPDATE STATE


	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; AIMED PHYSICS

	.include ROOT\Game\Subroutines\doMoveTowardsPoint.asm

	
octant_adjust:
	.db #%00111111
	.db #%00000000
	.db #%11000000
	.db #%11111111
	.db #%01000000
	.db #%01111111
	.db #%10111111
	.db #%10000000
	
	
atan_tab:
		.db $00,$00,$00,$00,$00,$00,$00,$00
		.db $00,$00,$00,$00,$00,$00,$00,$00
		.db $00,$00,$00,$00,$00,$00,$00,$00
		.db $00,$00,$00,$00,$00,$00,$00,$00
		.db $00,$00,$00,$00,$00,$00,$00,$00
		.db $00,$00,$00,$00,$00,$00,$00,$00
		.db $00,$00,$00,$00,$00,$00,$00,$00
		.db $00,$00,$00,$00,$00,$00,$00,$00
		.db $00,$00,$00,$00,$00,$00,$00,$00
		.db $00,$00,$00,$00,$00,$00,$00,$00
		.db $00,$00,$00,$00,$00,$01,$01,$01
		.db $01,$01,$01,$01,$01,$01,$01,$01
		.db $01,$01,$01,$01,$01,$01,$01,$01
		.db $01,$01,$01,$01,$01,$01,$01,$01
		.db $01,$01,$01,$01,$01,$02,$02,$02
		.db $02,$02,$02,$02,$02,$02,$02,$02
		.db $02,$02,$02,$02,$02,$02,$02,$02
		.db $03,$03,$03,$03,$03,$03,$03,$03
		.db $03,$03,$03,$03,$03,$04,$04,$04
		.db $04,$04,$04,$04,$04,$04,$04,$04
		.db $05,$05,$05,$05,$05,$05,$05,$05
		.db $06,$06,$06,$06,$06,$06,$06,$06
		.db $07,$07,$07,$07,$07,$07,$08,$08
		.db $08,$08,$08,$08,$09,$09,$09,$09
		.db $09,$0a,$0a,$0a,$0a,$0b,$0b,$0b
		.db $0b,$0c,$0c,$0c,$0c,$0d,$0d,$0d
		.db $0d,$0e,$0e,$0e,$0e,$0f,$0f,$0f
		.db $10,$10,$10,$11,$11,$11,$12,$12
		.db $12,$13,$13,$13,$14,$14,$15,$15
		.db $15,$16,$16,$17,$17,$17,$18,$18
		.db $19,$19,$19,$1a,$1a,$1b,$1b,$1c
		.db $1c,$1c,$1d,$1d,$1e,$1e,$1f,$1f


		;;;;;;;; log2(x)*32 ;;;;;;;;

log2_tab:
		.db $00,$00,$20,$32,$40,$4a,$52,$59
		.db $60,$65,$6a,$6e,$72,$76,$79,$7d
		.db $80,$82,$85,$87,$8a,$8c,$8e,$90
		.db $92,$94,$96,$98,$99,$9b,$9d,$9e
		.db $a0,$a1,$a2,$a4,$a5,$a6,$a7,$a9
		.db $aa,$ab,$ac,$ad,$ae,$af,$b0,$b1
		.db $b2,$b3,$b4,$b5,$b6,$b7,$b8,$b9
		.db $b9,$ba,$bb,$bc,$bd,$bd,$be,$bf
		.db $c0,$c0,$c1,$c2,$c2,$c3,$c4,$c4
		.db $c5,$c6,$c6,$c7,$c7,$c8,$c9,$c9
		.db $ca,$ca,$cb,$cc,$cc,$cd,$cd,$ce
		.db $ce,$cf,$cf,$d0,$d0,$d1,$d1,$d2
		.db $d2,$d3,$d3,$d4,$d4,$d5,$d5,$d5
		.db $d6,$d6,$d7,$d7,$d8,$d8,$d9,$d9
		.db $d9,$da,$da,$db,$db,$db,$dc,$dc
		.db $dd,$dd,$dd,$de,$de,$de,$df,$df
		.db $df,$e0,$e0,$e1,$e1,$e1,$e2,$e2
		.db $e2,$e3,$e3,$e3,$e4,$e4,$e4,$e5
		.db $e5,$e5,$e6,$e6,$e6,$e7,$e7,$e7
		.db $e7,$e8,$e8,$e8,$e9,$e9,$e9,$ea
		.db $ea,$ea,$ea,$eb,$eb,$eb,$ec,$ec
		.db $ec,$ec,$ed,$ed,$ed,$ed,$ee,$ee
		.db $ee,$ee,$ef,$ef,$ef,$ef,$f0,$f0
		.db $f0,$f1,$f1,$f1,$f1,$f1,$f2,$f2
		.db $f2,$f2,$f3,$f3,$f3,$f3,$f4,$f4
		.db $f4,$f4,$f5,$f5,$f5,$f5,$f5,$f6
		.db $f6,$f6,$f6,$f7,$f7,$f7,$f7,$f7
		.db $f8,$f8,$f8,$f8,$f9,$f9,$f9,$f9
		.db $f9,$fa,$fa,$fa,$fa,$fa,$fb,$fb
		.db $fb,$fb,$fb,$fc,$fc,$fc,$fc,$fc
		.db $fd,$fd,$fd,$fd,$fd,$fd,$fe,$fe
		.db $fe,$fe,$fe,$ff,$ff,$ff,$ff,$ff	
		
		
		
		
AngleToHVelLo:
		.db #$fe , #$fe , #$fe , #$fe , #$fd , #$fd , #$fd , #$fc , #$fc , #$fb , #$fa , #$f9 , #$f9 , #$f8 , #$f7 , #$f5 , #$f4 , #$f3 , #$f2 , #$f0 , #$ef , #$ee , #$ec , #$ea , #$e9 , #$e7 , #$e5 , #$e3 , #$e1 , #$df , #$dd , #$db , #$d9 , #$d7 , #$d4 , #$d2 , #$d0 , #$cd , #$cb , #$c8 , #$c6 , #$c3 , #$c0 , #$be , #$bb , #$b8 , #$b5 , #$b2 , #$b0 , #$ad , #$aa , #$a7 , #$a4 , #$a1 , #$9e , #$9b , #$98 , #$95 , #$92 , #$8f , #$8b , #$88 , #$85 , #$82 , #$7f , #$7c , #$79 , #$76 , #$73 , #$6f , #$6c , #$69 , #$66 , #$63 , #$60 , #$5d , #$5a , #$57 , #$54 , #$51 , #$4e , #$4c , #$49 , #$46 , #$43 , #$40 , #$3e , #$3b , #$38 , #$36 , #$33 , #$31 , #$2e , #$2c , #$2a , #$27 , #$25 , #$23 , #$21 , #$1f , #$1d , #$1b , #$19 , #$17 , #$15 , #$14 , #$12 , #$10 , #$f , #$e , #$c , #$b , #$a , #$9 , #$7 , #$6 , #$5 , #$5 , #$4 , #$3 , #$2 , #$2 , #$1 , #$1 , #$1 , #$0 , #$0 , #$0 , #$0 , #$0 , #$0 , #$0 , #$1 , #$1 , #$1 , #$2 , #$2 , #$3 , #$4 , #$5 , #$5 , #$6 , #$7 , #$9 , #$a , #$b , #$c , #$e , #$f , #$10 , #$12 , #$14 , #$15 , #$17 , #$19 , #$1b , #$1d , #$1f , #$21 , #$23 , #$25 , #$27 , #$2a , #$2c , #$2e , #$31 , #$33 , #$36 , #$38 , #$3b , #$3e , #$40 , #$43 , #$46 , #$49 , #$4c , #$4e , #$51 , #$54 , #$57 , #$5a , #$5d , #$60 , #$63 , #$66 , #$69 , #$6c , #$6f , #$73 , #$76 , #$79 , #$7c , #$7f , #$82 , #$85 , #$88 , #$8b , #$8f , #$92 , #$95 , #$98 , #$9b , #$9e , #$a1 , #$a4 , #$a7 , #$aa , #$ad , #$b0 , #$b2 , #$b5 , #$b8 , #$bb , #$be , #$c0 , #$c3 , #$c6 , #$c8 , #$cb , #$cd , #$d0 , #$d2 , #$d4 , #$d7 , #$d9 , #$db , #$dd , #$df , #$e1 , #$e3 , #$e5 , #$e7 , #$e9 , #$ea , #$ec , #$ee , #$ef , #$f0 , #$f2 , #$f3 , #$f4 , #$f5 , #$f7 , #$f8 , #$f9 , #$f9 , #$fa , #$fb , #$fc , #$fc , #$fd , #$fd , #$fd , #$fe , #$fe , #$fe

AngleToVVelLo:
		
		.db #$7f , #$7c , #$79 , #$76 , #$73 , #$6f , #$6c , #$69 , #$66 , #$63 , #$60 , #$5d , #$5a , #$57 , #$54 , #$51 , #$4e , #$4c , #$49 , #$46 , #$43 , #$40 , #$3e , #$3b , #$38 , #$36 , #$33 , #$31 , #$2e , #$2c , #$2a , #$27 , #$25 , #$23 , #$21 , #$1f , #$1d , #$1b , #$19 , #$17 , #$15 , #$14 , #$12 , #$10 , #$f , #$e , #$c , #$b , #$a , #$9 , #$7 , #$6 , #$5 , #$5 , #$4 , #$3 , #$2 , #$2 , #$1 , #$1 , #$1 , #$0 , #$0 , #$0 , #$0 , #$0 , #$0 , #$0 , #$1 , #$1 , #$1 , #$2 , #$2 , #$3 , #$4 , #$5 , #$5 , #$6 , #$7 , #$9 , #$a , #$b , #$c , #$e , #$f , #$10 , #$12 , #$14 , #$15 , #$17 , #$19 , #$1b , #$1d , #$1f , #$21 , #$23 , #$25 , #$27 , #$2a , #$2c , #$2e , #$31 , #$33 , #$36 , #$38 , #$3b , #$3e , #$40 , #$43 , #$46 , #$49 , #$4c , #$4e , #$51 , #$54 , #$57 , #$5a , #$5d , #$60 , #$63 , #$66 , #$69 , #$6c , #$6f , #$73 , #$76 , #$79 , #$7c , #$7f , #$82 , #$85 , #$88 , #$8b , #$8f , #$92 , #$95 , #$98 , #$9b , #$9e , #$a1 , #$a4 , #$a7 , #$aa , #$ad , #$b0 , #$b2 , #$b5 , #$b8 , #$bb , #$be , #$c0 , #$c3 , #$c6 , #$c8 , #$cb , #$cd , #$d0 , #$d2 , #$d4 , #$d7 , #$d9 , #$db , #$dd , #$df , #$e1 , #$e3 , #$e5 , #$e7 , #$e9 , #$ea , #$ec , #$ee , #$ef , #$f0 , #$f2 , #$f3 , #$f4 , #$f5 , #$f7 , #$f8 , #$f9 , #$f9 , #$fa , #$fb , #$fc , #$fc , #$fd , #$fd , #$fd , #$fe , #$fe , #$fe , #$fe , #$fe , #$fe , #$fe , #$fd , #$fd , #$fd , #$fc , #$fc , #$fb , #$fa , #$f9 , #$f9 , #$f8 , #$f7 , #$f5 , #$f4 , #$f3 , #$f2 , #$f0 , #$ef , #$ee , #$ec , #$ea , #$e9 , #$e7 , #$e5 , #$e3 , #$e1 , #$df , #$dd , #$db , #$d9 , #$d7 , #$d4 , #$d2 , #$d0 , #$cd , #$cb , #$c8 , #$c6 , #$c3 , #$c0 , #$be , #$bb , #$b8 , #$b5 , #$b2 , #$b0 , #$ad , #$aa , #$a7 , #$a4 , #$a1 , #$9e , #$9b , #$98 , #$95 , #$92 , #$8f , #$8b , #$88 , #$85 , #$82

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
doHandleBounds_bank18:

	LDA EdgeSolidReaction
	AND #%00001111 ;; this is the edge reaction for this object, grabbed in the physics script prior to this point.
	BNE dontIgnoreEdge
	JMP ignoreEdge
dontIgnoreEdge:
	CMP #$01
	BEQ atOneEdge
		JMP notOneEdge
	atOneEdge:
		;; is one edge
		.include SCR_EDGE_1
		JMP ignoreEdge
	notOneEdge

	
	CMP #$02
	BEQ atTwoEdge
		JMP notTwoEdge
	atTwoEdge:
		;; is two edge
		.include SCR_EDGE_2
		JMP ignoreEdge
	notTwoEdge:
	CMP #$03
	BEQ atThreeEdge
		JMP notThreeEdge
	atThreeEdge:
		;; is three edge
		.include SCR_EDGE_3
		JMP ignoreEdge
	notThreeEdge:
	CMP #$04
	BEQ atFourEdge
		JMP notFourEdge
	atFourEdge:
		;; is four edge
		.include SCR_EDGE_4
		JMP ignoreEdge
	notFourEdge:
	CMP #$05
	BEQ atFiveEdge
		JMP notFiveEdge
	atFiveEdge:
		;; is five edge
		.include SCR_EDGE_5
		JMP ignoreEdge
	notFiveEdge:
	CMP #$06
	BEQ atSixEdge
		JMP notSixEdge
	atSixEdge:
		;; is sixEdge
		.include SCR_EDGE_6
		JMP ignoreEdge
	notSixEdge:
		;; must be seven edge
		.include SCR_EDGE_7
		;;jmp ignoreEdge
	
ignoreEdge:
	RTS
	
	
	
 doEraseBox_bank18:
;;; draw box will update one metatile row at a time,
	; ;;; so at max, it will be updating 16x4 tiles (64) x 3 bytes per tile (192).
	; ;;; This makes multple frames of updates easy.
	; ;;; If the queue flag bit 0 is activated, that means that we have moved on to another row, but are not done yet.
	
	; LDA queueFlags
	; AND #%00000001
	; BEQ +notCurrentlyErasingQueuedTiles
	; ;; currently updating queued tiles
	
	; JMP +currentlyErasingQueuedTiles
; +notCurrentlyErasingQueuedTiles:
	; ;;;;; We are JUST starting a box update.
	; ; arg0_hold = X value, in metatiles
	; ; arg1_hold = y value, in metatiles
	; ; arg2_hold = width, in metatiles
	; ; arg3_hold = height, in metatiles
	
	; LDA queueFlags
	; ORA #%00000001
	; STA queueFlags
	
	; LDA arg0_hold
	; STA Box_x_origin
	; LDA arg1_hold
	; STA Box_y_origin
	; STA Box_y_hold
	; LDA arg2_hold
	; STA Box_width
	; LDA arg3_hold
	; STA Box_height
	
; +currentlyErasingQueuedTiles:
	
	; LDA Box_x_origin ;; the x value, in metatiles, of the box draw.
	; ASL ;; multiplied by two, since metatiles are 16x16, but PPU addresses are 8x8.
	; STA temp
	; LDA Box_y_origin ;; the y value, in metatiles, of the box draw.
	; ASL ;; multiplied by two, since metatiles are 16x16, but ppu addresses are 8x8.
	; STA temp1
		; ASL
		; ASL
		; ASL
		; ASL
		; ASL
		; CLC 
		; ADC temp
		; STA temp3
		; STA tempC
		
	; LDA temp1
		; LSR
		; LSR
		; LSR
	; CLC
	; ADC #$20
	; STA temp2
	; STA tempD
	
	
	
	
	; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; ;;; LOAD THE BYTES INTO SCRATCH RAM:
	; ;;; High, Low, Tile.
	; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; LDA #$00
		; STA scrollOffsetCounter
		; TAY
		
		; -doEraseBoxLoop:
	
			; LDX Box_width ;; load the width into x.

			; -doEraseBoxLoop_inner:
				; LDA temp2
				; STA scrollUpdateRam,y
				; INY
				; LDA temp3
				; STA scrollUpdateRam,y
				; INY
				; LDA #$F5
				; STA scrollUpdateRam,y
				; INY
				
				; LDA temp2
				; STA scrollUpdateRam,y
				; INY
				; LDA temp3
				; CLC
				; ADC #$01
				; STA scrollUpdateRam,y
				; INY
				; LDA #$F5
				; STA scrollUpdateRam,y
				; INY
				
					; LDA temp3
					; CLC
					; ADC #$20
					; STA temp3
					; LDA temp2
					; ADC #$00
					; STA temp2
				
				; LDA temp2
				; STA scrollUpdateRam,y
				; INY
				; LDA temp3
				; STA scrollUpdateRam,y
				; INY
				; LDA #$F5
				; STA scrollUpdateRam,y
				; INY
				
				; LDA temp2
				; STA scrollUpdateRam,y
				; INY
				; LDA temp3
				; CLC
				; ADC #$01
				; STA scrollUpdateRam,y
				; INY
				; LDA #$F5
				; STA scrollUpdateRam,y
				; INY
					
				; DEX
				; BEQ +doneWithEraseBoxRow
				; ;;; more box row to draw.
					; LDA temp3
					; SEC
					; SBC #$1E 
					; STA temp3
					; LDA temp2
					; SBC #$00
					; STA temp2
					; JMP -doDrawBoxLoop_inner
				; +doneWithEraseBoxRow:
						; DEC Box_height
						; LDA Box_height
						; BEQ +doneWithBoxEraseOutterLoop

							; LDA Box_y_origin
							; CLC
							; ADC #$01
							; STA Box_y_origin
							; JMP +notDoneWithBoxEraseOutterLoop
				; +doneWithBoxEraseOutterLoop:
					; LDA queueFlags
					; AND #%11111110
					; STA queueFlags
					; LDA gameStatusByte
					; AND #%11111110 ;;; this will skip object handling.
					; STA gameStatusByte
			; +notDoneWithBoxEraseOutterLoop:
		
		
		
	; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; ;;; Push the offset so we know how many tiles to update.
	; ;;; max would be 85 tiles.
	; ;;; could make this metatiles to get more out of this.
		; TYA
		; STA maxScrollOffsetCounter
		
		
				
		
	; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; ;;; Turn on update screen on next frame.
			; LDA updateScreenData
			; ORA #%0000100
			; STA updateScreenData
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 RTS
	
	
doDrawHud_bank18:
	LDA gameHandler
	AND #%00100000
	BEQ doDrawHudStuff
	
	JMP doneHudUpdate
doDrawHudStuff:
;;; draw hud box
	LDA #BOX_0_WIDTH
	ASL
	STA tempA
	LDA #BOX_0_HEIGHT
	ASL
	STA tempB
	LDA #BOX_0_ORIGIN_X ;; the x value, in metatiles, of the box draw.
	ASL ;; multiplied by two, since metatiles are 16x16, but PPU addresses are 8x8.
	STA temp
	LDA #BOX_0_ORIGIN_Y ;; the y value, in metatiles, of the box draw.
	ASL ;; multiplied by two, since metatiles are 16x16, but ppu addresses are 8x8.
	STA temp1
		ASL
		ASL
		ASL
		ASL
		ASL
		CLC 
		ADC temp
		STA temp3 ;; low byte.

		
	LDA temp1
		LSR
		LSR
		LSR
	CLC
	ADC camFocus_tiles
	STA temp2 ;; high byte
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; DRW BUX;;;;;;;;;;;;;;;;;;;;;;;;;;	
	doDrawHudBoxLoop:
		LDA temp2
		STA $2006
		LDA temp3
		STA $2006
		LDA #$F5 ;; blank tile
		STA $2007
		INC temp3
		DEC tempA
		LDA tempA
		BNE doDrawHudBoxLoop
			LDA #BOX_0_WIDTH
			ASL
			STA tempA
			LDA temp3
			SEC
			SBC tempA
			CLC
			ADC #$20
			STA temp3
			LDA temp2
			ADC #$00
			STA temp2
			
			DEC tempB
			LDA tempB
			BNE doDrawHudBoxLoop
		;; done.	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DO ATTRIBUTES

		LDA #BOX_0_ORIGIN_X
		LSR
		STA tempA
		LDA #BOX_0_ORIGIN_Y
		LSR
		STA tempB
		
		LDA #BOX_0_WIDTH
		LSR 
		;; allow for odd starts, if on odd, will need to add 1
		STA tempC
		STA tempz	
		
		LDA #BOX_0_HEIGHT
		LSR
		STA tempD
		
		
		
			LDA tempB
			ASL
			ASL
			ASL
			CLC 
			ADC tempA
			sta tempx ;; tempx is our offset for the Attribute table.
			
			
			LDA camFocus_att ;; high byte, have to change based on which nametable we are in.
			STA temp1
			LDA #$C0
			CLC
			ADC tempx
			STA temp2
			
		doDrawHudAttLoop
			LDA temp1
			STA $2006
			LDA temp2
			STA $2006
			LDA #$FF
			STA $2007
			INC temp2
			DEC tempC
			LDA tempC
			BNE doDrawHudAttLoop
				DEC tempD
				BEQ doneWithDrawHudAttLoop
				;; not done with draw hud att loop.
				LDA temp2
				SEC
				SBC tempz
				CLC
				ADC #$08
				STA temp2
				LDA tempz
				STA tempC
				JMP doDrawHudAttLoop
				
		doneWithDrawHudAttLoop:
	RTS
	
	
.include GameData\HUD_UPDATES.dat


doUpdateHudElement_bank18:
	
checkForHudUpdates:
	
	LDA hudUpdates
	BNE notNoHudUpdates
	RTS
notNoHudUpdates:
	LDA updateScreenData
	AND #%00000101 ;; if queued to push tiles or attributes
	BEQ +screenNotCurrentlyUpdating
	RTS
+screenNotCurrentlyUpdating


	LDA hudUpdates
	AND #%00000001
	BEQ notZeroTypeHudUpdate
		JSR updateHudElement0
		LDA hudUpdates
		AND #%11111110
		STA hudUpdates
		JMP doneHudUpdate
	notZeroTypeHudUpdate:
	LDA hudUpdates
	AND #%00000010
	BEQ notOneTypeHudUpdate
		JSR updateHudElement1
		LDA hudUpdates
		AND #%11111101
		STA hudUpdates
		JMP doneHudUpdate
	notOneTypeHudUpdate:
	LDA hudUpdates
	AND #%00000100
	BEQ notTwoTypeHudUpdate
	
		JSR updateHudElement2
		LDA hudUpdates
		AND #%11111011
		STA hudUpdates
		JMP doneHudUpdate
	notTwoTypeHudUpdate:
	LDA hudUpdates
	AND #%00001000
	BEQ notThreeTypeHudUpdate
		JSR updateHudElement3
		LDA hudUpdates
		AND #%11110111
		STA hudUpdates
		JMP doneHudUpdate
	notThreeTypeHudUpdate
	LDA hudUpdates
	AND #%00010000
	BEQ notFourTypeHudUpdate
		JSR updateHudElement4
		LDA hudUpdates
		AND #%11101111
		STA hudUpdates
		JMP doneHudUpdate
	notFourTypeHudUpdate:
	LDA hudUpdates
	AND #%00100000
	BEQ notFiveTypeHudUpdate
		JSR updateHudElement5
		LDA hudUpdates
		AND #%11011111
		STA hudUpdates
		JMP doneHudUpdate
	notFiveTypeHudUpdate:
	LDA hudUpdates
	AND #%01000000
	BEQ notSixTypeHudUpdate
		JSR updateHudElement6
		LDA hudUpdates
		AND #%10111111
		STA hudUpdates
		JMP doneHudUpdate
	notSixTypeHudUpdate
	LDA hudUpdates
	AND #%10000000
	BEQ doneHudUpdate
		JSR updateHudElement7
		LDA hudUpdates
		AND #%01111111
		STA hudUpdates
	doneHudUpdate:

	
	RTS
		
	
	 
getPathInfo:
LDA #$00
	STA TL_path
	STA TR_path
	STA TC_path
	STA CL_path
	STA CR_path
	STA BL_path
	STA BR_path
	STA BC_path
	


	TYA
	STA tempA
	;tempA_hold is how we can now restore y if we have to 
				;; corrupt it.
		

	CPY #$10
	BNE notOnFirstPathRow
	;;; is on first path row.
	;; this means that all top paths should read as paths.
	LDA temp
	STA TL_path
	STA TC_path
	STA TR_path
	JMP gotTopPaths
notOnFirstPathRow:
	;; find top left
;	TYA
;	AND #%00001111
;	BNE notOnLeftEdge
	;; it is on left edge
;	so top left is a path (path continues past the screen)
;	LDA temp

;	STA TL_path
;	JMP gotTLpath
notOnLeftEdge:
	TYA 
	SEC
	SBC #$11 ; one row up, one value to the left.
	TAY
	LDA	(temp16),y
	CMP temp
	BNE gotTLpath ;; ignore TL, keep it at zero
					;; because it is not a path
	LDA temp
	STA TL_path
gotTLpath:   ;;; top left path is figured.	

	INY
	LDA (temp16),y ;; this is for top center.
	CMP temp
	BNE gotTCpath ;; ignore TC, keep at zero
	LDA temp
	STA TC_path
gotTCpath:

	INY
	TYA
	AND #%00001111
	BNE notOnRightEdge
	;; it is on right edge
	LDA temp
	STA TR_path
	JMP gotTRpath
notOnRightEdge:
	LDA (temp16),y
	CMP temp
	BNE gotTRpath ;; ignore TR, keep it zero
	LDA temp
	STA TR_path
gotTRpath:
	;;;; ALL top paths have been gotten.
gotTopPaths:

	;;; get center two paths.
	
	LDY tempA ;; restore y
	;; first check to see if it's on the left edge
;	TYA 
;	AND #%00001111
;	BNE notOnLeftEdgeC
	;; it is on left edge.
;	LDA temp
;	STA CL_path
;	JMP gotCLpath
notOnLeftEdgeC:
	DEY
	LDA (temp16),y
	CMP temp
	BNE gotCLpath ;; keep cl as zero
	LDA temp
	STA CL_path
gotCLpath:
	LDY tempA
	INY
	TYA
	AND #%00001111
	BNE notOnRightEdgeC
	LDA temp
	STA CR_path
	JMP gotCRpath
notOnRightEdgeC:

	LDA (temp16),y
	CMP temp
	BNE gotCRpath

	LDA temp
	STA CR_path
gotCRpath:	
	;;;; got center paths.
	;;; now just need bottom paths, then we can 
	;; do basic reads of those variables
	;; to determine which tiles to draw.
	;; first, are we in the bottom row?  The bottom row for this would be
	;; #$0E
	;; skip for now
	LDY tempA
;	TYA
;	AND #%00001111
;	BNE notOnLeftEdgeB
	;; is on left edge bottom

	;LDA temp
;	STA BL_path
;	JMP gotBLpath
notOnLeftEdgeB:
	TYA
	CLC
	ADC #$0f
	TAY
	LDA (temp16),y
	CMP temp
	BNE gotBLpath ;; skip/ignore, was not path - keep zero
	LDA temp
	STA BL_path
gotBLpath:
	INY
	LDA (temp16),y
	CMP temp
	BNE gotBCpath ;; keep zero
	LDA temp
	STA BC_path
gotBCpath:
	INY
	TYA
	AND #%00001111
	BNE notRightEdgeB
	;; is on right edge
	;LDA temp
	;STA BR_path
	;JMP gotBRpath
notRightEdgeB:
	LDA (temp16),y
	CMP temp
	BNE gotBRpath
	LDA temp
	STA BR_path
gotBRpath:
	LDY tempA
	TYA
	
	AND #%00001111
	BNE notOnLeftEdge_safe
	LDA temp
	STA TL_path
	STA CL_path
	STA BL_path
notOnLeftEdge_safe:
	LDA tempA
	CLC
	ADC #$01
	AND #%00001111
	BNE notOnRightEdge_safe
	LDA temp
	STA TR_path
	STA CR_path
	STA BR_path
notOnRightEdge_safe

	LDA tempA
	CMP #$e0
	BCC notOnBottomEdge_safe
	LDA temp
	STA BL_path
	STA BC_path
	STA BR_path
notOnBottomEdge_safe:
	LDA tempA
	CMP #$10
	BCS notOnTopEdge_safe
	LDA temp
	STA TL_path
	STA TC_path
	STA TR_path
notOnTopEdge_safe:
	
	
		;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;; All temp vars are loaded now.
		;;;;;;;;;;;;;;; now we can just go through and populate based on the values.
	;; FIRST lets focus on the TR.  Must check left, top and top left.
	
DoPathTileLoads:
	LDA CL_path
	BNE leftIsAPath
;;===============LEFT IS NOT A PATH============================

	;; left is not a path.
	LDA TC_path
	BNE topCenterIsApath
	;; no left path
	;; no top path
	;; that would make this a top left corner.
	LDA temp
	CLC
	ADC #$01
	STA currentPathTile_TL
	JMP topLeftCornerIsDone
topCenterIsApath:
	LDA temp
	clc
	adc #$05
	STA currentPathTile_TL
	JMP topLeftCornerIsDone
	
;;=====================================================

leftIsAPath:
;;===========================================
;; LEFT IS A PATH
	LDA TC_path
	BNE topCenterIsAPath2
	;; left is a path
	;; top is NOT a path
	;; that means this is a *topper*
	LDA temp
	clc
	adc #$02
	STA currentPathTile_TL
	JMP topLeftCornerIsDone
topCenterIsAPath2:
	;; top center is a path, left is a path.
	;; if diag is a path, this is full open path
	;; otherwise it is an interior corner
	LDA TL_path
	BNE topLeftIsApath
	;; top left is not a path
	;; so this is an interior corner
	LDA temp
	CLC
	ADC #$0b
	STA currentPathTile_TL
	JMP topLeftCornerIsDone
topLeftIsApath:
	;; top left is a path.
	;; so this is a wide open tile
	LDA temp
	STA currentPathTile_TL
	;; last possibility for TL 
topLeftCornerIsDone:
	;;;;; DO TOP RIGHT CORNER.
	LDA CR_path
	BNE topRightIsAPath
	;;;; ==== TOP RIGHT IS NOT A PATH
	LDA TC_path
	BNE topCenterIsAPath3
	;; that would make this a top right corner
	LDA temp
	CLC
	ADC #$04
	STA currentPathTile_TR
	JMP topRightCornerIsDone
topCenterIsAPath3:
	;; so if the right of me is not a path
	;; but the top of me is a path
	;; i need to show the right edge
	LDA temp
	CLC
	ADC #$06
	STA currentPathTile_TR
	JMP topRightCornerIsDone
topRightIsAPath:
	;; right is a path
	;; is above a path?
	LDA TC_path
	BNE topCenterIsAPath4
	;; right is a path.
	;; top center is not a path, which means this is a topper.
	LDA temp
	CLC
	ADC #$03
	STA currentPathTile_TR
	JMP topRightCornerIsDone
topCenterIsAPath4:
	;; right is a path, top center is a path.
	;; check if diag is a path
	LDA TR_path
	BNE topRightIsAPath2
	;; that means this is an interior corner
	LDA temp
	CLC
	ADC #$0d
	STA currentPathTile_TR
	JMP topRightCornerIsDone
topRightIsAPath2:
	;; right is a path, top is a path, diag is a path
	;; full path tile
	LDA temp
	CLC
	ADC #$0F ;; this gives the staggered default tile to top right and bottom left.
	STA currentPathTile_TR
	;; last top right possibility
topRightCornerIsDone:
	;;;;; do bottom left
	LDA CL_path
	BNE leftIsAPath2
	;; left is NOT a path
	;; check bottom
	LDA BC_path
	BNE bottomCenterIsPath
	;; left is not a path
	;; bottom is not a path
	;; that means this is a bottom corner.
	LDA temp
	CLC 
	ADC #$07
	STA currentPathTile_BL
	JMP bottomLeftCornerIsDone
bottomCenterIsPath:
	;; left is not a path, but bottom is
	;; that means this is an edger
	LDA temp
	CLC
	ADC #$05
	STA currentPathTile_BL
	JMP bottomLeftCornerIsDone
leftIsAPath2:
	;; if the left IS a path
	;; check bottom
	LDA BC_path
	BNE bottomCenterIsPath2
	;; left is a bath, but bottom is not
	;; this is an bottom edger
	LDA temp
	CLC
	ADC #$08
	STA currentPathTile_BL
	JMP bottomLeftCornerIsDone
bottomCenterIsPath2
	;; left is a path, bottom is a path
	LDA BL_path
	BNE bottomLeftIsPath
	;; interor
	LDA temp
	CLC
	ADC #$0c
	STA currentPathTile_BL
	JMP bottomLeftCornerIsDone
bottomLeftIsPath:
	LDA temp
	CLC
	ADC #$0F ;; this gives the staggered default tile to top right and bottom left.
	STA currentPathTile_BL
	;;last possibility
bottomLeftCornerIsDone:
	;;; bottom right corner
	LDA CR_path
	BNE rightIsPath
	;; right is not a path
	LDA BC_path
	BNE bottomCenterIsPath3
	;; no path beneath, no path to the right
	;; this is a bottom right corner.
	LDA temp
	CLC
	ADC #$0a
	STA currentPathTile_BR
	JMP bottomRightIsDone
bottomCenterIsPath3:
	;; right is not path
	;; butt below me is
	;; this is a right edger.
	LDA temp
	CLC
	ADC #$06
	STA currentPathTile_BR
	JMP bottomRightIsDone
rightIsPath:
	;; right is path.
	LDA BC_path
	BNE bottomCenterIsPath4
	;;; right is path, but bottom is not.
	;; this is a bottom edger
	LDA temp
	CLC
	ADC #$09
	STA currentPathTile_BR
	JMP bottomRightIsDone
bottomCenterIsPath4:
	;; right is path, center is path.
	LDA BR_path
	BNE bottomRightIsPath
	;; right,bottom center are paths, but bottom right is not path.
	;; this is an interior corner
	LDA temp
	CLC
	ADC #$0e
	STA currentPathTile_BR
	JMP bottomRightIsDone
bottomRightIsPath
	LDA temp
	STA currentPathTile_BR
	;; last possibility.
bottomRightIsDone:
;;=================================================	
GetPathsDone:
	LDA currentPathTile_TL ;; top left of curent tile / path tile	
	STA updateTile_00
			;; top right of current tile.
			
	LDA currentPathTile_TR
	STA updateTile_01

	LDA currentPathTile_BL
	STA updateTile_02
	LDA currentPathTile_BR
	STA updateTile_03

	RTS
	
	
	
