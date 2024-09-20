;bank 0 
	.base $8000
	.include SCR_BANK00
	.pad $c000
	

		;bank 1
	.base $8000
	.include SCR_BANK01
	.pad $c000
	
		;bank 2 
	.base $8000
	.include SCR_BANK02
	.pad $c000
	
	
	;bank 3
	.base $8000
	.include SCR_BANK03
	.pad $c000
	
		;bank 4 
	.base $8000
	.include SCR_BANK04
	.pad $c000
	
		;bank 5
	.base $8000
	.include SCR_BANK05
	.pad $c000
	
		;bank 6
	.base $8000
	.include SCR_BANK06
	.pad $c000

		;bank 7
	.base $8000
	.include SCR_BANK07
	.pad $c000
	

		;bank 8 
	.base $8000
	.include SCR_BANK08
	.pad $c000
	
		;bank 10 (09)
	.base $8000
	.include SCR_BANK09
	.pad $c000
	
	
	;bank 11 (0a)
	.base $8000
	.include SCR_BANK0A
	.pad $c000
	
		;bank 12 (0b)
	.base $8000
	.include SCR_BANK0B
	.pad $c000
	
		;bank 13 (oc)
	.base $8000
	.include SCR_BANK0C
	.pad $c000
	
		;bank 14 (od)
	.base $8000
	.include SCR_BANK0D
	.pad $c000


	;bank 15 (0e)
	.base $8000
	.include SCR_BANK0E
	.pad $c000
	

		;bank 16 (0f)
	.base $8000
	.include SCR_BANK0F
	.pad $c000
	
		;bank 17 (10)
	.base $8000
	.include SCR_BANK10
	.pad $c000
	
	
	;bank 18 (11)
	.base $8000
	.include SCR_BANK11
	.pad $c000
	
		;bank 19  (12)
	.base $8000
	.include SCR_BANK12
	.pad $c000
	
		;bank 20 (13)
	.base $8000
		.include SCR_BANK13
	.pad $c000
	
		;bank 21 (14)
	.base $8000
	.include SCR_BANK14
	.pad $c000

	;bank 22 (15)
	.base $8000
	.include SCR_BANK15
	.pad $c000
	

		;bank 23 (16)
	.base $8000
		.include SCR_BANK16
	.pad $c000
	
		;bank 24 (17)
	.base $8000
		.include SCR_BANK17
	.pad $c000
	
	
	;bank 25 (18)
	.base $8000
		.include SCR_BANK18
	.pad $c000
	
		;bank 26 (19)
	.base $8000
		.include SCR_BANK19
	.pad $c000
	
		;bank 27 (1a)
	.base $8000
		.include SCR_BANK1A
	.pad $c000
	
		;bank 28 (1b)
	.base $8000
	.include SCR_BANK1B
	.pad $c000

		;bank 29  (1c)
	.base $8000
	.include SCR_BANK1C
	.pad $c000
	

		;bank 30 (1d)
	.base $8000
	.include SCR_BANK1D
	.pad $c000
	
		;bank 31 (1e)
	.base $8000
	.include SCR_BANK1E
	.pad $c000
	

	;bank fixed, 1F

	.org $c000 ; because c000 is the last 16kb of memory.  The first 16 starts at 8000, so
				; the swappable banks will go from 8000-bfff
				; everything here will be in the static bank.
				; everything moved into 8000 will be in the swappable 16k bank.