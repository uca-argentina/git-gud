Class {
	#name : #GameEnded,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GameEnded >> hasEnded [
^true.
]

{ #category : #'as yet unclassified' }
GameEnded >> turnOf: aPlayer withGame: aGame [
aGame turnOfWhenGameHasEnded: aPlayer.
]

{ #category : #'as yet unclassified' }
GameEnded >> wonBy: aPlayer withGame: aGame [
	^ aGame whenGameHasEndedWonBy: aPlayer
]
