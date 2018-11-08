Class {
	#name : #WormHole,
	#superclass : #Tile,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> activateEffectforGame: aGame [
	aGame changePositionOf: (aGame currentPlayer) by: 4 negated
]
