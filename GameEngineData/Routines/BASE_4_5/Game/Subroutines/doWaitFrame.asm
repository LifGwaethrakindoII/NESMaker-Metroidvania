doWaitFrame:
	inc waiting
	waitLoop:
		lda waiting
		BNE waitLoop
	
	RTS