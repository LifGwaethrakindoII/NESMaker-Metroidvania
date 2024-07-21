doEraseBox:
	SwitchBank #$18
		JSR doEraseBox_bank18
	ReturnBank
		
	
	
	RTS