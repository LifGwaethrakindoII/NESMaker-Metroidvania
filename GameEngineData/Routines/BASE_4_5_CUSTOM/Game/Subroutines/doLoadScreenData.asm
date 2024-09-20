doLoadScreenData:

;	JSR doClearAllMonsters
		
	LDA #$00
	STA spriteRamPointer
	JSR doCleanUpSpriteRam



	SwitchBank arg0_hold
	
	;;;;;;;;;;;;;;;;;;;;;
	;;; By default, screen data begins
	;;; 120 (dec) beyond the collision table label,
	;;; which is currently stored to collisionPointer.
	LDY #120
	; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;=======================================
;SET SCREEN TYPE
	;#120
	LDA (collisionPointer),y
	STA screenType
;=======================================
	INY 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; #121 Legacied - was GraphicsBank - now screen bank is handled via logic.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INY
;========================================
;SET SCREEN PALETTE
	;#122
	LDA (collisionPointer),y ;; this is the palette data
	STA newPal
;=======================================
	INY
;=======================================
;; #123 Legacied - was MaineTileID / ScreenTileID, now handled in bytes below
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INY
;=======================================
;; #124 - Screen Byte 00
	LDA (collisionPointer),y
	STA ScreenFlags00
		;;; ScreenByte00 hold the screen flags.
;=======================================
	INY
;=======================================
;; #125 - ScreenByte01 stuff.
	;first, load screenSpeed
	LDA (collisionPointer),y
	STA ScreenByte01
		AND #%00000011
		STA screenSpeed
	; ;;;;;;;;;;;;;;;;;;;;;;
	; ;;; DO OTHER SCREEN BYTE 1 THINGS HERE!
;=========================================
	INY
;=========================================

;; #126 - Load paths, through a loop to figure out path choices
	LDA (collisionPointer),y
	STA temp
	
	TYA
	PHA
	
	LDY #$00
	LDX #$00
loadPathTilesLoop:
	LDA temp
	AND ValToBitTable,y
	BEQ notFirstPath
	TYA 
	STA pathTile00,x
	INX 
	CPX #$04
	BEQ doneGettingPaths
	INY
	JMP loadPathTilesLoop
notFirstPath:
	INY
	
	JMP loadPathTilesLoop
doneGettingPaths:	
	LDY tempy

	PLA
	TAY
;========================================
	INY
;========================================
;; 127 - Warp out screen
	LDA (collisionPointer),y
	STA warpToScreen
;=======================================	
	INY
;=======================================
;; 128 - Warp In Position
;; This might need to be skipped under certain warp conditions
;; and should only be observed if the transition is of warp type.
	LDA screenTransitionType
	BEQ skipSettingWarpInXY
	CMP #$01
	BEQ setToStartValue
	CMP #$02
	BEQ setToContinueValue
		;;; other cases go here
setToContinueValue
	LDA continueX
	STA newX
	LDA continueY
	STA newY
	JMP skipSettingWarpInXY
setToStartValue:

	LDA (collisionPointer),y
	AND #%11110000
	STA newY
	
	LDA (collisionPointer),y
	AND #%00001111
	ASL
	ASL
	ASL 
	ASL
	STA newX
	
	
skipSettingWarpInXY:
	LDA #$00
	STA screenTransitionType ;; reset screen transition type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;==========================================
	INY
;==========================================
;; 129 - Legacied - used to be screen type and song number.
		;; Also, may have handled banks for monsters based on state.
;==========================================
	INY 
;;=========================================
;; 130 - needed bits	

	LDA (collisionPointer),y
	STA screenLoadTemps ;; this is whether screen should load 8x8 or 16x16.
;	LDA (collisionPointer),y
	AND #%00000001 ;; is this overworld or underworld map? 
	STA warpToMap
	
	LDA screenLoadTemps
	AND #%01110000
	LSR
	LSR
	LSR
	LSR
	AND #%00000111
	STA gameState
;;;;;========================================================
;;;;;========================================================

	; ;; THIS is where we jump to load state specific data.
	; ;***********************
	;JSR GetScreenTriggerInfo	
	; ;***********************
; ;=====================================================	
;============================================
;; 131 

	LDY #182
	LDA (collisionPointer),y
	STA ScreenFlags01
	
	
	
	LDY #196
	LDA (collisionPointer),y

	 STA tileLayout
	 INY
	 LDA (collisionPointer),y
	STA backgroundTilesToLoad
	INY 
	LDA (collisionPointer),y
	STA backgroundTilesToLoad+1
	INY
	LDA (collisionPointer),y
	STA backgroundTilesToLoad+2
	INY
	LDA (collisionPointer),y
	STA backgroundTilesToLoad+3
	INY
	LDA (collisionPointer),y
	STA backgroundTilesToLoad+4
	INY
	LDA (collisionPointer),y
	STA backgroundTilesToLoad+5
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; Handle state based data.
	TXA
	PHA
	JSR GetScreenTriggerInfo
	
		
	
	PLA
	TAX
	

;;;;;;;;;;;;;;;; THERE WILL BE BYTES
;;;;;;;;;;;;;;;; That will contian this information on a screen by screen basis.
;;;;;;;;;;;;;;;; 00 = pacman
;;;;;;;;;;;;;;;; 01 = zelda screen
;;;;;;;;;;;;;;;; 02 = scroll (which updates the Object_screen,x
;;;;;;;;;;;;;;;; 03 = acts as a solid edge.

;;;;;;;;;;;;;;;; Right now, this is being hard coded.
	LDA #%00000000
	STA screenEdgeBehavior

	ReturnBank
	
getTextForScreen:
	SwitchBank #$16
	
		LDA stringGroupPointer ;; this is the group of the string. 
		ASL
		ASL
		TAY
		LDA AllTextGroups,y
		STA screenText
		INY
		LDA AllTextGroups,y
		STA screenText+1
		INY
		LDA AllTextGroups,y
		STA screenText+2
		INY
		LDA AllTextGroups,y
		STA screenText+3
	
	ReturnBank	
	RTS



	
	RTS
	



	
	
	
GetScreenTriggerInfo:
		JSR doClearAllMonsters
 ;;;;; MONSTERS
	;;; constants for banks
	
			
		GetTrigger
		
		;; result of screenType trigger stored in temp3 and also in accum
		;; x and y restored.
		BEQ thisScreenIsNotTriggered
			;; this screen IS triggered
			LDA gameHandler
			AND #%00000001 ;; one = night
			BEQ isTriggeredDay
				;; triggered and night
				LDA #$03
				STA screenState
				TAX
				LDY #152
				LDA (collisionPointer),y
				LSR
				LSR
				LSR
				LSR 
			;	LDA #$03
				STA monsterTableOffset
				JMP triggeredStateInfoIsLoaded
			isTriggeredDay
		
				;; triggered and day
				LDA #$02
				STA screenState
				TAX
				LDY #153
				LDA (collisionPointer),y
				AND #%00001111
			;	LDA #$02
				STA monsterTableOffset
			
			JMP triggeredStateInfoIsLoaded
		;;=================================
		thisScreenIsNotTriggered
			JMP isNormalDay
			LDA gameHandler
			AND #%00000001 ;; one = night
			BEQ isNormalDay
				
				;; normal and night
				LDA #$01
				STA screenState
				TAX
				LDY #152
				LDA (collisionPointer),y
				LSR
				LSR
				LSR
				LSR
			;	LDA #$01
				STA monsterTableOffset
				JMP triggeredStateInfoIsLoaded
			isNormalDay:
			
				;; normal and day
				LDA #$00
				STA screenState
				TAX
				;;;;;;;;;;;
				;Load correspnding monster tileset.
				LDY #152
				LDA (collisionPointer),y
				AND #%00001111
			;	LDA #$00
				STA monsterTableOffset
		triggeredStateInfoIsLoaded:
	
		;;=================================
		;Now, here, load all of the state specific stuff.
		;This will use X as an offset for small tables in ZeroOutAssets file.
		; We'll have to use the stack for any part of these routines that might need X.
		; ;;;;; considerations for the states.
			; ;1: Get Object Graphics Bank 	
			; ;2: String Data
			; ;3: Monster Spawn positions
			; ;4: Monster group (this is more complicated than a single digit)
			; ;5: Object palettes (also more complicated than a single digit)
			; ;6: Object tiles to load.
			; ;7: Object IDs
			; ;8: Song to play
;;=============================================================
;;=============================================================	
		LDA StringDataChoice,x
		TAY ;; now y holds the byte offset value for the text string group.
		LDA (collisionPointer),y
		STA stringGroupPointer
		
		
			TXA
			PHA
		;	LDX monsterTableOffset
		;;; Handle monster 1
			
		JSR LoadMonster_1
		; LDY Mon1SpawnLocation,x
		; LDA (collisionPointer),y
		; STA temp
		; AND #%11110000
		; CMP #%11110000
		; BNE loadMon1toPosition
			; LDA temp
			; AND #%00001111
			; CMP #%00000011
			; BEQ skipLoadingMonster1
			; ;;; Random / Edge cases here
			
		; loadMon1toPosition:
			; ;;;;;;; Load monster 1.
			; LDY Monster1ID,x
			; LDA (collisionPointer),y
			; STA mon1_type
			; LDY Mon1SpawnLocation,x
			; LDA (collisionPointer),y
				; ASL
				; ASL
				; ASL
				; ASL
				; STA tempB ;; x value in tempB
			; LDY Mon1SpawnLocation,x
			; LDA (collisionPointer),y
				; AND #%11110000
				; STA tempC ;; y value in tempC
				; TXA
				; PHA
			; CreateObject tempB, tempC, mon1_type, #$00
			
				; PLA
				; TAX
	
		
		LDY Mon2SpawnLocation,x
		LDA (collisionPointer),y
		STA temp
		AND #%11110000
		CMP #%11110000
		BNE loadMon2toPosition
			LDA temp
			AND #%00001111
			CMP #%00000011
			BEQ skipLoadingMonster2
			;;; Random / Edge cases here
		loadMon2toPosition	
			;;;;;;;; Load monster 1.
			LDY Monster2ID,x
			LDA (collisionPointer),y
			STA mon2_type ;; type of monster loaded into tempA
			LDY Mon2SpawnLocation,x
			LDA (collisionPointer),y
				ASL
				ASL
				ASL
				ASL
				STA tempB ;; x value in tempB
			LDY Mon2SpawnLocation,x
			LDA (collisionPointer),y
				AND #%11110000
				STA tempC ;; y value in tempC
				TXA
				PHA
			CreateObject tempB, tempC, mon2_type, #$00
				LDA #$01
				STA Object_id,x
				PLA
				TAX
		skipLoadingMonster2:
	;;; Handle monster 3

		LDY Mon3SpawnLocation,x
		LDA (collisionPointer),y
		STA temp
		AND #%11110000
		CMP #%11110000
		BNE loadMon3toPosition
			LDA temp
			AND #%00001111
			CMP #%00000011
			BEQ skipLoadingMonster3
			;;; Random / Edge cases here
		loadMon3toPosition	
			LDY Monster3ID,x
			LDA (collisionPointer),y
			STA mon3_type ;; type of monster loaded into tempA
			LDY Mon3SpawnLocation,x
			LDA (collisionPointer),y
				ASL
				ASL
				ASL
				ASL
				STA tempB ;; x value in tempB
			LDY Mon3SpawnLocation,x
			LDA (collisionPointer),y
				AND #%11110000
				STA tempC ;; y value in tempC
				TXA
				PHA
			CreateObject tempB, tempC, mon3_type, #$00
			LDA #$02
			STA Object_id,x
				PLA
				TAX
		skipLoadingMonster3:	
		
	;;; Handle monster 4

		LDY Mon4SpawnLocation,x
		LDA (collisionPointer),y
		STA temp
		AND #%11110000
		CMP #%11110000
		BNE loadMon4toPosition
			LDA temp
			AND #%00001111
			CMP #%00000011
			BEQ skipLoadingMonster4
			;;; Random / Edge cases here
		loadMon4toPosition	
			;;;;;;;; Load monster 1.
			LDY Monster4ID,x
			LDA (collisionPointer),y
			STA mon4_type ;; type of monster loaded into tempA
			LDY Mon4SpawnLocation,x
			LDA (collisionPointer),y
				ASL
				ASL
				ASL
				ASL
				STA tempB ;; x value in tempB
			LDY Mon4SpawnLocation,x
			LDA (collisionPointer),y
				AND #%11110000
				STA tempC ;; y value in tempC
				TXA
				PHA
			CreateObject tempB, tempC, mon4_type, #$00 
			LDA #$03
				STA Object_id,x
				PLA
				TAX
		skipLoadingMonster4:
		PLA 
		TAX
			;PLA
			;TAX
			
	
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;============================================================
;;============================================================
;; Load subpalettes
;; HERE is where you could define game object sub palettes by reading a specific byte
	TXA
	PHA
	LDX screenState

	LDY GoPal1Choice,x
		LDA (collisionPointer),y
	
	STA spriteSubPal3;spriteSubPal1
	;LDX screenState
	LDY GoPal2Choice,x

		LDA (collisionPointer),y
	
	STA spriteSubPal4;spriteSubPal2
	;LDX screenState
	LDY MonPal1Choice,x
		LDA (collisionPointer),y
	
		STA spriteSubPal1
	LDY MonPal2Choice,x
		LDA (collisionPointer),y
		
		STA spriteSubPal2
	PLA
	TAX

	TYA
	PHA
	
	LDY #178
	LDA (collisionPointer),y
	STA temp
	CMP #$FF
	BNE notStopSong
		STA songToPlay
		StopSound
		JMP skipSongToPlay
	notStopSong:
	
	CMP songToPlay
	BEQ skipSongToPlay ;; already playing this song
		PlaySong temp
	skipSongToPlay:
	
	PLA
	TAY
		
	RTS
	
	













	
	