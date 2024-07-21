;;;;; read the first behavior and do the thing.
doHandleCreateState:
	
	LDA Object_frame,x
		LSR
		LSR
		LSR
		AND #%00000111
		STA tempB
		; LDA #$00
		; STA tempD
		; SwitchBank #$1C
			; ;;; Then, get the behavior for that object on that frame number.
			; LDY Object_type,x
			; LDY #$10
			; LDA ObjectBehaviorTableLo,y
			; LDA #<Object0_ActionTypes
			; STA pointer
			
			; LDA ObjectBehaviorTableHi,y
			; LDA #>Object0_ActionTypes
			; STA pointer+1
			; LDY tempD
			; LDY #$00
			; LDA (pointer),y
			; AND #%00001111
			; STA tempB
		; ReturnBank
	;;;; object behavior tables are with the lut table.
	;;;; the lut table is in bank 1C.
	
	TXA 
	STA tempA
	
	
	DoObjectAction tempA, tempB
;	;arg0 = what object?
	;arg1 = what step for the behavior?

	
	LDA Object_status,x
	AND #%00111111
	ORA #%10000000
	STA Object_status,x ;; kick it to active
	RTS