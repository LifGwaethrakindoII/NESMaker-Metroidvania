;; do draw state
	;;; the new draw state will blast these off:
	;;; y (offset in pixels), tile ID, attribute, x (offset in pixels).
	;;; since the y offset can never be larger than F0, even if is taking up the whole screen,
	;;; that means we have F0 - FF as opcodes when the y offset is being read.
	;;; FF = THIS ITEM IS FINISHED.
	;;; FE = Draw this off screen (no need to keep a "blank tile" anymore).
	
	;;; the old draw state, the ObjectInfo.dat file puts things in the format
	;;; tile, attribute.  It bases everything on a width / height tile draw.
	
