; Modified from KEP's Eevee Tutor code, which was modified from jojobear and Mateo's Move Relearner Code.
; In LGPE, you don't need any money to teach Eevee any moves, so I'm cutting that part of the script.
; Thanks to PokeCorpus for making it so I don't have to play LGPE when looking for text.
; https://abcboy101.github.io/poke-corpus/#file=lgpe.sub_event_073

EeveeTutorText::
	; Progressgating to post-Misty.
	; Zach didn't want Buzzy Buzz accessible for the Misty fight.
	CheckEvent EVENT_BEAT_MISTY
	jr nz, .goForthMyChild
	ld hl, EeveeTutorNotReady
	call PrintText
	jp .end
	
.goForthMyChild
	; Check if the player has talked to the Tutor before.
	; This code is very janky and probably has a better way of doing things but it worked in KEP and I'm sure it's fine.
	CheckEvent EVENT_TALKED_TO_EEVEE_TUTOR ; So we first check if this flag has been hit.
	jr nz, .flagSet ; Yep? Go next.
	SetEvent EVENT_TALKED_TO_EEVEE_TUTOR ; Now he will now never say this again.
	ld hl, EeveeTutorPreamble ; Otherwise, we're using this. The Eevee Tutor introduces themselves as the descendent of Based God himself.
	jr .letsLearnMoves ; go to print text
.flagSet
	ld hl, EeveeTutorGreetingText
	; fallthrough
.letsLearnMoves ; If you're keeping track, if you've talked to the tutor before, you'll land here instead, where he just says "Hey you!" instead.
	call PrintText
	ld a, [wSimulatedJoypadStatesEnd] ; ensuring that the text doesn't autoskip.
	and a
	call z, WaitForTextScrollButtonPress
	call EnableAutoTextBoxDrawing
	ld hl, EeveeTutorWantLearnMove
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .exit
	xor a
	;charge 1000 money
;	ld [hMoney], a	
;	ld [hMoney + 2], a	
;	ld a, $0A
;	ld [hMoney + 1], a  
;	call HasEnoughMoney
;	jr nc, .enoughMoney
	; not enough money
;	ld hl, EeveeTutorNotEnoughMoneyText
;	call PrintText
;	jp TextScriptEnd
;.enoughMoney
	ld hl, EeveeTutorSaidYesText
	call PrintText
	; Select pokemon from party.
	call SaveScreenTilesToBuffer2
	xor a
	ld [wListScrollOffset], a
	ld [wPartyMenuTypeOrMessageID], a
	ld [wUpdateSpritesEnabled], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	jp c, .exit
	
	ld a, [wcf91] ; Eevee checker
	cp EEVEE
	jr nz, .thatsNoEevee
	
	ld a, [wWhichPokemon]
	ld b, a
	push bc
	ld hl, PrepareEeveeMoveList
	ld b, Bank(PrepareEeveeMoveList)
	call Bankswitch
	ld a, [wMoveBuffer]
	and a
	jr nz, .chooseMove
	pop bc ; error handler
.thatsNoEevee
	ld hl, EeveeTutorNoMovesText
	call PrintText
	jp TextScriptEnd
.chooseMove
	ld hl, EeveeTutorWhichMoveText
	call PrintText
	; Display the list of moves to the player.
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, MOVESLISTMENU
	ld [wListMenuID], a
	ld de, wMoveBuffer
	ld hl, wListPointer
	ld [hl], e
	inc hl
	ld [hl], d
	xor a
	ld [wPrintItemPrices], a ; don't print prices
	call DisplayListMenuID
	pop bc
	jr c, .exit  ; exit if player chose cancel
	push bc
	; Save the selected move id.
	ld a, [wcf91]
	ld [wMoveNum], a
	ld [wd11e],a
	call GetMoveName
	call CopyToStringBuffer ; copy name to wcf4b
	pop bc
	ld a, b
	ld [wWhichPokemon], a
	ld a, [wLetterPrintingDelayFlags]
	push af
	xor a
	ld [wLetterPrintingDelayFlags], a
	predef LearnMove
	pop af
	ld [wLetterPrintingDelayFlags], a
	ld a, b
	and a
	jr z, .exit
	; Charge 1000 money
;	xor a
;	ld [wPriceTemp], a
;	ld [wPriceTemp + 2], a	
;	ld a, $0A
;	ld [wPriceTemp + 1], a	
;	ld hl, wPriceTemp + 2
;	ld de, wPlayerMoney + 2
;	ld c, $3
;	predef SubBCDPredef
	ld hl, EeveeTutorByeText
	call PrintText
	jp TextScriptEnd
.exit
	ld hl, EeveeTutorByeText
	call PrintText
.end ; for progressgater
	jp TextScriptEnd

EeveeTutorPreamble:
	text_far _EeveeTutorPreamble
	text_end

EeveeTutorGreetingText:
	text_far _EeveeTutorGreetingText
	text_end

EeveeTutorWantLearnMove:
	text_far _EeveeTutorWantLearnMove
	text_end

EeveeTutorSaidYesText:
	text_far _EeveeTutorSaidYesText
	text_end

;EeveeTutorNotEnoughMoneyText:
;	text_far _EeveeTutorNotEnoughMoneyText
;	text_end

EeveeTutorWhichMoveText:
	text_far _EeveeTutorWhichMoveText
	text_end

EeveeTutorByeText:
	text_far _EeveeTutorByeText
	text_end

EeveeTutorNoMovesText:
	text_far _EeveeTutorNoMovesText
	text_end

EeveeTutorNotReady:
	text_far _EeveeTutorNotReady
	text_end
