Class {
	#name : #DeterministicDice,
	#superclass : #Object,
	#instVars : [
		'QuantityOfSides',
		'futureThrows',
		'nextThrow'
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
	futureThrows := futureThrows select: [ :number | number < (aDice quantityOfSides + 1) & (number > 0) ].	"Me quedo solo con los valores que esten entre 1 y quantity of sides "
	nextThrow := nextThrow + 1.
	^ futureThrows at: nextThrow.
]
