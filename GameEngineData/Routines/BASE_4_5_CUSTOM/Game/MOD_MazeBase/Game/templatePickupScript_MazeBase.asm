;;; Pickup scripts.
;;; Right now, we need to look at the type of object that is in X.
;;; Then, we have to do pickup behavior accordingly.

;; Here is an example of how to set variable myAmmo to 5 if the pickup type
;; is gameobject 2.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pickupLabel:
	LDA Object_type,x
	CMP #$01 ;;What object is your pickup?  00 - 0f
	BNE +notThisPickup
		;;;;;;;;;;;;;;;;;;;;;;;;; What do you want to do to the value?
		;;;;;;;;;;;;;;;;;;;;;;;;; Increase?  Decrease?  Set it to a number?
		;;;;;;;;;;;;;;;;;;;;;;;;; Here, we are setting myAmmo to 5.
		;MACRO AddValue arg0, arg1, arg2, arg3
		;arg0 = how many places this value has.
		;arg1 = home variable
		;arg2 = amount to add
		;arg3 = what place value is receiving the addition?
		
		AddValue #$06, myScore, #$1, #$02
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;;;;;;;;;;;; Do we need to update the HUD to reflect this?
		;;;;;;;;;;;;;;;;;;;;;;;;; If so, which element is the above variable represented in?
		UpdateHudElement #$03
		JMP +endPickups
+notThisPickup:
	
	 
+notThisPickup

+endPickups

	;;; object will already destroy based on type.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;