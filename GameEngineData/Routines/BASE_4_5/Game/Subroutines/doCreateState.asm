;;;create state
	;; current object is in x.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TURN THE OBJECT ON:
	; LDA Object_status,x
	; AND #%01111111
	; ORA #%01000000
	; STA Object_status,x
;; Object is now on.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Check if we should turn on drawing for this object, or if it is a control object.

; ;; TURN DRAWING OBJECT ON.
	; LDA Object_status,x
	; ORA #%00100000
	; STA Object_status,x
; ;;;;;;;;;;;;;;;;;;;;;;;;;

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;; Check if we should turn on collisions.
	; LDA Object_status,x
	; ORA #%00011000 ;; turn on tile and object based collisions.
	; STA Object_status,x
	


; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;;;; HERE WE CHECK FOR THE BEHAVIORS, AND DO RESULTING BEHAVIORS.
	; ;;; we have to bounce out to bank 16 to get the position of this object's create events.
	; SwitchBank #$16
	
		; LDA CREATE_STATE_POINTER_LO,x
		; STA temp16
		; LDA CREATE_STATE_POINTER_HI,x
		; STA temp16+1
		; ;;;; now, the label for this object's create state is in (temp16).
		
		; LDY #$00 ;; we will use y to keep track of what offset we are on.
		; loop_DoCreateBeahviors:
			; LDA (temp16),y
			; BNE doCreateBehavior
				; ReturnBank
				; JMP noCreateBehaviors
			; doCreateBehavior:
				; STA temp ;; now the value that was in that temp space, the opcode, is in temp.
				; ;;; here, all of the create behaviors are done.
				; ;;; a non-zero number means that this was an opcode, to do a thing.
				; TYA
				; PHA
				; LDA temp
				; ASL ;; because we use words, not bytes.
				; TAY
				; LDA Object_Behavior_Table,y
				; STA pointer
				; LDA Object_Behavior_Table+1,y
				; STA pointer+1
				
	; ReturnBank
	; ;SwitchBank #$17 ;; this is where the actual routines are for behaviors.
				; ;;; now pointer points to the behavior invoked
				; ;;;; HERE figure out how many arguments this opcode has (from another table.)
				; ;;;; Do a code trampoline to that routine.
				; JSR doCreateTrampoline
					; JMP pastCreateTrampoline
				; doCreateTrampoline:
					; JMP (pointer)
					; ;;; make sure that the behavior ends in an RTS, and then it will 
					; ;;; slide right back to this part of the code.
				; pastCreateTrampoline:
				
				
				; PLA
				; TAY
		
		; noCreateBehaviors:
	; ;ReturnBank

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DoneCreateState:
