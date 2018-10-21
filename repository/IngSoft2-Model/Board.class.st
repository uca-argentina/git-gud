Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> madeOf: aGroupOfTiles [
	^ self new initializeMadeOfTiles: aGroupOfTiles.
]

{ #category : #initialization }
Board class >> withGenerator: aTileGenerator withTiles: aNumberOfTiles [
	^ self new initializeWithGenerator: aTileGenerator WithTiles: aNumberOfTiles
]

{ #category : #initialization }
Board >> initializeMadeOfTiles: aGroupOfTiles. [
tiles:=aGroupOfTiles.
]

{ #category : #initialization }
Board >> initializeWithGenerator: aTileGenerator WithTiles: aNumberOfTiles [

	tiles := (1 to: aNumberOfTiles) collect: [ :each | aTileGenerator generateTile ].
	
	
]

{ #category : #accessing }
Board >> tiles [
^tiles.
]
