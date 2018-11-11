Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Acceleration >> activateCardEffectForPlayer: aPlayer in: aGame [
	aGame players do: [ :player | aGame addPermanentCard: self to: player ]
]

{ #category : #'as yet unclassified' }
Acceleration >> outcome [
	^ 1.
]
