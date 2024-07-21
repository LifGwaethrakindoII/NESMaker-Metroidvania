	
	;LDA collisionsToCheck ;; declared in doHandlePhysics script
							;; the last nibble, each bit corresponding to a point to check.
							;; 0001 = top left
							;; 0010 = top right
							;; 0100 = bottom right
							;; 1000 = bottom left
							
	;;; will only need to use col pt 0 and 1 to see if we should evaluate from col table 1 or 2.
	;;; since they represent the left and the right of the object, the other checks would be
	;;; redundant.
	LDA #$00
	STA tempA
	STA tempB
	STA tempC
	STA tempD

;	LDA collisionsToCheck
	;AND #%00000001
	;BEQ noCollision_point0 ;; ignore checking for point 0
	LDA xHold_screen
	AND #%00000001
	STA tempx ;; we will flip this if we have crossed threshold for left points

	LDA yHold_hi
	CLC
	ADC self_top
	STA tileY
	
	LDA xHold_hi
	CLC
	ADC self_left
	STA tileX
	BCC +pointDidNotCrossThreshold
		;; x point did cross threshold.
	LDA tempx
	EOR #%00000001
	STA tempx
+pointDidNotCrossThreshold
	
	JSR GetTileAtPosition
	LDA tempx
	AND #%00000001
	BEQ inLeftCt
		LDA #$01
		STA temp2
		LDA collisionTable2,y
		JMP gotPoint0
	inLeftCt:
		LDA #$00
		STA temp2
		LDA collisionTable,y
gotPoint0:
	STA tempA
	;BEQ noCollision_point0
	;JMP doneWithTileCollision
noCollision_point0:

	;LDA collisionsToCheck
	;AND #%00000010
	;BEQ noCollision_point1

	LDA xHold_screen
	AND #%00000001
	STA tempy ;; for right points. 
	; LDA yHold_hi
	; CLC
	; ADC self_top
	; STA tileY
	
	
	LDA xHold_hi
	CLC
	ADC self_right
	STA tileX
	BCC +pointDidNotCrossThreshold
		LDA tempy
		EOR #%00000001
		STA tempy
+pointDidNotCrossThreshold:
	

	LDA tempy
	BEQ inLeftCt2
inRightCt2:
		LDA #$01
		STA temp2
	JSR GetTileAtPosition
	LDA collisionTable2,y
	JMP gotPoint1
inLeftCt2
		LDA #$00
		STA temp2
	JSR GetTileAtPosition
	LDA collisionTable,y
	JMP gotPoint1
	
gotPoint1:
	STA tempB
	;BEQ noCollision_point1
	;JMP doneWithTileCollision

noCollision_point1:

;	LDA collisionsToCheck
;	AND #%00000100
;	BEQ noCollision_point2
		
	LDA yHold_hi
	CLC
	ADC self_bottom
	STA tileY

	LDA tempy
	AND #%00000001
	BEQ inLeftCt3
inRightCt3:
		LDA #$01
		STA temp2
	JSR GetTileAtPosition
	LDA collisionTable2,y
	JMP gotPoint2
inLeftCt3
		LDA #$00
		STA temp2
	JSR GetTileAtPosition
	LDA collisionTable,y
	JMP gotPoint2
	
gotPoint2:
	STA tempC
	;BEQ noCollision_point2
	;JMP doneWithTileCollision

	
	
noCollision_point2:	


;	LDA collisionsToCheck
;	AND #%00001000
;	BEQ noCollision_point3
	
		
	LDA yHold_hi
	CLC
	ADC self_bottom
	STA tileY
	
	
	LDA xHold_hi
	CLC
	ADC self_left
	STA tileX
	

	LDA tempx
	AND #%00000001
	BEQ inLeftCt4
inRightCt4:
		LDA #$01
		STA temp2
	JSR GetTileAtPosition
	LDA collisionTable2,y
	JMP gotPoint3
inLeftCt4
		LDA #$00
		STA temp2
	JSR GetTileAtPosition
	LDA collisionTable,y
	JMP gotPoint3
	
gotPoint3:
	STA tempD
	;BEQ noCollision_point3
	;JMP doneWithTileCollision

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

noCollision_point3:
		


doneWithTileCollision:
	;;; now the first non-zero collision point that this object encountered
	;;; is in the accumulator.
	;;; if the result was zero, doHandleObjects will skip tile behaviors.
	;;;; otherwise, it will run a trampoline to that behavior.
	;;;; this will allow us to utilize other banks and whatnot, since doHandleObjects
	;;;; is in the static bank.