Class {
	#name : #GameState,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
GameState >> cardIsPlayed [
	self subclassResponsibility 
]

{ #category : #testing }
GameState >> hasEnded [
self subclassResponsibility 
]

{ #category : #actions }
GameState >> turnOf: aPlayer in: aGame [
self subclassResponsibility 
]

{ #category : #actions }
GameState >> wonBy: aPlayer in: aGame [
self subclassResponsibility 
]
