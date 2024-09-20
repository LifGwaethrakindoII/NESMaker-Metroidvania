	;;; object collions have to check from current index
	;;; through the rest of the objects on the field of play.
	;;; Objects prior to its index have already checked against this particular object
	;;; so they do not have to be checked redundantly.

	TXA
	PHA
	STA selfObject ;; this will be used to talk about "self"
	TYA
	PHA

	;;; we probably want this to live inside bank 1C
	;;; so that we can access flag data easily with no RAM.
	SwitchBank #$1C
		LDA Object_status,x
		AND #%10000000
		BNE doCheckSelfForObjectCollision
			;; object is inactive.
			JMP doneWithObjectCollisionCheck
		doCheckSelfForObjectCollision:
			;; object is active.
			LDY Object_type,x
			LDA ObjectFlags,y
			STA tempA ;; temp A now holds the current object flags.
					;; collision box is still held over from the physics routine.
			LDA Object_x_hi,x
			CLC
			ADC self_left
			STA bounds_left
			LDA Object_x_hi,x
			CLC
			ADC self_right
			STA bounds_right
			
			LDA Object_y_hi,x
			CLC
			ADC self_top
			STA bounds_top
			LDA Object_y_hi,x
			CLC
			ADC self_bottom
			STA bounds_bottom
			LDX #$00
			doObjectCollisionLoop:

					TXA
					STA otherObject
					LDA Object_status,x
					AND #%10000000
					BNE doCheckForObjectCollision
						JMP checkNextObjectCollision
					doCheckForObjectCollision:
					LDY Object_type,x
					LDA ObjectFlags,y
					STA tempB ;; now tempB holds the "other" object flag.
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;;; set up "other" bounding box.
					LDA Object_x_hi,x
					CLC 
					ADC ObjectBboxLeft,y
					STA other_left
					CLC
					ADC ObjectWidth,y
					STA other_right
					SEC
					SBC other_left
					LSR
					STA other_center_x
					
					LDA Object_y_hi,x
					CLC
					ADC ObjectBboxTop,y
					STA other_top
					CLC
					ADC ObjectHeight,y
					STA other_bottom
					SEC
					SBC other_top
					LSR
					STA other_center_y ;; self center in the vertical direction.
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;; This is where we do the flag comparisons.
					;; For instance, if A is a player, it would usually check for 
					;; all types of collisions.
					;; A monster might ignore power ups and other monsters.
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;; Or, in a two player game, we might expect to see 
					;; same "team" identifiers ignore each other.
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;; Here is a generic check against all types for a player type
					;; object, assuming that in type,
					;; 		bit 0 = persistent (ignore)
					;;		bit 1 = player
					;;		bit 2 = player weapon
					;;		bit 3 = monster
					;; 		bit 4 = monster weapon
					;;		bit 5 = power up
					;;		bit 6 = trigger
					;; 		bit 7 = npc
				;;============ IF THE SELF OBJECT IS A PLAYER....
					LDA tempA
					AND #%00000010
					BNE isPlayerForObjectCheck
						JMP notPlayer_forObjectCollisionCheck
					isPlayerForObjectCheck:
						;; this has the player box ticked for
						;; Object collision checking.
						LDA tempB
						AND #%00011000 ;; is it a monster or monster weapon?
						BEQ notHarmfulToPlayer
							
							;; this was harmful to the player.
							JSR doCompareBoundingBoxes
								;; the above routine returns 1 if there was a collision
								;; or 0 if there was no collision.
							BEQ notHarmfulToPlayer
								;;; yes, there was a collision here.
								;;; This should affect the PLAYER, the SELF object.
								TXA
								PHA
								LDX selfObject
								SwitchBank #$18
									;;; do hurt player stuff.
									JSR doHandleHurtPlayer
								ReturnBank
								PLA
								TAX
								JMP checkNextObjectCollision
						notHarmfulToPlayer:
						LDA tempB
						AND #%00100000
						BEQ notPickupPowerupForPlayerCollision
								;; this is a pickup or powerup.
							JSR doCompareBoundingBoxes
							BNE isPickupPowerup
								JMP notPickupPowerup
							isPickupPowerup:	
								DestroyObject 
								SwitchBank #$18
									;; do pickup stuff here.
								ReturnBank
								JMP checkNextObjectCollision
						notPickupPowerupForPlayerCollision:
						LDA tempB
						AND #%10000000
						BEQ notNPCforPlayerCollision
							JSR doCompareBoundingBoxes
							BNE isNpcPlayerCollision
								JMP checkNextObjectCollision
							isNpcPlayerCollision
								;;;;; SET UP NPC FUNCTION
								LDA Object_id,x
								TXA
								PHA
									LDA stringGroupPointer,x
									STA npc_text
								PLA
								TAX
								LDA npcTrigger
								ORA #%00000001
								STA npcTrigger
								
								JMP checkNextObjectCollision
						notNPCforPlayerCollision:
					notPlayer_forObjectCollisionCheck:
				;;============= IF THE SELF OBJECT IS A MONSTER
						LDA tempA
						AND #%00011000 ;; is it a monster or monster weapon?
						BEQ notMonsterOrMonsterWeapon
							LDA tempB
							AND #%00000010
							BEQ notPlayerForMonsterCollision
								JSR doCompareBoundingBoxes
								BEQ notLethalResult
									SwitchBank #$18
										;; This should affect the PLAYER, the OTHER object, currently loaded in x.
										JSR doHandleHurtPlayer
									ReturnBank
									JMP checkNextObjectCollision
								notLethalResult
							notPlayerForMonsterCollision:
								LDA tempB
								AND #%00000100 ;; is it a player weapon?
								BEQ notPlayerWeaponForMonsterCollision
									JSR doCompareBoundingBoxes
									BEQ notHarmfulToMonster
										;;; this should affect the MONSTER, the SELF object.
										;;; could also check tempB if you don't want a player weapon to
										;;; "hurt" a monster weapon.
										LDA tempA
										AND #%00001000
										BEQ notMonsterForPlayerWeaponInteraction
											TXA 
											PHA
											SwitchBank #$18
												LDX selfObject
												JSR doHandleHurtMonster
												LDX otherObject
													LDA Object_type,x
													CMP #$03
													BEQ +skip
														DestroyObject
													+skip
													
													
											ReturnBank
											PLA
											TAX
											JMP checkNextObjectCollision
										notMonsterForPlayerWeaponInteraction:
									notHarmfulToMonster:
								notPlayerWeaponForMonsterCollision:
						notMonsterOrMonsterWeapon
						
						LDA tempA
						AND #%00100000
						BEQ notPickupPowerup
					;=========== IF THE SELF OBJECT IS A POWERUP TYPE
					;
							;;; it is a pickup or powerup.
							;;; player and player weapons interact with this.
							LDA tempB
							AND #%00000110
							BEQ notPlayerForPickupCollision
								JSR doCompareBoundingBoxes
								BEQ doNotActivatePickup
									TXA
									PHA
									LDX selfObject
									DestroyObject
									SwitchBank #$18
									;; do pickup things.
									
										.include SCR_PICKUP_SCRIPTS
									
									ReturnBank
									PLA 
									TAX
								doNotActivatePickup:
							notPlayerForPickupCollision
						notPickupPowerup
				checkNextObjectCollision:
					INX 
					CPX #TOTAL_MAX_OBJECTS
					BNE moreObjectsToCheck
						JMP doneWithObjectCollisionCheck
					moreObjectsToCheck:
						JMP doObjectCollisionLoop
			doneWithObjectCollisionCheck:
		
	
	
	ReturnBank
	
	PLA
	TAY
	PLA
	TAX