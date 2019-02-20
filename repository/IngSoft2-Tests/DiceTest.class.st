Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testDiceCreation [
	| dice |
	dice := RandomDice ofSides: 6.
	self assert: dice quantityOfSides equals: 6
]

{ #category : #tests }
DiceTest >> testDiceShouldFailWithNegativeQuantity [
	self
		should: [  RandomDice ofSides: -6 ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The quantity of sides must be greater than zero' ]
]

{ #category : #tests }
DiceTest >> testDiceWontThrowInvalidValue [
	| dice |
	dice := DeterministicDice withFutureThrows: #(7 1 2 3 4 5) andSides: 6.
	self assert: dice throw equals: 1
]

{ #category : #tests }
DiceTest >> testThrowDeterministicDice [
	| dice |
	dice := DeterministicDice withFutureThrows: #(5 1 2 3 4 5) andSides: 6.
	self assert: dice throw equals: 5
]

{ #category : #tests }
DiceTest >> testThrowRandomDice [
	| dice |
	dice := RandomDice ofSides: 6.
	self assert: (dice throw between: 1 and: 6)
]
