Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Acceleration >> activateCardEffectFor: aPlayer in: aGame [
	aGame players do: [ :player | aGame addPermanentCard: self to: player ]
]

{ #category : #actions }
Acceleration >> tilesToMove [
	^ 1.
]
