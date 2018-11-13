Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Redo >> activateCardEffectFor: aTarget in: aGame [
	(Card allSubclasses includes: aTarget class)|(aGame players includes: aTarget)
		ifFalse: [ AssertionFailure signal: 'The target for Redo is not correct for this card' ].
	aGame lastCardActivated activateCardEffectFor: aTarget in: aGame
]
