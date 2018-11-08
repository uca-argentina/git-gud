Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testDeterministicBoardIsCreatedWithTiles [
	| board wormHole normalTile |
	wormHole := WormHole new.
	normalTile := NormalTile new.
	board := Board composedOf: (Array with: wormHole with: normalTile with: wormHole with: normalTile).
	self assert: ((board tiles at: 1) isKindOf: WormHole)
]

{ #category : #tests }
BoardTest >> testRandomBoardIsCreated [
	| board |
	board := Board randomlyComposedOf: 20.
	self assert: (board tiles allSatisfy: [ :tile | Tile allSubclasses includes: tile class ])
]
