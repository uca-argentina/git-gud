Class {
	#name : #GameEnded,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
GameEnded >> placeOf: aPlayer withGame: aGame [
^aGame placeOfWhenGameHasEnded: aPlayer.
]

{ #category : #'as yet unclassified' }
GameEnded >> turnOf: aPlayer withGame: aGame [
aGame turnOfWhenGameHasEnded: aPlayer.
]
