Class {
	#name : #MoonWalk,
	#superclass : #Object,
	#instVars : [
		'backwardValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'initialize-release' }
MoonWalk class >> withValue: anInteger [
^self new initializeWithValue: anInteger.
]

{ #category : #'as yet unclassified' }
MoonWalk >> activateEffectforGame: aGame [
	aGame activateMoonWalkWithAmount: backwardValue .
]

{ #category : #'initialize-release' }
MoonWalk >> initializeWithValue: anInteger [
backwardValue:= anInteger.
]
