Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'quantityOfSides',
		'type'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Dice class >> assertValidNumberOfSides: anInteger [
	(anInteger <0)
	ifTrue: [ AssertionFailure signal:'The quantity of sides must be greater than zero' ].
]

{ #category : #initialization }
Dice class >> of: aType withSides: anNumberOfSides [
	self assertValidNumberOfSides: anNumberOfSides.
	^ self new initializeAs: aType OfSides: anNumberOfSides
]

{ #category : #initialization }
Dice >> initializeAs: aType OfSides: aNumberOfSides [
	type := aType.
	quantityOfSides := aNumberOfSides
]

{ #category : #accesing }
Dice >> quantityOfSides [
	^ quantityOfSides
]

{ #category : #actions }
Dice >> throw [
	^type throw: self.
]
