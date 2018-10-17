Class {
	#name : #RandomDice,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RandomDice >> throw: aDice [
	| aRandomSeries aRandomInt |
	aRandomSeries := Random new.
	aRandomInt := aRandomSeries nextInt: aDice quantityOfSides.
	^ aRandomInt.
]
