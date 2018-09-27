Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerIsCreated [
|player|
player:= Player named: 'Miguel'.
self assert: player name equals: 'Miguel'.
self assert: player position equals: 0.
]

{ #category : #tests }
PlayerTest >> testPlayerThrowsDiceAndShowPosition [
	|player dice|
	player:= Player named: 'Maria'.
	dice:= Dice withType: (DeterministicDice new) withQuantityOfSides: 6.
	player throws: dice.
	self assert: (player position)equals: 5.       
]
