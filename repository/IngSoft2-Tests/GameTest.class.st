Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testGameCanEnd [
	| john tim players dice dices game |
	john := Player named: 'John'.
	tim := Player named: 'Tim'.
	players := Array with: john with: tim.
	dice := Dice withType: (DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1)) withSides: 6.
	dices := Array with: dice.
	game := Game playedBy: players throwing: dices onABoardWithNumberOfTiles: 20.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 5.
	self assert: (game positionOf: tim) equals: 1.
	game turnOf: john.
	game turnOf: tim.
	game turnOf: john.
	game turnOf: tim.
	game turnOf: john.
	self
		should: [ game turnOf: tim ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'El juego ya termino' ].
	self assert: (game positionOf: john) equals: 20.
	self assert: (game positionOf: tim) equals: 3.
	self assert: game hasEnded
]

{ #category : #tests }
GameTest >> testGameIsCreated [
	| john tim players dice1 dice2 dices game |
	john := Player named: 'John'.
	tim := Player named: 'Tim'.
	players := Array with: john with: tim.
	dice1 := Dice withType: (DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1)) withSides: 5.
	dice2 := Dice withType: (DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1)) withSides: 5.
	dices := Array with: dice1 with: dice2.
	game := Game playedBy: players throwing: dices onABoardWithNumberOfTiles: 20.
	self deny: game hasEnded
]

{ #category : #tests }
GameTest >> testGamePlaceOfTimEquals2 [
	| john tim players dice dices game |
	john := Player named: 'John'.
	tim := Player named: 'Tim'.
	players := Array with: john with: tim.
	dice := Dice withType: (DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1)) withSides: 5.
	dices := Array with: dice.
	game := Game playedBy: players throwing: dices onABoardWithNumberOfTiles: 11.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 5.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game placeOf: john )equals: 1.
	game turnOf: john.
	game turnOf: tim.
	game turnOf: john.
	self assert: (game wonBy: john)
]

{ #category : #tests }
GameTest >> testGamePlayerThrowsDice [
	| john tim players dice dices game |
	john := Player named: 'John'.
	tim := Player named: 'Tim'.
	players := Array with: john with: tim.
	dice := Dice withType: (DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1)) withSides: 5.
	dices := Array with: dice.
	game := Game playedBy: players throwing: dices onABoardWithNumberOfTiles: 20.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 0.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 5
]

{ #category : #tests }
GameTest >> testGameRespectsTurns [
	| john tim players dice dices game |
	john := Player named: 'John'.
	tim := Player named: 'Tim'.
	players := Array with: john with: tim.
	dice := Dice withType: (DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1)) withSides: 5.
	dices := Array with: dice.
	game := Game playedBy: players throwing: dices onABoardWithNumberOfTiles: 20.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 0.
	self should: [ game turnOf: tim ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'No es el turno del jugador' ].
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 5.
	self assert: (game positionOf: tim) equals: 1
]

{ #category : #tests }
GameTest >> testGameStartingPositionIsZero [
	| john tim players dice game dices |
	john := Player named: 'John'.
	tim := Player named: 'Tim'.
	players := Array with: john with: tim.
	dice := Dice withType: (DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1)) withSides: 5.
	dices := Array with: dice.
	game := Game playedBy: players throwing: dice onABoardWithNumberOfTiles: 20.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 0
]

{ #category : #tests }
GameTest >> testGameWonByJohn [
	| john tim players dice dices game |
	john := Player named: 'John'.
	tim := Player named: 'Tim'.
	players := Array with: john with: tim.
	dice := Dice withType: (DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1)) withSides: 5.
	dices := Array with: dice.
	game := Game playedBy: players throwing: dices onABoardWithNumberOfTiles: 11.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 5.
	self assert: (game positionOf: tim) equals: 1.
	game turnOf: john.
	game turnOf: tim.
	"self deny: (game wonBy: john)."
	self deny: game hasEnded.
	game turnOf: john.
	self assert: (game wonBy: john).
	self assert: (game positionOf: john) equals: 11
]
