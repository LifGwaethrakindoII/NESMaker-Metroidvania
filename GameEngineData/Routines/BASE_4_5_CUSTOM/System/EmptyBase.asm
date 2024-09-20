;;;; This is what is needed for a completely empty base.
;;=========================
	.include SCR_HEADER		
	.enum $0000
		;;; this variable needed for blank reset routine.
		soft2001	.dsb 1
	.ende
;;=========================
	.include SCR_ASSIGN_BANKS
;;=========================
	.include SCR_RESET
;;=========================
    .include SCR_GAME_LOOP
;;=========================
	.include SCR_NMI
;;=========================
	.include SCR_VECTORS