MACRO CreateObject arg0, arg1, arg2, arg3
	;; arg0 = x
	;; arg1 = y
	;; arg2 = object
	;; arg3 = beginning state
	JSR FindFreeObjectSlot
	CPX #$FF
	BNE +CreateThisObject
	JMP +NoFreeSpaces
+CreateThisObject:
	
	LDA arg0
	STA arg0_hold
	LDA arg1
	STA arg1_hold
	LDA arg2
	STA arg2_hold
	LDA arg3
	STA arg3_hold
	
	
	TYA
	PHA
	LDA currentNametable
	STA Object_screen,x
	JSR doCreateObject
	
	PLA
	TAY
+NoFreeSpaces:
	ENDM