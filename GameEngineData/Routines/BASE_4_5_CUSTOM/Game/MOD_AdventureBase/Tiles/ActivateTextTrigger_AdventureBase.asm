	LDA npcTrigger
    ORA #%00000001
	STA npcTrigger
	
	LDA screenText
	STA npc_text
	
	RTS