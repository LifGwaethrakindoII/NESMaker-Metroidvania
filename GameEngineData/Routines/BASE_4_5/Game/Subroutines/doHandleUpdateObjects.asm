
	LDA ObjectUpdateByte
	AND #%00000001 ;; is it solid?
	BNE hitAsolidObject
	JMP doPossiblyUpdatePosition
hitAsolidObject:	
	
	;;;; DO SOLID EDGE BEHAVIOR FOR THIS OBJECT:
	;;;;
	LDA EdgeSolidReaction
	LSR
	LSR
	LSR
	LSR
	BNE wasNotNullReaction
	JMP doPossiblyUpdatePosition ;; because 0 is null.
wasNotNullReaction:
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;; the reaction was not null.
		CMP #$01
		BNE notOneObjectReaction
			;; is one object reaction
			JSR doAiReaction1
		
			JMP donePositionUpdate
		notOneObjectReaction:
		CMP #$02
		BNE notTwoObjectReaction
			;; is two object reaction
			JSR doAiReaction2
			JMP donePositionUpdate
		notTwoObjectReaction:
		CMP #$03
		BNE notThreeObjectReaction
			;; is three object reaction
			JSR doAiReaction3
			JMP donePositionUpdate
		notThreeObjectReaction:
		CMP #$04
		BNE notFourObjectReaction
			;; is four object reaction
			JSR doAiReaction4
			JMP donePositionUpdate
		notFourObjectReaction:
		CMP #$05
		BNE notFiveObjectReaction
			;; is five object reaction
			JSR doAiReaction5
			JMP donePositionUpdate
		notFiveObjectReaction:
		CMP #$06
		BNE notSixObjectReaction
			;; is six object reaction
			JSR doAiReaction6
			JMP donePositionUpdate
		notSixObjectReaction:
			;;must be 7
			JSR doAiReaction7
			JMP donePositionUpdate

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

doPossiblyUpdatePosition:

	LDA xHold_lo
	STA Object_x_lo,x
	LDA xHold_hi
	STA Object_x_hi,x
	
	LDA yHold_lo
	STA Object_y_lo,x
	LDA yHold_hi
	STA Object_y_hi,x
	
	;LDA screenEdgeBehavior
	;BEQ skipUpdatingEdgeScreen ;; if it is 00, it is acting like pacman
	
	LDA xHold_screen
	STA Object_screen,x
skipUpdatingEdgeScreen:	
;;;; also do a yHold screen?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Activate Scroll.
	

	; LDA scrollTrigger
	; BNE atLeastOneScrollTrigger
	; JMP doneActivatingScrollTrigger
; atLeastOneScrollTrigger:
	; CPX camObject
	; BEQ notDoneActivatingScrollTrigger
	; JMP doneActivatingScrollTrigger
; notDoneActivatingScrollTrigger:
	; LDA scrollTrigger
	; AND #%00010000
	; BEQ skipRightScroll
	; LDA Object_x_hi,x
	; SEC
	; SBC camX
	; CMP #SCROLL_BORDER_R
	; BCC skipRightScroll
	; LDA scrollTrigger
	; AND #%11110000
	; ORA #%00000001  
	; JMP setScrollSpeed

; skipRightScroll:
	; LDA scrollTrigger
	; AND #%00100000
	; BEQ skipLeftScroll
	; LDA Object_x_hi,x
	; SEC
	; SBC camX
	; CMP #SCROLL_BORDER_L
	; BCS skipLeftScroll
	; LDA scrollTrigger
	; AND #%11110000
	; ORA #%00000010
	; JMP setScrollSpeed
	
; skipLeftScroll:	

	; LDA scrollTrigger
	; AND #%11111100
	; STA scrollTrigger
	; JMP doneActivatingScrollTrigger_h
; setScrollSpeed:
	; STA scrollTrigger
	; LDA Object_h_speed_lo,x
	; STA scrollSpeed_lo
	; LDA Object_h_speed_hi,x
	; STA scrollSpeed_hi
	; JMP doneActivatingScrollTrigger

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
; doneActivatingScrollTrigger_h

	; LDA scrollTrigger
	; AND #%01000000
	; BEQ skipBottomScroll
	
	; ;; Activate Scroll.
	; LDA Object_y_hi,x
	; SEC
	; SBC camY
	; CMP #SCROLL_BORDER_D
	; BCC skipBottomScroll
	; LDA scrollTrigger
	; AND #%11110000
	; ORA #%00000100  
	; JMP setScrollSpeed2

; skipBottomScroll:
	; LDA scrollTrigger
	; AND #%10000000
	; BEQ skipTopScroll
	; LDA Object_y_hi,x
	; SEC
	; SBC camY
	; CMP #SCROLL_BORDER_U
	; BCS skipTopScroll
	; LDA scrollTrigger
	; AND #%11110000
	; ORA #%00001000
	; JMP setScrollSpeed2
	
; skipTopScroll:	

	; LDA scrollTrigger
	; AND #%11110011
	; STA scrollTrigger
	; JMP doneActivatingScrollTrigger
; setScrollSpeed2:
	; STA scrollTrigger
	; LDA Object_v_speed_lo,x
	; STA scrollSpeed_lo
	; LDA Object_v_speed_hi,x
	; STA scrollSpeed_hi
	
; doneActivatingScrollTrigger:
	
	
	JMP donePositionUpdate
	
dontUpdateObjectPosition:
	LDA #$00
	STA Object_x_lo,x
	STA Object_y_lo,x
	STA Object_h_speed_hi,x
	STA Object_h_speed_lo,x
	STA Object_v_speed_hi,x
	STA Object_v_speed_lo,x
	LDA xPrev
	STA Object_x_hi,x
	LDA yPrev
	STA Object_y_hi,x
donePositionUpdate:










