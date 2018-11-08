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
		'winningLap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertNumberOfTilesGreaterThanZero: anInteger [
	(anInteger <0)
	ifTrue: [ AssertionFailure signal:'The number of tiles in the board must be greater than zero' ].
]

{ #category : #initialization }
Game class >> playedBy: aPlayerArray throwing: aDiceArray onABoard: aBoard withNumberOfLaps: aNumberOfLaps [
	self assertNumberOfTilesGreaterThanZero: (aBoard tiles) size.
	^ self new initializePlayedBy: aPlayerArray throwing: aDiceArray onABoard: aBoard withNumberOfLaps: aNumberOfLaps
]

{ #category : #actions }
Game >> advanceTurn [
	turn := turn + 1 > self players size
		ifTrue: [ 1 ]
		ifFalse: [ turn + 1 ]
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

{ #category : #testing }
Game >> hasEnded [
	^stateOfGame hasEnded.
]

{ #category : #initialization }
Game >> initializePlayedBy: aGroupOfPlayers throwing: aGroupOfDices onABoard: aBoard withNumberOfLaps: aNumberOfLaps [
	dices := aGroupOfDices.
	board := aBoard.
	turn := 1.
	stateOfGame := GamePlaying new.
	positions := Dictionary new.
	laps := Dictionary new.
	
	aGroupOfPlayers do: [ :each | positions at: each put: 1 ].
	aGroupOfPlayers do: [ :each | laps at: each put: 0 ].
	winningLap := aNumberOfLaps
]

{ #category : #accessing }
Game >> lapOf: aPlayer [
	(laps includesKey: aPlayer)
		ifTrue: [ ^ laps at: aPlayer ]
		ifFalse: [ AssertionFailure signal: 'The requested player does not exist' ]
]

{ #category : #accessing }
Game >> placeOf: aPlayer [
	^ (self players asSortedCollection: [ :player | self lapOf: player ] descending , [ :player | self positionOf: player ] descending)
		detectIndex: [ :player | player = aPlayer ]
		ifNone: [ AssertionFailure signal: 'The requested player does not exist' ]
]

{ #category : #accessing }
Game >> playTurnFor: aPlayer [
	|totalRoll|
	totalRoll := dices sumNumbers: [:dice | dice throw ].
	self changePositionOf: aPlayer by: totalRoll.
	self recalculateLaps.
	(board tiles at: (self positionOf: aPlayer)) activateEffectforGame: self.
	self recalculateLaps.
	((self lapOf: aPlayer) >= winningLap )								
		ifTrue: [ 
			self updateGameState ]
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
			(positions at: player) < 0
				ifTrue: [ laps at: player put: (laps at: player) - 1.
					self changePositionOf: player by: board tiles size ] ]
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
