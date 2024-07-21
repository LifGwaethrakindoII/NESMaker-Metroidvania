MACRO PlaySong arg0
;; arg0 =song to play

	LDA arg0
	STA songToPlay
	LDA updateSoundByte
	ORA #%00000100
	STA updateSoundByte
	ENDM