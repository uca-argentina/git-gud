Class {
	#name : #Repeat,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Repeat >> activateCardEffectFor: aPlayer in: aGame [
	aGame lastTileActivated key activateEffectforGame: aGame forPlayer: aGame lastTileActivated value
]
