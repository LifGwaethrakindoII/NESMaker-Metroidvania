doHandleUpdateScreen:
	 LDA hudUpdates
	 BEQ noHudUpdatesThisFrame
		; ;; there is hud updates this frame.
		;;; PRESUMES THAT SECOND SCREEN FLAGS BIT IS FOR HIDING HUD
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		LDA ScreenFlags00
		AND #%01000000
		BNE noHudUpdatesThisFrame
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			SwitchBank #$18
				JSR doUpdateHudElement_bank18
			ReturnBank
 noHudUpdatesThisFrame:
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set focus variables to know which nametable is the one to update.
	LDX player1_object
	LDA Object_screen,x
	AND #%00000001
	BEQ updatesToEvenNametable
		;;updates to odd nametable
		LDA #$24
		STA camFocus_tiles
		LDA #$27
		STA camFocus_att
		JMP gotScreenFocus
	updatesToEvenNametable:
		LDA #$20
		STA camFocus_tiles
		LDA #$23
		STA camFocus_att
	gotScreenFocus:
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Byte byte has been flipped.
;; go through collision by collision to get rid of potential boss tiles.
;; held in bossTile_hold over frames.
;; assumes boss block is in tile 4
	LDA bossByte
	BNE +doCheckForBossByteTiles
		;;;skip boss byte tiles.  Byte was not flipped
		JMP +skipBossByte
	+doCheckForBossByteTiles
		LDY bossTile_hold
		LDA camFocus_tiles
		CMP #$20
		BNE +isSecondScreen
			LDA collisionTable,y
			CMP #$04 ;; value of boss block tile.
			BEQ +dontSkipThisTile
				JMP +skipThisTile
			+dontSkipThisTile
				LDA #$00
				STA collisionTable,y
				JMP +updateTile
		+isSecondScreen
			LDA collisionTable2,y
			CMP #$04
			BEQ +dontSkipThisTile
				JMP +skipThisTile
			+dontSkipThisTile
				LDA #$00
				STA collisionTable2,y
				
			+updateTile
				LDA camFocus_tiles
				STA temp1
			
					TYA
					STA temp
					LSR
					LSR
					LSR
					LSR
					LSR
					LSR
					clc
					ADC temp1
					STA temp2 ;;;temp16+1
					TYA
					AND #%11110000
					ASL
					ASL
					STA tempz
					TYA
					AND #%00001111
					ASL
					ORA tempz
					STA temp3 ;temp16
					
			;;; SET THE TILE NUMBER TO CHANGE TO.	
				LDA #$00 ;; the tile to change.
						;;; this is in tiles, so if you wanted the second "metatile",
						;;; use 2, not 1.  If you wanted the tile in the next row, 
						;;; use #$20, not #$10.  Etc.
				STA tempA
				CLC
				ADC #$01
				STA tempB
				CLC
				ADC #$0F
				STA tempC
				CLC
				ADC #$01
				STA tempD
				
				
				LDY #$00
					LDA temp2
					STA scrollUpdateRam,y
					INY
					LDA temp3
					STA scrollUpdateRam,y
					INY
					LDA tempA
					STA scrollUpdateRam,y
					INY
					
					LDA temp2
					STA scrollUpdateRam,y
					INY
					LDA temp3
					CLC
					ADC #$01
					STA scrollUpdateRam,y
					INY
					LDA tempB
					STA scrollUpdateRam,y
					INY
					
						LDA temp3
						CLC
						ADC #$20
						STA temp3
						LDA temp2
						ADC #$00
						STA temp2
					
					LDA temp2
					STA scrollUpdateRam,y
					INY
					LDA temp3
					STA scrollUpdateRam,y
					INY
					LDA tempC
					STA scrollUpdateRam,y
					INY
					
					LDA temp2
					STA scrollUpdateRam,y
					INY
					LDA temp3
					CLC
					ADC #$01
					STA scrollUpdateRam,y
					INY
					LDA tempD
					STA scrollUpdateRam,y
					INY
				
				TYA
				STA maxScrollOffsetCounter
				
				
						
				
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;; Turn on update screen on next frame.
					LDA updateScreenData
					ORA #%0000100
					STA updateScreenData
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
		+skipThisTile
			LDY bossTile_hold
			INY 
			CPY #240
			BEQ +doneWithScreenCheck
				;;;not done yet.
				;;;prepare to loop on next frame
				
				TYA 
				STA bossTile_hold
				JMP +skipBossByte
			+doneWithScreenCheck
				LDA #$00
				STA bossTile_hold
				STA bossByte
				LDA ScreenFlags00
				AND #%11100111 
				STA ScreenFlags00
				LDA camX
				CLC
				ADC #$01
				STA camX
				LDA camX_hi
				ADC #$00
				STA camX_hi
				
				LDA scrollByte
				ORA #%00000010
				STA scrollByte
	+skipBossByte
	

	LDA gameHandler
	AND #%10000000
	BNE doUpdateToNewScreen
	JMP dontUpdateToNewScreen
doUpdateToNewScreen:
	LDA #$00
	STA soft2001	
	JSR doWaitFrame
	

	
	LDA currentNametable
	LDX player1_object
	STA Object_screen,x
	
	LSR
	LSR
	LSR
	LSR
	STA camY_hi
	LDA currentNametable
	AND #%00001111
	STA camX_hi

	
	JSR doLoadScreen2
	JSR doLoadScreen
	LDA gameHandler
	AND #%01111111
	STA gameHandler
	RTS
dontUpdateToNewScreen:	
;

	RTS