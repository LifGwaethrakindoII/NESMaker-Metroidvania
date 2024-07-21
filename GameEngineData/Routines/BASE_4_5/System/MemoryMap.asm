
SpriteRam	  		= $0200
CollisionRam  		= $0300
ObjectRam 	  		= $0400 
ScratchRam			= $0500 ;; a whole page for scratch ram as a buffer space.  
userVariableRam 	= $0600 ;; user defined, game specific variable space.  Currently, 256 bytes capable by default.
scrollUpdateRam		= $0700 ;; used for a buffer.


FlashRamPage 		= $0300 ;; because collision data will not be used on saving/loading of data.
							;; this should always be utilized on a non-screen, and reload the screen when saving/loading is finished.
SoundRam 			= $0100


;;;;;;;;; SET UP SOUND RAM
;;;;;;ZERO PAGE VARIABLES
	.enum $0000
		.include GameData/ZP_RAM.asm
		.include GameData/Variables/UserVariables.asm 
	.ende

	
	.enum SoundRam ;; also used by the stack, 
					;; but should never conflict.
		.include ROOT\System\ggsound_ram.asm
	.ende
	
;;;; SET UP COLLISION RAM	
	.enum CollisionRam
		collisionTable .dsb 256
		;; good for single page collision data.
		;; scrolling engines may need to either alot more ram, or use nibbles in ram calculations.
	.ende
	.enum ScratchRam
		collisionTable2 .dsb 240 ;; 
		
	.ende
	
;; SET UP VARIABLE RAM	
	.enum userVariableRam ;; 512 bytes.
		.include GameData/System_RAM.asm
		
		
	.ende
	
	
	.enum ObjectRam ;; 512 bytes
		.include GameData/Object_RAM.asm
	.ende