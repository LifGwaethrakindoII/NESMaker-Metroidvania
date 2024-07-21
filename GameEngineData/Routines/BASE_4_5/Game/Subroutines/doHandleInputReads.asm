doHandleInputReads:
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DO GamePadCheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GamePadCheck:
	LDA #$01
	STA $4016
	;STA gamepad2
	LSR
	STA $4016
	
	LDA #$80
	STA gamepad
	STA gamepad2
ReadControllerBytesLoop:
	LDA $4016
	AND #%00000011
	CMP #%00000001
	ROR gamepad
	LDA $4017
	AND #%00000011
	CMP #%00000001
	ROR gamepad2
	BCC ReadControllerBytesLoop
	;RTS
	; LDA gamepad
	; AND #%11000000
	; CMP #%11000000
	; BNE NoFilter_LR
	
	; EOR gamepad
	; STA gamepad
; NoFilter_LR:
	; LDA gamepad
	; AND #%00110000
	; CMP #%00110000
	; BNE NoFilter_UD
	; EOR gamepad
	; STA gamepad
; NoFilter_UD:

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;END GamePadCheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Read input definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	TXA
	PHA
	TYA
	PHA
	LDA currentBank
	STA tempBank
	
	LDA gamepad
	STA gamepad_hold
	LDA buttonStates
	STA buttonStates_hold
	LDA #$00
	STA controllerNumber_hold
	JSR doCheckControllerInputStates
	
	LDA gamepad2
	STA gamepad_hold
	LDA buttonStates2
	STA buttonStates_hold
	LDA #$01
	STA controllerNumber_hold
	JSR doCheckControllerInputStates
	
	LDy tempBank
	JSR doBankswitchY

	PLA
	TAY
	PLA
	TAX	
	
	LDA gamepad
	STA buttonStates
	LDA gamepad2
	STA buttonStates2
	RTS
	
	
	
findObjectOfType:

	LDX #$00
	doFindObjectOfTypeLoop:
		LDA Object_type,x
		CMP tempB
		BEQ xIsNowCorrect
		INX
		CPX #TOTAL_MAX_OBJECTS
		BNE doFindObjectOfTypeLoop
		LDX #$FF
	xIsNowCorrect:
	RTS	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
doCheckControllerInputStates:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; HANDLE HELD INPUTS ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	LDA #HELD_INPUTS
	BNE doHeldInputs
	JMP doneWithInputLoops_Held
doHeldInputs:
	LDA #$00
	STA loopTemp
GetDefinedInputsLoop_Held:
	LDX loopTemp ;; set x temporarily to loopTemp variable for table reads
	;; we need to check to see if this input uses current game state
	;; if not, skip it.
	LDA DefinedScriptGameStates_Held,x
	CMP gameState
	BEQ inputCheckGameStateIsCorrect_Held
	JMP skipThisInput_Held
inputCheckGameStateIsCorrect_Held:
	LDA DefinedTargetController_Held,x
	CMP controllerNumber_hold
	BEQ inputCheckControllerIsCorrect_held
	JMP skipThisInput_Held
inputCheckControllerIsCorrect_held
	
	;;;; now check gamepad variable against the
	;;; DefinedInputs table to see if the current
	;;; gamepad state matches any of the chosen inputs.
	LDA buttonStates_hold
	AND DefinedInputs_Held,x ;; this AND checks button states and
								;; logically only checks about those
								;; states being asked about. If we remove this,
								;; the buttons have to be in the exact input state 
								;; as DefinedInputs_Pressed.  With it in, 
								;; left will still do left things even if b-button
								;; is pressed, for example. 
	CMP DefinedInputs_Held,x
	BNE skipThisInput_Held
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			 ;;; from the ScriptAddress table.
		LDA DefinedTargetObjects_Held,y ;; this is the type of object we're looking for.
		STA tempB
			JSR findObjectOfType
			CPX #$FF
			BEQ skipThisInput_Held
		
	;LDX DefinedTargetObjects_Held,y
	LDA TargetScriptBank,y
	STA temp
	;LDA currentBank
	;STA prevBank
	
	SwitchBank temp
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			;;; from the ScriptAddress table.

	LDA DefinedTargetScripts_Held,y
	TAY
	LDA ScriptAddressLo,y
	STA temp16
	LDA ScriptAddressHi,y
	STA temp16+1
	JSR UseInputTrampoline_Held
	JMP passedInputTrampoline_Held
UseInputTrampoline_Held:
	;;; ADVANCED CONCEPT:
	;;;; since there is no such thing as an indirect JSR
	;;; we have to use an indirect jump.  However, we want this
	;;; to behave as a JSR and jump back to this point in code
	;;; at the end of the eventual routine.
	;;; So we use this trampoline method, where
	;;; Our JSR above sets the *return* point to that point in code.
	;;; Then, at the end of the routine we jump to, when it hits an RTS,
	;;; that return will return to the JSR above, which will immediately
	;;; jump to the passedInputTrampoline below.
	JMP (temp16)
	
passedInputTrampoline_Held:

	ReturnBank
	;;;===========================
	

skipThisInput_Held:
	INC loopTemp
	LDA loopTemp
	CMP #HELD_INPUTS ;;; the total number of scripts to jump through
	BCs doneWithInputLoops_Held
	JMP GetDefinedInputsLoop_Held
doneWithInputLoops_Held:
	

;;;;;;;;;;;;;;;END HELD	
	
	


;;;;;;;;;;;;;;;;;;;;PRESSED	
	;JMP AllButtonStatesChecked
	
	LDA #PRESSED_INPUTS
	BNE doPressedInputs
	JMP doneWithInputLoops_Pressed
doPressedInputs:
	
	LDA #$00
	STA loopTemp
GetDefinedPressedInputsLoop:
	
	LDX loopTemp ;; set x temporarily to loopTemp variable for table reads
	;; we need to check to see if this input uses current game state
	;; if not, skip it.
	LDA DefinedScriptGameStates_Pressed,x
	CMP gameState
	BEQ inputCheckGameStateIsCorrect_Pressed
	JMP skipThisInput_Pressed
inputCheckGameStateIsCorrect_Pressed:
	LDA DefinedTargetController_Pressed,x
	CMP controllerNumber_hold
	BEQ inputCheckControllerIsCorrect_Pressed
	JMP skipThisInput_Pressed
inputCheckControllerIsCorrect_Pressed
	LDA buttonStates_hold
	AND DefinedInputs_Pressed,x
	BNE skipThisInput_Pressed
	
	LDA gamepad_hold
	AND DefinedInputs_Pressed,x
	BEQ skipThisInput_Pressed
	
	


DoInputActionTrampoline:
	
	;LDX tempx
	;;;===========================
	;;;; TRAMPOLINE
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			 ;;; from the ScriptAddress table
		LDA DefinedTargetObjects_Pressed,y ;; this is the type of object we're looking for.
		STA tempB
			JSR findObjectOfType
			CPX #$FF
			BEQ skipThisInput_Pressed
	;LDX DefinedTargetObjects_Pressed,y
	LDA TargetScriptBank,y
	STA temp
	SwitchBank temp
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			;;; from the ScriptAddress table.
	LDA DefinedTargetScripts_Pressed,y
	TAY
	LDA ScriptAddressLo,y
	STA temp16
	LDA ScriptAddressHi,y
	STA temp16+1

	JSR UseInputTrampoline
	JMP passedInputTrampoline
UseInputTrampoline:
	;;; ADVANCED CONCEPT:
	;;;; since there is no such thing as an indirect JSR
	;;; we have to use an indirect jump.  However, we want this
	;;; to behave as a JSR and jump back to this point in code
	;;; at the end of the eventual routine.
	;;; So we use this trampoline method, where
	;;; Our JSR above sets the *return* point to that point in code.
	;;; Then, at the end of the routine we jump to, when it hits an RTS,
	;;; that return will return to the JSR above, which will immediately
	;;; jump to the passedInputTrampoline below.
	JMP (temp16)
	
passedInputTrampoline: 

	ReturnBank
	;;;===========================


skipThisInput_Pressed:
	INC loopTemp
	LDA loopTemp
	CMP #PRESSED_INPUTS ;;; the total number of scripts to jump through
	BCs doneWithInputLoops_Pressed
	JMP GetDefinedPressedInputsLoop
doneWithInputLoops_Pressed:


;;===============RELEASED
	LDA #RELEASED_INPUTS
	BNE doReleasedInputs
	JMP doneWithInputLoops_Released
doReleasedInputs:
	LDA #$00
	STA loopTemp
GetDefinedInputsReleasedLoop:
	LDX loopTemp ;; set x temporarily to loopTemp variable for table reads
	;; we need to check to see if this input uses current game state
	;; if not, skip it.
	LDA DefinedScriptGameStates_Released,x
	CMP gameState
	BEQ inputCheckGameStateIsCorrect_Released
	JMP skipThisInput_Released
inputCheckGameStateIsCorrect_Released:
	LDA DefinedTargetController_Released,x
	CMP controllerNumber_hold
	BEQ inputCheckControllerIsCorrect_released
	JMP skipThisInput_Released
inputCheckControllerIsCorrect_released

	;;;; now check gamepad variable against the
	;;; DefinedInputs table to see if the current
	;;; gamepad state matches any of the chosen inputs.

	
	LDA buttonStates_hold
	AND DefinedInputs_Released,x
	BEQ skipThisInput_Released
	
	LDA gamepad_hold
	AND DefinedInputs_Released,x
	BNE skipThisInput_Released
	
	
	
DoInputActionTrampoline_Released:
	;JMP AllButtonStatesChecked
	;LDX tempx
	;;;===========================
	;;;; TRAMPOLINE
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			 ;;; from the ScriptAddress table.
		LDA DefinedTargetObjects_Released,y ;; this is the type of object we're looking for.
		STA tempB
			JSR findObjectOfType
			CPX #$FF
			BEQ skipThisInput_Released
	;LDX DefinedTargetObjects_Released,y
	;LDA DefinedTargetScripts_Released,y
	;TAY
	LDA TargetScriptBank,y
	STA temp
	SwitchBank temp
	
	LDY loopTemp ;;; THIS NEEDS TO EQUAL THE INDEX OF THE SCRIPT BEING CALLED
			;;; from the ScriptAddress table.
	LDA DefinedTargetScripts_Released,y
	TAY
	LDA ScriptAddressLo,y
	STA temp16
	LDA ScriptAddressHi,y
	STA temp16+1
	JSR UseInputReleasedTrampoline
	JMP passedInputReleasedTrampoline
UseInputReleasedTrampoline:
	;;; ADVANCED CONCEPT:
	;;;; since there is no such thing as an indirect JSR
	;;; we have to use an indirect jump.  However, we want this
	;;; to behave as a JSR and jump back to this point in code
	;;; at the end of the eventual routine.
	;;; So we use this trampoline method, where
	;;; Our JSR above sets the *return* point to that point in code.
	;;; Then, at the end of the routine we jump to, when it hits an RTS,
	;;; that return will return to the JSR above, which will immediately
	;;; jump to the passedInputTrampoline below.
	JMP (temp16)
	
passedInputReleasedTrampoline:

	ReturnBank
	;;;===========================

	
skipThisInput_Released:
	INC loopTemp
	LDA loopTemp
	CMP #RELEASED_INPUTS ;;; the total number of scripts to jump through
	BCs doneWithInputLoops_Released
	JMP GetDefinedInputsReleasedLoop
doneWithInputLoops_Released:


;=======================

AllButtonStatesChecked:

	; LDY #$14
	; JSR bankswitchY
	; JSR ExtraInputControl

	
	RTS