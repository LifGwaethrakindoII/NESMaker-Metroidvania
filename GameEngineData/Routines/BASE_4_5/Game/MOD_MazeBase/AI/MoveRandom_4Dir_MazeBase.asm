;;;; Choose out of 4 directions, UDLR.
	TXA	
	STA tempA
	JSR doGetRandomNumber
	AND #%00000110
	TAY
	LDA DirectionTableOrdered,y
	STA tempB
	LDA FacingTableOrdered,y
	STA tempC
	StartMoving tempA, tempB, #$00
	ChangeFacingDirection tempA, tempC


;; 000 = down
;; 001 = down right
;; 010 = right
;; 011 = up right
;; 100 = up
;; 101 = up left
;; 110 = left
;; 111 = down left