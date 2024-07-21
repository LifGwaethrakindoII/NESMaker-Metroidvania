;Music Bank

doHandleUpdateMusic: ;from the main loop 
	LDA updateSoundByte
	AND #%00000001
	BEQ dontStopMusic
		;; stop music
		jsr sound_stop
		LDA updateSoundByte
		AND #%11111110
		STA updateSoundByte
	dontStopMusic
	LDA updateSoundByte
	AND #%00000010
	BEQ dontPlaySound
		
		;;; play sound
			LDA sfxToPlay
			STA sound_param_byte_0
			;LDA sfxPriority
			LDA #soundeffect_one
			STA sound_param_byte_1
			jsr play_sfx
		LDA updateSoundByte
		AND #%11111101
		STA updateSoundByte
	dontPlaySound:
	LDA updateSoundByte
	AND #%00000100
	BEQ dontPlaySong
		;; play song
		LDA songToPlay
		sta sound_param_byte_0
		jsr play_song
		LDA updateSoundByte
		AND #%11111011
		STA updateSoundByte
	dontPlaySong:
	RTS


doSoundEngineUpdate:
	soundengine_update  
	RTS

	.include ROOT\System\ggsound.asm
IntroSong:
	.include "Sound\AllSongs_WithSFX.asm"
