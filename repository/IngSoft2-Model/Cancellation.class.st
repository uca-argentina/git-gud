Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Cancellation >> activateCardEffectFor: aCard in: aGame [
	(aGame activePermanentCards values detect: [ :cardsOfPlayer|cardsOfPlayer includes: aCard] ifNone: [AssertionFailure signal: 'Cancellation requires an active permanent card to cancel' ]).
	aGame players do: [ :player | aGame removePermanentCard: aCard from: player ]
]
