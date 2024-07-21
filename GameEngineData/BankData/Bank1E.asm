
;;Bank1E:
NT_StartScreen:
	.incbin "ScreenData2\Nametables\NT_StartScreen.nam"
NT_Register:
	.incbin "ScreenData2\Nametables\NT_RegisterScreen.nam"
NT_SongBook:
	.incbin "ScreenData2\Nametables\NT_SongBook.nam"
NT_Death:
	.incbin "ScreenData2\Nametables\NT_Death.nam"
NT_Menu:
	.incbin "ScreenData2\Nametables\NT_Menu.nam"
NT_NPC:
	.incbin "ScreenData2\Nametables\NT_NPC.nam"
NT_Shop:
	.incbin "ScreenData2\Nametables\NT_Shop.nam"

NT_Story:
	.incbin "ScreenData2\Nametables\NT_Story.nam"
	
;NT_MainGame:
;	.incbin "ScreenData\Nametables\NT_MainGame.nam"
NT_Win:
	.incbin "ScreenData2\Nametables\NT_Win.nam"
	
NT_Hud
	.incbin "ScreenData2\Nametables\NT_Hud.nam"
	
CtS:
	.include "ScreenData2\CollisionTables\CT_Start.txt"
	
CtMenu:
	.include "ScreenData2\CollisionTables\CT_Menu.txt"
CtNPC:
	.include "ScreenData2\CollisionTables\CT_NPC.txt"
	
julianSSChr:
	.incbin "Graphics\Sprites\CHR_julianSS.chr"