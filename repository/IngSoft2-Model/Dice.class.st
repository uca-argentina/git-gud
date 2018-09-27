Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'QuantityOfSides',
		'type',
		'futureThrows',
		'nextThrow'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Dice class >> assertQuantityOfSidesGreaterThanZero: anInteger [
	(anInteger <0)
	ifTrue: [ AssertionFailure signal:'The quantity of sides must be greater than zero' ].
]

{ #category : #initialization }
Dice class >> withType: aType withQuantityOfSides: anInteger [ 

 self assertQuantityOfSidesGreaterThanZero: anInteger.
	^self new initializeWithType: aType WithQuantityOfSides: anInteger.
]

{ #category : #accesing }
Dice >> QuantityOfSides [
	^QuantityOfSides 
]

{ #category : #initialization }
Dice >> initializeWithType: aType WithQuantityOfSides: anInteger [ 
	type:=aType.
	QuantityOfSides:= anInteger.
	futureThrows :=#(5 1 5 1 5 1 5 1 5 1 5 1 5 1 5 1 5 1 5 1).
	nextThrow:= 0.
	
]

{ #category : #actions }
Dice >> throw [
	^type throw: self.
]

{ #category : #actions }
Dice >> throwWhenRandom [
	|aRandomSeries aRandomInt|
	aRandomSeries := Random new.
	aRandomInt := (aRandomSeries nextInt: (QuantityOfSides)).
	^aRandomInt
	
]

{ #category : #actions }
Dice >> throwWhenSecuential [
	futureThrows := (futureThrows select: [:number | (number < (QuantityOfSides+1)) & (number>0) ]).			"Me quedo solo con los valores que esten entre 1 y quantity of sides "
	nextThrow :=nextThrow+1.
	^(futureThrows at: nextThrow).
	
	
]
