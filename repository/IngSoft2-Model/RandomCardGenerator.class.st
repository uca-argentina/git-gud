Class {
	#name : #RandomCardGenerator,
	#superclass : #CardGenerator,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RandomCardGenerator >> generateCard [
	| aRandomSeries aRandomInt |
	aRandomSeries := Random new.
	aRandomInt := aRandomSeries nextInt: 6.
	aRandomInt = 1
		ifTrue: [ ^ Overload new ].
	aRandomInt = 2
		ifTrue: [ ^ Speed new ].
	aRandomInt = 3
		ifTrue: [ ^ Acceleration new ].
	aRandomInt = 4
		ifTrue: [ ^ Cancellation new ].
	aRandomInt = 5
		ifTrue: [ ^ Redo new ].
	aRandomInt = 6
		ifTrue: [ ^ Repeat new ].
]
