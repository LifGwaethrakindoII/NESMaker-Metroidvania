;;; handle game timer.
	LDA gameTimerTicks
	CLC
	ADC #$01 ;; change this to how fast you want the timer to run.
	STA gameTimerTicks
	LDA gameTimerLo
	ADC #$00
	STA gameTimerLo
	LDA gameTimerHi
	ADC #$00
	STA gameTimerHi
	
	
