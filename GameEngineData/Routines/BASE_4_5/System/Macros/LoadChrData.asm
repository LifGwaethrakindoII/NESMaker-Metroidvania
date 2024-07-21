MACRO LoadChrData arg0, arg1, arg2, arg3, arg4, arg5, arg6
	;; This loads CHR data to the PPU.  
	;; It is designed for updates when rendering is turned OFF.
	
	;; arg0 is what bank to draw from
	;; arg1 feeds what 'row' the pattern table will load to
	;; arg2 feeds what 'column'.  it must end in zero (be a multiple of 16)
	;; arg3 feeds how many tiles load.
	;; arg4 what table to load from, lo
	;; arg5 what table to load from, hi
	;; arg6 is the index from the table.
	
	LDA arg0
	STA tempBank
	LDA arg1
	STA arg1_hold ;; row
	LDA arg2
	STA arg2_hold ;; column (must end in zero)
	LDA arg3
	STA arg3_hold ;; number of tiles
	LDA arg6
	STA arg6_hold
	
	SwitchBank #$16
	
		LDY arg6

		LDA #<arg4
		STA temp16
		LDA #>arg4
		STA temp16+1
		
		LDA (temp16),y
		STA temp
		
		
		LDA #<arg5
		STA temp16
		LDA #>arg5
		STA temp16+1
		
		LDA (temp16),y
		STA temp1
		
		LDA temp
		STA temp16
		LDA temp1
		STA temp16+1
	
	ReturnBank
	
	
	JSR doLoadChrRam
	ENDM
