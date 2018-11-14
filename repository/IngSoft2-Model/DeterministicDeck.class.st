Class {
	#name : #DeterministicDeck,
	#superclass : #Deck,
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
DeterministicDeck class >> withFutureCards: aCardsArray [
	^self new initializeWithFutureCards: aCardsArray.
	
]

{ #category : #actions }
DeterministicDeck >> drawCard [
	currentDeckPosition := currentDeckPosition + 1.
	currentDeckPosition > futureCards size
		ifTrue: [ AssertionFailure signal: 'The deck is out of cards' ].
	^ futureCards at: currentDeckPosition
]

{ #category : #initialization }
DeterministicDeck >> initializeWithFutureCards: aCardsArray [
	futureCards := aCardsArray.
	
	currentDeckPosition := 0
]
