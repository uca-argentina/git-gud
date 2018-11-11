Class {
	#name : #WormHole,
	#superclass : #Tile,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> activateEffectforGame: aGame forPlayer: aPlayer [
	aGame changePositionOf: aPlayer by: 4 negated
]
