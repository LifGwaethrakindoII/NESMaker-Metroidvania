doClearAllMonsters:


	SwitchBank #$1C
	LDX #$00
	doClearObjectsLoop:
		LDY Object_type,x
		LDA ObjectFlags,y
		AND #%00000001 ;; is it persistent?
		BNE doneClearingObject
		LDA #$00
		STA Object_status,x
		STA Object_frame,x
		STA Object_direction,x
	doneClearingObject:
		INX
		CPX #TOTAL_MAX_OBJECTS
		BNE doClearObjectsLoop
	ReturnBank
	

	
	
	RTS
	
