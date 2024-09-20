
	DestroyObject
	AddValue #$06, varMoney, #$01, #$00 
		;arg0 = how many places this value has.
		;arg1 = home variable
		;arg2 = amount to add
		;arg3 = what place value is receiving the addition?
	UpdateHudElement #$01
