Class {
	#name : #DeterministicDice,
	#superclass : #Object,
	#instVars : [
		'futureThrows',
		'nextThrow',
		'quantityOfSides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DeterministicDice class >> withFutureThrows: aThrowsArray [
^self new initializeWithFutureThrows: aThrowsArray.
	
]

{ #category : #initialization }
DeterministicDice >> initializeWithFutureThrows: aThrowsArray [
futureThrows :=aThrowsArray.
nextThrow:=0.

]

{ #category : #actions }
DeterministicDice >> throw: aDice [
	futureThrows := futureThrows select: [ :number | number < (aDice quantityOfSides + 1) & (number > 0) ].	
	nextThrow := nextThrow + 1.
	^ futureThrows at: nextThrow
]
