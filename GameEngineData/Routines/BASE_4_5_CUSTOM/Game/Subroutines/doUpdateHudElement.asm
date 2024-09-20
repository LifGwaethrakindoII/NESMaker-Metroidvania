doUpdateHudElement:
	SwitchBank #$18
		JSR doUpdateHudElement_bank18
	ReturnBank
	; ;;; arg0_hold right now contains WHICH hud element is being update.
	; LDY arg0_hold
	; ;; these values will be pushed to any of the subroutines
	; ;; for updating.
	; LDA HudOffsetX_Table,y
		; STA temp
		; LDA #BOX_0_ORIGIN_X
		; ASL
		; CLC
		; ADC temp
		; STA tempx
		
	; LDA HudOffsetY_Table,y
		; STA temp
		; LDA #BOX_0_ORIGIN_Y
		; ASL
		; CLC
		; ADC temp
		; STA tempy
		
	; ;; now the box position + element offset is loaded into tempx, tempy
	
	; LDA HudAssetType_Table,y
	; CMP #$FF
	; BNE notNone_HudTilesForUpdate
		; ;; this element has no update
		; JMP doneWithUpdatingHudElement
	; notNone_HudTilesForUpdate:
	; LDA HudAssetType_Table,y
	; ;;; now we know the TYPE of element this is
	; BNE notZeroTypeOfElement_forHudUpdate
		; ;; is zero type of element...Var tiles
		; ;; if it is VAR tiles, we need to know the container max number
		; ;; and the value of the variable being called, which is being held in arg1_hold
			; LDA HudMaxValue,y
			; STA tempA 
			; LDA arg1_hold ;; just in case we invoke another macro that needs this ram.
			; STA tempB
			
			; LDA HudBlankImage,y
			; CLC
			; ADC #HUD_OFFSET
			; STA tempC
			; LDA HudFullImage,y
			; CLC
			; ADC #HUD_OFFSET
			; STA tempD
		; JSR doUpdateHudVarTiles
		; JMP doneWithUpdatingHudElement
	; notZeroTypeOfElement_forHudUpdate:
	; CMP #$01
	; BNE notOneTypeOfElement_forHudUpdate
		; ;; is one type of element...HUD Asset
		
		; JMP doneWithUpdatingHudElement
	; notOneTypeOfElement_forHudUpdate:
	; CMP #$02
	; BNE notTwoTypeOfElement_forHudUpdate
		; ;; is two type of element... Text
		
		; JMP doneWithUpdatingHudElement
	; notTwoTypeOfElement_forHudUpdate:
		; ;; is, thus, three type of element...number
		; LDA HudMaxValue,y
		; STA tempA 
		; ;;; pointer now holds the ram spot of the variable being called.
		; JSR doUpdateHudNumber
	; doneWithUpdatingHudElement:
	RTS