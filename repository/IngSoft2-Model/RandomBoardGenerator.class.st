Class {
	#name : #RandomBoardGenerator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RandomBoardGenerator >> generateBoard: aNumberOfTiles [ 

| aRandomSeries aRandomInt aGroupOfTiles aTileGenerator|
aGroupOfTiles :=Array new: aNumberOfTiles.

aTileGenerator:= TileGenerator new.
aRandomSeries := Random new.
aRandomInt := aRandomSeries nextInt: 100.
aGroupOfTiles:= aGroupOfTiles collect: [ :each | aTileGenerator generateTile: aRandomInt ].


^ aGroupOfTiles.
]
