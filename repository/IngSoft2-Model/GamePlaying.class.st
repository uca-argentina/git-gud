Class {
	#name : #GamePlaying,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GamePlaying >> hasEnded [
^false.
]

{ #category : #'as yet unclassified' }
GamePlaying >> turnOf: aPlayer withGame: aGame [
aGame turnOfWhenGameIsBeingPlayed: aPlayer.
]

{ #category : #'as yet unclassified' }
GamePlaying >> wonBy: aPlayer withGame: aGame [
	^ aGame whenGameIsBeingPlayedwonBy: aPlayer
]
