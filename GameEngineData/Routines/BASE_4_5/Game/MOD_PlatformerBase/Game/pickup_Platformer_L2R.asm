;;; Pickup scripts.
;;; Right now, we need to look at the type of object that is in X.
;;; Then, we have to do pickup behavior accordingly.

;; Here is an example of how to set variable myAmmo to 5 if the pickup type
;; is gameobject 2.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDA Object_type,x
	CMP #$01 ;;What object is your pickup?  00 - 0f
	BNE +notThisPickup
		;;;;;;;;;;;;;;;;;;;;;;;;; What do you want to do to the value?
		;;;;;;;;;;;;;;;;;;;;;;;;; Increase?  Decrease?  Set it to a number?
		;;;;;;;;;;;;;;;;;;;;;;;;; Here, we are setting myAmmo to 5.
		inc myPrizes
		LDA myPrizes
		CMP #10
		BNE +notTenYet
			;; is ten
			;; reset myPrizes
			LDA #$00
			STA myPrizes
			;; increase lives
		
			INC myLives
			LDA myLives
			CMP #$09
			BNE +notMaxLivesAt8
				;;; normalize lives at max of 6
				LDA #$08
				STA myLives
			+notMaxLivesAt8
			JMP +endPickups
		+notTenYet
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;;;;;;;;;;;; Do we need to update the HUD to reflect this?
		;;;;;;;;;;;;;;;;;;;;;;;;; If so, which element is the above variable represented in?
		;UpdateHudElement #$03
		JMP +endPickups
+notThisPickup:


+endPickups

	;;; object will already destroy based on type.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;