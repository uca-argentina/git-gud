Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'positions',
		'laps',
		'dices',
		'turn',
		'stateOfGame',
		'board',
		'winningLap',
		'cardGenerator',
		'playerHands',
		'activePermanentCards',
		'lastTileActivated',
		'lastCardActivated'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertNumberOfTilesGreaterThanZero: anInteger [
	(anInteger <0)
	ifTrue: [ AssertionFailure signal:'The number of tiles in the board must be greater than zero' ].
]

{ #category : #initialization }
Game class >> playedBy: aPlayerArray throwing: aDiceArray onABoard: aBoard withCardGenerator: aCardGenerator  withNumberOfLaps: aNumberOfLaps [
	self assertNumberOfTilesGreaterThanZero: aBoard tiles size.
	^ self new
		initializePlayedBy: aPlayerArray
		throwing: aDiceArray
		onABoard: aBoard
		withCardGenerator: aCardGenerator
		withNumberOfLaps: aNumberOfLaps
]

{ #category : #adding }
Game >> addPermanentCard: aCard to: aPlayer [
(activePermanentCards at: aPlayer) add: aCard
]

{ #category : #actions }
Game >> advanceTurn [
	turn := turn + 1 > self players size
		ifTrue: [ 1 ]
		ifFalse: [ turn + 1 ]
]

{ #category : #accessing }
Game >> amountOfActivePermanentCardsfor: aPlayer [
^(activePermanentCards at: aPlayer)size.
]

{ #category : #asserting }
Game >> assertCanPlay: aPlayer [
	^ (self players at: turn) = aPlayer
		ifFalse: [ AssertionFailure signal: 'It´s not the player´s turn' ]
]

{ #category : #actions }
Game >> changePositionOf: aPlayer by: anAmount. [
	positions at: aPlayer put: (positions at: aPlayer) + anAmount.
]

{ #category : #accessing }
Game >> currentPlayer [
	^self players at: turn.
]

{ #category : #accessing }
Game >> currentTilefor: aPlayer [
	^ board tiles at: (self positionOf: aPlayer)
]

{ #category : #actions }
Game >> drawCardForPlayer: aPlayer [
	(playerHands at: aPlayer) add: cardGenerator generateCard.
	
]

{ #category : #accessing }
Game >> handSizeOf: aPlayer [
	^ ((playerHands at: aPlayer) size)
]

{ #category : #testing }
Game >> hasEnded [
	^stateOfGame hasEnded.
]

{ #category : #initialization }
Game >> initializePlayedBy: aGroupOfPlayers throwing: aGroupOfDices onABoard: aBoard withCardGenerator: aCardGenerator withNumberOfLaps: aNumberOfLaps [
	dices := aGroupOfDices.
	board := aBoard.
	turn := 1.
	stateOfGame := GamePlaying new.
	positions := Dictionary new.
	laps := Dictionary new.
	cardGenerator := aCardGenerator.
	aGroupOfPlayers do: [ :each | positions at: each put: 1 ].
	aGroupOfPlayers do: [ :each | laps at: each put: 0 ].
	winningLap := aNumberOfLaps.
	playerHands := Dictionary new.
	activePermanentCards := Dictionary new.
	lastTileActivated := NormalTile new -> (aGroupOfPlayers at: 1).
	aGroupOfPlayers
		do: [ :player | 
			playerHands at: player put: OrderedCollection new.
			self drawCardForPlayer: player.
			self drawCardForPlayer: player ].
	aGroupOfPlayers do: [ :each | activePermanentCards at: each put: OrderedCollection new ]
]

{ #category : #accessing }
Game >> lapOf: aPlayer [
	(laps includesKey: aPlayer)
		ifTrue: [ ^ laps at: aPlayer ]
		ifFalse: [ AssertionFailure signal: 'The requested player does not exist' ]
]

{ #category : #accessing }
Game >> lastTileActivated [
^lastTileActivated 
]

{ #category : #accessing }
Game >> placeOf: aPlayer [
	^ (self players asSortedCollection: [ :player | self lapOf: player ] descending , [ :player | self positionOf: player ] descending)
		detectIndex: [ :player | player = aPlayer ]
		ifNone: [ AssertionFailure signal: 'The requested player does not exist' ]
]

{ #category : #actions }
Game >> playAccelerationFromPlayer: aPlayer [
	"| acceleration |
	acceleration := Acceleration new.
	aPlayer = self currentPlayer
		ifTrue: [ (playerHands at: aPlayer)
				remove: ((playerHands at: aPlayer) detect: [ :card | card class = Acceleration ] ifNone: [ AssertionFailure signal: 'The player does not possess an Acceleration card' ]).
			acceleration activateCardEffectFor: aPlayer in: self.
			lastCardActivated := acceleration ]
		ifFalse: [ AssertionFailure signal: 'Permanent Cards can only be played in the player´s turn' ]"
		
	| firstCardFound |
	aPlayer = self currentPlayer
		ifTrue: [ firstCardFound := (playerHands at: aPlayer) detect: [ :card | card class = Acceleration ] ifNone: [ AssertionFailure signal: 'The player does not possess an Acceleration card' ].
			firstCardFound activateCardEffectFor: aPlayer in: self.
			(playerHands at: aPlayer) remove: firstCardFound ]
		ifFalse: [ AssertionFailure signal: 'Permanent Cards can only be played in the player´s turn' ]
]

{ #category : #actions }
Game >> playCancellationFromPlayer: aPlayer ForCard: aCard [
	
	| firstCardFound |
	firstCardFound := (playerHands at: aPlayer) detect: [ :card | card class = Cancellation ] ifNone: [ AssertionFailure signal: 'The player does not possess a Cancellation card' ].
	firstCardFound activateCardEffectFor: aCard in: self.
	(playerHands at: aPlayer) remove: firstCardFound.
	
	

]

{ #category : #actions }
Game >> playOverloadFromPlayer: aPlayer toPlayer: targetPlayer [
	| firstCardFound |
	aPlayer = self currentPlayer
		ifTrue: [ firstCardFound := (playerHands at: aPlayer) detect: [ :card | card class = Overload ] ifNone: [ AssertionFailure signal: 'The player does not possess an Overload card' ].
			firstCardFound activateCardEffectFor: targetPlayer in: self.
			(playerHands at: aPlayer) remove: firstCardFound. ]
		ifFalse: [ AssertionFailure signal: 'Permanent Cards can only be played in the player´s turn' ]
]

{ #category : #actions }
Game >> playRedoFromPlayer: aPlayer toPlayer: targetPlayer [
	
	| firstCardFound |
	firstCardFound := (playerHands at: aPlayer) detect: [ :card | card class = Redo ] ifNone: [ AssertionFailure signal: 'The player does not possess a Redo card' ].
	firstCardFound activateCardEffectFor: lastCardActivated value in: self.
	(playerHands at: aPlayer) remove: firstCardFound.
	self recalculateLaps
	
	
	
]

{ #category : #actions }
Game >> playRepeatFromPlayer: aPlayer [
	

	| firstCardFound |
	firstCardFound := (playerHands at: aPlayer) detect: [ :card | card class = Repeat ] ifNone: [ AssertionFailure signal: 'The player does not possess an Repeat card' ].
	firstCardFound activateCardEffectFor: lastTileActivated value in: self.
	(playerHands at: aPlayer) remove: firstCardFound.
	self recalculateLaps
]

{ #category : #actions }
Game >> playSpeedFromPlayer: aPlayer toPlayer: targetPlayer [
		| firstCardFound |
	aPlayer = self currentPlayer
		ifTrue: [ firstCardFound := (playerHands at: aPlayer) detect: [ :card | card class = Speed ] ifNone: [ AssertionFailure signal: 'The player does not possess an Speed card' ].
			firstCardFound activateCardEffectFor: targetPlayer in: self.
			(playerHands at: aPlayer) remove: firstCardFound ]
		ifFalse: [ AssertionFailure signal: 'Permanent Cards can only be played in the player´s turn' ]
]

{ #category : #accessing }
Game >> playTurnFor: aPlayer [
	| totalRoll |
	totalRoll := dices sumNumbers: [ :dice | dice throw ].
	totalRoll := totalRoll + ((activePermanentCards at: aPlayer) sumNumbers: [ :card | card outcome ]).
	
	self changePositionOf: aPlayer by: totalRoll.
	self recalculateLaps.
	lastTileActivated := (self currentTilefor: aPlayer) -> aPlayer.
	(self currentTilefor: aPlayer) activateEffectforGame: self forPlayer: self currentPlayer.
	self recalculateLaps.
	(self lapOf: aPlayer) >= winningLap
		ifTrue: [ self updateGameState ]
]

{ #category : #accessing }
Game >> players [
^(positions keysSortedSafely)
]

{ #category : #accessing }
Game >> positionOf: aPlayer [
	(positions includesKey: aPlayer)
		ifTrue: [ ^ positions at: aPlayer ]
		ifFalse: [ AssertionFailure signal: 'The requested player does not exist' ]
]

{ #category : #accessing }
Game >> recalculateLaps [
	self players
		do: [ :player | 
			(positions at: player) > board tiles size
				ifTrue: [ laps at: player put: (laps at: player) + 1.
					self changePositionOf: player by: board tiles size negated ].
			(positions at: player) < 1
				ifTrue: [ laps at: player put: (laps at: player) - 1.
					self changePositionOf: player by: board tiles size ] ]
]

{ #category : #removing }
Game >> removePermanentCard: aCard from: aPlayer [
	(activePermanentCards at: aPlayer) removeAllSuchThat: [ :card | aCard  = card  ]
]

{ #category : #actions }
Game >> turnOf: aPlayer [
	stateOfGame turnOf: aPlayer in: self.
]

{ #category : #actions }
Game >> turnOfWhenGameHasEnded: aPlayer [
	AssertionFailure signal: 'The game has already ended'
]

{ #category : #accessing }
Game >> turnOfWhenGameIsBeingPlayed: aPlayer [
	
	self assertCanPlay: aPlayer.
	self playTurnFor: aPlayer.
	self advanceTurn
]

{ #category : #actions }
Game >> updateGameState [
stateOfGame := GameEnded new.
]

{ #category : #actions }
Game >> whenGameHasEndedWonBy: aPlayer [
	^((self placeOf: aPlayer )=1)
]

{ #category : #actions }
Game >> whenGameIsBeingPlayedwonBy: aPlayer [
	^ AssertionFailure signal: 'The game has not ended yet'
]

{ #category : #accessing }
Game >> wonBy: aPlayer [
	^stateOfGame wonBy: aPlayer in: self.
]
