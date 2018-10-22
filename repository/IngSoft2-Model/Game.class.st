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
	^ self new initializeWithPlayers: aPlayerArray withDices: aDiceArray withBoard: aBoard withNumberOfLaps: aNumberOfLaps
]

{ #category : #actions }
Game >> UpdateGameState [
stateOfGame := GameEnded new.
]

{ #category : #actions }
Game >> activateAtomicBomb [
	self players do: [:each|
		self changePositionOf: each  by: (self positionOf: each) negated + 1 .
		].
	
]

{ #category : #actions }
Game >> activateMoonWalkWithAmount: backwardValue [

	self players do: [:each|
		self changePositionOf: each  by: backwardValue negated .
		].
	self changePositionOf: (self players at: turn)  by: backwardValue.
	
]

{ #category : #actions }
Game >> activateSpeedUp [
	self changePositionOf: (self players at: turn)  by: 4.
	
]

{ #category : #actions }
Game >> activateWormHole [
self changePositionOf: (self players at: turn)  by: 4 negated .
]

{ #category : #actions }
Game >> advanceTurn [
	turn := turn + 1 > (self players) size
				ifTrue: [ 1 ]
				ifFalse: [ "Para que si ya tiraron todos vuelva a empezar" turn + 1 ] 
]

{ #category : #asserting }
Game >> assertCanPlay: aPlayer [
	^ (( (self players) at: turn) = aPlayer)
	ifFalse:[AssertionFailure signal: 'No es el turno del jugador'].
]

{ #category : #actions }
Game >> changePositionOf: aPlayer by: anAmount. [
	positions at: aPlayer put: (positions at: aPlayer) + anAmount.
]

{ #category : #testing }
Game >> hasEnded [
	^stateOfGame hasEnded.
]

{ #category : #initialization }
Game >> initializeWithPlayers: aGroupOfPlayers withDices: aGroupOfDices withBoard: aBoard withNumberOfLaps: aNumberOfLaps [
	
	dices := aGroupOfDices.
	board := aBoard.
	turn := 1.
	stateOfGame := GamePlaying new.
	positions:= Dictionary new.
	laps:= Dictionary new.
	
	aGroupOfPlayers do:[:each| positions at: each put: 1].
	aGroupOfPlayers do:[:each| laps at: each put: 0].
	winningLap:= aNumberOfLaps.
]

{ #category : #accessing }
Game >> lapOf: aPlayer [
	(laps includesKey: aPlayer)
		ifTrue: [ ^(laps at: aPlayer) ]
		ifFalse: [ AssertionFailure signal: 'No existe el jugador solicitado' ].
]

{ #category : #accessing }
Game >> placeOf: aPlayer [
	"| orderedPlayers |
	
	orderedPlayers:=Array new: (players size).
	players doWithIndex: [:each :i| orderedPlayers at: i put:  (each ->((self positionOf: each) + (self lapOf: each)*((board tiles) size)))]."
	
	^ (self players asSortedCollection: [:player | self lapOf: player ] descending , [:player | self positionOf: player] descending) detectIndex: [:each| each=aPlayer] ifNone: [ AssertionFailure signal: 'No existe el jugador' ]
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
			self UpdateGameState ]
]

{ #category : #accessing }
Game >> players [
^(positions keysSortedSafely)
]

{ #category : #accessing }
Game >> positionOf: aPlayer [
	(positions includesKey: aPlayer)
		ifTrue: [ ^(positions at: aPlayer) ]
		ifFalse: [ AssertionFailure signal: 'No existe el jugador solicitado' ].
]

{ #category : #accessing }
Game >> recalculateLaps [
self players do:[ :each | 
		( (positions at: each) > (board tiles) size)
		ifTrue: [ 
				laps at: each put: (laps at: each)+1.
				self changePositionOf: each  by: ((board tiles) size)negated .
				
			 ].
		((positions at: each) < 0)
	ifTrue: [ 
				laps at: each put: (laps at: each)-1.
				self changePositionOf: each  by: ((board tiles) size) .
				
			 ].
	
	
	 ]
]

{ #category : #actions }
Game >> turnOf: aPlayer [
	stateOfGame turnOf: aPlayer withGame: self.
]

{ #category : #actions }
Game >> turnOfWhenGameHasEnded:aPlayer [
	AssertionFailure signal: 'El juego ya termino'
]

{ #category : #accessing }
Game >> turnOfWhenGameIsBeingPlayed: aPlayer [
	
	self assertCanPlay: aPlayer.
	self playTurnFor: aPlayer.
	self advanceTurn
]

{ #category : #actions }
Game >> whenGameHasEndedWonBy: aPlayer [
	^((self placeOf: aPlayer )=1)
]

{ #category : #actions }
Game >> whenGameIsBeingPlayedwonBy: aPlayer [
^AssertionFailure signal: 'El juego no terminó todavia'.
]

{ #category : #accessing }
Game >> wonBy: aPlayer [
	^stateOfGame wonBy: aPlayer withGame: self.
]
