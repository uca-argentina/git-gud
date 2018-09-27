Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Player class >> named: aString [ 
	^self new initializeWithName: aString.
]

{ #category : #initialization }
Player >> initializeWithName: aString [ 
	name:=aString.
	position:=0.
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
	position:= self position+ (aDice throw).
]

{ #category : #actions }
Player >> throws: aDeterministicDice to: anInteger [
	position:= self position+ (aDeterministicDice throw: anInteger).
]
