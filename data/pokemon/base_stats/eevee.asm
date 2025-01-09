	db DEX_EEVEE ; pokedex id

	db  70,  65,  65,  60,  70
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 92 ; base exp

	INCBIN "gfx/pokemon/front/eevee.pic", 0, 1 ; sprite dimensions
	dw EeveePicFront, EeveePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        IRON_TAIL,    BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  \
	     RAGE,         DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         SWIFT,        SKULL_BASH,   REST,         SUBSTITUTE,   \
		 CUT,          FLY,          SURF,         STRENGTH,     FLASH
	; end

	db 0 ; padding
