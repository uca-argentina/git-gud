Class {
	#name : #GamePlaying,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GamePlaying >> hasEnded [
^false.
]

{ #category : #actions }
GamePlaying >> turnOf: aPlayer withGame: aGame [
aGame turnOfWhenGameIsBeingPlayed: aPlayer.
]

{ #category : #actions }
GamePlaying >> wonBy: aPlayer withGame: aGame [
	^ aGame whenGameIsBeingPlayedwonBy: aPlayer
]
