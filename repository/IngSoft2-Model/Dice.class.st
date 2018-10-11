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
Dice class >> withType: aType withSides: anNumberOfSides [
	self assertValidNumberOfSides: anNumberOfSides.
	^ self new initializeWithType: aType WithSides: anNumberOfSides
]

{ #category : #initialization }
Dice >> initializeWithType: aType WithSides: aNumberOfSides [
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
