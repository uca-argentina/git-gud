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
Game class >> assertNumberOfTilesGreaterThanZero: aBoard [
	((aBoard tiles size) < 0)
		ifTrue: [ AssertionFailure signal: 'The number of tiles in the board must be greater than zero' ]
]

{ #category : #initialization }
Game class >> playedBy: aPlayerArray throwing: aDiceArray onABoard: aBoard usingDeck: aDeck withNumberOfLaps: aNumberOfLaps [
	self assertNumberOfTilesGreaterThanZero: aBoard.
	^ self new
		initializePlayedBy: aPlayerArray
		throwing: aDiceArray
		onABoard: aBoard
		usingDeck: aDeck
		withNumberOfLaps: aNumberOfLaps
]

{ #category : #accessing }
Game >> activePermanentCards [
^activePermanentCards 
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
	^ (self currentPlayer ) = aPlayer
		ifFalse: [ AssertionFailure signal: 'It´s not the player´s turn' ]
]

{ #category : #asserting }
Game >> assertPlayerExists: aPlayer [
((self players) includes: aPlayer)
ifFalse: [ AssertionFailure signal: 'The player does not exist' ].
]

{ #category : #actions }
Game >> changePositionOf: aPlayer by: anAmount [
	positions at: aPlayer put: (positions at: aPlayer) + anAmount
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
	(playerHands at: aPlayer) add: cardGenerator drawCard.
	
]

{ #category : #accessing }
Game >> handOf: aPlayer [
^(playerHands at: aPlayer).
]

{ #category : #accessing }
Game >> handSizeOf: aPlayer [
	^ ((playerHands at: aPlayer) size)
]

{ #category : #asserting }
Game >> hasEnded [
	^stateOfGame hasEnded.
]

{ #category : #initialization }
Game >> initializePlayedBy: aGroupOfPlayers throwing: aGroupOfDices onABoard: aBoard usingDeck: aDeck withNumberOfLaps: aNumberOfLaps [
	dices := aGroupOfDices.
	board := aBoard.
	turn := 1.
	stateOfGame := GamePlaying new.
	positions := Dictionary new.
	laps := Dictionary new.
	cardGenerator := aDeck.
	aGroupOfPlayers do: [ :each | positions at: each put: 1 ].
	aGroupOfPlayers do: [ :each | laps at: each put: 0 ].
	winningLap := aNumberOfLaps.
	playerHands := Dictionary new.
	activePermanentCards := Dictionary new.
	lastTileActivated := NormalTile new -> (aGroupOfPlayers at: 1).
	lastCardActivated := NoEffectCard new.
	aGroupOfPlayers
		do: [ :player | 
			playerHands at: player put: OrderedCollection new.
			self drawCardForPlayer: player.
			self drawCardForPlayer: player ].
	aGroupOfPlayers do: [ :each | activePermanentCards at: each put: OrderedCollection new ]
]

{ #category : #accessing }
Game >> lapOf: aPlayer [
	self assertPlayerExists: aPlayer.	
	^ laps at: aPlayer.
]

{ #category : #accessing }
Game >> lastCardActivated [
	^ lastCardActivated
]

{ #category : #accessing }
Game >> lastTileActivated [
^lastTileActivated 
]

{ #category : #accessing }
Game >> placeOf: aPlayer [
	^ (self players asSortedCollection: [ :player | self lapOf: player ] descending , [ :player | self positionOf: player ] descending)
		detectIndex: [ :player | player = aPlayer ]
		ifNone: [ AssertionFailure signal: 'The player does not exist' ]
]

{ #category : #actions }
Game >> playAccelerationFromPlayer: aPlayer [
	| firstCardFound |
	stateOfGame cardIsPlayed.
	self assertPlayerExists: aPlayer.
	firstCardFound := (playerHands at: aPlayer)
		detect: [ :card | card class = Acceleration ]
		ifNone: [ AssertionFailure signal: 'The player does not possess an Acceleration card' ].
	firstCardFound isPlayableBy: aPlayer in: self.
	firstCardFound activateCardEffectFor: aPlayer in: self.
	lastCardActivated := firstCardFound.
	(playerHands at: aPlayer) remove: firstCardFound
]

{ #category : #actions }
Game >> playCancellationFromPlayer: aPlayer ForCard: aCard [
	| firstCardFound |
	stateOfGame cardIsPlayed.
	self assertPlayerExists: aPlayer.
	self activePermanentCards values
		detect: [ :cardsOfPlayer | cardsOfPlayer includes: aCard ]
		ifNone: [ AssertionFailure signal: 'Cancellation requires an active permanent card to cancel' ].
	firstCardFound := (playerHands at: aPlayer)
		detect: [ :card | card class = Cancellation ]
		ifNone: [ AssertionFailure signal: 'The player does not possess a Cancellation card' ].
	firstCardFound activateCardEffectFor: aCard in: self.
	lastCardActivated := firstCardFound.
	(playerHands at: aPlayer) remove: firstCardFound.
	
]

{ #category : #actions }
Game >> playOverloadFromPlayer: aPlayer toPlayer: targetPlayer [
	| firstCardFound |
	stateOfGame cardIsPlayed.
	self assertPlayerExists: aPlayer.
	self assertPlayerExists: targetPlayer.
	 firstCardFound := (playerHands at: aPlayer)
				detect: [ :card | card class = Overload ]
				ifNone: [ AssertionFailure signal: 'The player does not possess an Overload card' ].
			firstCardFound isPlayableBy: aPlayer in: self.
			firstCardFound activateCardEffectFor: targetPlayer in: self.
			lastCardActivated := firstCardFound.
			(playerHands at: aPlayer) remove: firstCardFound 
		
]

{ #category : #actions }
Game >> playRedoFromPlayer: aPlayer for: aTarget [
	| firstCardFound |
	stateOfGame cardIsPlayed.
	self assertPlayerExists: aPlayer.
	(Card allSubclasses includes: aTarget class) | (self players includes: aTarget)
		ifFalse: [ AssertionFailure signal: 'The target for Redo is not correct for this card' ].
	firstCardFound := (playerHands at: aPlayer) detect: [ :card | card class = Redo ] ifNone: [ AssertionFailure signal: 'The player does not possess a Redo card' ].
	firstCardFound activateCardEffectFor: aTarget in: self.
	(playerHands at: aPlayer) remove: firstCardFound.
	self recalculateLaps
]

{ #category : #actions }
Game >> playRepeatFromPlayer: aPlayer [
	| firstCardFound |
	stateOfGame cardIsPlayed.
	self assertPlayerExists: aPlayer.
	firstCardFound := (playerHands at: aPlayer) detect: [ :card | card class = Repeat ] ifNone: [ AssertionFailure signal: 'The player does not possess an Repeat card' ].
	firstCardFound activateCardEffectFor: lastTileActivated value in: self.
	lastCardActivated := firstCardFound.
	(playerHands at: aPlayer) remove: firstCardFound.
	self recalculateLaps
]

{ #category : #actions }
Game >> playSpeedFromPlayer: aPlayer toPlayer: targetPlayer [
	| firstCardFound |
	stateOfGame cardIsPlayed.
	self assertPlayerExists: aPlayer.
	self assertPlayerExists: targetPlayer.
	firstCardFound := (playerHands at: aPlayer)
				detect: [ :card | card class = Speed ]
				ifNone: [ AssertionFailure signal: 'The player does not possess an Speed card' ].
			firstCardFound isPlayableBy: aPlayer in: self.
			firstCardFound activateCardEffectFor: targetPlayer in: self.
			lastCardActivated := firstCardFound.
			(playerHands at: aPlayer) remove: firstCardFound 
		
]

{ #category : #accessing }
Game >> playTurnFor: aPlayer [
	| totalRoll |
	totalRoll := dices sumNumbers: [ :dice | dice throw ].
	totalRoll := totalRoll + ((activePermanentCards at: aPlayer) sumNumbers: [ :card | card tilesToMove ]).
	
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
	self assertPlayerExists: aPlayer.
	^ positions at: aPlayer
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
