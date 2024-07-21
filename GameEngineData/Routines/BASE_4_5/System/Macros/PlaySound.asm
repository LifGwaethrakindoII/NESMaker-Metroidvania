MACRO PlaySound arg0
;; arg0 = sound effect to play
	LDA arg0
	STA sfxToPlay
	LDA updateSoundByte
	ORA #%00000010
	STA updateSoundByte
	
	ENDM