;;; This script can be used as a start game input script.
;;; It will take you to the first screen and set up new continue points based on
;;; that screen's info.

LDA screenUpdateByte
ORA #%00000100
STA screenUpdateByte

	LDA warpToMap

	STA warpMap
	
	LDA warpToScreen
	STA currentNametable
	
	LDX player1_object
	STA Object_screen,x
	
	LDA #$01
	STA screenTransitionType ;; is of warp type

	
	LDA gameHandler
	ORA #%10000000
	STA gameHandler ;; this will set the next game loop to update the screen.
	RTS