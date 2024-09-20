	CPX player1_object
	BNE notPlayerForWarpTile
	
	WarpToScreen warpToMap, warpToScreen, #$01
		;; arg0 = warp to map.  0= map1.  1= map2.
		;; arg1 = screen to warp to.
		;; arg2 = screen transition type - most likely use 1 here.
			;; 1 = warp, where it observes the warp in position for the player.
	LDA #$05 
	STA bossHealth ;; resets boss health for the new level.
notPlayerForWarpTile: