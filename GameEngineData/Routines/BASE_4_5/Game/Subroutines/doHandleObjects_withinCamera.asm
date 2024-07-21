doHandleObjects:
	LDA gameStatusByte
	AND #%00000001 ;;; this will skip object handling.
	BEQ dontSkipObjectHandling
		RTS
dontSkipObjectHandling:
	LDA gameHandler
	AND #%10000000
	BEQ dontSkipObjectHandling2
		;;; this was in the middle of a screen transition
		RTS
dontSkipObjectHandling2

	;;;; RESET ANY VARIABLES THAT NEED RESET BEFORE EVALUATION
	LDA npcTrigger
	AND #%11111110
	STA npcTrigger
	;;;; Create state
	LDX #$00
		
	loop_doHandleObjectsLoop:

		LDA Object_status,x
		AND #%11000000
		BNE objectHasActivity
			;;;; this object is not being created
			;;;; and is not active.
			JMP doObjectIsInactive
			
		objectHasActivity:
			LDA Object_status,x
			AND #OBJECT_QUEUED_FOR_DESTRUCTION
			BEQ doNotDestroyThisObject
				;;;; Destroy 
				.include SCR_DESTROY_STATE
				LDA #$00
				STA Object_status,x
				JMP doObjectIsInactive ;; destroying will automatically set this object to inactive.
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				;;;;;;;;END OF THE LINE FOR THIS OBJECT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			
		doNotDestroyThisObject:
		
			LDA Object_status,x
			AND #OBJECT_IS_ACTIVE
			BEQ checkForObjectActivation
				JMP doActiveObject
			checkForObjectActivation:
			
				LDA Object_status,x
				AND #OBJECT_QUEUED_FOR_ACTIVATION
				BNE doCreateThisNewObjectd
					JMP doObjectIsInactive
				doCreateThisNewObjectd:
			;;; create the new object.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Here, we create a new object.  It will exist upon the next frame.
					.include SCR_CREATE_STATE
					
					JSR doHandleCreateState
					SwitchBank #$1C
						LDY Object_type,x
						LDA ObjectFlags,y
						STA Object_flags,x
					ReturnBank
					
					JMP doObjectIsInactive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Below is everything that happens for an active object.
		doActiveObject:
		
			;;;; EVALUATE THE CAMERA POSITION

				LDA Object_x_hi,x
				STA pointer
				LDA Object_screen,x
				AND #%00001111
				STA pointer+1
							
				Compare16 pointer+1, pointer, camX_hi, camX
				; arg0 = high byte of first value
				; arg1 = low byte of first value
				; arg2 = high byte of second value
				; arg3 = low byte of second value

				+
					JMP +checkRightForDrawingOffCamera
				
				++		
					;;; object is outside camera
					;;; so skip updating this object.
					JMP doObjectIsInactive
					
			+checkRightForDrawingOffCamera
				LDA Object_x_hi,x
				;CLC
				;ADC #$10 ;; arbitrary - approximate width of objects
				STA pointer
				LDA Object_screen,x
				;ADC #$00
				AND #%00001111
				STA pointer+1

				LDA camX
				STA pointer5
				LDA camX+1
				clc
				ADC #$01
				STA temp
				Compare16 pointer+1, pointer, temp, pointer5; camX
				+
					;; this camera is out of camera range.
					JMP doObjectIsInactive
				++
					;;; this object is in camera range.
					;;; cotninue evaluating this object. 
				
		
			;; ORDER OF OPERATIONS
				; 1) Check to see if this object reads input (status byte).  If not (0), skip input read.
					; 2) We have the states from each button (8 buttons, two controllers) from input management.  	
							; So now we compare it to this object, and whether or not it should
							; have any behaviors associated with it's pressed, down, released, or up states.
				; 3) Switch banks to the one that contains our LUTs for object data (sizes and whatnot)
				; 4) Check to see if this object observes physics (status byte).  If not (0), skip physics.
					
					; 5) Do a basic physics update for this object.
					; 6) Check to see if this object observes tile collisions.  If not (0), skip tile collisions.
							; 7) Check tile collisions.
					; 8) Check to see if this object observes object collisions.  If not (0), skip object collisions.
							; 9) Check object collisions.
					; 10) Check bounds.
				; 11) Update the object's position and behavior based on above.
				; 12) Check to see if this object should be drawn.  If not (0), skip drawing.
					; 13) Draw this object.
				; 14) Return to main bank.

				;; So status byte would be:
				;; #% 7 6 5 4 3 2 1 0
				;; 	  | | | | | | | + - Queued for deactivation (?)
				;; 	  | | | | | | + --- Observes drawing
				;; 	  | | | | | + ----- Observes Object Collisions
				;; 	  | | | | + ------- Observes Tile Collisions
				;; 	  | | | + --------- Observes Physics
				;; 	  | | + -----------	Observes Input
				;; 	  | + ------------- Queued for activation
				;; 	  + --------------- Active
			
			LDA Object_type,x
			STA tempObjType ;; not corrupted by any other routines
							;; used in timer handlings so no reference to bank1c is needed.
			SwitchBank #$18
				LDY Object_type,x
				LDA ObjectReaction,y
				STA EdgeSolidReaction ;; temporarily holds this data.
		
			ReturnBank
					
			LDA Object_status,x
			AND #OBJECT_OBSERVES_INPUT
			BNE ObjectReceivesInput
			JMP ObjectDoesNotRecieveInput
			ObjectReceivesInput:
				;;;; Input state
				.include SCR_INPUT_STATE
				
				
				
					
				
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			ObjectDoesNotRecieveInput:
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			LDA Object_status,x
			AND #OBJECT_OBSERVES_PHYSICS
			BNE ObjectDoesObservePhysics
			JMP ObjectDoesNotObservePhysics
			ObjectDoesObservePhysics:
				;;;;; SYSTEM PHYSICS
				;; we will use bank #$1C for physics since it has our lut tables in it.
				SwitchBank #$1C
					TXA
					PHA
					.include SCR_HANDLE_PHYSICS
					PLA
					TAX
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DEMO PHYSICS
				ReturnBank
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			ObjectDoesNotObservePhysics:
			
			SwitchBank #$18
				JSR doTileObservationLogic
			ReturnBank
			
			LDA Object_status,x
			AND #OBJECT_OBSERVES_OBJECTS
			BNE ObjectDoesObserveObjects
				JMP ObjectDoesNotObserveObjects
			ObjectDoesObserveObjects:
				;; Object collisions
			SwitchBank #$1C
				JSR doObjectCollisions_bank1C
			ReturnBank
		
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			ObjectDoesNotObserveObjects:
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			
			
			SwitchBank #$18
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
				;;;: Bounds reached
			;	.include SCR_BOUNDS_STATE - this would be handled inside of physics.  If a potential position
			;								represents the "bounds", this would be triggered.
			
				;;;; Update state
			;; At ths point, physics and positioning are all figured out.
			;; 			now we update the object.  This includes pushing temp positions to new positions,
			;; 			handling timers, doing AI mode updates and whatnot, etc, and anything that should happen
			;;			specifically for this object in the update state.
				TXA
				PHA
				JSR doUpdateState
				JSR doHandleObjectUpdate
				PLA
				TAX
			ReturnBank
			
			SkipUpdateObjectPos:
		
				;;;; Timer
				;.include SCR_TIMER_STATE - timer's are handled inside of update state.
			JustDrawObject:	
			SwitchBank #$1C
				TXA
				PHA
				JSR doUpdateActionTimer
				PLA
				TAX
		;;;;;;;;;
			LDA Object_status,x
			AND #OBJECT_OBSERVES_DRAWING
			BEQ ObjectDoesNotDraw
				;;; Lastly, we draw the sprite.
				;;; The sprite should be drawn anyway, HERE.
				
				TXA
				PHA
				TYA
				PHA
				JSR doDrawSprites
				PLA
				TAY
				PLA
				TAX
				
				JSR doUpdateSpriteTimer
				
				
				;;; And additional object specific drawing stuff would go here. 
				
				.include SCR_DRAW_STATE
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			ObjectDoesNotDraw:
			ReturnBank
		doObjectIsInactive:
		;; cycle through objects.
			; CPX camObject
				; BEQ isCamObjectForScrollHandle
					; JMP notCamObjectForScrollHandle
				; isCamObjectForScrollHandle:
					; .include SCR_HANDLE_H_SCROLL
					; .include SCR_HANDLE_V_SCROLL
				; notCamObjectForScrollHandle:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End Object Update.
	INX
	CPX #TOTAL_MAX_OBJECTS ;; a number that is configured
							;; in the Object Variables tab
							;; of project settings.
							
							;; This space makes use of ObjectRam.  By default, it is one page in size (256 bytes),
							;; however, it could stretch into the scratch ram if desired allowing for 512 bytes for object use.
	BEQ DoneHandlingObjects
	JMP loop_doHandleObjectsLoop
	
DoneHandlingObjects:
;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RTS