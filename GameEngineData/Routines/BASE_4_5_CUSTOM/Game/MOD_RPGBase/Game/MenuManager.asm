;;;;;;;;;;;;;;;;;;;;; In this script, we will manage the size and contents of our various menues for a game.
;; Different games will have dramatically different needs, so this is meant to demonstrate one method, and how
;; it works with various scripts, gameSubStates, constants, and variables, in order to create the effect
;; of menu and sub menu systems.

;; Every menu is effectively a textbox with contents, and generally has some type of picker.
;; Textboxes have x and y, width and height, and contents.
;; Generally, textboxes should line up on EVEN numbers to make use of where the attributes (color data) fall.

;; So what I'll do is introduce a menu with explanation, and submenus.  

;;;;;;;;;;;;;;;;;;;;;;;;;;;=================================================
;;;;1. COMMAND MENU:
;;;; This menu will behave like a command menu that pops up in the overworld of a game like 
;;;; Final Fantasy or Dragon Quest.
	;;;; POSITION CONSTANTS:
		COMMAND_BOX_ORIGIN_X = #$06
		COMMAND_BOX_ORIGIN_Y = #$04
		COMMAND_BOX_WIDTH = #$6
		COMMAND_BOX_HEIGHT = #$06
	;;;; ITEMS WITHIN THE MENU:
		COMMAND_BOX_CHOICES = #$04
	;;;; VALUE OF SELECTOR SPRITE FROM SPRITE SHEET:
		COMMAND_BOX_CURSOR = #$00 
	;;;; VALUE OF COMMANE BOX SUBSTATE: 
		;;; this determines what will be in gameSubState during command box routines.
		COMMAND_BOX_SUBSTATE = #$01
	
	;;;; COMMAND MENU TEXT
	commandMenuText:
		;;;;;; This command menu has four possible choices, denoted by the above "COMMAND_BOX_CHOICES".
		;;;;;; They are STATUS, SPELL, ITEM, EQUIP.
		;;;;;; At this point, this is just used for display, and the items don't do anything in particular.
    .db #_SPACE, #$FE ;; #$FE skips a line
    ;;;; adding spaces will give padding.
		.db #_SPACE, #_SPACE, #_S, #_T, #_A, #_T, #_U, #_S, #$FE, #$FE ;; #$FE = skip line.  Twice, skip two lines
		.db #_SPACE, #_SPACE, #_S, #_P, #_E, #_L, #_L, #$FE, #$FE
		.db #_SPACE, #_SPACE, #_I, #_T, #_E, #_M, #$FE, #$FE
		.db #_SPACE, #_SPACE, #_E, #_Q, #_I, #_P, #$FF ;; #$FF = finish text.
    
    ;;;; COMMAND MENU CUSOR POSITIONING FOR EACH CHOICE
	commandMenuChoiceX: ;; the x value of the cursor for choice.
		.db #$64, #$64, #$64, #$64
	commandMenuChoiceY: ;; the y value of the cursor for choice.
		.db #$46, #$56, #$66, #$76
		
		
		
	;;;;;;;;;;;;========================	
	;;; A) STATUS MENU
		;;; the menu for this text makes use of drawing the value of variables within the string.
		;;; It draws some standard text, but then using the #$f6 opcode, followed by the high and low address
		;;; of the variable you'd like to draw, draws a variable number value in the middle of the string.
		
		STATUS_BOX_ORIGIN_X = #$02
		STATUS_BOX_ORIGIN_Y = #$04
		STATUS_BOX_WIDTH = #$06
		STATUS_BOX_HEIGHT = #$06
		STATUS_BOX_CHOICES = #$00
		STATUS_BOX_CURSOR = #$00
		STATUS_BOX_SUBSTATE = #$02
		
	statusMenuText:
		.db #_SPACE, #$FE;
		.db #_SPACE, #_S, #_T, #_A, #_T, #_U, #_S, #$FE, #$FE
		.db #_SPACE, #_SPACE, #_H, #_P, #_COLON, #_SPACE, #$F6, <myHP_2, >myHP_2, #$f6, <myHP, >myHP, #$FE
		.db #_SPACE, #_SPACE, #_M, #_P, #_COLON, #_SPACE, #$F6, <myMP_2, >myMP_2, #$f6, <myMP, >myMP, #$FE
		.db #_SPACE, #_SPACE, #_X, #_P, #_COLON, #_SPACE, #$F6, <myExp4, >myExp4, #$f6, <myExp3, >myExp3, #$F6, <myExp2, >myExp2, #$f6, <myExp, >myExp,#$FE
		.db #_SPACE, #_SPACE, #_L, #_V, #_COLON, #_SPACE, #$F6, <myLevel2, >myLevel2, #$f6, <myLevel, >myLevel, #$FE
		.db #_SPACE, #_SPACE, #_G, #_P, #_COLON, #_SPACE, #$F6, <myGold3, >myGold3, #$f6, <myGold2, >myGold2,#$f6, <myGold, >myGold,#$FE
		.db #_SPACE, #_SPACE, #_S, #_T, #_COLON, #_SPACE,#$F6, <myStrength2, >myStrength2, #$f6, <myStrength, >myStrength,#$FE
		.db #_SPACE, #_SPACE, #_D, #_E, #_COLON, #_SPACE,#$F6, <myDefense2, >myDefense2, #$f6, <myDefense, >myDefense,#$FF
		
		
		
		
		
		
	;statusMenuChoiceX:
	;statusMenuChoiceY:
	
	;;; B) SPELL MENU
		;;; The spell menu uses a library system, where it draws variable words in the string
		;;; based on a library of word values.  In this case, the names of spells.
		;;; What's good about this is that those spells can be defined numerically in their variable defines, and if they are
		;;; set to zero (like at the start of the game), it will draw nothing.
		SPELL_BOX_ORIGIN_X = #$02
		SPELL_BOX_ORIGIN_Y = #$04
		SPELL_BOX_WIDTH = #$06
		SPELL_BOX_HEIGHT = #$06
		SPELL_BOX_CHOICES = #$03
		SPELL_BOX_CURSOR = #$00
		SPELL_BOX_SUBSTATE = #$03
		
	spellMenuText:
		.db #_SPACE, #$FE;
		.db #_SPACE, #_S, #_P, #_E, #_L, #_L, #_S, #$FE, #$FE
			;;;; In this case, F8 puts it into reading from a library mode.
			;;;; spell1 and spell2 are user variables.
			;;;; it uses the value of those variables as offsets to read from the library table.
		.db #_SPACE, #$F8, #<spell1,#>spell1, #$FE 
		; .db #_SPACE, #$F8, #<spell2,#>spell2, #$Fe
		; .db #_SPACE, #$F8, #<spell2,#>spell2, #$Fe
		; .db #_SPACE, #$F8, #<spell2,#>spell2, #$Fe
		; .db #_SPACE, #$F8, #<spell2,#>spell2, #$Fe
		; .db #_SPACE, #$F8, #<spell2,#>spell2, #$Fe
		.db #_SPACE, #$F8, #<spell2,#>spell2, #$FF
		
	spellMenuChoiceX: ;; the x value of the cursor for choice.
		.db #$24, #$64, #$64, #$64
	spellMenuChoiceY: ;; the y value of the cursor for choice.
		.db #$56, #$56, #$66, #$76
	
	;;; C) ITEM MENU
		;;; The item menu works identical to the spell menu, using the library mode. Just name your game items in the library as well
		;;; and assign them a value.  You could even make constants and assign the constants that value to make your code easier to read
		;;; and trace through.
		ITEM_BOX_ORIGIN_X = #$02
		ITEM_BOX_ORIGIN_Y = #$04
		ITEM_BOX_WIDTH = #$0C
		ITEM_BOX_HEIGHT = #$0A
		ITEM_BOX_CHOICES = #$6
		ITEM_BOX_CURSOR = #$00
		ITEM_BOX_SUBSTATE = #$04
		
		itemMenuText:
		.db #_SPACE, #$FE;
		.db #_SPACE, #_I, #_T, #_E, #_M, #_S, #$FE, #$FE
			;;;; In this case, F8 puts it into reading from a library mode.
			;;;; spell1 and spell2 are user variables.
			;;;; it uses the value of those variables as offsets to read from the library table.
		.db #_SPACE, #$F8, #<item1,#>item1, #$FE 
		.db #_SPACE, #$F8, #<item2,#>item2, #$Fe
		.db #_SPACE, #$F8, #<item3,#>item3, #$Fe
		.db #_SPACE, #$F8, #<item4,#>item4, #$Fe
		.db #_SPACE, #$F8, #<item5,#>item5, #$Fe
		.db #_SPACE, #$F8, #<item6,#>item6, #$FF
		
	itemMenuChoiceX: ;; the x value of the cursor for choice.
		.db #$24, #$64, #$64, #$64
	itemMenuChoiceY: ;; the y value of the cursor for choice.
		.db #$56, #$56, #$66, #$76
	
	;;; D) EQUP MENU
		
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; SUBSTATE TABLES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; A table value of FF effectively means "N/A".
;0 = normal 
;1 = command menu
;2 = status menu
;3 = spell menu
;4 = item menu
;5 = equip menu.

SubstateTable_Origin_x:
	.db #$FF, #COMMAND_BOX_ORIGIN_X, #STATUS_BOX_ORIGIN_X, #SPELL_BOX_ORIGIN_X, #ITEM_BOX_ORIGIN_X, #$FF
SubstateTable_Origin_y:
	.db #$FF, #COMMAND_BOX_ORIGIN_Y, #STATUS_BOX_ORIGIN_Y, #SPELL_BOX_ORIGIN_Y, #ITEM_BOX_ORIGIN_Y, #$FF
SubstateTable_width:
	.db #$FF, #COMMAND_BOX_WIDTH, #STATUS_BOX_WIDTH, #SPELL_BOX_WIDTH, #ITEM_BOX_WIDTH, #$FF
SubstateTable_height:
	.db #$FF, #COMMAND_BOX_HEIGHT, #STATUS_BOX_HEIGHT, #SPELL_BOX_HEIGHT, #ITEM_BOX_HEIGHT, #$FF
SubstateTable_text_lo:
	.db #$ff, #<commandMenuText, #<statusMenuText, #<spellMenuText, #<itemMenuText
SubstateTable_text_hi:
	.db #$ff, #>commandMenuText, #>statusMenuText, #>spellMenuText, #>itemMenuText
SubstateTable_NextSubState:
	.db #$00, #$00, #$00, #$00, #$00
	
	
	
	
	
	

	
TextLibrary_lo:
	.db #<TL_0, #<TL_1, #<TL_2, #<TL_3, #<TL_4, #<TL_5, #<TL_6, #<TL_7
	.db #<TL_8, #<TL_9, #<TL_10, #<TL_11
	
TextLibrary_hi:
	.db #>TL_0, #>TL_1, #>TL_2, #>TL_3, #>TL_4, #>TL_5, #>TL_6, #>TL_7
	.db #>TL_8, #>TL_9, #>TL_10, #>TL_11
	

;;;; #$F7 must end all of the TL values, since that is what sends it back into normal text read mode.
;;;;;;; OVERWORLD SPELLS


TL_0:
	.db #$F7
TL_1:
	.db #_SPACE,#_H, #_E, #_A, #_L, #$F7
TL_2:
	.db  #_SPACE,#_R, #_E, #_T, #_U, #_R, #_N, #$F7
TL_3:
	.db  #_SPACE,#_S, #_A, #_F, #_E, #$F7
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; ITEM NAMES - note that the items start at position 4.
;;;;; So when I assign items, I'm going to add 4 to their value.
;;;;; This is a convuluted step that I would likely do very differently
;;;;; In a full module, like keep various libraries for different types of text,
;;;;; and not have to use a weird offset like this.  But for this example project,
;;;;; this is a way to do it all from the same library.  Look at the initialization script to
;;;;; see how I add four to init values to correctly apply them.
TL_4:
	.db #$F7
TL_5:
	.db #_SPACE, #_P, #_O, #_T, #_I, #_O, #_N, #$F7
TL_6:
	.db #_SPACE, #_E, #_L, #_I, #_X, #_E, #_R, #$F7
TL_7:
	.db #_SPACE, #_T, #_E, #_N, #_T, #$F7
TL_8:
	.db #_SPACE, #_A, #_N, #_T, #_I, #_D, #_O, #_T, #_E, #$F7
TL_9:
	.db #_SPACE, #_K, #_E, #_Y, #$F7
TL_10:
	.db #_SPACE, #_B, #_A, #_I, #_T, #$F7
TL_11:
	.db #_SPACE, #_B, #_O, #_M, #_B, #$F7
