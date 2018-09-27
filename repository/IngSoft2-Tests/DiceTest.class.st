Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testDiceShouldRaiseExceptionWithNegativeQuantity [
	|dice|
	self should: [dice:=Dice withType:(DeterministicDice new) withQuantityOfSides: -6.] raise: AssertionFailure .

]

{ #category : #tests }
DiceTest >> testDiceWasCreated [
	|dice|
	dice:=Dice withType: (RandomDice new) withQuantityOfSides: 6.
	self assert: dice QuantityOfSides equals: 6.
]

{ #category : #tests }
DiceTest >> testThrowReturnsColaboratorInDeterministicDice [
	|dice|
	dice:= Dice withType:  (DeterministicDice new) withQuantityOfSides: 6.
	self assert: (dice throw) equals: 5.
]
