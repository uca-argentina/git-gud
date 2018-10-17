Class {
	#name : #DeterministicBoardGenerator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
DeterministicBoardGenerator >> generateBoard: aNumberOfTiles [ 

| aGroupOfTiles aTileGenerator|
aGroupOfTiles :=Array new: aNumberOfTiles.
aTileGenerator:= TileGenerator new.
aGroupOfTiles doWithIndex:  [ :each :i | aTileGenerator generateTile: i ].

^ aGroupOfTiles.
]
