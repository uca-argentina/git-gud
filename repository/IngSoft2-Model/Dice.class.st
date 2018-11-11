Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'quantityOfSides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Dice class >> assertValidNumberOfSides: anInteger [
	(anInteger <0)
	ifTrue: [ AssertionFailure signal:'The quantity of sides must be greater than zero' ].
]

{ #category : #accesing }
Dice >> quantityOfSides [
	^ quantityOfSides
]

{ #category : #actions }
Dice >> throw [
	self subclassResponsibility
]
