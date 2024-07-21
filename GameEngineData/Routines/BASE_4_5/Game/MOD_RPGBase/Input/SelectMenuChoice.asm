;;; select menu choice.
    LDA gameSubState
    BNE +dontSkipMenu 
        RTS
    +dontSkipMenu
    CMP #$01
    BEQ +inCommandMenu
        JMP +notInCommandMenu
    +inCommandMenu:
          
        ;;; in command menu
        LDA currentCommandChoice
        BEQ +isZero
            JMP +notZero
        +isZero
            ;; is zero in command menu
            ;;; By default, this shows the player "status"
            ;;; we will have a table of constants for status below.
            ;;; This will actually close the box, which the #$02 in the 5th argument denotes.
            DrawBox #COMMAND_BOX_ORIGIN_X, #COMMAND_BOX_ORIGIN_Y, #COMMAND_BOX_WIDTH , #COMMAND_BOX_HEIGHT, #$02, #$00
            ;;; then it loads the status box substate into the substate
            ;;; which will tell the end box scripts to draw another textbox.
            LDA #STATUS_BOX_SUBSTATE
            STA gameSubState
            JMP +skipMenu
        +notZero
        CMP #$01
        BNE +notOne
            ;; is one in command menu
             ;;; This will actually close the box, which the #$02 in the 5th argument denotes.
            DrawBox #COMMAND_BOX_ORIGIN_X, #COMMAND_BOX_ORIGIN_Y, #COMMAND_BOX_WIDTH , #COMMAND_BOX_HEIGHT, #$02, #$00
            ;;; then it loads the status box substate into the substate
            ;;; which will tell the end box scripts to draw another textbox.
            LDA #SPELL_BOX_SUBSTATE
            STA gameSubState
            JMP +skipMenu
        +notOne
        CMP #$02
        BNE +notTwo
         ;; is one in command menu
             ;;; This will actually close the box, which the #$02 in the 5th argument denotes.
            DrawBox #COMMAND_BOX_ORIGIN_X, #COMMAND_BOX_ORIGIN_Y, #COMMAND_BOX_WIDTH , #COMMAND_BOX_HEIGHT, #$02, #$00
            ;;; then it loads the status box substate into the substate
            ;;; which will tell the end box scripts to draw another textbox.
            LDA #ITEM_BOX_SUBSTATE
            STA gameSubState
            JMP +skipMenu
            ;; is two in command menu
        +notTwo
        CMP #$03
        BNE +notThree
            ;;; is three in command menu
            
        +notThree
            JMP +skipMenu
    +notInCommandMenu
+skipMenu
    RTS
    
    
    
