SuperRodFishingSlots::
	db PALLET_TOWN, STARYU, 25, TENTACOOL, 25, TENTACRUEL, 30, TENTACRUEL, 30
	db VIRIDIAN_CITY, POLIWAG, 15, POLIWAG, 20, POLIWAG, 25, POLIWAG, 30
	db CERULEAN_CITY, GOLDEEN, 25, GOLDEEN, 30, SEAKING, 30, SEAKING, 40
	db VERMILION_CITY, TENTACOOL, 25, TENTACOOL, 30, KRABBY, 30, HORSEA, 30
	db CELADON_CITY, GOLDEEN, 20, GOLDEEN, 25, GOLDEEN, 30, GRIMER, 25
	db FUCHSIA_CITY, MAGIKARP, 5, MAGIKARP, 10, MAGIKARP, 15, GYARADOS, 20
	db CINNABAR_ISLAND, STARYU, 35, TENTACOOL, 35, STARYU, 30, TENTACRUEL, 35
	db ROUTE_4, GOLDEEN, 30, GOLDEEN, 35, SEAKING, 30, SEAKING, 35
	db ROUTE_6, GOLDEEN, 30, GOLDEEN, 35, SEAKING, 30, SEAKING, 35
	db ROUTE_24, GOLDEEN, 35, SEAKING, 30, SEAKING, 35, SEAKING, 30
	db ROUTE_25, KRABBY, 25, KRABBY, 30, KINGLER, 35, DRATINI, 15
	db ROUTE_10, KRABBY, 25, KRABBY, 30, HORSEA, 30, KINGLER, 35
	db ROUTE_11, TENTACOOL, 25, TENTACOOL, 25, TENTACOOL, 30, HORSEA, 35
	db ROUTE_12, HORSEA, 30, HORSEA, 25, SEADRA, 30, SEADRA, 35
	db ROUTE_13, HORSEA, 25, HORSEA, 30, TENTACRUEL, 30, SEADRA, 30
	db ROUTE_17, TENTACOOL, 25, TENTACOOL, 30, SHELLDER, 30, SHELLDER, 35
	db ROUTE_18, TENTACOOL, 25, SHELLDER, 30, SHELLDER, 35, SHELLDER, 35
	db ROUTE_19, TENTACOOL, 25, STARYU, 30, TENTACOOL, 30, TENTACRUEL, 35
	db ROUTE_20, TENTACOOL, 20, TENTACRUEL, 20, STARYU, 30, TENTACRUEL, 40
	db ROUTE_21, TENTACOOL, 15, STARYU, 20, TENTACOOL, 30, TENTACRUEL, 30
	db ROUTE_22, POLIWAG, 10, POLIWAG, 15, POLIWAG, 20, POLIWHIRL, 25
	db ROUTE_23, POLIWAG, 25, POLIWAG, 30, POLIWHIRL, 30, POLIWHIRL, 40
	db VERMILION_DOCK, TENTACOOL, 30, TENTACRUEL, 30, STARYU, 35, SHELLDER, 30
	db SAFARI_ZONE_CENTER, MAGIKARP, 10, MAGIKARP, 15, DRATINI, 20, DRAGONAIR, 30
	db SAFARI_ZONE_EAST, MAGIKARP, 10, MAGIKARP, 15, GYARADOS, 20, DRATINI, 25
	db SAFARI_ZONE_NORTH, MAGIKARP, 10, MAGIKARP, 15, GYARADOS, 20, DRATINI, 25
	db SAFARI_ZONE_WEST, MAGIKARP, 10, MAGIKARP, 15, GYARADOS, 20, DRATINI, 25
	db SEAFOAM_ISLANDS_B3F, KRABBY, 35, STARYU, 35, KINGLER, 40, VAPOREON, 40
	db SEAFOAM_ISLANDS_B4F, KINGLER, 40, STARYU, 40, OMANYTE, 35, KABUTO, 35
	db CERULEAN_CAVE_1F, SEAKING, 55, POLIWRATH, 55, CLOYSTER, 55, STARMIE, 55
	db CERULEAN_CAVE_B1F, SEAKING, 60, KINGLER, 60, CLOYSTER, 60, STARMIE, 60
	db -1 ; end

CheckMapForFishingMon:
	push hl
	push bc
	ld hl, SuperRodFishingSlots
.loop
	ld a, [hl] ; current map idW
	cp $ff
	jr z, .done
	ld c, a
	inc hl

	ld b, $0
.loop2
	ld a, $4 ; 4 pokemon per map
	cp b
	jr z, .loop
	ld a, [wd11e] ; ID of the mon we're searching for
	; Do old rod and good rod mons manually because there's so little of them
	cp POLIWAG
	jr z, .found
	cp GOLDEEN
	jr z, .found
	cp HORSEA
	jr z, .found
	cp KRABBY
	jr z, .found
	cp [hl]
	jr nz, .notfound
.found
	dec de
	ld a, [de]
	cp c
	inc de
	jr z, .notfound ; already added this to buffer
	ld a, c ; found so add map id to list
	ld [de], a
	inc de
.notfound
	inc hl
	inc hl
	inc b
	jr .loop2
.done
	pop bc
	pop hl
	ret