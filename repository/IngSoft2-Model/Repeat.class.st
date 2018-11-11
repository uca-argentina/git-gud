Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Repeat >> activateCardEffectForPlayer: aPlayer in: aGame [
	((aGame lastTileActivated) key) activateEffectforGame: aGame forPlayer: aPlayer
]
