Class {
	#name : #BoardGenerator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
BoardGenerator >> generateBoard: aNumberOfTiles [
	| aRandomSeries aRandomInt aGroupOfTiles aTileGenerator |
	aTileGenerator := RandomTileGenerator new.
	aRandomSeries := Random new.
	aRandomInt := aRandomSeries nextInt: 100.
	aGroupOfTiles := (1 to: aNumberOfTiles) collect: [ :each | aTileGenerator generateTile: aRandomInt ].
	^ aGroupOfTiles
]
