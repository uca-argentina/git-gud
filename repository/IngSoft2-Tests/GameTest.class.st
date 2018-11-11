Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'extract methods' }
GameTest >> createTilesAtomicBombNormalTile [
	| atomicBomb tiles normalTile |
	atomicBomb := AtomicBomb new.
	normalTile := NormalTile new.
	tiles := OrderedCollection new.
	(1 to: 10)
		do: [ :each | 
			tiles add: atomicBomb.
			tiles add: normalTile ].
	^ tiles
]

{ #category : #'as yet unclassified' }
GameTest >> createTilesDrawACardTile [
		|  tiles drawACard |
	drawACard := DrawACard  new.
	tiles := OrderedCollection new.
	(1 to: 11) do: [ :each | tiles add: drawACard ].
	^ tiles
	
]

{ #category : #'extract methods' }
GameTest >> createTilesMoonWalkNormalTile [
	| moonwalk tiles normalTile |
	moonwalk := MoonWalk ofValue: 3.
	normalTile := NormalTile new.
	tiles := OrderedCollection new.
	(1 to: 10)
		do: [ :each | 
			tiles add: moonwalk.
			tiles add: normalTile ].
	
	^ tiles
]

{ #category : #'extract methods' }
GameTest >> createTilesNormalTile [
		|  tiles normalTile |
	normalTile := NormalTile new.
	tiles := OrderedCollection new.
	(1 to: 11) do: [ :each | tiles add: normalTile ].
	^ tiles
]

{ #category : #'extract methods' }
GameTest >> createTilesSpeedUpNormalTile [
	| speedUp tiles normalTile |
	speedUp := SpeedUp new.
	normalTile := NormalTile new.
	tiles := OrderedCollection new.
	(1 to: 10)
		do: [ :each | 
			tiles add: speedUp.
			tiles add: normalTile ].
	
	^ tiles
]

{ #category : #'extract methods' }
GameTest >> createTilesWormHole [
	| tiles wormhole |
	wormhole := WormHole new.
	tiles := OrderedCollection new.
	(1 to: 20) do: [ :each | tiles add: wormhole ].
	^ tiles
]

{ #category : #'extract methods' }
GameTest >> createTilesWormHoleNormalTile [
	| wormhole tiles normalTile |
	wormhole := WormHole new.
	normalTile := NormalTile new.
	tiles := OrderedCollection new.
	(1 to: 10)
		do: [ :each | 
			tiles add: wormhole.
			tiles add: normalTile ].
	^ tiles
]

{ #category : #tests }
GameTest >> testAtomicBombMovesPlayers [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesAtomicBombNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0
]

{ #category : #tests }
GameTest >> testCantBeWonWhilePlaying [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 2.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 11.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0.
	self should: [ game wonBy: tim ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game has not ended yet' ].
	game turnOf: tim.
	game turnOf: john
]

{ #category : #tests }
GameTest >> testGameCanEnd [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 2.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 11.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 3.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 10.
	self assert: (game lapOf: john) equals: 1.
	self assert: (game positionOf: tim) equals: 4.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: tim.
	game turnOf: john.
	self should: [ game turnOf: tim ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game has already ended' ].
	self assert: (game positionOf: john) equals: 4.
	self assert: (game lapOf: john) equals: 2.
	self assert: (game positionOf: tim) equals: 5.
	self assert: (game lapOf: tim) equals: 0.
	self should: [ game turnOf: tim ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game has already ended' ].
	self assert: game hasEnded
]

{ #category : #tests }
GameTest >> testGameIsCreated [
	| board john tim players dice1 dice2 dices game |
	board := Board composedOf: self createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice1 := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dice2 := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice1 with: dice2.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded
]

{ #category : #tests }
GameTest >> testGamePlaceOfReturnsOrderOfPlayers [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 2.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	game turnOf: john.
	game turnOf: tim.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 10.
	self assert: (game lapOf: john) equals: 1.
	self assert: (game positionOf: tim) equals: 4.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: tim.
	game turnOf: john.
	self should: [ game turnOf: tim ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game has already ended' ].
	self assert: (game positionOf: john) equals: 4.
	self assert: (game lapOf: john) equals: 2.
	self assert: (game positionOf: tim) equals: 5.
	self assert: (game lapOf: tim) equals: 0.
	self assert: game hasEnded.
	self assert: (game placeOf: tim) equals: 2
]

{ #category : #tests }
GameTest >> testGamePlayerThrowsDice [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 2.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0
]

{ #category : #tests }
GameTest >> testGameRespectsTurns [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	self should: [ game turnOf: tim ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'It´s not the player´s turn' ].
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0
]

{ #category : #tests }
GameTest >> testGameStartingPositionIsOneAndLapIsZero [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: john) equals: 0
]

{ #category : #tests }
GameTest >> testGameWonByJohn [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 2.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game placeOf: tim) equals: 2.
	game turnOf: john.
	game turnOf: tim.
	game turnOf: john.
	game turnOf: tim.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 10.
	self assert: (game lapOf: john) equals: 1.
	self assert: (game positionOf: tim) equals: 4.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: tim.
	game turnOf: john.
	self should: [ game turnOf: tim ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game has already ended' ].
	self assert: (game positionOf: john) equals: 4.
	self assert: (game lapOf: john) equals: 2.
	self assert: (game positionOf: tim) equals: 5.
	self assert: (game lapOf: tim) equals: 0.
	self assert: game hasEnded.
	self assert: (game placeOf: tim) equals: 2.
	self assert: (game wonBy: john)
]

{ #category : #tests }
GameTest >> testMoonWalkMovesOtherPlayers [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesMoonWalkNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 2 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 2.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 3.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 3.
	self assert: (game lapOf: john) equals: 0
]

{ #category : #tests }
GameTest >> testNegativeLapsExist [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesWormHole.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(1 1 1 1 1 1 1 1 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 18.
	self assert: (game lapOf: john) equals: -1.
	self assert: (game positionOf: tim) equals: 18.
	self assert: (game lapOf: tim) equals: -1.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 15.
	self assert: (game lapOf: john) equals: -1
]

{ #category : #tests }
GameTest >> testPlayerDoesNotExist [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	self should: [ game positionOf: 'pepe' ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'The requested player does not exist' ].
	self should: [ game lapOf: 'pepe' ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'The requested player does not exist' ].
	self should: [ game placeOf: 'pepe' ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'The requested player does not exist' ].
	game turnOf: john.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0
]

{ #category : #tests }
GameTest >> testSpeedUpMovesPlayer [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesSpeedUpNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 15.
	self assert: (game lapOf: john) equals: 0
]

{ #category : #tests }
GameTest >> testWormHoleMovesPlayer [
	| board john tim players dice dices game |
	board := Board composedOf: self createTilesWormHoleNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: GameTestWithCards new createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 7.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 2.
	self assert: (game lapOf: tim) equals: 0
]
