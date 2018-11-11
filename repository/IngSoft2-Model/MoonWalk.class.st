Class {
	#name : #MoonWalk,
	#superclass : #Tile,
	#instVars : [
		'backwardValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'initialize-release' }
MoonWalk class >> ofValue: anInteger [
^self new initializeOfValue: anInteger.
]

{ #category : #actions }
MoonWalk >> activateEffectforGame: aGame forPlayer: aPlayer [
	(aGame players copyWithout: aPlayer) do: [ :each | aGame changePositionOf: each by: backwardValue negated ]
]

{ #category : #'initialize-release' }
MoonWalk >> initializeOfValue: aValue [
	backwardValue := aValue
]
