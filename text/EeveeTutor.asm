; Modified from my Tradeback Tutor text.
; Thanks to PokeCorpus for making it so I don't have to play LGPE
; https://abcboy101.github.io/poke-corpus/#file=lgpe.sub_event_073
; Like all LGPE text in KEP, it's been adapted for the 17-char limit and certainty in starter choice.
; - Plague von Karma

; This is said on the first encounter.
_EeveeTutorPreamble::
	text "Your EEVEE looks"
	line "very promising!"
	
	para "I'm pretty sure"
	line "it can learn a"
	cont "marvelous move"
	cont "I've developed!"
	done

; Otherwise
_EeveeTutorGreetingText::
	text "Hey, you!"
	done

_EeveeTutorWantLearnMove::
	text "Do you want me"
	line "to teach a"
	cont "marvelous move"
	cont "to your EEVEE?"
	done

_EeveeTutorSaidYesText::
	text "Which #MON"
	line "should I tutor?"
	prompt
	
;_EeveeTutorNotEnoughMoneyText::
;	text "Hey, I don't"
;	line "do this for"
;	cont "free, you know!"
;	done
	
_EeveeTutorWhichMoveText::
	text "Which move should"
	line "it learn?"
	done
	
_EeveeTutorByeText::
	text "Build a marvelo-"
	line "us relationship"
	cont "with EEVEE, ok?"
	done
	
_EeveeTutorNoMovesText::
	text "That's no EEVEE!"
	done

; We don't want the player to get Buzzy Buzz right before Misty, so we're progressgating it.
; This is distinctly different from LGPE.
_EeveeTutorNotReady::
	text "Hmm, your EEVEE"
	line "has potential."
	
	para "Beat MISTY, and"
	line "I'll teach it"
	cont "something cool!"
	done
