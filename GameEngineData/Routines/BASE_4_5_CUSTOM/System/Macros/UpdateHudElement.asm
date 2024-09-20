MACRO UpdateHudElement arg0;, arg1
	;;; arg 0, which element to update.
	;;; what variable should we update?
	
	TYA
	PHA
	LDY arg0
	LDA ValToBitTable_inverse,y
	STA hudUpdates
	PLA
	TAY
	
	ENDM