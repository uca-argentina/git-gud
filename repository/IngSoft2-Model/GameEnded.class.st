Class {
	#name : #GameEnded,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GameEnded >> hasEnded [
^true.
]

{ #category : #actions }
GameEnded >> turnOf: aPlayer withGame: aGame [
aGame turnOfWhenGameHasEnded: aPlayer.
]

{ #category : #actions }
GameEnded >> wonBy: aPlayer withGame: aGame [
	^ aGame whenGameHasEndedWonBy: aPlayer
]
