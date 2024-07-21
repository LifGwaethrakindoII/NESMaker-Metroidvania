NMI:
	;first push whatever is in the accumulator to the stack
	
	PHA
	LDA doNMI
	BEQ dontSkipNMI
	JMP skipWholeNMI
dontSkipNMI:

	LDA #$01
	STA doNMI
	TXA
	PHA
	TYA
	PHA
	PHP
	
	LDA temp
	PHA 
	LDA temp1
	PHA 
	LDA temp2
	PHA 
	LDA temp3
	PHA 
	LDA tempx
	PHA 
	LDA tempy
	PHA 
	LDA tempz
	PHA 
	
	LDA tempA
	PHA
	LDA tempB
	PHA
	LDA tempC
	PHA
	LDA tempD
	PHA


	LDA arg0_hold
	PHA
	LDA arg1_hold
	PHA
	LDA arg2_hold
	PHA
	LDA arg3_hold
	PHA
	LDA arg4_hold
	PHA
	LDA arg5_hold
	PHA
	LDA arg6_hold
	PHA
	LDA arg7_hold
	PHA

	
	LDA temp16
	PHA 
	LDA temp16+1
	PHA 
	
	LDA pointer
	PHA
	LDA pointer+1
	PHA
	
	LDA pointer2
	PHA
	LDA pointer2+1
	PHA
	
	LDA pointer3
	PHA
	LDA pointer3+1
	PHA
	
	LDA pointer6
	PHA
	LDA pointer6+1
	PHA
	
	LDA currentBank
	PHA 
	LDA prevBank
	PHA 
	LDA tempBank
	PHA 
	LDA chrRamBank
	PHA 

	
	
	LDA skipNMI
	BEQ dontSkipNMI2
	JMP skipNMIstuff
dontSkipNMI2:


	
	LDA #$00
	STA $2000
	LDA soft2001
	STA $2001
	
	;;;Set OAL DMA
	LDA #$00
	STA $2003
	LDA #$02
	STA $4014
	;; Load the Palette
	
	LDA soft2001
	BNE doScreenUpdates
	JMP skipScreenUpdates
 doScreenUpdates:
	
	 bit $2002
	 LDA updateScreenData
	 AND #%00000001
	 BNE doPaletteUpdates
	 JMP +
 doPaletteUpdates:
	 .include SCR_LOAD_PALETTES
	 JMP skipScreenUpdates
 +
	 LDA updateScreenData
	 AND #%00000010
	 BNE doSpritePaletteUpdates:
	 JMP +
doSpritePaletteUpdates:
	.include SCR_LOAD_SPRITE_PALETTES
	JMP skipScreenUpdates
+
	LDA updateScreenData
	AND #%00000100
	BNE doColumnUpdate
	JMP +
doColumnUpdate:
	.include SCR_UPDATE_SCROLL_COLUMN
	JMP skipScreenUpdates
+

skipScreenUpdates:	
	;; always do hud update, otherwise
	;; it's possible that updates to tiles, attributes, or palettes
	;; will cause a skip in hud update.
	;.include ROOT\DataLoadScripts\LoadHudData.asm
	
			LDA camY_hi
			ASL
			ASL
			ASL
			ASL
			CLC
			ADC camX_hi
			STA camScreen
	;LDA camScreen ;; bit 0, determines which nametable we are looking at.
	
	
	
	AND #%00000001
	ORA #%10010000
	
	STA $2000
	

	LDA camX
	STA $2005	;reset scroll values to zero
	LDA camY
	STA $2005	;reset scroll values to zero
	

skipNMIstuff:		


	
	INC vBlankTimer
	INC randomSeed

	;; music player things


	SwitchBank #$1B ;; music bank
	 JSR doSoundEngineUpdate 
	 ReturnBank

	
	PLA
	STA chrRamBank
	PLA 
	STA tempBank
	PLA 
	STA prevBank
	PLA
	STA currentBank
	
	PLA
	STA pointer6+1
	PLA
	STA pointer6
	PLA
	STA pointer3+1
	PLA
	STA pointer3
	
	PLA
	STA pointer2+1
	PLA
	STA pointer2
	
	PLA
	STA pointer+1
	PLA
	STA pointer
	
	PLA
	STA temp16+1
	PLA
	STA temp16

	PLA
	STA arg7_hold
	PLA
	STA arg6_hold
	PLA
	STA arg5_hold
	PLA
	STA arg4_hold
	PLA
	STA arg3_hold
	PLA
	STA arg2_hold
	PLA
	STA arg1_hold
	PLA
	STA arg0_hold
	
	PLA 
	STA tempD
	PLA
	STA tempC
	PLA
	STA tempB
	PLA 
	STA tempA
	
	PLA 
	STA tempz
	PLA 
	STA tempy
	PLA
	STA tempx
	PLA 
	STA temp3
	PLA 
	STA temp2
	PLA 
	STA temp1
	PLA 
	STA temp
	
	LDA #$00
	STA doNMI
	
	PLP
	PLA
	TAY
	PLA
	TAX
skipWholeNMI:	
	LDA #$00
	STA waiting
	PLA

	
	RTI