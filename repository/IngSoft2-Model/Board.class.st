Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> withGenerator: aTileGenerator withTiles: aNumberOfTiles [
	^ self new initializeWithGenerator: aTileGenerator WithTiles: aNumberOfTiles
]

{ #category : #initialization }
Board >> initializeWithGenerator: aTileGenerator WithTiles: aNumberOfTiles [

	tiles := (1 to: aNumberOfTiles) collect: [ :each | aTileGenerator generateTile ].
	
	"aGroupOfTiles :=Array  new: aNumberOfTiles.
	1 to: aNumberOfTiles do:[
		:each | aGroupOfTiles at:  (Tile createTile).
		].
	
	tiles:=aGroupOfTiles ."
]

{ #category : #accessing }
Board >> tiles [
^tiles.
]
