					
					LDA scrollByte
						AND #%00100000
						BEQ notVscrolling
						JMP doneHScrollHandle
					notVscrolling
					
					lda camY
					AND #%00001111
					BEQ camYisLinedUpWithBoundary
						;; don't allow vertical movement if we're not x aligned.
						JMP doneHScrollHandle 
					camYisLinedUpWithBoundary
					
					LDA camX
					AND #%00001111
					BEQ linedUpWithHscrollBoundary
						;; not yet lined up with the boundary
						;; so skip looking for input and keep scrolling
						;; to the nearest tile boundary.
						LDA scrollByte
						AND #%00000001
						BNE canDoRightScroll
						JMP canDoLeftScroll
					linedUpWithHscrollBoundary:
					
					;LDA gamepad
					;AND #%10000000
					LDA scrollTrigger
					AND #%0000001
					BEQ dontScrollRight
						;;;;;;;;;;;;;;;;;;;;; here we will use the temp variable to look at the
											; current normalized scroll value.  If it gets beyond
					
						;;;;;;;;;;;;;;;;;;;;; This is the part that insures a column is fully loaded
						;;;;;;;;;;;;;;;;;;;;; before the game tries to load a new column, 
						;;;;;;;;;;;;;;;;;;;;; fixing a problem which manifests when quickly changing directions
						;;;;;;;;;;;;;;;;;;;;; while close to the scroll tile boundary.
						;;;;;;;;;;;;;;;;;;;;; Bit 7 controls whether or not we are in scroll update mode.
						;;;;;;;;;;;;;;;;;;;;; Bit 0 controls horizontal direction we are moving.
						;;;;;;;;;;;;;;;;;;;;; If we are in scroll update mode, but were previously moving left,
						;;;;;;;;;;;;;;;;;;;;; wait to scroll (and/or do the scroll updates) until we are no longer
						;;;;;;;;;;;;;;;;;;;;; updating the scroll tiles.
						
						LDA scrollByte
						AND #%10000000
						BEQ canDoRightScroll
							LDA scrollByte
							AND #%00000001
							BNE canDoRightScroll
							JMP doneHScrollHandle
						canDoRightScroll:
					
						LDA scrollByte
						ORA #%00000001
						STA scrollByte
						;;; scroll right
						LDA camX
						AND #%11110000
						STA temp
						
						LDA camX_lo
						CLC
						ADC scrollSpeed_lo;#SCROLL_SPEED_LO
						STA camX_lo
						LDA camX
						ADC scrollSpeed_hi;#SCROLL_SPEED_HI
						STA camX
						LDA camX_hi
						ADC #$00
						STA camX_hi ;; this keeps track of nametable.
									;; wasted bits though, maybe use to store other info?
						LDA camX
						AND #%11110000
						CMP temp
						BEQ dontUpdateScrollColumn
							;;;;;;;;;;;;;;;;;;;;;;;;;
							;;; update the scroll column.
								LDA scrollByte
								AND #%10000000
								BEQ canScrollRight
									JMP doneScrollRight
								canScrollRight
							
							JSR doLoadScrollColumn
							doneScrollRight:
								JMP doneHScrollHandle
						dontUpdateScrollColumn:
					dontScrollRight:
						LDA scrollTrigger
						AND #%00000010
						;LDA gamepad
						;AND #%01000000
						BEQ dontUpdateScrollColumn2
						;;;;;;;;;;;;;;;;;;;;; here we will use the temp variable to look at the
											; current normalized scroll value.  If it gets beyond
											; 16 we will trigger an update to the seam tiles.
											
						;;;;;;;;;;;;;;;;;;;;; This is the part that insures a column is fully loaded
						;;;;;;;;;;;;;;;;;;;;; before the game tries to load a new column, 
						;;;;;;;;;;;;;;;;;;;;; fixing a problem which manifests when quickly changing directions
						;;;;;;;;;;;;;;;;;;;;; while close to the scroll tile boundary.
						;;;;;;;;;;;;;;;;;;;;; Bit 7 controls whether or not we are in scroll update mode.
						;;;;;;;;;;;;;;;;;;;;; Bit 0 controls horizontal direction we are moving.
						;;;;;;;;;;;;;;;;;;;;; If we are in scroll update mode, but were previously moving left,
						;;;;;;;;;;;;;;;;;;;;; wait to scroll (and/or do the scroll updates) until we are no longer
						;;;;;;;;;;;;;;;;;;;;; updating the scroll tiles.
						
						LDA scrollByte
						AND #%10000000
						BEQ canDoLeftScroll
							LDA scrollByte
							AND #%00000001
							BEQ canDoLeftScroll
							JMP doneHScrollHandle
						canDoLeftScroll:
										
											
							LDA scrollByte
							AND #%11111110
	
						STA scrollByte
						;;; scroll left
						
						LDA camX
						AND #%11110000
						STA temp
						
						LDA camX_lo
						SEC
						SBC scrollSpeed_lo;#SCROLL_SPEED_LO
						STA camX_lo
						LDA camX
						SBC scrollSpeed_hi;#SCROLL_SPEED_HI
						STA camX
						LDA camX_hi
						sbc #$00
						STA camX_hi ;; this keeps track of nametable.
									;; wasted bits though, maybe use to store other info?
					
						LDA camX
						AND #%11110000
						CMP temp
						BEQ dontUpdateScrollColumn2
							;;;;;;;;;;;;;;;;;;;;;;;;;
							;;; update the scroll column.
								LDA scrollByte
								AND #%10000000
								BEQ canScrollLeft
									JMP doneScrollLeft
								canScrollLeft
							JSR doLoadScrollColumn
							
							doneScrollLeft:
						dontUpdateScrollColumn2:
					doneHScrollHandle: