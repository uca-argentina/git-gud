Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Repeat >> activateCardEffectFor: aPlayer in: aGame [
	aGame lastTileActivated key activateEffectforGame: aGame forPlayer: aPlayer
]