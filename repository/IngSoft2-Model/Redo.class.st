Class {
	#name : #Redo,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Redo >> activateCardEffectFor: aTarget in: aGame [
	
	aGame lastCardActivated activateCardEffectFor: aTarget in: aGame
]
