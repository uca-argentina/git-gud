Class {
	#name : #SpeedUp,
	#superclass : #Tile,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUp >> activateEffectforGame: aGame [
	aGame changePositionOf: aGame currentPlayer by: 4.
]
