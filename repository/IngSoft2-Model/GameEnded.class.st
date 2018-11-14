Class {
	#name : #GameEnded,
	#superclass : #GameState,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
GameEnded >> cardIsPlayed [
	^AssertionFailure signal: 'Cards can not be played after the game has ended'
]

{ #category : #testing }
GameEnded >> hasEnded [
^true.
]

{ #category : #actions }
GameEnded >> turnOf: aPlayer in: aGame [
aGame turnOfWhenGameHasEnded: aPlayer.
]

{ #category : #actions }
GameEnded >> wonBy: aPlayer in: aGame [
	^ aGame whenGameHasEndedWonBy: aPlayer
]
