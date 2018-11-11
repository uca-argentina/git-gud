Class {
	#name : #DeterministicCardGenerator,
	#superclass : #CardGenerator,
	#instVars : [
		'futureCards',
		'currentDeckPosition'
	],
	#classInstVars : [
		'futureCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DeterministicCardGenerator class >> withFutureCards: aCardsArray [
	^self new initializeWithFutureCards: aCardsArray.
	
]

{ #category : #actions }
DeterministicCardGenerator >> generateCard [
	currentDeckPosition := currentDeckPosition + 1.
	(currentDeckPosition= futureCards size)
	ifTrue: [currentDeckPosition:=1].
	^ futureCards at: currentDeckPosition
]

{ #category : #initialization }
DeterministicCardGenerator >> initializeWithFutureCards: aCardsArray [
	futureCards := aCardsArray.
	currentDeckPosition := 0.
]
