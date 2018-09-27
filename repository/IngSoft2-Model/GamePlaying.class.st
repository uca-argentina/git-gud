Class {
	#name : #GamePlaying,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
GamePlaying >> placeOf: aPlayer withGame: aGame [
^aGame placeOfWhenGameIsBeingPlayed: aPlayer.
]

{ #category : #'as yet unclassified' }
GamePlaying >> turnOf: aPlayer withGame: aGame [
aGame turnOfWhenGameIsBeingPlayed: aPlayer.
]
