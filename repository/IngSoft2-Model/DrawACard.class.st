Class {
	#name : #DrawACard,
	#superclass : #Tile,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
DrawACard >> activateEffectforGame: aGame forPlayer: aPlayer [
	aGame drawCardForPlayer: aPlayer
]
