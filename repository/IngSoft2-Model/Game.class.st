Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'players',
		'dices',
		'turn',
		'stateOfGame',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertNumberOfTilesGreaterThanZero: anInteger [
	(anInteger <0)
	ifTrue: [ AssertionFailure signal:'The number of tiles in the board must be greater than zero' ].
]

{ #category : #initialization }
Game class >> playedBy: aPlayerArray throwing: aDiceArray onABoard: aBoard [
	self assertNumberOfTilesGreaterThanZero: (aBoard tiles) size.
	^ self new initializeWithPlayers: aPlayerArray withDices: aDiceArray withBoard: aBoard
]

{ #category : #actions }
Game >> UpdateGameState [
stateOfGame := GameEnded new.
]

{ #category : #'as yet unclassified' }
Game >> activateAtomicBomb [
	players do: [ :each | each moveBackwards: (each position - 1) ]
]

{ #category : #'as yet unclassified' }
Game >> activateMoonWalkWithAmount: backwardValue [
	players do:[:each| each moveBackwards: backwardValue].
	(players at: turn)  moveForward: backwardValue.
]

{ #category : #actions }
Game >> activateSpeedUp [
	(players at: turn) moveForward: 4
]

{ #category : #actions }
Game >> activateWormHole [
(players at: turn) moveBackwards: 4.
]

{ #category : #actions }
Game >> advanceTurn [
	turn := turn + 1 > players size
				ifTrue: [ 1 ]
				ifFalse: [ "Para que si ya tiraron todos vuelva a empezar" turn + 1 ] 
]

{ #category : #asserting }
Game >> assertCanPlay: aPlayer [
	^ (players at: turn) = aPlayer
	ifFalse:[AssertionFailure signal: 'No es el turno del jugador'].
]

{ #category : #testing }
Game >> hasEnded [
	^stateOfGame hasEnded.
]

{ #category : #initialization }
Game >> initializeWithPlayers: aGroupOfPlayers withDices: aGroupOfDices withBoard: aBoard [
	players := aGroupOfPlayers.
	dices := aGroupOfDices.
	board := aBoard.
	turn := 1.
	stateOfGame := GamePlaying new
]

{ #category : #accesing }
Game >> placeOf: aPlayer [
	| orderedPlayers |
	orderedPlayers := players.
	^ (orderedPlayers sort: #position descending) detectIndex: [:each| each=aPlayer] ifNone: [ AssertionFailure signal: 'No existe el jugador' ]
]

{ #category : #accessing }
Game >> playTurnFor: aPlayer [
	dices do: [ :each | aPlayer throws: each ].
	(board tiles at: aPlayer position) activateEffectforGame: self.
	aPlayer position >= board tiles size
		ifTrue: [ aPlayer setPosition: board tiles size.
			self UpdateGameState ]
]

{ #category : #accesing }
Game >> positionOf: aPlayer [
	(players includes: aPlayer)
		ifTrue: [ ^ aPlayer position ]
		ifFalse: [ AssertionFailure signal: 'No existe el jugador solicitado' ].
]

{ #category : #actions }
Game >> turnOf: aPlayer [
	stateOfGame turnOf: aPlayer withGame: self.
]

{ #category : #'as yet unclassified' }
Game >> turnOfWhenGameHasEnded:aPlayer [
	AssertionFailure signal: 'El juego ya termino'
]

{ #category : #accessing }
Game >> turnOfWhenGameIsBeingPlayed: aPlayer [
	
	self assertCanPlay: aPlayer.
	self playTurnFor: aPlayer.
	self advanceTurn
]

{ #category : #'as yet unclassified' }
Game >> whenGameHasEndedWonBy: aPlayer [
	^((self placeOf: aPlayer )=1)
]

{ #category : #'as yet unclassified' }
Game >> whenGameIsBeingPlayedwonBy: aPlayer [
^AssertionFailure signal: 'El juego no terminó todavia'.
]

{ #category : #accesing }
Game >> wonBy: aPlayer [
	^stateOfGame wonBy: aPlayer withGame: self.
]
