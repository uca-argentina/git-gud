Class {
	#name : #RandomDice,
	#superclass : #Dice,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RandomDice class >> ofSides: aNumberOfSides [
	self assertValidNumberOfSides: aNumberOfSides.
	^ self new initializeOfSides: aNumberOfSides
]

{ #category : #initialization }
RandomDice >> initializeOfSides: aNumberOfSides [
	quantityOfSides := aNumberOfSides
]

{ #category : #actions }
RandomDice >> throw [
	| aRandomSeries aRandomInt |
	aRandomSeries := Random new.
	aRandomInt := aRandomSeries nextInt: quantityOfSides.
	^ aRandomInt
]
