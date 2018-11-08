Class {
	#name : #GamePlaying,
	#superclass : #GameState,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GamePlaying >> hasEnded [
^false.
]

{ #category : #actions }
GamePlaying >> turnOf: aPlayer in: aGame [
aGame turnOfWhenGameIsBeingPlayed: aPlayer.
]

{ #category : #actions }
GamePlaying >> wonBy: aPlayer in: aGame [
	^ aGame whenGameIsBeingPlayedwonBy: aPlayer
]
