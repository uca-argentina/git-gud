Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'position',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Player class >> named: aString [ 
	^self new initializeWithName: aString.
]

{ #category : #initialization }
Player >> initializeWithName: aString [
	name := aString.
	position := 1
]

{ #category : #'as yet unclassified' }
Player >> moveBackwards: anAmount [
	position := position - anAmount.
	
]

{ #category : #'as yet unclassified' }
Player >> moveForward: anAmount [
	position := position + anAmount.
	
]

{ #category : #accessing }
Player >> name [
^name.
]

{ #category : #accessing }
Player >> position [
	^ position
]

{ #category : #updating }
Player >> setPosition: anInteger [ 
	position:= anInteger.
]

{ #category : #actions }
Player >> throws: aDice [
	self moveForward:aDice throw
]
