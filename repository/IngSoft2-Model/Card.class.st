Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card >> activateCardEffectFor: aPlayer in: aGame [
self subclassResponsibility 
]
