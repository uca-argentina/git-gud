Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Cancellation >> activateCardEffectFor: aCard in: aGame [
	aGame players do: [ :player | aGame removePermanentCard: aCard from: player ]
]
