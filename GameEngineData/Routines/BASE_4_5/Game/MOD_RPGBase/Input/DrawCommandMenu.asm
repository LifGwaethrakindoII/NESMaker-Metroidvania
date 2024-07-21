;;; Here is a script to draw a menu on button push.
;;; In an RPG, this would be a command menu that you might draw
;;; on an overworld.

;;; Draw a box.  We will need an X origin, a Y origin, a width, and a height.
;;; The best thing to do is to make these fall on the "attribute" lines.  See HUD&BOXES
;;; and turn on 32px grid to see this.  Keeping them even numbers will help.

;; For this module, check the MenuManager script in the script defines for values.



LDA gameSubState
CMP #%00
BNE +notSubState0
    ;;; if we are in "overworld" (main game) state, launch the command box.
    JMP +launchCommandBox
+notSubState0
    LDY gameSubState
    LDA SubstateTable_Origin_x,y
    CMP #$FF
    BNE +thisIsNotANullState
        ;; this state has no boxes associated with the button press.
        RTS
    +thisIsNotANullState
        STA tempA
        LDA SubstateTable_Origin_y,y
        STA tempB
        LDA SubstateTable_width,y
        STA tempC
        LDA SubstateTable_height,y
        STA tempD
        
        ;;; if we are IN command box state when the same button is pressed, it
        ;;; should erase the box
        DrawBox tempA, tempB, tempC, tempD, #TEXT_FREE, #$00
        
        ;;; Now, when this closes, what state should it be in?
        ;;; To return to our main game, it will be zero, but maybe you have a menu opening in a
        ;;; battle substate which is non-zero.  You can tell it what substate it should open in on
        ;;; the menu manager in the SubstateTable_NextSubState table.  Most of the time, this will be zero.
        LDA SubstateTable_NextSubState,y
        STA gameSubState
        RTS


+launchCommandBox
    ;;; change the state to 1, which will be that command box is open.
    LDA #COMMAND_BOX_SUBSTATE
    STA gameSubState
 
    LDA #$00
    STA currentCommandChoice
    
    DrawBox #COMMAND_BOX_ORIGIN_X, #COMMAND_BOX_ORIGIN_Y, #COMMAND_BOX_WIDTH , #COMMAND_BOX_HEIGHT, #TEXT_FREE, commandMenuText
    ;;; x
    ;;; y
    ;;; width
    ;;; height
    ;;; text mode
        ;#TEXT_NPC pulls from the index in the following argument.
        ;#TEXT_FREE allows you to just write a label definition in the following argument
        ; and as long as you're in the right bank, will draw it.
    ;;; string or index.



RTS

    