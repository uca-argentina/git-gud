Class {
	#name : #GameTestWithCards,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
GameTestWithCards >> createAccelerationCardsGenerator [
	| deck acceleration aCardGenerator |
	acceleration := Acceleration new.
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: acceleration ].
	aCardGenerator := DeterministicCardGenerator withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #'as yet unclassified' }
GameTestWithCards >> createOverloadCancellationCardsGenerator [
	
	
	
	
| deck overload1 overload2 overload3 cancellation1 cancellation2 cancellation3 |
	deck := OrderedCollection new.
	deck add: (overload1 := Overload new).
	deck add: (cancellation1 := Cancellation new).
	deck add: (overload2 := Overload new).
	deck add: (cancellation2 := Cancellation new).
	deck add: (overload3 := Overload new).
	deck add: (cancellation3 := Cancellation new).
	DeterministicCardGenerator withFutureCards: deck.
]

{ #category : #'extract methods' }
GameTestWithCards >> createOverloadCardsGenerator [
	| deck overload aCardGenerator |
	overload := Overload new.
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: overload ].
	aCardGenerator := DeterministicCardGenerator withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #'as yet unclassified' }
GameTestWithCards >> createRepeatCardsGenerator [
	| deck overload aCardGenerator |
	overload := Repeat new.
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: overload ].
	aCardGenerator := DeterministicCardGenerator withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #'extract methods' }
GameTestWithCards >> createSpeedCardsGenerator [
	| deck speed aCardGenerator |
	speed := Speed new.
	deck := OrderedCollection new.
	(1 to: 10) do: [ :each | deck add: speed ].
	aCardGenerator := DeterministicCardGenerator withFutureCards: deck.
	^ aCardGenerator
]

{ #category : #tests }
GameTestWithCards >> testAccelerationCardAffectsTurnOfPlayer [
	| board john tim players dice dices game |
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: self createAccelerationCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game handSizeOf: john) equals: 2.
	game playAccelerationFromPlayer: john.
	self assert: (game handSizeOf: john) equals: 1.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 7.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 3.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 1.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 1
]

{ #category : #tests }
GameTestWithCards >> testAccelerationCardIsCancelled [
	| board john tim players dice dices game deck acceleration1 acceleration2 acceleration3 cancellation1 cancellation2 cancellation3 |
	deck := OrderedCollection new.
	deck add: (acceleration1 := Acceleration new).
	deck add: (cancellation1 := Cancellation new).
	deck add: (acceleration2 := Acceleration new).
	deck add: (cancellation2 := Cancellation new).
	deck add: (acceleration3 := Acceleration new).
	deck add: (cancellation3 := Cancellation new).
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: (DeterministicCardGenerator withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handSizeOf: john) equals: 2.
	game playAccelerationFromPlayer: john.
	self assert: (game handSizeOf: john) equals: 1.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 1.
	game playCancellationFromPlayer: john ForCard: acceleration1.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 0.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 0
]

{ #category : #tests }
GameTestWithCards >> testAccelerationCardIsRemovedFromHand [
	| board john tim players dice dices game |
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: self createAccelerationCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handSizeOf: john) equals: 2.
	game playAccelerationFromPlayer: john.
	self assert: (game handSizeOf: john) equals: 1.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 1.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 1
]

{ #category : #tests }
GameTestWithCards >> testGameWithCardsIsCreated [
	| board john tim players dice dices game |
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: self createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	
]

{ #category : #tests }
GameTestWithCards >> testOverloadCardAffectsTurnOfPlayer [
	| board john tim players dice dices game |
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: self createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game handSizeOf: john) equals: 2.
	game playOverloadFromPlayer: john toPlayer: tim.
	self assert: (game handSizeOf: john) equals: 1.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 11.
	self assert: (game lapOf: tim) equals: -1.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 0.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 1
]

{ #category : #tests }
GameTestWithCards >> testOverloadCardIsCancelled [
	| board john tim players dice dices game deck overload1 overload2 overload3 cancellation1 cancellation2 cancellation3 |
	deck := OrderedCollection new.
	deck add: (overload1 := Overload new).
	deck add: (cancellation1 := Cancellation new).
	deck add: (overload2 := Overload new).
	deck add: (cancellation2 := Cancellation new).
	deck add: (overload3 := Overload new).
	deck add: (cancellation3 := Cancellation new).
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: (DeterministicCardGenerator withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handSizeOf: john) equals: 2.
	game playOverloadFromPlayer: john toPlayer: tim.
	self assert: (game handSizeOf: john) equals: 1.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 0.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 1.
	game playCancellationFromPlayer: tim ForCard: overload1.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 0.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 0
]

{ #category : #tests }
GameTestWithCards >> testOverloadCardIsRemovedFromHand [
	| board john tim players dice dices game |
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: self createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handSizeOf: john) equals: 2.
	game playOverloadFromPlayer: john toPlayer: tim.
	self assert: (game handSizeOf: john) equals: 1.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 0.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 1
]

{ #category : #tests }
GameTestWithCards >> testPlayerDrawsCardFromTile [
	| board john tim players dice dices game |
	board := Board composedOf: GameTest new createTilesDrawACardTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: self createAccelerationCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handSizeOf: john) equals: 2.
	game playAccelerationFromPlayer: john.
	self assert: (game handSizeOf: john) equals: 1.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 1.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 1.
	game turnOf: john.
	self assert: (game handSizeOf: john) equals: 2
]

{ #category : #tests }
GameTestWithCards >> testPlayerPlaysCardHeDoesNotHave [
	| board john tim players dice dices game |
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: self createOverloadCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handSizeOf: john) equals: 2.
	game playOverloadFromPlayer: john toPlayer: tim.
	self assert: (game handSizeOf: john) equals: 1.
	self assert: (game handSizeOf: tim) equals: 2.
	game playOverloadFromPlayer: john toPlayer: tim.
	self assert: (game handSizeOf: john) equals: 0.
	self
		should: [ game playOverloadFromPlayer: john toPlayer: tim ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The player does not possess an Overload card' ]
]

{ #category : #tests }
GameTestWithCards >> testRepeatCardIsUsed [
	| board john tim players dice dices game |
	board := Board composedOf: GameTest new createTilesWormHole.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: self createRepeatCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	game playRepeatFromPlayer: tim.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	game turnOf: john.
	self assert: (game positionOf: john) equals: 2.
	self assert: (game lapOf: john) equals: 0.
	game playRepeatFromPlayer: tim.
	self assert: (game positionOf: john) equals: 18.
	self assert: (game lapOf: john) equals: -1
]

{ #category : #tests }
GameTestWithCards >> testSpeedCardAffectsTurnOfPlayer [
	| board john tim players dice dices game |
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: self createSpeedCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game positionOf: john) equals: 1.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 1.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game handSizeOf: john) equals: 2.
	game playSpeedFromPlayer: john toPlayer: tim.
	self assert: (game handSizeOf: john) equals: 1.
	game turnOf: john.
	game turnOf: tim.
	self assert: (game positionOf: john) equals: 6.
	self assert: (game lapOf: john) equals: 0.
	self assert: (game positionOf: tim) equals: 3.
	self assert: (game lapOf: tim) equals: 0.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 0.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 1
]

{ #category : #tests }
GameTestWithCards >> testSpeedCardIsCancelled [
	| board john tim players dice dices game deck speed1 speed2 speed3 cancellation1 cancellation2 cancellation3 |
	deck := OrderedCollection new.
	deck add: (speed1 := Speed new).
	deck add: (cancellation1 := Cancellation new).
	deck add: (speed2 := Speed new).
	deck add: (cancellation2 := Cancellation new).
	deck add: (speed3 := Speed new).
	deck add: (cancellation3 := Cancellation new).
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: (DeterministicCardGenerator withFutureCards: deck)
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handSizeOf: john) equals: 2.
	game playSpeedFromPlayer: john toPlayer: tim.
	self assert: (game handSizeOf: john) equals: 1.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 0.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 1.
	game playCancellationFromPlayer: tim ForCard: speed1.
	self assert: (game amountOfActivePermanentCardsfor: john) equals: 0.
	self assert: (game amountOfActivePermanentCardsfor: tim) equals: 0
]

{ #category : #tests }
GameTestWithCards >> testSpeedCardIsRemovedFromHand [
	| board john tim players dice dices game |
	board := Board composedOf: GameTest new createTilesNormalTile.
	john := 'John'.
	tim := 'Tim'.
	players := Array with: john with: tim.
	dice := DeterministicDice withFutureThrows: #(5 1 5 1 5 1 5 1 5 1) andSides: 5.
	dices := Array with: dice.
	game := Game
		playedBy: players
		throwing: dices
		onABoard: board
		withCardGenerator: self createSpeedCardsGenerator
		withNumberOfLaps: 3.
	self deny: game hasEnded.
	self assert: (game handSizeOf: john) equals: 2.
	game playSpeedFromPlayer: john toPlayer: john.
	self assert: (game handSizeOf: john) equals: 1
]
