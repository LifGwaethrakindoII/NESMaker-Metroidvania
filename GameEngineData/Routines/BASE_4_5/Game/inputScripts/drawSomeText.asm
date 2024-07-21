

DrawBox #BOX_1_ORIGIN_X, #BOX_1_ORIGIN_Y, #BOX_1_WIDTH , #BOX_1_HEIGHT, #TEXT_NPC, npc_text

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
