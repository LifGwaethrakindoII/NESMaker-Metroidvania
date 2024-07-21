
_sfx_noteDead:
;	.db 0, 1
;	.db 0, 1
;	.dw sfx_noteDead_square1
;	.dw 0
;	.dw 0
;	.dw 0
;	.dw 0


sfx_noteDead_square1:
;	.db CAL,<(sfx_noteDead_square1_0),>(sfx_noteDead_square1_0)
;	.db TRM



sfx_noteDead_square1_0:
;	.db STI,09,SLL,24
;;; change number after sti (13) to instrument of choice

;		.db NoteVAR ; note to play
		
	RestOfSFX:
	;.db SLL,6,STI,16,GS3
	;.db RET
	



_sfx_noteLive:
	;.db 0, 1
	;.db 0, 1
	;.dw sfx_noteLive_square1
	;.dw 0
	;.dw 0
	;.dw 0
	;.dw 0

sfx_noteLive_square1:
	;.db CAL,<(sfx_noteLive_square1_0),>(sfx_noteLive_square1_0)
	;.db TRM




	
	
sfx_noteLive_square1_0:
	;.db STI,01,SLL,42,NoteVAR,SLL,6,STI,16,FS3
	;.db RET
;; change number after STI (05) to instrument of choice.


	
