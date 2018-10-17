Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testRandomBoardIsCreated [
	| board |
	board := Board withGenerator: RandomBoardGenerator new withTiles: 20.
	self assert: (((board tiles at: 2) isKindOf: NormalTile) | ((board tiles at: 2) isKindOf: AtomicBomb )| ((board tiles at: 2) isKindOf: WormHole )| ((board tiles at: 2) isKindOf: SpeedUp )| ((board tiles at: 2) isKindOf: MoonWalk ))
]
