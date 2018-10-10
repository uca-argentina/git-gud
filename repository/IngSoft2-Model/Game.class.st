Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'players',
		'dices',
		'turn',
		'numberOfTiles',
		'stateOfGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertNumberOfTilesGreaterThanZero: anInteger [
	(anInteger <0)
	ifTrue: [ AssertionFailure signal:'The number of tiles in the board must be greater than zero' ].
]

{ #category : #initialization }
Game class >> playedBy: aPlayerArray throwing: aDiceArray onABoardWithNumberOfTiles: aBoard [
	self assertNumberOfTilesGreaterThanZero: aBoard. 
	 ^self new initializeWithPlayers: aPlayerArray  withDices: aDiceArray withBoard: aBoard.
]

{ #category : #accesing }
Game >> hasEnded [
	players
		do: [ :each | 
			each position >= numberOfTiles
				ifTrue: [ 
					stateOfGame :=GameEnded new.
					^ true.
					] ].
	^ false
]

{ #category : #initialization }
Game >> initializeWithPlayers: aPlayersArray withDices: aDiceArray withBoard: aBoard [ 
	players:=aPlayersArray.
	dices:=aDiceArray.
	numberOfTiles:=aBoard.
	turn:=1.
	stateOfGame:=GamePlaying new.
	
]

{ #category : #accesing }
Game >> placeOf: aPlayer [ 
	^(stateOfGame placeOf: aPlayer withGame: self).
]

{ #category : #accesing }
Game >> placeOfWhenGameHasEnded:aPlayer [
	players sort: [:player1 :player2 | player1 position >=player2 position].
		players doWithIndex: [ :each :i|
			(each = aPlayer)
			ifTrue: [ ^i. ]
			
			 ].
		AssertionFailure signal: 'No existe el jugador'.
]

{ #category : #accesing }
Game >> placeOfWhenGameIsBeingPlayed: aPlayer [
AssertionFailure signal: 'No se puede dar la posición final en la mitad del juego'


]

{ #category : #accesing }
Game >> positionOf: aPlayer [
	players
		do: [ :each | 
			aPlayer = each
				ifTrue: [ ^ each position ] ].
	AssertionFailure signal: 'No existe el jugador solicitado'
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
	| numberOfPlayers |
	(players at: turn) = aPlayer
		ifTrue: [ "Si le toca a ese jugador"
			dices
				do:
					[ :each | (players at: turn) throws: each	"El jugador del turno tira cada dado" ].
			self hasEnded
				ifTrue: [ (players at: turn) setPosition: numberOfTiles ].	"Si se paso del maximo su posción final es la última del tablero"
			numberOfPlayers := players size.	"Tamaño del arreglo de jugadores"
			turn := turn + 1 > numberOfPlayers
				ifTrue: [ 1 ]
				ifFalse: [ turn + 1 ]	"Para que si ya tiraron todos vuelva a empezar" ]
		ifFalse: [ "Revisa que el jugador que mandan es al que le toca" AssertionFailure signal: 'No es el turno de ese jugador' ]
]

{ #category : #accesing }
Game >> wonBy: aPlayer [ 
	players do:[:each | 
		(aPlayer=each)
		ifTrue: [
		
			(each position=numberOfTiles )
			ifTrue: [ ^true ]
			ifFalse: [ ^false ]
			]
		
			].
	
	AssertionFailure signal:'No existe el jugador solicitado'.
]
