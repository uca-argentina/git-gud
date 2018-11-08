Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> composedOf: aGroupOfTiles [
	^ self new initializeComposedOfTiles: aGroupOfTiles.
]

{ #category : #'instance creation' }
Board class >> randomlyComposedOf: anAmountOfTiles [
	| generator tiles |
	generator := RandomTileGenerator new.
	tiles := (1 to: anAmountOfTiles) collect: [ :each | generator generateTile ].
	^self composedOf: tiles
]

{ #category : #initialization }
Board >> initializeComposedOfTiles: aGroupOfTiles. [
tiles:=aGroupOfTiles.
]

{ #category : #accessing }
Board >> tiles [
^tiles.
]
