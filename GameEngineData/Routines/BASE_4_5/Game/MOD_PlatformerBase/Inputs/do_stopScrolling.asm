;;; this will stop the camera moving.
;;; great for release events, especially for one way scrolling.

LDA scrollByte
AND #%00001111
STA scrollByte
RTS