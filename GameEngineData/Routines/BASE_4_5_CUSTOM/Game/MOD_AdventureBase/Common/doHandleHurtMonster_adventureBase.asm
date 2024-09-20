
	TXA
	PHA
	STA temp
	GetActionStep temp
	CMP #$07 ;; we will use action step 7 for hurt.
	BNE +dontSkipHurtingThisObject
		JMP +doSkipHurtingThisObject ;; if he is hurt, he can't be hurt again.
	+dontSkipHurtingThisObject:
		;;;;;;;;;;;;;;;;;; Here, we need to determine the direction.
		;;;;;;;;;;;;;;;;;; To do that, we can compare positions of self and other's center.
		;;;;;;;;;;;;;;;;;;;; HANDLE RECOIL
			TXA
			PHA
			LDX selfObject
			LDA Object_direction,x
			AND #%11110000
			STA temp1
			PLA
			TAX
			
			LDA Object_direction,x
			AND #%00001111
			ORA temp1
			STA Object_direction,x
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
		ChangeActionStep temp, #$07
		DEC Object_health,x
		LDA Object_health,x
		BEQ +dontSkipHurtingThisObject
			JMP +doSkipHurtingThisObject
		+dontSkipHurtingThisObject:
			;; maintain x and y positions for dropable location
			LDA Object_x_hi,x
			STA tempA
			LDA Object_y_hi,x
			STA tempB
			DestroyObject
			;;; here, we can handle droppables.
			
			;;; dropable script will pick a random number between 0 and 7.
			;;; the following are the values of the number game object that could spawn.
			;;; if it is an #$FF, then nothing will spawn.
			;;; If one of the values is a 01, then there will be a 1 in 8 chance that a monster will drop game object 1 when it dies.
			;;; If two of the values is a 01, then there will be a 1 in 4 chance that a monster will drop game object 1 when it dies.
			;;; You can use this to, with a chance, spawn any game object 00 - 0f.  The more of a particular value, the better chance that spawns.
			
			DROPABLE_00 = #$02
			DROPABLE_01 = #$02
			DROPABLE_02 = #$05
			DROPABLE_03 = #$05
			DROPABLE_04 = #$FF
			DROPABLE_05 = #$FF
			DROPABLE_06 = #$FF
			DROPABLE_07 = #$FF
			
			JSR doGetRandomNumber
			AND #%00000111 ;; random number between 0 and 7.
			TAY ;; load it into y.
			LDA DropTable,y
			CMP #$FF
			BNE +dontSkipHurtingThisObject
				JMP +doSkipHurtingThisObject
			+dontSkipHurtingThisObject
				STA tempC
				CreateObject tempA, tempB, tempC, #$00, currentNametable
				;; create the value that is in the droppable table
			+doSkipHurtingThisObject
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;;; Here we will look at all of the tiles one by one, and if there is a monster block tile, we will convert it
			CountObjects #%00001000
			BEQ +noMoreMonsters
				JMP +doSkipHurtingThisObject
			+noMoreMonsters
				
				MONSTER_BLOCK_TILE = #$07 ; the number collision type of your monster block.
				LDX #$00
				doCheckForMonsterBlockAfterMonsterDeath:
					LDA currentNametable
						AND #%00000001
						BEQ +isEvenCt
							LDA #$24
							STA temp1 ;; high byte of thing
							;;; is odd col table.
							LDA collisionTable2,x
							CMP #MONSTER_BLOCK_TILE
							BEQ +isMonsterBlockTile
								JMP +notMonsterBlockTile
							+isMonsterBlockTile
								;; is monster block table.
								LDA #$00
								STA collisionTable2,x
								
								JSR getTileToChange_forMonBlock

								JMP +doneWithTileUpdate
						+isEvenCt
							LDA #$20
							STA temp1 ;; high byte of thing.
							;;; is odd col table.
							LDA collisionTable,x
							CMP #MONSTER_BLOCK_TILE
							BEQ +isMonsterBlockTile
								JMP +notMonsterBlockTile
							+isMonsterBlockTile
								;; is monster block table.
								LDA #$00
								STA collisionTable,x
								JSR getTileToChange_forMonBlock
		
								JMP +doneWithTileUpdate
								
								
								
							getTileToChange_forMonBlock:
								TXA
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
								TXA
								AND #%11110000
								ASL
								ASL
								STA tempz
								TXA
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
								TriggerScreen screenType
								RTS
						+doneWithTileUpdate
	
						
						JSR doWaitFrame
					+notMonsterBlockTile
					INX 
					CPX #240
					BEQ +doSkipHurtingThisObject ;; done
						JMP doCheckForMonsterBlockAfterMonsterDeath ;; last monster block.
			
	+doSkipHurtingThisObject
		PLA
		TAX
