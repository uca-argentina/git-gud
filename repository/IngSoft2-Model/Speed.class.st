Class {
	#name : #Speed,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Speed >> activateCardEffectFor: aPlayer in: aGame [
	aGame addPermanentCard: self to: aPlayer
]

{ #category : #'as yet unclassified' }
Speed >> outcome [
^1
]
