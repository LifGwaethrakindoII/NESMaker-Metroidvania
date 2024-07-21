
	DestroyObject

	CountObjects #%00001000
	BNE +notZeroCount
		;;; if there are no more monsters left, we want to disable
		;;; the edge check for scrolling.
		LDA ScreenFlags00
		AND #%11101111
		STA ScreenFlags00

+notZeroCount: