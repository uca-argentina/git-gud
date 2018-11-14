Class {
	#name : #InstantCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
InstantCard >> activateCardEffectFor: aPlayer in: aGame [
	self subclassResponsibility
]
