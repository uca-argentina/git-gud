Class {
	#name : #Overload,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Overload >> activateCardEffectFor: aPlayer in: aGame [
	aGame addPermanentCard: self to: aPlayer
]

{ #category : #actions }
Overload >> tilesToMove [
	^ (-2)
]
