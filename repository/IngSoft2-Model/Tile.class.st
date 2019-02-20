Class {
	#name : #Tile,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Tile >> activateEffectforGame: aGame forPlayer: aPlayer [
	self subclassResponsibility
]
