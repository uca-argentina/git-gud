Class {
	#name : #Overload,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Overload >> activateCardEffectForPlayer: aPlayer in: aGame [
	aGame addPermanentCard: Overload new to: aPlayer
]

{ #category : #'as yet unclassified' }
Overload >> outcome [
	^ (-2)
]
