;;solid tile

LDA ObjectUpdateByte
ORA #%00000001
STA ObjectUpdateByte ;; makes solid
rts