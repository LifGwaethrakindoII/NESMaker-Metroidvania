.include GameData\UserDefinedConstants.asm
.include GameData\HUD_BOX_CONSTANTS.dat
.include GameData\HUD_CONSTANTS.dat


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Directions for physics engine
; to use with movement byte.
; These pertain to actual physics inertia,
; not facing directions.
DOWN = #%00110000
UP = #%00100000
LEFT = #%10000000
RIGHT = #%11000000

DOWNRIGHT = #%11110000
UPRIGHT	= #%11100000
UPLEFT = #%10100000
DOWNLEFT = #%10110000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Facing direction, for animation engine.
;; These determine which facing direction the sprite uses.
FACE_DOWN = #%00000000
FACE_DOWNRIGHT = #%00000001
FACE_RIGHT = #%00000010
FACE_UPRIGHT = #%00000011
FACE_UP = #%00000100
FACE_UPLEFT = #%00000101
FACE_LEFT = #%00000110
FACE_DOWNLEFT = #%00000111



TEXT_FREE = #$01
TEXT_NPC = #$04