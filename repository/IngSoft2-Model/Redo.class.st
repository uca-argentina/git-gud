Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Redo >> activateCardEffectFor: aTarget in: aGame [
aGame lastCardActivated activateCardEffectFor: aTarget in: aGame.
]
