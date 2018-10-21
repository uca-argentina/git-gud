Class {
	#name : #DeterministicTileGenerator,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'nextTile'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
DeterministicTileGenerator class >> withBoard: aGroupOfTiles [
	^ self new initializeWithBoard: aGroupOfTiles
]

{ #category : #actions }
DeterministicTileGenerator >> generateTile [
	nextTile := nextTile + 1 > tiles size
		ifTrue: [ 1 ]
		ifFalse: [ "Para que si ya tiraron todos vuelva a empezar" nextTile + 1 ].
		^tiles at: nextTile.
]

{ #category : #initialization }
DeterministicTileGenerator >> initializeWithBoard: aGroupOfTiles [
	tiles := aGroupOfTiles.
	nextTile := 0
]
