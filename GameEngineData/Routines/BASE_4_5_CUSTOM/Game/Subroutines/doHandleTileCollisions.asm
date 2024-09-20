	
	;LDA collisionsToCheck ;; declared in doHandlePhysics script
							;; the last nibble, each bit corresponding to a point to check.
							;; 0001 = top left
							;; 0010 = top right
							;; 0100 = bottom right
							;; 1000 = bottom left
							
	;;; will only need to use col pt 0 and 1 to see if we should evaluate from col table 1 or 2.
	;;; since they represent the left and the right of the object, the other checks would be
	;;; redundant.
		
	; LDA collisionsToCheck
	; AND #%00000001
	; BEQ noCollision_point0 ;; ignore checking for point 0
	

	
	LDA xHold_hi
	CLC
	ADC self_left
	STA tileX
	; LDA Object_screen,x
	; ADC #$00
	; CMP Object_screen,x
	; BEQ CollisionPoint0didNotCrossScreenThreshold

	; ;; collision point 0 crossed screen threshold
; ;	LDA tempD
; ;	EOR #$01
; ;	STA tempz
CollisionPoint0didNotCrossScreenThreshold:

	
	LDA yHold_hi
	CLC
	ADC self_top
	STA tileY
	JSR GetTileAtPosition

	LDA xHold_screen
	AND #%00000001
	BEQ inLeftCt
		LDA #$01
		STA temp2 ;; will be used to determine which collision table we were in.
		LDA collisionTable2,y
		JMP gotPoint0
	inLeftCt:
		LDA #$00
		STA temp2 ;; will be used to determine which collision table we were in.
		LDA collisionTable,y
gotPoint0:
	STA tempA
	;BEQ noCollision_point0
;	JMP doneWithTileCollion
noCollision_point0:
	
	;JMP doneWithTileCollion

	; LDA collisionsToCheck
	; AND #%00000010
	; BEQ noCollision_point1
	
		
	LDA yHold_hi
	CLC
	ADC self_top
	STA tileY
	
	
	LDA xHold_hi
	CLC
	ADC self_right
	STA tileX
	BCC CollisionPoint1didNotCrossScreenThreshold
	;BEQ CollisionPoint1didNotCrossScreenThreshold
	;; collision point 0 crossed screen threshold
		;; so now we have to check the opposite collision table.
		LDA xHold_screen
		CLC
		ADC #$01
		AND #%00000001
		BEQ inLeftCt2
		JMP inRightCt2
		
CollisionPoint1didNotCrossScreenThreshold:

	LDA xHold_screen
	AND #%00000001
	BEQ inLeftCt2
inRightCt2:
		LDA #$01
		STA temp2 ;; will be used to determine which collision table we were in.
	JSR GetTileAtPosition
	LDA collisionTable2,y
	JMP gotPoint1
inLeftCt2
		LDA #$00
		STA temp2 ;; will be used to determine which collision table we were in.
	JSR GetTileAtPosition
	LDA collisionTable,y
	JMP gotPoint1
	
gotPoint1:
	STA tempB
	;BEQ noCollision_point1
	;JMP doneWithTileCollion

	


noCollision_point1:

	; LDA collisionsToCheck
	; AND #%00000100
	; BEQ noCollision_point2
	
		
	LDA yHold_hi
	CLC
	ADC self_bottom
	STA tileY
	
	
	LDA xHold_hi
	CLC
	ADC self_right
	STA tileX
	BCC CollisionPoint1didNotCrossScreenThreshold2

		;; so now we have to check the opposite collision table.
		LDA xHold_screen
		CLC
		ADC #$01
		AND #%00000001
		BEQ inLeftCt3
		JMP inRightCt3
		
CollisionPoint1didNotCrossScreenThreshold2:

	LDA xHold_screen
	AND #%00000001
	BEQ inLeftCt3
inRightCt3:
		LDA #$01
		STA temp2 ;; will be used to determine which collision table we were in.
	JSR GetTileAtPosition
	LDA collisionTable2,y
	JMP gotPoint2
inLeftCt3
		LDA #$00
		STA temp2 ;; will be used to determine which collision table we were in.
	JSR GetTileAtPosition
	LDA collisionTable,y
	JMP gotPoint2
	
gotPoint2:
	STA tempC
	;BEQ noCollision_point2
	;JMP doneWithTileCollion

	
	
noCollision_point2:	


	; LDA collisionsToCheck
	; AND #%00001000
	; BEQ noCollision_point3
	
		
	LDA yHold_hi
	CLC
	ADC self_bottom
	STA tileY
	
	
	LDA xHold_hi
	CLC
	ADC self_left
	STA tileX
	BCC CollisionPoint1didNotCrossScreenThreshold3

		;; so now we have to check the opposite collision table.
		LDA xHold_screen
		CLC
		ADC #$01
		AND #%00000001
		BEQ inLeftCt4
		JMP inRightCt4
		
CollisionPoint1didNotCrossScreenThreshold3:

	LDA xHold_screen
	AND #%00000001
	BEQ inLeftCt4
inRightCt4:
		LDA #$01
		STA temp2 ;; will be used to determine which collision table we were in.
	JSR GetTileAtPosition
	LDA collisionTable2,y
	JMP gotPoint3
inLeftCt4
		LDA #$00
		STA temp2 ;; will be used to determine which collision table we were in.
	JSR GetTileAtPosition
	LDA collisionTable,y
	JMP gotPoint3
	
gotPoint3:
	STA tempD
	;BEQ noCollision_point3
	;JMP doneWithTileCollion


noCollision_point3:
	;;;;;;;;;;;;;;;; Now, collision tempA-tempD hold collision data.
	;;;;;;;;;;;;;;;; Check all for solid first.
	LDA tempA
	BEQ +skipThisTile
	CMP #$01
	BNE +isNotSolid
		JMP +isSolid
	+isNotSolid
	+skipThisTile
	LDA tempB
	BNE +dontSkipThisTile
		JMP +skipThisTile
	+dontSkipThisTile:
	CMP #$01
	BNE +isNotSolid
		JMP +isSolid
	+isNotSolid
	+skipThisTile
	LDA tempC
	BEQ +skipThisTile
	CMP #$01
	BNE +isNotSolid	
		JMP +isSolid
	+isNotSolid
	+skipThisTile
	LDA tempD
	BEQ +skipThisTile
	CMP #$01
	BEQ +isSolid
	+skipThisTile
	LDA tempA
	BEQ tempAisNull
		;; temp A is not null
		LDA yHold_hi
		CLC
		ADC self_top
		STA tileY
		
		LDA xHold_hi
		CLC
		ADC self_left
		STA tileX
		JSR GetTileAtPosition ;; stores the y, which we need to know which collision table we are affecting.
		LDA tempA
		
		JMP doneWithTileCollision
	tempAisNull:
	LDA tempB
	BEQ tempBisNull
		LDA yHold_hi
		CLC
		ADC self_top
		STA tileY
		
		LDA xHold_hi
		CLC
		ADC self_right
		STA tileX
		JSR GetTileAtPosition ;; stores the y, which we need to know which collision table we are affecting.
		LDA tempB
		JMP doneWithTileCollision
	tempBisNull:
	LDA tempC
	BEQ tempCisNull
		LDA yHold_hi
		CLC
		ADC self_bottom
		STA tileY
		
		LDA xHold_hi
		CLC
		ADC self_right
		STA tileX
		JSR GetTileAtPosition ;; stores the y, which we need to know which collision table we are affecting.
		LDA tempC
		JMP doneWithTileCollision
	tempCisNull:
	LDA tempD
	BEQ tempDisNull
		LDA yHold_hi
		CLC
		ADC self_bottom
		STA tileY
		
		LDA xHold_hi
		CLC
		ADC self_left
		STA tileX
		JSR GetTileAtPosition ;; stores the y, which we need to know which collision table we are affecting.
		LDA tempD
		JMP doneWithTileCollision
	tempDisNull

	LDA #$00
	JMP doneWithTileCollision
+isSolid
	LDA #$01
	JMP doneWithTileCollision

+notSolidOrNull:

doneWithTileCollision:
	;;; now the first non-zero collision point that this object encountered
	;;; is in the accumulator.
	;;; if the result was zero, doHandleObjects will skip tile behaviors.
	;;;; otherwise, it will run a trampoline to that behavior.
	;;;; this will allow us to utilize other banks and whatnot, since doHandleObjects
	;;;; is in the static bank.