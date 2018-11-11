Class {
	#name : #Speed,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Speed >> activateCardEffectForPlayer: aPlayer in: aGame [
	aGame addPermanentCard: Speed new to: aPlayer
]

{ #category : #'as yet unclassified' }
Speed >> outcome [
^1
]
