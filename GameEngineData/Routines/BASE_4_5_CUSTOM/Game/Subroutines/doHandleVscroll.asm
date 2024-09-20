	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

				LDA scrollByte
				AND #%01000000
				BEQ notHscrolling
					JMP doneVscrollHandle
				notHscrolling
				
				lda camX
					AND #%00001111
					BEQ camXisLinedUpWithBoundary
						;; don't allow vertical movement if we're not x aligned.
						JMP doneVscrollHandle 
					camXisLinedUpWithBoundary
				
				 LDA camY
				 AND #%00001111
				 BEQ linedUpWithVscrollBoundary
	
					 LDA scrollByte
					 AND #%00000010
					 BNE canDoDownScroll
					 JMP canDoUpScroll
				linedUpWithVscrollBoundary:

				LDA scrollTrigger
				AND #%00000100
				BNE isPressingDown
					JMP noPressingDown
				isPressingDown:
					;; pressing down.
					LDA scrollByte
					AND #%10000000
					BEQ canDoDownScroll
						LDA scrollByte
						AND #%00000010
						BNE canDoDownScroll
						JMP doneVscrollHandle
					canDoDownScroll:
						 LDA scrollByte
							 ORA #%00000010
							 STA scrollByte
					LDA camY
					BNE notAtZeroForDownScroll
						LDA #$FF
						STA temp ;; will insure that temp compare activates a scroll 
									;; for row 0 as soon as we move down.
						JMP gotTempForDownScroll
					notAtZeroForDownScroll:
						AND #%11111000 ;; maybe we check 8 instead of 16.
						STA temp
					gotTempForDownScroll:
					LDA camY_lo
					CLC
					ADC scrollSpeed_lo;#SCROLL_SPEED_LO
					STA camY_lo
					LDA camY
					ADC scrollSpeed_hi;#SCROLL_SPEED_HI
					CMP #240
					BCS overflowYscroll
						STA camY
						JMP checkForRowUpdate
					overflowYscroll:
						AND #%00001111
						STA camY
						LDA camY_hi
						CLC 
						ADC #$01
						STA camY_hi
						;;;;;;;;;;;;;;;;;;;;;;;;;;;
							;; manage objects' offset, tool
							TXA
							PHA
							LDX #$00
							doOverflowObjectsDownLoop:
								LDA Object_status,x
								AND #%10000000
								BEQ skipDoOverflowDownLoopForThisObject
									LDA Object_y_hi,x
									CLC
									ADC #$10
									STA Object_y_hi,x
								skipDoOverflowDownLoopForThisObject:
									INX
									CPX #TOTAL_MAX_OBJECTS
									BNE doOverflowObjectsDownLoop
							PLA
							TAX
						;;;;;;;;;;;;;;;;;;;;;;;;;;;
					checkForRowUpdate:
					LDA camY
					SEC
					SBC #$04
					AND #%11111000 ;; maybe we check for 8 instead of 16
					CMP temp
					BEQ dontUpdateRowColumnDown
						;; update row column down.
						LDA scrollByte
						AND #%10000000
						BEQ canScrollDown
							JMP doneScrollDown
						canScrollDown:
					
							JSR doLoadScrollRow
						doneScrollDown:
					dontUpdateRowColumnDown:
					JMP doneVscrollHandle
				noPressingDown:
				LDA scrollTrigger
				AND #%00001000
				BEQ notPressingUp
				LDA scrollByte
					AND #%10000000
					BEQ canDoUpScroll
						LDA scrollByte
						AND #%00000010
						BEQ canDoUpScroll
						JMP doneVscrollHandle
					canDoUpScroll:
							LDA scrollByte
								AND #%11111101
								STA scrollByte
					LDA camY_lo
					SEC
					SBC scrollSpeed_lo;#SCROLL_SPEED_LO
					STA camY_lo
					LDA camY
					SBC scrollSpeed_hi;#SCROLL_SPEED_HI
					BCC underflowYscroll
						STA camY
						JMP checkForRowUpdateUp
					underflowYscroll
						
						AND #%00001111
						SBC #32 
						STA camY
						LDA camY_hi
						SEC
						SBC #$01
						STA camY_hi
						
						;;;;;;;;;;;;;;;;;;;;;;;;;;;
							;; manage objects' offset, tool
							TXA
							PHA
							LDX #$00
							doUnderflowObjectsDownLoop:
								LDA Object_status,x
								AND #%10000000
								BEQ skipDoUnderflowDownLoopForThisObject
									LDA Object_y_hi,x
									sec
									sbc #$10
									STA Object_y_hi,x
								skipDoUnderflowDownLoopForThisObject:
									INX
									CPX #TOTAL_MAX_OBJECTS
									BNE doUnderflowObjectsDownLoop
							PLA
							TAX
						;;;;;;;;;;;;;;;;;;;;;;;;;;;
						
					checkForRowUpdateUp:
						LDA camY
					SEC
					SBC #$04
						AND #%11111000
						CMP temp
						BEQ dontUpdateRomColumnUp
							LDA scrollByte
							AND #%10000000
							BEQ canScrollUp
								JMP doneScrollUp
							canScrollUp:
					
								JSR doLoadScrollRow
							doneScrollUp:
							
						dontUpdateRomColumnUp:
						JMP doneVscrollHandle
				notPressingUp:

				doneVscrollHandle: