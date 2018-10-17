Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> withGenerator: aBoardGenerator withTiles: aNumberOfTiles [ 
	^self new initializeWithGenerator: aBoardGenerator WithTiles: aNumberOfTiles 
]

{ #category : #initialization }
Board >> initializeWithGenerator: aBoardGenerator WithTiles: aNumberOfTiles [ 
	
	tiles:=aBoardGenerator generateBoard: aNumberOfTiles.
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
