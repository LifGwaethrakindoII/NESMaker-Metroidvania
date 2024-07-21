ToggleNametable
	LDA updateNametable
	CMP #$20
	BNE switchToLeftNametable
	;; switch to right nametable
	LDA #$24
	JMP gotNametableToView
switchToLeftNametable:
	LDA #$20
gotNametableToView:
	STA updateNametable
	RTS
	
ToggleAttributeTable
	LDA updateAttributeTable
	CMP #$23
	BNE switchToLeftAtttable
	;; switch to right nametable
	LDA #$27
	JMP gotAttToView
switchToLeftAtttable:
	LDA #$23
gotAttToView:
	STA updateAttributeTable
	RTS
	
	
FactorSecondAttributeTable:
	;; based on camera
		LDA camX_hi
		AND #%00000001
		BEQ secondAttTableIs27
			LDA #$23
			JMP gotSecondAttTable
		secondAttTableIs27
			LDA #$27
		gotSecondAttTable
		STA updateAttributeTable
	
	RTS
	
	

ValToBitTable:
	.db #%10000000, #%01000000, #%00100000, #%00010000, #%00001000, #%00000100, #%00000010, #%00000001
	
ValToBitTable_inverse:
	.db #%00000001, #%00000010, #%000000100, #%00001000, #%00010000, #%00100000, #%01000000, #%10000000
	
	
DirectionTable:
	.db #DOWN, #UP, #LEFT, #RIGHT, #DOWNRIGHT, #UPRIGHT, #UPLEFT, #DOWNLEFT
	
FacingTable
	.db #FACE_DOWN, #FACE_UP, #FACE_LEFT, #FACE_RIGHT, #FACE_DOWNRIGHT, #FACE_UPRIGHT, #FACE_UPLEFT, #FACE_DOWNLEFT
	
DirectionTableOrdered:
	.db #DOWN, #DOWNRIGHT, #RIGHT, #UPRIGHT, #UP, #UPLEFT, #LEFT, #DOWNLEFT
FacingTableOrdered:
	.db #FACE_DOWN, #FACE_DOWNRIGHT, #FACE_RIGHT, #FACE_UPRIGHT, #FACE_UP, #FACE_UPLEFT, #FACE_LEFT, #FACE_DOWNLEFT
	
	
	
.include GameData\HUD_DEFINES.dat ;; because of tables created, this is a better place for this than constants.

HudAssetType_Table:
	.db #BOX_0_ASSET_0_TYPE, #BOX_0_ASSET_1_TYPE, #BOX_0_ASSET_2_TYPE, #BOX_0_ASSET_3_TYPE
	.db #BOX_0_ASSET_4_TYPE, #BOX_0_ASSET_5_TYPE, #BOX_0_ASSET_6_TYPE, #BOX_0_ASSET_7_TYPE
	
HudOffsetX_Table:
	.db #BOX_0_ASSET_0_X, #BOX_0_ASSET_1_X, #BOX_0_ASSET_2_X, #BOX_0_ASSET_3_X
	.db #BOX_0_ASSET_4_X, #BOX_0_ASSET_5_X, #BOX_0_ASSET_6_X, #BOX_0_ASSET_7_X
	
HudOffsetY_Table:
	.db #BOX_0_ASSET_0_Y, #BOX_0_ASSET_1_Y, #BOX_0_ASSET_2_Y, #BOX_0_ASSET_3_Y
	.db #BOX_0_ASSET_4_Y, #BOX_0_ASSET_5_Y, #BOX_0_ASSET_6_Y, #BOX_0_ASSET_7_Y
	

HudMaxValue:
	.db #BOX_0_ASSET_0_MAX_VALUE, #BOX_0_ASSET_1_MAX_VALUE, #BOX_0_ASSET_2_MAX_VALUE, #BOX_0_ASSET_3_MAX_VALUE
	.db #BOX_0_ASSET_4_MAX_VALUE, #BOX_0_ASSET_5_MAX_VALUE, #BOX_0_ASSET_6_MAX_VALUE, #BOX_0_ASSET_7_MAX_VALUE
	
HudFullImage: ;; really, only used for var tiles, but we can waste 8 bytes to save on more lost to complex rom data
	.db #BOX_0_ASSET_0_IMAGE, #BOX_0_ASSET_1_IMAGE, #BOX_0_ASSET_2_IMAGE, #BOX_0_ASSET_3_IMAGE
	.db #BOX_0_ASSET_4_IMAGE, #BOX_0_ASSET_5_IMAGE, #BOX_0_ASSET_6_IMAGE, #BOX_0_ASSET_7_IMAGE
	
HudBlankImage: ;;;; really, only used for var tiles, but we can waste 8 bytes to save on more lost to complex rom data
	.db #BOX_0_ASSET_0_BLANK, #BOX_0_ASSET_1_BLANK, #BOX_0_ASSET_2_BLANK, #BOX_0_ASSET_3_BLANK
	.db #BOX_0_ASSET_4_BLANK, #BOX_0_ASSET_5_BLANK, #BOX_0_ASSET_6_BLANK, #BOX_0_ASSET_7_BLANK


NumberBaseTable:
	.db #$00, #$01, #$02, #$03, #$04, #$05, #$06, #$07, #$08, #$09
	

;; use this defined script for any extraneous tables.	
.include SCR_TABLES
