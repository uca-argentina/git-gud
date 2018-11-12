Class {
	#name : #Overload,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Overload >> activateCardEffectFor: aPlayer in: aGame [
	aGame addPermanentCard: self to: aPlayer
]

{ #category : #'as yet unclassified' }
Overload >> outcome [
	^ (-2)
]
