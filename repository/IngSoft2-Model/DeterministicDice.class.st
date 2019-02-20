Class {
	#name : #DeterministicDice,
	#superclass : #Dice,
	#instVars : [
		'futureThrows',
		'nextThrow'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DeterministicDice class >> withFutureThrows: aThrowsArray andSides: aNumberOfSides [
	self assertValidNumberOfSides: aNumberOfSides.
	^ self new initializeWithFutureThrows: aThrowsArray andSides: aNumberOfSides
]

{ #category : #initialization }
DeterministicDice >> initializeWithFutureThrows: aThrowsArray andSides: aNumberOfSides [
	quantityOfSides :=aNumberOfSides.
	futureThrows := aThrowsArray.
	nextThrow := 0
]

{ #category : #actions }
DeterministicDice >> throw [
	futureThrows := futureThrows select: [ :number | number < ( quantityOfSides + 1) & (number > 0) ].
	nextThrow := nextThrow + 1.
	^ futureThrows at: nextThrow
]
