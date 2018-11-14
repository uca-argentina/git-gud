Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Redo >> activateCardEffectFor: aTarget in: aGame [
	
	aGame lastCardActivated activateCardEffectFor: aTarget in: aGame
]
