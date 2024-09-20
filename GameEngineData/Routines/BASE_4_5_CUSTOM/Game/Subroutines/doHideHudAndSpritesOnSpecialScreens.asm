;;;;;;;
;;;;;;;
;; UNDER WHAT CONDITION SHOULD WE HIDE SPRITES?
	LDA ScreenFlags00
	AND #%10000000
	BEQ doNotTurnOffSprites

		HideSprites
		JMP doneWithExtraScreenCheckForSprites
	doNotTurnOffSprites:
		ShowSprites
	doneWithExtraScreenCheckForSprites:

	LDA ScreenFlags00
	AND #%01000000
	BEQ doNotTurnOffHud
		HideHud
		JMP doneWithExtraScreenCheckForHud
	doNotTurnOffHud:
		ShowHud
	doneWithExtraScreenCheckForHud:

	doneWithExtraCheck::