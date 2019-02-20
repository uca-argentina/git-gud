Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Card >> activateCardEffectFor: aPlayer in: aGame [
self subclassResponsibility 
]
