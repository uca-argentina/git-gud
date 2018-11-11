Class {
	#name : #SpeedUp,
	#superclass : #Tile,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUp >> activateEffectforGame: aGame forPlayer: aPlayer [
	aGame changePositionOf: aPlayer by: 4
]
