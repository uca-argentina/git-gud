Class {
	#name : #GameEnded,
	#superclass : #GameState,
	#category : #'IngSoft2-Model'
}

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
