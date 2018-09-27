Class {
	#name : #DeterministicDice,
	#superclass : #Object,
	#instVars : [
		'QuantityOfSides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
DeterministicDice class >> assertQuantityOfSidesGreaterThanZero: anInteger [
	(anInteger <0)
	ifTrue: [ AssertionFailure signal:'The quantity of sides must be greater than zero' ].
]

{ #category : #initialization }
DeterministicDice class >> withQuantityOfSides: anInteger [ 

 self assertQuantityOfSidesGreaterThanZero: anInteger.
	^self new initializeWithQuantityOfSides: anInteger.
]

{ #category : #accessing }
DeterministicDice >> QuantityOfSides [
	^QuantityOfSides 
]

{ #category : #initialization }
DeterministicDice >> initializeWithQuantityOfSides: anInteger [ 
	QuantityOfSides:= anInteger.
]

{ #category : #actions }
DeterministicDice >> throw: aDice [
^aDice throwWhenSecuential.
	
]
