MACRO StopSound
	LDA #$FF
	STA songToPlay
	LDA updateSoundByte
	ORA #%00000001
	STA updateSoundByte
	ENDM