Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
PermanentCard >> activateCardEffectFor: aPlayer in: aGame [
	self subclassResponsibility
]

{ #category : #testing }
PermanentCard >> isPlayableBy: aPlayer in: aGame [
	aPlayer = aGame currentPlayer
		ifFalse: [ AssertionFailure signal: 'Permanent Cards can only be played in the player´s turn' ]
]
