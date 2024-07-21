;;;; 
    TXA
    STA temp ;; assumes the object we want to move is in x.

        StartMoving temp, #RIGHT
     ;   TXA
      ;  STA temp ;; assumes the object we want to move is in x.
     ;   ChangeFacingDirection temp, #FACE_RIGHT
        
    RTS