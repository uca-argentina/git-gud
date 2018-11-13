Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Repeat >> activateCardEffectFor: aPlayer in: aGame [
	aGame assertPlayerExists: aPlayer.
	aGame lastTileActivated key activateEffectforGame: aGame forPlayer: aPlayer
]
